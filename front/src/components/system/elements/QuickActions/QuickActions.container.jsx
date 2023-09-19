import { useState } from 'react'
import QuickActions from './QuickActions.jsx'

const QuickActionsContainer = (props) => {

    const [isOpen, setIsOpen] = useState(false)
    const toggle = () => setIsOpen(!isOpen)

    const propsData = {
        isOpen,
        toggle
    }

    return (
        <QuickActions {...propsData}/>
    )
}

export default QuickActionsContainer