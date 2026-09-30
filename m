Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CA5226A0;
	Wed, 30 Sep 2026 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804102; cv=none; b=mZDu3F/ZswXqpSUXlbr6lWLv4TNJzRlb1aSQ6vFbTKk/BQM9cJvqq6LE5W+mx9WE6Tm5Fdo5l5yb0Q/QxsQkVCytPiUdKKj3ZjYzRqjZTjBMdBWdTMP1Eh+aOkm3SJSZk/2YzU6hrd5rv1arQ0aA1X/o8Uvyx7ql02saBukRgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804102; c=relaxed/simple;
	bh=/lZY1lho0EVSMIJ7R8XpSxxMW5zamnnUWgcay3/CGqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndtSpz/7WKUjr+yL4QdqFGwpyRB58/MX288ZjbkJamUKmJ3Zo1chsFdpuIgFMuzcxv/Ui9iADopYODEjDEe4Cx7UKtrK9qmqPe3LL6s+LEq8/Mwa0L2VZ0ge2/RMba5auTUg35UkGTskyxsEJAYPeGReDvN2bDgOVen17zWe4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1fEZS/f; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1fEZS/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804099; x=1822340099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/lZY1lho0EVSMIJ7R8XpSxxMW5zamnnUWgcay3/CGqc=;
  b=W1fEZS/frwUK4zbllAn6RomXVDPN4THkdu/nUV8t8Sxb895SQycp6o+G
   f0nsYlZ17N7jrdRmdxjtLoM4PrP7hqn6DTzDNs4yNAwZjkZ24y+SkddUn
   D5nZf2BMkL9ce1aSBo5VoijsR/7vf54f8wXoTHXhNcAcK+axChQmay68m
   +WD5btv2ARRTzVUJYUntLzJjGE5sNjZeDRHRr/rzbkbShFJ5iCqObQojU
   dRk7eE2amwFOXY3CVfdrD2EuWxvHTxn8bHvpRhpZAYdZmm/AOOvHuImsX
   W8O17jfhOB8YTyPUH9dsO2RR0uJW8EneUbjKBSaWvDcKCW8CiTOtnp72/
   A==;
X-CSE-ConnectionGUID: rqnW4r2MS4OcVZi+ItWyHw==
X-CSE-MsgGUID: yjDFxYZXQqWQTfYoOCSMrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432674"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:34:58 -0700
X-CSE-ConnectionGUID: 7dGtqJefRVqqDNMjCyWlVw==
X-CSE-MsgGUID: gS5V4OBTQoqyYwJFh//TUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867218"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:34:58 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v8 05/20] KVM: VMX: Refactor instruction information decoding
Date: Wed, 30 Sep 2026 21:07:35 +0000
Message-ID: <20260930210750.1487547-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 58 +++++++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c    |  9 +++---
 arch/x86/kvm/vmx/vmx.h    | 48 +++++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 67168cd3e7af..f05ac3c9aa12 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5242,7 +5242,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 instr_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5250,20 +5250,20 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 
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
@@ -5679,7 +5679,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Decode instruction info and find the field to read */
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	if (!nested_vmx_is_evmptr12_valid(vmx)) {
 		/*
@@ -5727,8 +5727,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
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
@@ -5801,8 +5801,8 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	     get_vmcs12(vcpu)->vmcs_link_pointer == INVALID_GPA))
 		return nested_vmx_failInvalid(vcpu);
 
-	if (instr_info & BIT(10))
-		value = kvm_register_read(vcpu, (((instr_info) >> 3) & 0xf));
+	if (vmx_get_instr_info_is_reg(instr_info))
+		value = kvm_register_read(vcpu, vmx_get_instr_info_reg(instr_info));
 	else {
 		len = is_64_bit_mode(vcpu) ? 8 : 4;
 		if (get_vmx_mem_address(vcpu, exit_qualification,
@@ -5813,7 +5813,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, r, &e);
 	}
 
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	offset = get_vmcs12_field_offset(field);
 	if (offset < 0)
@@ -5990,7 +5990,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long type, roots_to_free;
-	u64 vmx_instruction_info;
+	u64 instr_info;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -6010,8 +6010,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
@@ -6023,7 +6023,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6070,8 +6070,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 vmx_instruction_info;
 	unsigned long type, types;
+	u64 instr_info;
 	gva_t gva;
 	struct x86_exception e;
 	struct {
@@ -6091,8 +6091,8 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.vpid_caps &
@@ -6106,7 +6106,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6436,16 +6436,16 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
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
index 74c4b9dbe29b..bd8505d69420 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6154,8 +6154,8 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u64 vmx_instruction_info;
 	unsigned long type;
+	u64 instr_info;
 	gva_t gva;
 	struct {
 		u64 pcid;
@@ -6168,16 +6168,15 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
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
index 4751f27f006b..92eed58f48ad 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -715,14 +715,54 @@ static inline u64 vmx_get_instr_info(void)
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

