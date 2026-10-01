Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263C352C54
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829885; cv=fail; b=pl8fFModo+2glXFrLgsK0lbkjiyx9OWiSR52A9uT320YdWym5eCBS+0QXSu51xo55AkGptbJ0l7vuuoc9oFVzpd9apgvBPjk1zXSZjjqCnrcrCJC/lfJ9TuHtDDeLP31VP1RDeQXbPzII33Lrk6vFSDUFwnRRvNrA8N8FHlFKbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829885; c=relaxed/simple;
	bh=ZOuv14EHzd8FRVXEmYBsQp4+kEWisCyevBdlCcKgcMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRG7mN9shPNXC0TjUK/ZzdRRffaA3jz1LJCTlbpcY7efygDC7Y133BZWc0hOfn6YC3VFKiR8Z21jp+qIBLkp1MbluSgVP3JjYBrVG2i2AX50xmlAJHm3WpZvsIYME4Aa8CGdzCcV/yy0OsmoNJ+3jlQ3rY7v8vFhiSEZ9iwdC4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yE88Sy/N; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yE88Sy/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJcYFlbW4t1XcX0JPmY5UkUonn9DNkIe1V6UamDNgo5QmWmuiOwrGvlauQ71LfM4mkGCD6BLTV1YvDi5CBHkRpTBwVpwVD8ZM4UYI7sty8NYX5/qBEqSJMyZlmxLfP0P9y9x94CaUl16uZ02iOeHqQCB/xA44mYHqUKu7vdRu0IKlMMDl/y5CDo6cjjCxS3ITTzIwlvFcpz2IYx5okK0y7yu8v++xb/DaiMZWr5stz9buL/Dc456N8EJpEKsnwUZDiRa4NKh4I4jEdmBIv40xLWJGdlK3ekNkrCgz1K+x3VFgdDn4TWEvizBOt9aRA/nQc8nfss/Roz9p56EdpwZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTzcYreMHOCWaLB882dvTkc2qcC8fDyZ0z+/JKXlCnY=;
 b=G1NT4KzIcqOMHwSARitQJUr90gx+1UICAcANWFFrTm/fg2kByquBZpmNk5ruXR30L5eRy0tPnlDKsHvLsKuCr0X4rdhuy8MX/fsSaZy+2CUGQLpraTkbt169rI5lnI5izfKSCFAdMr7l1Fn7dhD2aYjLtpX8DWdK1WVpUWAvEjsv60UBfRAVOzXCzslqc4FF7/AW5sWMJz53CJTxWj2FKmjBm2nbn6Ixak7dtoT4rLpjSeaza1DS/G8zeeiM0Vxy8aQaa9sV+gWCCmEoqoOh5PZB3+UFsWPOLfTlbOl8gzsM5gz7uuFPvjiwVGzKwqtdT4k1axkbgD4fw3qwegxGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTzcYreMHOCWaLB882dvTkc2qcC8fDyZ0z+/JKXlCnY=;
 b=yE88Sy/NJY/X71z+WC/IMbUYaGxmnoQnoIwl/XgeBaddL6lKW7yAi7AOcdUwzfGeIBtl0atzO2uqlhIepgZbsrSadYep+Kp3Tq7OP4VngHhzd/0bFqebRbKtIUzo7SNyURArdoAVZ1TOQg7T6h8F4pkrDA3WVXQVU56sYxAMDgA=
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:44:40 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::27) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 04:44:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:40 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:25 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 5/7] KVM: x86/pmu: Refresh event-selects before counting emulated events
Date: Thu, 1 Oct 2026 04:43:49 +0000
Message-ID: <20261001044351.50535-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001044351.50535-1-manali.shukla@amd.com>
References: <20261001044351.50535-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 42663c9b-8edb-4f72-550c-08df1f76b4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0zt0VR2gax64sKHVj4oJoiCPl23M4PbPJbJ42tq+/AG9dILQRRibi7BiBkvzzaFxV/CuGGPPSBz0ff/kHV+K1vV5V+glocJqFOH4R27ONnjvhWBrtXINzsSUNPzMZmluddy7hAB9GONgPTaNUCiyNTkBQlM6lxoGwecv0L8eUTFVygmlLrWCEHnZ+87Ml5SLnHmSJXGeO+F7yCRvxqnDCFNAZnDdhO5AEGy5tnbxZllv2nRHEz0Cx0naCWmgqHvYAxEYgRdEvBaHPeEX56lGI0ge834XVJ2ojcViIK65/qvtzgIm5ZhPjxPoEXZBaJK1WbkcfI0EVQG3BNnEnUHgxyiJiK/AlBucmMMgQCpdBP0Nu7b+8MFvSg+voPlHukFqKBhf+pE5iC4Y/QlmW07qmnkZ55tGacsq+p645wp6Gkej02+Uq+aKPCVXLN5am4ktra2DI/i0zm58a05X7/cXkIc+JEJKOwrRjAhWE086enMRdc0RopOrbh5eWIgcYBFVAH2Xx7b4P0sAY900eG6RRRokDxentXd515c59Yh8ADojxpnZH1fmvXqWB6aeKUKnLcyNYWMcWIxZqF01yeHIqq+yQdRCdp47K31i18rYVr19one3Ib7R4fllLfDjtEDJ0iLy82PLhUxG1nBRfOUPXO/adD8PcgYCTd1tNM5EtXo16qXZku4DmapEEMTHBJndMYVHDb6U/E591ismpxIkpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X9H0gqd4UMXCipx56S1GxG5TQHiHGNc3qWGsKHp6KnLzMajKv2kK2I67Ym5Tc8A0mJxbTUXUWPqz9uKtw3YBHJqW9p4zPml6Y13OZPKUPhSs9FV33d+Is0eOD5T0KvrtE1u6ucMzzET4Gq2x/eASYkrzftKQHA0FFxqO2WR/MJ/ZQjHzqOtLLSveNZEHAdApvyPoZimismCjfD2WZ/Rz4z+Y/+Z1OCO2ccalBlF+5sKSvCv7IcEhCXFgeiCoWpTS5hWkzAU3Fwe7Iqqm5RPatnldaPySoWajxsw6FNmdF/WfEfiIBX6wpJh4tvZlji7mRosVlloTe1nX9ArFGlywi+DpqYMLwI00lEeNfO4h+13m0NtiuMrsrSP4ugf+v4YYx7b/V3y7eYCdr4eOt1oKIUp4GzKoBrrsUo105DrKujN76ljaaBsUkeCxZhyD4IRu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:40.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42663c9b-8edb-4f72-550c-08df1f76b4ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485

