package
{
    import away3d.arcane;
    import away3d.animators.SkeletonAnimator;
    import away3d.animators.data.JointPose;
    import away3d.containers.ObjectContainer3D;
 
    use namespace arcane
    /**
     * 骨骼绑定点
     * @author vancopper
     *
     */
    public class BindingTag extends ObjectContainer3D
    {
        private var _skeletonAnimator:SkeletonAnimator;
        private var _skeletonIndex:int;
 
        /**
         *
         * @param skeletonAnimator
         * @param skeletonIndex 要绑定的骨骼索引
         *
         */    
        public function BindingTag(skeletonAnimator:SkeletonAnimator, skeletonIndex:int)
        {
            super();
            _skeletonAnimator = skeletonAnimator;
            _skeletonIndex = skeletonIndex;
        }
 
        public function notifyBindingTransformChange():void
        {
            invalidateTransform();
        }
 
        override protected function updateSceneTransform():void
        {
            if (_parent)
            {
                var jointPoses:Vector.<JointPose> = _skeletonAnimator.globalPose.jointPoses;
                if(jointPoses && jointPoses.length)
                {
                    //取到骨骼数据并同步给当前对象
                    _sceneTransform.copyFrom( jointPoses[_skeletonIndex].toMatrix3D() );
                    _sceneTransform.append( _parent.sceneTransform );
                    _sceneTransform.prepend(transform);
                }
            }
            _sceneTransformDirty = false;
        }
 
        override public function dispose():void
        {
            //TODO:
        }
    }
}