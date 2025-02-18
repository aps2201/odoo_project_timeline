FROM docker.io/almalinux/9-base
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN /usr/bin/crb --enable

RUN dnf install -y https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox-0.12.6.1-2.almalinux9.x86_64.rpm
RUN dnf install -y gcc python3.12-devel python3.12-pip openldap-devel

COPY . /apps/odoo/
COPY odoo.conf_ /etc/odoo/conf/odoo.conf
RUN cd /apps/odoo/ && pip-3.12 install -r req
CMD  python3.12 /apps/odoo/odoo-bin -D /usr/share/odoo -d odoo --config /etc/odoo/conf/odoo.conf --init base,project,project_timeline,web_timeline --without-demo all