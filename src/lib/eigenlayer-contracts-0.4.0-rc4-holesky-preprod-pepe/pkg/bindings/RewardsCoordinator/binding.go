// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package RewardsCoordinator

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
	_ = abi.ConvertType
)

// IRewardsCoordinatorDistributionRoot is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorDistributionRoot struct {
	Root                           [32]byte
	RewardsCalculationEndTimestamp uint32
	ActivatedAt                    uint32
}

// IRewardsCoordinatorEarnerTreeMerkleLeaf is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorEarnerTreeMerkleLeaf struct {
	Earner          common.Address
	EarnerTokenRoot [32]byte
}

// IRewardsCoordinatorRewardsMerkleClaim is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorRewardsMerkleClaim struct {
	RootIndex       uint32
	EarnerIndex     uint32
	EarnerTreeProof []byte
	EarnerLeaf      IRewardsCoordinatorEarnerTreeMerkleLeaf
	TokenIndices    []uint32
	TokenTreeProofs [][]byte
	TokenLeaves     []IRewardsCoordinatorTokenTreeMerkleLeaf
}

// IRewardsCoordinatorRewardsSubmission is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorRewardsSubmission struct {
	StrategiesAndMultipliers []IRewardsCoordinatorStrategyAndMultiplier
	Token                    common.Address
	Amount                   *big.Int
	StartTimestamp           uint32
	Duration                 uint32
}

// IRewardsCoordinatorStrategyAndMultiplier is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorStrategyAndMultiplier struct {
	Strategy   common.Address
	Multiplier *big.Int
}

// IRewardsCoordinatorTokenTreeMerkleLeaf is an auto generated low-level Go binding around an user-defined struct.
type IRewardsCoordinatorTokenTreeMerkleLeaf struct {
	Token              common.Address
	CumulativeEarnings *big.Int
}

