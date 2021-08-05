# Online_Learning-Based_Defense_Against_Jamming_Attacks_in_Multi-Channel_Wireless_CPS

This folder contains Matlab codes for the IEEE Internet of Things Journal paper titled "Multiuser Scheduling in Centralized Cognitive Radio Networks: A Multi-Armed Bandit Approach". The reader can find the required codes related to the algorithm provided in the paper. All the main files and corresponding functions include necessary in-line comments to ease following the algorithms through the codes.

Below please find the content provided in each folder:


### Abstract 

We study security of  remote state estimation in wireless cyber-physical systems (CPS) where a sensor sends its measurements to the remote state estimator over a multi-channel wireless link in presence of a  jamming attacker. Most of the existing works study the sensor's defense scheme by adopting optimization-based methods and rely on the prior knowledge of the attacker’s attack policy.To relax this constraint, we propose a novel online learning-based policy called J-CAP (Joint Channel And Power selection) for the sensor to dynamically choose transmission channel and power. The proposed method assumes \emph{no prior} knowledge of the attacker's attack policy, nor of the channel state information. J-CAP jointly optimizes sensor's channel selection and power consumption, and guarantees the estimator’s asymptotic stability. We theoretically prove that J-CAP achieves a sublinear learning regret bound. We also show J-CAP's optimality by deriving and matching its regret lower and upper bound orders. Compared with the solution that directly applies the baseline solution, J-CAP improves the regret upper 0bound by a factor of $\sqrt{K\!+\!L}$, where $K$ and $L$ denote the number of channels and number of power levels, respectively. Numerical evaluations validate the analytical results under various CPS parameters, and compare the J-CAP's performance with the state-of-the-art solutions.


### CPS System Model 

<img width="576" alt="Screen Shot 2021-08-05 at 11 53 40 AM" src="https://user-images.githubusercontent.com/75192031/128381670-b333c850-feae-4896-b632-0220b3d161b2.png">

#### Algorithm: J-CAP (Joint Channel  And  Power  selection)

We propose a novel online learning-based algorithm called J-CAP, for joint channel and power level selection by the sensor. J-CAP is presented in Algorithm 1 in the paper. Based on J-CAP, at each time $t$, the sensor chooses channel $i_t\!\in\![K]$, and power level $l_t\!\in\![L]$ according to the probabilities $p_i(t)$ and $q_l(t)$ distributed over $K$ and $L$, respectively (see step 2 to 5 in J-CAP algorithm). These distributions are a mixture of the uniform distribution (i.e., the terms $\frac{\gamma}{K}$ and $\frac{\gamma}{L}$) and a distribution which depends exponentially on the past observations for that channel and power level (i.e., the first term in the definition of $p_i(t)$ and $q_l(t)$). Mixing the uniform distribution on both sets of $K$ and $L$ actions, enables the algorithm to explore all the actions in these sets to find the best channel and power level pair. 

#### Cite [BibTeX]

@ARTICLE{9380209,
  author={Alipour-Fanid, Amir and Dabaghchian, Monireh and Wang, Ning and Jiao, Long and Zeng, Kai},
  journal={IEEE Internet of Things Journal}, 
  title={Online Learning-Based Defense Against Jamming Attacks in Multi-Channel Wireless CPS}, 
  year={2021},
  volume={},
  number={},
  pages={1-1},
  doi={10.1109/JIOT.2021.3066476}}
