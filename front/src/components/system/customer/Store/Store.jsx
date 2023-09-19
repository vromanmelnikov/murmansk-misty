import Styles from './Store.module.css'

import starIcon from '../../../../assets/photos/star_icon.png'
import feedbackIcon from '../../../../assets/photos/feedback_icon.png'
import heartFullIcon from '../../../../assets/photos/heart_full.png'
import heartIcon from '../../../../assets/photos/heart.png'
import profileIcon from '../../../../assets/photos/profile_icon.png'
import { Badge, Button, Card, Col, Row, Accordion, AccordionBody, AccordionHeader, AccordionItem } from 'reactstrap'


const Store = (props) => {


    return (
        <div className={`${Styles.page} container`}>
            <Row>
                <Col xs='4'>
                    <Card className='p-3 '>
                        <div className={`${Styles.img}`} style={{ backgroundImage: `url(${profileIcon})` }}></div>
                    </Card>
                    <Card className={`${Styles.description}`}>
                        <Accordion flush open={props.descriptions} toggle={props.toggle}>
                            <AccordionItem>
                                <AccordionHeader targetId="1">{props.description.name}</AccordionHeader>
                                <AccordionBody accordionId="1">
                                    {props.description.description}
                                </AccordionBody>
                            </AccordionItem>
                            </Accordion>
                    </Card>
                </Col>
                <Col xs='8' className={`${Styles.items}`}>
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
                                        <div className={`${Styles.image}`}></div>
                                        <div className={`${Styles.info}`}>
                                            <span
                                                className={`${Styles.name}`}
                                                onClick={() => props.goToGood(item.id)}
                                            >
                                                {item.name}
                                            </span>
                                            {
                                                item.details &&
                                                Object.keys(item.details).map(
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
                                            }
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
                                                        <img src={heartFullIcon} onClick={() => props.likeGood(index)} />
                                                        :
                                                        <img src={heartIcon} onClick={() => props.likeGood(index)} />
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

export default Store