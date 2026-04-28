Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071234D915;
	Tue, 28 Apr 2026 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353985; cv=none; b=PHgxSmXmOmaGD740XdPtqHfgezJt90vcOx8/x2TnfrxnfM6ym7IPZTEs1bUxnWZHQ7NiUVwUtaZNyPMP5Xl3TNpkyExdqD508b7ikIzIw0LNe3i22RrHY/5pX8oVAz8U3G8HvEQnfwUhr6L90/CVFwVjRRcJtFzRl5+AiUjkEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353985; c=relaxed/simple;
	bh=gzjH0FtlYv7LTHWvCPmEBSTE+qlnlpM5zQJsORs+EIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5McfHT8KI4VuvBkYI2efhbVcTOX2ygYIDnDVzSUC3hP0kOxcsTQLwmEWDFD3qvwdlT33cu8PCYcA6UMyFDgSNFpWhClmaBCfUs7IiqysUhWy8lUWWrvb5baNSXNSVkjb+L2U1Mqqc7vowMaN3EPze4KO2jwYCj8LcIVzXHyxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBkqbooQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBkqbooQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353983; x=1808889983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzjH0FtlYv7LTHWvCPmEBSTE+qlnlpM5zQJsORs+EIg=;
  b=IBkqbooQY91dE/BCAZ07gzY329yNnm/bvT6tTeS+dren15B36aM4OUdg
   XdkchUTvN+0QntkP1S9L/WeWQWS9Wj069gNZY7UiLk4g7j+8wZyaxeFPF
   KdUerhgvvGigFwMFUeqzj570yWxqVEB0Z5wyjwPrTYFyUjhUGxRfRYvJr
   bY6RXD48rTr143UNCPwlpbuW//wF/Yyorvw82rRLO8Au2sYTcfCRdIjAV
   ySVUBibZq2Aak72RTuMbbm0SiihpuOiAxTA13uzrm0JEpR0TBtxnQKI4U
   PRC7+Lp3Xqy5+3exc2nU2F9WR0dr8XCccZEJs9qPR1CTJSUOUkEx/0lE6
   g==;
X-CSE-ConnectionGUID: rATlAyytRq+JR56MIHSP9w==
X-CSE-MsgGUID: e/fCbyHESQi8KWPe2+KPPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131698"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131698"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:23 -0700
X-CSE-ConnectionGUID: TeX4oVIPQtqi8rBDgXQriA==
X-CSE-MsgGUID: 8f5yABb3TgeoxrqnjG19NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130187"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 07/20] KVM: VMX: Refactor VMX instruction information access
Date: Tue, 28 Apr 2026 05:00:58 +0000
Message-ID: <20260428050111.39323-8-chang.seok.bae@intel.com>
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

Introduce a helper that returns the instruction information as 64-bit
value and adjust existing sites to prepare for a wider field.

The VMX instruction information field is currently 32 bits. Future
extensions may expand this field to support extended register IDs,
requiring a wider width. The change provides a single access point for
the transition.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch
---
 arch/x86/kvm/vmx/nested.c | 22 +++++++++++-----------
 arch/x86/kvm/vmx/nested.h |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  4 ++--
 arch/x86/kvm/vmx/vmx.h    | 10 ++++++++--
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c4d2bc080add..69fcbb03ec4b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5216,7 +5216,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5348,7 +5348,7 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 	int r;
 
 	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
-				vmcs_read32(VMX_INSTRUCTION_INFO), false,
+				vmx_get_instr_info(), false,
 				sizeof(*vmpointer), &gva)) {
 		*ret = 1;
 		return -EINVAL;
@@ -5633,7 +5633,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5739,7 +5739,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
 	unsigned long field;
@@ -5928,7 +5928,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
-	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	u64 instr_info = vmx_get_instr_info();
 	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
@@ -5956,7 +5956,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info, types;
+	u64 vmx_instruction_info, types;
 	unsigned long type, roots_to_free;
 	struct kvm_mmu *mmu;
 	gva_t gva;
@@ -5976,7 +5976,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6036,7 +6036,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type, types;
 	gva_t gva;
 	struct x86_exception e;
@@ -6057,7 +6057,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
@@ -6410,7 +6410,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long field;
 	u8 b;
 
@@ -6418,7 +6418,7 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
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
index 05e5005b1524..24e3b47cd1f0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6119,7 +6119,7 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
-	u32 vmx_instruction_info;
+	u64 vmx_instruction_info;
 	unsigned long type;
 	gva_t gva;
 	struct {
@@ -6133,7 +6133,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+	vmx_instruction_info = vmx_get_instr_info();
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index da3cdb89a816..280c76af3bb6 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -701,12 +701,18 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
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
2.51.0

