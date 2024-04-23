<div align="center">
  <!-- <img height="100" src="docs/img/title-logo-mark-cmake.png"> -->
  <picture>
    <img width="100" height="100" src="docs/img/logo-gdal.svg">
  </picture>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/img/logo-crowdin-white.svg">
    <source media="(prefers-color-scheme: light)" srcset="docs/img/logo-crowdin-dark.svg">
    <img width="100" height="100" src="docs/img/logo-crowdin-dark.svg">
  </picture>
</div>

<h1 id="localization-of-cmake-documentation">
Localization of GDAL Documentation
</h1>

<details><summary><strong>Switch Languages</strong></summary>
<p></p>
<ul>
  <li><a href="./README.md"><code>en</code> : English</a></li>
  <li><a href="./README.zh_TW.md"><code>zh_TW</code> : 繁體中文</a></li>
</ul>
</details>

<h2 id="table-of-contents">
Table of Contents
</h2>

- <a href="#introduction">Introduction</a>
- <a href="#progress-of-translations">Progress of Translations</a>
- <a href="#preview-translations">Preview Translations</a>
  - <a href="#preview-in-local-build">Preview in Local Build</a>
  - <a href="#preview-in-gh-pages">Preview in GitHub Pages</a>
- <a href="#licenses">Licenses</a>
- <a href="#translation-disclaimer">Translation Disclaimer</a>
- <a href="#about-author">Maintainers List</a>
- <a href="#support-this-project">Support This Project</a>
- <a href="#sponsorship">Sponsorship</a>
- <a href="#contributors-list">Contributors List</a>
  - <a href="#code-contributors">Code Contributors</a>
  - <a href="#translation-contributors">Translation Contributors</a>
  - <a href="#financial-contributors">Financial Contributors</a>
- <a href="#acknowledgements">Acknowledgements</a>

<h2 id="introduction"><a href="#table-of-contents">
Introduction
</a></h2>

<div align="center">
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/stargazers" title="GitHub Stars" target="_blank"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/hwhsu1231/cmake3-docs-l10n-draft2.svg?logo=github&style=flat&color=blue" ></a>
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/network/members" title="GitHub Forks" target="_blank"><img alt="GitHub Forks" src="https://img.shields.io/github/forks/hwhsu1231/cmake3-docs-l10n-draft2.svg?logo=github&style=flat&color=blue" ></a>
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/graphs/contributors" title="GitHub Contributors" target="_blank"><img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/hwhsu1231/cmake3-docs-l10n-draft2.svg?logo=github&style=flat&color=blue" ></a>
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2" title="GitHub Repo Size" target="_blank"><img alt="GitHub Repo Size" src="https://img.shields.io/github/repo-size/hwhsu1231/cmake3-docs-l10n-draft2?logo=github&style=flat&color=blue"></a><br />
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/issues" title="GitHub Open Issues" target="_blank"><img alt="GitHub Open Issues" src="https://img.shields.io/github/issues/hwhsu1231/cmake3-docs-l10n-draft2.svg?logo=github&style=flat&color=brightgreen" ></a>
  <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/pulls" title="GitHub Open Pull Requests" target="_blank"><img alt="GitHub Open Pull Requests" src="https://img.shields.io/github/issues-pr/hwhsu1231/cmake3-docs-l10n-draft2?logo=github&style=flat&color=brightgreen" ></a><br />
  <a href="https://opensource.org/licenses/BSD-3-Clause" title="License: BSD-3-Clause" target="_blank"><img alt="License: BSD-3-Clause" src="https://img.shields.io/badge/License-BSD%203--Clause-blue.svg"></a>
  <a href="https://www.contributor-covenant.org/" title="Contributor Covenant: 2.1" target="_blank"><img alt="Contributor Covenant" src="https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg"></a>
  <a href="https://crowdin.com/project/cmake-docs-i18n" title="Crowdin Localized" target="_blank"><img alt="Crowdin Localized" src="https://badges.crowdin.net/cmake-docs-i18n/localized.svg" ></a>  
</div>
<p></p>

This is a localization project for CMake Documentation.

The translations are contributed in Crowdin Project and downloaded automatically in Git Repository.

Git Repository:

- GitHub (main): https://github.com/hwhsu1231/gdal-docs-l10n
- Gitee (mirror): https://gitee.com/hwhsu1231/gdal-docs-l10n
- GitFlic (mirror): https://gitflic.ru/project/hwhsu1231/gdal-docs-l10n
- Codeberg (mirror): https://codeberg.org/hwhsu1231/gdal-docs-l10n

