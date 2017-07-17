/**
 * Created by bingoogolapple on 2017/7/14.
 */
export default [
  {
    path: '',
    name: 'BlogList',
    component: resolve => require(['@/views/BlogList.vue'], resolve)
  },
  {
    path: '/BlogDetail/:number',
    name: 'BlogDetail',
    component: resolve => require(['@/views/BlogDetail.vue'], resolve)
  }
]