// RewardsCoordinatorMetaData contains all meta data concerning the RewardsCoordinator contract.
var RewardsCoordinatorMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"constructor\",\"inputs\":[{\"name\":\"_delegationManager\",\"type\":\"address\",\"internalType\":\"contractIDelegationManager\"},{\"name\":\"_strategyManager\",\"type\":\"address\",\"internalType\":\"contractIStrategyManager\"},{\"name\":\"_CALCULATION_INTERVAL_SECONDS\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"_MAX_REWARDS_DURATION\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"_MAX_RETROACTIVE_LENGTH\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"_MAX_FUTURE_LENGTH\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"__GENESIS_REWARDS_TIMESTAMP\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"CALCULATION_INTERVAL_SECONDS\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GENESIS_REWARDS_TIMESTAMP\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"MAX_FUTURE_LENGTH\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"MAX_RETROACTIVE_LENGTH\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"MAX_REWARDS_DURATION\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"activationDelay\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"beaconChainETHStrategy\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"contractIStrategy\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"calculateEarnerLeafHash\",\"inputs\":[{\"name\":\"leaf\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.EarnerTreeMerkleLeaf\",\"components\":[{\"name\":\"earner\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"earnerTokenRoot\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}]}],\"outputs\":[{\"name\":\"\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"stateMutability\":\"pure\"},{\"type\":\"function\",\"name\":\"calculateTokenLeafHash\",\"inputs\":[{\"name\":\"leaf\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.TokenTreeMerkleLeaf\",\"components\":[{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"cumulativeEarnings\",\"type\":\"uint256\",\"internalType\":\"uint256\"}]}],\"outputs\":[{\"name\":\"\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"stateMutability\":\"pure\"},{\"type\":\"function\",\"name\":\"checkClaim\",\"inputs\":[{\"name\":\"claim\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.RewardsMerkleClaim\",\"components\":[{\"name\":\"rootIndex\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"earnerIndex\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"earnerTreeProof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"earnerLeaf\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.EarnerTreeMerkleLeaf\",\"components\":[{\"name\":\"earner\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"earnerTokenRoot\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}]},{\"name\":\"tokenIndices\",\"type\":\"uint32[]\",\"internalType\":\"uint32[]\"},{\"name\":\"tokenTreeProofs\",\"type\":\"bytes[]\",\"internalType\":\"bytes[]\"},{\"name\":\"tokenLeaves\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.TokenTreeMerkleLeaf[]\",\"components\":[{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"cumulativeEarnings\",\"type\":\"uint256\",\"internalType\":\"uint256\"}]}]}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"claimerFor\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"createAVSRewardsSubmission\",\"inputs\":[{\"name\":\"rewardsSubmissions\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.RewardsSubmission[]\",\"components\":[{\"name\":\"strategiesAndMultipliers\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.StrategyAndMultiplier[]\",\"components\":[{\"name\":\"strategy\",\"type\":\"address\",\"internalType\":\"contractIStrategy\"},{\"name\":\"multiplier\",\"type\":\"uint96\",\"internalType\":\"uint96\"}]},{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"startTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"duration\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"createRewardsForAllSubmission\",\"inputs\":[{\"name\":\"rewardsSubmissions\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.RewardsSubmission[]\",\"components\":[{\"name\":\"strategiesAndMultipliers\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.StrategyAndMultiplier[]\",\"components\":[{\"name\":\"strategy\",\"type\":\"address\",\"internalType\":\"contractIStrategy\"},{\"name\":\"multiplier\",\"type\":\"uint96\",\"internalType\":\"uint96\"}]},{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"startTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"duration\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"cumulativeClaimed\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"\",\"type\":\"address\",\"internalType\":\"contractIERC20\"}],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"currRewardsCalculationEndTimestamp\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"delegationManager\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"contractIDelegationManager\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"domainSeparator\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getCurrentDistributionRoot\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.DistributionRoot\",\"components\":[{\"name\":\"root\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"rewardsCalculationEndTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"activatedAt\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getDistributionRootAtIndex\",\"inputs\":[{\"name\":\"index\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.DistributionRoot\",\"components\":[{\"name\":\"root\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"rewardsCalculationEndTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"activatedAt\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getDistributionRootsLength\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getRootIndexFromHash\",\"inputs\":[{\"name\":\"rootHash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"globalOperatorCommissionBips\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint16\",\"internalType\":\"uint16\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"initialize\",\"inputs\":[{\"name\":\"initialOwner\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"_pauserRegistry\",\"type\":\"address\",\"internalType\":\"contractIPauserRegistry\"},{\"name\":\"initialPausedStatus\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"_rewardsUpdater\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"_activationDelay\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"_globalCommissionBips\",\"type\":\"uint16\",\"internalType\":\"uint16\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"isAVSRewardsSubmissionHash\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"isRewardsForAllSubmitter\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"isRewardsSubmissionForAllHash\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"operatorCommissionBips\",\"inputs\":[{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"avs\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"uint16\",\"internalType\":\"uint16\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"owner\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"pause\",\"inputs\":[{\"name\":\"newPausedStatus\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"pauseAll\",\"inputs\":[],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"paused\",\"inputs\":[{\"name\":\"index\",\"type\":\"uint8\",\"internalType\":\"uint8\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"paused\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"pauserRegistry\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"contractIPauserRegistry\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"processClaim\",\"inputs\":[{\"name\":\"claim\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.RewardsMerkleClaim\",\"components\":[{\"name\":\"rootIndex\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"earnerIndex\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"earnerTreeProof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"earnerLeaf\",\"type\":\"tuple\",\"internalType\":\"structIRewardsCoordinator.EarnerTreeMerkleLeaf\",\"components\":[{\"name\":\"earner\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"earnerTokenRoot\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}]},{\"name\":\"tokenIndices\",\"type\":\"uint32[]\",\"internalType\":\"uint32[]\"},{\"name\":\"tokenTreeProofs\",\"type\":\"bytes[]\",\"internalType\":\"bytes[]\"},{\"name\":\"tokenLeaves\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.TokenTreeMerkleLeaf[]\",\"components\":[{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"cumulativeEarnings\",\"type\":\"uint256\",\"internalType\":\"uint256\"}]}]},{\"name\":\"recipient\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"renounceOwnership\",\"inputs\":[],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"rewardsUpdater\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"setActivationDelay\",\"inputs\":[{\"name\":\"_activationDelay\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setClaimerFor\",\"inputs\":[{\"name\":\"claimer\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setGlobalOperatorCommission\",\"inputs\":[{\"name\":\"_globalCommissionBips\",\"type\":\"uint16\",\"internalType\":\"uint16\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setPauserRegistry\",\"inputs\":[{\"name\":\"newPauserRegistry\",\"type\":\"address\",\"internalType\":\"contractIPauserRegistry\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setRewardsForAllSubmitter\",\"inputs\":[{\"name\":\"_submitter\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"_newValue\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setRewardsUpdater\",\"inputs\":[{\"name\":\"_rewardsUpdater\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"strategyManager\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"contractIStrategyManager\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"submissionNonce\",\"inputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"submitRoot\",\"inputs\":[{\"name\":\"root\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"rewardsCalculationEndTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"transferOwnership\",\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"unpause\",\"inputs\":[{\"name\":\"newPausedStatus\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"event\",\"name\":\"AVSRewardsSubmissionCreated\",\"inputs\":[{\"name\":\"avs\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"submissionNonce\",\"type\":\"uint256\",\"indexed\":true,\"internalType\":\"uint256\"},{\"name\":\"rewardsSubmissionHash\",\"type\":\"bytes32\",\"indexed\":true,\"internalType\":\"bytes32\"},{\"name\":\"rewardsSubmission\",\"type\":\"tuple\",\"indexed\":false,\"internalType\":\"structIRewardsCoordinator.RewardsSubmission\",\"components\":[{\"name\":\"strategiesAndMultipliers\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.StrategyAndMultiplier[]\",\"components\":[{\"name\":\"strategy\",\"type\":\"address\",\"internalType\":\"contractIStrategy\"},{\"name\":\"multiplier\",\"type\":\"uint96\",\"internalType\":\"uint96\"}]},{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"startTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"duration\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"ActivationDelaySet\",\"inputs\":[{\"name\":\"oldActivationDelay\",\"type\":\"uint32\",\"indexed\":false,\"internalType\":\"uint32\"},{\"name\":\"newActivationDelay\",\"type\":\"uint32\",\"indexed\":false,\"internalType\":\"uint32\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"ClaimerForSet\",\"inputs\":[{\"name\":\"earner\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"oldClaimer\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"claimer\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"DistributionRootSubmitted\",\"inputs\":[{\"name\":\"rootIndex\",\"type\":\"uint32\",\"indexed\":true,\"internalType\":\"uint32\"},{\"name\":\"root\",\"type\":\"bytes32\",\"indexed\":true,\"internalType\":\"bytes32\"},{\"name\":\"rewardsCalculationEndTimestamp\",\"type\":\"uint32\",\"indexed\":true,\"internalType\":\"uint32\"},{\"name\":\"activatedAt\",\"type\":\"uint32\",\"indexed\":false,\"internalType\":\"uint32\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"GlobalCommissionBipsSet\",\"inputs\":[{\"name\":\"oldGlobalCommissionBips\",\"type\":\"uint16\",\"indexed\":false,\"internalType\":\"uint16\"},{\"name\":\"newGlobalCommissionBips\",\"type\":\"uint16\",\"indexed\":false,\"internalType\":\"uint16\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"Initialized\",\"inputs\":[{\"name\":\"version\",\"type\":\"uint8\",\"indexed\":false,\"internalType\":\"uint8\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"OwnershipTransferred\",\"inputs\":[{\"name\":\"previousOwner\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"newOwner\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"Paused\",\"inputs\":[{\"name\":\"account\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"newPausedStatus\",\"type\":\"uint256\",\"indexed\":false,\"internalType\":\"uint256\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"PauserRegistrySet\",\"inputs\":[{\"name\":\"pauserRegistry\",\"type\":\"address\",\"indexed\":false,\"internalType\":\"contractIPauserRegistry\"},{\"name\":\"newPauserRegistry\",\"type\":\"address\",\"indexed\":false,\"internalType\":\"contractIPauserRegistry\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"RewardsClaimed\",\"inputs\":[{\"name\":\"root\",\"type\":\"bytes32\",\"indexed\":false,\"internalType\":\"bytes32\"},{\"name\":\"earner\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"claimer\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"recipient\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"token\",\"type\":\"address\",\"indexed\":false,\"internalType\":\"contractIERC20\"},{\"name\":\"claimedAmount\",\"type\":\"uint256\",\"indexed\":false,\"internalType\":\"uint256\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"RewardsForAllSubmitterSet\",\"inputs\":[{\"name\":\"rewardsForAllSubmitter\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"oldValue\",\"type\":\"bool\",\"indexed\":true,\"internalType\":\"bool\"},{\"name\":\"newValue\",\"type\":\"bool\",\"indexed\":true,\"internalType\":\"bool\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"RewardsSubmissionForAllCreated\",\"inputs\":[{\"name\":\"submitter\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"submissionNonce\",\"type\":\"uint256\",\"indexed\":true,\"internalType\":\"uint256\"},{\"name\":\"rewardsSubmissionHash\",\"type\":\"bytes32\",\"indexed\":true,\"internalType\":\"bytes32\"},{\"name\":\"rewardsSubmission\",\"type\":\"tuple\",\"indexed\":false,\"internalType\":\"structIRewardsCoordinator.RewardsSubmission\",\"components\":[{\"name\":\"strategiesAndMultipliers\",\"type\":\"tuple[]\",\"internalType\":\"structIRewardsCoordinator.StrategyAndMultiplier[]\",\"components\":[{\"name\":\"strategy\",\"type\":\"address\",\"internalType\":\"contractIStrategy\"},{\"name\":\"multiplier\",\"type\":\"uint96\",\"internalType\":\"uint96\"}]},{\"name\":\"token\",\"type\":\"address\",\"internalType\":\"contractIERC20\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"startTimestamp\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"duration\",\"type\":\"uint32\",\"internalType\":\"uint32\"}]}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"RewardsUpdaterSet\",\"inputs\":[{\"name\":\"oldRewardsUpdater\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"newRewardsUpdater\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"}],\"anonymous\":false},{\"type\":\"event\",\"name\":\"Unpaused\",\"inputs\":[{\"name\":\"account\",\"type\":\"address\",\"indexed\":true,\"internalType\":\"address\"},{\"name\":\"newPausedStatus\",\"type\":\"uint256\",\"indexed\":false,\"internalType\":\"uint256\"}],\"anonymous\":false}]",
	Bin: "0x6101806040523480156200001257600080fd5b5060405162003f3838038062003f388339810160408190526200003591620002e4565b868686868686866200004885826200037e565b63ffffffff1615620000ed5760405162461bcd60e51b815260206004820152606060248201527f52657761726473436f6f7264696e61746f723a2047454e455349535f5245574160448201527f5244535f54494d455354414d50206d7573742062652061206d756c7469706c6560648201527f206f662043414c43554c4154494f4e5f494e54455256414c5f5345434f4e4453608482015260a4015b60405180910390fd5b620000fc62015180866200037e565b63ffffffff16156200019d5760405162461bcd60e51b815260206004820152605760248201527f52657761726473436f6f7264696e61746f723a2043414c43554c4154494f4e5f60448201527f494e54455256414c5f5345434f4e4453206d7573742062652061206d756c746960648201527f706c65206f6620534e415053484f545f434144454e4345000000000000000000608482015260a401620000e4565b6001600160a01b0396871661012052949095166101405263ffffffff92831660805290821660a052811660c05291821660e0521661010052620001df620001f2565b5050466101605250620003b09350505050565b600054610100900460ff16156200025c5760405162461bcd60e51b815260206004820152602760248201527f496e697469616c697a61626c653a20636f6e747261637420697320696e697469604482015266616c697a696e6760c81b6064820152608401620000e4565b60005460ff9081161015620002af576000805460ff191660ff9081179091556040519081527f7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb38474024989060200160405180910390a15b565b6001600160a01b0381168114620002c757600080fd5b50565b805163ffffffff81168114620002df57600080fd5b919050565b600080600080600080600060e0888a0312156200030057600080fd5b87516200030d81620002b1565b60208901519097506200032081620002b1565b95506200033060408901620002ca565b94506200034060608901620002ca565b93506200035060808901620002ca565b92506200036060a08901620002ca565b91506200037060c08901620002ca565b905092959891949750929550565b600063ffffffff80841680620003a457634e487b7160e01b600052601260045260246000fd5b92169190910692915050565b60805160a05160c05160e05161010051610120516101405161016051613af1620004476000396000611919015260008181610459015261239d0152600061071b01526000818161036201526121cc0152600081816102d60152612278015260008181610432015261217b01526000818161067a0152611ef201526000818161062001528181611fa901526120840152613af16000f3fe608060405234801561001057600080fd5b50600436106102945760003560e01c8063715018a611610167578063c46db606116100ce578063f2fde38b11610087578063f2fde38b1461073d578063f698da2514610750578063f8cd844814610758578063fabc1cbc1461076b578063fbf1e2c11461077e578063fce36c7d1461079157600080fd5b8063c46db6061461069c578063d4540a55146106ca578063de02e503146106dd578063e221b245146106f0578063e810ce2114610703578063ea4d3c9b1461071657600080fd5b80639104c319116101205780639104c319146105c85780639be3d4e4146105e35780639d45c2811461061b578063a0169ddd14610642578063bb7e451f14610655578063bf21a8aa1461067557600080fd5b8063715018a6146105565780637b8f8b051461055e578063863cb9a914610566578063865c695314610579578063886f1195146105a45780638da5cb5b146105b757600080fd5b806337838ed01161020b57806358baaa3e116101c457806358baaa3e146104cf578063595c6a67146104e25780635ac86ab7146104ea5780635c975abb1461050d5780635e9d8348146105155780636d21117e1461052857600080fd5b806337838ed01461042d57806339b70e38146104545780633a8c07861461047b5780633ccc861d146104925780633efe1db6146104a55780634d18cc35146104b857600080fd5b8063131433b41161025d578063131433b41461035d578063136439dd14610384578063149bc8721461039757806322f19a64146103b85780632b9f64a4146103d957806336af41fa1461041a57600080fd5b806218572c1461029957806304a0c502146102d1578063092db0071461030d5780630eb383451461033557806310d67a2f1461034a575b600080fd5b6102bc6102a7366004613205565b60d16020526000908152604090205460ff1681565b60405190151581526020015b60405180910390f35b6102f87f000000000000000000000000000000000000000000000000000000000000000081565b60405163ffffffff90911681526020016102c8565b60cb5461032290600160e01b900461ffff1681565b60405161ffff90911681526020016102c8565b610348610343366004613230565b6107a4565b005b610348610358366004613205565b610826565b6102f87f000000000000000000000000000000000000000000000000000000000000000081565b610348610392366004613269565b6108e2565b6103aa6103a536600461329a565b610a21565b6040519081526020016102c8565b6103226103c63660046132b6565b505060cb54600160e01b900461ffff1690565b6104026103e7366004613205565b60cc602052600090815260409020546001600160a01b031681565b6040516001600160a01b0390911681526020016102c8565b6103486104283660046132e4565b610a97565b6102f87f000000000000000000000000000000000000000000000000000000000000000081565b6104027f000000000000000000000000000000000000000000000000000000000000000081565b60cb546102f890600160a01b900463ffffffff1681565b6103486104a036600461336c565b610cd1565b6103486104b33660046133cc565b611086565b60cb546102f890600160c01b900463ffffffff1681565b6103486104dd3660046133f8565b611386565b610348611397565b6102bc6104f8366004613413565b606654600160ff9092169190911b9081161490565b6066546103aa565b6102bc610523366004613436565b61145e565b6102bc61053636600461346b565b60cf60209081526000928352604080842090915290825290205460ff1681565b6103486114dc565b60ca546103aa565b610348610574366004613205565b6114f0565b6103aa6105873660046132b6565b60cd60209081526000928352604080842090915290825290205481565b606554610402906001600160a01b031681565b6033546001600160a01b0316610402565b61040273beac0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeebeac081565b6105eb611501565b604080518251815260208084015163ffffffff9081169183019190915292820151909216908201526060016102c8565b6102f87f000000000000000000000000000000000000000000000000000000000000000081565b610348610650366004613205565b611589565b6103aa610663366004613205565b60ce6020526000908152604090205481565b6102f87f000000000000000000000000000000000000000000000000000000000000000081565b6102bc6106aa36600461346b565b60d060209081526000928352604080842090915290825290205460ff1681565b6103486106d83660046134b4565b6115e8565b6105eb6106eb366004613269565b611730565b6103486106fe366004613527565b6117ac565b6102f8610711366004613269565b6117bd565b6104027f000000000000000000000000000000000000000000000000000000000000000081565b61034861074b366004613205565b61189f565b6103aa611915565b6103aa61076636600461329a565b611953565b610348610779366004613269565b611964565b60cb54610402906001600160a01b031681565b61034861079f3660046132e4565b611ac0565b6107ac611c3f565b6001600160a01b038216600081815260d1602052604080822054905160ff9091169284151592841515927f4de6293e668df1398422e1def12118052c1539a03cbfedc145895d48d7685f1c9190a4506001600160a01b0391909116600090815260d160205260409020805460ff1916911515919091179055565b606560009054906101000a90046001600160a01b03166001600160a01b031663eab66d7a6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610879573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061089d9190613542565b6001600160a01b0316336001600160a01b0316146108d65760405162461bcd60e51b81526004016108cd9061355f565b60405180910390fd5b6108df81611c99565b50565b60655460405163237dfb4760e11b81523360048201526001600160a01b03909116906346fbf68e90602401602060405180830381865afa15801561092a573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061094e91906135a9565b61096a5760405162461bcd60e51b81526004016108cd906135c6565b606654818116146109e35760405162461bcd60e51b815260206004820152603860248201527f5061757361626c652e70617573653a20696e76616c696420617474656d70742060448201527f746f20756e70617573652066756e6374696f6e616c697479000000000000000060648201526084016108cd565b606681905560405181815233907fab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d906020015b60405180910390a250565b600080610a316020840184613205565b8360200135604051602001610a7a9392919060f89390931b6001600160f81b031916835260609190911b6bffffffffffffffffffffffff19166001830152601582015260350190565b604051602081830303815290604052805190602001209050919050565b60665460019060029081161415610ac05760405162461bcd60e51b81526004016108cd9061360e565b33600090815260d1602052604090205460ff16610b5f5760405162461bcd60e51b815260206004820152605160248201527f52657761726473436f6f7264696e61746f723a2063616c6c6572206973206e6f60448201527f7420612076616c69642063726561746552657761726473466f72416c6c53756260648201527036b4b9b9b4b7b71039bab136b4ba3a32b960791b608482015260a4016108cd565b60026097541415610b825760405162461bcd60e51b81526004016108cd90613645565b600260975560005b82811015610cc65736848483818110610ba557610ba561367c565b9050602002810190610bb79190613692565b33600081815260ce60209081526040808320549051949550939192610be292909185918791016137d7565b604051602081830303815290604052805190602001209050610c0383611d90565b33600090815260d0602090815260408083208484529091529020805460ff19166001908117909155610c3690839061381d565b33600081815260ce602052604090819020929092559051829184917f51088b8c89628df3a8174002c2a034d0152fce6af8415d651b2a4734bf27048290610c7e908890613835565b60405180910390a4610cb0333060408601803590610c9f9060208901613205565b6001600160a01b0316929190612568565b5050508080610cbe90613848565b915050610b8a565b505060016097555050565b60665460029060049081161415610cfa5760405162461bcd60e51b81526004016108cd9061360e565b60026097541415610d1d5760405162461bcd60e51b81526004016108cd90613645565b6002609755600060ca610d3360208601866133f8565b63ffffffff1681548110610d4957610d4961367c565b6000918252602091829020604080516060810182526002909302909101805483526001015463ffffffff808216948401949094526401000000009004909216918101919091529050610d9b84826125d9565b6000610dad6080860160608701613205565b6001600160a01b03808216600090815260cc60205260409020549192501680610dd35750805b336001600160a01b03821614610e515760405162461bcd60e51b815260206004820152603c60248201527f52657761726473436f6f7264696e61746f722e70726f63657373436c61696d3a60448201527f2063616c6c6572206973206e6f742076616c696420636c61696d65720000000060648201526084016108cd565b60005b610e6160a0880188613863565b90508110156110785736610e7860e08901896138b4565b83818110610e8857610e8861367c565b6001600160a01b038716600090815260cd602090815260408083209302949094019450929091508290610ebd90850185613205565b6001600160a01b03166001600160a01b0316815260200190815260200160002054905080826020013511610f775760405162461bcd60e51b815260206004820152605560248201527f52657761726473436f6f7264696e61746f722e70726f63657373436c61696d3a60448201527f2063756d756c61746976654561726e696e6773206d75737420626520677420746064820152741a185b8818dd5b5d5b185d1a5d9950db185a5b5959605a1b608482015260a4016108cd565b6000610f878260208501356138fe565b6001600160a01b038716600090815260cd60209081526040822092935085018035929190610fb59087613205565b6001600160a01b0316815260208082019290925260400160002091909155610ff7908a908390610fe790870187613205565b6001600160a01b03169190612882565b86516001600160a01b03808b1691878216918916907f9543dbd55580842586a951f0386e24d68a5df99ae29e3b216588b45fd684ce319061103b6020890189613205565b604080519283526001600160a01b039091166020830152810186905260600160405180910390a4505050808061107090613848565b915050610e54565b505060016097555050505050565b606654600390600890811614156110af5760405162461bcd60e51b81526004016108cd9061360e565b60cb546001600160a01b031633146111265760405162461bcd60e51b815260206004820152603460248201527f52657761726473436f6f7264696e61746f723a2063616c6c6572206973206e6f6044820152733a103a3432903932bbb0b93239aab83230ba32b960611b60648201526084016108cd565b60cb5463ffffffff600160c01b9091048116908316116111c25760405162461bcd60e51b815260206004820152604b60248201527f52657761726473436f6f7264696e61746f722e7375626d6974526f6f743a206e60448201527f657720726f6f74206d75737420626520666f72206e657765722063616c63756c60648201526a185d1959081c195c9a5bd960aa1b608482015260a4016108cd565b428263ffffffff161061125b5760405162461bcd60e51b815260206004820152605560248201527f52657761726473436f6f7264696e61746f722e7375626d6974526f6f743a207260448201527f65776172647343616c63756c6174696f6e456e6454696d657374616d702063616064820152746e6e6f7420626520696e207468652066757475726560581b608482015260a4016108cd565b60ca5460cb5460009061127b90600160a01b900463ffffffff1642613915565b6040805160608101825287815263ffffffff878116602080840182815286841685870181815260ca805460018101825560009190915296517f42d72674974f694b5f5159593243114d38a5c39c89d6b62fee061ff523240ee160029098029788015591517f42d72674974f694b5f5159593243114d38a5c39c89d6b62fee061ff523240ee29096018054925196861667ffffffffffffffff19909316929092176401000000009686169690960295909517905560cb805463ffffffff60c01b1916600160c01b840217905593519283529394508892908616917fecd866c3c158fa00bf34d803d5f6023000b57080bcb48af004c2b4b46b3afd08910160405180910390a45050505050565b61138e611c3f565b6108df816128b2565b60655460405163237dfb4760e11b81523360048201526001600160a01b03909116906346fbf68e90602401602060405180830381865afa1580156113df573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061140391906135a9565b61141f5760405162461bcd60e51b81526004016108cd906135c6565b600019606681905560405190815233907fab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d9060200160405180910390a2565b60006114d48260ca61147360208301836133f8565b63ffffffff16815481106114895761148961367c565b6000918252602091829020604080516060810182526002909302909101805483526001015463ffffffff808216948401949094526401000000009004909216918101919091526125d9565b506001919050565b6114e4611c3f565b6114ee6000612923565b565b6114f8611c3f565b6108df81612975565b604080516060810182526000808252602082018190529181019190915260ca805461152e906001906138fe565b8154811061153e5761153e61367c565b6000918252602091829020604080516060810182526002909302909101805483526001015463ffffffff80821694840194909452640100000000900490921691810191909152919050565b33600081815260cc602052604080822080546001600160a01b031981166001600160a01b038781169182179093559251911692839185917fbab947934d42e0ad206f25c9cab18b5bb6ae144acfb00f40b4e3aa59590ca31291a4505050565b600054610100900460ff16158080156116085750600054600160ff909116105b806116225750303b158015611622575060005460ff166001145b6116855760405162461bcd60e51b815260206004820152602e60248201527f496e697469616c697a61626c653a20636f6e747261637420697320616c72656160448201526d191e481a5b9a5d1a585b1a5e995960921b60648201526084016108cd565b6000805460ff1916600117905580156116a8576000805461ff0019166101001790555b6116b06129d1565b60c9556116bd8686612a68565b6116c687612923565b6116cf84612975565b6116d8836128b2565b6116e182612b52565b8015611727576000805461ff0019169055604051600181527f7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb38474024989060200160405180910390a15b50505050505050565b604080516060810182526000808252602082018190529181019190915260ca82815481106117605761176061367c565b6000918252602091829020604080516060810182526002909302909101805483526001015463ffffffff8082169484019490945264010000000090049092169181019190915292915050565b6117b4611c3f565b6108df81612b52565b60ca546000905b63ffffffff811615611830578260ca6117de60018461393d565b63ffffffff16815481106117f4576117f461367c565b906000526020600020906002020160000154141561181e5761181760018261393d565b9392505050565b8061182881613962565b9150506117c4565b5060405162461bcd60e51b815260206004820152603760248201527f52657761726473436f6f7264696e61746f722e676574526f6f74496e6465784660448201527f726f6d486173683a20726f6f74206e6f7420666f756e6400000000000000000060648201526084016108cd565b6118a7611c3f565b6001600160a01b03811661190c5760405162461bcd60e51b815260206004820152602660248201527f4f776e61626c653a206e6577206f776e657220697320746865207a65726f206160448201526564647265737360d01b60648201526084016108cd565b6108df81612923565b60007f0000000000000000000000000000000000000000000000000000000000000000461415611946575060c95490565b61194e6129d1565b905090565b60006001610a316020840184613205565b606560009054906101000a90046001600160a01b03166001600160a01b031663eab66d7a6040518163ffffffff1660e01b8152600401602060405180830381865afa1580156119b7573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906119db9190613542565b6001600160a01b0316336001600160a01b031614611a0b5760405162461bcd60e51b81526004016108cd9061355f565b606654198119606654191614611a895760405162461bcd60e51b815260206004820152603860248201527f5061757361626c652e756e70617573653a20696e76616c696420617474656d7060448201527f7420746f2070617573652066756e6374696f6e616c697479000000000000000060648201526084016108cd565b606681905560405181815233907f3582d1828e26bf56bd801502bc021ac0bc8afb57c826e4986b45593c8fad389c90602001610a16565b60665460009060019081161415611ae95760405162461bcd60e51b81526004016108cd9061360e565b60026097541415611b0c5760405162461bcd60e51b81526004016108cd90613645565b600260975560005b82811015610cc65736848483818110611b2f57611b2f61367c565b9050602002810190611b419190613692565b33600081815260ce60209081526040808320549051949550939192611b6c92909185918791016137d7565b604051602081830303815290604052805190602001209050611b8d83611d90565b33600090815260cf602090815260408083208484529091529020805460ff19166001908117909155611bc090839061381d565b33600081815260ce602052604090819020929092559051829184917f450a367a380c4e339e5ae7340c8464ef27af7781ad9945cfe8abd828f89e628190611c08908890613835565b60405180910390a4611c29333060408601803590610c9f9060208901613205565b5050508080611c3790613848565b915050611b14565b6033546001600160a01b031633146114ee5760405162461bcd60e51b815260206004820181905260248201527f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657260448201526064016108cd565b6001600160a01b038116611d275760405162461bcd60e51b815260206004820152604960248201527f5061757361626c652e5f73657450617573657252656769737472793a206e657760448201527f50617573657252656769737472792063616e6e6f7420626520746865207a65726064820152686f206164647265737360b81b608482015260a4016108cd565b606554604080516001600160a01b03928316815291831660208301527f6e9fcd539896fca60e8b0f01dd580233e48a6b0f7df013b89ba7f565869acdb6910160405180910390a1606580546001600160a01b0319166001600160a01b0392909216919091179055565b6000611d9c82806138b4565b905011611e01576040805162461bcd60e51b8152602060048201526024810191909152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a206e6f20737472617465676965732073657460648201526084016108cd565b6000816040013511611e735760405162461bcd60e51b81526020600482015260416024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20616d6f756e742063616e6e6f74206265206064820152600360fc1b608482015260a4016108cd565b6f4b3b4ca85a86c47a098a223fffffffff81604001351115611eeb5760405162461bcd60e51b815260206004820152603f6024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20616d6f756e7420746f6f206c617267650060648201526084016108cd565b63ffffffff7f000000000000000000000000000000000000000000000000000000000000000016611f2260a08301608084016133f8565b63ffffffff161115611fa75760405162461bcd60e51b81526020600482015260546024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a206475726174696f6e20657863656564732060648201527326a0ac2fa922aba0a92229afa22aa920aa24a7a760611b608482015260a4016108cd565b7f0000000000000000000000000000000000000000000000000000000000000000611fd860a08301608084016133f8565b611fe29190613998565b63ffffffff16156120825760405162461bcd60e51b815260206004820152606a6024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a206475726174696f6e206d7573742062652060648201527f61206d756c7469706c65206f662043414c43554c4154494f4e5f494e54455256608482015269414c5f5345434f4e445360b01b60a482015260c4016108cd565b7f00000000000000000000000000000000000000000000000000000000000000006120b360808301606084016133f8565b6120bd9190613998565b63ffffffff16156121635760405162461bcd60e51b81526020600482015260706024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20737461727454696d657374616d70206d7560648201527f73742062652061206d756c7469706c65206f662043414c43554c4154494f4e5f60848201526f494e54455256414c5f5345434f4e445360801b60a482015260c4016108cd565b61217360808201606083016133f8565b63ffffffff167f000000000000000000000000000000000000000000000000000000000000000063ffffffff16426121ab91906138fe565b111580156121f457506121c460808201606083016133f8565b63ffffffff167f000000000000000000000000000000000000000000000000000000000000000063ffffffff1611155b61226e5760405162461bcd60e51b81526020600482015260516024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20737461727454696d657374616d7020746f6064820152701bc819985c881a5b881d1a19481c185cdd607a1b608482015260a4016108cd565b61229e63ffffffff7f0000000000000000000000000000000000000000000000000000000000000000164261381d565b6122ae60808301606084016133f8565b63ffffffff1611156123325760405162461bcd60e51b81526020600482015260536024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20737461727454696d657374616d7020746f6064820152726f2066617220696e207468652066757475726560681b608482015260a4016108cd565b6000805b61234083806138b4565b905081101561256357600061235584806138b4565b838181106123655761236561367c565b61237b9260206040909202019081019150613205565b60405163198f077960e21b81526001600160a01b0380831660048301529192507f00000000000000000000000000000000000000000000000000000000000000009091169063663c1de490602401602060405180830381865afa1580156123e6573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061240a91906135a9565b8061243157506001600160a01b03811673beac0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeebeac0145b6124a45760405162461bcd60e51b815260206004820152604a6024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a20696e76616c69642073747261746567792060648201526918dbdb9cda59195c995960b21b608482015260a4016108cd565b806001600160a01b0316836001600160a01b0316106125515760405162461bcd60e51b81526020600482015260696024820152600080516020613a9c83398151915260448201527f7264735375626d697373696f6e3a2073747261746567696573206d757374206260648201527f6520696e20617363656e64696e67206f7264657220746f2068616e646c65206460848201526875706c69636174657360b81b60a482015260c4016108cd565b915061255c81613848565b9050612336565b505050565b6040516001600160a01b03808516602483015283166044820152606481018290526125d39085906323b872dd60e01b906084015b60408051601f198184030181529190526020810180516001600160e01b03166001600160e01b031990931692909217909152612bbd565b50505050565b806040015163ffffffff164210156126525760405162461bcd60e51b815260206004820152603660248201527f52657761726473436f6f7264696e61746f722e5f636865636b436c61696d3a206044820152751c9bdbdd081b9bdd081858dd1a5d985d1959081e595d60521b60648201526084016108cd565b61265f60c0830183613863565b905061266e60a0840184613863565b9050146126f85760405162461bcd60e51b815260206004820152604c60248201527f52657761726473436f6f7264696e61746f722e5f636865636b436c61696d3a2060448201527f746f6b656e496e646963657320616e6420746f6b656e50726f6f6673206c656e60648201526b0cee8d040dad2e6dac2e8c6d60a31b608482015260a4016108cd565b61270560e08301836138b4565b905061271460c0840184613863565b90501461279c5760405162461bcd60e51b815260206004820152604a60248201527f52657761726473436f6f7264696e61746f722e5f636865636b436c61696d3a2060448201527f746f6b656e5472656550726f6f667320616e64206c6561766573206c656e67746064820152690d040dad2e6dac2e8c6d60b31b608482015260a4016108cd565b80516127c8906127b260408501602086016133f8565b6127bf60408601866139bb565b86606001612c8f565b60005b6127d860a0840184613863565b90508110156125635761287260808401356127f660a0860186613863565b848181106128065761280661367c565b905060200201602081019061281b91906133f8565b61282860c0870187613863565b858181106128385761283861367c565b905060200281019061284a91906139bb565b61285760e08901896138b4565b878181106128675761286761367c565b905060400201612e03565b61287b81613848565b90506127cb565b6040516001600160a01b03831660248201526044810182905261256390849063a9059cbb60e01b9060640161259c565b60cb546040805163ffffffff600160a01b9093048316815291831660208301527faf557c6c02c208794817a705609cfa935f827312a1adfdd26494b6b95dd2b4b3910160405180910390a160cb805463ffffffff909216600160a01b0263ffffffff60a01b19909216919091179055565b603380546001600160a01b038381166001600160a01b0319831681179093556040519116919082907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a35050565b60cb546040516001600160a01b038084169216907f237b82f438d75fc568ebab484b75b01d9287b9e98b490b7c23221623b6705dbb90600090a360cb80546001600160a01b0319166001600160a01b0392909216919091179055565b604080518082018252600a81526922b4b3b2b72630bcb2b960b11b60209182015281517f8cad95687ba82c2ce50e74f7b754645e5117c3a5bec8151c0726d5857980a866818301527f71b625cfad44bac63b13dba07f2e1d6084ee04b6f8752101ece6126d584ee6ea81840152466060820152306080808301919091528351808303909101815260a0909101909252815191012090565b6065546001600160a01b0316158015612a8957506001600160a01b03821615155b612b0b5760405162461bcd60e51b815260206004820152604760248201527f5061757361626c652e5f696e697469616c697a655061757365723a205f696e6960448201527f7469616c697a6550617573657228292063616e206f6e6c792062652063616c6c6064820152666564206f6e636560c81b608482015260a4016108cd565b606681905560405181815233907fab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d9060200160405180910390a2612b4e82611c99565b5050565b60cb546040805161ffff600160e01b9093048316815291831660208301527f8cdc428b0431b82d1619763f443a48197db344ba96905f3949643acd1c863a06910160405180910390a160cb805461ffff909216600160e01b0261ffff60e01b19909216919091179055565b6000612c12826040518060400160405280602081526020017f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564815250856001600160a01b0316612f549092919063ffffffff16565b8051909150156125635780806020019051810190612c3091906135a9565b6125635760405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b60648201526084016108cd565b612c9a602083613a02565b6001901b8463ffffffff1610612d245760405162461bcd60e51b815260206004820152604360248201527f52657761726473436f6f7264696e61746f722e5f7665726966794561726e657260448201527f436c61696d50726f6f663a20696e76616c6964206561726e65724c656166496e6064820152620c8caf60eb1b608482015260a4016108cd565b6000612d2f82610a21565b9050612d7a84848080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152508a92508591505063ffffffff8916612f6b565b612dfb5760405162461bcd60e51b815260206004820152604660248201527f52657761726473436f6f7264696e61746f722e5f7665726966794561726e657260448201527f436c61696d50726f6f663a20696e76616c6964206561726e657220636c61696d60648201526510383937b7b360d11b608482015260a4016108cd565b505050505050565b612e0e602083613a02565b6001901b8463ffffffff1610612e8c5760405162461bcd60e51b815260206004820152603c60248201527f52657761726473436f6f7264696e61746f722e5f766572696679546f6b656e4360448201527f6c61696d3a20696e76616c696420746f6b656e4c656166496e6465780000000060648201526084016108cd565b6000612e9782611953565b9050612ee284848080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152508a92508591505063ffffffff8916612f6b565b612dfb5760405162461bcd60e51b815260206004820152603f60248201527f52657761726473436f6f7264696e61746f722e5f766572696679546f6b656e4360448201527f6c61696d3a20696e76616c696420746f6b656e20636c61696d2070726f6f660060648201526084016108cd565b6060612f638484600085612f83565b949350505050565b600083612f798685856130b4565b1495945050505050565b606082471015612fe45760405162461bcd60e51b815260206004820152602660248201527f416464726573733a20696e73756666696369656e742062616c616e636520666f6044820152651c8818d85b1b60d21b60648201526084016108cd565b6001600160a01b0385163b61303b5760405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e747261637400000060448201526064016108cd565b600080866001600160a01b031685876040516130579190613a42565b60006040518083038185875af1925050503d8060008114613094576040519150601f19603f3d011682016040523d82523d6000602084013e613099565b606091505b50915091506130a98282866131b7565b979650505050505050565b6000602084516130c49190613a54565b1561314b5760405162461bcd60e51b815260206004820152604b60248201527f4d65726b6c652e70726f63657373496e636c7573696f6e50726f6f664b65636360448201527f616b3a2070726f6f66206c656e6774682073686f756c642062652061206d756c60648201526a3a34b836329037b310199960a91b608482015260a4016108cd565b8260205b855181116131ae57613162600285613a54565b6131835781600052808601516020526040600020915060028404935061319c565b8086015160005281602052604060002091506002840493505b6131a760208261381d565b905061314f565b50949350505050565b606083156131c6575081611817565b8251156131d65782518084602001fd5b8160405162461bcd60e51b81526004016108cd9190613a68565b6001600160a01b03811681146108df57600080fd5b60006020828403121561321757600080fd5b8135611817816131f0565b80151581146108df57600080fd5b6000806040838503121561324357600080fd5b823561324e816131f0565b9150602083013561325e81613222565b809150509250929050565b60006020828403121561327b57600080fd5b5035919050565b60006040828403121561329457600080fd5b50919050565b6000604082840312156132ac57600080fd5b6118178383613282565b600080604083850312156132c957600080fd5b82356132d4816131f0565b9150602083013561325e816131f0565b600080602083850312156132f757600080fd5b823567ffffffffffffffff8082111561330f57600080fd5b818501915085601f83011261332357600080fd5b81358181111561333257600080fd5b8660208260051b850101111561334757600080fd5b60209290920196919550909350505050565b6000610100828403121561329457600080fd5b6000806040838503121561337f57600080fd5b823567ffffffffffffffff81111561339657600080fd5b6133a285828601613359565b925050602083013561325e816131f0565b803563ffffffff811681146133c757600080fd5b919050565b600080604083850312156133df57600080fd5b823591506133ef602084016133b3565b90509250929050565b60006020828403121561340a57600080fd5b611817826133b3565b60006020828403121561342557600080fd5b813560ff8116811461181757600080fd5b60006020828403121561344857600080fd5b813567ffffffffffffffff81111561345f57600080fd5b612f6384828501613359565b6000806040838503121561347e57600080fd5b8235613489816131f0565b946020939093013593505050565b80356133c7816131f0565b803561ffff811681146133c757600080fd5b60008060008060008060c087890312156134cd57600080fd5b86356134d8816131f0565b955060208701356134e8816131f0565b94506040870135935060608701356134ff816131f0565b925061350d608088016133b3565b915061351b60a088016134a2565b90509295509295509295565b60006020828403121561353957600080fd5b611817826134a2565b60006020828403121561355457600080fd5b8151611817816131f0565b6020808252602a908201527f6d73672e73656e646572206973206e6f74207065726d697373696f6e6564206160408201526939903ab73830bab9b2b960b11b606082015260800190565b6000602082840312156135bb57600080fd5b815161181781613222565b60208082526028908201527f6d73672e73656e646572206973206e6f74207065726d697373696f6e6564206160408201526739903830bab9b2b960c11b606082015260800190565b60208082526019908201527f5061757361626c653a20696e6465782069732070617573656400000000000000604082015260600190565b6020808252601f908201527f5265656e7472616e637947756172643a207265656e7472616e742063616c6c00604082015260600190565b634e487b7160e01b600052603260045260246000fd5b60008235609e198336030181126136a857600080fd5b9190910192915050565b818352600060208085019450826000805b868110156137175782356136d6816131f0565b6001600160a01b03168852828401356bffffffffffffffffffffffff81168082146136ff578384fd5b898601525060409788019792909201916001016136c3565b50959695505050505050565b60008135601e1983360301811261373957600080fd5b8201803567ffffffffffffffff81111561375257600080fd5b8060061b360384131561376457600080fd5b60a0855261377960a0860182602085016136b2565b91505061378860208401613497565b6001600160a01b03166020850152604083810135908501526137ac606084016133b3565b63ffffffff1660608501526137c3608084016133b3565b63ffffffff81166080860152509392505050565b60018060a01b03841681528260208201526060604082015260006137fe6060830184613723565b95945050505050565b634e487b7160e01b600052601160045260246000fd5b6000821982111561383057613830613807565b500190565b6020815260006118176020830184613723565b600060001982141561385c5761385c613807565b5060010190565b6000808335601e1984360301811261387a57600080fd5b83018035915067ffffffffffffffff82111561389557600080fd5b6020019150600581901b36038213156138ad57600080fd5b9250929050565b6000808335601e198436030181126138cb57600080fd5b83018035915067ffffffffffffffff8211156138e657600080fd5b6020019150600681901b36038213156138ad57600080fd5b60008282101561391057613910613807565b500390565b600063ffffffff80831681851680830382111561393457613934613807565b01949350505050565b600063ffffffff8381169083168181101561395a5761395a613807565b039392505050565b600063ffffffff82168061397857613978613807565b6000190192915050565b634e487b7160e01b600052601260045260246000fd5b600063ffffffff808416806139af576139af613982565b92169190910692915050565b6000808335601e198436030181126139d257600080fd5b83018035915067ffffffffffffffff8211156139ed57600080fd5b6020019150368190038213156138ad57600080fd5b600082613a1157613a11613982565b500490565b60005b83811015613a31578181015183820152602001613a19565b838111156125d35750506000910152565b600082516136a8818460208701613a16565b600082613a6357613a63613982565b500690565b6020815260008251806020840152613a87816040850160208701613a16565b601f01601f1916919091016040019291505056fe52657761726473436f6f7264696e61746f722e5f76616c696461746552657761a26469706673582212202da1ed95bdf2cdfce35381a42043ede57113426459d33310eb3ca8a9c157f90e64736f6c634300080c0033",
}

