import { Card, Row } from 'reactstrap'
import Styles from './Shops.module.css'

import profileIcon from '../../../../../assets/photos/profile_icon.png'
import API_CONFIG from '../../../../../config/api.config'
import AddButtonContainer from '../../../../UI/AddButton/AddButton.container'
import AddingStoreModalContainer from './AddingStoreModal/AddingStoreModal.container'

const Shops = (props) => {

    return (
        <>
            <Card className='p-3'>
                <h2>Мои магазины</h2>
                <Row className={`${Styles.store}`}>
                    {
                        props.stores.map(
                            (item, index) => {

                                let url = item.img

                                if (url !== null && url.indexOf('http') === -1) {
                                    url = `${API_CONFIG.PROD_BASE_URL}/files/${url}`
                                }
                                else if (url === null) {
                                    url = profileIcon
                                }

                                // console.log(url)

                                return (
                                    <span
                                        key={index}
                                        className={`${Styles.item}`}
                                        style={{ backgroundImage: `url(${url})` }}
                                        onClick={() => props.goToStore(item.id)}>

                                    </span>
                                )
                            }
                        )
                    }
                    <AddButtonContainer callback={props.addStore} />
                </Row>
            </Card>
            <AddingStoreModalContainer />
        </>

    )

}

export default Shops