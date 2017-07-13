/**
 * Created by bingoogolapple on 2017/7/14.
 */
export default [
  {
    path: '',
    name: 'Home',
    component: resolve => require(['@/views/Home.vue'], resolve)
  },
  {
    path: '/Detail/:number',
    name: 'Detail',
    component: resolve => require(['@/views/Detail.vue'], resolve)
  }
]
