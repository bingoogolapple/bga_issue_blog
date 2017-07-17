/**
 * Created by bingoogolapple on 2017/7/13.
 */

const gitHubApi = require('./gitHubApi')

const isGetUserInfo = function (vm, config) {
  return config && (config.url === `https://api.github.com/repos/${vm.$store.getters.context}/labels` || config.url === `https://api.github.com/users/${vm.$store.getters.gitHubUsername}`)
}

module.exports = {
  gitHubApi,
  isGetUserInfo
}
