from .commPolicy import CommPolicy
# This is the one that can be customized with a gui
# An agent is the brain of a pair of arms

class Agent:
    def __init__(self) -> None:
        self.policy = None      # The agent policy is how the experts are connected

    