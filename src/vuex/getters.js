export const labels = (state) => {
  return state.labels
}


// 获取 noteList,这里将会根据 state.show 的状态做数据过滤
export const filteredNotes = (state) => {
  if (state.show === 'all') {
    return state.notes || {}
  } else if (state.show === 'favorite') {
    return state.notes.filter(note => note.favorite) || {}
  }
}


// 获取列表展示状态 ： all or favorite
export const show = (state) => {
  return state.show
}

// 获取当前激活 note
export const activeNote = (state) => {
  return state.activeNote
}
