/**
 * Created by bingoogolapple on 2017/5/31.
 */
import {makeAction} from '../util'

const SET_LABELS = 'SET_LABELS'
const SET_ACTIVE_LABEL = 'SET_ACTIVE_LABEL'
const SET_ISSUES = 'SET_ISSUES'
const SET_ACTIVE_ISSUE = 'SET_ACTIVE_ISSUE'
const SET_COMMENTS = 'SET_COMMENTS'

const state = {
  labels: [],
  activeLabel: {},
  issues: [],
  activeIssue: {},
  comments: []
}

const mutations = {
  [SET_LABELS] (state, labels) {
    state.labels = labels
    state.activeLabel = state.labels[0] || {}
  },
  [SET_ACTIVE_LABEL] (state, label) {
    state.activeLabel = label
    state.issues = []
    state.activeIssue = {}
    state.comments = []
  },
  [SET_ISSUES] (state, issues) {
    state.issues = issues
    state.activeIssue = state.issues[0] || {}
    state.comments = []
  },
  [SET_ACTIVE_ISSUE] (state, issue) {
    state.activeIssue = issue
    state.comments = []
  },
  [SET_COMMENTS] (state, comments) {
    state.comments = comments
  }
}

const actions = {
  setLabels: makeAction(SET_LABELS),
  updateActiveLabel: makeAction(SET_ACTIVE_LABEL),
  setIssues: makeAction(SET_ISSUES),
  updateActiveIssue: makeAction(SET_ACTIVE_ISSUE),
  setComments: makeAction(SET_COMMENTS)
}

const getters = {
  labels: (state) => {
    return state.labels
  },
  activeLabel: (state) => {
    return state.activeLabel
  },
  issues: (state) => {
    return state.issues
  },
  activeIssue: (state) => {
    return state.activeIssue
  },
  comments: (state) => {
    return state.comments
  }
}

export default {
  state,
  mutations,
  getters,
  actions
}
