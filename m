Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940317;
	b=J1MFYMwMrzxSTYJCHnxznU0BaKJCNoP6jGdga48uNWzRIdu1YiFCmk57cszZaiysZ1l4
	 uRCh5nPoVAu5ZUUop17M/tPUG/isCY0QL5+lksE/DsEAmYtd4d1rAmwCvIbpnSqTZu86O
	 VcbHRfIhq7ExSmT4njGOk+xF17o75suL0udZOKdDW33hZxbOQq/KNOD2qF6xeKfeU2pni
	 jjHXpWdSDYYOZ0yEPqPkcnLCCqbf19Ukg6g4xIvzmgC7CErzsuqITZE0RiUFC3OBrEo1s
	 /DAwXOjymH/2m4ofLA3PsVU5ottkDemfMmXCR7F9cg7bF33Ev5G5ClMOTpM+qJJFBNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=orcSIjpY0PnZMZ6MpyZm8883qObQSJGN+r1xqdzq+4k=;
	b=3sHutkP+BG9fwofWbIbNSRItEfNOXBX5eQFYQjPtcJU1b5Oo1gL2+pgX5m5YgEREZlTz
	 FT3m43qiENF02euH9YntZ65qaiNK3PJFYtNCpeUhFK4n4bfeH2N7fnatq7FSK4ZQh0lx7
	 +lrSuvxH2xY4YSmS/odbwYS7qInemj5rNJjRYdeKEQ03zZ5URli7fm52TwqjYdNKAcn4r
	 aF+by7wXokcqzs5zme1KfQI2MBUYF4Gy2QNRigyUfUFOsynhBwmNl8H3rowmR6smYPi6Q
	 Kh5iMiTZesauWFsjomGloBhFPHq/sJtf/aIBs2uJsLKOYpbP+zh2tisB7ddnxpAwlew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VK9V4Vfc;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570B606A896;
	Tue, 17 Nov 2026 18:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D570B606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VK9V4Vfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940317; x=1826476317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBeuzU2K+VxyKJUyVmrsgVO1CUjp09J1v2DpmGwwUgg=;
  b=VK9V4VfcXrn+veMrksMMseaBk31F3//oB5jPgsVK7/ebSLoYptONdMdV
   2VoKP3gUG7K828pADTvVF6brLyAVRxNyp6enz++HcH1s980CcPCZCxkkD
   tEtdY4feKmn3ir49/7pZpHzcj2U7RNcXq0CqvXUy0CFKPpL6MSN52a9Bl
   54Hj3VFgPFR81fZjcivv43twGug8rc0sNoDzTE2A76PAGKAs1yO7tJGJt
   mrzMZe+ZKu7xNvHamL48wI5QM08lM89SnkEKPVVG6+tDBFFhpXFPFzWfW
   vpn+4qwKMa6hUApDuEGEKR8dpGr903r3Pf1tki0RrwwQJlVqguTxmWMaz
   w==;
X-CSE-ConnectionGUID: CiudRN+dRdqdDsZnR8oeug==
X-CSE-MsgGUID: 5Pk/mxmhRaemPYYZ+d4nKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607251"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:47 -0800
X-CSE-ConnectionGUID: O6W8/iXgTfK2uR5C1I0n5w==
X-CSE-MsgGUID: u8tbIgXXRFywC3GVvbGNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775027"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:47 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 05/20] KVM: VMX: Refactor VMX instruction information access
Date: Tue, 17 Nov 2026 18:02:55 +0000
Message-ID: <20261117180310.921701-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper that returns the instruction information as a 64-bit
value and adjust existing sites to prepare for a wider field.

The VMX instruction information field is currently 32 bits. Future
extensions may expand this field to support extended register IDs,
requiring a wider width. The change provides a single access point for
the transition.

No functional change intended.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V8 -> V9: Rebased on 7.4-rc1
---
 arch/x86/kvm/vmx/nested.c | 23 ++++++++++++-----------
 arch/x86/kvm/vmx/nested.h |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  6 +++---
 arch/x86/kvm/vmx/vmx.h    | 10 ++++++++--
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a98f28651f7..ccd7843f43c6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5218,7 +5218,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5350,7 +5350,7 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 	int r;
 
 	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
-				vmcs_read32(VMX_INSTRUCTION_INFO), false,
+				vmx_get_instr_info(), false,
 				sizeof(*vmpointer), &gva)) {
 		*ret = 1;
 		return -EINVAL;
@@ -5644,7 +5644,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5750,7 +5750,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5941,7 +5941,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vt_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	gpa_t current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
@@ -5977,8 +5977,8 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info, types;
 	unsigned long type, roots_to_free;
+	u64 vmx_instruction_info;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -5986,6 +5986,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 		u64 eptp, gpa;
 	} operand;
 	int i, r, gpr_index;
+	u32 types;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_EPT) ||
@@ -5997,7 +5998,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6057,7 +6058,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type, types;
 	gva_t gva;
 	struct x86_exception e;
@@ -6078,7 +6079,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6423,7 +6424,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long field;
 	u8 b;
 
@@ -6431,7 +6432,7 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 		return true;
 
 	/* Decode instruction info and find the field to access */
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	field = kvm_register_read(vcpu, (((vmx_instruction_info) >> 28) & 0xf));
 
 	/* Out-of-range fields always cause a VM exit from L2 to L1 */
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index c6de848bd9ce..6bbccaa8263a 100644
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
index dec480c46a1e..5d95f8138628 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6154,7 +6154,7 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type;
 	gva_t gva;
 	struct {
@@ -6168,7 +6168,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6297,7 +6297,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+	return vmx_get_instr_info_reg(vmx_get_instr_info());
 }
 
 static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 74cd50f29fa4..cda6e9707686 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -678,12 +678,18 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
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

