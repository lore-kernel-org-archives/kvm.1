Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564903AA9F8;
	Thu,  6 Aug 2026 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979128; cv=none; b=RcgT/wYtq+01VnSfl6Bk2FjPOdDPYZDQqgmJG0GqrenQ09eFdlFOTYT2qm4hGvcsFvAec4sniP1t0z3deKTKSq7dthjl6peTXT3ZXhJ83s7v0RECrx++g8qy2nhz6AVGmJtEAX9Fh4tDn+lqopu26QksnIZ/h/LGgjkxzz7j6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979128; c=relaxed/simple;
	bh=GQYT6sb5UlBNgU+qYqrDwbOdsyfYfWJMXudd9GDVMf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhLDYJ5ux2Gw02JJFEyhTreXyKrZoTUeGuHfgoYlBR6sDWnbMrxNzHtMYEI4S4b6YilAtPpQJWlxrd7i/0xdyEaFPQ3qnlSO/qxLcJ58dicwZt3UMdUgfJ+FytA8ZR8cjy4l7+2RTlmYno/tA/O7+QWtC09F8l02Nj8DKC34dRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2g3XP1J; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2g3XP1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979126; x=1817515126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQYT6sb5UlBNgU+qYqrDwbOdsyfYfWJMXudd9GDVMf4=;
  b=L2g3XP1JaWD58PDOPARPdYt+FrhsNfv4bIh16n43nD516+bnnQRdHJ1H
   1z0fWuqiwhDKQfAYhwsYLGVLpOxDVC414MuWx/tOfsS8sIuIjCliFCvf4
   lxYkswxGV+qqnCdhQAdKStmTSAul94KEvtdqjTGLqT1SV5Hawr4xR8E58
   QyL7ufJc5qs8rTMCQxhn3Sq34aG3hTEbfs4UWfdVygTEaYOcNGqUSHHiJ
   UKX1mXe44sxS8bIiU73mDDIHUAb4z6qWGWBrHQNLTImLYdTZCkxvaVgmF
   StqcB48InGKijy/5ExkVfdqiqV75mLlMXsGTYuaaZqPeW+gnuqyfq4A5/
   w==;
X-CSE-ConnectionGUID: Tc+iY2MKSju3r1yDCiEnPw==
X-CSE-MsgGUID: YGTa24pVSreHTZys0IgFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86593990"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86593990"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:44 -0700
X-CSE-ConnectionGUID: fcE+frd2RJq3S21b9ydyrA==
X-CSE-MsgGUID: 5X1MAht6TbePGGGdveIxjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804614"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:44 -0700
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
Subject: [PATCH v4 3/7] KVM: x86: Add LASS violation checks during instruction emulation
Date: Wed,  5 Aug 2026 18:15:32 -0700
Message-ID: <20260806011536.4172258-4-sohil.mehta@intel.com>
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

When Linear Address Space Separation (LASS) is enabled, the processor
applies a LASS violation check on every access to a linear address. To
align with hardware behavior, KVM needs to perform the same check during
instruction emulation before consulting the page tables.

Add a new callback to x86_emulate_ops to let the emulator query whether
an access would trigger a LASS violation. The callback takes the linear
address and the size that describe the memory access, plus a set of
flags that convey the type of access.

Add the LASS violation check to __linearize() so that every explicit
guest memory access is validated along with the other linear address
checks. The SDM (June 2026), Vol3, Chapter 4, specifically states that
there is no relative ordering between the canonicality check and the
LASS violation check. Also, there is no prioritization specified between
the faults generated by alignment checks and LASS violations.

Implicit supervisor accesses bypass __linearize(). So, add LASS checks
for those in linear_read_system() and linear_write_system() and tag the
access as implicit.

For now, emulator_is_lass_violation() is a no-op. Later, it will be
wired up to the VMX implementation.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - Switched to using gva_t for the address parameter
 - Clarified LASS and canonicality checks and alignment checks ordering
 - Reworded the commit message
 - Use kvm_x86_call() instead of static_call()

Note, internal AI review warns about missing canonicality checks during
implicit accesses. A valid guest kernel shouldn't trigger canonicality
faults. But for correctness, such checks could be considered. Though,
that is beyond the scope of this series.
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/emulate.c             | 17 +++++++++++++++++
 arch/x86/kvm/kvm_emulate.h         |  3 ++-
 arch/x86/kvm/x86.c                 |  7 +++++++
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e30..a82b20281f31 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,6 +146,7 @@ KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
+KVM_X86_OP_OPTIONAL_RET0(is_lass_violation)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..d2181a805ace 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1727,6 +1727,8 @@ struct kvm_x86_ops {
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
+	bool (*is_lass_violation)(struct kvm_vcpu *vcpu, gva_t gva,
+				  unsigned int size, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 7f04544cfee5..9cbfde649064 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -693,6 +693,16 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 		}
 		break;
 	}
+
+	/*
+	 * LASS and canonicality checks generate the same fault and
+	 * their relative order is not architecturally defined. Also,
+	 * the SDM doesn't prioritize LASS violations against
+	 * alignment-check faults, so any order is legal.
+	 */
+	if (ctxt->ops->is_lass_violation(ctxt, la, size, flags))
+		goto bad;
+
 	if (la & (insn_alignment(ctxt, size) - 1))
 		return emulate_gp(ctxt, 0);
 	return X86EMUL_CONTINUE;
@@ -799,6 +809,9 @@ static inline int jmp_rel(struct x86_emulate_ctxt *ctxt, int rel)
 static int linear_read_system(struct x86_emulate_ctxt *ctxt, ulong linear,
 			      void *data, unsigned size)
 {
+	if (ctxt->ops->is_lass_violation(ctxt, linear, size, X86EMUL_F_IMPLICIT))
+		return emulate_gp(ctxt, 0);
+
 	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, true);
 }
 
@@ -806,6 +819,10 @@ static int linear_write_system(struct x86_emulate_ctxt *ctxt,
 			       ulong linear, void *data,
 			       unsigned int size)
 {
+	if (ctxt->ops->is_lass_violation(ctxt, linear, size,
+					 X86EMUL_F_IMPLICIT | X86EMUL_F_WRITE))
+		return emulate_gp(ctxt, 0);
+
 	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, true);
 }
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 97421b8dde13..f136d3d0ba42 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -249,7 +249,8 @@ struct x86_emulate_ops {
 
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
-
+	bool (*is_lass_violation)(struct x86_emulate_ctxt *ctxt, gva_t addr,
+				  unsigned int size, unsigned int flags);
 	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				  unsigned int flags);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..70c8439312c3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5800,6 +5800,12 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
 					       addr, flags);
 }
 
+static bool emulator_is_lass_violation(struct x86_emulate_ctxt *ctxt, gva_t addr,
+				       unsigned int size, unsigned int flags)
+{
+	return kvm_x86_call(is_lass_violation)(emul_to_vcpu(ctxt), addr, size, flags);
+}
+
 static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
 				       gva_t addr, unsigned int flags)
 {
@@ -5859,6 +5865,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.get_xcr             = emulator_get_xcr,
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
+	.is_lass_violation   = emulator_is_lass_violation,
 	.is_canonical_addr   = emulator_is_canonical_addr,
 	.page_address_valid  = emulator_page_address_valid,
 };
-- 
2.43.0

