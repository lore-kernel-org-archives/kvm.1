Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B33D3485
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122452; cv=fail; b=DGynMqheP0rwhhUcYqOKznLAXMTm3xLTh0id5k79qo2tbjoQ3n/WFzbP9BkBe/QGg6SV+9igUA1Nzb8HqWOSvm3hI+rwoRXU8ZwXT/xwr9K6H+G2pQTpUvJXyYsa//DPTvBkBsHb0T7qOBG0HZ+fFbpjpRVGqwd8wMKmx5noYtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122452; c=relaxed/simple;
	bh=p0XnG6B0YjToFAwJxcaNiCn0SFsx7LK5uCoERF2HpF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYbxwfiElcy/KF9rAvgQjm7NdlIOJjXOaelZ7L59Z7uFTc9BKdWDw/7uogLbhFnTxqQcuftXVrWpBS7yoHNDZXGemomjX1TdWNY2keYf//HurLSB/F0jZTjsrCEmpc7jI6IwgNCdh42Biv83XBrpaS6KQELBNIFIAH95FkCdAOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w4SYciLW; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w4SYciLW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlMjrLmUecdSy/LZuN2OjP9F/AihQeCn/PLLe7yM8jMyWHHBDthwoSmfYOfDPNGJU6QApqZzEDKrsFS/nWcARH6qf43JOAX1e4SDuwV1ANvSUCYQIJswj4sw6VTzkNH35kU5W4U40cd7+SdLg2m/j64Csx1kth28HR2fTw2U7XCNEhZKR/YFBI2Pqfmsy1nyanYgB8zUM5KGZ51oDBO1LdLt3ILbr9GQZGWSXVGRYWdGpt21XUJw87qJeYFxQiuva8/oZ+kZI6+OGXqbSD7MadmJ4PhyAl29gXicIiBkibOkH3/R8qvHSiJ4qd1tWjRSfKc1OvKE10fR1oRJFgpVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szdgS7+/Uk8rn6JG/QUua+Rd3idQp2/TWlgYY4HrRm0=;
 b=G0XVHJ7G+zZoccmc5fFkZZu4+t2lQQkww2ZRdpd/aarUK+/ltBoEt0pX8uNB2cgAFmhSidMeHzGEZnrBpe3AfE/5jVRDxGD4wpeoyEbk3gmA5836c4YBkZgYQYFB9Eb9pOdoxlGXAcCySCBPdaNkvE7cFTHYejBRgBVSyT7dzHF7sqZ9my9ZSJHnAFIFFcD75uFvSVWyG1n1ZPQK9tF2WXjtM6m0cORTBsrh2OivvxqG40mcKXbNqMhpi7ma0nHUCHbuvvASk+q+0X3YVEgN5tHRuvznAPeTSMpMYTPMpluhhjH1Ibtu5ZJ2f3dRY4uBIhT0Btgw5/aNgI9WXSQshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szdgS7+/Uk8rn6JG/QUua+Rd3idQp2/TWlgYY4HrRm0=;
 b=w4SYciLWnS9U2u8Ns0DwMs9Z2ggJnmx3aNmWB8rQFwPXiDShjnrGQdDv15MtRZ1NlYrGR1yEqn7GdBYhVHHSYTPUITWyz+zyJ6YsBnOXMxVaEH5TCefWQxGyA4RxqEgg9GRLGfoYjod5yRoJZh8PQxkxBmGeT7Z6aOtWVH8urd8=
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 06:00:42 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::f1) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:40 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:39 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
Date: Tue, 10 Mar 2026 06:00:18 +0000
Message-ID: <20260310060022.15120-7-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc37a13-dde2-408f-6e67-08de7e6a5bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	r7XVPgEJcYTviBdMNZ2SRjs2NT0aGeIyzq+tzRWTk9tbX11t+pGBFHz10PfW4Br6bs6TlQCr4Y2yDVyNOjxB0xCrXAaH41vU8oyLB2Z3uj0BYnFDwJVxoC67hpce9N1ERHL8g5pmXTgdxuNN0BoAIsAv4lcJ1Ns51Iku/bj+2T31wO7k2u4/TcvCjylkREblxOqBYMzMkRnf1GL2qL/Xnl7xz7CsgMmH8qgX0TogR6H/uj1GblW+j5CFmQUfIlFYAIuHU2HO7k47EOL0HohstSbwfGPEuZYu9om3tyufKom+eXhaaLjyuGb308hFMGX80rsN0owO9Ypcc5tuLoymNNanlzfKIPuMfyYw0/+tgLpof+pjwiFavXyDWqiJ7MSQeqOhO6/Fq0OenxySNp+6G8MOaWdeXYUNnIjkOiIxVt5XtIYNN3CgZFwPjBo2RqqQTudrKC//96n0Zna11ECBHxofVCbtP9upADhmzzjt0Fd4NJ+nCCjR8Lk9dVslh5b1QkqLF4EZAxKpktHu5OeDOZdMpP+Yo2ymLy+2hEKHI+tlAH1lTZZ/AMlzINFh6XOdJzR59pu1vzDEGC6V2nTQo8C9tBUSndoNiwec+Rx8FfT49RHuxjxyL21i9TxXfl3+WxTPURVrHWnmti6xh3PaxApIG5eH74MV/ZQnlFz/XYixfztUk+uNrL8QNlPWIqp1WhRcNvio13vqR4bIJVaR7yYgngR46mBy12JBwWXgBWFETQcMFbqOxmh5S000banWy6qUv4UnsNnTVMcBgSRX1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gf9jZT3u+zHgExpydKlFkd8XdRnPIHtM2y5XQ+JQDVJeVikTN5n+YwunR3HJcWPX5Wi5FiKTrb8n74bZItqIBeGH+PknChUNBletHY1uQQQCmQXgCfPEth1tx/mevkF+QNJrV+jv8YAI3UnZk1bMrlCSqe1285aT0/PQfNlRAqep9XzaflsyhzN8UN5e6OZWJo0Fl5D5+kaP8KkyxNhvq4Gxl/GXWodIAj590d2YLE9uA8EvzwLhA9eFJkmkq96AcAeB18FxKGWPXHw4Hxcm/NAnNpKretztChiZ8Vy0VMJPQdRLWR252DpJQklX0OkxXDMw0boNO+3x/Qp2ro09kF5IJd9y3JzWhzqGlhES96Q9QNoksl4iodd4LokIr1l094U6959D+6fsE3+H9DiM9H+L6THylGYh3pUCyUn4hY5Rd62rbRT+8V2Cr0Pam7PQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:40.7660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc37a13-dde2-408f-6e67-08de7e6a5bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

