import ProfileInfoContainer from "../elements/profileInfo/profileInfo.container"
import ItemsContainer from "./Items/Items.container"
import Styles from './SomeoneProfile.module.css'
import { Button, Card, Col, Row,Badge } from "reactstrap"

const SomeoneProfile = (props) => {

    return (
        <div className={`${Styles.content} container`}>
            <ProfileInfoContainer isPersonal={false} />
            <div className={`${Styles.tagContainer}`}>
                <h1 className={`${Styles.tagName}`}><Badge color='primary'>Идеи для подарков</Badge></h1>
                <Card className={`${Styles.tag}`} >
                    {
                        props.favouriteProducts.map(
                            (item, index) => {

                                return (

                                    <ItemsContainer key={index} item={item}></ItemsContainer>

                                )
                            }
                        )
                    }

                </Card>
            </div>
        </div>
    )
}

export default SomeoneProfile