Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F693AD51C
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763176; cv=fail; b=R+NMIYrS81Kq5CBC4h43ipLSGkoOoGZ/KnB0dkJB+XlxjoMsu69gh4AT7y9xKcl8A0vcyBqrOjrZSek3+yvzrb50ohaJHtdQydGWEzSL7KMSonfW9cMRirH/ZM3bN25SeqTZwkELWka2qclK8iDEUURzz92z3VgEBwgKSTTpDdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763176; c=relaxed/simple;
	bh=1I/5VksMgll4EI032T8S5UnaAPJSxUVERzH8HQtO03o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG2RHRprCp1utA2wpFhQoCdIBgtJtV14t6W+ZZIv+Xyj81X/E5EtddoPaTkmdjH+3wKPen8UOOD6xlT91OodxgZBQA6a+mNYTQMajqpXRaUwSlwsj26aIqptRBBuMH+LDUShW/JtZu6tmqqMItZreJ8KUxPVkNECCtjO181TW94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFrCjSQ4; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFrCjSQ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpLPFcKA3kHUo03leGoT9o7IA3gS9yPKm0iN5NbwS2n59fNRJou/AYKU5E/qxnb551dBKaMVBEbC0j7gx1IYb0Q2lh/ejz+8DbYL8tZ4Ht6BwIAak/pNSKIt73TRMTztucBZQKc63hUQfLUqf+dLLv3XWUXAhejzM3yASMUP/wXemjQzQuq8WY0pGUn/GZQnJYsrdvH4tPM+fRKxeCNkenrXjTC/z1hhygKcoIbMgq4zIdkBEnGCjhNQ790HhTyEjhlW36XpgKCl8NgQd7l0FQAgNgZpUECAlED5ndc9UCLEWEUdAwZyDnWowRZuvCRkf3ekL8g9aPssbva77exdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkPAOnZsDLxYe3YO98j+6kvNtJDDQhRFdmsSyPvhGLU=;
 b=N084uZtyKWh+OptUnLcpAgPysLGWeVA+xiCunwXheaxZCD6fDxgPaDyBzBiYGXan9Arblr5DSeNWOOEWqDfHAcXLGTL+rwxW4L67A5/7VxgNOPSsjCPsKOfoLEZtY2s9mum2g+u/Cw9Bu3WX0A3v9rbe7Y5mKeopSf/lTKOnNAeULKyr8cR0eXneIl4uVeRRNloylURSxI30WrNxMOLT1zFkskCoI5m68q5FdhpTr7Ma+4hYlKVO2hqo9D5jisbmZDjDvADbYVFnRPQQfiIwrxJa3T7e+eZxwL74rHQNzwpyALfaawZbBomz3YEQOKXsfV30RuMsULPVcMj4Ak9ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkPAOnZsDLxYe3YO98j+6kvNtJDDQhRFdmsSyPvhGLU=;
 b=vFrCjSQ4QLtDu+f9U0FCzJaPzTGNx2bMnJGLlO4uI84e0Z1+iZLz2Cm5ktvDZ/VYuYzsUJM5UhutD4kPbHxtViJZohyzOt6RwGnw561GYMs5FnPZeUD2m+t+BVGYpKiK2iyn1rKpcMATkXJu9hrDWymZbb310Ve11Qi0HL35GyI=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:28 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::17) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:28 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:25 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 1/8] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