// RewardsCoordinatorABI is the input ABI used to generate the binding from.
// Deprecated: Use RewardsCoordinatorMetaData.ABI instead.
var RewardsCoordinatorABI = RewardsCoordinatorMetaData.ABI

// RewardsCoordinatorBin is the compiled bytecode used for deploying new contracts.
// Deprecated: Use RewardsCoordinatorMetaData.Bin instead.
var RewardsCoordinatorBin = RewardsCoordinatorMetaData.Bin

// DeployRewardsCoordinator deploys a new Ethereum contract, binding an instance of RewardsCoordinator to it.
func DeployRewardsCoordinator(auth *bind.TransactOpts, backend bind.ContractBackend, _delegationManager common.Address, _strategyManager common.Address, _CALCULATION_INTERVAL_SECONDS uint32, _MAX_REWARDS_DURATION uint32, _MAX_RETROACTIVE_LENGTH uint32, _MAX_FUTURE_LENGTH uint32, __GENESIS_REWARDS_TIMESTAMP uint32) (common.Address, *types.Transaction, *RewardsCoordinator, error) {
	parsed, err := RewardsCoordinatorMetaData.GetAbi()
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	if parsed == nil {
		return common.Address{}, nil, nil, errors.New("GetABI returned nil")
	}

	address, tx, contract, err := bind.DeployContract(auth, *parsed, common.FromHex(RewardsCoordinatorBin), backend, _delegationManager, _strategyManager, _CALCULATION_INTERVAL_SECONDS, _MAX_REWARDS_DURATION, _MAX_RETROACTIVE_LENGTH, _MAX_FUTURE_LENGTH, __GENESIS_REWARDS_TIMESTAMP)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &RewardsCoordinator{RewardsCoordinatorCaller: RewardsCoordinatorCaller{contract: contract}, RewardsCoordinatorTransactor: RewardsCoordinatorTransactor{contract: contract}, RewardsCoordinatorFilterer: RewardsCoordinatorFilterer{contract: contract}}, nil
}

// RewardsCoordinator is an auto generated Go binding around an Ethereum contract.
type RewardsCoordinator struct {
	RewardsCoordinatorCaller     // Read-only binding to the contract
	RewardsCoordinatorTransactor // Write-only binding to the contract
	RewardsCoordinatorFilterer   // Log filterer for contract events
}

// RewardsCoordinatorCaller is an auto generated read-only Go binding around an Ethereum contract.
type RewardsCoordinatorCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// RewardsCoordinatorTransactor is an auto generated write-only Go binding around an Ethereum contract.
type RewardsCoordinatorTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// RewardsCoordinatorFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type RewardsCoordinatorFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// RewardsCoordinatorSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type RewardsCoordinatorSession struct {
	Contract     *RewardsCoordinator // Generic contract binding to set the session for
	CallOpts     bind.CallOpts       // Call options to use throughout this session
	TransactOpts bind.TransactOpts   // Transaction auth options to use throughout this session
}

// RewardsCoordinatorCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type RewardsCoordinatorCallerSession struct {
	Contract *RewardsCoordinatorCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts             // Call options to use throughout this session
}

// RewardsCoordinatorTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type RewardsCoordinatorTransactorSession struct {
	Contract     *RewardsCoordinatorTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts             // Transaction auth options to use throughout this session
}

// RewardsCoordinatorRaw is an auto generated low-level Go binding around an Ethereum contract.
type RewardsCoordinatorRaw struct {
	Contract *RewardsCoordinator // Generic contract binding to access the raw methods on
}

// RewardsCoordinatorCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type RewardsCoordinatorCallerRaw struct {
	Contract *RewardsCoordinatorCaller // Generic read-only contract binding to access the raw methods on
}

// RewardsCoordinatorTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type RewardsCoordinatorTransactorRaw struct {
	Contract *RewardsCoordinatorTransactor // Generic write-only contract binding to access the raw methods on
}

