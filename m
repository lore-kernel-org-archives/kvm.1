Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940321;
	b=YpXLU0UQvpNOWlXzZ33awc4+j+da7gcQ8TQ9Hvs7n6nwtgVoSatGefDIcTQJd53ZfvCH
	 1G87mPZHv/icYovZd1K3KiO+VzO4BEH/kIMsfZ5FfesrvaEKYKUwIHbzb9CXJgc4lDCyZ
	 k2YBfH7Gc4LDKJm7AccZ2Znlk6vAY98Ss5rPeN/Rqao0eoaeJmxfRySGsL27QDvcRUk7E
	 wA2tIVeGTYbZlp/WAR4jxFoVnfKNLOB20+dqByPJJenkXvCYj/s1vFM6SBMovODxe2fAy
	 sC9HD8wDHlvw8a7IXoYCodqruwoR2rRbYMDlSWBuJbm+yWMesEXtMrILAtcOw02vLQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940321;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ubfk8Z6lwe0ShJEzI9YzXqY42fIAdl4Hrtye981QR3g=;
	b=RqtIS2CKLK3vJoAWuwbM/bOC4qlqyRPOvCM7rubYlYmeQ+JytjteY1msAK8shTv/0lTm
	 WZq+CUBBZ+XdOqHhdZF4CHjzMRsZDgAby8gHIz2mg2ZpQS4VMcRTepoKPyfflFn4YMJMq
	 6WgUx+0B8a9F63JpxFh9dDizUpQ4JufxwsNT6Zpux0vMMh3XV01WJgRk4HsNOb9i9Ypgg
	 GgCMDj1MQpsj6F5HnO+kaZ4yiW49lSnSxk832yYmOGDhFllizBv6mNoXJDt3f5cPGe2oE
	 eOvVvxlwLJoW2YoNxe+MVgzh+CIQR3pjAajuUK13Cu85fMDSFSJ/Vivdeujx4JDJYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dNM1Mc3j;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CC60A3812;
	Tue, 17 Nov 2026 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505CC60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dNM1Mc3j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940320; x=1826476320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdtB8hecPd1O2fKBX/ET7WL7NdNQIi58fBooNGrYdqk=;
  b=dNM1Mc3j9ruNfa8EHBF2L6e/1U2f6eMMjFXo8n4MeBAv3K5c2TptfAc/
   /1a87PuL2btRRlALU9D05N2emyFNuuLkRVFD/h/eXeB/JLthIQAd6qTdx
   1TtkGED9F3Vi08vs8PrZY8wgiMXaYtTc0vNRBVI2O1aJRtLegluT5U3rP
   hwAMO5f9q5Aj/2fESzBBZOoRenZY+grgZMUrhuwYWWwWIQ8eLxOh3K40s
   ZBpHe9EfgjbZ9HMQUZprZkMHrMwSnk4cfIZlpzUrCcu79p0en3FVIp/jy
   CUfBn8gteXayHNieV57wXiBHAa4pGBeNMHiCa4DQL9QTVnGqQ/NJS9kIN
   w==;
X-CSE-ConnectionGUID: yEm+4y/XTNmoVsJ/OJCGKQ==
X-CSE-MsgGUID: MwSEQ9CGRpWH2ehd2+q46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607260"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:48 -0800
X-CSE-ConnectionGUID: ZkwrNhQNTYaB3H0LTw5pgg==
X-CSE-MsgGUID: zT+h9UCZRsGEaBe55WuDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775033"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:48 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v9 06/20] KVM: VMX: Refactor instruction information decoding
Date: Tue, 17 Nov 2026 18:02:56 +0000
Message-ID: <20261117180310.921701-7-chang.seok.bae@intel.com>
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

KVM currently decodes the VMX instruction information field using a mix
of open-coded bit manipulations and ad hoc helpers. Convert all decoding
to use helpers to centralize the decoding logic for the transition to a
wider instruction information.

No functional change intended.

Tested-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V8 -> V9: Rebased on 7.4-rc1
---
 arch/x86/kvm/vmx/nested.c | 58 +++++++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c    |  9 +++---
 arch/x86/kvm/vmx/vmx.h    | 48 +++++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ccd7843f43c6..da73ed81d99c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5218,7 +5218,7 @@ static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
  * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
-			u64 vmx_instruction_info, bool wr, int len, gva_t *ret)
+			u64 instr_info, bool wr, int len, gva_t *ret)
 {
 	gva_t off;
 	bool exn;
@@ -5226,20 +5226,20 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 
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
@@ -5657,7 +5657,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Decode instruction info and find the field to read */
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	if (!nested_vmx_is_evmptr12_valid(vmx)) {
 		/*
@@ -5705,8 +5705,8 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
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
@@ -5779,8 +5779,8 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 	     get_vmcs12(vcpu)->vmcs_link_pointer == INVALID_GPA))
 		return nested_vmx_failInvalid(vcpu);
 
-	if (instr_info & BIT(10))
-		value = kvm_register_read(vcpu, (((instr_info) >> 3) & 0xf));
+	if (vmx_get_instr_info_is_reg(instr_info))
+		value = kvm_register_read(vcpu, vmx_get_instr_info_reg(instr_info));
 	else {
 		len = is_64_bit_mode(vcpu) ? 8 : 4;
 		if (get_vmx_mem_address(vcpu, exit_qualification,
@@ -5791,7 +5791,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, r, &e);
 	}
 
-	field = kvm_register_read(vcpu, (((instr_info) >> 28) & 0xf));
+	field = kvm_register_read(vcpu, vmx_get_instr_info_reg2(instr_info));
 
 	offset = get_vmcs12_field_offset(field);
 	if (offset < 0)
@@ -5978,7 +5978,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long type, roots_to_free;
-	u64 vmx_instruction_info;
+	u64 instr_info;
 	struct kvm_mmu *mmu;
 	gva_t gva;
 	struct x86_exception e;
@@ -5998,8 +5998,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
@@ -6011,7 +6011,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6058,8 +6058,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 static int handle_invvpid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 vmx_instruction_info;
 	unsigned long type, types;
+	u64 instr_info;
 	gva_t gva;
 	struct x86_exception e;
 	struct {
@@ -6079,8 +6079,8 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	vmx_instruction_info = vmx_get_instr_info();
-	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	instr_info = vmx_get_instr_info();
+	gpr_index = vmx_get_instr_info_reg2(instr_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.vpid_caps &
@@ -6094,7 +6094,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
 	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
-			vmx_instruction_info, false, sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
 	if (r != X86EMUL_CONTINUE)
@@ -6424,16 +6424,16 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
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
index 5d95f8138628..e6d77508dede 100644
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
 	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
-				vmx_instruction_info, false,
-				sizeof(operand), &gva))
+				instr_info, false, sizeof(operand), &gva))
 		return 1;
 
 	return kvm_handle_invpcid(vcpu, type, gva);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index cda6e9707686..205d5719034d 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -684,14 +684,54 @@ static inline u64 vmx_get_instr_info(void)
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

