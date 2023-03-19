# Changelog

## 0.1.3 - 2023/03/19

* Improve update handling and garbage collection.
* Improve start-up Operating System and bundled-files dependency checks.
* Introduce dialog boxes for `list`, and add `search` to display IDs and description data as searchable text.
* Improve error message handling.
* Improve help screens.
* Improve and update documentation.
* Fix bug when making timelapse videos that occurred when running into stay _.listing_ files.

---

## 0.1.2 - 2023/03/14

* Improve debug logging.
* Introduce large randomised wait of up to 60 seconds before bulk satellite image fetching even commences when running as a cronjob, to distribute server load at remote end, and avoid dramatic i/o inrush at local end.
* Add small random wait between each satellite image file during bulk fetching, to distribute server load in automated instances at remote end generally.
* Make positional parameters consistent throughout the codebase; improve code readability and comments.
* Add a spinner that displays while waiting for fetching satellite/radar lists to complete.
* Add a stopwatch to record and pretty-display total time taken to fetch, or build a timelapse.
* Add documentation.
* Fix bug where radar layers were not moved to .archive when radar timelapse was successfully completed.
* Hide cursor during flattening images.
* Update radar description data.

---

## 0.1.1 - 2023/03/01

* Overhaul the method for logging bugs.
* Code clean-up, minor refactoring, and improve garbage collection.
* File-system permission bits clean-up throughout.

---

## 0.1.0 - 2023/02/26

* Introduce path locking when fetching.
* Add `update` option.
* Add `reset` option.
* Replace `ncftp` with `wget` throughout.
* Add timestamping to Himawari frames.
* Add timestamp globbing capability to fetching.
* Bugfix `convert` image canvas-size crash. Thanks @matt_brown.
* Add code debug logging and turn it on by default.

---

## 0.0.1a - 2022/11/05

* Development started.

---

## 0.0.0a - 2022/10/13

* Proof of concept, as `radars.sh`.