// NewRewardsCoordinator creates a new instance of RewardsCoordinator, bound to a specific deployed contract.
func NewRewardsCoordinator(address common.Address, backend bind.ContractBackend) (*RewardsCoordinator, error) {
	contract, err := bindRewardsCoordinator(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinator{RewardsCoordinatorCaller: RewardsCoordinatorCaller{contract: contract}, RewardsCoordinatorTransactor: RewardsCoordinatorTransactor{contract: contract}, RewardsCoordinatorFilterer: RewardsCoordinatorFilterer{contract: contract}}, nil
}

// NewRewardsCoordinatorCaller creates a new read-only instance of RewardsCoordinator, bound to a specific deployed contract.
func NewRewardsCoordinatorCaller(address common.Address, caller bind.ContractCaller) (*RewardsCoordinatorCaller, error) {
	contract, err := bindRewardsCoordinator(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorCaller{contract: contract}, nil
}

// NewRewardsCoordinatorTransactor creates a new write-only instance of RewardsCoordinator, bound to a specific deployed contract.
func NewRewardsCoordinatorTransactor(address common.Address, transactor bind.ContractTransactor) (*RewardsCoordinatorTransactor, error) {
	contract, err := bindRewardsCoordinator(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorTransactor{contract: contract}, nil
}

// NewRewardsCoordinatorFilterer creates a new log filterer instance of RewardsCoordinator, bound to a specific deployed contract.
func NewRewardsCoordinatorFilterer(address common.Address, filterer bind.ContractFilterer) (*RewardsCoordinatorFilterer, error) {
	contract, err := bindRewardsCoordinator(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorFilterer{contract: contract}, nil
}

// bindRewardsCoordinator binds a generic wrapper to an already deployed contract.
func bindRewardsCoordinator(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := RewardsCoordinatorMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_RewardsCoordinator *RewardsCoordinatorRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _RewardsCoordinator.Contract.RewardsCoordinatorCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_RewardsCoordinator *RewardsCoordinatorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.RewardsCoordinatorTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_RewardsCoordinator *RewardsCoordinatorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.RewardsCoordinatorTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_RewardsCoordinator *RewardsCoordinatorCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _RewardsCoordinator.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_RewardsCoordinator *RewardsCoordinatorTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_RewardsCoordinator *RewardsCoordinatorTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.contract.Transact(opts, method, params...)
}

// CALCULATIONINTERVALSECONDS is a free data retrieval call binding the contract method 0x9d45c281.
//
// Solidity: function CALCULATION_INTERVAL_SECONDS() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CALCULATIONINTERVALSECONDS(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "CALCULATION_INTERVAL_SECONDS")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// CALCULATIONINTERVALSECONDS is a free data retrieval call binding the contract method 0x9d45c281.
//
// Solidity: function CALCULATION_INTERVAL_SECONDS() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) CALCULATIONINTERVALSECONDS() (uint32, error) {
	return _RewardsCoordinator.Contract.CALCULATIONINTERVALSECONDS(&_RewardsCoordinator.CallOpts)
}

// CALCULATIONINTERVALSECONDS is a free data retrieval call binding the contract method 0x9d45c281.
//
// Solidity: function CALCULATION_INTERVAL_SECONDS() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CALCULATIONINTERVALSECONDS() (uint32, error) {
	return _RewardsCoordinator.Contract.CALCULATIONINTERVALSECONDS(&_RewardsCoordinator.CallOpts)
}

// GENESISREWARDSTIMESTAMP is a free data retrieval call binding the contract method 0x131433b4.
//
// Solidity: function GENESIS_REWARDS_TIMESTAMP() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) GENESISREWARDSTIMESTAMP(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "GENESIS_REWARDS_TIMESTAMP")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// GENESISREWARDSTIMESTAMP is a free data retrieval call binding the contract method 0x131433b4.
//
// Solidity: function GENESIS_REWARDS_TIMESTAMP() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) GENESISREWARDSTIMESTAMP() (uint32, error) {
	return _RewardsCoordinator.Contract.GENESISREWARDSTIMESTAMP(&_RewardsCoordinator.CallOpts)
}

// GENESISREWARDSTIMESTAMP is a free data retrieval call binding the contract method 0x131433b4.
//
// Solidity: function GENESIS_REWARDS_TIMESTAMP() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GENESISREWARDSTIMESTAMP() (uint32, error) {
	return _RewardsCoordinator.Contract.GENESISREWARDSTIMESTAMP(&_RewardsCoordinator.CallOpts)
}

// MAXFUTURELENGTH is a free data retrieval call binding the contract method 0x04a0c502.
//
// Solidity: function MAX_FUTURE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) MAXFUTURELENGTH(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "MAX_FUTURE_LENGTH")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// MAXFUTURELENGTH is a free data retrieval call binding the contract method 0x04a0c502.
//
// Solidity: function MAX_FUTURE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) MAXFUTURELENGTH() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXFUTURELENGTH(&_RewardsCoordinator.CallOpts)
}

// MAXFUTURELENGTH is a free data retrieval call binding the contract method 0x04a0c502.
//
// Solidity: function MAX_FUTURE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) MAXFUTURELENGTH() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXFUTURELENGTH(&_RewardsCoordinator.CallOpts)
}

// MAXRETROACTIVELENGTH is a free data retrieval call binding the contract method 0x37838ed0.
//
// Solidity: function MAX_RETROACTIVE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) MAXRETROACTIVELENGTH(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "MAX_RETROACTIVE_LENGTH")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// MAXRETROACTIVELENGTH is a free data retrieval call binding the contract method 0x37838ed0.
//
// Solidity: function MAX_RETROACTIVE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) MAXRETROACTIVELENGTH() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXRETROACTIVELENGTH(&_RewardsCoordinator.CallOpts)
}

// MAXRETROACTIVELENGTH is a free data retrieval call binding the contract method 0x37838ed0.
//
// Solidity: function MAX_RETROACTIVE_LENGTH() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) MAXRETROACTIVELENGTH() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXRETROACTIVELENGTH(&_RewardsCoordinator.CallOpts)
}

// MAXREWARDSDURATION is a free data retrieval call binding the contract method 0xbf21a8aa.
//
// Solidity: function MAX_REWARDS_DURATION() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) MAXREWARDSDURATION(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "MAX_REWARDS_DURATION")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// MAXREWARDSDURATION is a free data retrieval call binding the contract method 0xbf21a8aa.
//
// Solidity: function MAX_REWARDS_DURATION() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) MAXREWARDSDURATION() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXREWARDSDURATION(&_RewardsCoordinator.CallOpts)
}

// MAXREWARDSDURATION is a free data retrieval call binding the contract method 0xbf21a8aa.
//
// Solidity: function MAX_REWARDS_DURATION() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) MAXREWARDSDURATION() (uint32, error) {
	return _RewardsCoordinator.Contract.MAXREWARDSDURATION(&_RewardsCoordinator.CallOpts)
}

// ActivationDelay is a free data retrieval call binding the contract method 0x3a8c0786.
//
// Solidity: function activationDelay() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) ActivationDelay(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "activationDelay")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// ActivationDelay is a free data retrieval call binding the contract method 0x3a8c0786.
//
// Solidity: function activationDelay() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) ActivationDelay() (uint32, error) {
	return _RewardsCoordinator.Contract.ActivationDelay(&_RewardsCoordinator.CallOpts)
}

// ActivationDelay is a free data retrieval call binding the contract method 0x3a8c0786.
//
// Solidity: function activationDelay() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) ActivationDelay() (uint32, error) {
	return _RewardsCoordinator.Contract.ActivationDelay(&_RewardsCoordinator.CallOpts)
}

// BeaconChainETHStrategy is a free data retrieval call binding the contract method 0x9104c319.
//
// Solidity: function beaconChainETHStrategy() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) BeaconChainETHStrategy(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "beaconChainETHStrategy")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// BeaconChainETHStrategy is a free data retrieval call binding the contract method 0x9104c319.
//
// Solidity: function beaconChainETHStrategy() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) BeaconChainETHStrategy() (common.Address, error) {
	return _RewardsCoordinator.Contract.BeaconChainETHStrategy(&_RewardsCoordinator.CallOpts)
}

// BeaconChainETHStrategy is a free data retrieval call binding the contract method 0x9104c319.
//
// Solidity: function beaconChainETHStrategy() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) BeaconChainETHStrategy() (common.Address, error) {
	return _RewardsCoordinator.Contract.BeaconChainETHStrategy(&_RewardsCoordinator.CallOpts)
}

// CalculateEarnerLeafHash is a free data retrieval call binding the contract method 0x149bc872.
//
// Solidity: function calculateEarnerLeafHash((address,bytes32) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CalculateEarnerLeafHash(opts *bind.CallOpts, leaf IRewardsCoordinatorEarnerTreeMerkleLeaf) ([32]byte, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "calculateEarnerLeafHash", leaf)

	if err != nil {
		return *new([32]byte), err
	}

	out0 := *abi.ConvertType(out[0], new([32]byte)).(*[32]byte)

	return out0, err

}

// CalculateEarnerLeafHash is a free data retrieval call binding the contract method 0x149bc872.
//
// Solidity: function calculateEarnerLeafHash((address,bytes32) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorSession) CalculateEarnerLeafHash(leaf IRewardsCoordinatorEarnerTreeMerkleLeaf) ([32]byte, error) {
	return _RewardsCoordinator.Contract.CalculateEarnerLeafHash(&_RewardsCoordinator.CallOpts, leaf)
}

// CalculateEarnerLeafHash is a free data retrieval call binding the contract method 0x149bc872.
//
// Solidity: function calculateEarnerLeafHash((address,bytes32) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CalculateEarnerLeafHash(leaf IRewardsCoordinatorEarnerTreeMerkleLeaf) ([32]byte, error) {
	return _RewardsCoordinator.Contract.CalculateEarnerLeafHash(&_RewardsCoordinator.CallOpts, leaf)
}

// CalculateTokenLeafHash is a free data retrieval call binding the contract method 0xf8cd8448.
//
// Solidity: function calculateTokenLeafHash((address,uint256) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CalculateTokenLeafHash(opts *bind.CallOpts, leaf IRewardsCoordinatorTokenTreeMerkleLeaf) ([32]byte, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "calculateTokenLeafHash", leaf)

	if err != nil {
		return *new([32]byte), err
	}

	out0 := *abi.ConvertType(out[0], new([32]byte)).(*[32]byte)

	return out0, err

}

// CalculateTokenLeafHash is a free data retrieval call binding the contract method 0xf8cd8448.
//
// Solidity: function calculateTokenLeafHash((address,uint256) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorSession) CalculateTokenLeafHash(leaf IRewardsCoordinatorTokenTreeMerkleLeaf) ([32]byte, error) {
	return _RewardsCoordinator.Contract.CalculateTokenLeafHash(&_RewardsCoordinator.CallOpts, leaf)
}

// CalculateTokenLeafHash is a free data retrieval call binding the contract method 0xf8cd8448.
//
// Solidity: function calculateTokenLeafHash((address,uint256) leaf) pure returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CalculateTokenLeafHash(leaf IRewardsCoordinatorTokenTreeMerkleLeaf) ([32]byte, error) {
	return _RewardsCoordinator.Contract.CalculateTokenLeafHash(&_RewardsCoordinator.CallOpts, leaf)
}

// CheckClaim is a free data retrieval call binding the contract method 0x5e9d8348.
//
// Solidity: function checkClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CheckClaim(opts *bind.CallOpts, claim IRewardsCoordinatorRewardsMerkleClaim) (bool, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "checkClaim", claim)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// CheckClaim is a free data retrieval call binding the contract method 0x5e9d8348.
//
// Solidity: function checkClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorSession) CheckClaim(claim IRewardsCoordinatorRewardsMerkleClaim) (bool, error) {
	return _RewardsCoordinator.Contract.CheckClaim(&_RewardsCoordinator.CallOpts, claim)
}

// CheckClaim is a free data retrieval call binding the contract method 0x5e9d8348.
//
// Solidity: function checkClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CheckClaim(claim IRewardsCoordinatorRewardsMerkleClaim) (bool, error) {
	return _RewardsCoordinator.Contract.CheckClaim(&_RewardsCoordinator.CallOpts, claim)
}

// ClaimerFor is a free data retrieval call binding the contract method 0x2b9f64a4.
//
// Solidity: function claimerFor(address ) view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) ClaimerFor(opts *bind.CallOpts, arg0 common.Address) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "claimerFor", arg0)

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// ClaimerFor is a free data retrieval call binding the contract method 0x2b9f64a4.
//
// Solidity: function claimerFor(address ) view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) ClaimerFor(arg0 common.Address) (common.Address, error) {
	return _RewardsCoordinator.Contract.ClaimerFor(&_RewardsCoordinator.CallOpts, arg0)
}

// ClaimerFor is a free data retrieval call binding the contract method 0x2b9f64a4.
//
// Solidity: function claimerFor(address ) view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) ClaimerFor(arg0 common.Address) (common.Address, error) {
	return _RewardsCoordinator.Contract.ClaimerFor(&_RewardsCoordinator.CallOpts, arg0)
}

// CumulativeClaimed is a free data retrieval call binding the contract method 0x865c6953.
//
// Solidity: function cumulativeClaimed(address , address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CumulativeClaimed(opts *bind.CallOpts, arg0 common.Address, arg1 common.Address) (*big.Int, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "cumulativeClaimed", arg0, arg1)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// CumulativeClaimed is a free data retrieval call binding the contract method 0x865c6953.
//
// Solidity: function cumulativeClaimed(address , address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorSession) CumulativeClaimed(arg0 common.Address, arg1 common.Address) (*big.Int, error) {
	return _RewardsCoordinator.Contract.CumulativeClaimed(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// CumulativeClaimed is a free data retrieval call binding the contract method 0x865c6953.
//
// Solidity: function cumulativeClaimed(address , address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CumulativeClaimed(arg0 common.Address, arg1 common.Address) (*big.Int, error) {
	return _RewardsCoordinator.Contract.CumulativeClaimed(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// CurrRewardsCalculationEndTimestamp is a free data retrieval call binding the contract method 0x4d18cc35.
//
// Solidity: function currRewardsCalculationEndTimestamp() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) CurrRewardsCalculationEndTimestamp(opts *bind.CallOpts) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "currRewardsCalculationEndTimestamp")

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// CurrRewardsCalculationEndTimestamp is a free data retrieval call binding the contract method 0x4d18cc35.
//
// Solidity: function currRewardsCalculationEndTimestamp() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) CurrRewardsCalculationEndTimestamp() (uint32, error) {
	return _RewardsCoordinator.Contract.CurrRewardsCalculationEndTimestamp(&_RewardsCoordinator.CallOpts)
}

// CurrRewardsCalculationEndTimestamp is a free data retrieval call binding the contract method 0x4d18cc35.
//
// Solidity: function currRewardsCalculationEndTimestamp() view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) CurrRewardsCalculationEndTimestamp() (uint32, error) {
	return _RewardsCoordinator.Contract.CurrRewardsCalculationEndTimestamp(&_RewardsCoordinator.CallOpts)
}

// DelegationManager is a free data retrieval call binding the contract method 0xea4d3c9b.
//
// Solidity: function delegationManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) DelegationManager(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "delegationManager")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// DelegationManager is a free data retrieval call binding the contract method 0xea4d3c9b.
//
// Solidity: function delegationManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) DelegationManager() (common.Address, error) {
	return _RewardsCoordinator.Contract.DelegationManager(&_RewardsCoordinator.CallOpts)
}

// DelegationManager is a free data retrieval call binding the contract method 0xea4d3c9b.
//
// Solidity: function delegationManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) DelegationManager() (common.Address, error) {
	return _RewardsCoordinator.Contract.DelegationManager(&_RewardsCoordinator.CallOpts)
}

// DomainSeparator is a free data retrieval call binding the contract method 0xf698da25.
//
// Solidity: function domainSeparator() view returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) DomainSeparator(opts *bind.CallOpts) ([32]byte, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "domainSeparator")

	if err != nil {
		return *new([32]byte), err
	}

	out0 := *abi.ConvertType(out[0], new([32]byte)).(*[32]byte)

	return out0, err

}

// DomainSeparator is a free data retrieval call binding the contract method 0xf698da25.
//
// Solidity: function domainSeparator() view returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorSession) DomainSeparator() ([32]byte, error) {
	return _RewardsCoordinator.Contract.DomainSeparator(&_RewardsCoordinator.CallOpts)
}

// DomainSeparator is a free data retrieval call binding the contract method 0xf698da25.
//
// Solidity: function domainSeparator() view returns(bytes32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) DomainSeparator() ([32]byte, error) {
	return _RewardsCoordinator.Contract.DomainSeparator(&_RewardsCoordinator.CallOpts)
}

// GetCurrentDistributionRoot is a free data retrieval call binding the contract method 0x9be3d4e4.
//
// Solidity: function getCurrentDistributionRoot() view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorCaller) GetCurrentDistributionRoot(opts *bind.CallOpts) (IRewardsCoordinatorDistributionRoot, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "getCurrentDistributionRoot")

	if err != nil {
		return *new(IRewardsCoordinatorDistributionRoot), err
	}

	out0 := *abi.ConvertType(out[0], new(IRewardsCoordinatorDistributionRoot)).(*IRewardsCoordinatorDistributionRoot)

	return out0, err

}

// GetCurrentDistributionRoot is a free data retrieval call binding the contract method 0x9be3d4e4.
//
// Solidity: function getCurrentDistributionRoot() view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorSession) GetCurrentDistributionRoot() (IRewardsCoordinatorDistributionRoot, error) {
	return _RewardsCoordinator.Contract.GetCurrentDistributionRoot(&_RewardsCoordinator.CallOpts)
}

