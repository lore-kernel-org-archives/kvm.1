Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D4568FD0;
	Thu, 15 Oct 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095726; cv=none; b=Jl9qWwxRRlc2J9c6al71RX5qN0eslRCu0izH6ysA4qaoNKGmav3//mbIfHCfTlaHBw7bHc9Mn9jb7XbYajWPjqQiSB38MBeL4xc9codNrrXC4HceSIe+Vekj9m+Aq+y+f3yZAMazYovCJ/KkWJ6DHEyiKI2YMO8lMAR4Oe8k+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095726; c=relaxed/simple;
	bh=eNdj0uX51MbU2L3x9jNeMs6RwuRvHajgZdoHIqaod80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unNAsZzMErv3ZexVEvWAqtCATrHZJVgEef1xqDrk5Kn2rTquce9SUiy/usnCY29fVNPCIa/guyomh/z8F7FRfGsE03qcrEP0M6AHlr+oUypCxzvLF5Afyi3UeUEWF9hcgX6np9H7sCkKwTNWe9vhLK682gPqhbFMrzSYUCK39Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jU6LdA9X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jU6LdA9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095724; x=1823631724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eNdj0uX51MbU2L3x9jNeMs6RwuRvHajgZdoHIqaod80=;
  b=jU6LdA9XXbMtPE3cNH6WTRJFJO0SpvjqW5jYIspWQIX916cKso9oG3Ki
   3Iak+Sw+heQgqrziKaRClKo8zVxH4erLeUHSfB7xC5O/ebapLIzujYbxE
   WFeH2eEacIs1KE/yYouCI9mSadhBpyY9yKaHVOE2vqUdk7eort2buJ5Iv
   S6poB8+kXM6MeJKnfpLZl8HJgHaNgSIydHMsoGfcvBsu+dQsPc4nDlQRw
   fGbP85DTb2KepToY641N6VJP8Gq3zOC7SzHclbUMZ+aeWP5umu/G6+Le0
   EJKCRL4oQNZJJszqdyHrtQJjMk1b3kU/JE1k4LQZmd+vVoDJwSpl76tiz
   Q==;
X-CSE-ConnectionGUID: UmFHVc7dSn2Ne80wMjkMMQ==
X-CSE-MsgGUID: +ceUYm7/SEevwSPHIMYC6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911116"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911116"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:22:00 -0700
X-CSE-ConnectionGUID: dUvUQLmGSNuSDKmo35DXJQ==
X-CSE-MsgGUID: bipvbnenT6uGLVA+JBvrAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844441"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:59 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 4/6] KVM: VMX: Implement LASS violation check
Date: Thu, 15 Oct 2026 13:19:38 -0700
Message-ID: <20261015201940.1655956-5-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015201940.1655956-1-sohil.mehta@intel.com>
References: <20261015201940.1655956-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Guang <guang.zeng@intel.com>

Add a VMX implementation of the is_lass_violation() hook to let KVM
detect Linear Address Space Separation (LASS) violations on linear
addresses generated during emulation. LASS uses bit 63 of the linear
address to determine which half of the address space is being targeted,
and reports a violation when that half doesn't match the current
privilege level.

Note, LASS takes effect only in IA-32e mode; it is ignored in legacy
mode. LASS enforcement for supervisor-mode data accesses additionally
requires SMAP to be enabled, and is suppressed for explicit accesses
when RFLAGS.AC=1.

Enforce LASS violations on emulated instruction fetches and data
accesses, including implicit supervisor accesses, so that the mode-based
protections are applied before paging. Also enforce LASS on the linear
addresses consumed by emulated VMX and SGX ENCLS instructions.

Linear addresses used for TLB invalidation (INVLPG, INVPCID, and
INVVPID) and branch targets are not subject to LASS enforcement.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
---
v5:
 - Added a function comment describing the basic flow
 - Replaced Binbin's SoB with a Reviewed-by
 - Picked up review and test tags

v4:
 - Switch to using gva_t for the address argument
 - Split patch diff and reworded the commit message

Note, Sashiko flagged a missing CR4.SMEP check for supervisor fetches
and suggested is_64_bit_mode() instead of is_long_mode(). Both are false
positives. LASS enforces the equivalent of SMEP regardless of CR4.SMEP,
and it applies throughout IA-32e mode, including compatibility mode.
---
 arch/x86/kvm/vmx/main.c   |  1 +
 arch/x86/kvm/vmx/nested.c | 11 ++++---
 arch/x86/kvm/vmx/sgx.c    |  3 +-
 arch/x86/kvm/vmx/vmx.c    | 64 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h    |  3 ++
 arch/x86/kvm/x86.c        |  2 +-
 6 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..0696ba3b77fe 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1144,6 +1144,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
 
 	.get_untagged_addr = vmx_get_untagged_addr,
+	.is_lass_violation = vmx_is_lass_violation,
 
 	.mem_enc_ioctl = vt_op_tdx_only(mem_enc_ioctl),
 	.vcpu_mem_enc_ioctl = vt_op_tdx_only(vcpu_mem_enc_ioctl),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..1794f25e0724 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5309,11 +5309,12 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 			*ret = off;
 
 		*ret = vmx_get_untagged_addr(vcpu, *ret, 0);
