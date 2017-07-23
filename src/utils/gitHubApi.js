/**
 * Created by bingoogolapple on 2017/7/13.
 */

module.exports = {
  getLabels (vue) {
    return vue.$http.get(`https://api.github.com/repos/${vue.$store.getters.context}/labels`)
  },
  getGitHubUser (vue) {
    return vue.$http.get(`https://api.github.com/users/${vue.$store.getters.gitHubUsername}`)
  },
  getUserInfo (vue) {
    return vue.$http.all([this.getGitHubUser(vue), this.getLabels(vue)])
  },
  getIssues (vue, data) {
    let label = ''
    if (data.label && data.label.trim().length > 0) {
      label = `+label:${data.label}`
    }

    return vue.$http.get(`https://api.github.com/search/issues?q=${data.keyword}+state:open+repo:${vue.$store.getters.context}${label}&sort=created&order=desc&page=${data.currentPage}&per_page=${data.pageSize}`)
  },
  getIssue (vue, number) {
    return vue.$http.get(`https://api.github.com/repos/${vue.$store.getters.context}/issues/${number}`)
  },
  getComments (vue, url) {
    return vue.$http.get(url)
  },
  getReadme (vue) {
    return vue.$http.get(`https://raw.githubusercontent.com/${vue.$store.getters.context}/master/README.md`)
  }
}
