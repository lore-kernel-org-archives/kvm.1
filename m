Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C965355057;
	Fri, 22 May 2026 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472333; cv=none; b=IkyvGB/RjTWXTZKwYX19bI5ksLUDbrWPTzwCvv87uL7SQgGWneLpWW8LhOdw7DFvD9crP1CUnzk2T5rdQcMK06/Q80D0UdzJWGhVccG88pRBuWF7+ExVbkad5px0iq048t3ze0G8LYv9g8aSek9Wlm5+5gnjO5URZUe65zd9EIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472333; c=relaxed/simple;
	bh=kHlaOMTDrUR9HvY1Wz85mMKmBja/k8peokE+kICtqD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhETncMVfSAwkZxtRUadsJZWe21A0sz2VbZst5mjWPWmu+7Fi+l3jrw9/I/C6o4xUSDWwo0OhAh7D3Nl9ltDRbEVbGb2PcPcON6pFcQfh1QL5VKSW72TNkhI9exMIq1cOyklDkkcZJSdSjQTir4N/Ma57SWuQf7e0KBQbWm5Sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcXY5ZxN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcXY5ZxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779472332; x=1811008332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHlaOMTDrUR9HvY1Wz85mMKmBja/k8peokE+kICtqD4=;
  b=bcXY5ZxN8XMMuXk0zccHEbvSmB7+b09OaioqimWIbJuqAlzrDBMWj0/+
   gtYDBupz5hABwl9EXKCagX00aH/JHYRH8SE4sUBWZ9WBiK/ZMno29x6qy
   V5Y54ZvJ/6YfN1CKe7l4uNE4YS+jqn3L4sbRNTSB3Fpwtm9//csNAae3l
   MFlbmu5bOP/5BN2EXl33UXHPnR4B8UMkhQ5bIeLzpKmvGStjVV95vCZ46
   QuNUXDOMhN+5rLXs9j8G3NaFT6PTBL6HAj1JRL9kpC0Fg+f9SM/mzi2aq
   b3fTssrx0dY16Mzn/1XccNNKlKFLcNTgHoNAdKo6rBDA5U30WNKNm+pIG
   Q==;
X-CSE-ConnectionGUID: NJx0nHNnSJ+RXqsQN7DkAw==
X-CSE-MsgGUID: fsuBc4cUT26G74rfINM5+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="103082940"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="103082940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 10:52:11 -0700
X-CSE-ConnectionGUID: X6bUMcnWQVyB7518VkqatQ==
X-CSE-MsgGUID: Ux7DvpFESvK0hqghfsUNtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="264801382"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa001.fm.intel.com with ESMTP; 22 May 2026 10:52:10 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4a 08/21] KVM: VMX: Refactor VMX instruction information access
Date: Fri, 22 May 2026 17:26:52 +0000
Message-ID: <20260522172652.181396-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-9-chang.seok.bae@intel.com>
References: <20260512011502.53072-9-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper that returns the instruction information as 64-bit
value and adjust existing sites to prepare for a wider field.

The VMX instruction information field is currently 32 bits. Future
extensions may expand this field to support extended register IDs,
requiring a wider width. The change provides a single access point for
the transition.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from V4: convert for vmx_get_msr_imm_reg()
---
 arch/x86/kvm/vmx/nested.c | 22 +++++++++++-----------
 arch/x86/kvm/vmx/nested.h |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  6 +++---
 arch/x86/kvm/vmx/vmx.h    | 10 ++++++++--
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4690a4d23709..06c1d83a8082 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5229,7 +5229,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5361,7 +5361,7 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 	int r;
 
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-				vmcs_read32(VMX_INSTRUCTION_INFO), false,
+				vmx_get_instr_info(), false,
 				sizeof(*vmpointer), &gva)) {
 		*ret = 1;
 		return -EINVAL;
@@ -5646,7 +5646,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5752,7 +5752,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5941,7 +5941,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
@@ -5969,7 +5969,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info, types;
+	u64 vmx_instruction_info, types;
 	unsigned long type, roots_to_free;
 	struct kvm_mmu *mmu;
 	gva_t gva;
@@ -5989,7 +5989,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6049,7 +6049,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type, types;
 	gva_t gva;
 	struct x86_exception e;
@@ -6070,7 +6070,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6423,7 +6423,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long field;
 	u8 b;
 
@@ -6431,7 +6431,7 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 		return true;
 
 	/* Decode instruction info and find the field to access */
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	field = kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
 
 	/* Out-of-range fields always cause a VM exit from L2 to L1 */
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 213a448104af..ff1ea771d1fb 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -51,7 +51,7 @@ void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu);
 int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
 int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata);
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u32 vmx_instruction_info, bool wr, int len, gva_t *ret);
+			u64 vmx_instruction_info, bool wr, int len, gva_t *ret);
 bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 				 int size);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e8dd5d5b33ad..747e52f79b0e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6136,7 +6136,7 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type;
 	gva_t gva;
 	struct {
@@ -6150,7 +6150,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6301,7 +6301,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+	return vmx_get_instr_info_reg(vmx_get_instr_info());
 }
 
 static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index daedf663c0a9..aa4190620e82 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -702,12 +702,18 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
 void dump_vmcs(struct kvm_vcpu *vcpu);
 
-static inline int vmx_get_instr_info_reg(u32 vmx_instr_info)
+/* A placeholder to smoothen 64-bit extension */
+static inline u64 vmx_get_instr_info(void)
+{
+	return vmcs_read32(VMX_INSTRUCTION_INFO);
+}
+
+static inline int vmx_get_instr_info_reg(u64 vmx_instr_info)
 {
 	return (vmx_instr_info >> 3) & 0xf;
 }
 
-static inline int vmx_get_instr_info_reg2(u32 vmx_instr_info)
+static inline int vmx_get_instr_info_reg2(u64 vmx_instr_info)
 {
 	return (vmx_instr_info >> 28) & 0xf;
 }
-- 
2.53.0

