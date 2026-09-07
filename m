Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CF403EB9
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763186; cv=fail; b=YGQy7StJwBlk0LbLnga1e/rTcZXJsePOFUU+o7Vlqy0/Tj9o6JOsseXannRM8mZNRUECShjB5Y+4BjWOTCCaDVvdLfImCoFWa/Y3V52U6uneuq+1ZZYgSwgBqulVVkO7aBsEyVbVq86Dlo0VT78CuZohsAuMje7EyybpSWG6+4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763186; c=relaxed/simple;
	bh=9L7gwfDv8RbcijbaZ9/gkdDjQ95J9B8dJ/aqafZPIVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGBJqWRuo9XPP0dlPkyiBQWWz8GGDlmyU/BbGQXtBvGUQ8nUfpMHVCbqLhOG1yDwdPfiy5gY4fqf5gQcpxzTKq09GLCVA1R534tQN6jBg7TpWDZHav9MDh1HvST2zyjHc3MzmDX8tDp4d3nQrHZy62QSprY/CoiSSuWh0Q0A9H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dbiD0If0; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dbiD0If0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRM55d9XidHVemGW4H/bHqd725maRteWqXFP0U+CfTR/GEiAtTWfi87bDTqqI1l0YH6hx87exLPqk+y7QS7RErVCDsYWCL3fb/0cCVAUZEwcpDgF3bKnPw577KDKqQGHWSeIlbzg/xQNrIcjKJQjXpsLQL0S3/UXW0hVLSGi/EjJD/XmsgpkBbIiUvcQcmB4Qzwbs+ztlYXMvK6lGjEzo0YtcFk9AOfSl+qBaGK6A0UiE8mvexZg/dd3GvkoigA6ncuV5WqEKZ78A3ucowPtI0xcRtIUTI/PZZs7rlN+tcGODtfI+61AmNjRaDONgkLwddfq/RrYD/SqSVJLDPMUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwW285r5QlErm2D3csGCqEXOMtCcB4SEv0srbZnVaIQ=;
 b=oAykZfQxe5VALJpM1UAwQnHX4ScdWeAW9eCY5zVaC+gCfWzI+P43bD6q/V0EB49dTuhXdNxV8amp4AbcB56fm6ANe4Gmgr1z9Y6StCC6sKknWdsmvgKfMF5R3H2qm/6MTdsC7NHEoBEfgx7FpoIl+4AQv/F01BkWVJDxRsqFWCv1xZMx3ULKkwe2lvrCCmYBFoKX3acgqe4tlFu3QSLN6CsSMscNeJDqkggsXvcIN2yPSiet8/ibarCv8eX86DzU1vPCCcMqcnyeL0036BM0fqP46bWFsbxwtYOmVtx8VKzi1bHK4Llw6OPLa1dbbwvRCJnHjfnGRcIYCQED+YFfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwW285r5QlErm2D3csGCqEXOMtCcB4SEv0srbZnVaIQ=;
 b=dbiD0If0zleaqQZACgerAZOXyFNvLLvcO+tbRRo6kF0xT3a3rewCqmYfyOEQBbN3c71PJOeVcAQm9YwdF2HghfnOoUkvyVEhIFH85jXQmDbdFkiAAR8mXf0NtkWwR7QR/X90m7tqLCFs5W3FjvVlo6oBbmm7Fjdpuf26mVjzV1g=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 7 Sep
 2026 06:39:40 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::81) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 06:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:40 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:37 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 5/8] KVM: x86: Carve out common dirty logging update
