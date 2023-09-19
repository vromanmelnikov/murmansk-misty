
import { Button, Card } from 'reactstrap'
import Styles from './Goods.module.css'

import heartFullIcon from '../../../../../assets/photos/heart_full.png'
import heartIcon from '../../../../../assets/photos/heart.png'

const Goods = (props) => {

    return (
        <div className={`${Styles.list}`}>
            {
                props.items.length === 0
                &&
                <Card className={`${Styles.noItems}`}>
                    <h2>Нет избранных товаров</h2>
                </Card>
            }
            {
                props.items.map(
                    (item, index) => {
                        return (
                            <Card key={index} className={`${Styles.item}`}>
                                <div className={`${Styles.image}`} style={{backgroundImage: `url(${item.product_item.product.preview_img})`}}></div>
                                <div className={`${Styles.info}`}>
                                    <div className={`${Styles.firstRow}`}>
                                        <span
                                            className={`${Styles.name}`}
                                            onClick={() => props.goToGood(item.product_item.product_id)}
                                        >
                                            {item.product_item.name}
                                        </span>
                                        <img className={`${Styles.like}`} src={heartFullIcon} onClick={() => props.deleteGood(item.id)} />
                                    </div>
                                    <div className={`${Styles.secondRow}`}>
                                        <span className={`${Styles.value}`}>{item.product_item.price} р.</span>
                                        <div className={`${Styles.func}`}>
                                            <Button color='primary' onClick={() => props.addToBasket(item.product_item_id)}>
                                                В корзину
                                            </Button>
                                        </div>
                                    </div>
                                </div>

                            </Card>
                        )
                    }
                )
            }
        </div>
    )

}

export default Goods