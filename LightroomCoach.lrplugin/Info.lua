return {
  LrSdkVersion = 12.0,
  LrToolkitIdentifier = 'com.yourco.lightroomcoach',
  LrPluginName = 'Lightroom Coach',
  LrInitPlugin = 'PluginInit.lua',
  LrPluginInfoProvider = 'Prefs.lua',
  LrExportMenuItems = {
    { title = 'Lightroom Coach…', file = 'PluginInit.lua', enabledWhen = 'always' }
  },
}