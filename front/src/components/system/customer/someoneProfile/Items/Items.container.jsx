import { useNavigate } from 'react-router'
import Items from './Items.jsx'

const ItemsContainer = (props) => {

    const navigate = useNavigate()

    const goToGood = (id) => {

        navigate(`/product/${id}`)

    }

    const propsData = {
        item: props.item,
        goToGood
    }

    return (
        <Items {...propsData}/>
    )
}

export default ItemsContainer