/**
 * Created by bingoogolapple on 2017/5/31.
 */
import { makeAction } from '../util'

const SET_GITHUB_USER = 'SET_GITHUB_USER'

const state = {
  gitHubUsername: 'bingoogolapple',
  weiBoUsername: 'bingoogol',
  gitHubUser: null,
  showQQGroup: true,
  gitBookUrl: 'https://bingoogolapple.gitbooks.io/bgalearningnotes-git/content'
}

const mutations = {
  [SET_GITHUB_USER] (state, gitHubUser) {
    state.gitHubUser = gitHubUser
  }
}

const actions = {
  setGitHubUser: makeAction(SET_GITHUB_USER)
}

const getters = {
  weiBoUsername: (state) => {
    return state.weiBoUsername
  },
  gitHubUsername: (state) => {
    return state.gitHubUsername
  },
  context: (state) => {
    return `${state.gitHubUsername}/${state.gitHubUsername}.github.io`
  },
  gitHubUser: (state) => {
    return state.gitHubUser
  },
  showQQGroup: (state) => {
    return state.showQQGroup
  },
  gitBookUrl: (state) => {
    return state.gitBookUrl
  }
}

export default {
  state,
  mutations,
  getters,
  actions
}