Crowdin Project: https://crowdin.com/project/gdal-docs

Contributing and Maintaining Guidelines:

- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Contributing Guidelines](./docs/CONTRIBUTING.md)
- [Maintaining Guidelines](./docs/MAINTAINING.md)

GitHub Worflows:

<p></p>
<table align="center">
  <tbody>
    <tr>
      <th>Status Badges</th>
      <th>Schedule</th>
      <th>Purpose</th>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-check-pr-status.yml"><img alt="ci-check-pr-status" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-check-pr-status.yml/badge.svg" ></a>
      </td>
      <td><strong>NONE</strong></td>
      <td>Check PR's status before merging.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-gettext-update-po.yml"><img alt="ci-gettext-update-po" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-gettext-update-po.yml/badge.svg" ></a>
      </td>
      <td><strong>NONE</strong></td>
      <td>Update po from Gettext.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-upload-pot.yml"><img alt="ci-crowdin-upload-pot" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-upload-pot.yml/badge.svg" ></a><br />
      </td>
      <td><strong>NONE</strong></td>
      <td>Upload pot to Crowdin.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-contributor.yml"><img alt="ci-crowdin-contributor" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-contributor.yml/badge.svg" ></a>
      </td>
      <td><strong>0 0 * * 5</strong></td>
      <td>Update Crowdin Contributors.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-document.yml"><img alt="ci-crowdin-document" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-document.yml/badge.svg" ></a>
      </td>
      <td><strong>0 0 * * 5</strong></td>
      <td>
        Upload documents to Crowdin;<br />
        Download documents from Crowdin.
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-download-po.yml"><img alt="ci-crowdin-download-po" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-crowdin-download-po.yml/badge.svg" ></a>
      </td>
      <td><strong>0 2 * * 5</strong></td>
      <td>Download po from Crowdin.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-merge-compendium.yml"><img alt="ci-merge-compendium" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-merge-compendium.yml/badge.svg" ></a>
      </td>
      <td><strong>0 4 * * 5</strong></td>
      <td>Merge po from Compendium.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-deploy-gh-pages.yml"><img alt="ci-deploy-gh-pages" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-deploy-gh-pages.yml/badge.svg" ></a>
      </td>
      <td><strong>0 8 * * 5</strong></td>
      <td>Deploy html to GitHub Pages.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-deploy-po-version.yml"><img alt="ci-deploy-po-version" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-deploy-po-version.yml/badge.svg" ></a>
      </td>
      <td><strong>0 8 * * 5</strong></td>
      <td>Deploy po to <code>po/${VERSION}</code> branch.</td>
    </tr>
    <tr>
      <td>
        <a href="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-sphinx-update-pot.yml"><img alt="ci-sphinx-update-pot" src="https://github.com/hwhsu1231/cmake3-docs-l10n-draft2/actions/workflows/ci-sphinx-update-pot.yml/badge.svg" ></a>
      </td>
      <td><strong>0 9 * * 5</strong></td>
      <td>Update pot from Sphinx.</td>
    </tr>
</table>

<h2 id="progress-of-translations"><a href="#table-of-contents">
Progress of Translations
</a></h2>

<table align="center">
  <thead>
    <tr>
      <th>Language<br />Code</th>
      <th>Language Name<br />Localized Name</th>
      <th>Translated<br />Proofread</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>zh_CN</code></td>
      <td>Simplified Chinese<br />简体中文</td>
      <td>
        <a href="https://crowdin.com/project/cmake-docs-i18n/zh-CN" title="zh-CN translation" target="_blank"><img alt="zh-CN translation" src="https://img.shields.io/badge/dynamic/json?color=blue&label=zh-CN&style=flat&logo=crowdin&query=%24.progress[?(@.data.languageId==%27zh-CN%27)].data.translationProgress&url=https%3A%2F%2Fbadges.awesome-crowdin.com%2Fstats-15619673-581765.json" width="90"></a>
        <br />
        <a href="https://crowdin.com/project/cmake-docs-i18n/zh-CN" title="zh-CN proofreading" target="_blank"><img alt="zh-CN proofreading" src="https://img.shields.io/badge/dynamic/json?color=green&label=zh-CN&style=flat&logo=crowdin&query=%24.progress[?(@.data.languageId==%27zh-CN%27)].data.approvalProgress&url=https%3A%2F%2Fbadges.awesome-crowdin.com%2Fstats-15619673-581765.json" width="90"></a>
      </td>
    </tr>
    <tr>
      <td><code>zh_TW</code></td>
      <td>Traditional Chinese<br />繁體中文</td>
      <td>
        <a href="https://crowdin.com/project/cmake-docs-i18n/zh-TW" title="zh-TW translation" target="_blank"><img alt="zh-TW translation" src="https://img.shields.io/badge/dynamic/json?color=blue&label=zh-TW&style=flat&logo=crowdin&query=%24.progress[?(@.data.languageId==%27zh-TW%27)].data.translationProgress&url=https%3A%2F%2Fbadges.awesome-crowdin.com%2Fstats-15619673-581765.json" width="90"></a>
        <br />
        <a href="https://crowdin.com/project/cmake-docs-i18n/zh-TW" title="zh-TW proofreading" target="_blank"><img alt="zh-TW proofreading" src="https://img.shields.io/badge/dynamic/json?color=green&label=zh-TW&style=flat&logo=crowdin&query=%24.progress[?(@.data.languageId==%27zh-TW%27)].data.approvalProgress&url=https%3A%2F%2Fbadges.awesome-crowdin.com%2Fstats-15619673-581765.json" width="90"></a>
      </td>
    </tr>
  </tbody>
