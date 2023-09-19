import { Button } from 'reactstrap'
import Styles from './Items.module.css'

const Items = (props) => {

    return (
        <div className={`${Styles.item}`}>
            <span
                className={`${Styles.img}`}
                style={{ backgroundImage: "url()" }}
            >

            </span>
            <span className={`${Styles.name}`} onClick={()=>props.goToGood(props.item.product_item.product_id)} >{props.item.product_item.name}</span>
            <div>
                <span className={`${Styles.cost}`} >{props.item.product_item.price} р.</span>
                <Button color="primary" size="sm" className={`${Styles.button}`}>В корзину </Button>
            </div>
        </div>
    )

}

export default Items