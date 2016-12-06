classdef KinematicDof < Kinematics
    % Defines a single degrees of freedom (rigid joints) of the model
    % as kinematic constraints.
    % 
    %
    % @author Ayonga Hereid @date 2016-09-23
    % 
    % Copyright (c) 2016, AMBER Lab
    % All right reserved.
    %
    % Redistribution and use in source and binary forms, with or without
    % modification, are permitted only in compliance with the BSD 3-Clause 
    % license, see
    % http://www.opensource.org/licenses/bsd-license.php
    
    properties (SetAccess=protected, GetAccess=public)
        
        % the index of dof in the list of model.dofs
        %
        % @type cellstr
        DofIndex
        
        
    end % properties
    
    
    methods
        
        function obj = KinematicDof(name, model, dof_name, varargin)
            % The constructor function
            %
            % Parameters:
            %  name: a string that will be used to represent this
            %  constraints in Mathematica @type char           
            %  model: the rigid body model @type RigidBodyModel
            %  dof_name: the name of the coordinate @type char
            
            obj = obj@Kinematics(name, varargin{:});
            
            % the dimension is always 1
            obj.Dimension = 1;
            
            if nargin > 1
                
                obj.DofIndex = getDofIndices(model, dof_name);
                
                assert(~isnan(obj.DofIndex),'KinematicDof:invalidDoF',...
                    'The input DoF name is not found: %s',dof_name);
            end
            
            % check if DoF names contains invalid characters
            
            % if (~isempty(regexp(dofs_name, '_', 'once')) || ~isempty(regexp(dofs_name, '\W', 'once')))
            %     err_msg = ['The DoF (joint) name can NOT contain ''_'' or special characters.\n',...
            %         '%s type of constraints cannot be established for the current model.\n',...
            %         'To use it this class definition, please change the joint names in the URDF file, \n',...
            %         'such that names does not contains underscores or other special characters.\n',...
            %         'Here is the list of current joint names: \n %s'];
            %
            %     error('Kinematics:invalidSymbol', err_msg, class(obj), implode(dofs_name,','));
            % end
            
            
            
            
        end
        
        
        
        
    end % methods
    
    
    methods (Access = protected)
        
        function cmd = getKinMathCommand(obj)
            % This function returns he Mathematica command to compile the
            % symbolic expression for the kinematic constraint.
            
            % command for joint dofs
            cmd = ['ComputeJointConstraint[',num2str(obj.DofIndex),']'];
        end
        
        % use default function
        % function cmd = getJacMathCommand(obj)
        % end
        
        % use default function
        % function cmd = getJacDotMathCommand(obj)
        % end
        
        
    end % private methods
    
end % classdef
