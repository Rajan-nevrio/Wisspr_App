# Wisspr App - Project Guidelines

## 🎯 Development Approach
- **Step-by-step development**: All changes require explicit permission before implementation
- **Plan-driven**: We work according to a structured plan
- **No unauthorized changes**: Nothing gets modified without approval

## 🎨 Design & UI Standards

### Theme Usage
- **MANDATORY**: Use theme colors in every screen where color is needed
- **Consistency**: All UI elements must follow the app's theme system
- **Color Management**: Never hardcode colors - always use `Theme.of(context).colorScheme` or custom theme properties

### Responsive Design
- **Responsive Dimensions**: Use responsive dimensions everywhere for all screen sizes
- **Adaptive Layout**: Ensure the app works perfectly on phones, tablets, and different screen orientations
- **Scalable UI**: All text, spacing, and component sizes should scale appropriately

## ⚡ Performance & User Experience

### Loading States
- **Shimmer Effects**: Implement shimmer/skeleton loading effects for all loading states
- **Smooth Transitions**: Use appropriate loading animations and transitions
- **User Feedback**: Always provide visual feedback during data fetching or processing

### App Performance
- **Optimization**: Focus on making the app faster and more responsive
- **Efficient Rendering**: Use proper widget lifecycle management
- **Memory Management**: Avoid memory leaks and optimize resource usage

## 📱 Responsive Implementation

### Screen Adaptation
- Use `MediaQuery` for screen size detection
- Implement responsive breakpoints for different device types
- Ensure proper scaling across all screen densities

### Layout Guidelines
- Use `Flexible` and `Expanded` widgets appropriately
- Implement proper `SingleChildScrollView` where needed
- Consider different screen orientations

## 🔄 Development Workflow

### Change Management
1. **Propose Changes**: Always explain what needs to be changed and why
2. **Get Permission**: Wait for explicit approval before implementing
3. **Implement**: Make changes only after receiving permission
4. **Test**: Verify changes work as expected
5. **Document**: Update relevant documentation if needed

### Code Quality
- Follow Flutter best practices
- Use proper state management
- Implement proper error handling
- Write clean, maintainable code

## 📋 Current Project Status
- **Project Type**: Flutter Application
- **Current State**: Basic Flutter counter app (default template)
- **Next Steps**: Awaiting specific requirements and permission to proceed

## 🛠️ Technical Stack
- **Framework**: Flutter
- **Language**: Dart
- **Platforms**: Android, iOS, Web, macOS, Linux, Windows
- **State Management**: To be determined based on requirements

---

**Remember**: Every change requires your explicit permission. I will always ask before implementing any modifications to ensure we stay aligned with your vision and requirements.
