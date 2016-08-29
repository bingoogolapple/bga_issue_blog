import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// 需要维护的状态
const state = {
  labels: [],
  activeLabel: {},
  issues: [],
  activeIssue: {},
}

const mutations = {
  INIT_STORE(state, data) {
    state.labels = data.labels;
    state.activeLabel = data.activeLabel;
    state.issues = data.issues
    state.activeIssue = data.activeIssue
  },
  SET_LABELS(state, labels) {
    state.labels = labels
    state.activeLabel = state.labels[0] || {}
  },
  SET_ACTIVE_LABEL(state, label) {
    state.activeLabel = label
  },
  SET_ISSUES(state, issues) {
    state.issues = issues;
    state.activeIssue = state.issues[0] || {}
  },
  SET_ACTIVE_ISSUE(state, issue) {
    state.activeIssue = issue
  }
}

export default new Vuex.Store({
  state,
  mutations
})
