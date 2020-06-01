import { getControllerSearchProps } from 'foremanReact/constants';

export const TASKS_TABLE_ID = 'TASKS_TABLE';

export const SELECT_ROWS = 'SELECT_ROWS';
export const UNSELECT_ROWS = 'UNSELECT_ROWS';
export const UNSELECT_ALL_ROWS = 'UNSELECT_ALL_ROWS';
export const SELECT_ALL_ROWS = 'SELECT_ALL_ROWS';
export const OPEN_SELECT_ALL = 'OPEN_SELECT_ALL';

export const BULK_CANCEL_ACTION = 'bulk_cancel';
export const BULK_RESUME_ACTION = 'bulk_resume';

export const CANCEL_MODAL = 'cancelConfirmModal';
export const RESUME_MODAL = 'resumeConfirmModal';
export const CANCEL_SELECTED_MODAL = 'cancelSelectedConfirmModal';
export const RESUME_SELECTED_MODAL = 'resumeSelectedConfirmModal';
export const CONFIRM_MODAL = 'ConfirmModal';

export const UPDATE_CLICKED = 'UPDATE_CLICKED';
export const UPDATE_MODAL = 'UPDATE_MODAL';

export const TASKS_SEARCH_PROPS = {
  ...getControllerSearchProps('tasks'),
  controller: 'foreman_tasks_tasks',
};
