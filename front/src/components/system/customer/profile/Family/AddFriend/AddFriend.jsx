import Styles from './AddFriend.module.css'
import { Input, ModalBody, ModalHeader, Modal, Form } from 'reactstrap'

const AddFriend = (props) => {

    return (
        <Modal isOpen={props.flag} toggle={props.close} centered>
            <ModalHeader>Добавление близкого человека</ModalHeader>
            <ModalBody>
                <Form className={`${Styles.form}`}>
                    <Input type='email' placeholder='Почта' />
                    <Input type='submit' value={'Добавить друга'} />
                </Form>
            </ModalBody>
        </Modal>
    )

}

export default AddFriend