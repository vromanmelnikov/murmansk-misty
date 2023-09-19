import { useEffect } from 'react'
import Catalog from './Catalog.jsx'

const CatalogContainer = (props) => {

    useEffect(
        () => {
            window.document.title = 'Каталог'
        }
    )

    const propsData = {

    }

    return (
        <Catalog {...propsData}/>
    )
}

export default CatalogContainer