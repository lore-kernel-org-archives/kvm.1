Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA5322DAF;
	Tue, 28 Apr 2026 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353987; cv=none; b=dX66jHy5B98AWT3KGLZggP8L/HqHymf9jC/TN+5mW2brHwkEi2qNb5wfxL7/V0kzbJlIRFVDa7UHUuF8XsWlrLb5NCkN68aggqTgkFgj4aDlQoLQf0wvo8T2rR18Cv4e5lqevpH8VnwM0/VXNlrODkWVmt6N5xPf2+BKYao3qOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353987; c=relaxed/simple;
	bh=05EDSTYmbsN5MZN2T0Soj/vYVYPR8D60XUIP1aBh/EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXCaRAfhKUQabuGzJn40eM5+6LXUcPUJQsi9wpqXQ8phI4dUgmQ9ZgxSfCoYj2hw0CFkm36ivdthSvPM7X9+L+42VkF4Si2UhuuPvSGgitiQm0zzTw5Vu2ni9OqMHUTIqQUxyvbZoXPFoKkEIF33VvIg3XR4QZoWPWBySAwbJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QssUs7yB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QssUs7yB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353984; x=1808889984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05EDSTYmbsN5MZN2T0Soj/vYVYPR8D60XUIP1aBh/EQ=;
  b=QssUs7yBkreYvi/iXTOywIu59l8jX9DnfjtWolmRnpdEN7Y4vY9l55xK
   MzaVd9wOn2cEOeh/U11txd6IvNzsISP93ZAEBcSTD/KcOQ6qVtAfcXrM9
   dOQHWwkydbTVJmpjGcwiuIDRElkmF+mTPuwsinY0yOedpjZZ/2e82oVTM
   7ZvU4h/X8Rk7BfFvTB6KIDnJ2BdDmrAG+4KwQaKynqcDZezeXF8apOt3I
   yhpMITmh75Wgmbp4YpVbXkAO9b55nZxHjtRAoEq2Am5B7sMUa9ho+V9F1
   OyZ5zvUVm8B56/70Wab0MIIjyonbVaQygsQF7hKvi3FYXlemo5fVcZUqE
   A==;
X-CSE-ConnectionGUID: fP1F2kbHTuaglMpWRLj4bA==
X-CSE-MsgGUID: ieWpmLtCR1qJ8Mn3kcHtWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131702"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131702"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:24 -0700
X-CSE-ConnectionGUID: SqHA3XqdT26DYeTLk0z/AQ==
X-CSE-MsgGUID: FQoBQcMhRGC0aGixjH36hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130190"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:24 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 08/20] KVM: VMX: Refactor instruction information decoding
Date: Tue, 28 Apr 2026 05:00:59 +0000
Message-ID: <20260428050111.39323-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently decodes the VMX instruction information field using a mix
of open-coded bit manipulations and ad hoc helpers. Convert all decoding
to use helpers to centralizes the decoding logic for the transition to a
wider instruction information.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch
---
 arch/x86/kvm/vmx/nested.c | 58 +++++++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c    | 11 ++++----
 arch/x86/kvm/vmx/vmx.h    | 48 +++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 69fcbb03ec4b..6fa8f2a46202 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5216,7 +5216,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 instr_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5224,20 +5224,20 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 
 	/*
 	 * According to Vol. 3B, "Information for VM Exits Due to Instruction
-	 * Execution", on an exit, vmx_instruction_info holds most of the
-	 * addressing components of the operand. Only the displacement part
-	 * is put in exit_qualification (see 3B, "Basic VM-Exit Information").
+	 * Execution", on an exit, instr_info holds most of the addressing
+	 * components of the operand. Only the displacement part is put in
+	 * exit_qualification (see 3B, "Basic VM-Exit Information").
 	 * For how an actual address is calculated from all these components,
 	 * refer to Vol. 1, "Operand Addressing".
 	 */
-	int  scaling = vmx_instruction_info & 3;
-	int  addr_size = (vmx_instruction_info >> 7) & 7;
-	bool is_reg = vmx_instruction_info & (1u << 10);
-	int  seg_reg = (vmx_instruction_info >> 15) & 7;
-	int  index_reg = (vmx_instruction_info >> 18) & 0xf;
-	bool index_is_valid = !(vmx_instruction_info & (1u << 22));
-	int  base_reg       = (vmx_instruction_info >> 23) & 0xf;
-	bool base_is_valid  = !(vmx_instruction_info & (1u << 27));
+	int  scaling        = vmx_get_instr_info_scaling(instr_info);
+	int  addr_size      = vmx_get_instr_info_addr_size(instr_info);
+	bool is_reg         = vmx_get_instr_info_is_reg(instr_info);
+	int  seg_reg        = vmx_get_instr_info_seg_reg(instr_info);
+	int  index_reg      = vmx_get_instr_info_index_reg(instr_info);
+	bool index_is_valid = vmx_get_instr_info_index_is_valid(instr_info);
+	int  base_reg       = vmx_get_instr_info_base_reg(instr_info);
+	bool base_is_valid  = vmx_get_instr_info_base_is_valid(instr_info);
 
 	if (is_reg) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
