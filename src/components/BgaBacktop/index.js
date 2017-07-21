/**
 * Created by bingoogolapple on 2017/7/21.
 */
import Backtop from './src/BgaBacktop.vue'

const BgaBacktop = {
  install: function (Vue) {
    Vue.component('bga-backtop', Backtop)
    Vue.prototype.$bgaBacktop = function () {
      if (Vue.prototype.$bagBacktopInstance) {
        Vue.prototype.$bagBacktopInstance.startScrollToTop()
      }
    }
  }
}

export default BgaBacktop
