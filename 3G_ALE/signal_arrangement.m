function [ Iarr , Qarr ] = signal_arrangement( Imat , Qmat , signal_type )

switch signal_type
    case 1
        Iarr = Imat(17:end-18);
        Qarr = Qmat(19:end-16);
    otherwise
        Iarr = Imat(17:end-16);
        Qarr = Qmat(17:end-16);
end


end

