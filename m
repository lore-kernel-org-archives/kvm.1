Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD037B41C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080390; cv=fail; b=EiyAco4BuNnc8uib9JZOSvUZ1HdYRbMn/egyfqS8Q1ZbQIEkQCvgWm3gFeidNbypRieDauYdRbuRWVcN4llrqtfyDS6DDYfyy+LQUhDJAv8aMTQ68sIZbADIONGYeF4e/9CLJRg84PnTcZ9qHe4RMGkoUggPWo92OyR2DLa1KaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080390; c=relaxed/simple;
	bh=NlO5p5aFWcqSF4HMwoLKUwnwRD0W51/kvFV/nU/MnMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb9/ifZStgdF4ESG7Qrdbb+jq8Bqlz9F6wdGcP0Ue+cMedCDF31hmcTT4BVLuNkFnXsUcOwTEaOrmWeM77b8iMdUNwI6szVgVGOrs2l+1nL9ZeV5ZrR5GYEVckjxEvDa0Ax7ISvoBB+5+kYncujXj8GrHYF2/DZ949yBB7z6aqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eQgJ+6IT; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eQgJ+6IT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lULKZ9R+pP279ZroZGnajsGHul2hYG5GyVdvp9yafkeonPmipm189YnflbDGrC3iqlOoYNp+v6yxQEsq/aQsmCRlEIgN/VIlQzLhRx4S78gGZhJzNMs3GUTBUcVNSbhxgfsWfYdcdIUSVsAhmi6DpA1j4/uu6OGOvgXllM/4Xcj328Rac7l9Y/vKtmeXBFHt8d80siczM7CHyIWo0j6XmPUpfVQXXhDrzL5I5Cs66m7ZW7GKOHNX2Mk8cjxWn3Xrc+xcZEfCsKaVI8+x0gKBcroIfXwRA4qT9DPFqn+G9jqIVnkrSayNbuWG8LwKB4cLietk6C9DOS1+XombWvtObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34uZkpzW9reApApjTZmCh7+O5NWYuV2Flwqw3pgnByw=;
 b=Z3iRXEI1QJ+fO9eV8kGB/dy3FbU04HxsfaMghIVe79QgKSN+a+HcfUtdFcPlJMbE+UDEp7cgkCAWnFiR2GnjNjkgGH4PhIlCnlLIGnrNwRClA2hc0buFJIZbjhApdlWTN49vcp5PpsyZEBUF1w5b77y7gef+1wHRBB0+gTO+DOJqIlz4iKEHbM3J+lVK6KQq9Cb6TQ/z6COjPaZTIXUzka+NhPFAHaTJGhDuAtUkyInMD31JnY9//vL0QF7FbfwD2DgtkMxqzRQhKi+ZmbvIteYmB+BYEqSzeh0G3SkPZISNhcA6W6Hass9KjGdBvh10Iyds5O3+O09mg9vJJmL70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34uZkpzW9reApApjTZmCh7+O5NWYuV2Flwqw3pgnByw=;
 b=eQgJ+6ITxeCwA0gHP955EvLcJ9eOOZb9z74Daqs80ZomtXI7isUnlcSROsNIGODZCXJSHJ1bDiRdk74RvHVpHLgjuDrWoJRTa1lxy9FwU1W4ToPCCgVh5USQyNszgc3Wpvq4hY5KKQfNvdoA2atbqKjMmWNExx3rCC0SMJpulUg=
Received: from IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::10)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 04:59:44 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:464:cafe::22) by IA1P220CA0016.outlook.office365.com
 (2603:10b6:208:464::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 04:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:44 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:40 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 1/7] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