// GetCurrentDistributionRoot is a free data retrieval call binding the contract method 0x9be3d4e4.
//
// Solidity: function getCurrentDistributionRoot() view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GetCurrentDistributionRoot() (IRewardsCoordinatorDistributionRoot, error) {
	return _RewardsCoordinator.Contract.GetCurrentDistributionRoot(&_RewardsCoordinator.CallOpts)
}

// GetDistributionRootAtIndex is a free data retrieval call binding the contract method 0xde02e503.
//
// Solidity: function getDistributionRootAtIndex(uint256 index) view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorCaller) GetDistributionRootAtIndex(opts *bind.CallOpts, index *big.Int) (IRewardsCoordinatorDistributionRoot, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "getDistributionRootAtIndex", index)

	if err != nil {
		return *new(IRewardsCoordinatorDistributionRoot), err
	}

	out0 := *abi.ConvertType(out[0], new(IRewardsCoordinatorDistributionRoot)).(*IRewardsCoordinatorDistributionRoot)

	return out0, err

}

// GetDistributionRootAtIndex is a free data retrieval call binding the contract method 0xde02e503.
//
// Solidity: function getDistributionRootAtIndex(uint256 index) view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorSession) GetDistributionRootAtIndex(index *big.Int) (IRewardsCoordinatorDistributionRoot, error) {
	return _RewardsCoordinator.Contract.GetDistributionRootAtIndex(&_RewardsCoordinator.CallOpts, index)
}

// GetDistributionRootAtIndex is a free data retrieval call binding the contract method 0xde02e503.
//
// Solidity: function getDistributionRootAtIndex(uint256 index) view returns((bytes32,uint32,uint32))
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GetDistributionRootAtIndex(index *big.Int) (IRewardsCoordinatorDistributionRoot, error) {
	return _RewardsCoordinator.Contract.GetDistributionRootAtIndex(&_RewardsCoordinator.CallOpts, index)
}

// GetDistributionRootsLength is a free data retrieval call binding the contract method 0x7b8f8b05.
//
// Solidity: function getDistributionRootsLength() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCaller) GetDistributionRootsLength(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "getDistributionRootsLength")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// GetDistributionRootsLength is a free data retrieval call binding the contract method 0x7b8f8b05.
//
// Solidity: function getDistributionRootsLength() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorSession) GetDistributionRootsLength() (*big.Int, error) {
	return _RewardsCoordinator.Contract.GetDistributionRootsLength(&_RewardsCoordinator.CallOpts)
}

// GetDistributionRootsLength is a free data retrieval call binding the contract method 0x7b8f8b05.
//
// Solidity: function getDistributionRootsLength() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GetDistributionRootsLength() (*big.Int, error) {
	return _RewardsCoordinator.Contract.GetDistributionRootsLength(&_RewardsCoordinator.CallOpts)
}

// GetRootIndexFromHash is a free data retrieval call binding the contract method 0xe810ce21.
//
// Solidity: function getRootIndexFromHash(bytes32 rootHash) view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCaller) GetRootIndexFromHash(opts *bind.CallOpts, rootHash [32]byte) (uint32, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "getRootIndexFromHash", rootHash)

	if err != nil {
		return *new(uint32), err
	}

	out0 := *abi.ConvertType(out[0], new(uint32)).(*uint32)

	return out0, err

}

// GetRootIndexFromHash is a free data retrieval call binding the contract method 0xe810ce21.
//
// Solidity: function getRootIndexFromHash(bytes32 rootHash) view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorSession) GetRootIndexFromHash(rootHash [32]byte) (uint32, error) {
	return _RewardsCoordinator.Contract.GetRootIndexFromHash(&_RewardsCoordinator.CallOpts, rootHash)
}

// GetRootIndexFromHash is a free data retrieval call binding the contract method 0xe810ce21.
//
// Solidity: function getRootIndexFromHash(bytes32 rootHash) view returns(uint32)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GetRootIndexFromHash(rootHash [32]byte) (uint32, error) {
	return _RewardsCoordinator.Contract.GetRootIndexFromHash(&_RewardsCoordinator.CallOpts, rootHash)
}

// GlobalOperatorCommissionBips is a free data retrieval call binding the contract method 0x092db007.
//
// Solidity: function globalOperatorCommissionBips() view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorCaller) GlobalOperatorCommissionBips(opts *bind.CallOpts) (uint16, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "globalOperatorCommissionBips")

	if err != nil {
		return *new(uint16), err
	}

	out0 := *abi.ConvertType(out[0], new(uint16)).(*uint16)

	return out0, err

}

// GlobalOperatorCommissionBips is a free data retrieval call binding the contract method 0x092db007.
//
// Solidity: function globalOperatorCommissionBips() view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorSession) GlobalOperatorCommissionBips() (uint16, error) {
	return _RewardsCoordinator.Contract.GlobalOperatorCommissionBips(&_RewardsCoordinator.CallOpts)
}

// GlobalOperatorCommissionBips is a free data retrieval call binding the contract method 0x092db007.
//
// Solidity: function globalOperatorCommissionBips() view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) GlobalOperatorCommissionBips() (uint16, error) {
	return _RewardsCoordinator.Contract.GlobalOperatorCommissionBips(&_RewardsCoordinator.CallOpts)
}

// IsAVSRewardsSubmissionHash is a free data retrieval call binding the contract method 0x6d21117e.
//
// Solidity: function isAVSRewardsSubmissionHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCaller) IsAVSRewardsSubmissionHash(opts *bind.CallOpts, arg0 common.Address, arg1 [32]byte) (bool, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "isAVSRewardsSubmissionHash", arg0, arg1)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// IsAVSRewardsSubmissionHash is a free data retrieval call binding the contract method 0x6d21117e.
//
// Solidity: function isAVSRewardsSubmissionHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorSession) IsAVSRewardsSubmissionHash(arg0 common.Address, arg1 [32]byte) (bool, error) {
	return _RewardsCoordinator.Contract.IsAVSRewardsSubmissionHash(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// IsAVSRewardsSubmissionHash is a free data retrieval call binding the contract method 0x6d21117e.
//
// Solidity: function isAVSRewardsSubmissionHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) IsAVSRewardsSubmissionHash(arg0 common.Address, arg1 [32]byte) (bool, error) {
	return _RewardsCoordinator.Contract.IsAVSRewardsSubmissionHash(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// IsRewardsForAllSubmitter is a free data retrieval call binding the contract method 0x0018572c.
//
// Solidity: function isRewardsForAllSubmitter(address ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCaller) IsRewardsForAllSubmitter(opts *bind.CallOpts, arg0 common.Address) (bool, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "isRewardsForAllSubmitter", arg0)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// IsRewardsForAllSubmitter is a free data retrieval call binding the contract method 0x0018572c.
//
// Solidity: function isRewardsForAllSubmitter(address ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorSession) IsRewardsForAllSubmitter(arg0 common.Address) (bool, error) {
	return _RewardsCoordinator.Contract.IsRewardsForAllSubmitter(&_RewardsCoordinator.CallOpts, arg0)
}

// IsRewardsForAllSubmitter is a free data retrieval call binding the contract method 0x0018572c.
//
// Solidity: function isRewardsForAllSubmitter(address ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) IsRewardsForAllSubmitter(arg0 common.Address) (bool, error) {
	return _RewardsCoordinator.Contract.IsRewardsForAllSubmitter(&_RewardsCoordinator.CallOpts, arg0)
}

// IsRewardsSubmissionForAllHash is a free data retrieval call binding the contract method 0xc46db606.
//
// Solidity: function isRewardsSubmissionForAllHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCaller) IsRewardsSubmissionForAllHash(opts *bind.CallOpts, arg0 common.Address, arg1 [32]byte) (bool, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "isRewardsSubmissionForAllHash", arg0, arg1)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// IsRewardsSubmissionForAllHash is a free data retrieval call binding the contract method 0xc46db606.
//
// Solidity: function isRewardsSubmissionForAllHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorSession) IsRewardsSubmissionForAllHash(arg0 common.Address, arg1 [32]byte) (bool, error) {
	return _RewardsCoordinator.Contract.IsRewardsSubmissionForAllHash(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// IsRewardsSubmissionForAllHash is a free data retrieval call binding the contract method 0xc46db606.
//
// Solidity: function isRewardsSubmissionForAllHash(address , bytes32 ) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) IsRewardsSubmissionForAllHash(arg0 common.Address, arg1 [32]byte) (bool, error) {
	return _RewardsCoordinator.Contract.IsRewardsSubmissionForAllHash(&_RewardsCoordinator.CallOpts, arg0, arg1)
}

// OperatorCommissionBips is a free data retrieval call binding the contract method 0x22f19a64.
//
// Solidity: function operatorCommissionBips(address operator, address avs) view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorCaller) OperatorCommissionBips(opts *bind.CallOpts, operator common.Address, avs common.Address) (uint16, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "operatorCommissionBips", operator, avs)

	if err != nil {
		return *new(uint16), err
	}

	out0 := *abi.ConvertType(out[0], new(uint16)).(*uint16)

	return out0, err

}

// OperatorCommissionBips is a free data retrieval call binding the contract method 0x22f19a64.
//
// Solidity: function operatorCommissionBips(address operator, address avs) view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorSession) OperatorCommissionBips(operator common.Address, avs common.Address) (uint16, error) {
	return _RewardsCoordinator.Contract.OperatorCommissionBips(&_RewardsCoordinator.CallOpts, operator, avs)
}

// OperatorCommissionBips is a free data retrieval call binding the contract method 0x22f19a64.
//
// Solidity: function operatorCommissionBips(address operator, address avs) view returns(uint16)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) OperatorCommissionBips(operator common.Address, avs common.Address) (uint16, error) {
	return _RewardsCoordinator.Contract.OperatorCommissionBips(&_RewardsCoordinator.CallOpts, operator, avs)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "owner")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) Owner() (common.Address, error) {
	return _RewardsCoordinator.Contract.Owner(&_RewardsCoordinator.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) Owner() (common.Address, error) {
	return _RewardsCoordinator.Contract.Owner(&_RewardsCoordinator.CallOpts)
}

// Paused is a free data retrieval call binding the contract method 0x5ac86ab7.
//
// Solidity: function paused(uint8 index) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCaller) Paused(opts *bind.CallOpts, index uint8) (bool, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "paused", index)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// Paused is a free data retrieval call binding the contract method 0x5ac86ab7.
//
// Solidity: function paused(uint8 index) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorSession) Paused(index uint8) (bool, error) {
	return _RewardsCoordinator.Contract.Paused(&_RewardsCoordinator.CallOpts, index)
}

// Paused is a free data retrieval call binding the contract method 0x5ac86ab7.
//
// Solidity: function paused(uint8 index) view returns(bool)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) Paused(index uint8) (bool, error) {
	return _RewardsCoordinator.Contract.Paused(&_RewardsCoordinator.CallOpts, index)
}

// Paused0 is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCaller) Paused0(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "paused0")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Paused0 is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorSession) Paused0() (*big.Int, error) {
	return _RewardsCoordinator.Contract.Paused0(&_RewardsCoordinator.CallOpts)
}

// Paused0 is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) Paused0() (*big.Int, error) {
	return _RewardsCoordinator.Contract.Paused0(&_RewardsCoordinator.CallOpts)
}

// PauserRegistry is a free data retrieval call binding the contract method 0x886f1195.
//
// Solidity: function pauserRegistry() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) PauserRegistry(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "pauserRegistry")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// PauserRegistry is a free data retrieval call binding the contract method 0x886f1195.
//
// Solidity: function pauserRegistry() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) PauserRegistry() (common.Address, error) {
	return _RewardsCoordinator.Contract.PauserRegistry(&_RewardsCoordinator.CallOpts)
}

// PauserRegistry is a free data retrieval call binding the contract method 0x886f1195.
//
// Solidity: function pauserRegistry() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) PauserRegistry() (common.Address, error) {
	return _RewardsCoordinator.Contract.PauserRegistry(&_RewardsCoordinator.CallOpts)
}

// RewardsUpdater is a free data retrieval call binding the contract method 0xfbf1e2c1.
//
// Solidity: function rewardsUpdater() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) RewardsUpdater(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "rewardsUpdater")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// RewardsUpdater is a free data retrieval call binding the contract method 0xfbf1e2c1.
//
// Solidity: function rewardsUpdater() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) RewardsUpdater() (common.Address, error) {
	return _RewardsCoordinator.Contract.RewardsUpdater(&_RewardsCoordinator.CallOpts)
}

// RewardsUpdater is a free data retrieval call binding the contract method 0xfbf1e2c1.
//
// Solidity: function rewardsUpdater() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) RewardsUpdater() (common.Address, error) {
	return _RewardsCoordinator.Contract.RewardsUpdater(&_RewardsCoordinator.CallOpts)
}

// StrategyManager is a free data retrieval call binding the contract method 0x39b70e38.
//
// Solidity: function strategyManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCaller) StrategyManager(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "strategyManager")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// StrategyManager is a free data retrieval call binding the contract method 0x39b70e38.
//
// Solidity: function strategyManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorSession) StrategyManager() (common.Address, error) {
	return _RewardsCoordinator.Contract.StrategyManager(&_RewardsCoordinator.CallOpts)
}

// StrategyManager is a free data retrieval call binding the contract method 0x39b70e38.
//
// Solidity: function strategyManager() view returns(address)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) StrategyManager() (common.Address, error) {
	return _RewardsCoordinator.Contract.StrategyManager(&_RewardsCoordinator.CallOpts)
}

// SubmissionNonce is a free data retrieval call binding the contract method 0xbb7e451f.
//
// Solidity: function submissionNonce(address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCaller) SubmissionNonce(opts *bind.CallOpts, arg0 common.Address) (*big.Int, error) {
	var out []interface{}
	err := _RewardsCoordinator.contract.Call(opts, &out, "submissionNonce", arg0)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// SubmissionNonce is a free data retrieval call binding the contract method 0xbb7e451f.
//
// Solidity: function submissionNonce(address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorSession) SubmissionNonce(arg0 common.Address) (*big.Int, error) {
	return _RewardsCoordinator.Contract.SubmissionNonce(&_RewardsCoordinator.CallOpts, arg0)
}

// SubmissionNonce is a free data retrieval call binding the contract method 0xbb7e451f.
//
// Solidity: function submissionNonce(address ) view returns(uint256)
func (_RewardsCoordinator *RewardsCoordinatorCallerSession) SubmissionNonce(arg0 common.Address) (*big.Int, error) {
	return _RewardsCoordinator.Contract.SubmissionNonce(&_RewardsCoordinator.CallOpts, arg0)
}

// CreateAVSRewardsSubmission is a paid mutator transaction binding the contract method 0xfce36c7d.
//
// Solidity: function createAVSRewardsSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) CreateAVSRewardsSubmission(opts *bind.TransactOpts, rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "createAVSRewardsSubmission", rewardsSubmissions)
}

// CreateAVSRewardsSubmission is a paid mutator transaction binding the contract method 0xfce36c7d.
//
// Solidity: function createAVSRewardsSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) CreateAVSRewardsSubmission(rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.CreateAVSRewardsSubmission(&_RewardsCoordinator.TransactOpts, rewardsSubmissions)
}

// CreateAVSRewardsSubmission is a paid mutator transaction binding the contract method 0xfce36c7d.
//
// Solidity: function createAVSRewardsSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) CreateAVSRewardsSubmission(rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.CreateAVSRewardsSubmission(&_RewardsCoordinator.TransactOpts, rewardsSubmissions)
}

// CreateRewardsForAllSubmission is a paid mutator transaction binding the contract method 0x36af41fa.
//
// Solidity: function createRewardsForAllSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) CreateRewardsForAllSubmission(opts *bind.TransactOpts, rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "createRewardsForAllSubmission", rewardsSubmissions)
}

// CreateRewardsForAllSubmission is a paid mutator transaction binding the contract method 0x36af41fa.
//
// Solidity: function createRewardsForAllSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) CreateRewardsForAllSubmission(rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.CreateRewardsForAllSubmission(&_RewardsCoordinator.TransactOpts, rewardsSubmissions)
}

// CreateRewardsForAllSubmission is a paid mutator transaction binding the contract method 0x36af41fa.
//
// Solidity: function createRewardsForAllSubmission(((address,uint96)[],address,uint256,uint32,uint32)[] rewardsSubmissions) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) CreateRewardsForAllSubmission(rewardsSubmissions []IRewardsCoordinatorRewardsSubmission) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.CreateRewardsForAllSubmission(&_RewardsCoordinator.TransactOpts, rewardsSubmissions)
}

// Initialize is a paid mutator transaction binding the contract method 0xd4540a55.
//
// Solidity: function initialize(address initialOwner, address _pauserRegistry, uint256 initialPausedStatus, address _rewardsUpdater, uint32 _activationDelay, uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) Initialize(opts *bind.TransactOpts, initialOwner common.Address, _pauserRegistry common.Address, initialPausedStatus *big.Int, _rewardsUpdater common.Address, _activationDelay uint32, _globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "initialize", initialOwner, _pauserRegistry, initialPausedStatus, _rewardsUpdater, _activationDelay, _globalCommissionBips)
}

// Initialize is a paid mutator transaction binding the contract method 0xd4540a55.
//
// Solidity: function initialize(address initialOwner, address _pauserRegistry, uint256 initialPausedStatus, address _rewardsUpdater, uint32 _activationDelay, uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) Initialize(initialOwner common.Address, _pauserRegistry common.Address, initialPausedStatus *big.Int, _rewardsUpdater common.Address, _activationDelay uint32, _globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Initialize(&_RewardsCoordinator.TransactOpts, initialOwner, _pauserRegistry, initialPausedStatus, _rewardsUpdater, _activationDelay, _globalCommissionBips)
}

