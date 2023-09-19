import Styles from './BudgetModal.module.css'
import { Form, Input, Modal, ModalBody, ModalHeader } from 'reactstrap'

const BudgetModal = (props) => {

    return (
        <Modal isOpen={props.flag} toggle={props.close} centered>
            <ModalHeader>Пополнение счёта</ModalHeader>
            <ModalBody>
                <Form className={`${Styles.form}`} onSubmit={(event)=>{
                    props.onSubmit(event)
                }}>
                    <Input type='number' placeholder='Сумма пополнения' value={props.budget}
                            onChange={props.addBudget}/>
                    <Input type='submit' value={'Пополнить'} />
                </Form>
            </ModalBody>
        </Modal>
    )

}

export default BudgetModal