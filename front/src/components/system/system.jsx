import { Container } from 'reactstrap'
import FooterContainer from './elements/Footer/Footer.container'
import QuickActionsContainer from './elements/QuickActions/QuickActions.container'
import HeaderContainer from './elements/header/header.container'
import Styles from './system.module.css'
import { Outlet } from "react-router"

const System = (props) => {

    return (
        <div className={`${Styles.content}`}>

            <HeaderContainer />

            <Outlet />
            {/* <FooterContainer /> */}

            <QuickActionsContainer />

        </div>
    )
}

export default System