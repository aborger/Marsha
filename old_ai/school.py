from AI.Agent.agent import Agent
from AI.Agent.agentPolicy import Policy


agent = Agent()
pol = Policy(agent.perform_actions, agent.observe, agent.reset)


pol.train()







