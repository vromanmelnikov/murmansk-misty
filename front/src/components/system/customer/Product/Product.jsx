import { Button, Card, Col, Row } from 'reactstrap'
import Styles from './Product.module.css'
import heartIcon from '../../../../assets/photos/heart.png'
import heartFullIcon from '../../../../assets/photos/heart_full.png'
import ProductModalContainer from './ProductModal/ProductModal/ProductModal.container'

const Product = (props) => {

    let url = props.item.preview_img

    return (
        <div className={`container mt-3`}>
            <Row>
                <Col xs='9' className={`${Styles.firstCol}`}>
                    <Card className={`p-3 ${Styles.main}`}>

                        <div className={`${Styles.image}`}
                            style={{ backgroundImage: `url(${url})`, backgroundSize: 'cover' }}></div>
                        <div className={`${Styles.name}`}>
                            <div className={`${Styles.info}`}>
                                <h1>{props.item.name}</h1>
                                <div className={`${Styles.tags}`}></div>
                            </div>

                            <div className={`${Styles.items}`}>
                                {

                                    props.item.product_items?.map(
                                        (item, index) => {
                                            return (
                                                <div key={index} className={`${Styles.feedbacks}`} >
                                                    <Button onClick={() => props.ChangePrice(item.price, item.details,item.id)}>
                                                        {item.name}
                                                    </Button>
                                                </div>
                                            )
                                        }
                                    )}
                            </div>

                            {
                                props.currentProductItem.details &&
                                props.currentProductItem.details.characteristics?.map(
                                    (item, index) => {
                                        return (
                                            <>
                                                {
                                                    Object.keys(item).map(
                                                        (key, keyIndex) => {
                                                            return (
                                                                <p key={keyIndex} className={`${Styles.detail}`}>
                                                                    <span className={`${Styles.detailsKey}`}>{key}: </span>

                                                                    <span className={`${Styles.detailsValue}`}> {item[key]}</span>
                                                                </p>
                                                            )
                                                        }
                                                    )}
                                            </>
                                        )
                                    }
                                )
                            }
                        </div>

                    </Card>
                    <Card className={`p-3 ${Styles.feedbacks}`} >

                        {
                            props.feedbacks.map(
                                (item, index) => {
                                    return (
                                        <div key={index} className={`${Styles.feedback}`}>
                                            <h4>{item.user.firstname} {item.user.lastname}</h4>
                                            <div className={`${Styles.review}`}> {item.review}</div>
                                        </div>
                                    )
                                }
                            )
                        }
                        {
                            props.feedbacks.length === 0
                            &&
                            <h2>Нет отзывов</h2>
                        }
                    </Card>
                </Col>
                <Col xs='3' className={`${Styles.secondCol}`}>
                    <Card className={`p-3`}>
                        <div className={`${Styles.cost}`}>
                            <span className={`${Styles.value}`}>
                                {props.currentProductItem.price} р.
                            </span>
                            <div className={`${Styles.likes}`}>

                                {
                                    props.item.is_service === false
                                        ?
                                        <Button color='primary' onClick={props.addToBasket} >
                                            В корзину
                                        </Button>
                                        :
                                        <Button color='primary' onClick={props.addBook}>
                                            Забронировать
                                        </Button>


                                }
                                {
                                    props.likeflag === false
                                        ?
                                        <img src={heartIcon} onClick={() => props.likeGood()} />
                                        :
                                        <img src={heartFullIcon} onClick={() => props.likeGood()} />


                                }




                            </div>

                        </div>
                    </Card>
                </Col>
            </Row>
            <ProductModalContainer />
        </div>
    )

}

export default Product