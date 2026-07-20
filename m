Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF544D020;
	Mon, 20 Jul 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569587; cv=none; b=jJrPP5Kf+Rbg/6fyGU7bsTOPvobnPYn6he9Z57po+uKeJbHJP4E/LtiluarMBcCBjUkYOuHkelmj/bZ3m5EMOnmzIA8tAoRBIgxuPeaOhSazEfeaCCLtSIWOxLfSMoLVW6d7aM0ZJFHl6mOPqb0XVHmUzYvOGlcgmi85t1CcNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569587; c=relaxed/simple;
	bh=ngASC3yIZlP9NAPrPDwQbSk5sSArSJVG0BhmmCPskzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKURcPAgVP/zTio3MHx9HHe7FgknF4UYnp5/w9pu6txWpfOp+RLcwglejEktCcCnF5VT8zgGrgfYQ7ye9aAieRaKSx0O/tywZf3SDqBj2DF57oJ55+vrIkqRiitl8QfMk/gXTeQGgcdfYHrU5txjmNN42P+haPcrdmt+OO2rWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do29aq3h; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do29aq3h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569581; x=1816105581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ngASC3yIZlP9NAPrPDwQbSk5sSArSJVG0BhmmCPskzo=;
  b=do29aq3hMljttXyoQJ33FPKrBw47Kj6+bT7thDrZbJMinYqxbxzP1mkm
   ghjVugNejOoWMBSaMnbvJzG1bezo+lLj4tdLdSJ1WqdGZBXNFovARSYKh
   jAyDAqqTlJFEDJyQ+Gg6zWnZo0DdWDzgxZItlsXdw52cCKqStn6y1aAHu
   T3w23MyTTjhV+MFQpw2WpBSHqdFNl9k6UUOR8O/ea2CW0AIb7/y02Wn1s
   HasRIGfHW//a+0TkXj7VSE3vMqKA1aSp4PqhJ2hae97eIGmCI50Zxp1Tv
   2zgnMLGxgN3nlTHgKoYnCnBQymhP0YyrXXKZQhOdP4WLLlNO5EdOZ7U2c
   g==;
X-CSE-ConnectionGUID: kTN+3ABWQlu398y3CGiFgA==
X-CSE-MsgGUID: 1KMC6gPrTFGj1FNVflhdRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691666"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:04 -0700
X-CSE-ConnectionGUID: lCKTapOBQ5+ztGcND2scTw==
X-CSE-MsgGUID: 604wR9mYQSiWA6jO3d+rQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575360"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:03 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 08/20] KVM: VMX: Support instruction information extension
Date: Mon, 20 Jul 2026 17:19:37 +0000
Message-ID: <20260720171949.498680-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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

