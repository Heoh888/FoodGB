//
//  Publishers.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 21.10.2022.
//

import Combine
import SwiftUI

// MARK: - Publishers
extension Publishers {

    /// Оборачивает издателя высоты клавиатуры в пространстве имен `Publishers`.
    /// Издатель имеет два типа – `CGFloat и Never`, что означает, что он
    /// выдает значения типа `CGFloat` и никогда не может завершиться ошибкой.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {

        /// Оборачивает `willShow` и `willHide` уведомления в издателях.
        /// Всякий раз, когда центр уведомлений транслирует уведомление `willShow` или `willHide`,
        /// соответствующий издатель также выдает уведомление в качестве своего значения.
        /// Мы также используем оператор `map`, поскольку нас интересует только высота клавиатуры.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        /// Объединяет несколько издателей в один, объединив их исходящие значения.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

// MARK: - Notification
extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)!.height -  90
    }
}

// MARK: - View
extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
