function makeAction(type) {
  return ({dispatch}, ...args) => dispatch(type, ...args)
}

// 模拟初始化数据
const initData = {
  labels: [],
  activeLabel: {},
  issues: [],
  activeIssue: {},
  comments: []
}

export const initStore = ({dispatch}) => {
  dispatch('INIT_STORE', initData)
}

// 更新Label列表展示
export const setLabels = makeAction('SET_LABELS')

// 更新当前activeLabel对象
export const updateActiveLabel = makeAction('SET_ACTIVE_LABEL')

// 更新Issue列表展示
export const setIssues = makeAction('SET_ISSUES')

// 更新当前activeIssue
export const updateActiveIssue = makeAction('SET_ACTIVE_ISSUE')

// 更新当前comments
export const setComments = makeAction('SET_COMMENTS')
