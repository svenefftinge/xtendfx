package xtendfx.properties

import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy

@Retention(RetentionPolicy::RUNTIME)
annotation Immutable { 
	boolean test = true;
}