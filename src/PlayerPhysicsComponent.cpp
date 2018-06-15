//
//  PlayerPhysicsComponent.cpp
//  Helico-opter
//
//  Created by Alex Saalberg on 2/1/18.
//

#include "PlayerPhysicsComponent.hpp"

using namespace std;
using namespace glm;

void PlayerPhysicsComponent::update(GameObject& gameObject, float dt) {
    if(gameObject.collisionCooldown == 0.0f) {
        for (b2ContactEdge* c = gameObject.body->GetContactList(); c != nullptr; c = c->next)
        {
            b2Body *other = c->other;
            void *userData = other->GetUserData();
            if(userData) {
                char *cString = (char *) userData;
                if(strcmp(cString, "blimp") == 0) {
                    //printf("blimp\n");
                    gameObject.collisionCooldown = 2.0f;
                    gameObject.health -= 1;
                }
            }
        }
    }

	//restrict player to camera space
	b2Vec2 pos = gameObject.body->GetPosition();
	b2Vec2 vel = gameObject.body->GetLinearVelocity();

	if (pos.y > 15.0f) {
		if (vel.y > 0.0f)
			vel.y = -1.0f;
	}
	if (pos.y < -3.0f) {
		if (vel.y < 0.0f)
			vel.y = 1.0f;
	}
	gameObject.body->SetLinearVelocity(vel);
}
