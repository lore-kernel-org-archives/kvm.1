Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B42524B0A;
	Wed, 30 Sep 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804105; cv=none; b=P1FjL2QgMystOkEK2gRRXwAenDwN+lcwOtz7Rvl584NlwNjgK+2erv1EYWu7yTTd5UngUNd7loLIE5ucKbust7dHoOCqzJ+Qq35Yn/3c9l0HTJS30eU23RfkD/x/6wjZnk5uqXbHT/boU96dx+q7/2ePyPOz4byX15FTItJIDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804105; c=relaxed/simple;
	bh=wDvPITuOMyuQ7JDYaPIcf9pEG+MZAvSvoJPeOq8qAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnHLqke8o/uy5Fm2U3+VVm2jL3jazSej51ivtnf0BhWuV/hC5VAndhWN5NqwuM2K8Kr8c/KAiBOqLCb7cVUtwSClMTAoszdYznSffDc+m6bQssr7Z4KMZTnygIl+jRCKJXlo07R3m2FC4ihpjI4MrHG9q1cD/irbESMbSmhXmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLmvZbMZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLmvZbMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804104; x=1822340104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDvPITuOMyuQ7JDYaPIcf9pEG+MZAvSvoJPeOq8qAHo=;
  b=gLmvZbMZCsb3SDxiPoVeRoRfepdsRUGF7iA20qs+DwZCBYSgYXSaRVvC
   bzWnFkKkE2Zcj1l07AM/4Yjfeisyp+Jr4Yv4lg/myrYEmy0kRFmgBTysJ
   9tyzMQQ+S4O4XARll8baK773WkNJEE80ZHEnuieKz7cIcQ1OcGzLeeWZY
   xqRTTbBdivo8+ZVP2QtkAA2b/B7LJK7/QG4clkDjBVj5ecTVNNB9mrzYC
   XHX/4igid2SiD5chdBxI0xvg193L9+KPJK1NI1l3D5JufPLQgQ6ZK58xu
   uLhtq6A8674vIJuB3vnczxAG4iXw8kV8/wPWj77XRm3pkiWpW8dip0Hn9
   A==;
X-CSE-ConnectionGUID: QkH8U4usSN6QArVZ3ToFFQ==
X-CSE-MsgGUID: C+DWW61xTCay+qFHRr/T5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432689"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432689"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:03 -0700
X-CSE-ConnectionGUID: o5LgxlLyQGuoxEHiwyamQw==
X-CSE-MsgGUID: Zb4eYbM5R1SC/MocHZl6Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867283"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:03 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 08/20] KVM: VMX: Support instruction information extension
Date: Wed, 30 Sep 2026 21:07:38 +0000
Message-ID: <20260930210750.1487547-9-chang.seok.bae@intel.com>
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

Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.

Note the APX enumeration alone indicates the extension is available.
For safety, do not assume that previously reserved bits were zero
on older implementations.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
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
index f98e40df5004..0b1e2353db3b 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -277,6 +277,8 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	EXTENDED_INSTRUCTION_INFO       = 0x00002406,
+	EXTENDED_INSTRUCTION_INFO_HIGH  = 0x00002407,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 863b08478544..4a76af613720 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -330,9 +330,18 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
+/*
+ * The APX enumeration guarantees the presence of the extended fields.
+ * The host CPUID bit alone is sufficient to rely on it.
+ */
+static inline bool vmx_instr_info_extended(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_APX);
+}
+
 static inline int vmx_get_exit_qual_reg(unsigned long exit_qualification)
 {
-	return (exit_qualification >> 8) & 0xf;
+	return (exit_qualification >> 8) & (vmx_instr_info_extended() ? 0x1f : 0xf);
 }
 
 static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
@@ -714,20 +723,22 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
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
@@ -737,37 +748,44 @@ static inline int vmx_get_instr_info_scaling(u64 instr_info)
 
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

