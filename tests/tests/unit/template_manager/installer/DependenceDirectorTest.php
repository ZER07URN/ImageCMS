<?php

namespace template_manager\installer;

require_once realpath(dirname(__FILE__) . '/../../../..') . '/enviroment.php';

/**
 * Generated by PHPUnit_SkeletonGenerator 1.2.1 on 2014-04-10 at 11:31:11.
 */
class DependenceDirectorTest extends \PHPUnit_Framework_TestCase {

    /**
     * @var DependenceDirector
     */
    protected $object;
    protected $objectWithoutErrorsMessages;
    protected $dbWidgets;
    protected $dbModules;
    protected $ci;

    /**
     * Sets up the fixture, for example, opens a network connection.
     * This method is called before a test is executed.
     */
    protected function setUp() {
        $this->ci = & get_instance();

        $this->dbWidgets = $this->ci->db->get('widgets')->result_array();
        $this->dbModules = $this->ci->db->get('components')->result_array();

        $xmlFULL = '<?xml version="1.0" encoding="UTF-8"?>
        <dependencies>
            <dependency entityName="module" name="' . $this->dbModules[0]['identif'] . '" type="required"/>
            <dependency entityName="module" name="' . $this->dbModules[1]['identif'] . '" type="wishful"/>
            <dependency entityName="module" name="' . $this->dbModules[2]['identif'] . '" type="add"/>
            <dependency entityName="module" name="notExistingModule1" type="required"/>
            <dependency entityName="module" name="notExistingModule2" type="wishful"/>
            <dependency entityName="module" name="banners" type="add"/>
            <dependency entityName="widget" name="' . $this->dbWidgets[0]['name'] . '" type="required"/> 
            <dependency entityName="widget" name="' . $this->dbWidgets[1]['name'] . '" type="wishful"/> 
            <dependency entityName="widget" name="notExistingWidget1" type="required"/>
            <dependency entityName="widget" name="notExistingWidget2" type="wishful"/>
            <dependency entityName="widget" name="addHTMLWidget" type="add" widgetType="html" locale="en">
                <data>
                   <div>WidgetText</div>
                </data>
            </dependency>
            <dependency entityName="widget" name="addModuleWidget" type="add" widgetType="module" locale="en" module="widgetModule" method="methodName" description="widget description">
                <settings>
                    <setting1>1</setting1>
                    <setting2>2</setting2>
                    <setting3>3</setting3>
                </settings>
            </dependency>
        </dependencies>';

        $xmlWithoutErrorsMessages = '<?xml version="1.0" encoding="UTF-8"?>
        <dependencies>
            <dependency entityName="module" name="' . $this->dbModules[0]['identif'] . '" type="required"/>
            <dependency entityName="module" name="' . $this->dbModules[1]['identif'] . '" type="wishful"/>
            <dependency entityName="module" name="' . $this->dbModules[2]['identif'] . '" type="add"/>
            <dependency entityName="widget" name="' . $this->dbWidgets[0]['name'] . '" type="required"/> 
            <dependency entityName="widget" name="' . $this->dbWidgets[1]['name'] . '" type="wishful"/> 
            <dependency entityName="widget" name="addHTMLWidget" type="add" widgetType="html">
                <data>
                   <div>WidgetText</div>
                </data>
            </dependency>
            <dependency entityName="widget" name="addModuleWidget" type="add" widgetType="module" module="widgetModule" method="methodName" description="widget description">
                <settings>
                    <setting1>1</setting1>
                    <setting2>2</setting2>
                    <setting3>3</setting3>
                </settings>
            </dependency>
        </dependencies>';

        $xmlObject = simplexml_load_string($xmlFULL);

        $this->object = new DependenceDirector($xmlObject);

        $xmlObject = simplexml_load_string($xmlWithoutErrorsMessages);
        $this->objectWithoutErrorsMessages = new DependenceDirector($xmlObject);
    }

    /**
     * Tears down the fixture, for example, closes a network connection.
     * This method is called after a test is executed.
     */
    protected function tearDown() {
        
    }

    /**
     * @covers template_manager\installer\DependenceDirector::verify
     * @todo   Implement testVerify().
     */
    public function testVerify() {
        // Test if result is FALSE when some dependences is required or wishful but not installed
        $result = $this->object->verify();
        $this->assertFalse($result);

        $messages = $this->object->getMessages();
        $this->assertCount(4, $messages);
        foreach ($messages as $message) {
            //Check correct messages array keys
            $this->assertArrayHasKey('text', $message);
            $this->assertArrayHasKey('relation', $message);
            $this->assertArrayHasKey('name', $message);
            $this->assertArrayHasKey('type', $message);

            //Check correct messages array values
            if (in_array('notExistingModule1', $message)) {
                $this->assertContains('notExistingModule1', $message);
                $this->assertContains('required', $message);
                $this->assertContains('module', $message);
            }

            if (in_array('notExistingModule2', $message)) {
                $this->assertContains('notExistingModule2', $message);
                $this->assertContains('wishful', $message);
                $this->assertContains('module', $message);
            }

            if (in_array('notExistingWidget1', $message)) {
                $this->assertContains('notExistingWidget1', $message);
                $this->assertContains('required', $message);
                $this->assertContains('widget', $message);
            }

            if (in_array('notExistingWidget2', $message)) {
                $this->assertContains('notExistingWidget2', $message);
                $this->assertContains('wishful', $message);
                $this->assertContains('widget', $message);
            }
        }

        $this->ci->db->where_in('name', array('addHTMLWidget', 'addModuleWidget'))->delete('widgets');

        /**
         * Check verify method on complete without errors
         */
        $result = $this->objectWithoutErrorsMessages->verify();
        $this->assertTrue($result);
        $this->assertEmpty($this->objectWithoutErrorsMessages->getMessages());
    }

    /**
     * @covers template_manager\installer\DependenceDirector::getMessages
     * @todo   Implement testGetMessages().
     */
    public function testGetMessages() {
        /**
         * Check on not empty returned result
         */
        $this->object->verify();
        $this->assertNotEmpty($this->object->getMessages());
        $this->assertCount(4, $this->object->getMessages());


        /**
         * Check on empty returned result
         */
        $this->objectWithoutErrorsMessages->verify();
        $this->assertTrue(is_array($this->objectWithoutErrorsMessages->getMessages()));
        $this->assertEmpty($this->objectWithoutErrorsMessages->getMessages());
    }

}
