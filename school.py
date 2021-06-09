from AI.server import Server
from AI.Agent.agent import Agent
from AI.Agent.agentPolicy import Policy
from Environments.environment import Environment


agent = Agent()
pol = Policy(agent.action, agent.observe, agent.reset)

pol.train()







