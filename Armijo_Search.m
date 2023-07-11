function [Next_move_step_W,Next_move_step_Theta,k] = Armijo_Search(move_step_W,move_step_Theta,gamma,k,k_bound)
Next_move_step_W=move_step_W*(gamma^k);
Next_move_step_Theta=move_step_Theta*(gamma^k);
end

