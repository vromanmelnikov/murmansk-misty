import { useEffect, useState } from 'react'
import ProfileCalendar from './ProfileCalendar.jsx'
import { useNavigate } from 'react-router'

const   ProfileCalendarContainer = (props) => {

    const navigate = useNavigate()

    const [plannedGoods, setPlannedGoods] = useState([])

    const date = new Date()
    const currentDate = {
        day: date.getDate(),
        month: date.getMonth() + 1,
        year: date.getFullYear()
    }

    useEffect(
        () => {

            

            let nextDay = new Date()
            let i = 0

            let days = []

            do {

                nextDay = new Date(nextDay)
                nextDay.setDate(nextDay.getDate() + 1)
                i++

                const dayGood = {
                    date: `${nextDay.getDate()}.${nextDay.getMonth() + 1}.${nextDay.getFullYear()}`,
                    goods: [
                        {
                            value: 'Клининг'
                        },
                        {
                            value: 'Стрижка'
                        },
                    ]
                }

                days.push(dayGood)

            } while (i < 3)

            setPlannedGoods(days)

        }, []
    )

    const goToCalendar = () => {
        navigate('/calendar')
    }

    const propsData = {
        plannedGoods,
        goToCalendar
    }

    return (
        <ProfileCalendar {...propsData}/>
    )
}

export default ProfileCalendarContainer