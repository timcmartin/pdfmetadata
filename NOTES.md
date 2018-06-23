
# Ratings:

5: 7-8
4: 5-6
3: 3-4
2: 1-2
1: Veto
0: ?

# YAML
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

```yaml
:score:
  -
    :filename: "Ain't No Sunshine.pdf"
    :title: "Ain't No Sunshine"
    :composer: Bill Withers
    :keywords: Acoustic, keysf:0, keymi:1, rating:0
    :genre: Classic Soul
    :format: Sibelius
```
