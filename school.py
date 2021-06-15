from AI.Agent.agent import Agent
from AI.Agent.agentPolicy import Policy


agent = Agent()
pol = Policy(agent.action, agent.observe, agent.reset)

pol.train()







