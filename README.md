#  ERPNext on Docker

**The goal of this repo is stability.**

##### Problem

* ERPNext development tend to go very fast, new update comes every days 
and some will be bugs.

* ERPNext use many dependencies, during installation sometimes somethings might went wrong.

##### Solution

Using docker we can pre-build images and push it to [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/),
so you will always have usable images and can choose which version you want to use.

## Image tag

Currently there're 3 important branch on frappe.
So now on latest tag we'll have 8 tags.

All image will come with 2 variance with or without MySql.

* **Master (mas) - v10 [python2]**
  * mas-py2-latest
  * mas-py2-w.sql-latest
* **Staging (sta) - v11 [python2, python3]**
  * sta-py2-latest
  * sta-py3-latest
  * sta-py2-w.sql-latest
  * sta-py3-w.sql-latest
* **Develop (dev) - v12 [python3]**
  * dev-py3-latest
  * dev-py3-w.sql-latest

After latest tag is create image will be test and tag version to it. (Testing process is now very very simple, it only run image and get response code if it return 200 it'll pass.)

ie. `11.0.3-beta.39-py2` or `11.0.3-beta.39-py2-w.sql`

Image tag is host and list at [Docker hub](https://hub.docker.com/r/pipech/erpnext-docker-debian/)

Image will be automatically create Every Monday at Mid-night UTC.

## Usage

Read at [https://pipech.github.io/erpnext-docker-debian](https://pipech.github.io/erpnext-docker-debian)

## Contributing

Pull requests for new features, bug fixes, and suggestions are welcome!

## License

MIT
