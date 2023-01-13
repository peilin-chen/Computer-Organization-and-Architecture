/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_688(char*, char *);
extern void execute_689(char*, char *);
extern void execute_690(char*, char *);
extern void execute_691(char*, char *);
extern void execute_692(char*, char *);
extern void execute_693(char*, char *);
extern void execute_3305(char*, char *);
extern void execute_3306(char*, char *);
extern void execute_3307(char*, char *);
extern void execute_3308(char*, char *);
extern void execute_3309(char*, char *);
extern void execute_3310(char*, char *);
extern void execute_3311(char*, char *);
extern void execute_3312(char*, char *);
extern void execute_3313(char*, char *);
extern void execute_3314(char*, char *);
extern void execute_3315(char*, char *);
extern void execute_3316(char*, char *);
extern void execute_3317(char*, char *);
extern void execute_3582(char*, char *);
extern void execute_3583(char*, char *);
extern void execute_3584(char*, char *);
extern void execute_3585(char*, char *);
extern void execute_3586(char*, char *);
extern void execute_3587(char*, char *);
extern void execute_3588(char*, char *);
extern void execute_3589(char*, char *);
extern void execute_3590(char*, char *);
extern void execute_3591(char*, char *);
extern void execute_3592(char*, char *);
extern void execute_3593(char*, char *);
extern void execute_3594(char*, char *);
extern void execute_3595(char*, char *);
extern void execute_3596(char*, char *);
extern void execute_3597(char*, char *);
extern void execute_3598(char*, char *);
extern void execute_3599(char*, char *);
extern void execute_3600(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_699(char*, char *);
extern void execute_700(char*, char *);
extern void execute_701(char*, char *);
extern void execute_702(char*, char *);
extern void execute_703(char*, char *);
extern void execute_704(char*, char *);
extern void execute_705(char*, char *);
extern void execute_706(char*, char *);
extern void execute_707(char*, char *);
extern void execute_708(char*, char *);
extern void execute_709(char*, char *);
extern void execute_710(char*, char *);
extern void execute_711(char*, char *);
extern void execute_712(char*, char *);
extern void execute_713(char*, char *);
extern void execute_3296(char*, char *);
extern void execute_3297(char*, char *);
extern void execute_3298(char*, char *);
extern void execute_3299(char*, char *);
extern void execute_3300(char*, char *);
extern void execute_3301(char*, char *);
extern void execute_3302(char*, char *);
extern void execute_3303(char*, char *);
extern void execute_3304(char*, char *);
extern void execute_13(char*, char *);
extern void execute_14(char*, char *);
extern void execute_714(char*, char *);
extern void execute_715(char*, char *);
extern void execute_16(char*, char *);
extern void execute_1996(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_845(char*, char *);
extern void execute_846(char*, char *);
extern void execute_847(char*, char *);
extern void execute_856(char*, char *);
extern void execute_857(char*, char *);
extern void execute_858(char*, char *);
extern void execute_859(char*, char *);
extern void execute_860(char*, char *);
extern void execute_862(char*, char *);
extern void execute_863(char*, char *);
extern void execute_867(char*, char *);
extern void execute_868(char*, char *);
extern void execute_869(char*, char *);
extern void execute_870(char*, char *);
extern void execute_871(char*, char *);
extern void execute_19(char*, char *);
extern void execute_47(char*, char *);
extern void execute_832(char*, char *);
extern void execute_833(char*, char *);
extern void execute_834(char*, char *);
extern void execute_835(char*, char *);
extern void execute_836(char*, char *);
extern void execute_837(char*, char *);
extern void execute_838(char*, char *);
extern void execute_28(char*, char *);
extern void execute_29(char*, char *);
extern void execute_30(char*, char *);
extern void execute_44(char*, char *);
extern void execute_45(char*, char *);
extern void execute_46(char*, char *);
extern void execute_764(char*, char *);
extern void execute_765(char*, char *);
extern void execute_766(char*, char *);
extern void execute_767(char*, char *);
extern void execute_768(char*, char *);
extern void execute_769(char*, char *);
extern void execute_770(char*, char *);
extern void execute_772(char*, char *);
extern void execute_773(char*, char *);
extern void execute_774(char*, char *);
extern void execute_775(char*, char *);
extern void execute_779(char*, char *);
extern void execute_783(char*, char *);
extern void execute_784(char*, char *);
extern void execute_785(char*, char *);
extern void execute_786(char*, char *);
extern void execute_787(char*, char *);
extern void execute_788(char*, char *);
extern void execute_791(char*, char *);
extern void execute_793(char*, char *);
extern void execute_794(char*, char *);
extern void execute_795(char*, char *);
extern void execute_796(char*, char *);
extern void execute_797(char*, char *);
extern void execute_798(char*, char *);
extern void execute_799(char*, char *);
extern void execute_800(char*, char *);
extern void execute_801(char*, char *);
extern void execute_802(char*, char *);
extern void execute_803(char*, char *);
extern void execute_804(char*, char *);
extern void execute_805(char*, char *);
extern void execute_806(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_34(char*, char *);
extern void execute_35(char*, char *);
extern void execute_776(char*, char *);
extern void execute_777(char*, char *);
extern void execute_778(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_3564(char*, char *);
extern void execute_3565(char*, char *);
extern void execute_3566(char*, char *);
extern void execute_3571(char*, char *);
extern void execute_3572(char*, char *);
extern void execute_3573(char*, char *);
extern void execute_520(char*, char *);
extern void execute_521(char*, char *);
extern void execute_522(char*, char *);
extern void execute_523(char*, char *);
extern void execute_524(char*, char *);
extern void execute_525(char*, char *);
extern void execute_526(char*, char *);
extern void execute_527(char*, char *);
extern void execute_528(char*, char *);
extern void execute_529(char*, char *);
extern void execute_530(char*, char *);
extern void execute_687(char*, char *);
extern void execute_3361(char*, char *);
extern void execute_3362(char*, char *);
extern void execute_3363(char*, char *);
extern void execute_3364(char*, char *);
extern void execute_3372(char*, char *);
extern void execute_3373(char*, char *);
extern void execute_3374(char*, char *);
extern void execute_3552(char*, char *);
extern void execute_3555(char*, char *);
extern void execute_3556(char*, char *);
extern void execute_3557(char*, char *);
extern void execute_3558(char*, char *);
extern void execute_3559(char*, char *);
extern void execute_580(char*, char *);
extern void execute_581(char*, char *);
extern void execute_582(char*, char *);
extern void execute_583(char*, char *);
extern void execute_584(char*, char *);
extern void execute_585(char*, char *);
extern void execute_586(char*, char *);
extern void execute_587(char*, char *);
extern void execute_588(char*, char *);
extern void execute_3419(char*, char *);
extern void execute_3420(char*, char *);
extern void execute_3421(char*, char *);
extern void execute_3422(char*, char *);
extern void execute_3425(char*, char *);
extern void execute_3399(char*, char *);
extern void execute_3400(char*, char *);
extern void execute_3401(char*, char *);
extern void execute_3402(char*, char *);
extern void execute_3403(char*, char *);
extern void execute_3404(char*, char *);
extern void execute_3405(char*, char *);
extern void execute_3406(char*, char *);
extern void execute_3407(char*, char *);
extern void execute_3408(char*, char *);
extern void execute_3409(char*, char *);
extern void execute_3410(char*, char *);
extern void execute_3411(char*, char *);
extern void execute_3412(char*, char *);
extern void execute_3413(char*, char *);
extern void execute_3414(char*, char *);
extern void execute_3415(char*, char *);
extern void execute_3416(char*, char *);
extern void execute_3417(char*, char *);
extern void execute_3418(char*, char *);
extern void execute_535(char*, char *);
extern void execute_536(char*, char *);
extern void execute_541(char*, char *);
extern void execute_542(char*, char *);
extern void execute_553(char*, char *);
extern void execute_555(char*, char *);
extern void execute_557(char*, char *);
extern void execute_559(char*, char *);
extern void execute_561(char*, char *);
extern void execute_563(char*, char *);
extern void execute_565(char*, char *);
extern void execute_567(char*, char *);
extern void execute_569(char*, char *);
extern void execute_571(char*, char *);
extern void execute_573(char*, char *);
extern void execute_575(char*, char *);
extern void execute_577(char*, char *);
extern void execute_579(char*, char *);
extern void execute_657(char*, char *);
extern void execute_658(char*, char *);
extern void execute_659(char*, char *);
extern void execute_660(char*, char *);
extern void execute_661(char*, char *);
extern void execute_3426(char*, char *);
extern void execute_3493(char*, char *);
extern void execute_3494(char*, char *);
extern void execute_3495(char*, char *);
extern void execute_3463(char*, char *);
extern void execute_3464(char*, char *);
extern void execute_3465(char*, char *);
extern void execute_3466(char*, char *);
extern void execute_3467(char*, char *);
extern void execute_3468(char*, char *);
extern void execute_3469(char*, char *);
extern void execute_3470(char*, char *);
extern void execute_3471(char*, char *);
extern void execute_3472(char*, char *);
extern void execute_3473(char*, char *);
extern void execute_3474(char*, char *);
extern void execute_3475(char*, char *);
extern void execute_3476(char*, char *);
extern void execute_3477(char*, char *);
extern void execute_3478(char*, char *);
extern void execute_3479(char*, char *);
extern void execute_3480(char*, char *);
extern void execute_3481(char*, char *);
extern void execute_3482(char*, char *);
extern void execute_3483(char*, char *);
extern void execute_3484(char*, char *);
extern void execute_3485(char*, char *);
extern void execute_3486(char*, char *);
extern void execute_3487(char*, char *);
extern void execute_3488(char*, char *);
extern void execute_3489(char*, char *);
extern void execute_3490(char*, char *);
extern void execute_3491(char*, char *);
extern void execute_3492(char*, char *);
extern void execute_595(char*, char *);
extern void execute_596(char*, char *);
extern void execute_610(char*, char *);
extern void execute_614(char*, char *);
extern void execute_616(char*, char *);
extern void execute_618(char*, char *);
extern void execute_620(char*, char *);
extern void execute_622(char*, char *);
extern void execute_624(char*, char *);
extern void execute_628(char*, char *);
extern void execute_630(char*, char *);
extern void execute_632(char*, char *);
extern void execute_634(char*, char *);
extern void execute_636(char*, char *);
extern void execute_638(char*, char *);
extern void execute_640(char*, char *);
extern void execute_642(char*, char *);
extern void execute_644(char*, char *);
extern void execute_648(char*, char *);
extern void execute_650(char*, char *);
extern void execute_654(char*, char *);
extern void execute_656(char*, char *);
extern void execute_670(char*, char *);
extern void execute_671(char*, char *);
extern void execute_685(char*, char *);
extern void execute_686(char*, char *);
extern void execute_3497(char*, char *);
extern void execute_3498(char*, char *);
extern void execute_3499(char*, char *);
extern void execute_3500(char*, char *);
extern void execute_3501(char*, char *);
extern void execute_3502(char*, char *);
extern void execute_3503(char*, char *);
extern void execute_3504(char*, char *);
extern void execute_3506(char*, char *);
extern void execute_3507(char*, char *);
extern void execute_3508(char*, char *);
extern void execute_3512(char*, char *);
extern void execute_3518(char*, char *);
extern void execute_3520(char*, char *);
extern void execute_3521(char*, char *);
extern void execute_3522(char*, char *);
extern void execute_3523(char*, char *);
extern void execute_3524(char*, char *);
extern void execute_3525(char*, char *);
extern void execute_3526(char*, char *);
extern void execute_3527(char*, char *);
extern void execute_3528(char*, char *);
extern void execute_3529(char*, char *);
extern void execute_3530(char*, char *);
extern void execute_3531(char*, char *);
extern void execute_3532(char*, char *);
extern void execute_3533(char*, char *);
extern void execute_673(char*, char *);
extern void execute_674(char*, char *);
extern void execute_675(char*, char *);
extern void execute_676(char*, char *);
extern void execute_3509(char*, char *);
extern void execute_3510(char*, char *);
extern void execute_3511(char*, char *);
extern void execute_678(char*, char *);
extern void execute_679(char*, char *);
extern void execute_680(char*, char *);
extern void execute_681(char*, char *);
extern void execute_3513(char*, char *);
extern void execute_3514(char*, char *);
extern void execute_3515(char*, char *);
extern void execute_683(char*, char *);
extern void execute_684(char*, char *);
extern void execute_695(char*, char *);
extern void execute_696(char*, char *);
extern void execute_697(char*, char *);
extern void execute_3601(char*, char *);
extern void execute_3602(char*, char *);
extern void execute_3603(char*, char *);
extern void execute_3604(char*, char *);
extern void execute_3605(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[351] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_688, (funcp)execute_689, (funcp)execute_690, (funcp)execute_691, (funcp)execute_692, (funcp)execute_693, (funcp)execute_3305, (funcp)execute_3306, (funcp)execute_3307, (funcp)execute_3308, (funcp)execute_3309, (funcp)execute_3310, (funcp)execute_3311, (funcp)execute_3312, (funcp)execute_3313, (funcp)execute_3314, (funcp)execute_3315, (funcp)execute_3316, (funcp)execute_3317, (funcp)execute_3582, (funcp)execute_3583, (funcp)execute_3584, (funcp)execute_3585, (funcp)execute_3586, (funcp)execute_3587, (funcp)execute_3588, (funcp)execute_3589, (funcp)execute_3590, (funcp)execute_3591, (funcp)execute_3592, (funcp)execute_3593, (funcp)execute_3594, (funcp)execute_3595, (funcp)execute_3596, (funcp)execute_3597, (funcp)execute_3598, (funcp)execute_3599, (funcp)execute_3600, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_699, (funcp)execute_700, (funcp)execute_701, (funcp)execute_702, (funcp)execute_703, (funcp)execute_704, (funcp)execute_705, (funcp)execute_706, (funcp)execute_707, (funcp)execute_708, (funcp)execute_709, (funcp)execute_710, (funcp)execute_711, (funcp)execute_712, (funcp)execute_713, (funcp)execute_3296, (funcp)execute_3297, (funcp)execute_3298, (funcp)execute_3299, (funcp)execute_3300, (funcp)execute_3301, (funcp)execute_3302, (funcp)execute_3303, (funcp)execute_3304, (funcp)execute_13, (funcp)execute_14, (funcp)execute_714, (funcp)execute_715, (funcp)execute_16, (funcp)execute_1996, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_845, (funcp)execute_846, (funcp)execute_847, (funcp)execute_856, (funcp)execute_857, (funcp)execute_858, (funcp)execute_859, (funcp)execute_860, (funcp)execute_862, (funcp)execute_863, (funcp)execute_867, (funcp)execute_868, (funcp)execute_869, (funcp)execute_870, (funcp)execute_871, (funcp)execute_19, (funcp)execute_47, (funcp)execute_832, (funcp)execute_833, (funcp)execute_834, (funcp)execute_835, (funcp)execute_836, (funcp)execute_837, (funcp)execute_838, (funcp)execute_28, (funcp)execute_29, (funcp)execute_30, (funcp)execute_44, (funcp)execute_45, (funcp)execute_46, (funcp)execute_764, (funcp)execute_765, (funcp)execute_766, (funcp)execute_767, (funcp)execute_768, (funcp)execute_769, (funcp)execute_770, (funcp)execute_772, (funcp)execute_773, (funcp)execute_774, (funcp)execute_775, (funcp)execute_779, (funcp)execute_783, (funcp)execute_784, (funcp)execute_785, (funcp)execute_786, (funcp)execute_787, (funcp)execute_788, (funcp)execute_791, (funcp)execute_793, (funcp)execute_794, (funcp)execute_795, (funcp)execute_796, (funcp)execute_797, (funcp)execute_798, (funcp)execute_799, (funcp)execute_800, (funcp)execute_801, (funcp)execute_802, (funcp)execute_803, (funcp)execute_804, (funcp)execute_805, (funcp)execute_806, (funcp)execute_32, (funcp)execute_33, (funcp)execute_34, (funcp)execute_35, (funcp)execute_776, (funcp)execute_777, (funcp)execute_778, (funcp)execute_42, (funcp)execute_43, (funcp)execute_3564, (funcp)execute_3565, (funcp)execute_3566, (funcp)execute_3571, (funcp)execute_3572, (funcp)execute_3573, (funcp)execute_520, (funcp)execute_521, (funcp)execute_522, (funcp)execute_523, (funcp)execute_524, (funcp)execute_525, (funcp)execute_526, (funcp)execute_527, (funcp)execute_528, (funcp)execute_529, (funcp)execute_530, (funcp)execute_687, (funcp)execute_3361, (funcp)execute_3362, (funcp)execute_3363, (funcp)execute_3364, (funcp)execute_3372, (funcp)execute_3373, (funcp)execute_3374, (funcp)execute_3552, (funcp)execute_3555, (funcp)execute_3556, (funcp)execute_3557, (funcp)execute_3558, (funcp)execute_3559, (funcp)execute_580, (funcp)execute_581, (funcp)execute_582, (funcp)execute_583, (funcp)execute_584, (funcp)execute_585, (funcp)execute_586, (funcp)execute_587, (funcp)execute_588, (funcp)execute_3419, (funcp)execute_3420, (funcp)execute_3421, (funcp)execute_3422, (funcp)execute_3425, (funcp)execute_3399, (funcp)execute_3400, (funcp)execute_3401, (funcp)execute_3402, (funcp)execute_3403, (funcp)execute_3404, (funcp)execute_3405, (funcp)execute_3406, (funcp)execute_3407, (funcp)execute_3408, (funcp)execute_3409, (funcp)execute_3410, (funcp)execute_3411, (funcp)execute_3412, (funcp)execute_3413, (funcp)execute_3414, (funcp)execute_3415, (funcp)execute_3416, (funcp)execute_3417, (funcp)execute_3418, (funcp)execute_535, (funcp)execute_536, (funcp)execute_541, (funcp)execute_542, (funcp)execute_553, (funcp)execute_555, (funcp)execute_557, (funcp)execute_559, (funcp)execute_561, (funcp)execute_563, (funcp)execute_565, (funcp)execute_567, (funcp)execute_569, (funcp)execute_571, (funcp)execute_573, (funcp)execute_575, (funcp)execute_577, (funcp)execute_579, (funcp)execute_657, (funcp)execute_658, (funcp)execute_659, (funcp)execute_660, (funcp)execute_661, (funcp)execute_3426, (funcp)execute_3493, (funcp)execute_3494, (funcp)execute_3495, (funcp)execute_3463, (funcp)execute_3464, (funcp)execute_3465, (funcp)execute_3466, (funcp)execute_3467, (funcp)execute_3468, (funcp)execute_3469, (funcp)execute_3470, (funcp)execute_3471, (funcp)execute_3472, (funcp)execute_3473, (funcp)execute_3474, (funcp)execute_3475, (funcp)execute_3476, (funcp)execute_3477, (funcp)execute_3478, (funcp)execute_3479, (funcp)execute_3480, (funcp)execute_3481, (funcp)execute_3482, (funcp)execute_3483, (funcp)execute_3484, (funcp)execute_3485, (funcp)execute_3486, (funcp)execute_3487, (funcp)execute_3488, (funcp)execute_3489, (funcp)execute_3490, (funcp)execute_3491, (funcp)execute_3492, (funcp)execute_595, (funcp)execute_596, (funcp)execute_610, (funcp)execute_614, (funcp)execute_616, (funcp)execute_618, (funcp)execute_620, (funcp)execute_622, (funcp)execute_624, (funcp)execute_628, (funcp)execute_630, (funcp)execute_632, (funcp)execute_634, (funcp)execute_636, (funcp)execute_638, (funcp)execute_640, (funcp)execute_642, (funcp)execute_644, (funcp)execute_648, (funcp)execute_650, (funcp)execute_654, (funcp)execute_656, (funcp)execute_670, (funcp)execute_671, (funcp)execute_685, (funcp)execute_686, (funcp)execute_3497, (funcp)execute_3498, (funcp)execute_3499, (funcp)execute_3500, (funcp)execute_3501, (funcp)execute_3502, (funcp)execute_3503, (funcp)execute_3504, (funcp)execute_3506, (funcp)execute_3507, (funcp)execute_3508, (funcp)execute_3512, (funcp)execute_3518, (funcp)execute_3520, (funcp)execute_3521, (funcp)execute_3522, (funcp)execute_3523, (funcp)execute_3524, (funcp)execute_3525, (funcp)execute_3526, (funcp)execute_3527, (funcp)execute_3528, (funcp)execute_3529, (funcp)execute_3530, (funcp)execute_3531, (funcp)execute_3532, (funcp)execute_3533, (funcp)execute_673, (funcp)execute_674, (funcp)execute_675, (funcp)execute_676, (funcp)execute_3509, (funcp)execute_3510, (funcp)execute_3511, (funcp)execute_678, (funcp)execute_679, (funcp)execute_680, (funcp)execute_681, (funcp)execute_3513, (funcp)execute_3514, (funcp)execute_3515, (funcp)execute_683, (funcp)execute_684, (funcp)execute_695, (funcp)execute_696, (funcp)execute_697, (funcp)execute_3601, (funcp)execute_3602, (funcp)execute_3603, (funcp)execute_3604, (funcp)execute_3605, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 351;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cache_tb_behav/xsim.reloc",  (void **)funcTab, 351);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/cache_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/cache_tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/cache_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/cache_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/cache_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
