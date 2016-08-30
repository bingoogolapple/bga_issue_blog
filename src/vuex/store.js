import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// 需要维护的状态
const state = {
  labels: [],
  activeLabel: {},
  issues: [],
  activeIssue: {},
  comments: []
}

const mutations = {
  INIT_STORE(state, data) {
    state.labels = data.labels;
    state.activeLabel = data.activeLabel
    state.issues = data.issues
    state.activeIssue = data.activeIssue
    state.comments = data.comments
  },
  SET_LABELS(state, labels) {
    state.labels = labels
    state.activeLabel = state.labels[0] || {}
  },
  SET_ACTIVE_LABEL(state, label) {
    state.activeLabel = label
    state.issues = []
    state.activeIssue = {}
    state.comments = []
  },
  SET_ISSUES(state, issues) {
    state.issues = issues
    state.activeIssue = state.issues[0] || {}
    state.comments = []
  },
  SET_ACTIVE_ISSUE(state, issue) {
    state.activeIssue = issue
    state.comments = []
  },
  SET_COMMENTS(state, comments) {
    state.comments = comments
  }
}

export default new Vuex.Store({
  state,
  mutations
})