From: Santosh Shukla <santosh.shukla@amd.com>

IBS virtualization (VIBS) allows a guest to collect Instruction-Based
Sampling (IBS) data using hardware-assisted virtualization. With VIBS
enabled, the hardware automatically saves and restores guest IBS state
during VM-Entry and VM-Exit via the VMCB State Save Area.

IBS-generated interrupts are delivered directly to the guest without
causing a VMEXIT.

VIBS depends on mediated PMU mode and requires either AVIC or NMI
virtualization for interrupt delivery. However, since AVIC can be
dynamically inhibited, VIBS requires VNMI to be enabled to ensure
reliable interrupt delivery. If AVIC is inhibited and VNMI is
disabled, the guest can encounter a VMEXIT_INVALID when IBS
virtualization is enabled for the guest.

Because IBS state is classified as swap type C, the hypervisor must
save its own IBS state before VMRUN and restore it after VMEXIT. It
must also disable IBS before VMRUN and re-enable it afterward. This
will be handled using mediated PMU support in subsequent patches by
enabling mediated PMU capability for IBS PMUs.

More details about IBS virtualization can be found at [1].

[1]: https://bugzilla.kernel.org/attachment.cgi?id=306250
     AMD64 Architecture Programmer’s Manual, Vol 2, Section 15.38
     Instruction-Based Sampling Virtualization.

Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c     | 73 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 4296efc1dafe..17aa6bf76bce 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -226,6 +226,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define SVM_INT_VECTOR_MASK GENMASK(7, 0)
 
