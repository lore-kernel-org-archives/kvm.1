Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7303537D7;
	Tue, 28 Apr 2026 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353992; cv=none; b=XYBc++U5DInpJ27aj2ny26coLMUvO3dCVYYFCnfPJiDrmMv/akZLuQm2qhilHM3KJAYSCdAvXLt46vb7LtXctH2W5URnpv6luj+d8tBJMLlBScpxsPAa3uEdUERHYz3u2oZxA1ndIQ7U/wSlLz8wQWV/JXGfECXX/i2D4cs0NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353992; c=relaxed/simple;
	bh=hQCgFAkamahPjjtNaA5tZLTg9LirOjTb9FpS9s9GIm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4XYboQR95ZRCe7RKzEDvhA0b/H/6rxEbFOOqvwmGyCDlevxkV2fHMJFA8GRAJe0Vwn3q0Nn4Qgx2nbHW+eTHl6iZnA0h8wusNitdMGkObMCfhmjQmQWUGwA8rZnjsxNpnEvApeX3NUyKuR6faCFFqjqNpkJ1I2M2JfQbiO3IoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmQDq5gT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmQDq5gT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353987; x=1808889987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQCgFAkamahPjjtNaA5tZLTg9LirOjTb9FpS9s9GIm0=;
  b=QmQDq5gTsG8cI6WAol+jLeiZTj38TZSMI6KiUaU4eAPT0pvTV7EblLOO
   GfyoWJ9fzldVhghCjWSnFCzGzqwKobuJd0+H4o6mrQf3LeWlzKyeLh+7e
   057ATdFzfwWEto3RNkp58pCEVjMduKx+mDSyCbj8yklEe0wnCTbQof7SB
   J4+kg1bEvsFhvy70z7x4I362E4JsgkMCSZxcimibiQlt6/I73d8EZ9rUw
   huhPM0dQ+HerPUmIPQGvA3rOQMDL01mFApAYF8hRNfTcT9fknIFNhUofi
   leYSyzu1SbA8skJazIWtqZ7QIGyCuERsHD44sbM9LQstth3ofF4w2YZjT
   g==;
X-CSE-ConnectionGUID: uSex0HIuRQCcwcPzGRT0EQ==
X-CSE-MsgGUID: XzgqPVpjQhefDVMAcTVPtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131714"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131714"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:26 -0700
X-CSE-ConnectionGUID: 53t/uG3qSbmjl9Dh79sq8g==
X-CSE-MsgGUID: Sl+74EOBQgGH0ygNO5eaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130201"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:26 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 10/20] KVM: VMX: Support instruction information extension
Date: Tue, 28 Apr 2026 05:01:01 +0000
Message-ID: <20260428050111.39323-11-chang.seok.bae@intel.com>
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

Define the VMCS field offset for the extended instruction information.
Then, support 5-bit register indices retrieval from VMCS fields.

Note the APX enumeration alone indicates the extension is available.
However, software must not assume that previously reserved bits were zero
on older implementations.

Link: https://lore.kernel.org/7bb14722-c036-4835-8ed9-046b4e67909e@redhat.com
Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Drop the data structure that matches with the field format (Sean)
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/vmx/vmx.h     | 42 +++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 37080382df54..978cd6ac6483 100644
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
index 4d29d32fa87c..862a9cb4f653 100644
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
@@ -706,20 +715,22 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
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
@@ -729,37 +740,44 @@ static inline int vmx_get_instr_info_scaling(u64 instr_info)
 
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

