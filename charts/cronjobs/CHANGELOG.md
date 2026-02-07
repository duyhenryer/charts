# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2026-02-07

### Added
- Initial release of the generic CronJobs Helm chart.
- Support for multiple CronJob definitions in `values.yaml`.
- Support for automatic `kubernetes.io/dockerconfigjson` Secret creation from `imagePullSecrets`.
- Support for `ServiceAccount`, `SecurityContext`, `Resources`, `VolumeMounts`, `Affinity`, `Tolerations`.
