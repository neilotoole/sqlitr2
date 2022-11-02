# neilotoole/sqlitr2
`sqlitr2` is a trivial query tool for SQLite written in Go. It was created as a
example project for [neilotoole/xcgo](https://github.com/neilotoole/xcgo),
which is a Go/Golang cross-compiling docker builder image. `sqlitr2` invokes
the SQLite C library via CGo: building and distributing binaries for
multiple platforms with CGo is a challenge. The `neilotoole/xcgo`
image makes life easier for the common cases.

## Usage

From `sqlitr2 --help`:

```
sqlitr2 is a trivial query tool for SQLite.

Usage: sqlitr2 [FLAGS] path/to/db.sqlite query [QUERY_ARGS]

Examples:
  sqlitr2 --help
  sqlitr2 --version

  # simple select, will print header row
  sqlitr2 ./testdata/example.sqlite 'SELECT * FROM actor'

  # same as above, but don't print header row
  sqlitr2 --no-header ./testdata/example.sqlite 'SELECT * FROM actor'

  # same query, but the SQLite db is first downloaded from
  # the URL to a temp file, then the query is executed.
  sqlitr2 https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'

  # execute a SQL stmt (note the --exec flag, as opposed to default query behavior)
  sqlitr2 --exec ./testdata/example.sqlite "INSERT INTO actor (actor_id, first_name, last_name) VALUES(11, 'Kubla', 'Khan')"

  # execute a SQL stmt, but supply query args via the command line
  sqlitr2 --exec ./testdata/example.sqlite 'DELETE FROM actor WHERE actor_id = ?' 3

  # create a new DB file
  sqlitr2 --create path/to/db.sqlite


Note that if the SQL is a SELECT or similar query, output is
in TSV (tab-separated) format. To execute a non-query SQL statement
such as INSERT, supply the --exec flag: in that case the count of
rows affected (and the last insert ID if applicable) are printed.

sqlitr2 exists as a demonstration project for neilotoole/xcgo which
is a Go/CGo cross-compiling docker builder image. sqlitr2 makes use of
the https://github.com/mattn/sqlite3 package which uses CGo to
incorporate SQLite.

sqlitr2 was created by Neil O'Toole <neilotoole@apache.org> and is
released under the MIT License. See https://github.com/neilotoole/sqlitr2
```

Usage example, with a remote DB file:

```shell script
$ sqlitr2 https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'
actor_id	first_name	last_name
1	PENELOPE	GUINESS
2	NICK	WAHLBERG
3	ED	CHASE
4	JENNIFER	DAVIS
5	JOHNNY	LOLLOBRIGIDA
6	BETTE	NICHOLSON
7	GRACE	MOSTEL
8	MATTHEW	JOHANSSON
9	JOE	SWANK
10	CHRISTIAN	GABLE
```


## Installation
This section is the raison d'être of `sqlitr2`. After any of these
methods, run `sqlitr2 --version` to verify your install.

### go get
The usual Go method will work (although without `--version` info): 

```shell script
go get -u github.com/neilotoole/sqlitr2
```

### go install
Or, if you want to install from source (again without `--version` info):

```shell script
$ git clone https://github.com/neilotoole/sqlitr2.git && cd sqlitr2
$ go install
```

### brew
Install on macOS or Linux via [brew](https://brew.sh/) ([formula](https://github.com/neilotoole/homebrew-sqlitr2/blob/master/sqlitr2.rb))

```shell script
$ brew tap neilotoole/sqlitr2
$ brew install sqlitr2
```

### scoop
Install on Windows via [scoop](https://scoop.sh/) ([manifest](https://github.com/neilotoole/sqlitr2/blob/master/sqlitr2.json))

```shell script
$ scoop bucket add sqlitr2 https://github.com/neilotoole/sqlitr2
$ scoop install sqlitr2
```

### snap
Install on Linux via [snap](https://snapcraft.io/docs/getting-started).

```shell script
$ snap install sqlitr2 
```

### deb

The `deb` package is not currently published to a repository, so we'll need to directly reference the packages as published in [releases](https://github.com/neilotoole/sqlitr2/releases).

Download the `.deb` file (replace `v0.1.21` below with the appropriate version) and then install.

```shell script
$ curl -fsSLO https://github.com/neilotoole/sqlitr2/releases/download/v0.1.21/sqlitr2_0.1.21_linux_amd64.deb
$ sudo apt install -y ./sqlitr2_0.1.21_linux_amd64.deb
$ rm ./sqlitr2_0.1.21_linux_amd64.deb
```

### rpm

As per `deb`, the `rpm` is not published to a repository, so directly reference the package as published in [releases](https://github.com/neilotoole/sqlitr2/releases).


Via `yum`:

```shell script
$ yum localinstall -y https://github.com/neilotoole/sqlitr2/releases/download/v0.1.21/sqlitr2_0.1.21_linux_amd64.rpm
```

Via `rpm`:

```shell script
$ sudo rpm -i https://github.com/neilotoole/sqlitr2/releases/download/v0.1.21/sqlitr2_0.1.21_linux_amd64.rpm
```

### tarball
Download the appropriate `.tar.gz` or `.zip` file from GitHub [releases](https://github.com/neilotoole/sqlitr2/releases), and extract the binary from the archive.

### docker
You can also run `sqlitr2` directly from the published [docker image](https://hub.docker.com/repository/docker/neilotoole/sqlitr2):

```shell script
$ docker run neilotoole/sqlitr2:latest /example.sqlite 'SELECT * FROM actor'
```
^ Note that `/example.sqlite` is included in the image. You could also use a URL:

```shell script
$ docker run neilotoole/sqlitr2:latest https://github.com/neilotoole/sqlitr2/raw/master/testdata/example.sqlite 'SELECT * FROM actor'
```




## Acknowledgements
- `sqlitr2` was created to demonstrate [neilotoole/xcgo](https://github.com/neilotoole/xcgo): see that [README](https://github.com/neilotoole/xcgo/blob/master/README.md) for upstream acknowledgements.
- `testdata/example.sqlite` database is a tiny
stripped-down version of the [Sakila](https://dev.mysql.com/doc/sakila/en/) database.
- `sqlitr2` employs [mattn/go-sqlite3](https://github.com/mattn/go-sqlite3) to demonstrate CGo usage.
- And of course, [SQLite](https://www.sqlite.org/) itself.
