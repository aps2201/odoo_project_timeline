# Odoo + Project Timeline

This is the source for the [container image of the same name](https://quay.io/repository/aps2201/odoo_project_timeline). The idea is to provide a working timeline view by default for the Odoo project module. The Gantt chart is an enterprise feature which does not ship with the community edition. The [OCA](https://github.com/OCA) has created a drop in for this.

Source:
- https://github.com/OCA/web/tree/17.0/web_timeline (project_timeline depency)
- https://github.com/OCA/project/tree/17.0/project_timeline

## Podman + Quadlet

Ideally you run this using quadlet as is, I have provided a handy `./qdeploy` script to automate the process. This is tested on Podman 5.3.2 which works perfectly. 

You may need to restart the odoo service if the database starts late using `systemctl --user restart odoo`

If you want to build the main Odoo container yourself, there are two build flavors: proxy and no proxy. The proxy build uses the  --proxy-mode enables the use of X-Forwarded-* headers through Werkzeug’s proxy support. It ignores all X-Forwarded-* headers in case X-Forwarded-Host is missing from the request.

- no proxy build:  `podman build -f odoo_project_timeline.Containerfile . -t odoo_project_timeline` 
- proxy build: `podman build -f odoo_project_timeline_proxy.Containerfile . -t odoo_project_timeline:proxy`

## odoo.conf_ and quadlet/odoo_pg.container Files

If you want to change the password, you will have to make your own build. Make sure the `db_password` and `POSTGRES_PASSWORD` on these two are exactly the same. The underscore (\_) in __odoo.conf___ is intended, the __.gitignore__ blocks the default __odoo.conf__. The Containerfile will handle this by executing `COPY odoo.conf_ /etc/odoo/conf/odoo.conf`