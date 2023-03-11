module binding.nodes;

import binding;
import binding.err;
import binding.puppet;
import inochi2d;
import utils;

// Everything here should be C ABI compatible
extern(C) export:

struct InNode {
    Node node;
}
private {
InNode* to_ref(ref Node b) {
    return alloc!(Node, InNode)(b);
}
}

InNode* inPuppetGetRootNode(InPuppet* puppet) {
    return to_ref(puppet.puppet.root);
}

void inNodeGetChildren(InNode* node, InNode*** array_ptr, size_t* length) {
    array2carray!(Node, InNode*, to_ref)(node.node.children, *array_ptr, *length);
}

char* inNodeGetName(InNode* node) {
    return str2cstr(node.node.name);
}

uint inNodeGetUUID(InNode* node) {
    return node.node.uuid;
}

InNode* inNodeGetParent(InNode* node) {
    return to_ref(node.node.parent);
}

float inNodeGetZSort(InNode* node) {
    return node.node.zSort;
}

bool inNodeGetLockToRoot(InNode* node) {
    return node.node.lockToRoot;
}

char* inNodeGetPath(InNode* node) {
    return str2cstr(node.node.getNodePath);
}

bool inNodeGetEnabled(InNode* node) {
    return node.node.enabled;
}

char* inNodeGetTypeId(InNode* node) {
    return str2cstr(node.node.typeId);
}

bool inNodeHasParam(InNode* node, char* name) {
    auto dName = cstr2str(name);
    return node.node.hasParam(dName);
}

float inNodeGetValue(InNode* node, char* name) {
    return node.node.getValue(cstr2str(name));
}

void inNodeSetValue(InNode* node, char* name, float value) {
    node.node.setValue(cstr2str(name), value);
}

version (yesgl) {

    /**
        Draw node
    */
    void inNodeDraw(InNode* node) {
        node.node.draw();
    }

    void inNodeDrawOne(InNode* node) {
        node.node.drawOne();
    }
}

void inNodeUpdate(InNode* node) {
    node.node.update();
}

void inNodeBeginUpdate(InNode* node) {
    node.node.beginUpdate();
}

void inNodeTransformChanged(InNode* node) {
    node.node.transformChanged();
}

void inNodeGetCombinedBounds(InNode* node, float* x, float* y, float* z, float* w) {
    vec4 result = node.node.getCombinedBounds();
    *x = result.x;
    *y = result.y;
    *z = result.z;
    *w = result.w;
}

void inNodeGetCombinedBoundsWithUpdate(InNode* node, float* x, float* y, float* z, float* w) {
    vec4 result = node.node.getCombinedBounds!true();
    *x = result.x;
    *y = result.y;
    *z = result.z;
    *w = result.w;
}