import { Card } from 'reactstrap'
import Styles from './Groups.module.css'

const Groups = (props) => {

    return (
        <Card className={`${Styles.noItems}`}>
            <h2>Нет избранных товаров</h2>
        </Card>
    )

}

export default Groups