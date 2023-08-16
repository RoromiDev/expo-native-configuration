import ExpoNativeConfigurationModule from './ExpoNativeConfigurationModule';

export function getApiKey(): string {
  return ExpoNativeConfigurationModule.getApiKey();
}

export function payWithApplePay({ merchantId }): any {
  ExpoNativeConfigurationModule.payWithApplePay(merchantId)
}