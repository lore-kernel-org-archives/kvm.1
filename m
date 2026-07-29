Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1C3B42ED;
	Wed, 29 Jul 2026 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354221; cv=none; b=fmL59pAR2JVq31k5ztAvNeWWqtx/SVh8dxUSTfPWiv71X+lh5h02UMV9IgsORKVJ260kVILFpElhWBrX3s9o0D8lRM26UIJRWIDDmlWiqLIRS8y4410ZfYqmk4Fu3Nrnq8E8q1h/9AvkO88/8R2H5j3tVdGZ0v+Nt4peMWekETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354221; c=relaxed/simple;
	bh=ngASC3yIZlP9NAPrPDwQbSk5sSArSJVG0BhmmCPskzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9MiMTOn9dOlBTPNBdfhheon5GWbcDCn1Rff79BM4VzG7s9KnH3jLSrWBeY/8q95bzb66AT6UBVIT3U/81MlzZGJyMGfi3TKHQcLKL+exRRAIWx6mZ21i45QJlyYDF3Y9KmYlnWAL2bwr3ftY1WsYTb8f8bUWR0PqAC8tjUIY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUiCQGuw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUiCQGuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354216; x=1816890216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngASC3yIZlP9NAPrPDwQbSk5sSArSJVG0BhmmCPskzo=;
  b=YUiCQGuw/AW+s0DeMue+Ye6LWOqOL7bz20GaYaJLfRyET4qbuWekQoI5
   itnWYa69Adf7nNegDTpJZbIxuEb48xcrP1Yr8VBsPT7FN1G+iIepCWShy
   E9fKdab1/LKVs/cCNkR3APia4/03xAKAJ8m68NSKYTC/beJWsvx6VrZgs
   J7hyyU6+g7/a3LGBsNJ4W5R91uF54sds4YFVQ90HNLWgOAivYTRC41K9O
   L9qdKp8+G8Xosy3DD2lqtBXIXBuVrU7lFP+w3cRQ5IOy0keDP8lKHruQX
   0k8uDNt0In7pFJdAP1PPD9QlrKgv0eTRF4ki9dtFxp2Mcsp/XRzerQYGP
   w==;
X-CSE-ConnectionGUID: NXJeTS9kRUaYw/kamw+vzg==
X-CSE-MsgGUID: 560kc1ZnTpm1zJ9YNBYR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508272"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:24 -0700
X-CSE-ConnectionGUID: y3ytg+TRSr+baXCorOpzEg==
X-CSE-MsgGUID: bqEKLQHQRhmPMqrTRzyUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769243"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:24 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 08/20] KVM: VMX: Support instruction information extension
Date: Wed, 29 Jul 2026 19:16:44 +0000
Message-ID: <20260729191656.598771-9-chang.seok.bae@intel.com>
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

Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.

Note the APX enumeration alone indicates the extension is available.
For safety, do not assume that previously reserved bits were zero
on older implementations.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
---
Note for the review of extensions in following functions:
+-------+------------------+------------------------------------+
| Bits  | Field Name       | Related KVM Functions              |
+=======+==================+====================================+
| 3:2   | ASIZE            | vmx_get_instr_info_addr_size()     |
+-------+------------------+------------------------------------+
| 4     | Mem/Reg (1=>reg) | vmx_get_instr_info_is_reg()        |
+-------+------------------+------------------------------------+
| 9:7   | Segment          | vmx_get_instr_info_seg_reg()       |
+-------+------------------+------------------------------------+
| 10    | IndexInvalid     | vmx_get_instr_info_base_reg()      |
+-------+------------------+------------------------------------+
| 11    | BaseInvalid      | vmx_get_instr_info_base_is_valid() |
+-------+------------------+------------------------------------+
| 20:16 | Reg1             | vmx_get_instr_info_reg()           |
+-------+------------------+------------------------------------+
| 28:24 | Index            | vmx_get_instr_info_index_reg()     |
+-------+------------------+------------------------------------+
| 36:32 | Base             | vmx_get_instr_info_base_reg()      |
+-------+------------------+------------------------------------+
| 44:40 | Reg2             | vmx_get_instr_info_reg2()          |
+-------+------------------+------------------------------------+

