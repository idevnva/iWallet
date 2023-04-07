//  AddCategory.swift

import SwiftUI

struct AddCategory: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedType: CategoryType = .expense
    @State private var name: String = ""
    @State private var selectedImage: String = "folder.circle"
    @State private var selectedColor: String = "colorBlue"
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: selectedImage)
                                .foregroundColor(Color(.black))
                                .font(.system(size: 50))
                                .frame(width: 100, height: 100)
                                .background(Color(selectedColor))
                                .cornerRadius(10)
                            Spacer()
                        } .padding(.bottom, 15)
                        
                        Section {
                            VStack(alignment: .leading) {
                                Picker("CategoryType", selection: $selectedType) {
                                    Text("Расход").tag(CategoryType.expense)
                                    Text("Доход").tag(CategoryType.income)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                                .padding(.bottom, 15)
                            }
                        } header: {
                            Text("Введите тип:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        
                        Section {
                            VStack(alignment: .leading) {
                                TextField("Название", text: $name)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color("colorBalanceBG"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 15)
                            }
                        } header: {
                            Text("Введите название:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        Section {
                            IconPicker(selectedImage: $selectedImage)
                                .foregroundColor(Color(.black))
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                                .padding(.bottom, 15)
                        } header: {
                            Text("Выберете иконку:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        Section {
                            ColorPicker(selectedColor: $selectedColor)
                                .padding(5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                            
                        } header: {
                            Text("Выберете цвет:")
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                }
            }
            .background(Color("colorBG"))
            .navigationBarTitle("Создание категории", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveCategory(name: name, icon: selectedImage, color: selectedColor, type: selectedType)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
            }
        }
    }
}

struct AddCategory_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SceneViewModel()
        
        AddCategory()
            .environmentObject(viewModel)
    }
}