Without hardware-assisted PMC filtering, KVM intercepts every guest
write to an event-select, so its copy is always up to date.

With the filter enabled, event-selects are passed through and only
EN=1 writes of events not on the allow list cause a VM-exit.  The guest
can disable a counter, or switch it to another allowed event, without
KVM seeing it.  kvm_pmu_trigger_event() works from KVM's old copy, so it
can count into a counter the guest has turned off, and raise a PMI for
it.

Read the event-selects back from the VMCB before choosing the counters.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/kvm/pmu.c                     | 10 ++++++++++
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/svm/pmu.c                 |  1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index dcec41ad080a4..c7887dffe4f94 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -28,6 +28,7 @@ KVM_X86_PMU_OP_OPTIONAL_RET0(pmc_is_disabled_in_current_mode)
 
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
 KVM_X86_PMU_OP_OPTIONAL(clear_hw_pmc_allowlist)
+KVM_X86_PMU_OP_OPTIONAL(sync_eventsels_from_hw)
 KVM_X86_PMU_OP(mediated_load)
 KVM_X86_PMU_OP(mediated_put)
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7cc72b3863545..ace39076977af 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1209,6 +1209,16 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 
 	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
 
+	/*
+	 * The guest can reprogram allowed events without trapping.  Don't count,
+	 * or raise a PMI, for a counter the guest has since repurposed.
+	 */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED)) {
+		kvm_pmu_call(sync_eventsels_from_hw)(vcpu);
+		kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx)
+			kvm_pmu_recalc_pmc_emulation(pmu, pmc);
+	}
+
 	if (bitmap_empty(event_pmcs, X86_PMC_IDX_MAX))
 		return;
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 4a19b806b8480..d0b0589d3ae45 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -45,6 +45,7 @@ struct kvm_pmu_ops {
 	void (*clear_hw_pmc_allowlist)(struct kvm_vcpu *vcpu);
 	int (*get_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*set_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
+	void (*sync_eventsels_from_hw)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 634e6a337c31f..52da247e23050 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -516,6 +516,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.mediated_put = amd_mediated_pmu_put,
 	.get_vendor_state = amd_get_vendor_state,
 	.set_vendor_state = amd_set_vendor_state,
+	.sync_eventsels_from_hw = amd_sync_eventsels_from_hw,
 	.clear_hw_pmc_allowlist = amd_clear_hw_pmc_allowlist,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
-- 
2.43.0

