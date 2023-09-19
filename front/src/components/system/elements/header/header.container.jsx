import { useLocation, useNavigate, useParams } from "react-router"
import Header from "./header"
import { useEffect, useState } from "react"

const HeaderContainer = (props) => {

    const navigate = useNavigate()
    const params = useParams()
    const location = useLocation()

    const [searchDropdown, setSearchDropdown] = useState(false)
    const searchToggle = () => setSearchDropdown(!searchDropdown)

    const [notifDropdown, setNotifDropdown] = useState(false)
    const notifToggle = () => setNotifDropdown(!notifDropdown)

    const [searchValue, setSearchValue] = useState('')

    const onValueChange = (event) => {

        const value = event.target.value
        setSearchValue(value)

    }

    const goToProfile = () => {
        navigate('/profile')
    }

    const goToCatalog = () => {
        navigate('/recommendations')
    }

    const goToFavorities = () => {
        navigate('/favourites/goods')
    }

    const goToBasket = () => {
        navigate('/basket')
    }

    const findProduct = () => {
        if (searchValue !== '') {
            navigate(`/found-products/${searchValue}`)
        }
    }

    useEffect(
        () => {

            const path = location.pathname

            if (path.indexOf('found-products/') !== -1) {

                const request = params.request
                setSearchValue(request)

            }

            document.addEventListener('click', (event) => {

                const id = event.target.id

                switch (id) {
                    case 'search-line':
                        if (searchDropdown === false) {
                            searchToggle()
                            setNotifDropdown(false)
                        }
                        break
                    case 'notif-target':
                        if (notifDropdown === false) {
                            notifToggle()
                            setSearchDropdown(false)
                        }
                        break
                    default:
                        setSearchDropdown(false)
                        setNotifDropdown(false)
                        // searchToggle()
                        break
                }

            })
        }, []
    )

    const propsData = {
        goToProfile,
        goToCatalog,
        goToFavorities,
        goToBasket,
        searchDropdown,
        notifDropdown,
        searchToggle,
        findProduct,
        searchValue,
        onValueChange
    }

    return (
        <Header {...propsData} />
    )
}

export default HeaderContainer