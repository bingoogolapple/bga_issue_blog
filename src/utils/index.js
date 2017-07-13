/**
 * Created by bingoogolapple on 2017/7/13.
 */

const gitHubApi = require('./gitHubApi')

const isGetLabelsUrl = function (vm, config) {
  return config && config.url === `https://api.github.com/repos/${vm.$store.getters.context}/labels`
}

module.exports = {
  gitHubApi,
  isGetLabelsUrl
}
