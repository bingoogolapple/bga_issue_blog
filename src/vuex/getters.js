// 获取label数组
export const labels = (state) => {
  return state.labels
}

// 获取当前选中的label
export const activeLabel = (state) => {
  return state.activeLabel
}

// 获取issues数组
export const issues = (state) => {
  return state.issues
}

// 获取当前选中的issue
export const activeIssue = (state) => {
  return state.activeIssue
}

// 获取当前选中issue里的comment数组
export const comments = (state) => {
  return state.comments
}

// 获取新浪微博用户名
export const weiBoUsername = (state) => {
  return state.weiBoUsername
}

// 获取GitHub用户名
export const gitHubUsername = (state) => {
  return state.gitHubUsername
}
