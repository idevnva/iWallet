//  AddCategory.swift

import SwiftUI

struct AddCategory: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedType: CategoryType = .expense
    @State private var name: String = ""
    @State private var selectedImage: String = "folder.circle"
    @State private var selectedColor: String = "colorBlue"
    
    private let selectTypeLocalized: LocalizedStringKey = "Select type:"
    private let nameLocaLocalized: LocalizedStringKey = "Name"
    private let enterNameLocalized: LocalizedStringKey = "Enter Name"
    private let chooseAnIconLocalized: LocalizedStringKey = "Choose an icon:"
    private let chooseColorLocalized: LocalizedStringKey = "Choose color:"
    private let createACategoryLocalized: LocalizedStringKey = "Create a category"
    private let backLocalized: LocalizedStringKey = "Back"
    private let addLocalized: LocalizedStringKey = "Add"
    
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
                                .cornerRadius(25)
                            Spacer()
                        } .padding(.bottom, 15)
                        
                        Section {
                            VStack(alignment: .leading) {
                                Picker("Type", selection: $selectedType) {
                                    ForEach(CategoryType.allCases, id: \.self) { type in
                                        Text(type.localizedName)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("colorBalanceBG"))
                                .cornerRadius(10)
                                .padding(.bottom, 15)
                            }
                        } header: {
                            Text(selectTypeLocalized)
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                        
                        Section {
                            VStack(alignment: .leading) {
                                TextField(nameLocaLocalized, text: $name)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color("colorBalanceBG"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 15)
                            }
                        } header: {
                            Text(enterNameLocalized)
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
                            Text(chooseAnIconLocalized)
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
                            Text(chooseColorLocalized)
                                .font(.caption).textCase(.uppercase)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                }
            }
            .background(Color("colorBG"))
            .navigationBarTitle(createACategoryLocalized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text(backLocalized)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveCategory(name: name, icon: selectedImage, color: selectedColor, type: selectedType)
                        dismiss()
                    } label: {
                        Text(addLocalized)
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
