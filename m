Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8829442FC4
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402528; cv=none; b=dTVFnfczyrbl1Lx+HdJ2UjIhPZj4ehL2dqGFlvHHG8vws0pGBZSTqKWY+nTAPvoLjR3P5rlyftD8ynKttVG2WJx4McbHrgt7unYGUS+ijXEosJJhXjEnIxGsf9TU4tANKYEffe81i6hp9qEGVg1ogqfGb86o6dtpm537BpGtVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402528; c=relaxed/simple;
	bh=UvWnP8rThQ0I2iu6au3IwSGq/W2BJVM9E1d48NUSteQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ax2GR9gSciP9FGmExd6qtulsNi9Rkb+Wpwvqwuaa6erybeeDKsqDjYOuD31+0qYqThzRxrtwfYT4jcHanoNEJWe2u3pnGasiXkUEsqZnnfthOC3gJeISjdMLuiawhNwbwvoOwjdi9Gm5kplLKWZt19FpdrnJBzyIkFiwgEQqbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaRYzKW3; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaRYzKW3"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so37086855ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402526; x=1787007326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=57aBPOihCrGWuqYYWudkiYYcx3GP5FARz7fTh3Mm/5c=;
        b=IaRYzKW3AZ+vr7omLIP6hsuC5mZVFBNRwls4uZMkBXMPH2I0E0BtlPpu2y+/XWDqpB
         pmRFkCXZvWc0dQi/yuo8/RuCF+hoh3+kNPKSr3B28PrBFYBf/WF5H3w25yELTcgUjiF1
         /bInh1egzb6quKATsYrBxeTitO4omykEV5dhvrf4eQRP/y+LblmO2ljbnxkZer1/4PJz
         0tCqsZ8sQktLeBEG4ICqt+szqfJ0YGlWWvzv7v5I1SndQdPhAu8ypcpFP+hUkA+8Vm6f
         55PGN78Ea46kZARhkeqvzqvj+UlPWNgjgGVK1Aje1eGfbGqIMcrOREsq5JF/TeJicbva
         hYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402526; x=1787007326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=57aBPOihCrGWuqYYWudkiYYcx3GP5FARz7fTh3Mm/5c=;
        b=Rh7BtuwOz9WVIvZESuTQPMB+vcY592Ra+unwTzGCrOrmX4itFeun3pS7WqKcNc3qgZ
         cUtbMu716LdmzZKDMsMEjEenvwVS09XlipL5fOLM3FzlgADUCjE4uoB/7CdyHcXyK2A6
         bwL0elht+eprSPsBHvppo3n7apE4Dtu7O6bTweZLIUymwDQhRBvhzIG4zc+Q0uNrzqqV
         DKIQP2za+NSTsUG9jNS5dhFfaR0ARv/3W6ANfiuXk/cxsmK//xCdKgFZrAvix1ADv8SR
         m3ctvV1o7qq9pKCGRgie63x/FuQLVhc0NcdMQmruW72cm1+fhblpyQHsW0Zm0nRZCse/
         gIzQ==
X-Gm-Message-State: AOJu0YwuosjIQKujB/P0r6gRDn0R8tfSv8vmtnAA3fYqSL8+kJPeMrxC
	t2aiRYqEcsWk22+XsyV2zM2k5I8EARthoJECaj3vPU8GyLXaHm/msvGs98UwppdsAT1Y4yb1wW9
	s5CYCVg==
