import { Card, Row } from 'reactstrap'
import Styles from './Family.module.css'

import profileIcon from '../../../../../assets/photos/profile_icon.png'
import API_CONFIG from '../../../../../config/api.config'
import AddButtonContainer from '../../../../UI/AddButton/AddButton.container'
import AddFriendContainer from './AddFriend/AddFriend.container'

const Family = (props) => {

    return (
        <Card className='p-3'>
            <h2>Мои друзья</h2>
            <Row className={`${Styles.family}`}>
                {
                    props.familyList.map(
                        (item, index) => {

                            let url = item.friend.img

                            if (url !== null && url.indexOf('http') === -1) {
                                url = `${API_CONFIG.PROD_BASE_URL}/files/${url}`
                            }
                            else if (url === null) {
                                url = profileIcon
                            }

                            return (
                                <span key={index} className={`${Styles.item}`} style={{ backgroundImage: `url(${url})` }} onClick={() => props.goToProfile(item.friend_id)}>

                                </span>
                            )
                        }
                    )
                }
                <AddButtonContainer callback={props.addFriend}/>
                <AddFriendContainer />
            </Row>
        </Card>
    )

}

export default Family