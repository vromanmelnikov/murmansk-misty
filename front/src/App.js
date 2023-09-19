import './App.css';
import { useRoutes } from 'react-router';
import Routes from './routes/routes';

import 'bootstrap/dist/css/bootstrap.min.css';
function App() {

  const routes = useRoutes(Routes)

  return (
    <>
      {routes}
    </>
  );

}

export default App;
