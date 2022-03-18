# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2022-03-18

### Removed

- Helm's version is relaxed (no more need for +3.7)

## [0.3.0] - 2022-02-15

### Added

- It is now possible to control the passwords for Tuleap Site Administrator and Tuleap DB account.

## [0.2.0] - 2022-01-27

### Added

- Config file for nginx to allow tls-termination at the Ingress controller level,
  offering a ready-to-use Tuleap deployment.

- An initContainer to wait for database, in order to avoid starting Tuleap without database.

## [0.1.0] - 2022-01-14

Initial release.
