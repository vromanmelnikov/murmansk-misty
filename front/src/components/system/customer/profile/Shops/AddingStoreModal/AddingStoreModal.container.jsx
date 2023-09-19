import { useDispatch, useSelector } from 'react-redux'
import AddingStoreModal from './AddingStoreModal.jsx'
import { changeAddStore } from '../../../../../../store/modalSlice.js'

const AddingStoreModalContainer = (props) => {

    const dispatch = useDispatch()

    const flag = useSelector(state => state.modal.addStore)

    const close = () => {
        dispatch(changeAddStore())
    }

    const propsData = {
        flag,
        close
    }

    return (
        <AddingStoreModal {...propsData}/>
    )
}

export default AddingStoreModalContainer