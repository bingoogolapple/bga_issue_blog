/**
 * Created by bingoogolapple on 2017/5/31.
 */
import Vue from 'vue'
import Vuex from 'vuex'
import account from './modules/account'
import issue from './modules/issue'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    account,
    issue
  },
  strict: debug
})