// Initialize is a paid mutator transaction binding the contract method 0xd4540a55.
//
// Solidity: function initialize(address initialOwner, address _pauserRegistry, uint256 initialPausedStatus, address _rewardsUpdater, uint32 _activationDelay, uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) Initialize(initialOwner common.Address, _pauserRegistry common.Address, initialPausedStatus *big.Int, _rewardsUpdater common.Address, _activationDelay uint32, _globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Initialize(&_RewardsCoordinator.TransactOpts, initialOwner, _pauserRegistry, initialPausedStatus, _rewardsUpdater, _activationDelay, _globalCommissionBips)
}

// Pause is a paid mutator transaction binding the contract method 0x136439dd.
//
// Solidity: function pause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) Pause(opts *bind.TransactOpts, newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "pause", newPausedStatus)
}

// Pause is a paid mutator transaction binding the contract method 0x136439dd.
//
// Solidity: function pause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) Pause(newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Pause(&_RewardsCoordinator.TransactOpts, newPausedStatus)
}

// Pause is a paid mutator transaction binding the contract method 0x136439dd.
//
// Solidity: function pause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) Pause(newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Pause(&_RewardsCoordinator.TransactOpts, newPausedStatus)
}

// PauseAll is a paid mutator transaction binding the contract method 0x595c6a67.
//
// Solidity: function pauseAll() returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) PauseAll(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "pauseAll")
}

// PauseAll is a paid mutator transaction binding the contract method 0x595c6a67.
//
// Solidity: function pauseAll() returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) PauseAll() (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.PauseAll(&_RewardsCoordinator.TransactOpts)
}

// PauseAll is a paid mutator transaction binding the contract method 0x595c6a67.
//
// Solidity: function pauseAll() returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) PauseAll() (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.PauseAll(&_RewardsCoordinator.TransactOpts)
}

// ProcessClaim is a paid mutator transaction binding the contract method 0x3ccc861d.
//
// Solidity: function processClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim, address recipient) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) ProcessClaim(opts *bind.TransactOpts, claim IRewardsCoordinatorRewardsMerkleClaim, recipient common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "processClaim", claim, recipient)
}

// ProcessClaim is a paid mutator transaction binding the contract method 0x3ccc861d.
//
// Solidity: function processClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim, address recipient) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) ProcessClaim(claim IRewardsCoordinatorRewardsMerkleClaim, recipient common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.ProcessClaim(&_RewardsCoordinator.TransactOpts, claim, recipient)
}

// ProcessClaim is a paid mutator transaction binding the contract method 0x3ccc861d.
//
// Solidity: function processClaim((uint32,uint32,bytes,(address,bytes32),uint32[],bytes[],(address,uint256)[]) claim, address recipient) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) ProcessClaim(claim IRewardsCoordinatorRewardsMerkleClaim, recipient common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.ProcessClaim(&_RewardsCoordinator.TransactOpts, claim, recipient)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) RenounceOwnership(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "renounceOwnership")
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) RenounceOwnership() (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.RenounceOwnership(&_RewardsCoordinator.TransactOpts)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) RenounceOwnership() (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.RenounceOwnership(&_RewardsCoordinator.TransactOpts)
}

// SetActivationDelay is a paid mutator transaction binding the contract method 0x58baaa3e.
//
// Solidity: function setActivationDelay(uint32 _activationDelay) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetActivationDelay(opts *bind.TransactOpts, _activationDelay uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setActivationDelay", _activationDelay)
}

// SetActivationDelay is a paid mutator transaction binding the contract method 0x58baaa3e.
//
// Solidity: function setActivationDelay(uint32 _activationDelay) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetActivationDelay(_activationDelay uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetActivationDelay(&_RewardsCoordinator.TransactOpts, _activationDelay)
}

// SetActivationDelay is a paid mutator transaction binding the contract method 0x58baaa3e.
//
// Solidity: function setActivationDelay(uint32 _activationDelay) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetActivationDelay(_activationDelay uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetActivationDelay(&_RewardsCoordinator.TransactOpts, _activationDelay)
}

// SetClaimerFor is a paid mutator transaction binding the contract method 0xa0169ddd.
//
// Solidity: function setClaimerFor(address claimer) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetClaimerFor(opts *bind.TransactOpts, claimer common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setClaimerFor", claimer)
}

// SetClaimerFor is a paid mutator transaction binding the contract method 0xa0169ddd.
//
// Solidity: function setClaimerFor(address claimer) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetClaimerFor(claimer common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetClaimerFor(&_RewardsCoordinator.TransactOpts, claimer)
}

// SetClaimerFor is a paid mutator transaction binding the contract method 0xa0169ddd.
//
// Solidity: function setClaimerFor(address claimer) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetClaimerFor(claimer common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetClaimerFor(&_RewardsCoordinator.TransactOpts, claimer)
}

// SetGlobalOperatorCommission is a paid mutator transaction binding the contract method 0xe221b245.
//
// Solidity: function setGlobalOperatorCommission(uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetGlobalOperatorCommission(opts *bind.TransactOpts, _globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setGlobalOperatorCommission", _globalCommissionBips)
}

// SetGlobalOperatorCommission is a paid mutator transaction binding the contract method 0xe221b245.
//
// Solidity: function setGlobalOperatorCommission(uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetGlobalOperatorCommission(_globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetGlobalOperatorCommission(&_RewardsCoordinator.TransactOpts, _globalCommissionBips)
}

// SetGlobalOperatorCommission is a paid mutator transaction binding the contract method 0xe221b245.
//
// Solidity: function setGlobalOperatorCommission(uint16 _globalCommissionBips) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetGlobalOperatorCommission(_globalCommissionBips uint16) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetGlobalOperatorCommission(&_RewardsCoordinator.TransactOpts, _globalCommissionBips)
}

// SetPauserRegistry is a paid mutator transaction binding the contract method 0x10d67a2f.
//
// Solidity: function setPauserRegistry(address newPauserRegistry) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetPauserRegistry(opts *bind.TransactOpts, newPauserRegistry common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setPauserRegistry", newPauserRegistry)
}

// SetPauserRegistry is a paid mutator transaction binding the contract method 0x10d67a2f.
//
// Solidity: function setPauserRegistry(address newPauserRegistry) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetPauserRegistry(newPauserRegistry common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetPauserRegistry(&_RewardsCoordinator.TransactOpts, newPauserRegistry)
}

// SetPauserRegistry is a paid mutator transaction binding the contract method 0x10d67a2f.
//
// Solidity: function setPauserRegistry(address newPauserRegistry) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetPauserRegistry(newPauserRegistry common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetPauserRegistry(&_RewardsCoordinator.TransactOpts, newPauserRegistry)
}

// SetRewardsForAllSubmitter is a paid mutator transaction binding the contract method 0x0eb38345.
//
// Solidity: function setRewardsForAllSubmitter(address _submitter, bool _newValue) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetRewardsForAllSubmitter(opts *bind.TransactOpts, _submitter common.Address, _newValue bool) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setRewardsForAllSubmitter", _submitter, _newValue)
}

// SetRewardsForAllSubmitter is a paid mutator transaction binding the contract method 0x0eb38345.
//
// Solidity: function setRewardsForAllSubmitter(address _submitter, bool _newValue) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetRewardsForAllSubmitter(_submitter common.Address, _newValue bool) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetRewardsForAllSubmitter(&_RewardsCoordinator.TransactOpts, _submitter, _newValue)
}

// SetRewardsForAllSubmitter is a paid mutator transaction binding the contract method 0x0eb38345.
//
// Solidity: function setRewardsForAllSubmitter(address _submitter, bool _newValue) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetRewardsForAllSubmitter(_submitter common.Address, _newValue bool) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetRewardsForAllSubmitter(&_RewardsCoordinator.TransactOpts, _submitter, _newValue)
}

// SetRewardsUpdater is a paid mutator transaction binding the contract method 0x863cb9a9.
//
// Solidity: function setRewardsUpdater(address _rewardsUpdater) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SetRewardsUpdater(opts *bind.TransactOpts, _rewardsUpdater common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "setRewardsUpdater", _rewardsUpdater)
}

// SetRewardsUpdater is a paid mutator transaction binding the contract method 0x863cb9a9.
//
// Solidity: function setRewardsUpdater(address _rewardsUpdater) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SetRewardsUpdater(_rewardsUpdater common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetRewardsUpdater(&_RewardsCoordinator.TransactOpts, _rewardsUpdater)
}

// SetRewardsUpdater is a paid mutator transaction binding the contract method 0x863cb9a9.
//
// Solidity: function setRewardsUpdater(address _rewardsUpdater) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SetRewardsUpdater(_rewardsUpdater common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SetRewardsUpdater(&_RewardsCoordinator.TransactOpts, _rewardsUpdater)
}

// SubmitRoot is a paid mutator transaction binding the contract method 0x3efe1db6.
//
// Solidity: function submitRoot(bytes32 root, uint32 rewardsCalculationEndTimestamp) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) SubmitRoot(opts *bind.TransactOpts, root [32]byte, rewardsCalculationEndTimestamp uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "submitRoot", root, rewardsCalculationEndTimestamp)
}

// SubmitRoot is a paid mutator transaction binding the contract method 0x3efe1db6.
//
// Solidity: function submitRoot(bytes32 root, uint32 rewardsCalculationEndTimestamp) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) SubmitRoot(root [32]byte, rewardsCalculationEndTimestamp uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SubmitRoot(&_RewardsCoordinator.TransactOpts, root, rewardsCalculationEndTimestamp)
}

// SubmitRoot is a paid mutator transaction binding the contract method 0x3efe1db6.
//
// Solidity: function submitRoot(bytes32 root, uint32 rewardsCalculationEndTimestamp) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) SubmitRoot(root [32]byte, rewardsCalculationEndTimestamp uint32) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.SubmitRoot(&_RewardsCoordinator.TransactOpts, root, rewardsCalculationEndTimestamp)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) TransferOwnership(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "transferOwnership", newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.TransferOwnership(&_RewardsCoordinator.TransactOpts, newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.TransferOwnership(&_RewardsCoordinator.TransactOpts, newOwner)
}

// Unpause is a paid mutator transaction binding the contract method 0xfabc1cbc.
//
// Solidity: function unpause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactor) Unpause(opts *bind.TransactOpts, newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.contract.Transact(opts, "unpause", newPausedStatus)
}

// Unpause is a paid mutator transaction binding the contract method 0xfabc1cbc.
//
// Solidity: function unpause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorSession) Unpause(newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Unpause(&_RewardsCoordinator.TransactOpts, newPausedStatus)
}

// Unpause is a paid mutator transaction binding the contract method 0xfabc1cbc.
//
// Solidity: function unpause(uint256 newPausedStatus) returns()
func (_RewardsCoordinator *RewardsCoordinatorTransactorSession) Unpause(newPausedStatus *big.Int) (*types.Transaction, error) {
	return _RewardsCoordinator.Contract.Unpause(&_RewardsCoordinator.TransactOpts, newPausedStatus)
}

