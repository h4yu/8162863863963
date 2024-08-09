-- In StarterPlayerScripts > LocalScript

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local isAttacking = false
local combo = 0
local maxCombo = 4

local animations = {
    lightAttack1 = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("LightAttack1")),
    lightAttack2 = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("LightAttack2")),
    lightAttack3 = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("LightAttack3")),
    heavyAttack = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("HeavyAttack")),
    block = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("Block")),
    dodge = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("Dodge")),
    specialMove = humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("SpecialMove")),
}

-- VFX Functions
local function playHitEffect(position)
    local hitEffect = ReplicatedStorage:WaitForChild("HitEffect"):Clone()
    hitEffect.Position = position
    hitEffect.Parent = workspace
    hitEffect:Emit(50)  -- Emits particles
    
    -- Destroy the effect after a short delay
    Debris:AddItem(hitEffect, 2)
end

local function playTrailEffect()
    local trail = ReplicatedStorage:WaitForChild("SwordTrail"):Clone()
    trail.Attachment0 = humanoidRootPart:WaitForChild("RightHand").Attachment
    trail.Attachment1 = humanoidRootPart:WaitForChild("SwordAttachment")
    trail.Parent = humanoidRootPart:WaitForChild("Sword")
    
    -- Optional: Destroy the trail after a set time or when the attack ends
    Debris:AddItem(trail, 1)
end

local function playImpactEffect(position)
    local impactEffect = ReplicatedStorage:WaitForChild("ImpactEffect"):Clone()
    impactEffect.Position = position
    impactEffect.Parent = workspace
    
    -- Play any additional animation or effect
    impactEffect:Emit(100)  -- Emits particles or plays effect
    
    Debris:AddItem(impactEffect, 3)
end

-- Attack Handling
local function onAttack()
    if isAttacking then return end
    isAttacking = true
    
    if combo < maxCombo then
        combo = combo + 1
    else
        combo = 1
    end
    
    -- Play the appropriate animation based on combo count
    if combo == 1 then
        animations.lightAttack1:Play()
    elseif combo == 2 then
        animations.lightAttack2:Play()
    elseif combo == 3 then
        animations.lightAttack3:Play()
    elseif combo == 4 then
        animations.heavyAttack:Play()
        -- Trigger VFX for the heavy attack or special move
        playImpactEffect(humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5)
    end
    
    -- Reset after a short delay
    wait(0.5)
    isAttacking = false
end

local function onBlock()
    animations.block:Play()
    -- Additional logic for blocking can go here
end

local function onDodge()
    animations.dodge:Play()
    -- Additional logic for dodging can go here
end

local function onSpecialMove()
    animations.specialMove:Play()
    -- Trigger the special move, sound, and part summoning here
    playImpactEffect(humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 10)
end

-- Bind these functions to keys or buttons
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Z then
            onAttack()
        elseif input.KeyCode == Enum.KeyCode.X then
            onBlock()
        elseif input.KeyCode == Enum.KeyCode.C then
            onDodge()
        elseif input.KeyCode == Enum.KeyCode.V then
            onSpecialMove()
        end
    end
end)
