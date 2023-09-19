import Styles from './Schelduler.module.css'

import scheldulerTemp from '../../../../../assets/photos/schelduler_temp.png'
import { Card } from 'reactstrap'

const Schelduler = (props) => {

    return (
        <Card className='p-3 mt-3'>
            <h2 className='mb-3'>Свободное время в расписании</h2>
            <img className={`${Styles.image}`} src={scheldulerTemp} />
        </Card>
    )

}

export default Schelduler