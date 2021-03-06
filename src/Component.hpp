//
//  Component.hpp
//  Helico-opter
//
//  Created by Alex Saalberg on 1/28/18.
//

#ifndef Component_hpp
#define Component_hpp

#include <stdio.h>
#include <memory>

#include "GameObject.hpp"
#include "Program.h"

//Forward declaration because GameObject.hpp and Component.hpp include eachother
class GameObject;

class InputComponent
{
public:
    virtual ~InputComponent() {}
    virtual void update(GameObject& gameObject, float dt) = 0;
};

class PhysicsComponent
{
public:
    virtual ~PhysicsComponent() {}
    virtual void update(GameObject& gameObject, float dt) = 0;
};

class GraphicsComponent
{
public:
    int material = 2;
    virtual ~GraphicsComponent() {}
    virtual void update(GameObject& gameObject, float t, std::shared_ptr<Program> prog) = 0;
};

#endif /* Component_hpp */