Reference:
  APX Specification, Table 3.11 Extended Instruction-Information (EII)
  VMCS Field
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/vmx/vmx.h     | 42 +++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 5645a84f4fbc..2334f52071f9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -276,6 +276,8 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	EXTENDED_INSTRUCTION_INFO       = 0x00002406,
+	EXTENDED_INSTRUCTION_INFO_HIGH  = 0x00002407,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f3b0ec7ccb03..2f53338f84f0 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -323,9 +323,18 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
+/*
+ * The APX enumeration guarantees the presence of the extended fields.
+ * The host CPUID bit alone is sufficient to rely on it.
+ */
+static inline bool vmx_instr_info_extended(void)
+{
+	return static_cpu_has(X86_FEATURE_APX);
+}
+
 static inline int vmx_get_exit_qual_reg(unsigned long exit_qualification)
 {
-	return (exit_qualification >> 8) & 0xf;
+	return (exit_qualification >> 8) & (vmx_instr_info_extended() ? 0x1f : 0xf);
 }
 
 static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
@@ -707,20 +716,22 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
 void dump_vmcs(struct kvm_vcpu *vcpu);
 
-/* A placeholder to smoothen 64-bit extension */
 static inline u64 vmx_get_instr_info(void)
 {
-	return vmcs_read32(VMX_INSTRUCTION_INFO);
+	return vmx_instr_info_extended() ? vmcs_read64(EXTENDED_INSTRUCTION_INFO) :
+					   vmcs_read32(VMX_INSTRUCTION_INFO);
 }
 
 static inline int vmx_get_instr_info_reg(u64 instr_info)
 {
-	return (instr_info >> 3) & 0xf;
+	return vmx_instr_info_extended() ? (instr_info >> 16) & 0x1f :
+					   (instr_info >> 3) & 0xf;
 }
 
 static inline int vmx_get_instr_info_reg2(u64 instr_info)
 {
-	return (instr_info >> 28) & 0xf;
+	return vmx_instr_info_extended() ? (instr_info >> 40) & 0x1f :
+					   (instr_info >> 28) & 0xf;
 }
 
 static inline int vmx_get_instr_info_scaling(u64 instr_info)
@@ -730,37 +741,44 @@ static inline int vmx_get_instr_info_scaling(u64 instr_info)
 
 static inline int vmx_get_instr_info_addr_size(u64 instr_info)
 {
-	return (instr_info >> 7) & 7;
+	return vmx_instr_info_extended() ? (instr_info >> 2) & 3 :
+					   (instr_info >> 7) & 7;
 }
 
 static inline bool vmx_get_instr_info_is_reg(u64 instr_info)
 {
-	return !!(instr_info & BIT(10));
+	return vmx_instr_info_extended() ? !!(instr_info & BIT(4)) :
+					   !!(instr_info & BIT(10));
 }
 
 static inline int vmx_get_instr_info_seg_reg(u64 instr_info)
 {
-	return (instr_info >> 15) & 7;
+	return vmx_instr_info_extended() ? (instr_info >> 7) & 7 :
+					   (instr_info >> 15) & 7;
 }
 
 static inline int vmx_get_instr_info_index_reg(u64 instr_info)
 {
-	return (instr_info >> 18) & 0xf;
+	return vmx_instr_info_extended() ? (instr_info >> 24) & 0x1f :
+					   (instr_info >> 18) & 0xf;
 }
 
 static inline bool vmx_get_instr_info_index_is_valid(u64 instr_info)
 {
-	return !(instr_info & BIT(22));
+	return vmx_instr_info_extended() ? !(instr_info & BIT(10)) :
+					   !(instr_info & BIT(22));
 }
 
 static inline int vmx_get_instr_info_base_reg(u64 instr_info)
 {
-	return (instr_info >> 23) & 0xf;
+	return vmx_instr_info_extended() ? (instr_info >> 32) & 0x1f :
+					   (instr_info >> 23) & 0xf;
 }
 
 static inline bool vmx_get_instr_info_base_is_valid(u64 instr_info)
 {
-	return !(instr_info & BIT(27));
+	return vmx_instr_info_extended() ? !(instr_info & BIT(11)) :
+					   !(instr_info & BIT(27));
 }
 
 static inline bool vmx_can_use_ipiv(struct kvm_vcpu *vcpu)
-- 
2.53.0

