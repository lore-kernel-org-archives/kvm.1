Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B6492522
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780011; cv=none; b=kfuNdMtPWaYvBSYB9xcumKuRpfxsBm/DwS0BmMexV1kznqzh07fwsVixKf4+UKSIT5HC05VOlQ3ejXSjLwNc9JTeHI90v4U5tF48GOC8UmauuKpgy44kJozR6iRx2sc1GSFj5hkeoLm657vNDCsCjupbpY7lxz73kTBzQKYb5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780011; c=relaxed/simple;
	bh=MifOa2XnbtMroctCQ2vPlzSapAFPZbMD1f0LVHEO7X8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Se6Lof+P2KA9V8WnwfomevQH1/U4HWV4qDSwD1PA4z+I+gDTOo9gsb0AYxJblIeZD8RektGjGTmN8TMlnvnj/Zqf17f9Ni2K06InhlkO/wSfbzDJWQJMBNUR1Tfbpy165SJp6ETI5PCXJwLrZKxtz3qKiOiijhBu3SYspoOtwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PC2OcvxK; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PC2OcvxK"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1233533a12.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780009; x=1788384809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sIs19yA05E5+D5bvhm1516uSg4N0iBHK8YfCkpxX2Cg=;
        b=PC2OcvxKts4dmKa4tevER8k3tej1DRYZUs52ZD5uXDkXdQga7mY9QeNZWuPG3f+iUB
         wY1lf1M2/F/1Z/ii4VYL3MhU7qKEf0ba4PIrZGxr5IEEnJS5s28H6zpSR3KhMCoF57Z5
         G/vnAGRxMt2tmr3tk+mHmdiGY8N+DalR76Zng7j+ZPfpqo24qnve/XptvouipFiojr5b
         llyQcZZuSMsn/J7DiydAyWKH6pMEBo8DdRzyOazKD/XzJOjSfG0gcVrfyM3+Yhf/mHr9
         6bv3w6NYKw1GLIGIdkQRkc0Y4iexWVlNNGuNXwIwfNy9L2Sk0+SQOVuAWQLfxreC3pZB
         DvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780009; x=1788384809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sIs19yA05E5+D5bvhm1516uSg4N0iBHK8YfCkpxX2Cg=;
        b=RjYiXYJNMw1vWcR8jy4o2xn5h5dQIOIz9qBCB5tdOoyDC4ZE7cS49XnmyXodrzRNwn
         DvvnmWnBxIcDr/JhhICilQNyzG1tJZjbz7nisJTglfCilLkXD8Nzmlpxw9qOAR1zimAd
         0mYu+S/fr7x7FB1wW0p1u2CfmuCNgsXgcVDFgfTLVUdhJSH1mBz5ueSfo+GLoV+i/dEk
         +FW2Aod+9edraiDWC7v1yJ1TIZyutXU3u9EPQWb3q5d2RmvyWLLSPYkDEbSSMVYyWT3p
         MmHPS24Uwl+b7adNCOpRSGK3LDNt6SYS0xTmzMtlCDHtLv8SnZiM89nLR52QFiu/G8Ue
         3+hA==
X-Gm-Message-State: AFuF++l5J6cRUeEd7VdCi8yNWObaFMQu6t0shM4Ti7IHKd8wT2uBaHZQ
	B2w7w4h99rULUsFkWmDp97zwf9061DrWguK3UPZH08X/nVWhENanqVddTgXPj/P9bzLMR6L/m6E
	nSGF/yQ==
X-Received: from pghu17.prod.google.com ([2002:a63:ef11:0:b0:c82:a5b0:d9f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e18b:b0:3be:b0b3:3962
 with SMTP id adf61e73a8af0-3cf83f36b8amr21369888637.9.1787780008574; Wed, 26
 Aug 2026 14:33:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:33:01 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-22-seanjc@google.com>
Subject: [PATCH v10 21/21] KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC
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
index 0352bd147c40..34eadc75fee4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1383,82 +1383,6 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 
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
@@ -1525,11 +1449,14 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
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
2.55.0.887.g758fc8c411-goog

