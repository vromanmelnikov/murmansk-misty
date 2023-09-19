import { Badge, Button, Card, Col, Row } from 'reactstrap'
import Styles from './FoundProducts.module.css'

import starIcon from '../../../../assets/photos/star_icon.png'
import feedbackIcon from '../../../../assets/photos/feedback_icon.png'
import heartFullIcon from '../../../../assets/photos/heart_full.png'
import heartIcon from '../../../../assets/photos/heart.png'

const FoundProducts = (props) => {

    return (
        <div className={`${Styles.page} container`}>
            <Row>
                {/* <Col xs='4'>
                    <Card>d</Card>
                </Col> */}
                <Col xs='12' className={`${Styles.items}`}>
                    <Card className={`${Styles.groupsContainer}`}>
                        <div className={`${Styles.groups}`}>
                            {
                                props.groups.map(
                                    (item, index) => {
                                        return (
                                            <div key={index} className={`${Styles.group}`}>
                                                <h2 className={`${Styles.groupName}`}><Badge color='primary'>{item.name}</Badge></h2>
                                                {
                                                    item.items.map(
                                                        (good, goodIndex) => {
                                                            return (
                                                                <span className={`${Styles.groupGood}`}></span>
                                                            )
                                                        }
                                                    )
                                                }
                                            </div>
                                        )
                                    }
                                )
                            }
                        </div>
                    </Card>
                    {
                        props.items.map(
                            (item, index) => {
                                return (
                                    <Card className={`${Styles.item}`}>
                                        <div className={`${Styles.image}`} style={{backgroundImage: `url(${item.preview_img})`}}></div>
                                        <div className={`${Styles.info}`}>
                                            <span
                                                className={`${Styles.name}`}
                                                onClick={() => props.goToGood(item.product_id)}
                                            >
                                                {item.name}
                                            </span>
                                            {/* {
                                                item.details &&
                                                Object.keys(item.details.characteristics).map(
                                                    (key, keyIndex) => {
                                                        return (
                                                            <p key={keyIndex} className={`${Styles.detail}`}>
                                                                <span className={`${Styles.detailsKey}`}>{key}</span>
                                                                :
                                                                <span className={`${Styles.detailsValue}`}> {item.details[key]}</span>
                                                            </p>
                                                        )
                                                    }
                                                )
                                            } */}
                                            <span className={`${Styles.feedbackLine}`}>
                                                <span className={`${Styles.indicator}`}>
                                                    <img src={starIcon} />
                                                    {item.mark}
                                                </span>
                                                <span className={`${Styles.indicator}`}>
                                                    <img src={feedbackIcon} />
                                                    {item.feedbackCount}
                                                </span>
                                            </span>
                                        </div>
                                        <div className={`${Styles.cost}`}>
                                            <span className={`${Styles.value}`}>{item.cost} р.</span>
                                            <div className={`${Styles.func}`}>
                                                <Button color='primary'>
                                                    В корзину
                                                </Button>
                                                {
                                                    item.liked === true 
                                                    ?
                                                    <img src={heartFullIcon} onClick={() => props.likeGood(index)}/>
                                                    :
                                                    <img src={heartIcon} onClick={() => props.likeGood(index)}/>
                                                }
                                            </div>
                                        </div>
                                    </Card>
                                )
                            }
                        )
                    }
                </Col>
            </Row>
        </div>
    )

}

export default FoundProducts