X-Received: from plsk18.prod.google.com ([2002:a17:902:ba92:b0:2ca:cdc4:8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2bcc:b0:2c9:a5e9:c26e
 with SMTP id d9443c01a7336-2d3001e6ebcmr57931765ad.13.1786402526184; Mon, 10
 Aug 2026 15:55:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:57 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-20-seanjc@google.com>
Subject: [PATCH v9 19/21] KVM: x86: Use kernel timekeeping snapshots for
 getting kvmclock time since boot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Replace the KVM-private vgettsc()+do_kvmclock_base() timekeeping
reimplementation with calls to the recently crafted, generic
ktime_get_snapshot_id() interface.  This is the first step towards dropping
KVM's homebrewed implementation entirely (do_monotonic() and do_realtime()
will be converted in the near future).

As with KVM's implementation, the snapshot provides both the system time
and the raw_cycles (TSC), atomically paired using a sequence counter.  The
equivalents to vgettsc()'s TSC and HVCLOCK modes respectively are if the
clocksource itself is TSC (cs_id == CSID_X86_TSC) and if the underlying
hardware clocksource is TSC (hw_csid == CSID_X86_TSC).  In the Hyper-V
case, i.e. hw_csid == CSID_X86_TSC, if the clocksource couldn't provide a
raw hardware counter value, treat the clock not being based on TSC, which
which is equivalent to vgettsc() returning VDSO_CLOCKMODE_NONE.

Unlike KVM's current implementation, don't include offs_boot in the
atomically-acquired tuple as there's simply no need to do so: the time
since boot only changes at boot (duh) and at suspend/resume boundaries.
Unless processes aren't being frozen/thawed before/after suspend/resume,
which would completely break suspend/resume, TK_OFFS_BOOT can't change
while kvm_get_time_and_clockread() is running.  And if KVM does somehow try
to take a snapshot during suspend, timekeeping core will WARN and refuse to
provide the snapshot.

This is a step towards eliminating the pvclock_gtod_data private copy
of timekeeping state and the associated notifier callback.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: separate from other conversions, massage changelog accordingly]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 57 ++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aa39a423694c..85c456dd29d5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -35,6 +35,7 @@
 #include "smm.h"
 
 #include <linux/clocksource.h>
+#include <linux/timekeeping.h>
 #include <linux/interrupt.h>
 #include <linux/kvm.h>
 #include <linux/fs.h>
@@ -1435,29 +1436,6 @@ static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
 	return v * clock->mult;
 }
 
-/*
- * As with get_kvmclock_base_ns(), this counts from boot time, at the
- * frequency of CLOCK_MONOTONIC_RAW (hence adding gtos->offs_boot).
- */
-static int do_kvmclock_base(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->raw_clock.base_cycles;
-		ns += vgettsc(&gtod->raw_clock, tsc_timestamp, &mode);
-		ns >>= gtod->raw_clock.shift;
-		ns += ktime_to_ns(ktime_add(gtod->raw_clock.offset, gtod->offs_boot));
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
 /*
  * This calculates CLOCK_MONOTONIC at the time of the TSC snapshot, with
  * no boot time offset.
@@ -1502,6 +1480,29 @@ static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
 	return mode;
 }
 
+static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
+				 u64 *tsc_timestamp)
+{
+	/*
+	 * ktime_get_snapshot_id() cannot fail for standard clock IDs
+	 * (only for invalid/aux clocks or during suspend, with a WARN).
+	 */
+	if (!snap->valid)
+		return false;
+
+	if (snap->cs_id == CSID_X86_TSC) {
+		*tsc_timestamp = snap->cycles;
+		return true;
+	}
+
+	if (snap->hw_csid == CSID_X86_TSC && snap->hw_cycles) {
+		*tsc_timestamp = snap->hw_cycles;
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Calculates the kvmclock_base_ns (CLOCK_MONOTONIC_RAW + boot time) and
  * reports the TSC value from which it do so. Returns true if host is
@@ -1509,12 +1510,14 @@ static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
  */
 static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap = {};
+
+	ktime_get_snapshot_id(CLOCK_MONOTONIC_RAW, &snap);
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
-						     tsc_timestamp));
+	*kernel_ns = ktime_to_ns(ktime_mono_to_any(snap.systime, TK_OFFS_BOOT));
+	return true;
 }
 
 /*
-- 
2.55.0.679.g6767b8d81c-goog

