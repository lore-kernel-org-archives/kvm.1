Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DD3C37AF;
	Wed, 29 Jul 2026 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354214; cv=none; b=lQ1U34djK83TrfrdtAPZxRsawAuUcHbza4U++nIF8ZSanKx9DH35pQeGiuPsb9WuazaDQvFluYMBWR0RHntWzsY80vUuO/qXaCUYsO9TCMKP1WJCEu1tJ5v6h85GVTaOsmY/3VwfUHQDVrMjNFv9BwzTI7b3Zn5q4ULdGAfdPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354214; c=relaxed/simple;
	bh=tio3cp9B5/Kj79xKjqBojFllG1Xx1jqzA924PcO48Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEea3aTwK4WIjBPrsOKFGrWeP27txgvXn79qkumesMOoviFyDKXFBNGIPb/BSdH68tO5C7EyFxzNoBdtwddOKPsrQhpv79gpGZEg6pPSZmYuDte/K4+lG4vEtNsnjjXSF0UeX0qN8S9+he+vP5CxSCdH8LmFajWxYRNcNS7QEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzq4qKeW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzq4qKeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354209; x=1816890209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tio3cp9B5/Kj79xKjqBojFllG1Xx1jqzA924PcO48Ic=;
  b=bzq4qKeWgpVpWapYt7GBF+n7H1wAYS8CwBfiRLE5d+GGMf57EH3cx8aI
   tNEJ1yZM1T0jHr7swe5Y8JxfYlFsZhHHxmK+e6o69lI3/zLQfMU4rsfla
   Ze/6DCh09DtDgV9LfMO5A0wQP9EU5T1ZUJ9ewXK8idyt2MiLCyPVGcwAD
   QfXOHkFNM9NJiq5YdhqhnTssFjYIzhN/p7PukeuGKI+3Off5Z9X3mcpMU
   8084UD4CzMv2h4KO+VdVjeczDh2Sx96+X12bIjv3kZsLOqr1Ce+m1uLo7
   MBNsVsJ8SccBEuukXOcQyTzEDBKK5m6reBv27y6yabiE/mlp3ig9C3H8B
   A==;
X-CSE-ConnectionGUID: kqaXkL31QmO8ZoGw7QdrJQ==
X-CSE-MsgGUID: I1qnanWuSQK9pStobC6s0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508252"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508252"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:20 -0700
X-CSE-ConnectionGUID: glQ3vdXhRBWy5/8qEyUSvQ==
X-CSE-MsgGUID: EMtJCDiWThCjTTZl9A5C8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769231"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:20 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 04/20] KVM: VMX: Refactor VMX instruction information access
Date: Wed, 29 Jul 2026 19:16:40 +0000
Message-ID: <20260729191656.598771-5-chang.seok.bae@intel.com>
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

Introduce a helper that returns the instruction information as a 64-bit
value and adjust existing sites to prepare for a wider field.

The VMX instruction information field is currently 32 bits. Future
extensions may expand this field to support extended register IDs,
requiring a wider width. The change provides a single access point for
the transition.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: Convert vmx_get_msr_imm_reg() and keep `u32 type` in handle_invept()
---
 arch/x86/kvm/vmx/nested.c | 23 ++++++++++++-----------
 arch/x86/kvm/vmx/nested.h |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  6 +++---
 arch/x86/kvm/vmx/vmx.h    | 10 ++++++++--
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0635e92471c8..92b530baa0ee 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5234,7 +5234,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5366,7 +5366,7 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 	int r;
 
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-				vmcs_read32(VMX_INSTRUCTION_INFO), false,
+				vmx_get_instr_info(), false,
 				sizeof(*vmpointer), &gva)) {
 		*ret = 1;
 		return -EINVAL;
@@ -5651,7 +5651,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5757,7 +5757,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5946,7 +5946,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
@@ -5974,8 +5974,8 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info, types;
 	unsigned long type, roots_to_free;
+	u64 vmx_instruction_info;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -5983,6 +5983,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 		u64 eptp, gpa;
 	} operand;
 	int i, r, gpr_index;
+	u32 types;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_EPT) ||
@@ -5994,7 +5995,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6054,7 +6055,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type, types;
 	gva_t gva;
 	struct x86_exception e;
@@ -6075,7 +6076,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6428,7 +6429,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long field;
 	u8 b;
 
@@ -6436,7 +6437,7 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 		return true;
 
 	/* Decode instruction info and find the field to access */
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	field = kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
 
 	/* Out-of-range fields always cause a VM exit from L2 to L1 */
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6d6cd5904ddf..fb4f1757cb40 100644
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
index 1c86919d14d4..8a4b578252c2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6158,7 +6158,7 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type;
 	gva_t gva;
 	struct {
@@ -6172,7 +6172,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6323,7 +6323,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+	return vmx_get_instr_info_reg(vmx_get_instr_info());
 }
 
 static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index de9de0d2016c..a3f58a3d90e5 100644
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

