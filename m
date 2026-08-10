Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8703A1683
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356985; cv=fail; b=Zwb5RjRIg6AvKvtthFScD8rLyhs83A88COMKjZU330Gh6rSDfWxjPoPuhDlyWQJT9CKHPeyz/cFbIeFuXJ4URoc6F8si8sXkpby9ekY/dJJ/p4DjhVZB57a8IGX4/UmGlcbjGmOiUcz5MtOx1aGU501JBJXZeQ1xYVZmNkakPYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356985; c=relaxed/simple;
	bh=ovg7IsYUQ0hNrH///CvXjqJSL3l7yhocl4CFnr+x9FE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiD6cP/176qHrJSy1s0kFp6GWHb/BTL69ANiT3+6T/dl366I4ozLKX9JtUgqzfK7oVg1DuDKquJFFoN13QohvXXPEOMgfyjSW5v9a4SYBUwIVbXnm62eBp7fyz/ZvXvG9eGMNrz1aYTs7HukBR4g9JQ5HckMg/E2OrtQ1uVY6kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ccx4q9ka; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ccx4q9ka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZqrR4MBw0UhbrNcArfxIclouN1cN4ADp92PzEb8q/yiOgQeq6Na2x1TjRzX6GbuY7VoKrQuQfvKe5qtxifzSjICMgr08KxwSISOPZgefvHhUU5iy3SHnuSZnHNgPBkM7I41ZxUW3ic86Uy96DdCWLNew3FQgJuI+9b/bDYorc7P9vlBUfsDfZPWZym3bUoi2Z3issKdHikSX4xm/H03B/697THbx6cUllb3jp+M+Ax7bygyFa8gUDGjtrdRDJ4sYXTZKWAV9W1JfL/loyfSpsH3R8xg/vN0+sUTEH8y9mD0gLeLMsBmBKQJarZN0DvYTa1JtxDyCG2lElJ2240aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K20NMcniU/++WEi2W5iEWn80p3/9FDzTTt47Nr/iBTg=;
 b=fJ8WzrfoQVKTqabVnsZKtqE2MrduTQzYeZXxKfgoJz5l5j7+RnOeLjBzwjOZEgzuCph90KGqidh7RkptjnJLp8zcBMqDIC7Z8Nw0om3iq0Aj4b3LxKKH8QBTAKBoG53TNNWTOUDovSnp4LgIncquUzRLjyoI+2BLq7v6YZJorv/nvI8NqcVO3+0jTpaOGXRZFh20hryspZPVSs3KnxS7DKqVzT4Ju0w063IK0jYj6DP4hVlKXis41zyqpw+dEnOi3Q16vV9Q060tCPoAD0vietXISkzGjiBpAgML7pTepoudmVX+KQA0ZYCnnTmSN6uFAxTRwFPe4TbcEvqrgWPRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K20NMcniU/++WEi2W5iEWn80p3/9FDzTTt47Nr/iBTg=;
 b=Ccx4q9kaDR7OqFfNu92JhGR6hRY9FaEQLf8fvLYCGNf0VJcbYXCPhdB3SpHO5NekRHe03Zor0cnonVqxAnG5RAk4IfoQQGutfWdo+KIYqipiepKDT1snC8CJO9WRsG5pW9PfFcFmz5wzexHwtr8Hr8pRT/Zh1LaOzXrtCivXbOU=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Mon, 10 Aug
 2026 10:16:20 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::ac) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.1 via Frontend Transport; Mon, 10
 Aug 2026 10:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:16:18 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:16:14 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/8] KVM: x86/pmu: Add PMU ops for vendor state sync
