package xtendfx.properties

import java.lang.reflect.Modifier
import javafx.beans.property.SimpleStringProperty
import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester
import org.junit.Test

import static org.junit.Assert.*

class FxBeanTest {
	
	static extension XtendCompilerTester compiler = XtendCompilerTester::newXtendCompilerTester(typeof(FXBean), typeof(SimpleStringProperty))
	
	@Test def testAgainstCompiledClass() {
		'''
			import xtendfx.properties.FXBean
			import xtendfx.properties.FXProperty
			import java.util.Currency
			
			@FXBean class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency
				@FXProperty(readonly=true) Currency currencyReadOnly
			}
		'''.compile [
			compiledClass.getDeclaredField("stringTypeWithDefaultProperty") => [
				assertEquals(typeof(SimpleStringProperty), type)
				assertTrue(Modifier::isPrivate(modifiers))
			]
		]
	}
	
	@Test def testAgainstJavaSource() {
		'''
			import xtendfx.properties.FXBean
			import xtendfx.properties.FXProperty
			import java.util.Currency
			
			@FXBean class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency
				@FXProperty(readonly=true) Currency currencyReadOnly
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.BooleanProperty;
			import javafx.beans.property.ObjectProperty;
			import javafx.beans.property.ReadOnlyObjectProperty;
			import javafx.beans.property.ReadOnlyObjectWrapper;
			import javafx.beans.property.SimpleBooleanProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import javafx.beans.property.SimpleStringProperty;
			import javafx.beans.property.StringProperty;
			import xtendfx.properties.FXBean;
			import xtendfx.properties.FXProperty;
			
			@FXBean
			@SuppressWarnings("all")
			public class MyBean {
			  private Currency currency;
			  
			  @FXProperty(readonly = true)
			  private Currency currencyReadOnly;
			  
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
			  
			  private ReadOnlyObjectWrapper<Currency> currencyReadOnlyProperty;
			  
			  public Currency getCurrencyReadOnly() {
			    return (this.currencyReadOnlyProperty != null)? this.currencyReadOnlyProperty.get() : this.currencyReadOnly;
			    
			  }
			  
			  public ReadOnlyObjectProperty<Currency> currencyReadOnlyProperty() {
			    if (this.currencyReadOnlyProperty == null) { 
			    	this.currencyReadOnlyProperty = new ReadOnlyObjectWrapper<Currency>(this, "currencyReadOnly", this.currencyReadOnly);
			    }
			    return this.currencyReadOnlyProperty.getReadOnlyProperty();
			    
			  }
			}
		''')
	}
}