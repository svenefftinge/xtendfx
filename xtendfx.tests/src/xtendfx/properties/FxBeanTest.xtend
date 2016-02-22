package xtendfx.properties

import java.lang.reflect.Modifier
import javafx.beans.property.SimpleStringProperty
import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester
import org.eclipse.xtext.xbase.lib.Functions.Function0
import org.junit.Test
import xtendfx.beans.FXBindable

import static org.junit.Assert.*

class FXBindableTest {
	
	static extension XtendCompilerTester compiler = XtendCompilerTester.newXtendCompilerTester(FXBindable, ValueObject, SimpleStringProperty, Function0)
	
	@Test def testAgainstCompiledClass() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.beans.Readonly
			import xtendfx.beans.NoneLazy
			import java.util.Currency
			import xtendfx.properties.ValueObject
			
			@FXBindable class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency
				@Readonly Currency currencyReadOnly = Currency.getInstance("EUR")
				@NoneLazy Currency currencyGreedy = Currency.getInstance("EUR")
				ValueObject valueObject
			}
		'''.compile [
			compiledClass.getDeclaredField("stringTypeWithDefaultProperty") => [
				assertEquals(SimpleStringProperty, type)
				assertTrue(Modifier.isPrivate(modifiers))
			]
		]
	}
	
	@Test def testImmutablePropertyAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.properties.ValueObject
			
			@FXBindable class MyBean {
				ValueObject value
			}
		'''.assertCompilesTo('''
			import javafx.beans.property.ObjectProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import xtendfx.beans.FXBindable;
			import xtendfx.properties.ValueObject;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  private final static ValueObject DEFAULT_VALUE = null;
			  
			  private SimpleObjectProperty<ValueObject> valueProperty;
			  
			  public ValueObject getValue() {
			    return (this.valueProperty != null)? this.valueProperty.get() : DEFAULT_VALUE;
			  }
			  
			  public void setValue(final ValueObject value) {
			    this.valueProperty().set(value);
			  }
			  
			  public ObjectProperty<ValueObject> valueProperty() {
			    if (this.valueProperty == null) { 
			    	this.valueProperty = new SimpleObjectProperty<ValueObject>(this, "value", DEFAULT_VALUE);
			    }
			    return this.valueProperty;
			  }
			}
		''');
	}
	
	@Test def testDataPropertyAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.properties.DataObject
			
			@FXBindable class MyBean {
				DataObject value
			}
		'''.assertCompilesTo('''
			import javafx.beans.property.ObjectProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import xtendfx.beans.FXBindable;
			import xtendfx.properties.DataObject;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  private final static DataObject DEFAULT_VALUE = null;
			  
			  private SimpleObjectProperty<DataObject> valueProperty;
			  
			  public DataObject getValue() {
			    return (this.valueProperty != null)? this.valueProperty.get() : DEFAULT_VALUE;
			  }
			  
			  public void setValue(final DataObject value) {
			    this.valueProperty().set(value);
			  }
			  
			  public ObjectProperty<DataObject> valueProperty() {
			    if (this.valueProperty == null) { 
			    	this.valueProperty = new SimpleObjectProperty<DataObject>(this, "value", DEFAULT_VALUE);
			    }
			    return this.valueProperty;
			  }
			}
		''');
	}
	
	@Test def testForcedImmutablePropertyAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.beans.Readonly
			import xtendfx.beans.Immutable
			import java.util.Currency
			
			@FXBindable class MyBean {
				@Readonly @Immutable Currency currency
				@Readonly @Immutable Currency currencyWithDefault = Currency.getInstance("EUR")
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.ReadOnlyObjectProperty;
			import javafx.beans.property.ReadOnlyObjectWrapper;
			import xtendfx.beans.FXBindable;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  private final static Currency DEFAULT_CURRENCY = null;
			  
			  private ReadOnlyObjectWrapper<Currency> currencyProperty;
			  
			  public Currency getCurrency() {
			    return (this.currencyProperty != null)? this.currencyProperty.get() : DEFAULT_CURRENCY;
			  }
			  
			  public ReadOnlyObjectProperty<Currency> currencyProperty() {
			    if (this.currencyProperty == null) { 
			    	this.currencyProperty = new ReadOnlyObjectWrapper<Currency>(this, "currency", DEFAULT_CURRENCY);
			    }
			    return this.currencyProperty.getReadOnlyProperty();
			  }
			  
			  private final static Currency DEFAULT_CURRENCYWITHDEFAULT = Currency.getInstance("EUR");
			  
			  private ReadOnlyObjectWrapper<Currency> currencyWithDefaultProperty;
			  
			  public Currency getCurrencyWithDefault() {
			    return (this.currencyWithDefaultProperty != null)? this.currencyWithDefaultProperty.get() : DEFAULT_CURRENCYWITHDEFAULT;
			  }
			  
			  public ReadOnlyObjectProperty<Currency> currencyWithDefaultProperty() {
			    if (this.currencyWithDefaultProperty == null) { 
			    	this.currencyWithDefaultProperty = new ReadOnlyObjectWrapper<Currency>(this, "currencyWithDefault", DEFAULT_CURRENCYWITHDEFAULT);
			    }
			    return this.currencyWithDefaultProperty.getReadOnlyProperty();
			  }
			}
		''');
	}
	
	@Test def testReadOnlyPropertyAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.beans.Readonly
			import java.util.Currency
			
			@FXBindable class MyBean {
				@Readonly String stringType
				@Readonly String stringTypeWithDefault = ""
				@Readonly boolean booleanType
				@Readonly boolean booleanTypeWithDefault
				@Readonly Currency currency
				@Readonly Currency currencyWithDefault = Currency.getInstance("EUR")
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.ReadOnlyBooleanProperty;
			import javafx.beans.property.ReadOnlyBooleanWrapper;
			import javafx.beans.property.ReadOnlyObjectProperty;
			import javafx.beans.property.ReadOnlyObjectWrapper;
			import javafx.beans.property.ReadOnlyStringProperty;
			import javafx.beans.property.ReadOnlyStringWrapper;
			import xtendfx.beans.FXBindable;
			import xtendfx.beans.Readonly;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  @Readonly
			  private Currency currency;
			  
			  @Readonly
			  private Currency currencyWithDefault = Currency.getInstance("EUR");
			  
			  private final static String DEFAULT_STRINGTYPE = null;
			  
			  private ReadOnlyStringWrapper stringTypeProperty;
			  
			  public String getStringType() {
			    return (this.stringTypeProperty != null)? this.stringTypeProperty.get() : DEFAULT_STRINGTYPE;
			  }
			  
			  public ReadOnlyStringProperty stringTypeProperty() {
			    if (this.stringTypeProperty == null) { 
			    	this.stringTypeProperty = new ReadOnlyStringWrapper(this, "stringType", DEFAULT_STRINGTYPE);
			    }
			    return this.stringTypeProperty.getReadOnlyProperty();
			  }
			  
			  private final static String DEFAULT_STRINGTYPEWITHDEFAULT = "";
			  
			  private ReadOnlyStringWrapper stringTypeWithDefaultProperty;
			  
			  public String getStringTypeWithDefault() {
			    return (this.stringTypeWithDefaultProperty != null)? this.stringTypeWithDefaultProperty.get() : DEFAULT_STRINGTYPEWITHDEFAULT;
			  }
			  
			  public ReadOnlyStringProperty stringTypeWithDefaultProperty() {
			    if (this.stringTypeWithDefaultProperty == null) { 
			    	this.stringTypeWithDefaultProperty = new ReadOnlyStringWrapper(this, "stringTypeWithDefault", DEFAULT_STRINGTYPEWITHDEFAULT);
			    }
			    return this.stringTypeWithDefaultProperty.getReadOnlyProperty();
			  }
			  
			  private final static boolean DEFAULT_BOOLEANTYPE = false;
			  
			  private ReadOnlyBooleanWrapper booleanTypeProperty;
			  
			  public boolean getBooleanType() {
			    return (this.booleanTypeProperty != null)? this.booleanTypeProperty.get() : DEFAULT_BOOLEANTYPE;
			  }
			  
			  public ReadOnlyBooleanProperty booleanTypeProperty() {
			    if (this.booleanTypeProperty == null) { 
			    	this.booleanTypeProperty = new ReadOnlyBooleanWrapper(this, "booleanType", DEFAULT_BOOLEANTYPE);
			    }
			    return this.booleanTypeProperty.getReadOnlyProperty();
			  }
			  
			  private final static boolean DEFAULT_BOOLEANTYPEWITHDEFAULT = false;
			  
			  private ReadOnlyBooleanWrapper booleanTypeWithDefaultProperty;
			  
			  public boolean getBooleanTypeWithDefault() {
			    return (this.booleanTypeWithDefaultProperty != null)? this.booleanTypeWithDefaultProperty.get() : DEFAULT_BOOLEANTYPEWITHDEFAULT;
			  }
			  
			  public ReadOnlyBooleanProperty booleanTypeWithDefaultProperty() {
			    if (this.booleanTypeWithDefaultProperty == null) { 
			    	this.booleanTypeWithDefaultProperty = new ReadOnlyBooleanWrapper(this, "booleanTypeWithDefault", DEFAULT_BOOLEANTYPEWITHDEFAULT);
			    }
			    return this.booleanTypeWithDefaultProperty.getReadOnlyProperty();
			  }
			  
			  private ReadOnlyObjectWrapper<Currency> currencyProperty;
			  
			  public Currency getCurrency() {
			    return (this.currencyProperty != null)? this.currencyProperty.get() : this.currency;
			  }
			  
			  public ReadOnlyObjectProperty<Currency> currencyProperty() {
			    if (this.currencyProperty == null) { 
			    	this.currencyProperty = new ReadOnlyObjectWrapper<Currency>(this, "currency", this.currency);
			    }
			    return this.currencyProperty.getReadOnlyProperty();
			  }
			  
			  private ReadOnlyObjectWrapper<Currency> currencyWithDefaultProperty;
			  
			  public Currency getCurrencyWithDefault() {
			    return (this.currencyWithDefaultProperty != null)? this.currencyWithDefaultProperty.get() : this.currencyWithDefault;
			  }
			  
			  public ReadOnlyObjectProperty<Currency> currencyWithDefaultProperty() {
			    if (this.currencyWithDefaultProperty == null) { 
			    	this.currencyWithDefaultProperty = new ReadOnlyObjectWrapper<Currency>(this, "currencyWithDefault", this.currencyWithDefault);
			    }
			    return this.currencyWithDefaultProperty.getReadOnlyProperty();
			  }
			}
		''')
	}
	
	@Test def testNoneLazyPropertyAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import xtendfx.beans.NoneLazy
			import java.util.Currency
			
			@FXBindable class MyBean {
				@NoneLazy String stringType
				@NoneLazy String stringTypeWithDefault = ""
				@NoneLazy boolean booleanType
				@NoneLazy boolean booleanTypeWithDefault
				@NoneLazy Currency currency
				@NoneLazy Currency currencyWithDefault = Currency.getInstance("EUR")
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.BooleanProperty;
			import javafx.beans.property.ObjectProperty;
			import javafx.beans.property.SimpleBooleanProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import javafx.beans.property.SimpleStringProperty;
			import javafx.beans.property.StringProperty;
			import xtendfx.beans.FXBindable;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  private SimpleStringProperty stringTypeProperty = new SimpleStringProperty(this, "stringType");
			  
			  public String getStringType() {
			    return this.stringTypeProperty.get();
			  }
			  
			  public void setStringType(final String stringType) {
			    this.stringTypeProperty.set(stringType);
			  }
			  
			  public StringProperty stringTypeProperty() {
			    return this.stringTypeProperty;
			  }
			  
			  private SimpleStringProperty stringTypeWithDefaultProperty = new SimpleStringProperty(this, "stringTypeWithDefault",_initStringTypeWithDefault());
			  
			  private static final String _initStringTypeWithDefault() {
			    return "";
			  }
			  
			  public String getStringTypeWithDefault() {
			    return this.stringTypeWithDefaultProperty.get();
			  }
			  
			  public void setStringTypeWithDefault(final String stringTypeWithDefault) {
			    this.stringTypeWithDefaultProperty.set(stringTypeWithDefault);
			  }
			  
			  public StringProperty stringTypeWithDefaultProperty() {
			    return this.stringTypeWithDefaultProperty;
			  }
			  
			  private SimpleBooleanProperty booleanTypeProperty = new SimpleBooleanProperty(this, "booleanType");
			  
			  public boolean getBooleanType() {
			    return this.booleanTypeProperty.get();
			  }
			  
			  public void setBooleanType(final boolean booleanType) {
			    this.booleanTypeProperty.set(booleanType);
			  }
			  
			  public BooleanProperty booleanTypeProperty() {
			    return this.booleanTypeProperty;
			  }
			  
			  private SimpleBooleanProperty booleanTypeWithDefaultProperty = new SimpleBooleanProperty(this, "booleanTypeWithDefault");
			  
			  public boolean getBooleanTypeWithDefault() {
			    return this.booleanTypeWithDefaultProperty.get();
			  }
			  
			  public void setBooleanTypeWithDefault(final boolean booleanTypeWithDefault) {
			    this.booleanTypeWithDefaultProperty.set(booleanTypeWithDefault);
			  }
			  
			  public BooleanProperty booleanTypeWithDefaultProperty() {
			    return this.booleanTypeWithDefaultProperty;
			  }
			  
			  private SimpleObjectProperty<Currency> currencyProperty = new SimpleObjectProperty<Currency>(this, "currency");
			  
			  public Currency getCurrency() {
			    return this.currencyProperty.get();
			  }
			  
			  public void setCurrency(final Currency currency) {
			    this.currencyProperty.set(currency);
			  }
			  
			  public ObjectProperty<Currency> currencyProperty() {
			    return this.currencyProperty;
			  }
			  
			  private SimpleObjectProperty<Currency> currencyWithDefaultProperty = new SimpleObjectProperty<Currency>(this, "currencyWithDefault",_initCurrencyWithDefault());
			  
			  private static final Currency _initCurrencyWithDefault() {
			    Currency _instance = Currency.getInstance("EUR");
			    return _instance;
			  }
			  
			  public Currency getCurrencyWithDefault() {
			    return this.currencyWithDefaultProperty.get();
			  }
			  
			  public void setCurrencyWithDefault(final Currency currencyWithDefault) {
			    this.currencyWithDefaultProperty.set(currencyWithDefault);
			  }
			  
			  public ObjectProperty<Currency> currencyWithDefaultProperty() {
			    return this.currencyWithDefaultProperty;
			  }
			}
		''')
	}
	
	@Test def testAgainstJavaSource() {
		'''
			import xtendfx.beans.FXBindable
			import java.util.Currency
			
			@FXBindable class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.BooleanProperty;
			import javafx.beans.property.ObjectProperty;
			import javafx.beans.property.SimpleBooleanProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import javafx.beans.property.SimpleStringProperty;
			import javafx.beans.property.StringProperty;
			import xtendfx.beans.FXBindable;
			
			@FXBindable
			@SuppressWarnings("all")
			public class MyBean {
			  private Currency currency;
			  
			  private final static String DEFAULT_STRINGTYPEWITHDEFAULT = "";
			  
			  private SimpleStringProperty stringTypeWithDefaultProperty;
			  
			  public String getStringTypeWithDefault() {
			    return (this.stringTypeWithDefaultProperty != null)? this.stringTypeWithDefaultProperty.get() : DEFAULT_STRINGTYPEWITHDEFAULT;
			  }
			  
			  public void setStringTypeWithDefault(final String stringTypeWithDefault) {
			    this.stringTypeWithDefaultProperty().set(stringTypeWithDefault);
			  }
			  
			  public StringProperty stringTypeWithDefaultProperty() {
			    if (this.stringTypeWithDefaultProperty == null) { 
			    	this.stringTypeWithDefaultProperty = new SimpleStringProperty(this, "stringTypeWithDefault", DEFAULT_STRINGTYPEWITHDEFAULT);
			    }
			    return this.stringTypeWithDefaultProperty;
			  }
			  
			  private final static String DEFAULT_STRINGTYPE = null;
			  
			  private SimpleStringProperty StringTypeProperty;
			  
			  public String getStringType() {
			    return (this.StringTypeProperty != null)? this.StringTypeProperty.get() : DEFAULT_STRINGTYPE;
			  }
			  
			  public void setStringType(final String StringType) {
			    this.StringTypeProperty().set(StringType);
			  }
			  
			  public StringProperty StringTypeProperty() {
			    if (this.StringTypeProperty == null) { 
			    	this.StringTypeProperty = new SimpleStringProperty(this, "StringType", DEFAULT_STRINGTYPE);
			    }
			    return this.StringTypeProperty;
			  }
			  
			  private final static boolean DEFAULT_BOOLEANTYPE = false;
			  
			  private SimpleBooleanProperty booleanTypeProperty;
			  
			  public boolean getBooleanType() {
			    return (this.booleanTypeProperty != null)? this.booleanTypeProperty.get() : DEFAULT_BOOLEANTYPE;
			  }
			  
			  public void setBooleanType(final boolean booleanType) {
			    this.booleanTypeProperty().set(booleanType);
			  }
			  
			  public BooleanProperty booleanTypeProperty() {
			    if (this.booleanTypeProperty == null) { 
			    	this.booleanTypeProperty = new SimpleBooleanProperty(this, "booleanType", DEFAULT_BOOLEANTYPE);
			    }
			    return this.booleanTypeProperty;
			  }
			  
			  private SimpleObjectProperty<Currency> currencyProperty;
			  
			  public Currency getCurrency() {
			    return (this.currencyProperty != null)? this.currencyProperty.get() : this.currency;
			  }
			  
			  public void setCurrency(final Currency currency) {
			    if (currencyProperty != null) {
			    	this.currencyProperty.set(currency);
			    } else {
			    	this.currency = currency;
			    }
			  }
			  
			  public ObjectProperty<Currency> currencyProperty() {
			    if (this.currencyProperty == null) { 
			    	this.currencyProperty = new SimpleObjectProperty<Currency>(this, "currency", this.currency);
			    }
			    return this.currencyProperty;
			  }
			}
		''')
	}
}