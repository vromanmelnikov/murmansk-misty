import Styles from './Budget.module.css'
import { Button, Card} from "reactstrap"
import BudgetModalContainer from './BudgetModal/BudgetModal.container'
const Budget = (props) => {

    return (
        <Card className={'p-3 mt-3'} >
            <div className={`${Styles.budget}`}><h6 className={`${Styles.budgetText}`}>Бюджет:   {props.user.cash} </h6>
            <Button color='primary' className={`${Styles.button}`} onClick={props.addBudget}>
                Пополнить
            </Button>
            </div>
            <BudgetModalContainer/>
        </Card>
        
    )

}

export default Budget