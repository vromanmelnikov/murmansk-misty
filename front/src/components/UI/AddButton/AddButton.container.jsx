import AddButton from './AddButton.jsx'

const AddButtonContainer = (props) => {

    const propsData = {
        callback: props.callback
    }

    return (
        <AddButton {...propsData}/>
    )
}

export default AddButtonContainer