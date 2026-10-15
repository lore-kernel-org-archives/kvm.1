Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521304E56C8;
	Thu, 15 Oct 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095723; cv=none; b=Hx/mCfVJ8rxyY5ZfxS/4Zry5cfxoqVaMy/fuo66qHMchHmN2IBwqvPWDrNhuqS/0tjBlyNVjql8M2/26u+L7jVodF8qysbcarM+nZmef7x7HE3ZRcPKqhHxLcKVHnWKlZXQhYZdG8tqU+oT9ZE9HfY3aXYMPamA3tW4ANxDJ1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095723; c=relaxed/simple;
	bh=Dd7MsmCoV9aXmjakAz8Xoy0iMJDmV7ajQm+CqmYY+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui3su76v0qr4Ye2OlPOnnX3aoM06tnZ4k0eRPpWxtE073lsxdsbnhcEsQCalCc4I7AJbiqM3+5RRHDgvEgZONtZZ20gnwbrVfY+JX/TijZFHRC9+JhYVs+VLRc6ptdL5ljcCvxrTLuhlpGLPRldXjbvxRLkgsi+GShkNqS40HGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yf5sjLfK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yf5sjLfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095722; x=1823631722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dd7MsmCoV9aXmjakAz8Xoy0iMJDmV7ajQm+CqmYY+2g=;
  b=Yf5sjLfKrZFUf6RXn/E0RpbtvAQzAKwtkMZ3OkKd5DRqBkmfi1N6Hqmk
   Yw0gt+A9YJpgA//icu0xX4Uy53oEWDFdLXQk5NtAxKrzjIpNlfRpifqY8
   uLoe5a/R8NryEtrlUVcS+duv6M/RTjJ/s1kn7V+0FedjH0hoqJh6Hav+O
   z2bC1KiMqwA+iRQ8JqBvKI41JFXlgXkbqWHJGt2rdUJ+gHOGrq08K1eEL
   xSteql5zOSA42IGnTyr6+pDj5D7Odx3mcr/qKHqEX7YtlPY7ZXVbnt1/T
   Dv85+PaAb04GxyD+i5pmpd1vPmB2+Nv4nbu5veNy9YRslmhZ8G+Ch4hrd
   A==;
X-CSE-ConnectionGUID: jZVg+u0YR66uCqv00n+9bw==
X-CSE-MsgGUID: FprrIk7pTWemRySY2C4YrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911104"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:22:00 -0700
X-CSE-ConnectionGUID: qdhylAxKSvyN58cUI/D4zQ==
X-CSE-MsgGUID: 5grNBMjJS4yLkW+P9+6Xyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844438"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:58 -0700
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
Subject: [PATCH v5 3/6] KVM: x86: Add LASS violation checks during instruction emulation
Date: Thu, 15 Oct 2026 13:19:37 -0700
Message-ID: <20261015201940.1655956-4-sohil.mehta@intel.com>
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
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v5:
 - Replaced Binbin's SoB with a Reviewed-by
 - Picked up Tested-by tags

v4:
 - Switched to using gva_t for the address parameter
 - Clarified LASS and canonicality checks and alignment checks ordering
 - Reworded the commit message
 - Use kvm_x86_call() instead of static_call()

Note, internal AI review warned about missing canonicality checks during
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
index 48fa973b98d5..e16ea56e5911 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -147,6 +147,7 @@ KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
+KVM_X86_OP_OPTIONAL_RET0(is_lass_violation)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..1099ec2801db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1743,6 +1743,8 @@ struct kvm_x86_ops {
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
+	bool (*is_lass_violation)(struct kvm_vcpu *vcpu, gva_t gva,
+				  unsigned int size, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index fbf47f5ae298..e071b1de1dac 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -675,6 +675,16 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 		}
 		break;
 	}
+
+	/*
+	 * LASS and canonicality checks generate the same fault and their
+	 * relative order is not architecturally defined. Also, the SDM
+	 * doesn't prioritize LASS violations against the misalignment #GP,
+	 * so any order is fine.
+	 */
+	if (ctxt->ops->is_lass_violation(ctxt, la, size, flags))
+		goto bad;
+
 	if (la & (insn_alignment(ctxt, size) - 1))
 		return emulate_gp(ctxt, 0);
 	return X86EMUL_CONTINUE;
@@ -781,6 +791,9 @@ static inline int jmp_rel(struct x86_emulate_ctxt *ctxt, int rel)
 static int linear_read_system(struct x86_emulate_ctxt *ctxt, ulong linear,
 			      void *data, unsigned size)
 {
+	if (ctxt->ops->is_lass_violation(ctxt, linear, size, X86EMUL_F_IMPLICIT))
+		return emulate_gp(ctxt, 0);
+
 	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, true);
 }
 
@@ -788,6 +801,10 @@ static int linear_write_system(struct x86_emulate_ctxt *ctxt,
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
index 0623637f923b..c4bd50a28e8a 100644
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
index 32563a91fba9..bd69934cafd3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5843,6 +5843,12 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
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
@@ -5902,6 +5908,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.get_xcr             = emulator_get_xcr,
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
+	.is_lass_violation   = emulator_is_lass_violation,
 	.is_canonical_addr   = emulator_is_canonical_addr,
 	.page_address_valid  = emulator_page_address_valid,
 };
-- 
2.43.0

