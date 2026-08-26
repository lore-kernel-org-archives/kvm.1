Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42248A2B5
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780007; cv=none; b=m9pL+h3Am2MF3j11RzTSJPpO7I3GKchJUwBhRl/D55g9Zc+pdOUXgCscx1V5v28UJcHBGhrmwap6e1wyxT0huPfeoJkKsDL2lqG7VtjNWyNtETVoArOOzaao82SKXYvHPdW9TKScYAdUqgy9bmAqUCqbUP+PmIrUXpyUd90W/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780007; c=relaxed/simple;
	bh=hanmY8654Xv7t6haK0KTLVbsCwMesm0siIK+5YDQXZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mD9ZO8l3/l7KOkeWVhpBwz5SKu7jCsUf5V9V5yY3yCzAuYv2klY76zfDUsa25nmgA2VV1QnNQoGBDRiaOdzr0XatdbnWHdDXhAWkuREnCeB1BiDD289XWaISxjpcZUFlKIRexMUDt8jX20twQYd+oWcGEpsvrT6ipbNzOYHPIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qh95/L94; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qh95/L94"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e048a801dso2070284b3a.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780001; x=1788384801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bkUML0mp/Ew2O+uE+2q6c50/k7kk99NsNilvUx2h/vE=;
        b=Qh95/L94rBpDjK6nX7nhHZ6bjSMpOUSdzEMpzw7S/7bKaDwIq/OHOgaJsRwVobUvYW
         3IqUSVrsDatzJ6DDRTqJZSzPucC5ylMaoUPNVA7+jyKpw98hqVEy2OQRhRa8fao+RuUT
         ikJNhgKd05ty4pW6JtJINTo6E8XKqBDPTtX8x+Et5MmEy0TsFLXJfyuhH82K1yqwMQlb
         /3fwHGK4WrdZc+1DisbXD7irGTKhOlPERS2Jcbm5U38xbYqylBcOADXzjVtiOdwXpu1G
         +u3HfNnxh6YarX/U5wu/kKg3596zxq1SWMvze/wbOy4kRvvfgaisjmlR+lOXSE7VX9lK
         JUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780001; x=1788384801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bkUML0mp/Ew2O+uE+2q6c50/k7kk99NsNilvUx2h/vE=;
        b=hW0xDNisewJQq887fX9mu5L9oCKskGPqOJcG243vJDAAmHa3QqPm3R5WZmqMHz/nIO
         2/sMwYVmCAb/R21c1q+fvdKJ5Eo6HcNFK7Dk/ZUbqaRsr841kX3TgHBhCNfYPqhV3BTU
         KWFdiRcBx+SfqBj29hDcBJobk7xMYO310YTV7gzBdpyyMIHqCUAjyBLro3J8fKmTxwtX
         Zc8+tvzvjZDOGXAv34nT259OlKzUSNCXcx+mGG3SWRkg50WTlxbDM+515PAOnNnmWuP/
         IaHEjZjfE04OU+LVcr3dO2z/Lyi/0PYO5w7va3nxLZCia0uGh+4ebuhGgErPBxHtGUIN
         DapA==
X-Gm-Message-State: AFuF++mJyy/Sa6K18owYw5HEyMPrrPPZ3ZoRjquM1opM6YIkhoSJr341
	PQnRL50lYcyJ7l1nuPBoumPb2LFZ08IUHmme2nxkpmBoWUgvdCN8did3ptkFnbr0itdmmvYWi1w
	UGmNo0g==
X-Received: from pgcm9.prod.google.com ([2002:a63:7109:0:b0:c96:8ff3:53b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7287:b0:3cc:9620:5816
 with SMTP id adf61e73a8af0-3cf8282617dmr17682345637.8.1787780000771; Wed, 26
 Aug 2026 14:33:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:54 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-15-seanjc@google.com>
Subject: [PATCH v10 14/21] KVM: x86: Disable preemption, not IRQs, when
 getting TSC+freq pair
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Disable "just" preemption, not IRQs, when reading the TSC+frequency pair to
update guest time, as disabling IRQs to protect against task migration is
overkill (though it's *extremely* hard to see that it's overkill).

Disabling IRQs was added by commit 18068523d3a0 ("KVM: paravirtualized
clocksource: host part") before there was any coordination with timekeeping
(presumably disabling IRQs prevented the kernel from completing a software-
induced frequency change).

After the coordination and locking was added, commit c09664bb4418 ("KVM:
x86: fix deadlock in clock-in-progress request handling") moved the locking
and coordination out of IRQ protection, and thus made disabling IRQs
pointless, except for protecting get_cpu_tsc_khz().

And while cpu_tsc_khz is written only from IRQ context, and the *extremely*
confusing double IPIs sent by __kvmclock_cpufreq_notifier() to update the
per-CPU frequency make it seem like they would require readers to disable
IRQs, it is safe to read and consume cpu_tsc_khz (via get_cpu_tsc_khz())
with IRQs enabled.  The per-CPU variable is specifically written only in
IRQ context to ensure hotplugging a CPU wouldn't write cpu_tsc_khz with a
stale value (because apparently disabling IRQs would be too simple?!?).

As for the double IPIs in the frequency notifier, both IPIs are red
herrings.  The actual sequence that ensures KVM updates guest time with the
new frequency is that the first write is completed *before* the notifier
sets KVM_REQ_CLOCK_UPDATE for all vCPUs that last ran on the target pCPU.
The first write is done via IPI to adhere to the above rules, and the
second IPI is sent purely to kick any vCPU that happens to be running on
the target CPU out of the guest.  I.e. the second IPI writes cpu_tsc_khz
out of pure KVM laziness: it saves having to define another IPI callback.
In fact prior to commit 8cfdc0008542 ("KVM: x86: Make cpu_tsc_khz updates
use local CPU"), KVM did indeed use an empty callback to ack the IPI.  As
for why it was deemed cleaner to abuse tsc_khz_changed()...

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09435f153b5b..31fa3c941b49 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1799,7 +1799,6 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags;
 	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
@@ -1824,11 +1823,14 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 		}
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 
-	/* Keep irq disabled to prevent changes to the clock */
-	local_irq_save(flags);
+	/*
+	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
+	 * NOT using the master clock, the TSC frequency may vary between CPUs.
+	 */
+	preempt_disable();
 	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
 	if (unlikely(tgt_tsc_hz == 0)) {
-		local_irq_restore(flags);
+		preempt_enable();
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
 	}
@@ -1863,7 +1865,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	 */
 	vcpu->last_guest_tsc = tsc_timestamp;
 
-	local_irq_restore(flags);
+	preempt_enable();
 
 	/* With all the info we got, fill in the values */
 
-- 
2.55.0.887.g758fc8c411-goog

