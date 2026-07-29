Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E133C819B;
	Wed, 29 Jul 2026 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354213; cv=none; b=SJ5mGWA2gyW9xL1oe55NyzFg3Eepb5pMyrVVI6gHKkAIMSZmQBPuYOetbfD1Aho+HQ36YLpHtzBgFKGSdiu3cvDrw6GVnGEA3zHiK6E12olLtAVzSWSPQiN3SmxrjzjcDDPZFXCQ9cIAL66AeiTIsYQs+eS2JPzPbF9MwM7tBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354213; c=relaxed/simple;
	bh=NoaQtYvc697R38p3nXqqqb7tsgum8RmWOe4gUlYcfHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLQLtUyaikbhHAmLqKN6nCLryNO5fvljeflDkAPCdAviS+eDKysgLen/6JO2tmqMI+2gYXFWHrIUlhEw2kTATqIX4DnVF5MpztDXhOI5RauUjE2RvBsINv06oRNJdUS6FMvsGS+rlx55/N2Rq1rdrRszd/4IOwEGsAPrXgGUUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZQYUb7Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZQYUb7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354209; x=1816890209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoaQtYvc697R38p3nXqqqb7tsgum8RmWOe4gUlYcfHo=;
  b=JZQYUb7QOaXWeSxZ9Z5MsRd6iotKKQ/R1kKi3Io9kxxIrRenNPC1vTPT
   l2yRYQZoF15nggBkhMDM7nkZqkuEbLdOrB7er2SThs/+rvR4qns1it/dE
   vmzw9o/FuzADBcTI6cHVWvgFQdmfi+zkaJHPC2mHpbi9LNwUg277kVnl4
   j65VQB0PPziGEUacpL1ZDh6kGAcDmoP5f6+i62eSpxPVjd1h4JEc201L4
   zH1Vl1kY+vcnqT3mxzIVmUXFCizA2GBrCzjuM5YAtg37cPma2C4q43iP0
   XIaeTNVYdVzF3n5fw2UrvVG7z2EF+1z4+bEM85G22ZZ7fkn1+uzewOH8z
   w==;
X-CSE-ConnectionGUID: 4z1AFSnfRr22SoUduT514Q==
X-CSE-MsgGUID: 3sC1bVqrTV2a1nzkq4TJdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508256"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508256"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:21 -0700
X-CSE-ConnectionGUID: U0rB7GxoTxuGxIGmrllOKA==
X-CSE-MsgGUID: 0X35MLrTSKGrhezZ6afwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769234"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:21 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v6 05/20] KVM: VMX: Refactor instruction information decoding
Date: Wed, 29 Jul 2026 19:16:41 +0000
Message-ID: <20260729191656.598771-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently decodes the VMX instruction information field using a mix
of open-coded bit manipulations and ad hoc helpers. Convert all decoding
to use helpers to centralize the decoding logic for the transition to a
wider instruction information.

No functional change intended.

Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V5 -> V6: Add Tested-by (0day)
V4 -> V5: Fix handle_vmread() first accesses reg2 (0-day).
---
 arch/x86/kvm/vmx/nested.c | 58 +++++++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c    |  9 +++---
 arch/x86/kvm/vmx/vmx.h    | 48 +++++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 92b530baa0ee..fdec041e95c7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5234,7 +5234,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 instr_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5242,20 +5242,20 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 
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
@@ -5664,7 +5664,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Decode instruction info and find the field to read */
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	if (!nested_vmx_is_evmptr12_valid(vmx)) {
 		/*
@@ -5712,8 +5712,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
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
@@ -5786,8 +5786,8 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	     get_vmcs12(vcpu)->vmcs_link_pointer == INVALID_GPA))
 		return nested_vmx_failInvalid(vcpu);
 
-	if (instr_info & BIT(10))
-		value = kvm_register_read(vcpu, (((instr_info) >> 3) & 0xf));
+	if (vmx_get_instr_info_is_reg(instr_info))
+		value = kvm_register_read(vcpu, vmx_get_instr_info_reg(instr_info));
 	else {
 		len = is_64_bit_mode(vcpu) ? 8 : 4;
 		if (get_vmx_mem_address(vcpu, exit_qualification,
@@ -5798,7 +5798,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, r, &e);
 	}
 
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	offset = get_vmcs12_field_offset(field);
 	if (offset < 0)
@@ -5975,7 +5975,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long type, roots_to_free;
-	u64 vmx_instruction_info;
+	u64 instr_info;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -5995,8 +5995,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
@@ -6008,7 +6008,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6055,8 +6055,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 vmx_instruction_info;
 	unsigned long type, types;
+	u64 instr_info;
 	gva_t gva;
 	struct x86_exception e;
 	struct {
@@ -6076,8 +6076,8 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.vpid_caps &
@@ -6091,7 +6091,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6429,16 +6429,16 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
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
index 8a4b578252c2..c49bc6fabae3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6158,8 +6158,8 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u64 vmx_instruction_info;
 	unsigned long type;
+	u64 instr_info;
 	gva_t gva;
 	struct {
 		u64 pcid;
@@ -6172,16 +6172,15 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
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
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a3f58a3d90e5..acb4d7ac8b0a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -708,14 +708,54 @@ static inline u64 vmx_get_instr_info(void)
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
2.53.0

