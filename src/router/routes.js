/**
 * Created by bingoogolapple on 2017/7/14.
 */
import mainRoutes from './main-routes'

/**
 * 路由表配置
 */
export default [
  {
    name: 'AboutMe',
    path: '/AboutMe',
    meta: {requiresAuth: false},
    component: resolve => require.ensure([], () => resolve(require('@/views/AboutMe.vue')), 'AboutMe')
  },
  {
    path: '/',
    component: resolve => require.ensure([], () => resolve(require('@/views/Layout.vue')), 'Layout'),
    children: mainRoutes
  },
  {
    path: '*',
    redirect: '/'
  }
]
