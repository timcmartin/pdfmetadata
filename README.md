Pdfchart
================

A utility to add Metadata to PDF files, primarily for importing into the forScore iOS app.
Title, Composer, Genres, Tags, Rating, Difficulty, Duration and Key can be set in the PDF Metadata so that is unified for everyone who imports that PDF into forScore.

My personal workflow is to create lead sheets in Sibelius, export the PDF then run it through this utility to add the missing data before importing to forScore.

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.0
- Rails 5.1.6

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Notes
-----

* Create a `.env` file in the root directory with the following values:
  * `INPUT` - the base folder you are working with
  * `BACKUP` - a path for backup.  A copy of the original pdf will be stored here. (ie `BACKUP='backup'` will create a backup of the file in the `public/backup' directory of this repo.
  * `OUTPUT` - a path for processed files.  These are copied back into the `INPUT` directory upon successful editing.

* Example:

```
INPUT='/Users/tmartin/Dropbox/Music/CLB Shared/charts/'
BACKUP='backup'
OUTPUT='processed'
```

YAML
----

* Use quotes if any text has special characters or single quotes in it, otherwise it is not necessary

| PDF Value | forScore Value | Format                                             |
| --------- | -------------- | ------                                             |
| Title     | Title          | Single Value                                       |
| Author    | Composer       | One or more comma separated values                 |
| Subject   | Genres         | One or more comma separated values                 |
| Keywords  | Tags           | One or more comma separated values, plus next list |

| Keyword      | forScore Value     | Format                 |
| -------      | --------------     | ------                 |
| rating:N     | Rating             | Whole number 0..5      |
| difficulty:N | Rating             | Whole number 0..3      |
| duration:N   | Rating             | Whole number (seconds) |
| keysf:N      | Key (sharps/flats) | Whole number -7..7     |
| keymi:N      | Key (major/minor)  | 0:major, 1:minor       |

* Example:

```yaml
---
- :filename: Ain't No Sunshine.pdf
  :title: Ain't No Sunshine
  :composer: Bill Withers
  :keywords: Acoustic, keysf:0, keymi:1, rating:0
  :genre: Classic Soul
  :format: Sibelius
- :filename: "Aint Too Proud To Beg.pdf"
  :title: "Ain't Too Proud To Beg"
  :composer: The Temptations, The Rolling Stones
  :keywords: "Spare, keysf:2, keymi:0, rating:3"
  :genre: Classic Soul, Classic Rock
  :format: Sibelius
- :filename: "Alive.pdf"
  :title: Alive
  :composer: Pearl Jam
  :keywords: "Spare, keysf:0, keymi:0, rating:3"
  :genre: Modern Rock
  :format: Sibelius
- :filename: "Whipping Post.pdf"
  :title: Whipping Post
  :composer: Allman Brothers Band
  :keywords: "Current, keysf:0, keymi:1, rating:5"
  :genre: Classic Rock
  :format: Sibelius
```

Ratings
-------

* 5: 7-8
* 4: 5-6
* 3: 3-4
* 2: 1-2
* 1: Veto
* 0: ?