// RewardsCoordinatorAVSRewardsSubmissionCreatedIterator is returned from FilterAVSRewardsSubmissionCreated and is used to iterate over the raw logs and unpacked data for AVSRewardsSubmissionCreated events raised by the RewardsCoordinator contract.
type RewardsCoordinatorAVSRewardsSubmissionCreatedIterator struct {
	Event *RewardsCoordinatorAVSRewardsSubmissionCreated // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorAVSRewardsSubmissionCreatedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorAVSRewardsSubmissionCreated)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorAVSRewardsSubmissionCreated)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorAVSRewardsSubmissionCreatedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorAVSRewardsSubmissionCreatedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorAVSRewardsSubmissionCreated represents a AVSRewardsSubmissionCreated event raised by the RewardsCoordinator contract.
type RewardsCoordinatorAVSRewardsSubmissionCreated struct {
	Avs                   common.Address
	SubmissionNonce       *big.Int
	RewardsSubmissionHash [32]byte
	RewardsSubmission     IRewardsCoordinatorRewardsSubmission
	Raw                   types.Log // Blockchain specific contextual infos
}

// FilterAVSRewardsSubmissionCreated is a free log retrieval operation binding the contract event 0x450a367a380c4e339e5ae7340c8464ef27af7781ad9945cfe8abd828f89e6281.
//
// Solidity: event AVSRewardsSubmissionCreated(address indexed avs, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterAVSRewardsSubmissionCreated(opts *bind.FilterOpts, avs []common.Address, submissionNonce []*big.Int, rewardsSubmissionHash [][32]byte) (*RewardsCoordinatorAVSRewardsSubmissionCreatedIterator, error) {

	var avsRule []interface{}
	for _, avsItem := range avs {
		avsRule = append(avsRule, avsItem)
	}
	var submissionNonceRule []interface{}
	for _, submissionNonceItem := range submissionNonce {
		submissionNonceRule = append(submissionNonceRule, submissionNonceItem)
	}
	var rewardsSubmissionHashRule []interface{}
	for _, rewardsSubmissionHashItem := range rewardsSubmissionHash {
		rewardsSubmissionHashRule = append(rewardsSubmissionHashRule, rewardsSubmissionHashItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "AVSRewardsSubmissionCreated", avsRule, submissionNonceRule, rewardsSubmissionHashRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorAVSRewardsSubmissionCreatedIterator{contract: _RewardsCoordinator.contract, event: "AVSRewardsSubmissionCreated", logs: logs, sub: sub}, nil
}

// WatchAVSRewardsSubmissionCreated is a free log subscription operation binding the contract event 0x450a367a380c4e339e5ae7340c8464ef27af7781ad9945cfe8abd828f89e6281.
//
// Solidity: event AVSRewardsSubmissionCreated(address indexed avs, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchAVSRewardsSubmissionCreated(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorAVSRewardsSubmissionCreated, avs []common.Address, submissionNonce []*big.Int, rewardsSubmissionHash [][32]byte) (event.Subscription, error) {

	var avsRule []interface{}
	for _, avsItem := range avs {
		avsRule = append(avsRule, avsItem)
	}
	var submissionNonceRule []interface{}
	for _, submissionNonceItem := range submissionNonce {
		submissionNonceRule = append(submissionNonceRule, submissionNonceItem)
	}
	var rewardsSubmissionHashRule []interface{}
	for _, rewardsSubmissionHashItem := range rewardsSubmissionHash {
		rewardsSubmissionHashRule = append(rewardsSubmissionHashRule, rewardsSubmissionHashItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "AVSRewardsSubmissionCreated", avsRule, submissionNonceRule, rewardsSubmissionHashRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorAVSRewardsSubmissionCreated)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "AVSRewardsSubmissionCreated", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseAVSRewardsSubmissionCreated is a log parse operation binding the contract event 0x450a367a380c4e339e5ae7340c8464ef27af7781ad9945cfe8abd828f89e6281.
//
// Solidity: event AVSRewardsSubmissionCreated(address indexed avs, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseAVSRewardsSubmissionCreated(log types.Log) (*RewardsCoordinatorAVSRewardsSubmissionCreated, error) {
	event := new(RewardsCoordinatorAVSRewardsSubmissionCreated)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "AVSRewardsSubmissionCreated", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorActivationDelaySetIterator is returned from FilterActivationDelaySet and is used to iterate over the raw logs and unpacked data for ActivationDelaySet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorActivationDelaySetIterator struct {
	Event *RewardsCoordinatorActivationDelaySet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorActivationDelaySetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorActivationDelaySet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorActivationDelaySet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorActivationDelaySetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorActivationDelaySetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorActivationDelaySet represents a ActivationDelaySet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorActivationDelaySet struct {
	OldActivationDelay uint32
	NewActivationDelay uint32
	Raw                types.Log // Blockchain specific contextual infos
}

// FilterActivationDelaySet is a free log retrieval operation binding the contract event 0xaf557c6c02c208794817a705609cfa935f827312a1adfdd26494b6b95dd2b4b3.
//
// Solidity: event ActivationDelaySet(uint32 oldActivationDelay, uint32 newActivationDelay)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterActivationDelaySet(opts *bind.FilterOpts) (*RewardsCoordinatorActivationDelaySetIterator, error) {

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "ActivationDelaySet")
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorActivationDelaySetIterator{contract: _RewardsCoordinator.contract, event: "ActivationDelaySet", logs: logs, sub: sub}, nil
}

// WatchActivationDelaySet is a free log subscription operation binding the contract event 0xaf557c6c02c208794817a705609cfa935f827312a1adfdd26494b6b95dd2b4b3.
//
// Solidity: event ActivationDelaySet(uint32 oldActivationDelay, uint32 newActivationDelay)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchActivationDelaySet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorActivationDelaySet) (event.Subscription, error) {

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "ActivationDelaySet")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorActivationDelaySet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "ActivationDelaySet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseActivationDelaySet is a log parse operation binding the contract event 0xaf557c6c02c208794817a705609cfa935f827312a1adfdd26494b6b95dd2b4b3.
//
// Solidity: event ActivationDelaySet(uint32 oldActivationDelay, uint32 newActivationDelay)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseActivationDelaySet(log types.Log) (*RewardsCoordinatorActivationDelaySet, error) {
	event := new(RewardsCoordinatorActivationDelaySet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "ActivationDelaySet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorClaimerForSetIterator is returned from FilterClaimerForSet and is used to iterate over the raw logs and unpacked data for ClaimerForSet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorClaimerForSetIterator struct {
	Event *RewardsCoordinatorClaimerForSet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorClaimerForSetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorClaimerForSet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorClaimerForSet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorClaimerForSetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorClaimerForSetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorClaimerForSet represents a ClaimerForSet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorClaimerForSet struct {
	Earner     common.Address
	OldClaimer common.Address
	Claimer    common.Address
	Raw        types.Log // Blockchain specific contextual infos
}

// FilterClaimerForSet is a free log retrieval operation binding the contract event 0xbab947934d42e0ad206f25c9cab18b5bb6ae144acfb00f40b4e3aa59590ca312.
//
// Solidity: event ClaimerForSet(address indexed earner, address indexed oldClaimer, address indexed claimer)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterClaimerForSet(opts *bind.FilterOpts, earner []common.Address, oldClaimer []common.Address, claimer []common.Address) (*RewardsCoordinatorClaimerForSetIterator, error) {

	var earnerRule []interface{}
	for _, earnerItem := range earner {
		earnerRule = append(earnerRule, earnerItem)
	}
	var oldClaimerRule []interface{}
	for _, oldClaimerItem := range oldClaimer {
		oldClaimerRule = append(oldClaimerRule, oldClaimerItem)
	}
	var claimerRule []interface{}
	for _, claimerItem := range claimer {
		claimerRule = append(claimerRule, claimerItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "ClaimerForSet", earnerRule, oldClaimerRule, claimerRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorClaimerForSetIterator{contract: _RewardsCoordinator.contract, event: "ClaimerForSet", logs: logs, sub: sub}, nil
}

// WatchClaimerForSet is a free log subscription operation binding the contract event 0xbab947934d42e0ad206f25c9cab18b5bb6ae144acfb00f40b4e3aa59590ca312.
//
// Solidity: event ClaimerForSet(address indexed earner, address indexed oldClaimer, address indexed claimer)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchClaimerForSet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorClaimerForSet, earner []common.Address, oldClaimer []common.Address, claimer []common.Address) (event.Subscription, error) {

	var earnerRule []interface{}
	for _, earnerItem := range earner {
		earnerRule = append(earnerRule, earnerItem)
	}
	var oldClaimerRule []interface{}
	for _, oldClaimerItem := range oldClaimer {
		oldClaimerRule = append(oldClaimerRule, oldClaimerItem)
	}
	var claimerRule []interface{}
	for _, claimerItem := range claimer {
		claimerRule = append(claimerRule, claimerItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "ClaimerForSet", earnerRule, oldClaimerRule, claimerRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorClaimerForSet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "ClaimerForSet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseClaimerForSet is a log parse operation binding the contract event 0xbab947934d42e0ad206f25c9cab18b5bb6ae144acfb00f40b4e3aa59590ca312.
//
// Solidity: event ClaimerForSet(address indexed earner, address indexed oldClaimer, address indexed claimer)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseClaimerForSet(log types.Log) (*RewardsCoordinatorClaimerForSet, error) {
	event := new(RewardsCoordinatorClaimerForSet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "ClaimerForSet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorDistributionRootSubmittedIterator is returned from FilterDistributionRootSubmitted and is used to iterate over the raw logs and unpacked data for DistributionRootSubmitted events raised by the RewardsCoordinator contract.
type RewardsCoordinatorDistributionRootSubmittedIterator struct {
	Event *RewardsCoordinatorDistributionRootSubmitted // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorDistributionRootSubmittedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorDistributionRootSubmitted)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorDistributionRootSubmitted)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorDistributionRootSubmittedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorDistributionRootSubmittedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorDistributionRootSubmitted represents a DistributionRootSubmitted event raised by the RewardsCoordinator contract.
type RewardsCoordinatorDistributionRootSubmitted struct {
	RootIndex                      uint32
	Root                           [32]byte
	RewardsCalculationEndTimestamp uint32
	ActivatedAt                    uint32
	Raw                            types.Log // Blockchain specific contextual infos
}

// FilterDistributionRootSubmitted is a free log retrieval operation binding the contract event 0xecd866c3c158fa00bf34d803d5f6023000b57080bcb48af004c2b4b46b3afd08.
//
// Solidity: event DistributionRootSubmitted(uint32 indexed rootIndex, bytes32 indexed root, uint32 indexed rewardsCalculationEndTimestamp, uint32 activatedAt)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterDistributionRootSubmitted(opts *bind.FilterOpts, rootIndex []uint32, root [][32]byte, rewardsCalculationEndTimestamp []uint32) (*RewardsCoordinatorDistributionRootSubmittedIterator, error) {

	var rootIndexRule []interface{}
	for _, rootIndexItem := range rootIndex {
		rootIndexRule = append(rootIndexRule, rootIndexItem)
	}
	var rootRule []interface{}
	for _, rootItem := range root {
		rootRule = append(rootRule, rootItem)
	}
	var rewardsCalculationEndTimestampRule []interface{}
	for _, rewardsCalculationEndTimestampItem := range rewardsCalculationEndTimestamp {
		rewardsCalculationEndTimestampRule = append(rewardsCalculationEndTimestampRule, rewardsCalculationEndTimestampItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "DistributionRootSubmitted", rootIndexRule, rootRule, rewardsCalculationEndTimestampRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorDistributionRootSubmittedIterator{contract: _RewardsCoordinator.contract, event: "DistributionRootSubmitted", logs: logs, sub: sub}, nil
}

// WatchDistributionRootSubmitted is a free log subscription operation binding the contract event 0xecd866c3c158fa00bf34d803d5f6023000b57080bcb48af004c2b4b46b3afd08.
//
// Solidity: event DistributionRootSubmitted(uint32 indexed rootIndex, bytes32 indexed root, uint32 indexed rewardsCalculationEndTimestamp, uint32 activatedAt)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchDistributionRootSubmitted(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorDistributionRootSubmitted, rootIndex []uint32, root [][32]byte, rewardsCalculationEndTimestamp []uint32) (event.Subscription, error) {

	var rootIndexRule []interface{}
	for _, rootIndexItem := range rootIndex {
		rootIndexRule = append(rootIndexRule, rootIndexItem)
	}
	var rootRule []interface{}
	for _, rootItem := range root {
		rootRule = append(rootRule, rootItem)
	}
	var rewardsCalculationEndTimestampRule []interface{}
	for _, rewardsCalculationEndTimestampItem := range rewardsCalculationEndTimestamp {
		rewardsCalculationEndTimestampRule = append(rewardsCalculationEndTimestampRule, rewardsCalculationEndTimestampItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "DistributionRootSubmitted", rootIndexRule, rootRule, rewardsCalculationEndTimestampRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorDistributionRootSubmitted)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "DistributionRootSubmitted", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseDistributionRootSubmitted is a log parse operation binding the contract event 0xecd866c3c158fa00bf34d803d5f6023000b57080bcb48af004c2b4b46b3afd08.
//
// Solidity: event DistributionRootSubmitted(uint32 indexed rootIndex, bytes32 indexed root, uint32 indexed rewardsCalculationEndTimestamp, uint32 activatedAt)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseDistributionRootSubmitted(log types.Log) (*RewardsCoordinatorDistributionRootSubmitted, error) {
	event := new(RewardsCoordinatorDistributionRootSubmitted)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "DistributionRootSubmitted", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorGlobalCommissionBipsSetIterator is returned from FilterGlobalCommissionBipsSet and is used to iterate over the raw logs and unpacked data for GlobalCommissionBipsSet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorGlobalCommissionBipsSetIterator struct {
	Event *RewardsCoordinatorGlobalCommissionBipsSet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorGlobalCommissionBipsSetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorGlobalCommissionBipsSet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorGlobalCommissionBipsSet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorGlobalCommissionBipsSetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorGlobalCommissionBipsSetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorGlobalCommissionBipsSet represents a GlobalCommissionBipsSet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorGlobalCommissionBipsSet struct {
	OldGlobalCommissionBips uint16
	NewGlobalCommissionBips uint16
	Raw                     types.Log // Blockchain specific contextual infos
}

// FilterGlobalCommissionBipsSet is a free log retrieval operation binding the contract event 0x8cdc428b0431b82d1619763f443a48197db344ba96905f3949643acd1c863a06.
//
// Solidity: event GlobalCommissionBipsSet(uint16 oldGlobalCommissionBips, uint16 newGlobalCommissionBips)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterGlobalCommissionBipsSet(opts *bind.FilterOpts) (*RewardsCoordinatorGlobalCommissionBipsSetIterator, error) {

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "GlobalCommissionBipsSet")
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorGlobalCommissionBipsSetIterator{contract: _RewardsCoordinator.contract, event: "GlobalCommissionBipsSet", logs: logs, sub: sub}, nil
}

// WatchGlobalCommissionBipsSet is a free log subscription operation binding the contract event 0x8cdc428b0431b82d1619763f443a48197db344ba96905f3949643acd1c863a06.
//
// Solidity: event GlobalCommissionBipsSet(uint16 oldGlobalCommissionBips, uint16 newGlobalCommissionBips)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchGlobalCommissionBipsSet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorGlobalCommissionBipsSet) (event.Subscription, error) {

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "GlobalCommissionBipsSet")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorGlobalCommissionBipsSet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "GlobalCommissionBipsSet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseGlobalCommissionBipsSet is a log parse operation binding the contract event 0x8cdc428b0431b82d1619763f443a48197db344ba96905f3949643acd1c863a06.
//
// Solidity: event GlobalCommissionBipsSet(uint16 oldGlobalCommissionBips, uint16 newGlobalCommissionBips)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseGlobalCommissionBipsSet(log types.Log) (*RewardsCoordinatorGlobalCommissionBipsSet, error) {
	event := new(RewardsCoordinatorGlobalCommissionBipsSet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "GlobalCommissionBipsSet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorInitializedIterator is returned from FilterInitialized and is used to iterate over the raw logs and unpacked data for Initialized events raised by the RewardsCoordinator contract.
type RewardsCoordinatorInitializedIterator struct {
	Event *RewardsCoordinatorInitialized // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorInitializedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorInitialized)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorInitialized)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorInitializedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorInitializedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorInitialized represents a Initialized event raised by the RewardsCoordinator contract.
type RewardsCoordinatorInitialized struct {
	Version uint8
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterInitialized is a free log retrieval operation binding the contract event 0x7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb3847402498.
//
// Solidity: event Initialized(uint8 version)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterInitialized(opts *bind.FilterOpts) (*RewardsCoordinatorInitializedIterator, error) {

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "Initialized")
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorInitializedIterator{contract: _RewardsCoordinator.contract, event: "Initialized", logs: logs, sub: sub}, nil
}

// WatchInitialized is a free log subscription operation binding the contract event 0x7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb3847402498.
//
// Solidity: event Initialized(uint8 version)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchInitialized(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorInitialized) (event.Subscription, error) {

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "Initialized")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorInitialized)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "Initialized", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseInitialized is a log parse operation binding the contract event 0x7f26b83ff96e1f2b6a682f133852f6798a09c465da95921460cefb3847402498.
//
// Solidity: event Initialized(uint8 version)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseInitialized(log types.Log) (*RewardsCoordinatorInitialized, error) {
	event := new(RewardsCoordinatorInitialized)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "Initialized", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorOwnershipTransferredIterator is returned from FilterOwnershipTransferred and is used to iterate over the raw logs and unpacked data for OwnershipTransferred events raised by the RewardsCoordinator contract.
type RewardsCoordinatorOwnershipTransferredIterator struct {
	Event *RewardsCoordinatorOwnershipTransferred // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorOwnershipTransferredIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorOwnershipTransferred)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorOwnershipTransferred)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorOwnershipTransferredIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorOwnershipTransferredIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorOwnershipTransferred represents a OwnershipTransferred event raised by the RewardsCoordinator contract.
type RewardsCoordinatorOwnershipTransferred struct {
	PreviousOwner common.Address
	NewOwner      common.Address
	Raw           types.Log // Blockchain specific contextual infos
}

// FilterOwnershipTransferred is a free log retrieval operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterOwnershipTransferred(opts *bind.FilterOpts, previousOwner []common.Address, newOwner []common.Address) (*RewardsCoordinatorOwnershipTransferredIterator, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorOwnershipTransferredIterator{contract: _RewardsCoordinator.contract, event: "OwnershipTransferred", logs: logs, sub: sub}, nil
}

// WatchOwnershipTransferred is a free log subscription operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchOwnershipTransferred(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorOwnershipTransferred, previousOwner []common.Address, newOwner []common.Address) (event.Subscription, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorOwnershipTransferred)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseOwnershipTransferred is a log parse operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseOwnershipTransferred(log types.Log) (*RewardsCoordinatorOwnershipTransferred, error) {
	event := new(RewardsCoordinatorOwnershipTransferred)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorPausedIterator is returned from FilterPaused and is used to iterate over the raw logs and unpacked data for Paused events raised by the RewardsCoordinator contract.
type RewardsCoordinatorPausedIterator struct {
	Event *RewardsCoordinatorPaused // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorPausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorPaused)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorPaused)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorPausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorPausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorPaused represents a Paused event raised by the RewardsCoordinator contract.
type RewardsCoordinatorPaused struct {
	Account         common.Address
	NewPausedStatus *big.Int
	Raw             types.Log // Blockchain specific contextual infos
}

// FilterPaused is a free log retrieval operation binding the contract event 0xab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d.
//
// Solidity: event Paused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterPaused(opts *bind.FilterOpts, account []common.Address) (*RewardsCoordinatorPausedIterator, error) {

	var accountRule []interface{}
	for _, accountItem := range account {
		accountRule = append(accountRule, accountItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "Paused", accountRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorPausedIterator{contract: _RewardsCoordinator.contract, event: "Paused", logs: logs, sub: sub}, nil
}

// WatchPaused is a free log subscription operation binding the contract event 0xab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d.
//
// Solidity: event Paused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchPaused(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorPaused, account []common.Address) (event.Subscription, error) {

	var accountRule []interface{}
	for _, accountItem := range account {
		accountRule = append(accountRule, accountItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "Paused", accountRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorPaused)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "Paused", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParsePaused is a log parse operation binding the contract event 0xab40a374bc51de372200a8bc981af8c9ecdc08dfdaef0bb6e09f88f3c616ef3d.
//
// Solidity: event Paused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParsePaused(log types.Log) (*RewardsCoordinatorPaused, error) {
	event := new(RewardsCoordinatorPaused)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "Paused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorPauserRegistrySetIterator is returned from FilterPauserRegistrySet and is used to iterate over the raw logs and unpacked data for PauserRegistrySet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorPauserRegistrySetIterator struct {
	Event *RewardsCoordinatorPauserRegistrySet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorPauserRegistrySetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorPauserRegistrySet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorPauserRegistrySet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorPauserRegistrySetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorPauserRegistrySetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorPauserRegistrySet represents a PauserRegistrySet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorPauserRegistrySet struct {
	PauserRegistry    common.Address
	NewPauserRegistry common.Address
	Raw               types.Log // Blockchain specific contextual infos
}

// FilterPauserRegistrySet is a free log retrieval operation binding the contract event 0x6e9fcd539896fca60e8b0f01dd580233e48a6b0f7df013b89ba7f565869acdb6.
//
// Solidity: event PauserRegistrySet(address pauserRegistry, address newPauserRegistry)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterPauserRegistrySet(opts *bind.FilterOpts) (*RewardsCoordinatorPauserRegistrySetIterator, error) {

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "PauserRegistrySet")
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorPauserRegistrySetIterator{contract: _RewardsCoordinator.contract, event: "PauserRegistrySet", logs: logs, sub: sub}, nil
}

// WatchPauserRegistrySet is a free log subscription operation binding the contract event 0x6e9fcd539896fca60e8b0f01dd580233e48a6b0f7df013b89ba7f565869acdb6.
//
// Solidity: event PauserRegistrySet(address pauserRegistry, address newPauserRegistry)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchPauserRegistrySet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorPauserRegistrySet) (event.Subscription, error) {

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "PauserRegistrySet")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorPauserRegistrySet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "PauserRegistrySet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParsePauserRegistrySet is a log parse operation binding the contract event 0x6e9fcd539896fca60e8b0f01dd580233e48a6b0f7df013b89ba7f565869acdb6.
//
// Solidity: event PauserRegistrySet(address pauserRegistry, address newPauserRegistry)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParsePauserRegistrySet(log types.Log) (*RewardsCoordinatorPauserRegistrySet, error) {
	event := new(RewardsCoordinatorPauserRegistrySet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "PauserRegistrySet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorRewardsClaimedIterator is returned from FilterRewardsClaimed and is used to iterate over the raw logs and unpacked data for RewardsClaimed events raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsClaimedIterator struct {
	Event *RewardsCoordinatorRewardsClaimed // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorRewardsClaimedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorRewardsClaimed)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorRewardsClaimed)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorRewardsClaimedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorRewardsClaimedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorRewardsClaimed represents a RewardsClaimed event raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsClaimed struct {
	Root          [32]byte
	Earner        common.Address
	Claimer       common.Address
	Recipient     common.Address
	Token         common.Address
	ClaimedAmount *big.Int
	Raw           types.Log // Blockchain specific contextual infos
}

// FilterRewardsClaimed is a free log retrieval operation binding the contract event 0x9543dbd55580842586a951f0386e24d68a5df99ae29e3b216588b45fd684ce31.
//
// Solidity: event RewardsClaimed(bytes32 root, address indexed earner, address indexed claimer, address indexed recipient, address token, uint256 claimedAmount)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterRewardsClaimed(opts *bind.FilterOpts, earner []common.Address, claimer []common.Address, recipient []common.Address) (*RewardsCoordinatorRewardsClaimedIterator, error) {

	var earnerRule []interface{}
	for _, earnerItem := range earner {
		earnerRule = append(earnerRule, earnerItem)
	}
	var claimerRule []interface{}
	for _, claimerItem := range claimer {
		claimerRule = append(claimerRule, claimerItem)
	}
	var recipientRule []interface{}
	for _, recipientItem := range recipient {
		recipientRule = append(recipientRule, recipientItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "RewardsClaimed", earnerRule, claimerRule, recipientRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorRewardsClaimedIterator{contract: _RewardsCoordinator.contract, event: "RewardsClaimed", logs: logs, sub: sub}, nil
}

// WatchRewardsClaimed is a free log subscription operation binding the contract event 0x9543dbd55580842586a951f0386e24d68a5df99ae29e3b216588b45fd684ce31.
//
// Solidity: event RewardsClaimed(bytes32 root, address indexed earner, address indexed claimer, address indexed recipient, address token, uint256 claimedAmount)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchRewardsClaimed(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorRewardsClaimed, earner []common.Address, claimer []common.Address, recipient []common.Address) (event.Subscription, error) {

	var earnerRule []interface{}
	for _, earnerItem := range earner {
		earnerRule = append(earnerRule, earnerItem)
	}
	var claimerRule []interface{}
	for _, claimerItem := range claimer {
		claimerRule = append(claimerRule, claimerItem)
	}
	var recipientRule []interface{}
	for _, recipientItem := range recipient {
		recipientRule = append(recipientRule, recipientItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "RewardsClaimed", earnerRule, claimerRule, recipientRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorRewardsClaimed)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsClaimed", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseRewardsClaimed is a log parse operation binding the contract event 0x9543dbd55580842586a951f0386e24d68a5df99ae29e3b216588b45fd684ce31.
//
// Solidity: event RewardsClaimed(bytes32 root, address indexed earner, address indexed claimer, address indexed recipient, address token, uint256 claimedAmount)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseRewardsClaimed(log types.Log) (*RewardsCoordinatorRewardsClaimed, error) {
	event := new(RewardsCoordinatorRewardsClaimed)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsClaimed", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorRewardsForAllSubmitterSetIterator is returned from FilterRewardsForAllSubmitterSet and is used to iterate over the raw logs and unpacked data for RewardsForAllSubmitterSet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsForAllSubmitterSetIterator struct {
	Event *RewardsCoordinatorRewardsForAllSubmitterSet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorRewardsForAllSubmitterSetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorRewardsForAllSubmitterSet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorRewardsForAllSubmitterSet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorRewardsForAllSubmitterSetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorRewardsForAllSubmitterSetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorRewardsForAllSubmitterSet represents a RewardsForAllSubmitterSet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsForAllSubmitterSet struct {
	RewardsForAllSubmitter common.Address
	OldValue               bool
	NewValue               bool
	Raw                    types.Log // Blockchain specific contextual infos
}

// FilterRewardsForAllSubmitterSet is a free log retrieval operation binding the contract event 0x4de6293e668df1398422e1def12118052c1539a03cbfedc145895d48d7685f1c.
//
// Solidity: event RewardsForAllSubmitterSet(address indexed rewardsForAllSubmitter, bool indexed oldValue, bool indexed newValue)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterRewardsForAllSubmitterSet(opts *bind.FilterOpts, rewardsForAllSubmitter []common.Address, oldValue []bool, newValue []bool) (*RewardsCoordinatorRewardsForAllSubmitterSetIterator, error) {

	var rewardsForAllSubmitterRule []interface{}
	for _, rewardsForAllSubmitterItem := range rewardsForAllSubmitter {
		rewardsForAllSubmitterRule = append(rewardsForAllSubmitterRule, rewardsForAllSubmitterItem)
	}
	var oldValueRule []interface{}
	for _, oldValueItem := range oldValue {
		oldValueRule = append(oldValueRule, oldValueItem)
	}
	var newValueRule []interface{}
	for _, newValueItem := range newValue {
		newValueRule = append(newValueRule, newValueItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "RewardsForAllSubmitterSet", rewardsForAllSubmitterRule, oldValueRule, newValueRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorRewardsForAllSubmitterSetIterator{contract: _RewardsCoordinator.contract, event: "RewardsForAllSubmitterSet", logs: logs, sub: sub}, nil
}

// WatchRewardsForAllSubmitterSet is a free log subscription operation binding the contract event 0x4de6293e668df1398422e1def12118052c1539a03cbfedc145895d48d7685f1c.
//
// Solidity: event RewardsForAllSubmitterSet(address indexed rewardsForAllSubmitter, bool indexed oldValue, bool indexed newValue)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchRewardsForAllSubmitterSet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorRewardsForAllSubmitterSet, rewardsForAllSubmitter []common.Address, oldValue []bool, newValue []bool) (event.Subscription, error) {

	var rewardsForAllSubmitterRule []interface{}
	for _, rewardsForAllSubmitterItem := range rewardsForAllSubmitter {
		rewardsForAllSubmitterRule = append(rewardsForAllSubmitterRule, rewardsForAllSubmitterItem)
	}
	var oldValueRule []interface{}
	for _, oldValueItem := range oldValue {
		oldValueRule = append(oldValueRule, oldValueItem)
	}
	var newValueRule []interface{}
	for _, newValueItem := range newValue {
		newValueRule = append(newValueRule, newValueItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "RewardsForAllSubmitterSet", rewardsForAllSubmitterRule, oldValueRule, newValueRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorRewardsForAllSubmitterSet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsForAllSubmitterSet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseRewardsForAllSubmitterSet is a log parse operation binding the contract event 0x4de6293e668df1398422e1def12118052c1539a03cbfedc145895d48d7685f1c.
//
// Solidity: event RewardsForAllSubmitterSet(address indexed rewardsForAllSubmitter, bool indexed oldValue, bool indexed newValue)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseRewardsForAllSubmitterSet(log types.Log) (*RewardsCoordinatorRewardsForAllSubmitterSet, error) {
	event := new(RewardsCoordinatorRewardsForAllSubmitterSet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsForAllSubmitterSet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorRewardsSubmissionForAllCreatedIterator is returned from FilterRewardsSubmissionForAllCreated and is used to iterate over the raw logs and unpacked data for RewardsSubmissionForAllCreated events raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsSubmissionForAllCreatedIterator struct {
	Event *RewardsCoordinatorRewardsSubmissionForAllCreated // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorRewardsSubmissionForAllCreatedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorRewardsSubmissionForAllCreated)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorRewardsSubmissionForAllCreated)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorRewardsSubmissionForAllCreatedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorRewardsSubmissionForAllCreatedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorRewardsSubmissionForAllCreated represents a RewardsSubmissionForAllCreated event raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsSubmissionForAllCreated struct {
	Submitter             common.Address
	SubmissionNonce       *big.Int
	RewardsSubmissionHash [32]byte
	RewardsSubmission     IRewardsCoordinatorRewardsSubmission
	Raw                   types.Log // Blockchain specific contextual infos
}

// FilterRewardsSubmissionForAllCreated is a free log retrieval operation binding the contract event 0x51088b8c89628df3a8174002c2a034d0152fce6af8415d651b2a4734bf270482.
//
// Solidity: event RewardsSubmissionForAllCreated(address indexed submitter, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterRewardsSubmissionForAllCreated(opts *bind.FilterOpts, submitter []common.Address, submissionNonce []*big.Int, rewardsSubmissionHash [][32]byte) (*RewardsCoordinatorRewardsSubmissionForAllCreatedIterator, error) {

	var submitterRule []interface{}
	for _, submitterItem := range submitter {
		submitterRule = append(submitterRule, submitterItem)
	}
	var submissionNonceRule []interface{}
	for _, submissionNonceItem := range submissionNonce {
		submissionNonceRule = append(submissionNonceRule, submissionNonceItem)
	}
	var rewardsSubmissionHashRule []interface{}
	for _, rewardsSubmissionHashItem := range rewardsSubmissionHash {
		rewardsSubmissionHashRule = append(rewardsSubmissionHashRule, rewardsSubmissionHashItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "RewardsSubmissionForAllCreated", submitterRule, submissionNonceRule, rewardsSubmissionHashRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorRewardsSubmissionForAllCreatedIterator{contract: _RewardsCoordinator.contract, event: "RewardsSubmissionForAllCreated", logs: logs, sub: sub}, nil
}

// WatchRewardsSubmissionForAllCreated is a free log subscription operation binding the contract event 0x51088b8c89628df3a8174002c2a034d0152fce6af8415d651b2a4734bf270482.
//
// Solidity: event RewardsSubmissionForAllCreated(address indexed submitter, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchRewardsSubmissionForAllCreated(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorRewardsSubmissionForAllCreated, submitter []common.Address, submissionNonce []*big.Int, rewardsSubmissionHash [][32]byte) (event.Subscription, error) {

	var submitterRule []interface{}
	for _, submitterItem := range submitter {
		submitterRule = append(submitterRule, submitterItem)
	}
	var submissionNonceRule []interface{}
	for _, submissionNonceItem := range submissionNonce {
		submissionNonceRule = append(submissionNonceRule, submissionNonceItem)
	}
	var rewardsSubmissionHashRule []interface{}
	for _, rewardsSubmissionHashItem := range rewardsSubmissionHash {
		rewardsSubmissionHashRule = append(rewardsSubmissionHashRule, rewardsSubmissionHashItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "RewardsSubmissionForAllCreated", submitterRule, submissionNonceRule, rewardsSubmissionHashRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorRewardsSubmissionForAllCreated)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsSubmissionForAllCreated", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseRewardsSubmissionForAllCreated is a log parse operation binding the contract event 0x51088b8c89628df3a8174002c2a034d0152fce6af8415d651b2a4734bf270482.
//
// Solidity: event RewardsSubmissionForAllCreated(address indexed submitter, uint256 indexed submissionNonce, bytes32 indexed rewardsSubmissionHash, ((address,uint96)[],address,uint256,uint32,uint32) rewardsSubmission)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseRewardsSubmissionForAllCreated(log types.Log) (*RewardsCoordinatorRewardsSubmissionForAllCreated, error) {
	event := new(RewardsCoordinatorRewardsSubmissionForAllCreated)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsSubmissionForAllCreated", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorRewardsUpdaterSetIterator is returned from FilterRewardsUpdaterSet and is used to iterate over the raw logs and unpacked data for RewardsUpdaterSet events raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsUpdaterSetIterator struct {
	Event *RewardsCoordinatorRewardsUpdaterSet // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorRewardsUpdaterSetIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorRewardsUpdaterSet)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorRewardsUpdaterSet)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorRewardsUpdaterSetIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorRewardsUpdaterSetIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorRewardsUpdaterSet represents a RewardsUpdaterSet event raised by the RewardsCoordinator contract.
type RewardsCoordinatorRewardsUpdaterSet struct {
	OldRewardsUpdater common.Address
	NewRewardsUpdater common.Address
	Raw               types.Log // Blockchain specific contextual infos
}

// FilterRewardsUpdaterSet is a free log retrieval operation binding the contract event 0x237b82f438d75fc568ebab484b75b01d9287b9e98b490b7c23221623b6705dbb.
//
// Solidity: event RewardsUpdaterSet(address indexed oldRewardsUpdater, address indexed newRewardsUpdater)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterRewardsUpdaterSet(opts *bind.FilterOpts, oldRewardsUpdater []common.Address, newRewardsUpdater []common.Address) (*RewardsCoordinatorRewardsUpdaterSetIterator, error) {

	var oldRewardsUpdaterRule []interface{}
	for _, oldRewardsUpdaterItem := range oldRewardsUpdater {
		oldRewardsUpdaterRule = append(oldRewardsUpdaterRule, oldRewardsUpdaterItem)
	}
	var newRewardsUpdaterRule []interface{}
	for _, newRewardsUpdaterItem := range newRewardsUpdater {
		newRewardsUpdaterRule = append(newRewardsUpdaterRule, newRewardsUpdaterItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "RewardsUpdaterSet", oldRewardsUpdaterRule, newRewardsUpdaterRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorRewardsUpdaterSetIterator{contract: _RewardsCoordinator.contract, event: "RewardsUpdaterSet", logs: logs, sub: sub}, nil
}

// WatchRewardsUpdaterSet is a free log subscription operation binding the contract event 0x237b82f438d75fc568ebab484b75b01d9287b9e98b490b7c23221623b6705dbb.
//
// Solidity: event RewardsUpdaterSet(address indexed oldRewardsUpdater, address indexed newRewardsUpdater)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchRewardsUpdaterSet(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorRewardsUpdaterSet, oldRewardsUpdater []common.Address, newRewardsUpdater []common.Address) (event.Subscription, error) {

	var oldRewardsUpdaterRule []interface{}
	for _, oldRewardsUpdaterItem := range oldRewardsUpdater {
		oldRewardsUpdaterRule = append(oldRewardsUpdaterRule, oldRewardsUpdaterItem)
	}
	var newRewardsUpdaterRule []interface{}
	for _, newRewardsUpdaterItem := range newRewardsUpdater {
		newRewardsUpdaterRule = append(newRewardsUpdaterRule, newRewardsUpdaterItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "RewardsUpdaterSet", oldRewardsUpdaterRule, newRewardsUpdaterRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorRewardsUpdaterSet)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsUpdaterSet", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseRewardsUpdaterSet is a log parse operation binding the contract event 0x237b82f438d75fc568ebab484b75b01d9287b9e98b490b7c23221623b6705dbb.
//
// Solidity: event RewardsUpdaterSet(address indexed oldRewardsUpdater, address indexed newRewardsUpdater)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseRewardsUpdaterSet(log types.Log) (*RewardsCoordinatorRewardsUpdaterSet, error) {
	event := new(RewardsCoordinatorRewardsUpdaterSet)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "RewardsUpdaterSet", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// RewardsCoordinatorUnpausedIterator is returned from FilterUnpaused and is used to iterate over the raw logs and unpacked data for Unpaused events raised by the RewardsCoordinator contract.
type RewardsCoordinatorUnpausedIterator struct {
	Event *RewardsCoordinatorUnpaused // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *RewardsCoordinatorUnpausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(RewardsCoordinatorUnpaused)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(RewardsCoordinatorUnpaused)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *RewardsCoordinatorUnpausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *RewardsCoordinatorUnpausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// RewardsCoordinatorUnpaused represents a Unpaused event raised by the RewardsCoordinator contract.
type RewardsCoordinatorUnpaused struct {
	Account         common.Address
	NewPausedStatus *big.Int
	Raw             types.Log // Blockchain specific contextual infos
}

// FilterUnpaused is a free log retrieval operation binding the contract event 0x3582d1828e26bf56bd801502bc021ac0bc8afb57c826e4986b45593c8fad389c.
//
// Solidity: event Unpaused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) FilterUnpaused(opts *bind.FilterOpts, account []common.Address) (*RewardsCoordinatorUnpausedIterator, error) {

	var accountRule []interface{}
	for _, accountItem := range account {
		accountRule = append(accountRule, accountItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.FilterLogs(opts, "Unpaused", accountRule)
	if err != nil {
		return nil, err
	}
	return &RewardsCoordinatorUnpausedIterator{contract: _RewardsCoordinator.contract, event: "Unpaused", logs: logs, sub: sub}, nil
}

// WatchUnpaused is a free log subscription operation binding the contract event 0x3582d1828e26bf56bd801502bc021ac0bc8afb57c826e4986b45593c8fad389c.
//
// Solidity: event Unpaused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) WatchUnpaused(opts *bind.WatchOpts, sink chan<- *RewardsCoordinatorUnpaused, account []common.Address) (event.Subscription, error) {

	var accountRule []interface{}
	for _, accountItem := range account {
		accountRule = append(accountRule, accountItem)
	}

	logs, sub, err := _RewardsCoordinator.contract.WatchLogs(opts, "Unpaused", accountRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(RewardsCoordinatorUnpaused)
				if err := _RewardsCoordinator.contract.UnpackLog(event, "Unpaused", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseUnpaused is a log parse operation binding the contract event 0x3582d1828e26bf56bd801502bc021ac0bc8afb57c826e4986b45593c8fad389c.
//
// Solidity: event Unpaused(address indexed account, uint256 newPausedStatus)
func (_RewardsCoordinator *RewardsCoordinatorFilterer) ParseUnpaused(log types.Log) (*RewardsCoordinatorUnpaused, error) {
	event := new(RewardsCoordinatorUnpaused)
	if err := _RewardsCoordinator.contract.UnpackLog(event, "Unpaused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}