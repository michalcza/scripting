import PySimpleGUI as sg      

layout = [[sg.Text('This will convert CSV to fixed width ASCII text file')],
                           [sg.Text('_' * 80)],
                           [sg.Text('Left border character', size=(30, 1)), sg.InputText('|', size=(1, 1), key='left_border')],
                           [sg.Text('Right border character', size=(30, 1)), sg.InputText('|', size=(1, 1))],
                           [sg.Text('Top border character', size=(30, 1)), sg.InputText('#', size=(1, 1))],
                           [sg.Text('Bottom border character', size=(30, 1)), sg.InputText('=', size=(1, 1))],
                           [sg.Text('Header separator character', size=(30, 1)), sg.InputText('#', size=(1, 1))],
                           [sg.Text('Row separator character', size=(30, 1)), sg.InputText('-', size=(1, 1))],
                           [sg.Text('Intersection character', size=(30, 1)), sg.InputText('+', size=(1, 1))],
                           [sg.Text('Column separator character', size=(30, 1)), sg.InputText(':', size=(1, 1))],
                           [sg.Text('Table Width', size=(15, 1)),
                            sg.Spin(values=[i for i in range(1, 500)], initial_value=100, size=(3, 1)),
                            sg.Text('Cell Padding', size=(18, 1)),
                            sg.Spin(values=[i for i in range(1, 10)], initial_value=2, size=(2, 1))],
                           [sg.Text('_' * 80)],
                           [sg.Text('CSV to open')],
                           [sg.In(), sg.FileBrowse()],
                           [sg.Open(), sg.Cancel()]]

window = sg.Window('Window Title', layout)

event, values = window.read()
window.close()

print(values)
#left_border = values['left_border']
sg.popup('You entered', values['left_border'])
