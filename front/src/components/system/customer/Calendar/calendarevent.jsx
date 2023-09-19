import { Calendar, globalizeLocalizer } from 'react-big-calendar'
import { Button, Card, Col, Container, Fade, Row } from "reactstrap"
import Styles from './calendar.module.css'
import globalize from 'globalize'

const localizer = globalizeLocalizer(globalize)


const CalendarEvent = (props) => {

    return (
        <Card className='p-3 mt-4 m-5 pl-sm-5'>
            <Calendar className={`${Styles.card} `}
                localizer={localizer}
                defaultDate={new Date()}
                defaultView="month"
                events={props.events}
                style={{ height: "75vh" }}
            />
        </Card>
    )
}

export default CalendarEvent