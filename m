Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423F33B6F8;
	Tue, 12 May 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550033; cv=none; b=D/4V7ds17qGTHilEv21Whaz5sOhRjpincpLHhDmk9E7BoxNqvmULBYxlOdmlGQ0S3j1dZ9vVnwhZKscsPMTBwfQQynGdBpbYR30celr+7+5AlDBxzVnjITmqoQWW+voKPnJSGsh2KGYStROVoLGpath9OgF1tLcLk6rs3neUv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550033; c=relaxed/simple;
	bh=R/ysa1ksHpyGhjHiGcrnNVZs9H+0ooHMCBcBXdycmTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3Q/Rg658130WZMNczDeGQn7cVy1VedJpwd+CfX00gLKtQrtyaOzctY2z8reZD41dwP+ykf4+QusVMa+7K0fbpwHfy9+Vr306eEyKDM1W3Qsea9YqR90kN7mgw9ZLaA5QxjBW9MenYIRBWP5BQD8KQaIIbP39ul+danUNM/drFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFDQsfNz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFDQsfNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550029; x=1810086029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/ysa1ksHpyGhjHiGcrnNVZs9H+0ooHMCBcBXdycmTI=;
  b=lFDQsfNzkHKwVqS7CChz8wiWwOW66JUKvZRHQt0bJe6KkThAiNJXmA3h
   1AIw57/PXKlmc7km/sym9RQ9200xuEpF9GRxIojwtPLaGPy3XG1YuFEWh
   SBqmlV3mJR5b1GXXowI2S/ko2hDxjI5ScGlnVLSWPtytKVbhtCzB21zjZ
   cjMn+BzDA+FjQ7j2+b19VH5oJiXCBftnSMU6S84n7vLPGCE050dVo/wK1
   wnkAkQ6CBh9fEPDVWPcWXysWHH8eqmgAFXzOqlTObg82fBew52MWXzQ9b
   efigafCKPY/qL3xhsAKZVc9XxlnkNbWaQXWbcQ6R4ZuaWWfY6uuidnp/A
   Q==;
X-CSE-ConnectionGUID: ZAirv9zMQGWCrbwAlT8WsQ==
X-CSE-MsgGUID: owx2wGIqSZWzgEN5N2p/vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322152"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:27 -0700
X-CSE-ConnectionGUID: CM8l0GX6STmRSE0kL3AEbg==
X-CSE-MsgGUID: 3M4Q4LetTQ271eNGKAkucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572794"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:26 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 11/21] KVM: VMX: Support instruction information extension
Date: Tue, 12 May 2026 01:14:52 +0000
Message-ID: <20260512011502.53072-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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
However, software must not assume that previously reserved bits were zero
on older implementations.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/7bb14722-c036-4835-8ed9-046b4e67909e@redhat.com
Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/vmx/vmx.h     | 42 +++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ed2ded531e55..d4f23e581b84 100644
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
index f71ae8d2c338..88c540b7f087 100644
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
 static inline int vmx_get_exit_qual_reg(struct kvm_vcpu *vcpu)
 {
-	return (vmx_get_exit_qual(vcpu) >> 8) & 0xf;
+	return (vmx_get_exit_qual(vcpu) >> 8) & (vmx_instr_info_extended() ? 0x1f : 0xf);
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
2.51.0

