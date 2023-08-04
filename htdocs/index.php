<!DOCTYPE html>
<html>

<head>
  <title>Bienvenue sur <?= gethostname() ?></title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
  <style>
    body {
      margin: 0px;
    }

    main {
      min-height: calc(100vh - 165px);
    }

    .website,
    .phpmyadmin,
    .mysql,
    .php,
    .apache {
      display: inline-block;
      background: transparent url(assets/images/website.png) no-repeat left center;
      line-height: 32px;
      text-indent: 36px;
    }
  </style>
</head>

<body>
  <?php if (!isset($_GET['op'])) : ?>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark ">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">XAMPP</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link" aria-current="page" href="index.php?op=infos" target="_blank" rel="noopener noreferrer">PHP Info</a>
            </li>

            <li class="nav-item">
              <a class="nav-link" aria-current="page" href="/phpmyadmin/" target="_blank" rel="noopener noreferrer">MySQL</a>
            </li>
          </ul>
          <div class="d-flex text-white">Apache @<?= $_SERVER["HTTP_HOST"] ?></div>
        </div>
      </div>
    </nav>
  <?php endif; ?>

  <main class="container my-4">
    <?php
    if (!isset($_GET["op"])) :
    ?>
      <h1 class="text-center">Bienvenue sur <?= gethostname() ?></h1>

      <?php
      //phpinfo();
      //print_r($_ENV);
      $dont_show = [".", "..", "assets"];
      // $dont_show = [".", ".."];

      function folders_list($folder)
      {
        global $dont_show;
        $folders = array();

        $handle = opendir($folder);
        while (false !== ($entry = readdir($handle))) {
          if (!in_array($entry, $dont_show)) {
            if (is_dir($folder . DIRECTORY_SEPARATOR . $entry)) {
              $folders[] = $entry;
            }
          }
        }
        closedir($handle);

        return $folders;
      }

      $folders = folders_list(".");
      $i = 0;

      if (count($folders) > 0) {
        foreach ($folders as $folder) {
          echo "<div class=\"row my-1 align-items-center\">";
          echo "<div class=\"col-8\"><a class=\"website\" href=\"/$folder/\" target=\"_blank\" rel=\"noopener noreferrer\">$folder</a></div>";
          echo "<div class=\"col-4 text-center\">" . date("d/m/Y H:i:s", fileatime($folder)) . "</div>";
          echo "</div>";
          $i++;
        }
      } else {
        echo "Le dossier est actuellement vide.";
      }
      ?>
    <?php
    else :
    ?>
      <?php phpinfo(); ?>
    <?php
    endif;
    ?>
  </main>
  <footer class="d-print-none bg-dark text-white p-2">
    <div class="text-center">Page créée par Mohamed Anis MANI avec ♥</div>
    <div class="text-center small">Année scolaire : 2022/2023</div>
  </footer>
  <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>