Date: Mon, 7 Sep 2026 06:38:59 +0000
Message-ID: <20260907063906.1964557-2-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: c47675ad-8031-485d-0bdb-08df0caac440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ux9FIEJ8iuscHfFdborM1UTG1GYz+J3KA23O3hcq75SLwVwj/yy8M0etL0/dWI8/oH4fKt9/l+sDCPpTrXYJrvt14atMKln5ftENk5K7I4MWkY70n4HsL1OdtTneHd42BpByPkMg/a4sxzxvMKps0O66R1Rc0UpgydYjFXFLJaE9kaFMltdY2bQlGlF+eKhmqQSMsx+U5rey0/K4aNMtBS/NZA0s1xS26Q/3tzFYh7D4fg0MB+XnHyE57Ut6sfOX17edgoHsLc9Bs6GIV+cXpnlVzukldeaufqNdsnmi8/rTv+022MXqBiDSHmogt7flGrbuYXfxL2cgwOoVErP7nqWUzQD6nSR1cOLu/peCllqQTJCiQ2F0Q9F+cJB0aNhQGf/QoM69Znh8E42GeXw1OMUxilETDVA4SUoFF0RKnObRdfJUFrFXqsO1FdplN0TRxvm0WP7y/9FTforIcVdA2caPqRnUZ4YVZIcJx6oaJlxJwxzBdH4djSVqMbqDH4oqq/YuOQ9IF3nphOsspnTuP+N6jiWW6opdf9ymaLbZU+hdRnedmNx12EZXJgiq1qbxgXVHtB8n7nJt4Ila69+FZBtKY1t6JUIXCNUDpfHpBqyxFvtcW908ynZI57eVVOYqIOu71wkxld2pYvWX2bg3KUPDEbkne51TT9EQbXoY5viWjh0Oh517Z9UBTR6pl0b6dO7+LuLnzayko7NAwojwGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PUgIgu0weu72dY3MC15HPtAgFM7nLDec6IEETcxRJkuJprTCpvgT8Nm66pUz5r3KoYcVyvXAaLSxuR8mSlDB5MsIUK0ztJlYdKNaMrnbyLlCLqvpMqX8a4OH8gQZLHfsSO8WQ5AZbLxgqqvNByfgSHAI2JYcfVlBP/yXSEq1wsdrpBzPv1N5YYptFeS7due+9VyVtnWAE4vsx7yalHdZ1I9ZNnCgevhpMALgSoSiP7llcI6Kk0WbksLyn2W0nj+xKNH1m/1Tp77eBf0wa3M9l5u38Ul5R+/fPk8yQ+9yRihdcXSipI3RrFA+ZTFAF3aGH8M/PB6b9uaE5XRMBwMEed7WnVLN1mHt3wz2MyCkeVlBOCYNJPhvkFKN+WGfhoZD0Q4rdKZWiqN0Mq0iDwAV/a2ck7AE03bbf+DcJBtHKkTiEHgxQkJL5pzGf2wgpuVg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:28.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47675ad-8031-485d-0bdb-08df0caac440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

From: Sean Christopherson <seanjc@google.com>

Pass @vcpu instead of @vmx to init_vmcs(), and switch all of the vmx->vcpu
usage to a simple vcpu.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..a4fb4e77a56f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4883,10 +4883,11 @@ int vmx_vcpu_precreate(struct kvm *kvm)
 
 #define VMX_XSS_EXIT_BITMAP 0
 
-static void init_vmcs(struct vcpu_vmx *vmx)
+static void init_vmcs(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = vmx->vcpu.kvm;
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (nested)
 		nested_vmx_set_vmcs_shadowing_bitmap();
@@ -4911,7 +4912,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (cpu_has_tertiary_exec_ctrls())
 		tertiary_exec_controls_set(vmx, vmx_tertiary_exec_control(vmx));
 
-	if (enable_apicv && lapic_in_kernel(&vmx->vcpu)) {
+	if (enable_apicv && lapic_in_kernel(vcpu)) {
 		vmcs_write64(EOI_EXIT_BITMAP0, 0);
 		vmcs_write64(EOI_EXIT_BITMAP1, 0);
 		vmcs_write64(EOI_EXIT_BITMAP2, 0);
@@ -4923,7 +4924,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->vt.pi_desc)));
 	}
 
-	if (vmx_can_use_ipiv(&vmx->vcpu)) {
+	if (vmx_can_use_ipiv(vcpu)) {
 		vmcs_write64(PID_POINTER_TABLE, __pa(kvm_vmx->pid_table));
 		vmcs_write16(LAST_PID_POINTER_INDEX, kvm->arch.max_vcpu_ids - 1);
 	}
@@ -4958,15 +4959,15 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest.val));
 
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
-		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
+		vmcs_write64(GUEST_IA32_PAT, vcpu->arch.pat);
 
 	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
-	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
 
@@ -4981,7 +4982,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
-	vmx_write_encls_bitmap(&vmx->vcpu, NULL);
+	vmx_write_encls_bitmap(vcpu, NULL);
 
 	if (vmx_pt_mode_is_host_guest()) {
 		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
@@ -4994,13 +4995,13 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
 
-	vmx_guest_debugctl_write(&vmx->vcpu, 0);
+	vmx_guest_debugctl_write(vcpu, 0);
 
 	if (cpu_has_vmx_tpr_shadow()) {
 		vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, 0);
-		if (cpu_need_tpr_shadow(&vmx->vcpu))
+		if (cpu_need_tpr_shadow(vcpu))
 			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR,
-				     __pa(vmx->vcpu.arch.apic->regs));
+				     __pa(vcpu->arch.apic->regs));
 		vmcs_write32(TPR_THRESHOLD, 0);
 	}
 
@@ -5011,7 +5012,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	init_vmcs(vmx);
+	init_vmcs(vcpu);
 
 	if (nested &&
 	    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))
-- 
2.48.1

