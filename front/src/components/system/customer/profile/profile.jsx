import { Button, Card, Col, Container, Fade, Row } from "reactstrap"
import ProfileInfoContainer from "../elements/profileInfo/profileInfo.container"

import Styles from './profile.module.css'

import calendarArrowIcon from '../../../../assets/photos/calendar_arrow_icon.png'
import ProfileCalendarContainer from "./ProfileCalendar/ProfileCalendar.container"
import FamilyContainer from "./Family/Family.container"
import EditProfileModalContainer from "./EditProfileModal/EditProfileModal.container"
import ShopsContainer from "./Shops/Shops.container"
import BudgetContainer from "./Budget/Budget.container"
import ScheldulerContainer from "./Schelduler/Schelduler.container"

const Profile = (props) => {

    return (
        <div className={`${Styles.content} container`}>
            <ProfileInfoContainer isPersonal={true} user={props.user} userTags={props.userTags}/>
            <Row className={`${Styles.row}`}>
                <Col xs='6'>
                    <FamilyContainer />
                    <ProfileCalendarContainer />
                    <ScheldulerContainer />
                </Col>
                <Col xs='6'>
                    <ShopsContainer stores={props.user.stores}/>
                    <BudgetContainer/>
                </Col>
            </Row>
            <EditProfileModalContainer flag={props.editProfile} toggle={props.changeEdit} user={props.user} userTags={props.userTags}/>
        </div>
    )
}

export default Profile