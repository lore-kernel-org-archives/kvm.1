Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3B471259
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886784; cv=none; b=HUitgZUTWO6xf+ciYMny/Hb3yxix9C1MNg8FbQV8aczOldZxHxo3jPQEXqtnXyk9JJ82UjhnBZC8TH42RkGxHZgLH9dBK3lvecVBC71f64h3lSjVMjy17HTohfbPwfH9RH1cO+l6ucK6WP6/262LJQfBDkPihxSKxaq37I9HDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886784; c=relaxed/simple;
	bh=GbDDxRlbvftUHclixcrVm6MYfFPNZU3v3cMbJe0/dSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6QLYsuhviobHoEZyTCwf87sQ6QxYUpqnRnmKZG/iyZFjt0oiVeDW/6Smmod4bHs2IP3KquBp2oFbHCmKBCNAos9JxKf4liYvr8fcHNZ14HvhwnE21oeDmoHS/8VosgmOgB8ZcZmgtW7uvJfIKTEQLfn/8oBl1ZIf6xp6SDQJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UG4kPBeo; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UG4kPBeo"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1948614b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886782; x=1786491582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YqOvePDEGD7lsMrnIIEP459A6germ9Y0ToT6dwrTiHQ=;
        b=UG4kPBeoX/nzVapSgvaruEfaIW1qg4HcMXPjHLpr77Xc0aowSVJI0EX6v5OZZ4eJ3a
         CbabsN36j1w98lxtQJ6nVUwLTLQ/Hd+pjshrIFoIcEfIAnThF+tn+LA+S+nNGb7OouF2
         /ulusf7C9nHp+u9xHVECFw1KXzlbbEYi/3DhEK7jb2OTVMExnp0miJt1cN13ybEmxPlJ
         h/bhbB64vU1HFim9MMGErXYV9OG/wUKuTNo1trbqmf4D2IiGZ9+RzGimLA9oXzae4N8V
         eVJYDIyeIxTZOAygCt2h6QsVXwBzEwiourfJtdeqhtEnamc0Smgv3GsLTEOhzyycHnC/
         zjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886782; x=1786491582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqOvePDEGD7lsMrnIIEP459A6germ9Y0ToT6dwrTiHQ=;
        b=WVxHvMCjFA06kfiGyLNBH9h9CRmpwZgDRbIuWy2g1mXeMtdSboxvudbxFrQXqd8nEZ
         +p4i3vzYN7GOLguXl/43XT1FOBZkmPhJIi4vkeyrbJNdIjDqfaBl/RPlmp+iyZsvdIUP
         Zo9RH+DC4Knn6Efkk3NFfpmU5mSnHFvI1ZYdOk+LKrKjfe2gQs9zedd0BrxLQFADt6k8
         WI/ruVB0qmXe/Zup/Wa4RxBBoVMaEUq2ptlUXjKjTBaw1kdPNcWmNqqfqELRXj7Cu6om
         7zHJALiAOeC8sP+tvuGFmUz6kK+cfglLFIoBaB1AsxaJ1TTrNjohp3RHleDTMBfkgbLq
         STYQ==
X-Gm-Message-State: AOJu0YwQxP8OWFvWiQdvXG3p8pn/L+LB/z54Ne//KQeE5FOLanGdrUuY
	egLKI3lf3czTQRF4kQLpMR5CnAe4TcJKMTvvrJzv+WI98S4iZg+Fg5nG5LXx5o8sOIx6F71ZQnq
	oPOVvww==
X-Received: from pfnx14.prod.google.com ([2002:aa7:84ce:0:b0:84a:894f:23f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a116:b0:848:2a69:97be
 with SMTP id d2e1a72fcca58-84f2dbf31b3mr2422634b3a.10.1785886782216; Tue, 04
 Aug 2026 16:39:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:18 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-15-seanjc@google.com>
Subject: [PATCH v8 14/17] KVM: x86: Make master clock logic in guest PV clock
 updates 64-bit only
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Wrap kvm_guest_time_update()'s entire use_master_clock block in #ifdef
CONFIG_X86_64 and providing a hardcoded-to-false variable for the 32-bit
path, as use_master_clock is never true on 32-bit (host_tsc_clocksource is
only set under CONFIG_X86_64)

Keep the local "ka" variable outside of the 64-bit-only code as it's also
used for Xen code, but tag it as potentially unused since it's not used on
32-bit kernels without Xen emulation.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63702be799cc..070a12535788 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1796,22 +1796,21 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
+	struct kvm_arch *ka __maybe_unused = &v->kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock = {};
 	u64 tgt_tsc_hz;
-	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
-	struct kvm_arch *ka = &v->kvm->arch;
 	s64 kernel_ns;
 	u64 tsc_timestamp, host_tsc;
+
+	/*
+	 * If the host uses TSC clock, then passthrough TSC as stable
+	 * to the guest.
+	 */
+#ifdef CONFIG_X86_64
 	bool use_master_clock;
+	unsigned int seq;
 
-	kernel_ns = 0;
-	host_tsc = 0;
-
-	/*
-	 * If the host uses TSC clock, then passthrough TSC as stable
-	 * to the guest.
-	 */
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 		use_master_clock = ka->use_master_clock;
@@ -1820,7 +1819,9 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 			kernel_ns = ka->master_kernel_ns;
 		}
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-
+#else
+	const bool use_master_clock = false;
+#endif
 	/*
 	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
 	 * NOT using the master clock, the TSC frequency may vary between CPUs.
-- 
2.55.0.571.g244d577d93-goog