Date: Mon, 18 May 2026 04:59:10 +0000
Message-ID: <20260518045916.2988667-2-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518045916.2988667-1-nikunj@amd.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b393175-46ad-4cf4-4473-08deb49a4700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	eDnWHXCD5+8hIoDTQ+pziGiaR42f/nTh/tPRbBJqyxEWAiP3qMRabO44D1hn/UEP9J963I4x+PAWvx4gLzNd1r+Mg2GSfAz1RXz28vp+WKQg9eGwkXbFohT0uMF+O3lDf29NTG0FIKL4gO1ck8eOZgVJ/XCGv/PtD0S8SJBuOpddeGbHlDRvnZME5s6MD8I0r49Vl4dajD+fSy7GqNPgdLW2gwyCb1fwTDQb/4YuxRLqdrDVpv2XajhfaI8X2RWhaPcySbtQTpNufL6RuvMjoDn6yu/KxfGmtsojt0lOaWQkVkY5tZRrguMJb8RDazMEkUWKYgoSAvzJ1rUpYPiNbWLAISgITfiOEFMj31CcwkjnOTjjCSaANFu/tza0qd1K8Dm7Tvhsx9/6hO+/pgn14FNmleSq+srf9U+D0yE2a/0z005gilXACFb+H//kTHsZboGhaCHnmrkD1nKwrQFAbpIfz//J2igQ4AkRPceGreYFI9NhP4Qc/Anq+oQw8Wion5o5H8v0wpNc3mcEH02Z6N4spnCnoHtu+bzeCARwdMdNQZ7l4+Pfqrhuk6r/+9u1uGnOqte3QkVdUSuSvYOlKGuEL/GFKDwiXvrpJunmt0licJFnNvla6HDvMAhi/RuEkiFiipgtHx3zFgvcBi8AxJj6Dhr59Lp1h4MYs/dp3NBRw4xb/ZjKydv9iBY70KDHLHQKnSnh4y+lV+R0UQyv3oYT8NChj8I0F/RgdNBkU4w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sp0AZ0tcT+xkqf54a4HrzosOEMb6hWRZis6mpIzWxHTkf2cXAw1DO2Nvzt50GKRUbTReLfQbM2p+BZwTz+NmVFL8jtit6W8ufJvu0H5OWStyUJfaUruz+5pczkwN36ZLXqhSOZw7mH4hshB1uxM1lLLcXRyIWw+c78ilOOYAxh5DQTUIYpuRoGdcV/qO+NYciT3RFKBXKlkxu16laDlaFYQd3O1gNkVFy+98YlulsHVxTbpq+UIGUPv5xIyqCQS1s70CRCt3w7eC7xh73AMsWRVLlYlqLlJF2g8bSP3FblrxElpeSDybiQt4iC9uL9W/SKAbG2D3oXA1/uDKDxByWipcbyRD6aMtaACkIPD7xQsNbcys+/TI8nM5m3fvTbakv8GMkuhXuzQZvoHVhIa5cB/tfwZLTF12HpkJL5WuVnuAt14pl8IB/IwuVzif672D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:44.1929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b393175-46ad-4cf4-4473-08deb49a4700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

From: Sean Christopherson <seanjc@google.com>

Pass @vcpu instead of @vmx to init_vmcs(), and switch all of the vmx->vcpu
usage to a simple vcpu.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/vmx/vmx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b02d176800f8b..db468bcdc9808 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4851,10 +4851,11 @@ int vmx_vcpu_precreate(struct kvm *kvm)
 
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
@@ -4879,7 +4880,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (cpu_has_tertiary_exec_ctrls())
 		tertiary_exec_controls_set(vmx, vmx_tertiary_exec_control(vmx));
 
-	if (enable_apicv && lapic_in_kernel(&vmx->vcpu)) {
+	if (enable_apicv && lapic_in_kernel(vcpu)) {
 		vmcs_write64(EOI_EXIT_BITMAP0, 0);
 		vmcs_write64(EOI_EXIT_BITMAP1, 0);
 		vmcs_write64(EOI_EXIT_BITMAP2, 0);
@@ -4891,7 +4892,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->vt.pi_desc)));
 	}
 
-	if (vmx_can_use_ipiv(&vmx->vcpu)) {
+	if (vmx_can_use_ipiv(vcpu)) {
 		vmcs_write64(PID_POINTER_TABLE, __pa(kvm_vmx->pid_table));
 		vmcs_write16(LAST_PID_POINTER_INDEX, kvm->arch.max_vcpu_ids - 1);
 	}
@@ -4926,15 +4927,15 @@ static void init_vmcs(struct vcpu_vmx *vmx)
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
 
@@ -4949,7 +4950,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
-	vmx_write_encls_bitmap(&vmx->vcpu, NULL);
+	vmx_write_encls_bitmap(vcpu, NULL);
 
 	if (vmx_pt_mode_is_host_guest()) {
 		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
@@ -4962,13 +4963,13 @@ static void init_vmcs(struct vcpu_vmx *vmx)
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
 
@@ -4979,7 +4980,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	init_vmcs(vmx);
+	init_vmcs(vcpu);
 
 	if (nested &&
 	    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_STUFF_FEATURE_MSRS))
-- 
2.48.1