Date: Mon, 7 Sep 2026 06:39:03 +0000
Message-ID: <20260907063906.1964557-6-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 69218c13-c28e-4033-e503-08df0caacb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mnaoLqpzRrW3z2NFiJIRH9GKB9gO8hpRu54YnYnzloiSgwWebPcpAm7oKX1sn0CrSjTV9wiDTMlPUymCvrKzOQd1TwMomhbNm/K2t/6zHhyrE3SKVgg2Mp0mW2RcAS7zkvKPvmn5K+IJjuJ5yrw3h9k0nnDs0QMzfB54aRmkixqBJp8ZAjCfW9ORQBZ7T0Dt8bylTDa1VS8593C30xMEmrsLrCWASf2+7oNvJv15MUxUQlD8BRzgGwDtlhTnhqprvWvoF7ahb8TFFo5whD4MlykldmmS8Zbe/dJUn5MtO3l/CUJsW0+UK8qY07LfDjW5SU2wvpaTwGElqLB4+2/gSPPkh0ItFzFCQm0WPkmCrRWcCt582uxNIZ6uyre9k7+GYnyi3LbRDxwoOCrUPsP9raihC7XUWcXsE/8tNvt5o3JiDXDBPcUbdSYDXYxS2m+5EzdvOPSU4SkDl4jdcaWlYhRoMzA30SD39gUouiek/9os+U4TN2EO99dhSAdeC4cey7Op9sU7FHWffsOVXMkmF+WuWnB6AUgwIS2lL2b8Lh4RU2COKafFFl2w6vzKuzX8XUZDpPpSIyhHTwyT9ngHPvuYC3GJOWATZvOXWkERNms+R3WJn6JvoS7cbXKO+dBEXC0dQUxLwDE+ct9ipEusEognqLly8l9qoZ89YqO+3J9+2duxtMl6UpujVW4StiWDSPTBXJYYYg/uiWt9pFh+Tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/upAglY5fkHS3QNvzfRZkieUZfFZh0RtZ3WM1RVcoSo+3YFG2mSEtBT69lA35UqsV6qaC0O8YnYylXrk2VB1uAStitxr/LWvxpHYAjQYoAreP436z6GY9K8t6LFkG40RuruzAe4go52e9ej12ifCnkAOfvdQLxGUQCMLyubeT8CDL4mEN9od+22e54uKJdfi16HyfjN8NAS7I+SpicguGWnPWLv6LOqDL+NOkyfPZB/7KQB9+Ecplor3BXczsiRKW+IOI0ek+0iPCZbavxdXlZ1jyWZtCnf3+Ku3HH2hjiuHOGPPF0kvZJWWvYuVg43hISFJ7uYJnY3ZccyckN11Lt8oXGJQlTq10guLT2TV3rbO9VfS7B62kluEHDnINq0gT2C5djCnYzcL8taaCVTtrLwLUJFqqGA9+CiDi6N+5yU1cTGrkLFT+BkQvXeA/YjZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:40.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69218c13-c28e-4033-e503-08df0caacb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

Move the PML enable/disable decision logic from the VMX into a new
common wrapper kvm_update_cpu_dirty_logging() in x86.c to avoid
code duplication. Update the update_cpu_dirty_logging() signature to
accept a bool enable parameter accordingly.

Note, this subtly changes the ordering for VMX: currently
guard(vmx_vmcs01) is taken before the atomic_read of
nr_memslots_dirty_logging; after this refactoring the atomic_read
happens in common code before guard(vmx_vmcs01) is taken. The ordering
flip is harmless as a concurrent change to nr_memslots_dirty_logging
will queue another update request.

No functional change intended for VMX, restructuring to prepare for SVM
PML support.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/vmx/main.c         |  4 ++--
 arch/x86/kvm/vmx/vmx.c          | 12 ++----------
 arch/x86/kvm/vmx/vmx.h          |  2 +-
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 arch/x86/kvm/x86.c              | 17 ++++++++++++++++-
 6 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 07c422793702..2debf6294290 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1672,7 +1672,7 @@ struct kvm_x86_ops {
 			       struct x86_exception *exception);
 	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
 
-	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu);
+	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu, bool enable);
 
 	void (*vcpu_blocking)(struct kvm_vcpu *vcpu);
 	void (*vcpu_unblocking)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d0786..e77b5b731275 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -108,7 +108,7 @@ static void vt_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vmx_vcpu_load(vcpu, cpu);
 }
 
-static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
 {
 	/*
 	 * Basic TDX does not support feature PML. KVM does not enable PML in
@@ -117,7 +117,7 @@ static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(is_td_vcpu(vcpu)))
 		return;
 
-	vmx_update_cpu_dirty_logging(vcpu);
+	vmx_update_cpu_dirty_logging(vcpu, enable);
 }
 
 static void vt_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d944ea9ed273..b3768b4b212f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8418,21 +8418,13 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 }
 #endif
 
-void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
-		return;
-
 	guard(vmx_vmcs01)(vcpu);
 
-	/*
-	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
-	 * code, but in that case another update request will be made and so
-	 * the guest will never run with a stale PML value.
-	 */
-	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
+	if (enable)
 		secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_ENABLE_PML);
 	else
 		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6bcca3487c59..5f505ad14dde 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -390,7 +390,7 @@ u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
 
 gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 
-void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
+void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable);
 
 u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
 bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..4810f9b1b0fc 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -118,7 +118,7 @@ u64 vmx_get_l2_tsc_offset(struct kvm_vcpu *vcpu);
 u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
 void vmx_write_tsc_offset(struct kvm_vcpu *vcpu);
 void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu);
-void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
+void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable);
 #ifdef CONFIG_X86_64
 int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		     bool *expired);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dc5af51c0a90..6d26de8b7c3c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8073,6 +8073,21 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	kvm_x86_call(set_apic_access_page_addr)(vcpu);
 }
 
+static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
+	 * code, but in that case another update request will be made and so
+	 * the guest will never run with a stale PML value.
+	 */
+	bool enable = atomic_read(&vcpu->kvm->nr_memslots_dirty_logging);
+
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
+		return;
+
+	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
+}
+
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -8239,7 +8254,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_call(recalc_intercepts)(vcpu);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
-			kvm_x86_call(update_cpu_dirty_logging)(vcpu);
+			kvm_update_cpu_dirty_logging(vcpu);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu)) {
 			kvm_vcpu_reset(vcpu, true);
-- 
2.48.1