+#define SVM_MISC_ENABLE_V_IBS BIT_ULL(2)
+
 #define SVM_INTERRUPT_SHADOW_MASK	BIT_ULL(0)
 #define SVM_GUEST_INTERRUPT_MASK	BIT_ULL(1)
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5af3479cd264..421a929398da 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -161,12 +161,15 @@ module_param(lbrv, int, 0444);
 static int __ro_after_init tsc_scaling = true;
 module_param(tsc_scaling, int, 0444);
 
+/* enable/disable IBS virtualization */
+static bool __ro_after_init vibs = true;
+module_param(vibs, bool, 0444);
+
 module_param(enable_device_posted_irqs, bool, 0444);
 
 bool __read_mostly dump_invalid_vmcb;
 module_param(dump_invalid_vmcb, bool, 0644);
 
-
 bool __ro_after_init intercept_smi = true;
 module_param(intercept_smi, bool, 0444);
 
@@ -779,6 +782,26 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 }
 
+static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = !(guest_cpu_cap_has(vcpu, X86_FEATURE_IBS) &&
+			   kvm_vcpu_has_mediated_pmu(vcpu));
+
+	if (!enable_mediated_pmu || !vibs)
+		return;
+
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHLINAD, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPCTL, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPRIP, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPDATA, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPDATA2, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPDATA3, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSDCLINAD, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSBRTARGET, MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_ICIBSEXTDCTL, MSR_TYPE_RW, intercept);
+}
+
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -848,6 +871,7 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		sev_es_recalc_msr_intercepts(vcpu);
 
 	svm_recalc_pmu_msr_intercepts(vcpu);
+	svm_recalc_ibs_msr_intercepts(vcpu);
 
 	/*
 	 * x2APIC intercepts are modified on-demand and cannot be filtered by
@@ -2880,6 +2904,27 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DE_CFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+
+	case MSR_AMD64_IBSCTL:
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
+			msr_info->data = IBSCTL_LVT_OFFSET_VALID;
+		else
+			msr_info->data = 0;
+		break;
+
+
+	/*
+	 * When IBS virtualization is enabled, guest reads from
+	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must return 0.
+	 * This is done for security reasons, as guests should not be allowed to
+	 * access or infer any information about the system's physical
+	 * addresses.
+	 */
+	case MSR_AMD64_IBSDCPHYSAD:
+	case MSR_AMD64_IBSFETCHPHYSAD:
+		msr_info->data = 0;
+		break;
+
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -3171,6 +3216,16 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->msr_decfg = data;
 		break;
 	}
+	/*
+	 * When IBS virtualization is enabled, guest writes to
+	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must be ignored.
+	 * This is done for security reasons, as guests should not be allowed to
+	 * access or infer any information about the system's physical
+	 * addresses.
+	 */
+	case MSR_AMD64_IBSDCPHYSAD:
+	case MSR_AMD64_IBSFETCHPHYSAD:
+		return 1;
 	default:
 		return kvm_set_msr_common(vcpu, msr);
 	}
@@ -4678,6 +4733,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
+		svm->vmcb->control.misc_ctl2 |= SVM_MISC_ENABLE_V_IBS;
+	else
+		svm->vmcb->control.misc_ctl2 &= ~SVM_MISC_ENABLE_V_IBS;
+
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
 }
@@ -5510,6 +5570,11 @@ static __init void svm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_EXTAPIC))
 		kvm_caps.has_extapic = true;
 
+	if (vibs)
+		kvm_cpu_cap_check_and_set(X86_FEATURE_IBS);
+	else
+		kvm_cpu_caps[CPUID_8000_001B_EAX] = 0;
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
@@ -5698,6 +5763,12 @@ static __init int svm_hardware_setup(void)
 		svm_x86_ops.set_vnmi_pending = NULL;
 	}
 
+	vibs = enable_mediated_pmu && vnmi && vibs
+		&& boot_cpu_has(X86_FEATURE_VIBS);
+
+	if (vibs)
+		pr_info("IBS virtualization supported\n");
+
 	if (!enable_pmu)
 		pr_info("PMU virtualization is disabled\n");
 
-- 
2.43.0

