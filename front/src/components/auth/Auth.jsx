import { Card } from 'reactstrap'
import Styles from './Auth.module.css' 
import { Outlet } from 'react-router'


const Auth = (props) => {

    return(
        <div className={`${Styles.body}`}>
            <Card className={`${Styles.container}`}>
                <Outlet />
            </Card>
        </div>
    )
}

export default Auth