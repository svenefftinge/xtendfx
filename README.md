XtendFX
=======

XtendFX is a little library making JavaFX programming in Java and Xtend a joy.
Here's the typical [JavaFX hello world](http://docs.oracle.com/javafx/2/get_started/hello_world.htm) written in Xtend :

```xtend
@FXApp class HelloWorldXtend {
  override void start(Stage it) {
    title = "Hello World!"
    scene = new Scene(new StackPane => [
      children += new Button => [
        text = "Say 'Hello World'"
        onAction = [
          println("Hello World!")
        ]
      ]
    ], 300, 250)
    show
  }
}
```

The annotation @FXApp will make the class extend ```javafx.application.Application``` and adds 
a main method. The operator ```=>``` lets you pass lambda expressions (the blocks in square brackets) to an expression. With a constructor this makes for a nice builder pattern. Lambdas are also handy listener for events (see ```onAction```).

Note that besides ```@FXApp``` this is just raw JavaFX + Xtend. Let's see how XtendFX can improve on that.

FX Beans
========

Writing JavaFX conformant java beans is super tedious: You need to [declare two fields 
and three methods per property](http://blog.netopyr.com/2011/05/19/creating-javafx-properties/)!
With XtendFX you can use the ```@FXBindable``` annotation and get the boilerplate eliminated automatically:

```xtend
/**
 * A login bean written in Xtend.
 */
@FXBindable class LoginBeanXtend {
  String userName = ""
	String password
}
```

XtendFX already supports readonly and lazy properties, but it's also very easy to build your own active annotation and make it tailored to your specific needs. See [active annotations](http://www.eclipse.org/xtend/documentation.html#activeAnnotations).

Data Binding
============

The JavaFX databinding framework is awesome but programming it with Java a real pain. XtendFX let's you
replace the following Java:

```java
// JAVA CODE!
startButton.disableProperty().bind(anim.statusProperty().isNotEqualTo(Animation.Status.STOPPED));
pauseButton.disableProperty().bind(anim.statusProperty().isNotEqualTo(Animation.Status.RUNNING));
resumeButton.disableProperty().bind(anim.statusProperty().isNotEqualTo(Animation.Status.PAUSED));
stopButton.disableProperty().bind(anim.statusProperty().isEqualTo(Animation.Status.STOPPED));
```

with this :

```xtend
startButton.disableProperty  -> (anim.statusProperty != STOPPED)
pauseButton.disableProperty  -> (anim.statusProperty != RUNNING)
resumeButton.disableProperty -> (anim.statusProperty != PAUSED)
stopButton.disableProperty   -> (anim.statusProperty == STOPPED)
```

this only needs the correct ```static extension```:

```xtend
import static extension xtendfx.beans.binding.BindingExtensions.*
```

More Examples
=============

Here's the full code the three small examples:

 - "Hello World " [Java](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/helloworld/HelloWorldJava.java) [Xtend](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/helloworld/HelloWorldXtend.xtend)
 - "Metronome   " [Java](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/metronome/MetronomeTransitionJava.java) [Xtend](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/metronome/MetronomeTransitionXtend.xtend)
 - "Login Screen" [Java](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/login/LoginScreenJava.java) [Xtend](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/login/LoginScreenXtend.xtend)
 - "Login Bean  " [Java](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/login/LoginBeanJava.java) [Xtend](https://github.com/svenefftinge/xtendfx/blob/master/my.javafx.application/src/login/LoginBeanXtend.xtend)

Btw. we are looking for creative and smart people who want to join the party!
=============================================================================
