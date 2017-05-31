/**
 * Created by bingoogolapple on 2017/5/31.
 */
export function makeAction (type) {
  return ({commit}, ...args) => commit(type, ...args)
}
