/**
 * Created by bingoogolapple on 2017/7/13.
 */

const gitHubApi = require('./gitHubApi')

const isGetUserInfo = (vm, config) => {
  return config && (config.url === `https://api.github.com/repos/${vm.$store.getters.repo}/labels` || config.url === `https://api.github.com/users/${vm.$store.getters.gitHubUsername}`)
}

const queryParse = (search = window.location.search) => {
  if (!search) {
    return {}
  } else {
    const queryString = search[0] === '?' ? search.substring(1) : search
    const query = {}
    queryString
      .split('&')
      .forEach(queryStr => {
        const [key, value] = queryStr.split('=')
        if (key) {
          query[decodeURIComponent(key)] = decodeURIComponent(value)
        }
      })
    return query
  }
}

const queryStringify = query => {
  const queryString = Object.keys(query)
    .map(key => `${key}=${encodeURIComponent(query[key] || '')}`)
    .join('&')
  return queryString
}

export {
  gitHubApi,
  isGetUserInfo,
  queryParse,
  queryStringify
}
