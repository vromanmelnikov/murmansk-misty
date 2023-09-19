import { useEffect, useState } from "react";
import CalendarEvent from "./calendarevent"
import moment from 'moment'


const CalendarEventContainer = (props) => {

    const currentDate = new Date()

    const [events, setEvents] = useState([
        {
            start: currentDate,
            end: currentDate,
            title: "Купить стиральный порошок"
        },
        {
            start: currentDate.setDate(currentDate.getDate() + 1),
            end: currentDate.setDate(currentDate.getDate() + 1),
            title: "Стрижка"
        },

    ])

    const getRandom = (max) => {

        return Math.floor(Math.random() * max)

    }

    useEffect(
        () => {

            const currentDate = new Date()

            const newEvents = [
                {
                    title: 'Купить шоколадку'
                },
                {
                    title: 'Стрижка'
                },
                {
                    title: 'Клининг'
                },
                {
                    title: 'Купить стиральный порошок'
                },
                {
                    title: 'Массаж'
                },
            ]

            for (let key of Object.keys(newEvents)) {

                const date = structuredClone(currentDate)
                date.setDate(date.getDate() + getRandom(10))
                newEvents[key] = {
                    start: date,
                    end: date,
                    title: newEvents[key].title
                }

            }

            // for (let i = 0; i < 5; i++) {

            //     const date = structuredClone(currentDate)
            //     date.setDate(date.getDate() + getRandom(10))
            //     newEvents.push({
            //         start: date,
            //         end: date,
            //         title: 'Some event'
            //     })

            //     // currentDate.setDate(currentDate.getDate() + 1)

            // }

            setEvents(newEvents)

        }, []
    )

    const propsData = {
        events
    }

    return (
        <CalendarEvent {...propsData} />
    )
}

export default CalendarEventContainer