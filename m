Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130A3B42CE
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402531; cv=none; b=EKv9r9GtP9pI7iewUPs5d7nRiS7it37kiDe91L/OsENVB83FPJb1AxxzI3imHHp6zLLQFE7FVVn1E1DvpZsJFs1NjpPGQgx1R5kDmz1fVrt9UL1clg32/XUPuV59pog2l6sxbZcoIZgpEIVCeEjlhVbGnYs4KCXHG7ReUgdtd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402531; c=relaxed/simple;
	bh=ezLJCLMbVJeO1TB2+TOYF2iKtaGrO11RtViA7rAPS+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=modTTM2BQBD7MGVpnnkWREzJYIevFyrLQy6IfFTm3AW7rz53LYoCP38CCy1BefsYXHpb7Mhim9Ma6rYABTKwbTWCc7oNHHcDCI4o9FuMtjpkFnZCmOEXcLaMpzfpzmi9nOIrqIfHiyK+lKXhgUbjdnijbbYxhK/WF6ADf5ij/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4p8qdpy; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4p8qdpy"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84865f326efso3032302b3a.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402529; x=1787007329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x+HTMJZ+MtQQgAVQxt+nrwT2irv/Xu9LPWilczsy7do=;
        b=K4p8qdpyCBfam/LuUqtgT50b+4rD41+yLmwkoZ3wP0bkEee99rzhYy1kV6iybuXAGo
         tr7gVtF9woD9SPM4Lucg3dWq1d63puaGwezATI/0fhW5zUZn3qKBLvWuEG8ON0CFVI3L
         X5AApxHwd0nEfqqNAXfI4B77XGzEBwk4JDZiF8eGcmOsid5IvJ7t2bSuD6W8NFIgOeRU
         nv+bUFxuQTDBbcRzp2od9/SLpJGTWrwCS9BrVWgo2/Oji6c34aUrHNDUjvl0X7cFWoOX
         9j9XKsGvOwLSKJZYhFjazkNYveX5aVtRaFcsYtwDGW+8E4tto52+snDYtlri/2avJsTz
         kFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402529; x=1787007329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x+HTMJZ+MtQQgAVQxt+nrwT2irv/Xu9LPWilczsy7do=;
        b=JLBp1ebtrUpIAN154vrLA0jgPEdoSCGGOUy0cGWCAYVTc98llvpi4NaOLsfLpbw9jh
         CqjQd3/dJpMrszDmfgfCSxATf1btkpgyNC+4h5G378rufznub+QLVG3bTpb8G6R8D+7W
         ajbvWv/SPCCx+OFHkv8hwgKLFPPGEVOWSktg8jJtCpyZXoCK0gNLqVe/dCcp1Qaq2W6L
         YWGq3jQDX3IzIlnNhMltQe7l6zj8fCAAYnTVDRgEOBoElb+6GsKOt6GD9Xf4K6tPFl7x
         ZBKfuxAQo01oUj3VbDiRlZss8+Jxl4vdWdln7F0p4UjLYIuQGQ/+em9II0qwEkr/Tovb
         wPXQ==
X-Gm-Message-State: AOJu0Yxo3DyMsYNIIiEP3r4CAranyzbGo6q/UyHVptJ1Vpke9GGkDVAn
	Cefblgh9rYh8dTtdDu1mlGSDOOLy7kpi6o42/fvC4mvEaNiOgwLlEA3EspqTm/fP3WQtfENojuj
	Xf3uJUg==
X-Received: from pgv36.prod.google.com ([2002:a63:1564:0:b0:cbe:93b3:1154])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1396:b0:845:eb88:3d74
 with SMTP id d2e1a72fcca58-84f9c9d8504mr4998640b3a.29.1786402528485; Mon, 10
 Aug 2026 15:55:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:59 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-22-seanjc@google.com>
Subject: [PATCH v9 21/21] KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Replace the KVM-private vgettsc()+/do_do_realtime() timekeeping
reimplementation with calls to the recently crafted, generic
ktime_get_snapshot_id() interface.  As noted previously, the snapshot
provides both the system time and the raw_cycles (TSC), atomically paired
using a sequence counter.

With great pleasure, delete the now unused read_tsc() and vgettsc()

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: separate from other conversions, express joy at vgettsc()'s demise]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 85 ++++------------------------------------------
 1 file changed, 6 insertions(+), 79 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1513e4ae2353..a638898e528f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1381,82 +1381,6 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 
 #ifdef CONFIG_X86_64
 
-static u64 read_tsc(void)
-{
-	u64 ret = (u64)rdtsc_ordered();
-	u64 last = pvclock_gtod_data.clock.cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	/*
-	 * GCC likes to generate cmov here, but this branch is extremely
-	 * predictable (it's just a function of time and the likely is
-	 * very likely) and there's a data dependence, so force GCC
-	 * to generate a branch instead.  I don't barrier() because
-	 * we don't actually need a barrier, and if this function
-	 * ever gets inlined it will generate worse code.
-	 */
-	asm volatile ("");
-	return last;
-}
-
-static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
-			  int *mode)
-{
-	u64 tsc_pg_val;
-	long v;
-
-	switch (clock->vclock_mode) {
-	case VDSO_CLOCKMODE_HVCLOCK:
-		if (hv_read_tsc_page_tsc(hv_get_tsc_page(),
-					 tsc_timestamp, &tsc_pg_val)) {
-			/* TSC page valid */
-			*mode = VDSO_CLOCKMODE_HVCLOCK;
-			v = (tsc_pg_val - clock->cycle_last) &
-				clock->mask;
-		} else {
-			/* TSC page invalid */
-			*mode = VDSO_CLOCKMODE_NONE;
-		}
-		break;
-	case VDSO_CLOCKMODE_TSC:
-		*mode = VDSO_CLOCKMODE_TSC;
-		*tsc_timestamp = read_tsc();
-		v = (*tsc_timestamp - clock->cycle_last) &
-			clock->mask;
-		break;
-	default:
-		*mode = VDSO_CLOCKMODE_NONE;
-	}
-
-	if (*mode == VDSO_CLOCKMODE_NONE)
-		*tsc_timestamp = v = 0;
-
-	return v * clock->mult;
-}
-
-static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
 static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
 				 u64 *tsc_timestamp)
 {
@@ -1523,11 +1447,14 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
 					   u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap = {};
+
+	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
+	*ts = ktime_to_timespec64(snap.systime);
+	return true;
 }
 #endif
 
-- 
2.55.0.679.g6767b8d81c-goog