-		/* Long mode: #GP(0)/#SS(0) if the memory address is in a
-		 * non-canonical form. This is the only check on the memory
-		 * destination for long mode!
+		/*
+		 * Long mode: #GP(0)/#SS(0) if the memory address is in a
+		 * non-canonical form, or if the access violates LASS.
 		 */
-		exn = is_noncanonical_address(*ret, vcpu, 0);
+		exn = is_noncanonical_address(*ret, vcpu, 0) ||
+		      vmx_is_lass_violation(vcpu, *ret, len, 0);
 	} else {
 		/*
 		 * When not in long mode, the virtual/linear address is
@@ -6128,7 +6129,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	if (type != VMX_VPID_EXTENT_ALL_CONTEXT && !operand.vpid)
 		return nested_vmx_fail(vcpu, VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 
-	/* LAM doesn't apply to addresses that are inputs to TLB invalidation. */
+	/* LAM and LASS don't apply to addresses that are inputs to TLB invalidation. */
 	if (type == VMX_VPID_EXTENT_INDIVIDUAL_ADDR &&
 	    is_noncanonical_invlpg_address(operand.gla, vcpu))
 		return nested_vmx_fail(vcpu, VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 771c75a58343..4ac305ed6dea 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -39,7 +39,8 @@ static int sgx_get_encls_gva(struct kvm_vcpu *vcpu, unsigned long offset,
 		fault = true;
 	} else if (likely(is_64_bit_mode(vcpu))) {
 		*gva = vmx_get_untagged_addr(vcpu, *gva, 0);
-		fault = is_noncanonical_address(*gva, vcpu, 0);
+		fault = is_noncanonical_address(*gva, vcpu, 0) ||
+			vmx_is_lass_violation(vcpu, *gva, size, 0);
 	} else {
 		*gva &= 0xffffffff;
 		fault = (s.unusable) ||
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 04a9acf4a39a..6245de123ec3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8469,6 +8469,70 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
 	return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_ULL(63));
 }
 
+/*
+ * Check if an access violates LASS purely based on bit 63 of the linear
+ * address and whether the access targets the "wrong" half of the address
+ * space. The basic flow is straightforward:
+ *
+ *      if (exempt from LASS)
+ *              no violation;
+ *      else if (user access)
+ *              violation when address is in the supervisor half;
+ *      else
+ *              violation when address is in the user half;
+ *
+ * but the actual behavior is far more subtle due to the many exceptions and
+ * edge cases. For example, the implementation depends on which accesses are
+ * exempt, what constitutes a user access, and how supervisor data accesses
+ * differ from instruction fetches.
+ */
+bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
+			   unsigned int size, unsigned int flags)
+{
+	const bool is_supervisor_address = !!(gva & BIT_ULL(63));
+	const bool implicit_supervisor = !!(flags & X86EMUL_F_IMPLICIT);
+	const bool fetch = !!(flags & X86EMUL_F_FETCH);
+
+	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_LASS) || !is_long_mode(vcpu))
+		return false;
+
+	/*
+	 * INVLPG isn't subject to LASS, e.g. to allow invalidating userspace
+	 * addresses without toggling RFLAGS.AC.  Branch targets aren't
+	 * subject to LASS in order to simplify far control transfers (the
+	 * subsequent fetch will enforce LASS as appropriate).
+	 */
+	if (flags & (X86EMUL_F_BRANCH | X86EMUL_F_INVLPG))
+		return false;
+
+	if (!implicit_supervisor && vmx_get_cpl(vcpu) == 3)
+		return is_supervisor_address;
+
+	/*
+	 * LASS enforcement for supervisor-mode data accesses depends on SMAP
+	 * being enabled, and like SMAP ignores explicit accesses if RFLAGS.AC=1.
+	 */
+	if (!fetch) {
+		if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP))
+			return false;
+
+		if (!implicit_supervisor && (kvm_get_rflags(vcpu) & X86_EFLAGS_AC))
+			return false;
+	}
+
+	/*
+	 * The entire access must be in the appropriate address space.  Note,
+	 * if LAM is supported, @gva has already been untagged, so barring a
+	 * massive architecture change to expand the canonical address range,
+	 * it's impossible for a user access to straddle user and supervisor
+	 * address spaces.
+	 */
+	if (size && !((gva + size - 1) & BIT_ULL(63)))
+		return true;
+
+	return !is_supervisor_address;
+}
+
 static unsigned int vmx_handle_intel_pt_intr(void)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6c9dd5b2365d..48ae3b213f97 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -353,6 +353,9 @@ u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
 
 gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 
+bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
+			   unsigned int size, unsigned int flags);
+
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable);
 
 u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bd69934cafd3..ba94ade695fc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10857,7 +10857,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 	switch (type) {
 	case INVPCID_TYPE_INDIV_ADDR:
 		/*
-		 * LAM doesn't apply to addresses that are inputs to TLB
+		 * LAM and LASS don't apply to addresses that are inputs to TLB
 		 * invalidation.
 		 */
 		if ((!pcid_enabled && (operand.pcid != 0)) ||
-- 
2.43.0

