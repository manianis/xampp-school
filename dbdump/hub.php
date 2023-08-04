<?php
include_once 'dbase.php';

$op = "";
$method = $_SERVER['REQUEST_METHOD'];
$data = ["ok" => true, "method" => $method, "message" => "", "data" => []];

if ($method == "GET") {
    if (isset($_GET["op"])) $op = $_GET["op"];
} else if ($method == "POST") {
    if (isset($_POST["op"])) $op = $_POST["op"];
}

// Nothing to do
if ($op == "") {
    $data["ok"] = false;
    $data["error"] = "Specify an operation please.";
    echo json_encode($data);
    die();
}

// connect
if ($op == "connect") {
    if (!isset($_POST["host"]) || !isset($_POST["user"]) || !isset($_POST["password"])) {
        $data["ok"] = false;
        $data["error"] = "Incorrect parameters number.";
        die(json_encode($data));
    }
    try {
        $conn = new PDO('mysql:host=' . $_POST["host"], $_POST["user"], $_POST["password"]);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $data["message"] = "Connected to `" . $_POST["host"] . "`.";
        $data["message"] .= '\nConnection success.';
        $data["data"] = show_databases($conn);
    } catch (PDOException $e) {
        $data["ok"] = false;
        $data["error"] = "Connection failed with error." . $e->getMessage();
    }
    die(json_encode($data));
}

// export-db
if ($op == "export-db") {
    if (!isset($_POST["host"]) || !isset($_POST["user"]) || !isset($_POST["password"]) || !isset($_POST["dbname"])) {
        $data["ok"] = false;
        $data["error"] = "Incorrect parameters number.";
        die(json_encode($data));
    }
    try {
        $curr_dir = dirname(__FILE__);
        $sql_dir = $curr_dir . "/sqlfiles";

        include_once($curr_dir . '/mysqldump.php');
        $dump = new Ifsnop\Mysqldump\Mysqldump(
            'mysql:host=' . $_POST["host"] . ';dbname=' . $_POST["dbname"],
            $_POST["user"],
            $_POST["password"],
            ['databases' => true, 'add-drop-database' => true]
        );

        $tempfname = tempnam($sql_dir, 'sql');
        $filename = basename($tempfname);
        $dump->start($tempfname);
        $data["data"] = "sqlfiles/" . $filename;
    } catch (PDOException $e) {
        $data["ok"] = false;
        $data["error"] = "Connection failed with error." . $e->getMessage();
    }
    die(json_encode($data));
}

