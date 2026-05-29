Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC54418EE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093388; cv=none; b=jy0N1Rs2LQ+wvOAdE4UoC3jib/gM6CyEt+J2gaVZcnWwO/mWWGGFgTWLBwn+hcaIw8Wu6tPlQ24oC7VI51UV9H6wymrASfOkfNyivXqO5lluzIOzbMy9/oBpdf61TWiii3hue3WaXYVtB5S0OlwW1USwxugotoXwZvjHqLiwEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093388; c=relaxed/simple;
	bh=P2zXCRLo2YdTzgguBobD3cMk4Ntf0Zw0zqR0CFK6aS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h7MPv6ABhGN2viM5WgtbM9bS6bWgT15+8CVJwloGpoNmI2Vs31GsWEasgHa4M5skVNtGiGTpEds3lSV+FAK3d2y+jGfPJBaX6Egl/7ECxl6nryishXPW7auEKr1IAmwJOsukE85g+oiw3KPysaxMdGZVVEjiQcrhXjaj/Vxc3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PT3o+d/n; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PT3o+d/n"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so155862915ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093384; x=1780698184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SUKUT1cLL25O6B1OgJD5A10iK66u2vgLhkpt4cYUGcI=;
        b=PT3o+d/nrzA5J4WK9HDNgdrtIpQEIxRiYGaRxWpDsbI9GtQ2Qh6o3xwWM0/q0SAekb
         OguV4EhMZiYKPTCBNJwX0fOP+bf64dHP475nseF+Rhv3ZhozhkbH0/EV1GE9V2OgI5zy
         iKvYx1X/On+FCFSaM0fM2paZH0/AGA5CuZ/1GOWCdJA6TZqmtxpH1gxgW5DZk1dbfr58
         6MvD2nMkFoMfunidHmLJnCMJnoFc59jsuqHsr3YgCIDuDLn/44L4PUldxJTXuuwgMcV7
         2OqxTTeD47I5ZMNND0KG+1KajR0d/ywBWgRJ6hsE0CHQBWEfE5hli1mi+YYKp4NTkORZ
         fX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093384; x=1780698184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUKUT1cLL25O6B1OgJD5A10iK66u2vgLhkpt4cYUGcI=;
        b=GmvOPU9x3PdR2gMMmwwg/nLo3Vu0EGOzWis20Xq3hGpyul0uW1gmzb6b0RPlPKY1aS
         GOL+MiaFxCsfHkYeTVA3oJRgYknAwyzDYoPPavqd3lhSYjxtet0ibMoz0O6NZlgAJpCi
         S4pGllN1GUxoit+qvE9yJk/LTq6uy4aA46FFgQcrWGvN3AkTxnZwB/x7cJiWx02HkveQ
         1i5dMa8eFjsUp15Jm+zi7yN/zt91ocZsV23gxGZP1DeJnGaC7VNKV8oY3ZZr4vjU3zbO
         GnmOSckD2pbiKyZAqF7UUzpCsemHAAy0zVLYVeAkypEDVlcnRS8OVnWI0ZP48Y6D19UZ
         X2DQ==
X-Gm-Message-State: AOJu0YzSzlufDtmXHH8Ll+JM71pSWvPeAhyasp7QrqAGYVNi7+5XSQce
	X17pb/+3nkdttE7OecLdd5rZ7cZo+DYGSh025Y0F1ip+Rc32/w+QtzF++GGCi67h4E8zd1oSyyB
	Ol4Sj2A==
