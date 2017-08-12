/**
 * Created by bingoogolapple on 2017/7/13.
 */

module.exports = {
  getLabels (vue) {
    return vue.$http.get(`https://api.github.com/repos/${vue.$store.getters.repo}/labels`)
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
      label = `+label:"${data.label}"`
    }

    return vue.$http.get(`https://api.github.com/search/issues?q=${data.keyword}+state:open+repo:${vue.$store.getters.repo}${label}&sort=created&order=desc&page=${data.currentPage}&per_page=${data.pageSize}`)
  },
  getIssue (vue, number) {
    return vue.$http.get(`https://api.github.com/repos/${vue.$store.getters.repo}/issues/${number}`)
  },
  getComments (vue, url) {
    return vue.$http.get(url)
  },
  getReadme (vue) {
    return vue.$http.get(`https://raw.githubusercontent.com/${vue.$store.getters.repo}/master/README.md`)
  },
  getAccessToken (vue, code) {
    const auth = vue.$store.getters.auth
    return vue.$http.post(auth.proxy, {
      code,
      client_id: auth.clientID,
      client_secret: auth.clientSecret
    }, {
      headers: {
        'Accept': 'application/json'
      }
    })
  },
  addComment (vue, url, comment) {
    return vue.$http.post(url, {
      body: comment
    }, {
      headers: {
        Authorization: `token ${vue.$store.getters.accessToken}`
      }
    })
  }
}