@@ -5646,7 +5646,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Decode instruction info and find the field to read */
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg(instr_info));
 
 	if (!nested_vmx_is_evmptr12_valid(vmx)) {
 		/*
@@ -5694,8 +5694,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 	 * Note that the number of bits actually copied is 32 or 64 depending
 	 * on the guest's mode (32 or 64 bit), not on the given field's length.
 	 */
-	if (instr_info & BIT(10)) {
-		kvm_register_write(vcpu, (((instr_info) >> 3) & 0xf), value);
+	if (vmx_get_instr_info_is_reg(instr_info)) {
+		kvm_register_write(vcpu, vmx_get_instr_info_reg(instr_info), value);
 	} else {
 		len = is_64_bit_mode(vcpu) ? 8 : 4;
 		if (get_vmx_mem_address(vcpu, exit_qualification,
@@ -5768,8 +5768,8 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	     get_vmcs12(vcpu)->vmcs_link_pointer == INVALID_GPA))
 		return nested_vmx_failInvalid(vcpu);
 
-	if (instr_info & BIT(10))
-		value = kvm_register_read(vcpu, (((instr_info) >> 3) & 0xf));
+	if (vmx_get_instr_info_is_reg(instr_info))
+		value = kvm_register_read(vcpu, vmx_get_instr_info_reg(instr_info));
 	else {
 		len = is_64_bit_mode(vcpu) ? 8 : 4;
 		if (get_vmx_mem_address(vcpu, exit_qualification,
@@ -5780,7 +5780,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, r, &e);
 	}
 
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	offset = get_vmcs12_field_offset(field);
 	if (offset < 0)
@@ -5956,8 +5956,8 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 vmx_instruction_info, types;
 	unsigned long type, roots_to_free;
+	u64 instr_info, types;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -5976,8 +5976,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
@@ -5989,7 +5989,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6036,8 +6036,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 vmx_instruction_info;
 	unsigned long type, types;
+	u64 instr_info;
 	gva_t gva;
 	struct x86_exception e;
 	struct {
@@ -6057,8 +6057,8 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.vpid_caps &
@@ -6072,7 +6072,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6410,16 +6410,16 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
 {
-	u64 vmx_instruction_info;
 	unsigned long field;
+	u64 instr_info;
 	u8 b;
 
 	if (!nested_cpu_has_shadow_vmcs(vmcs12))
 		return true;
 
 	/* Decode instruction info and find the field to access */
-	vmx_instruction_info = vmx_get_instr_info();
-	field = kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
+	instr_info = vmx_get_instr_info();
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	/* Out-of-range fields always cause a VM exit from L2 to L1 */
 	if (field >> 15)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 24e3b47cd1f0..c7b3c1916b09 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6119,8 +6119,8 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u64 vmx_instruction_info;
 	unsigned long type;
+	u64 instr_info;
 	gva_t gva;
 	struct {
 		u64 pcid;
@@ -6133,16 +6133,15 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	/* According to the Intel instruction reference, the memory operand
 	 * is read even if it isn't needed (e.g., for type==all)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-				vmx_instruction_info, false,
-				sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 
 	return kvm_handle_invpcid(vcpu, type, gva);
@@ -6284,7 +6283,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+	return vmx_get_instr_info_reg(vmx_get_instr_info());
 }
 
 static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 280c76af3bb6..272bf250200b 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -707,14 +707,54 @@ static inline u64 vmx_get_instr_info(void)
 	return vmcs_read32(VMX_INSTRUCTION_INFO);
 }
 
-static inline int vmx_get_instr_info_reg(u64 vmx_instr_info)
+static inline int vmx_get_instr_info_reg(u64 instr_info)
 {
-	return (vmx_instr_info >> 3) & 0xf;
+	return (instr_info >> 3) & 0xf;
 }
 
-static inline int vmx_get_instr_info_reg2(u64 vmx_instr_info)
+static inline int vmx_get_instr_info_reg2(u64 instr_info)
 {
-	return (vmx_instr_info >> 28) & 0xf;
+	return (instr_info >> 28) & 0xf;
+}
+
+static inline int vmx_get_instr_info_scaling(u64 instr_info)
+{
+	return instr_info & 3;
+}
+
+static inline int vmx_get_instr_info_addr_size(u64 instr_info)
+{
+	return (instr_info >> 7) & 7;
+}
+
+static inline bool vmx_get_instr_info_is_reg(u64 instr_info)
+{
+	return !!(instr_info & BIT(10));
+}
+
+static inline int vmx_get_instr_info_seg_reg(u64 instr_info)
+{
+	return (instr_info >> 15) & 7;
+}
+
+static inline int vmx_get_instr_info_index_reg(u64 instr_info)
+{
+	return (instr_info >> 18) & 0xf;
+}
+
+static inline bool vmx_get_instr_info_index_is_valid(u64 instr_info)
+{
+	return !(instr_info & BIT(22));
+}
+
+static inline int vmx_get_instr_info_base_reg(u64 instr_info)
+{
+	return (instr_info >> 23) & 0xf;
+}
+
+static inline bool vmx_get_instr_info_base_is_valid(u64 instr_info)
+{
+	return !(instr_info & BIT(27));
 }
 
 static inline bool vmx_can_use_ipiv(struct kvm_vcpu *vcpu)
-- 
2.51.0

