const system_db = ['information_schema', 'mysql', 'performance_schema', 'phpmyadmin', 'test'];

const app = new Vue({
  el: "#app",
  data: {
    connection: {
      host: "127.0.0.1",
      user: "root",
      password: ""
    },
    databases: [],
    op: 'connect',
    selectedDB: '',
    sqlFilePath: ''
  },
  mounted: function () {
    this.connect();
  },
  methods: {
    sendPostQuery: function (obj) {
      return fetch("hub.php", {
        method: 'post',
        headers: {
          'Accept': 'application/json'
        },
        body: this.toFormData(obj)
      })
        .then(response => response.json());
    },
    toFormData: function (obj) {
      const data = new FormData();
      for (let key of Object.keys(obj)) {
        data.append(key, obj[key]);
      }
      return data;
    },
    connect: function () {
      this.op = "connect";
      const data = { ...this.connection };
      data["op"] = "connect";
      this.sendPostQuery(data)
        .then(data => {
          if (data.ok) {
            this.op = "dblist";
            this.databases = data.data.map(item => item.Database).filter(dbname => !system_db.includes(dbname));
          }
        });
    },
    exportDatabase: function () {
      const data = { 
        ...this.connection,
        op: 'export-db',
        dbname: this.selectedDB
      };
      this.sendPostQuery(data)
        .then(data => {
          if (data.ok) {
            this.op = "download";
            this.sqlFilePath = data.data;
            this.$nextTick(() => {
              const link = document.getElementById("download-link");
              if (link) {
                link.click();
              }
            });
          }
        });
    },
    exportAnotherDatabase: function() {
      this.op = 'dblist';
      this.selectedDB = '';
    }
  }
});