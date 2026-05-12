Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01601299AAB;
	Tue, 12 May 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550026; cv=none; b=LiA+yt9kRDX1cSScSnvNE4qvSrcLNhnPfa6oQtE1wJVbh6JbyDGgL9DZYk+2lywDt+zZvEAIYpnlyZV8gBNmfirX+BysRuYJsuvJiBHRZVURXyU/l8/ZEc3xCILamSRwcHNjEbmqz2wAWcXoDm1mepCoTznYPPViFR5VPLSilko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550026; c=relaxed/simple;
	bh=rRYx/DqFwQylNMC80SODlgxoMESxSmqvmCvmeT0talw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuGOIQt1Mx0KtXPtExXjLINNdu3WRggxvscmbfWPoHFcyXIhvNcxjuCVFF3WEsF69vMptF5fFk/2KPnLnnSlLqZoY1PK7HDgL8QIOxoQdqxcS1t0fviGqIo5MIWW6j2delw8X/d9l+EYF35QjZEcrD0ODbTzuZk+9NXeEGwVR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8Ch19fr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8Ch19fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550025; x=1810086025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRYx/DqFwQylNMC80SODlgxoMESxSmqvmCvmeT0talw=;
  b=n8Ch19frv5crJ3TQDPa2d35B+XA3Cf9MsyhCR4WP5uQKGUeVclanTE6x
   eUyZoglIzRo+0lFIw+MBZKGKZYy3rDncL/taWpX+0ZuXZmWQuq0RqcKcn
   8WIFVYtHvJAE2CCnnKzH6y0u/wFOyjCyUxsG42tr/jFNgPKBaLe0oXEhq
   HwuzjqqTOyAVZn+f/cmpOu8BWpVMK/1LI6SiwBQQ3byirHJROCDkaY5Py
   McsnSxFVg64oaKgH4ZX5gKIST3nqyb8EHBnAE21daGL5o8koDE/ybztTX
   wSEzLbaLZuQiukHI1VbWkowPNlvqrw0qJ2ONEZUfU60qcwJrN+wprCIHS
   w==;
X-CSE-ConnectionGUID: LASADdcBTZSwE4Njs06yRg==
X-CSE-MsgGUID: 11+N/KX6SCSCDPkWz3TZ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322124"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:23 -0700
X-CSE-ConnectionGUID: aNQ1fHAOSNWhnxT7a1Y8kA==
X-CSE-MsgGUID: 0Mu/YesDRlO9oNzbUS9DTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572763"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest FPU
Date: Tue, 12 May 2026 01:14:47 +0000
Message-ID: <20260512011502.53072-7-chang.seok.bae@intel.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

KVM will store APX extended GPRs directly in the regs[] field of struct
kvm_vcpu.  This is done to make accessors more uniform between GPRs and
EGPRs, and partly because x86 maintainers expressed the desire to compile
Linux with APX enabled sooner or later; accessing guest EGPRs from KVM's
C code would get in the way.

Therefore, let KVM handle the APX feature on its own when executing
ioctls to get and set the virtual machine's XSAVE state.

Cc: x86@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ chang: adjust function prototype ]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V3 -> V4: New patch
---
 arch/x86/include/asm/fpu/api.h | 2 +-
 arch/x86/kernel/fpu/core.c     | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index cd6f194a912b..0b218f5eaafd 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -160,7 +160,7 @@ static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
 					   unsigned int size, u64 xfeatures, u32 pkru);
-extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
+extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, void *buf, u64 xcr0, u32 *vpkru);
 
 static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 608983806fd7..ae5c73faed69 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -420,6 +420,8 @@ void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
 	struct membuf mb = { .p = buf, .left = size };
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
+		/* Up to date APX registers are in struct kvm_vcpu anyway.  */
+		xfeatures &= ~XFEATURE_MASK_APX;
 		__copy_xstate_to_uabi_buf(mb, kstate, xfeatures, pkru,
 					  XSTATE_COPY_XSAVE);
 	} else {
@@ -431,11 +433,11 @@ void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
 }
 EXPORT_SYMBOL_FOR_KVM(fpu_copy_guest_fpstate_to_uabi);
 
-int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
+int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, void *buf,
 				   u64 xcr0, u32 *vpkru)
 {
 	struct fpstate *kstate = gfpu->fpstate;
-	const union fpregs_state *ustate = buf;
+	union fpregs_state *ustate = buf;
 
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE)) {
 		if (ustate->xsave.header.xfeatures & ~XFEATURE_MASK_FPSSE)
@@ -464,6 +466,9 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (!(ustate->xsave.header.xfeatures & XFEATURE_MASK_PKRU))
 		vpkru = NULL;
 
+	/* APX registers are copied to and from struct kvm_vcpu, not the FPU.  */
+	ustate->xsave.header.xfeatures &= ~XFEATURE_MASK_APX;
+
 	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 }
 EXPORT_SYMBOL_FOR_KVM(fpu_copy_uabi_to_guest_fpstate);
-- 
2.51.0

