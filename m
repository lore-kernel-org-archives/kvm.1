Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF3ACF17;
	Thu,  6 Aug 2026 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979128; cv=none; b=MI4QF+OJzHCwR9PkvubyXTpXsdwC9M2N9MCmwUaZa/Y6e6DlG9HZFOpLNUYTdj7wLrfm/wvU3dDUllCV63cOcopwXHySG84ShmOaq0PdjCOjeyA6VBZSwo96Mtwy3lrHkFuWYu2mH0lOKInNU5fyxEIYTUyqnjFIlLJEuG8Kr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979128; c=relaxed/simple;
	bh=4o9xDC7SR3KpJwNEh2CBq2GIjuP6VSzx+X5j5D6K6yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENXBYHTCoAc9Ey9KLR3re2kFBgmgPm54OGxAWaaW8Gth6c2fcGfmsOawFPXcCfxASGNa7J4pGGTnrfIDplOxLHphqb5+o7oL9NXnMSY8db9J0kx8BF+9RYjbstAnH3mDCLtFkw8pNoHHbri3YhaeV2I2ilK6A8UTxmF9jFrJ7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN/jrht7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN/jrht7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979126; x=1817515126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4o9xDC7SR3KpJwNEh2CBq2GIjuP6VSzx+X5j5D6K6yg=;
  b=AN/jrht77tQRkp7WF/3Tvc9EPFJNkrTHwik8fxIc35p4dnzA2uNgi52n
   XyeMitcFoRIUCJJieSoTCUJrmhZJVrXQLkCXZxH6bLL7rrVDjECnmdxwV
   RTOb5P+/09hX4UTPQlei5dyjr40utcM2kf4JHnJ9QL64TajveUdwsuY+b
   VZLk4co546FqQlBX0cqBepcyeZR8K3XcpHubzeaTzbd2OJr1736lzEdwL
   rh59RMls6ayCRLYURHggZPDJ1bzXMoLTuVVSKcFM/XEP3ix1MgAQPVCvp
   53/5wo7T/7NGcx35ZPUBWuT9YfwRpkkuQLOf5ngnG06KOXjMLf3z7U/qc
   Q==;
X-CSE-ConnectionGUID: E9IBveVtR32LtU6+tVqMmw==
X-CSE-MsgGUID: 5BfVq1WrTPKoYuLScjs77Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86594000"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86594000"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:45 -0700
X-CSE-ConnectionGUID: NAdYo6EMSDK6ROnkxKKcxw==
X-CSE-MsgGUID: b61DikfoS5eK38XeXodP1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804618"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:45 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
Date: Wed,  5 Aug 2026 18:15:33 -0700
Message-ID: <20260806011536.4172258-5-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
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
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - Switch to using gva_t for the address argument
 - Split patch diff and reworded the commit message
---
 arch/x86/kvm/vmx/main.c   |  1 +
 arch/x86/kvm/vmx/nested.c | 11 ++++-----
 arch/x86/kvm/vmx/sgx.c    |  3 ++-
 arch/x86/kvm/vmx/vmx.c    | 47 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 arch/x86/kvm/x86.c        |  2 +-
 6 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0ff3230fd95e..3580aada8d2c 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1031,6 +1031,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
 
 	.get_untagged_addr = vmx_get_untagged_addr,
+	.is_lass_violation = vmx_is_lass_violation,
 
 	.mem_enc_ioctl = vt_op_tdx_only(mem_enc_ioctl),
 	.vcpu_mem_enc_ioctl = vt_op_tdx_only(vcpu_mem_enc_ioctl),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7ed79894d11d..61cf20cc4705 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5299,11 +5299,12 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
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
@@ -6108,7 +6109,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
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
index 973f7e95be65..ecd105f35c78 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8604,6 +8604,53 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
 	return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_ULL(63));
 }
 
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
+	 * addresses without toggling RFLAGS.AC.  Branch targets aren't subject
+	 * to LASS in order to simplify far control transfers (the subsequent
+	 * fetch will enforce LASS as appropriate).
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
index dc8517f15bc4..43df725a77f0 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -397,6 +397,9 @@ u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
 
 gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 
+bool vmx_is_lass_violation(struct kvm_vcpu *vcpu, gva_t gva,
+			   unsigned int size, unsigned int flags);
+
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
 u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 70c8439312c3..a6ea736fd48f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10752,7 +10752,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
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

