Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D4459AFB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886783; cv=none; b=nzxkAOcSYsprV9ljp29iveZ8uGAED4YS4Vc4VKmODUzEtf5dj7fOGmT3KCcwWIfs4Tu9TWXjS/hWNCwpD1ho0UMps5dSlvNes5bvwsFz/CqBhb2ia9v29VK143jfRLJq6XgutbgUCQkD1s4q/W1PIAJ7yFVQ9SP3E5N1TPvIhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886783; c=relaxed/simple;
	bh=OYDmse612vK5d4FLIG9srer7eR53sZ5xbP2KgtPnjDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ES5YB3mkXswJUL5wdDBnMreF6SfRI3gE55tNCybSGLP7N4DPSgWYF8HCE+IvWy27rnOurLZLMGi8444oZ91qU/spFRL3gaGx7cu083tVmUn+kkxGmzrYrY9TjTh18g1RVXDXLy6P7F2ZjgJgi8OvEP3iHMmYbZ+lMuoi0QQCBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDw8Fwfz; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDw8Fwfz"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2caf4173b1cso6408975ad.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886781; x=1786491581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=igGRF22UKQuGN63OKPz0N85SiBZ0lp1Jo/7y+mQANeQ=;
        b=WDw8Fwfzm4B8zTJ1QBhQW9mVf6K+tFSaD6GeAUsocMviZg0Zij1k3lqvaWmAuWK8+o
         s+NTNP/49xF7nJUXcITMHnEHgczhB6T77GQH5mZBxX2xp6aMzl5PRN8b3/gHd77NUdxk
         v/sRdeKcEt+PcYfSOlSDWifZwBfvaOlfSQAFKK662+wY8nIfDQBeYDlBR7GPEIGrckyl
         MVp94NXCXbsvMjJdk2SZa/MUBCneIRM4EWIlLidI6swR2jit4doAr/5Bck4JzuhnieaM
         ovkB16nzUnQgeQdEdz5/sYLxLTPgHja3Frui97mjpdb+a1KIRakit3Fu0XmbenkZHIHU
         YPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886781; x=1786491581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=igGRF22UKQuGN63OKPz0N85SiBZ0lp1Jo/7y+mQANeQ=;
        b=PbclZAyC0/sdGzyN0l94aI4iZuBBYa6LiQ0z+jQUk96vMIDIznKUm49yFIfUnqlFt3
         W9UMqS2+WzBQ0yhoGu83re/Gg0MpF5+dhiNEMA0QAjDX9gDbzT3B1GpptFvQztV6Ze1h
         KUwGVwcuXDQQ+cggZG/CF2ZsjDtxstDvZ08cb3RaPiyQOBNgozs/yakBn+Ww9wX3BECE
         GspfcDIrTPVQFUOK30QrPnQ935gNGy7YyIKy00jwoSJzUMN3NizDQpzET81BYq//2Be5
         f7o+5QnwUn9IB2DvhbEdbdJH5g8Ic1sB3p06Ti0mRyC1RxcohvEEMIrqv59nWZ80eks6
         r43g==
X-Gm-Message-State: AOJu0YwjXGcaxr/l5QEfJLxdZpekChNppxy3OEq/tm30U3VfZ8+ousT2
	EV13DFLiRAmHKQA3yvDaJo8E1CcKRxZZS9JFwQ69FeSWKqzOixHA6aAdhGGAAdR3Warop1Sripe
	zmO4JnA==
X-Received: from plnx14.prod.google.com ([2002:a17:902:820e:b0:2c7:ec09:a994])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58e:b0:2c7:1200:bd7e
 with SMTP id d9443c01a7336-2d0ca9838ebmr28241965ad.18.1785886781179; Tue, 04
 Aug 2026 16:39:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:17 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-14-seanjc@google.com>
Subject: [PATCH v8 13/17] KVM: x86: Disable preemption, not IRQs, when getting
 TSC+freq pair
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
index 5667cd17672b..63702be799cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1797,7 +1797,6 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags;
 	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
@@ -1822,11 +1821,14 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
@@ -1861,7 +1863,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	 */
 	vcpu->last_guest_tsc = tsc_timestamp;
 
-	local_irq_restore(flags);
+	preempt_enable();
 
 	/* With all the info we got, fill in the values */
 
-- 
2.55.0.571.g244d577d93-goog

