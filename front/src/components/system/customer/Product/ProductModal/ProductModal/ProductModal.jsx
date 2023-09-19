import Styles from './ProductModal.module.css'
import { Form, Input, Modal, ModalBody, ModalHeader } from 'reactstrap'

const ProductModal = (props) => {

    return (
        <Modal isOpen={props.flag} toggle={props.close} centered>
            <ModalHeader>Бронирование</ModalHeader>
            <ModalBody>
                <Form className={`${Styles.form}`} onSubmit={
                    (event) => {
                        props.submit(event)
                        
                    }
                    
                }>
                    <Input type='time' placeholder='Время доставки' value={props.date} onChange={props.addBooking} name='time'/>
                    <Input type='date' placeholder='Дата доставки доставки' value={props.booking.name} onChange={props.addBooking} name='date'/>
                    <Input type='submit' value={'Забронировать'} />
                </Form>
            </ModalBody>
        </Modal>
    )

}

export default ProductModal