Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86743274670
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309041; cv=none; b=ObiVnzn/XC9m9gFH+TUhx3wtgcdqrwxvSPpSP45kQc/jpTdJ7T4akrrYJKtcyksvUoOodjik8CuT9u/fgW2X9hcyKA8fzQijJYsbaEVK14ht5kpOuCIPnKEHiEqWA1c3rNNJ4WG/PnBICv2zpNEbM/taLON6xLtoxtPWpQ+Y/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309041; c=relaxed/simple;
	bh=xDIexEzWsokGY1ot/TXgPz0XxmAeawbDTidNIFnBVx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2Lh4HXUEsf8jvNK1Z5qnmaG+9zAoR+0nRXp1Yd2/TY6UHxM4tFDH0B76/l7ICOEmUcGOhllxEfay07zeTKVSqcyC+EogMjkbHiKQE1ozG45OINqAOflPaojgAxh8fr0DIHGf7OyckX58ulQqrZTjuahkqHCjjxMEKWErLVxIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAhC4BHk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAhC4BHk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842692bf60aso2006589b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309039; x=1781913839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tVEBpi8LrMz8eof+SsM1JvjGvZdFBSYQWxrXkLMLT1E=;
        b=BAhC4BHkA8zWu+BMt21ofEisp3R+WL2lkY9+TBKe+PJnjltQeSaqVfFCoyPbh5Unqe
         OGrwWC9QCUaajg1Ow4CCtIud16mDuEsN9WUI/eIYLNPQKA/d7KTvLv+ZgwZcnpusy6Z0
         CSlVxKQYLLYndPSrCodpOOxjx2QhlDeIwJw0FMeMB0Xh51IBvWrPD1oHOmzjiMSz1imu
         mvxMxAc4F0rlN4JR+DS/10xI4MK2m2Jjsz9v/cIVopgwkRgtrA7rqy42LUCYsP8sG+XZ
         bcd4XrE2LgwJCKXIg4W7CiqDUFG+2WLDanEcQrlFujxIoNlDWnU1t1ooZC/ojLOFHJ6r
         fHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309039; x=1781913839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVEBpi8LrMz8eof+SsM1JvjGvZdFBSYQWxrXkLMLT1E=;
        b=BUxOWbbdJvZGry0nhX1u5Z/uvdSLHbEbXa42CcrJAX2E/d8788j3jLK4BcVzYOE3EX
         UQomr1uc8xAFDdUDB/+N9KKvC35pko5y4EQERrvx8WDy4W6FTQ2/g7U06kq3t4A9+2it
         qxcpBhMUWLllEuDEBVGv5Ffcvs6rVfyD3wJj4AhYkxJFyAuNiFp77F4/u1klBbyHAhZF
         M3iciW22D7sqOj0mqfodac8N5lD5RCgrns5cuyMbSPE5xjvpNV37GOzjqqOka3d0J/YA
         G2T13ajii3Gt3ExQzqT1LrXPJe6sy1BrApAMBx+HmM9sOLyIn2+/G5DxUkWiVDQlSpq8
         /bBw==
X-Gm-Message-State: AOJu0YzByz03ih4mbXbcLjkelBMT2+PTIowzT6zl9U/Ib9Lc8/FPp3aQ
	iKCFKkqX2T1gvgTRGdGciLLsZ3LlQyfDZroL+FhL/BSLeLZUh28j1zoheRfSag3XH4oJhOEr0TZ
	DFIXhxg==
X-Received: from pfbkm55.prod.google.com ([2002:a05:6a00:3c77:b0:842:3c77:598c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d9d:b0:842:54e8:bdd
 with SMTP id d2e1a72fcca58-844e1aa64dbmr1898401b3a.40.1781309038799; Fri, 12
 Jun 2026 17:03:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:17 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-19-seanjc@google.com>
Subject: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the definition of "struct kvm_x86_msr_filter" and its associate,
"struct msr_bitmap_range", to msrs.c, as the details of the filters are
very much implementation details that can and should be buried in msrs.c.
While the _existence_ of filters is public knowledge, almost by definition,
the contents don't need to be exposed outside of the MSR code as the filter
data is provided by userspace, i.e. it pretty much has to be dynamically
allocated, and thus never should be fully embedded in a globally visible
structure.

Note, this creates a discrepancy with the PMU event filter structure; that
will be remedied shortly.

No functional change intended.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 15 ++-------------
 arch/x86/kvm/msrs.c             | 13 +++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09e437c947a9..4ff6304c02d0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -315,6 +315,8 @@ enum x86_intercept_stage;
 struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
+struct kvm_x86_msr_filter;
+
 struct kvm_caps {
 	/* control of guest tsc rate supported? */
 	bool has_tsc_control;
@@ -1291,13 +1293,6 @@ struct kvm_hv {
 };
 #endif
 
-struct msr_bitmap_range {
-	u32 flags;
-	u32 nmsrs;
-	u32 base;
-	unsigned long *bitmap;
-};
-
 #ifdef CONFIG_KVM_XEN
 /* Xen emulation context */
 struct kvm_xen {
@@ -1328,12 +1323,6 @@ enum kvm_suppress_eoi_broadcast_mode {
 	KVM_SUPPRESS_EOI_BROADCAST_DISABLED /* Disable Suppress EOI broadcast */
 };
 
-struct kvm_x86_msr_filter {
-	u8 count;
-	bool default_allow:1;
-	struct msr_bitmap_range ranges[16];
-};
-
 struct kvm_x86_pmu_event_filter {
 	__u32 action;
 	__u32 nevents;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 07f2a22d2607..c230b18d87e3 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -32,6 +32,19 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 
 #define MAX_IO_MSRS 256
 
+struct msr_bitmap_range {
+	u32 flags;
+	u32 nmsrs;
+	u32 base;
+	unsigned long *bitmap;
+};
+
+struct kvm_x86_msr_filter {
+	u8 count;
+	bool default_allow:1;
+	struct msr_bitmap_range ranges[16];
+};
+
 /*
  * Restoring the host value for MSRs that are only consumed when running in
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
-- 
2.54.0.1136.gdb2ca164c4-goog

