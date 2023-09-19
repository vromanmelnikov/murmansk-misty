import { Button, Card, Row } from 'reactstrap'
import Styles from './ProfileCalendar.module.css'
import calendarArrowIcon from '../../../../../assets/photos/calendar_arrow_icon.png'

const ProfileCalendar = (props) => {

    return (
        <Card className={`${Styles.calendarBlock} mt-3 p-3`}>
            <h2>Близжайшие покупки и события</h2>
            <Row className={`${Styles.calendar}`}>
                {
                    props.plannedGoods.map(
                        (item, index) => {
                            return (
                                <span key={index} className={`${Styles.calendarItemContainer}`}>
                                    <span className={`${Styles.calendarItem}`}>
                                        <h5>{item.date}</h5>
                                        <hr />
                                        {
                                            item.goods.map(
                                                (good, goodIndex) => {
                                                    return (
                                                        <a key={goodIndex} href=''>{good.value}</a>
                                                    )
                                                }
                                            )
                                        }
                                    </span>
                                    {
                                        index !== props.plannedGoods.length - 1 &&
                                        <img className={`${Styles.calendarArrow}`} src={calendarArrowIcon} />
                                    }
                                </span> 
                            )
                        }
                    )
                }
            </Row>
            <Button color="primary" onClick={props.goToCalendar}>
                Перейти к календарю
            </Button>
        </Card>
    )

}

export default ProfileCalendar