X-Received: from plblc11.prod.google.com ([2002:a17:902:fa8b:b0:2b0:6cdd:87e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc8e:b0:2ba:839e:15cb
 with SMTP id d9443c01a7336-2bf368463e6mr21255845ad.27.1780093384365; Fri, 29
 May 2026 15:23:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:01 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-19-seanjc@google.com>
Subject: [PATCH v3 18/40] KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate the kvm_caps and kvm_host_values struct definitions and their
associated global variable declarations to asm/kvm_host.h to allow for a
variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
maintainable rule that asm/kvm_host.h's role is to define common
structures (and declare any associated globals), and anything needed by
arch-neutral KVM.

While it would be lovely to trim kvm_host.h down to the point where it
*only* holds things needed by arch-neutral and/or non-KVM code, multiple
attempts to do just that have failed miserably.  Trying to "hide" code
from arch-neutral KVM is too restrictive (and ultimately pointless), and
KVM x86 itself also needs a place to define common structures and their
globals, e.g. to avoid inconsistent header include chains and/or misplaced
helpers.

E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
x86.h doesn't include mmu.h is that mmu.h references struct kvm_host, which
is currently defined in x86.h.  As a result of odd include ordering, the
very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h

"Fix" the kvm_host dependency so that x86.h can be the "central" include
everyone expects it to be, and set KVM x86 on the path to having somewhat
sensible "rules" for what goes where:

  - asm/kvm_host.h holds "common" structure definitions and associated key
    global  variables, and things that are referenced by arch-neutral KVM.
  - <thing>.{c,h} holds relevant declarations and definitions.
  - x86.{c,h} is the kitchen sink for everything else.

Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 44 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h              | 45 ---------------------------------
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2e535027dd5c..f7130eb98473 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -315,6 +315,50 @@ enum x86_intercept_stage;
 struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
+struct kvm_caps {
+	/* control of guest tsc rate supported? */
+	bool has_tsc_control;
+	/* maximum supported tsc_khz for guests */
+	u32  max_guest_tsc_khz;
+	/* number of bits of the fractional part of the TSC scaling ratio */
+	u8   tsc_scaling_ratio_frac_bits;
+	/* maximum allowed value of TSC scaling ratio */
+	u64  max_tsc_scaling_ratio;
+	/* 1ull << kvm_caps.tsc_scaling_ratio_frac_bits */
+	u64  default_tsc_scaling_ratio;
+	/* bus lock detection supported? */
+	bool has_bus_lock_exit;
+	/* notify VM exit supported? */
+	bool has_notify_vmexit;
+	/* bit mask of VM types */
+	u32 supported_vm_types;
+
+	u64 supported_mce_cap;
+	u64 supported_xcr0;
+	u64 supported_xss;
+	u64 supported_perf_cap;
+
+	u64 supported_quirks;
+	u64 inapplicable_quirks;
+};
+extern struct kvm_caps kvm_caps;
+
+struct kvm_host_values {
+	/*
+	 * The host's raw MAXPHYADDR, i.e. the number of non-reserved physical
+	 * address bits irrespective of features that repurpose legal bits,
+	 * e.g. MKTME.
+	 */
+	u8 maxphyaddr;
+
+	u64 efer;
+	u64 xcr0;
+	u64 xss;
+	u64 s_cet;
+	u64 arch_capabilities;
+};
+extern struct kvm_host_values kvm_host;
+
 /*
  * kvm_mmu_page_role tracks the properties of a shadow page (where shadow page
  * also includes TDP pages) to determine whether or not a page can be used in
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 80ed36d5d62a..b7d3b54cde15 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -12,48 +12,6 @@
 
 #define KVM_MAX_MCE_BANKS 32
 
-struct kvm_caps {
-	/* control of guest tsc rate supported? */
-	bool has_tsc_control;
-	/* maximum supported tsc_khz for guests */
-	u32  max_guest_tsc_khz;
-	/* number of bits of the fractional part of the TSC scaling ratio */
-	u8   tsc_scaling_ratio_frac_bits;
-	/* maximum allowed value of TSC scaling ratio */
-	u64  max_tsc_scaling_ratio;
-	/* 1ull << kvm_caps.tsc_scaling_ratio_frac_bits */
-	u64  default_tsc_scaling_ratio;
-	/* bus lock detection supported? */
-	bool has_bus_lock_exit;
-	/* notify VM exit supported? */
-	bool has_notify_vmexit;
-	/* bit mask of VM types */
-	u32 supported_vm_types;
-
-	u64 supported_mce_cap;
-	u64 supported_xcr0;
-	u64 supported_xss;
-	u64 supported_perf_cap;
-
-	u64 supported_quirks;
-	u64 inapplicable_quirks;
-};
-
-struct kvm_host_values {
-	/*
-	 * The host's raw MAXPHYADDR, i.e. the number of non-reserved physical
-	 * address bits irrespective of features that repurpose legal bits,
-	 * e.g. MKTME.
-	 */
-	u8 maxphyaddr;
-
-	u64 efer;
-	u64 xcr0;
-	u64 xss;
-	u64 s_cet;
-	u64 arch_capabilities;
-};
-
 void kvm_spurious_fault(void);
 
 #define SIZE_OF_MEMSLOTS_HASHTABLE \
@@ -417,9 +375,6 @@ fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
-extern struct kvm_caps kvm_caps;
-extern struct kvm_host_values kvm_host;
-
 void kvm_setup_xss_caps(void);
 
 /*
-- 
2.54.0.823.g6e5bcc1fc9-goog

