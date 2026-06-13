Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAB38DD3
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309022; cv=none; b=XUv9axYM86nm34rmKJr/YX5AxBMKjZYPTuNwitVnOZbhKm/AIYCAmG6nl5g5f7L0pdtWhnwfiH2Vsy7VhBUQ5rrPhEa81CDkVkBQHUpcVHG9AlugtK82zhYZKkF6FN/Htbid7ncp+SjlrSB1axrbQgc/QynQYSqzB9j6yu95Bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309022; c=relaxed/simple;
	bh=VCfXvYlAsNnTfjPorNWAwjoE53QCeKMLtMfsUcEqHkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZcXdKPBI84gAGYDBANf7hVcqRBkoVWtyBLftzMrNk44Th5HDSaf23hWIyTe612NmWMCQErEexO3GC/DceK98SIOBlLsxez6F0zjTI1q11O5iUdeIaPBNE2jDxb491dkH7L+PK0FbSa4MCI0WOPfHDRLll+P9yJcq6VXvJjFpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/zny9V/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/zny9V/"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8582b167f7so755995a12.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309020; x=1781913820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7vM8S2xsEK4YxPK5zgeR5QfX5rEA9qc/ZUmyBTUCfZc=;
        b=q/zny9V/mrboFImqJJD7EdY/yhtJYAdLweu89HcG99oWgYRbv/VHQiijPjkxLTsAAf
         jmSug2pTMBfWLS6D5b2ocD55CWDWz0uxQhxuVuB3r/qJYwdBFbjMO/MQd58eOii48t/s
         4kJl4YA6J1aUF7AzahaLvvzVa/jEiZY378FaXF5rV2PKxlljfhu/4HxJc93AQAnv2fXx
         HWMfGI84r83ZvqaLGFNLK6B8WHRI0ZF94NFmjhzmaOaAlQUbB9xu9IYVAuSrjl+cu0RS
         aKzTAilY9Addq4Nu/S6TH0UCW720byqZShTMXFqZ+xP6/zpCvLN5tQCEZLv2Etpsm89i
         IwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309020; x=1781913820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vM8S2xsEK4YxPK5zgeR5QfX5rEA9qc/ZUmyBTUCfZc=;
        b=qFZfl+GZHuJiSSEC2jGf/4Mz5148qv6YkvyYPIueMDJgg9DE6oK/OIGtc+DLhxMcag
         0ejJnb8EJ1pXmuXEcftrwl1+PlZ6Xn5mtgy8YP25OZC+SdkFeU9SavkB0Jve3wzbUVnS
         4/jGSWUrRV2tarl+9TJmrJAwrobPuKRJyhqZXAUvFl3WKyZzVeRC6KZQ8kQOZOstO4QF
         F8ZRDLh+UHtfITo/WrmCCI1TIJPnOeq5Oo5mHZO9jEsWwj88IY/QrXCQdcrV7WGHZCqz
         BF2FU00/ee+DIfoA5ZYBmKFtAoGyg1w8qWmTzYMHjSfGtdLzQWwIvyJBIC9FLzLhuPm+
         vKiA==
X-Gm-Message-State: AOJu0YydNm7t7tkYRlpFLZGXVoRhsIqkgFSxTiDSl8RiqJEX4u/CV5up
	Z4WKlfzHBcJtE4wnSirkk08pYma2oKVewl1GZMXyWUubkxf1hynTFnSK84TcYqP/PCV27RaAAwr
	QBURUNQ==
X-Received: from pgkb1.prod.google.com ([2002:a63:eb41:0:b0:c82:2d14:39c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2443:b0:3b4:87c0:d7f
 with SMTP id adf61e73a8af0-3b783fc439cmr5921278637.32.1781309020138; Fri, 12
 Jun 2026 17:03:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:05 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-7-seanjc@google.com>
Subject: [PATCH v4 06/30] KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
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
x86.h doesn't include mmu.h is that mmu.h references kvm_host, which is
currently defined in x86.h.  As a result of odd include ordering, the
very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h

"Fix" the kvm_host dependency so that x86.h can be the "central" include
everyone expects it to be, and set KVM x86 on the path to having somewhat
sensible "rules" for what goes where:

  - asm/kvm_host.h holds "common" structure definitions and associated key
    global variables, and things that are referenced by arch-neutral KVM.
  - <thing>.{c,h} holds relevant declarations and definitions.
  - x86.{c,h} is the kitchen sink for everything else.

Cc: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 44 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h              | 45 ---------------------------------
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 71e575d011e7..57e67bad4abe 100644
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
2.54.0.1136.gdb2ca164c4-goog

