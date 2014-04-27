package animation
{
	import away3d.animators.data.Skeleton;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class SkeletonAnimatorWithBindTag extends SkeletonAnimator
	{
		private var m_exitEvent:Sprite;
		private var _bindingTags:Vector.<BindingTag>;
		
		// 测试代码
		//var bindingTag:BindingTag = animator.addBindingTagByIndex(11);
		//bindingTag.addChild(new Trident(100));
		
		public function SkeletonAnimatorWithBindTag(animationSet:SkeletonAnimationSet, skeleton:Skeleton, forceCPU:Boolean = false) 
		{
			super(animationSet, skeleton, forceCPU);
			m_exitEvent = new Sprite();
		}
		
		override public function start():void
		{
			super.start();

			if(!m_exitEvent.hasEventListener(Event.EXIT_FRAME))
				m_exitEvent.addEventListener(Event.ENTER_FRAME, onExitFrame);
		}
		
		override public function stop():void
		{
			super.stop();
			
			if(m_exitEvent.hasEventListener(Event.EXIT_FRAME))
				m_exitEvent.removeEventListener(Event.EXIT_FRAME, onExitFrame);
		}
		
		/**
         * 绑定至通过名字指定的骨骼上
         * @param boneName
         * @return
         *
         */    
        public function addBindingTagByName(boneName:String):BindingTag
        {
            var boneIndex : int = globalPose.jointPoseIndexFromName(boneName);
            if(boneIndex<0)//骨骼不存在
                return null;
            return addBindingTagByIndex(boneIndex);
        }
 
        /**
         * 绑定至通过骨骼索引指定的骨骼上
         * @param boneIndex
         * @return
         *
         */    
        public function addBindingTagByIndex(boneIndex:int):BindingTag
        {
            var bindingTag:BindingTag = new BindingTag(this, boneIndex);
 
            for(var i:int = 0; i < _owners.length; i++)
            {
                _owners[i].addChild(bindingTag);//将bindingTag添加至骨骼对应的Mesh
            }
 
            if(!_bindingTags)_bindingTags = new Vector.<BindingTag>();
            _bindingTags.push(bindingTag);         
            return bindingTag;
        }
 
        protected function onExitFrame(event:Event):void
        {
            if(_bindingTags && _bindingTags.length)
            {
                for (var i:int = 0; i < _bindingTags.length; i++)
                {
                    _bindingTags[i].notifyBindingTransformChange();
                }
            }
        }
	}
}