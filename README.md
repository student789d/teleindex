# Telegram Index Fork

A simple Python webapp which indexes any configured Telegram chat (including channels) and serves its files for download.

This fork makes the app work on updated Linux systems with updated Python and libraries (specifically, this has been tested on Debian Bookworm with the distro's `python3` package), and implements a few quality-of-life bugfixes and new features.

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)](.) [![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

A working production demo is available at <https://hlb0.octt.eu.org/Drive/Telegram/>.

## Features, Present and Planned

[x] Index one or more telegram channels/chats
[x] View text messages and media files on the browser
[x] Search through the chat's messages
[x] Download any files through browsers or download managers, with direct HTTP links
[ ] Fix text message and caption formatting (from Markdown to HTML)
[ ] Atom/RSS feeds
[ ] Implement a secondary chat-like view (like t.me/s)

## Deploying

- **Clone to local machine**

```sh
git clone https://github.com/octospacc/TelegramIndex-Fork
cd TelegramIndex-Fork
```

- **Install dependencies**

```sh
sudo -H pip3 install -r requirements.txt
```

- **Environment Variables**

The app is configured via environment variables that must be set in your shell before starting the program.

| Variable Name                        | Value                                                                                                                 |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| `API_ID` (required)                  | Telegram api_id obtained from <https://my.telegram.org/apps>.                                                         |
| `API_HASH` (required)                | Telegram api_hash obtained from <https://my.telegram.org/apps>.                                                       |
| `INDEX_SETTINGS` (required)          | See the below description.                                                                                            |
| `PORT` (optional)                    | Port on which app should listen to, defaults to 8080.                                                                 |
| `HOST` (optional)                    | Host name on which app should listen to, defaults to 0.0.0.0.                                                         |
| `DEBUG` (optional)                   | Give `true` to set logging level to debug, info by default.                                                           |
| `BLOCK_DOWNLOADS` (optional)         | Enable downloads or not. If any value is provided, downloads will be disabled.                                        |
| `RESULTS_PER_PAGE` (optional)        | Number of results to be returned per page defaults to 20.                                                             |
| `TGINDEX_USERNAME` (optional)        | Username for authentication, defaults to `''`.                                                                        |
| `PASSWORD` (optional)                | Password for authentication, defaults to `''`.                                                                        |
| `SHORT_URL_LEN` (optional)           | Url length for aliases                                                                                                |
| `SESSION_COOKIE_LIFETIME` (optional) | Number of minutes, for which authenticated session is valid for, after which user has to login again. defaults to 60. |
| `SECRET_KEY` (optional)              | 32 characters long string for signing the session cookies, required if authentication is enabled.                     |

- **Setting value for `INDEX_SETTINGS`**

This is the general format, change the values of corresponding fields as your requirements. You can copy paste this as is to index all the channels available in your account.

**Remember to remove newlines.**

```json
{
  "index_all": true,
  "index_private": false,
  "index_group": false,
  "index_channel": true,
  "exclude_chats": [],
  "include_chats": []
}
```

> - `index_all` - Whether to consider all the chats associated with the telegram account. Value should either be `true` or `false`.
> - `index_private` - Whether to index private chats. Only considered if `index_all` is set to `true`. Value should either be `true` or `false`.
> - `index_group` - Whether to index group chats. Only considered if `index_all` is set to `true`. Value should either be `true` or `false`.
> - `index_channel` - Whether to index channels. Only considered if `index_all` is set to `true`. Value should either be `true` or `false`.
> - `exclude_chats` - An array/list of chat id's that should be ignored for indexing. Only considered if `index_all` is set to `true`.
> - `include_chats` - An array/list of chat id's to index. Only considered if `index_all` is set to `false`.

- **Run app**

```bash
set -a; source .env # (or whatever other way you use to load the environment variables)
python3 -m app
```

or, run the included wrapper script for a better experience:

```bash
bash ./StartTelegramIndex.sh
```

Note: you will be asked to **log in** the first time. (Login with the telegram account which is a participant of the chats you want to index).
After that, a `tg-index.session` file will be stored in the current working directory. **Keep it secret and secure**.

## Deploy Guide (Repl.it)

A (unmantained!) detailed and beginner friendly guide on how to deploy this project on a free instance of <https://repl.it> can be found [here](./repl-config/replit-deploy-guide.md).

## License, Credits

This program is forked from [odysseusmax/tg-index](https://github.com/odysseusmax/tg-index).

As per the original, code is released under [The GNU General Public License Version 3](LICENSE).
