Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96843D4F4
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886775; cv=none; b=tB6K1AgmFLhSwZ5UlBzxJqutgsH3jTwXS2aMH8KZTVr+QxRFLEzDXfONYtmv4QvE8Pk0stxSuTisp6oUXDHA7cE9njC9aq0ACkpe0s+iPlW7Q+Qn/FScQYdZmZkbW2+OSobCDkg0dSg2hz2Wlv5JRPnc1WDw4fDZXnt7i5wB0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886775; c=relaxed/simple;
	bh=bxCylr4HiPO9zwqBqEHUaooi53GWIYbqRZaq07brKjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2Ox8JmlzuXYtT8WhluR6nMbE/efuoKBWDjRSuffcQkFvNdGSMj66jqLP5ZS3t1i8huSdqSgZo+BcVvF6UNpS4Nw2F8ddxoGNjG1nDC5TkyRFTema0qjMYlUniy3VhCySPB4RATwfCLIcEGPOh2HiItHM0XA0WNTP7KWofPXhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5RXEdoB; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5RXEdoB"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so349816a12.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886773; x=1786491573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5KEhdOkBgt8kZo6v75UUHaCXwdu0mISEpkcWN+SxXyQ=;
        b=W5RXEdoBiytjRahh7bmbnWZit5544wpYN6crUVZv9nhGzoqGPGbEzJeyJf6ZeE9jjC
         V+Q+pluD8JKoGyTrU6DRDjzwsaXsttlCmj13yCfSou1OUOvgA4u1MC6OZUR7Bwu2kg+0
         RKC+JUfRdm620aFM61yXpOxdCfbNr60FFzj6GjZZT6XvRlZm7ZJwIwZ20KEJiRP/ctGu
         XRot9eRqGMyqCk2Z17dwX7LledL4EWO04OIq1G/3pHRSqUaiag8OyTMMeWXhqcvR/K55
         El8jChWc9OjEufgK4jeMGpsZIV3GRQNio1RA3JoB92Hg9kVJqPl4XlB93bfwltGzvCN/
         faCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886773; x=1786491573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5KEhdOkBgt8kZo6v75UUHaCXwdu0mISEpkcWN+SxXyQ=;
        b=AE58YBV7hhgqlk7lmsoVtFAUft7Zu2PmmXMbqYbv28apFJtO/g/AAfJXDPbUGEySYr
         nXVd2U569Kuu46mNY2Q6rbKdk1HZPklp9feyiU89YYfTVn/KbDPr3E2OIE/jJfF7dds9
         XlQiC81iM1pz0E6Ng5iT8Csgl7WLzfkSq3YjtfJAmAC3MN/em6aqyb4pfkOGGHSJpr87
         6N/N5nFlvTycuG68L+ChRzHv3ZSa+yYl1PiiAXDlx1fI5ZCKoJM/QsMy4pBAF9ZSC+gc
         28sHzgK4ynfjgf/rbbyRx9/d95doaUwjVzJPBL7xzpBiisbfrKZN11r2D+5T+kiNhw/k
         VVJw==
X-Gm-Message-State: AOJu0YwIFKMndiTjyrbzr0025wf2KY7ojni1zuqc5WLHZ095wBBjBLHm
	Op8saoxUh/pzG5KmjI+tSNXnj14LD+Fw2uTtr9QUl0E1bdeGySP+nKQiTdas8NU40d9bDL/dsyL
	HWlDlTw==
X-Received: from pgbl10.prod.google.com ([2002:a63:570a:0:b0:c8f:d0d0:d863])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6112:b0:3c3:b628:6d17
 with SMTP id adf61e73a8af0-3cb85e7f1bdmr2532242637.25.1785886772956; Tue, 04
 Aug 2026 16:39:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:10 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-7-seanjc@google.com>
Subject: [PATCH v8 06/17] KVM: x86: Drop unnecessary CPU pinning when
 computing/getting kvmclock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

When computing the current kvmclock value, don't pin the task to the
current CPU for the entire duration of the master clock path, as the
CPU pinning was never about ensuring rdtsc() and cpu_tsc_khz would
agree.  As pointed out by David, ka->use_master_clock can only be true
when the host clocksource is TSC based, which in turn requires a stable,
constant and synchronised TSC across all CPUs.

The CPU pinning was added in commit e2c2206a1899 ("KVM: x86: Fix potential
preemption when get the current kvmclock timestamp") purely in response to
a CONFIG_DEBUG_PREEMPT=y bug due.  Despite what the comment would suggest,
including rdtsc() in the {get,put}_cpu() section was opportunistic.  In
fact, Paolo even said exactly that when suggesting that KVM guarantee the
rdtsc() would execute on the same CPU[*].

 : Also, rdtsc() should really be on the same CPU as __this_cpu_read.  We
 : know it's not really really necessary because the master clock is
 : active, but since we need a get_cpu/put_cpu pair, better be clean.

Nothing has changed in the last ~9 years, i.e. the rdtsc() still *should*
be on the same CPU, but super strictly speaking, all will be fine if the
task is migrated between grabbing the frequency and doing rdtsc().
Dropping the CPU pinning will allow dropping the rdtsc() entirely without
having to resort to a large "rewrite get_kvmclock()" patch.

Opportunistically add a comment to explain why KVM needs to snapshot the
frequency, because that _is_ a hard requirement to avoid reintroducing the
bug fixed by commit e70b57a6ce4e ("KVM: X86: Fix softlockup when get the
current kvmclock")

Link: https://lore.kernel.org/all/ae8de642-8f14-a70a-1fab-57e2c4093cd5@redhat.com [*]
Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f60f4826db1a..0c0bf4c14bc5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1655,13 +1655,18 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	u64 tsc_hz;
 
-	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
+	/*
+	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
+	 * zeros the per-CPU value when a CPU is going offline.
+	 */
 	get_cpu();
+	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+	put_cpu();
 
 	data->flags = 0;
-	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+	if (ka->use_master_clock && tsc_hz) {
 #ifdef CONFIG_X86_64
 		struct timespec64 ts;
 
@@ -1675,15 +1680,13 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 		data->flags |= KVM_CLOCK_TSC_STABLE;
 		hv_clock.tsc_timestamp = ka->master_cycle_now;
 		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+		kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
 				   &hv_clock.tsc_shift,
 				   &hv_clock.tsc_to_system_mul);
 		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	} else {
 		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	}
-
-	put_cpu();
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-- 
2.55.0.571.g244d577d93-goog

