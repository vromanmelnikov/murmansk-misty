import { useEffect, useState } from 'react'
import Favourites from './Favourites.jsx'
import { useLocation, useNavigate } from 'react-router'

const FavouritesContainer = (props) => {

    const navigate = useNavigate()
    const location = useLocation()

    const selectItems = [
        {
            id: 0,
            value: 'Избранные товары',
            url: '/favourites/goods'
        },
        {
            id: 1,
            value: 'Группы товаров',
            url: '/favourites/groups'
        },
    ]

    const [select, setSelect] = useState(selectItems[0])

    useEffect(
        ()=>{
            
            const path = location.pathname

            if (path === '/favourites/groups') {
                setSelect(selectItems[1])
            }
            else {
                setSelect(selectItems[0])
            }

        }, []
    )

    const onSelectChange = (event) => {

        const value = event.target.value
        setSelect(value)

        const url = selectItems[value].url
        navigate(url)
    }

    const propsData = {
        selectItems,
        select,
        onSelectChange
    }

    return (
        <Favourites {...propsData}/>
    )
}

export default FavouritesContainer