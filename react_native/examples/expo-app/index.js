import { registerRootComponent } from 'expo';

// Import the MoonBit-generated App component
import { app as App } from './App.generated';

// registerRootComponent calls AppRegistry.registerComponent('main', () => App);
// It also ensures that whether you load the app in Expo Go or in a native build,
// the environment is set up appropriately
registerRootComponent(App);
