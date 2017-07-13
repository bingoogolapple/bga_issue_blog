/**
 * Created by bingoogolapple on 2017/5/31.
 */
import { makeAction } from '../util'

const SET_LABELS = 'SET_LABELS'
const SET_ACTIVE_LABEL = 'SET_ACTIVE_LABEL'

const state = {
  labels: [],
  activeLabel: null
}

const mutations = {
  [SET_LABELS] (state, labels) {
    state.labels = labels
  },
  [SET_ACTIVE_LABEL] (state, label) {
    state.activeLabel = label
  }
}

const actions = {
  setLabels: makeAction(SET_LABELS),
  updateActiveLabel: makeAction(SET_ACTIVE_LABEL)
}

const getters = {
  labels: (state) => {
    return state.labels
  },
  activeLabel: (state) => {
    return state.activeLabel
  }
}

export default {
  state,
  mutations,
  getters,
  actions
}