</table>

<div align="center">
  <a href="https://crowdin.com/project/cmake-docs-i18n"><img src="https://badges.awesome-crowdin.com/translation-15619673-581765-update.png"></a>
</div>

<h2 id="preview-translations"><a href="#table-of-contents">
Preview Translations
</a></h2>

<h3 id="preview-in-local-build"><a href="#table-of-contents">
Preview in Local Build
</a></h3>

You can preview translations in Local Build. About how to build documentation locally, see this [section](docs/CONTRIBUTING.md#how-to-build-the-docs-locally) for details.

<h3 id="preview-in-gh-pages"><a href="#table-of-contents">
Preview in GitHub Pages
</a></h3>

You can preview translations in GitHub Pages:

<table align="center">
  <tbody>
    <tr>
      <th>Language</th>
      <th>Available Versions</th>
    </tr>
    <tr>
      <td><code>zh_CN</code></td>
      <td>
        <a href="https://hwhsu1231.github.io/cmake3-docs-l10n-draft2/zh_CN/git-master">git-master</a>
        <a href="https://hwhsu1231.github.io/cmake3-docs-l10n-draft2/zh_CN/latest">latest</a>
      </td>
    </tr>
    <tr>
      <td><code>zh_TW</code></td>
      <td>
        <a href="https://hwhsu1231.github.io/cmake3-docs-l10n-draft2/zh_TW/git-master">git-master</a>
        <a href="https://hwhsu1231.github.io/cmake3-docs-l10n-draft2/zh_TW/latest">latest</a>
      </td>
    </tr>
  </tbody>
</table>

You can switch to other available versions by version switcher.

<h2 id="licenses"><a href="#table-of-contents">
Licenses
</a></h2>

All the script files (<code>CMakeLists.txt</code> and <code>.cmake</code> files) and workflow files (<code>.yml</code> files inside <code>.github/workflows/</code> directory) of this project are distributed under <a href="https://opensource.org/license/bsd-3-clause/">3-Clause BSD</a> license. See <a href="./LICENSE">LICENSE</a> for details.

All the translation files (`.po` and `.pot` files inside `l10n/` directory) are owned by the upstream, and are subject to its copyright and license.

<h2 id="translation-disclaimer"><a href="#table-of-contents">
Translation Disclaimer
</a></h2>

Translators who contribute to this project will never make use of the copyright on his or her translations, will never forbid copying them, and will never ask for some kind of compensation. Everyone will always be allowed to freely use, modify, and distribute these translations.

<h2 id="about-author"><a href="#table-of-contents">
Maintainers List
</a></h2>

This project is created and currently maintained by the author, Haowei Hsu.

<table align="center">
  <thead>
    <tr>
      <th>Language</th>
      <th>Proofreader</th>
      <th>Contact Info</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2">Simplified Chinese<br/>简体中文</td>
      <td>Haowei Hsu</td>
      <td>
        Crowdin: <a href="https://crowdin.com/profile/hwhsu1231">hwhsu1231</a><br/>
        GitHub: <a href="https://github.com/hwhsu1231">hwhsu1231</a><br/>
        Gitee: <a href="https://gitee.com/hwhsu1231">hwhsu1231</a>
      </td>
    </tr>
    <tr>
      <td>Xxxx Yyy</td>
      <td>xxxxyyy@example.com</td>
    </tr>
    <tr>
      <td rowspan="2">Traditional Chinese<br/>繁體中文</td>
      <td>Haowei Hsu</td>
      <td>
        Crowdin: <a href="https://crowdin.com/profile/hwhsu1231">hwhsu1231</a><br/>
        GitHub: <a href="https://github.com/hwhsu1231">hwhsu1231</a><br/>
        Gitee: <a href="https://gitee.com/hwhsu1231">hwhsu1231</a>
      </td>
    </tr>
    <tr>
      <td>Xxxx Yyy</td>
      <td>xxxxyyy@example.com</td>
    </tr>
  </tbody>
</table>

<h2 id="support-this-project"><a href="#table-of-contents">
Support this Project
</a></h2>

You can contribute and support this project by doing any of the following:

- Star the project on GitHub or other mirrors.
- Submit issues or pull requests on GitHub if you found any bug.
- Contribute your translations on Crowdin.
- If you love this project or hope your wished documentation be localized, please consider <a href="#sponsorship">sponsorship</a>. 

It will inspire author to make more and more localization projects for open-source documentation.

<h2 id="sponsorship"><a href="#table-of-contents">
Sponsorship
</a></h2>

<!-- You can sponsor the author in the following platforms: -->

<!-- <table align="center">
  <tbody>
    <tr>
      <th style="text-align: center; vertical-align: middle;">Patreon</th>
      <td style="text-align: center; vertical-align: middle;">
        <a href="https://www.patreon.com/hwhsu1231" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-button-patreon.png" alt="Patream">
      </td>
    </tr>
    <tr>
      <th style="text-align: center; vertical-align: middle;">Afdian</th>
      <td style="text-align: center; vertical-align: middle;">
        <a href="https://www.afdian.net/a/hwhsu1231" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-button-afdian.png" alt="Afdian">
      </td>
    </tr>
  </tbody>
</table> -->

Alternatively, you can sponsor the author through the following platforms and e-payments:

<table align="center">
  <tbody>
    <tr>
      <th style="text-align: center; vertical-align: middle;">Patreon</th>
      <td align="center">
        <a href="https://www.patreon.com/hwhsu1231" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-button-patreon.png" alt="Patream"></a>
      </td>
    </tr>
    <tr>
      <th style="text-align: center; vertical-align: middle;">Afdian</th>
      <td align="center">
        <a href="https://www.afdian.net/a/hwhsu1231" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-button-afdian.png" alt="Afdian"></a>
      </td>
    </tr>
    <tr>
      <th colspan="2" style="text-align: center; vertical-align: middle;"><a href="https://www.paypal.com" target="_blank">PayPal</a></th>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <a href="https://www.paypal.me/hwhsu1231" target="_blank"><img width="250" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-button-paypal.png"></a>
      </td>
    </tr>
    <tr>
      <th style="text-align: center; vertical-align: middle;"><a href="https://global.alipay.com/" target="_blank">Alipay</a></th>
      <th style="text-align: center; vertical-align: middle;"><a href="https://www.jkopay.com/" target="_blank">Jkopay</a></th>
    </tr>
    <tr>
      <td align="center">
        <a href="https://qr.alipay.com/fkx18294jx1hzzilce3rfc8" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-qrcode-alipay.png"></a>
      </td>
      <td align="center">
        <a href="https://www.jkopay.com/transfer?j=Transfer:909173642" target="_blank"><img width="200" src="https://cdn.jsdelivr.net/gh/hwhsu1231/static/sponsor-qrcode-jkopay.png"></a>
      </td>
    </tr>
  </tbody>
</table>

<h2 id="contributors-list"><a href="#table-of-contents">
Contributors List
</a></h2>

<h3 id="code-contributors"><a href="#table-of-contents">
Code Contributors
</a></h3>

<img alt="GitHub Contributors SVG" src="https://contrib.nn.ci/api?repo=hwhsu1231/cmake-docs-l10n-draft2&no_bot=true">

<h3 id="translation-contributors"><a href="#table-of-contents">
Translation Contributors
</a></h3>

See <a href="./docs/CROWDIN_CONTRIBUTORS.md">CROWDIN_CONTRIBUTORS</a>.

<h3 id="financial-contributors"><a href="#table-of-contents">
Financial Contributors
</a></h3>

TODO: Provided by <a href="https://github.com/antfu/sponsorkit">sponsorkit</a>.

<h2 id="acknowledgements"><a href="#table-of-contents">
Acknowledgements
</a></h2>

See <a href="./docs/ACKNOWLEDGEMENTS.md">ACKNOWLEDGEMENTS</a>.