Date: Mon, 10 Aug 2026 15:44:50 +0530
Message-ID: <97458b49f1ba443345e13868db0115fd0249b5aa.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbfddfd-29b6-44df-1e48-08def6c86b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	euLoEfltUIj0RnlNlNUg9p5nGiiheOpnOhqmFOYmTUZWu4pU59kV+sXjJ5nIHOOeUS/7vaoZ1qFIHD+cRJUos/c3mmt74CH1SyIhv6IxzGjrxxftYNP6DcUChXeJoJ5Pe2UsRDf6CTIt0V+Qsk1GPANbmmIJ1t5MoXbz2Or0KYzNuM77Xy1l3vx+OP9ZKaSGOtX2yyq9k+v9UwTYZlJOwBaHVBuzAaeAXSL9T+pc/XslOgQhofAhMkeZ7VRqC884PqayxnuRuZqVWWkT0zANtdhGD3cxy07ldNkj+Sm+Wxkfzdwht1NoNnYxdB/8ofsqjUySb7qQ/xIarnVSvReLhR/VrzmZXORSHQQtlz53jeJ7WP9CId3bLeGYmCFbGOm/N1NNR21JZQ4zst2OrqMs9pcUy27ZrtqBcQKOxOGNmds3IZeB7Zb7/awR4G7OoqNiQvcUaoan2oBMbYe7RY1oBEb0mca6RVJC4TIdY/1ztw4XhiOglGjRANlc/pEsAedBXavx3HE9vthGBImnRPeKxdKSyPoQJtuwCArlovsOjMAz+tXl8R7j2x3WYwkJtlXKl/uFVhtLNPn5kMM7cx83skaC6MFsbuh3MhjPr/qE/Y+DsXJqzFFPENu8E+EY9dba+vhAnpcUb2VEE1o2tBf5e7u+lCB9C/DRQkgzHVI+0eALNj9jINZVFtHEllfNCYx5vQTULDZ0YB1BeSd0AmOh+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hyS3t3gL5zPqfGQ5xe2g04v7901HPBgnGiTwa3FB/P/7f88+9KRFKfQvgkH0fy17CRN7um7Qz6CDcQAK7WYoYA+sar6N9UID8Mp+9wDEo4lEUv7g/8Wi119bqUPKdQTaPUsKz0M6gpUnoxscsBCoNLbrM/dAVuCPpxqb7RMki5nK0+DsdNXOVyZgMnIoC+4P6z9hgePAbgZdSEbwfHHgWnkhpnpFIX2yK0LNvg5TYJlspJiW+pZtw1YbglWyNkMvfpFRi5VJ3wn+hK6cXkFZnD+jMUFnhYZLQqsuXyFNSBfDsttrHcIB2KPyDIQma+IL4cF1PVAWAOWZSo2L6kcfOpRq7F2D/ZeD7OQKd7MP5MXRikKSltP3zQUbmAfzO515UvI8xnfmDq3RuuFHnJ7mheDRFvMwGydNLF6VfPF2waWJ8gbSfZgZ4H6fCPOi2naz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:16:18.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbfddfd-29b6-44df-1e48-08def6c86b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

When hardware-switched mediated PMU is enabled, the guest PMU state
resides in a vendor save area. Because of this, after every VMEXIT,
the state inside struct kvm_pmu can go out of sync with the vendor
save area. Since KVM expects struct kvm_pmu to have the correct guest
PMU state during event filtering and instruction emulation, introduce
new PMU ops to opportunistically synchronize the state of PMU MSRs
between the two backing stores.

The new ops are directional. get_vendor_state() copies data from the
vendor save area to the corresponding member of struct kvm_pmu while
set_vendor_state() does the opposite.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h | 3 +++
 arch/x86/kvm/pmu.c                     | 5 ++++-
 arch/x86/kvm/pmu.h                     | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 4a223c2793e3..4a617162d4c0 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -29,6 +29,9 @@ KVM_X86_PMU_OP_OPTIONAL_RET0(pmc_is_disabled_in_current_mode)
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
 KVM_X86_PMU_OP(mediated_load)
 KVM_X86_PMU_OP(mediated_put)
+
+KVM_X86_PMU_OP_OPTIONAL_RET0(get_vendor_state)
+KVM_X86_PMU_OP_OPTIONAL_RET0(set_vendor_state)
 #endif
 
 #undef KVM_X86_PMU_OP
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..5ede3ee968e3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -166,8 +166,11 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	    !pmu_ops->is_mediated_pmu_supported(&kvm_host_pmu))
 		enable_mediated_pmu = false;
 
-	if (!enable_mediated_pmu)
+	if (!enable_mediated_pmu) {
 		pmu_ops->write_global_ctrl = NULL;
+		pmu_ops->get_vendor_state = NULL;
+		pmu_ops->set_vendor_state = NULL;
+	}
 
 	if (!enable_pmu) {
 		memset(&kvm_pmu_cap, 0, sizeof(kvm_pmu_cap));
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 1aa46d3e2339..5d6f6863ad40 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -42,6 +42,8 @@ struct kvm_pmu_ops {
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
 	void (*mediated_put)(struct kvm_vcpu *vcpu);
 	void (*write_global_ctrl)(u64 global_ctrl);
+	int (*get_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
+	int (*set_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
-- 
2.53.0

