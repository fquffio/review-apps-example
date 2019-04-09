<h1 align="center">Review apps with GitLab CI</h1>
<p align="center">
  <a href="https://medium.com/chialab-open-source/review-apps-with-aws-cloudfront-for-html-js-projects-3bf0b7631bab">Medium Article</a> |
  <a href="https://github.com/fquffio/review-apps-example">GitHub + CirlceCI example</a> |
  <a href="https://gitlab.com/fquffio/review-apps-example">GitLab CI example</a> |
  <a href="https://www.chialab.io/">Authors</a>
</p>

This repository is a demonstration of how review applications can be integrated
in your workflow with several continuous integration.

Every time a new branch is pushed, a review application is started, so that designers
and teammates can review your changes in a live environment without forcing them
to checkout your branch on their workstations.

See pull requests for examples.

## CircleCI

CircleCI workflows let you run sequential and parallel jobs with ease.
See `.circleci/config.yml` included in this repository for an example of how
this can be used to deploy dynamic environments for your development branches.

## GitLab CI

GitLab CI lets you deploy [review applications](https://docs.gitlab.com/ee/ci/review_apps/index.html)
with ease. See `.gitlab-ci.yml` included in this repository for an example.
