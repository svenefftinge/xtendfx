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
			import java.util.Currency
			
			@FXBean class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency;
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
			import java.util.Currency
			
			@FXBean class MyBean {
				String stringTypeWithDefault = ""
				String StringType
				boolean booleanType
				Currency currency
			}
		'''.assertCompilesTo('''
			import java.util.Currency;
			import javafx.beans.property.SimpleBooleanProperty;
			import javafx.beans.property.SimpleObjectProperty;
			import javafx.beans.property.SimpleStringProperty;
			import xtendfx.properties.FXBean;
			
			@FXBean
			@SuppressWarnings("all")
			public class MyBean {
			  private Currency currency;
			  
			  private static String DEFAULT_STRINGTYPEWITHDEFAULT = "";
			  
			  private SimpleStringProperty stringTypeWithDefaultProperty;
			  
			  public String getStringTypeWithDefault() {
			    return (this.stringTypeWithDefaultProperty != null)? this.stringTypeWithDefaultProperty.get() : DEFAULT_STRINGTYPEWITHDEFAULT;
			    
			  }
			  
			  public void setStringTypeWithDefault(final String stringTypeWithDefault) {
			    this.stringTypeWithDefaultProperty().set(stringTypeWithDefault);
			    
			  }
			  
			  public SimpleStringProperty stringTypeWithDefaultProperty() {
			    if (this.stringTypeWithDefaultProperty == null) { 
			    	this.stringTypeWithDefaultProperty = new SimpleStringProperty(this, "stringTypeWithDefault", DEFAULT_STRINGTYPEWITHDEFAULT);
			    }
			    return this.stringTypeWithDefaultProperty;
			    
			  }
			  
			  private static String DEFAULT_STRINGTYPE;
			  
			  private SimpleStringProperty StringTypeProperty;
			  
			  public String getStringType() {
			    return (this.StringTypeProperty != null)? this.StringTypeProperty.get() : DEFAULT_STRINGTYPE;
			    
			  }
			  
			  public void setStringType(final String StringType) {
			    this.StringTypeProperty().set(StringType);
			    
			  }
			  
			  public SimpleStringProperty StringTypeProperty() {
			    if (this.StringTypeProperty == null) { 
			    	this.StringTypeProperty = new SimpleStringProperty(this, "StringType", DEFAULT_STRINGTYPE);
			    }
			    return this.StringTypeProperty;
			    
			  }
			  
			  private static boolean DEFAULT_BOOLEANTYPE;
			  
			  private SimpleBooleanProperty booleanTypeProperty;
			  
			  public boolean getBooleanType() {
			    return (this.booleanTypeProperty != null)? this.booleanTypeProperty.get() : DEFAULT_BOOLEANTYPE;
			    
			  }
			  
			  public void setBooleanType(final boolean booleanType) {
			    this.booleanTypeProperty().set(booleanType);
			    
			  }
			  
			  public SimpleBooleanProperty booleanTypeProperty() {
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
			  
			  public SimpleObjectProperty<Currency> currencyProperty() {
			    if (this.currencyProperty == null) { 
			    	this.currencyProperty = new SimpleObjectProperty<Currency>(this, "currency", this.currency);
			    }
			    return this.currencyProperty;
			    
			  }
			}
		''')
	}
}