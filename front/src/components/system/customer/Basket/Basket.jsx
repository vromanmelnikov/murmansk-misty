import { Button, Card, Col, Input, Row } from 'reactstrap'
import Styles from './Basket.module.css'
import { Outlet } from 'react-router'

const Basket = (props) => {

    return (
        <div className='container mt-3'>
            <Row>
                <Col xs='8' className={`${Styles.items}`}>
                    {
                        props.goods.length === 0
                        &&
                        <Card className={`${Styles.noItems}`}>
                            <h2>Нет товаров в корзине</h2>
                        </Card>
                    }
                    {
                        props.goods.map(
                            (item, index) => {
                                return (
                                    <Card key={index} className={`${Styles.item}`}>
                                        <div className={`${Styles.image}`} style={{backgroundImage: `url(${item.product_item.product.preview_img})`}}></div>
                                        <div className={`${Styles.info}`}>
                                            <span
                                                className={`${Styles.name}`}
                                                onClick={() => props.goToGood(item.product_item.product_id)}
                                            >
                                                {item.product_item.product.name}
                                            </span>
                                            {/* {
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
                                            } */}
                                            <span className={`${Styles.feedbackLine}`}>
                                                <span className={`${Styles.indicator}`}>
                                                    {/* <img src={starIcon} /> */}
                                                    {/* {item.mark} */}
                                                </span>
                                                <span className={`${Styles.indicator}`}>
                                                    {/* <img src={feedbackIcon} /> */}
                                                    {/* {item.feedbackCount} */}
                                                </span>
                                            </span>
                                        </div>
                                        <div className={`${Styles.cost}`}>
                                            <span className={`${Styles.value}`}>{item.product_item.price} р.</span>
                                            <div className={`${Styles.func}`}>
                                                <Button color='primary'>
                                                    -
                                                </Button>
                                                <Button disabled className={`${Styles.counter}`}>
                                                    {item.count}
                                                </Button>
                                                <Button color='primary' onClick={() => props.addItem(item.product_item_id)}>
                                                    +
                                                </Button>
                                                <Button color='danger' onClick={() => props.deleteItem(item.id)}>
                                                    x
                                                </Button>
                                            </div>
                                        </div>
                                    </Card>
                                )
                            }
                        )
                    }
                </Col>
                <Col xs='4'>
                    <Card className={`p-4 ${Styles.order}`}>
                        <h1>{props.cost} р.</h1>
                        <Button color='primary' onClick={props.buyAll}>Оформить заказ</Button>
                    </Card>
                </Col>
            </Row>
        </div>
    )

}

export default Basket