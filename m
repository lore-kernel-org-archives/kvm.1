Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940327;
	b=o1xe4Dvd6+Bo58bS1T86EB8w/DxFzHmWyYGuiaaVgJ0jKXG7mBbDEpfbXGyixGGqrzBo
	 U4TZu4n2DPAb14jLfctMVpi1y49UGb9NKtOe4jIHJmitH1ZfPt2NuuR7kxzBBD5CHTEIx
	 mhYNQ0A6Ml5RKGDx5mhdM7qIl9pBwW3EKJHHLSYhHY+6DlZAkPMP4ozsdhu0txxp1o1IX
	 wrrrODaPQaFwNLgG2oxZ4eZ1lv5vCZfap6iePE05r7MK7F/4r/R9kpzKXCekxjA4bhPhP
	 ApVwCscXoeocwzWHCJtVL4TY2kJlR/+xYuOe+Z/bb0RNfBD4wkidFsq0Ff0MjTgOkkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940327;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LsAFZWixu/i6F5Q2jePYBu4j/cOAO8juBaG3yrrHd4M=;
	b=x6l7EUL5sLaznU7QBFAWdiPcQblasInIjFY92bzYxU+VhkfaM3CgFlJASJXXxN6gMjwY
	 KnJScGyjp2z5NUQPJUefQMSuznKheuw3ByDbNlqss5dP1zxQ38t0406a3yFq5MrUIs9We
	 QVhngvY7a+K8mo4A3DNZ/unnM+NdxybClrAIQ69JS35S7WeVxO/TS5I5VyiJXnboEx1q5
	 FeGE8eWOANAoQnd6RnnrPu5WArGHA1X25gbrWjEe/kf7DWjEesbRWMzfUaL0Wvu9xeCsr
	 glxAJ9eIOwX0eLbSesL+4SqcPKpgNUERGuHx98XoVzSDjFPr5KDgBtEPSMQUl1sCNAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwLW2Yx9;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF160A5BDC;
	Tue, 17 Nov 2026 18:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78AF160A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwLW2Yx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940327; x=1826476327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hBLNbtqo3eFzAlUJoGD3jhCy/0SJMF9AzVWVOHE4fM=;
  b=gwLW2Yx9qJY/77OXtvzNNca4R9LESKCck+29gtbTYP7ZsOPJtD5o4PFJ
   mheQRd0JdlTTnBiFjEILZFJjrfT61ZbF5mZfgBN7z9UiAs2xtSTKWWXqL
   X8IEj2YyJCGDLqV7QlrqmU1xaF3iDm1IJRXGQzpJtI77/rHhGDcA8YvEE
   +s2tDBylem06dO8G3JX4nu5RLLVovdstdKqCCk5sla+KI/ujWrKNqZw1p
   OcZ5a62B0s/TbeOpfNn/kHDb7TdUTm5EI4uLI+BEurhzU4ZwDtUEvzSX9
   3Am1/z4UReImHxNzxqVsNzTIuU74cwzG6wRliUwSO9ZK8qX4pYwrjtWBt
   Q==;
X-CSE-ConnectionGUID: sCYsI+ijSH2badde/PYbcQ==
X-CSE-MsgGUID: lHgcJZSXQ4KHE4qSextQ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607293"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607293"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:52 -0800
X-CSE-ConnectionGUID: dKdrqG3DQ8W6tMT3hC2gQg==
X-CSE-MsgGUID: laU9FW+jS/yalU4mIYnm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775052"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:53 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 09/20] KVM: VMX: Support instruction information extension
Date: Tue, 17 Nov 2026 18:02:59 +0000
Message-ID: <20261117180310.921701-10-chang.seok.bae@intel.com>
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

Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.

Although the APX CPUID enumeration indicates that the extension is
available, hide it when using eVMCS, as eVMCS support is not ready yet.

For safety, do not assume that previously reserved bits were zero
on older implementations.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
---
V8 -> V9:
 * Guard not to break with eVMCS (Jim Mattson) [*]
 * Rebased on 7.4-rc1; Move vmx_instr_info_extended() to vmx_ops.h

[*] Note I ended up placing `kvm_cpu_cap_clear(APX) if eVMCS` in patch18
    along with all other kvm_cpu_cap_clear(APX) sites there.
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/vmx/common.h  |  2 +-
 arch/x86/kvm/vmx/vmx.h     | 31 ++++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx_ops.h |  9 +++++++++
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3c5019da4b71..68e86f2bf5a1 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -285,6 +285,8 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	EXTENDED_INSTRUCTION_INFO       = 0x00002406,
+	EXTENDED_INSTRUCTION_INFO_HIGH  = 0x00002407,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 30b0aa9560d5..6c26951edc68 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -112,7 +112,7 @@ static __always_inline unsigned long vt_get_exit_qual(struct kvm_vcpu *vcpu)
 
 static __always_inline int vt_get_exit_qual_reg(unsigned long exit_qualification)
 {
-	return (exit_qualification >> 8) & 0xf;
+	return (exit_qualification >> 8) & (vmx_instr_info_extended() ? 0x1f : 0xf);
 }
 
 static __always_inline u32 vt_get_intr_info(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 205d5719034d..01629de4aff3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -678,20 +678,22 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
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
@@ -701,37 +703,44 @@ static inline int vmx_get_instr_info_scaling(u64 instr_info)
 
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
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9ffe03a0c223..8ccf3549f078 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -365,4 +365,13 @@ static inline void ept_sync_context(u64 eptp)
 		ept_sync_global();
 }
 
+/*
+ * The APX enumeration guarantees the presence of the extended fields. The host
+ * CPUID bit alone is sufficient to rely on it. eVMCS does not support them yet.
+ */
+static inline bool vmx_instr_info_extended(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_APX) && !kvm_is_using_evmcs();
+}
+
 #endif /* __KVM_X86_VMX_INSN_H */
-- 
2.53.0

