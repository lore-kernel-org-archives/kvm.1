Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6E400E09
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402527; cv=none; b=jFLCOgdFXw8D9D/1NKx+KFDEbnJngXArXAznlAUS7yFfZfvBva16lSN++SVBenbq5xQuwhTMKqLwpHmsrJjcfy4lE+wteHvlzT5oDsZc8LJ/FQ+HeU+jCIjqAbDk7E4S5ZSvDxd16KtD7N/xqz++4c53pmXGcZhJWhXIwrtDM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402527; c=relaxed/simple;
	bh=yKoRdd0ffDUIImrM0joXcBmfrgPbp8a27fsII5ey2UE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qocZesKrn39BxgEdeUrzqtjWMh3GWmzLNMcS6vcco1og+fehGNpH2fcQvVDYY8frLnM1VXmJXKuaWqp8LMHxrNKWWrdxg3FHexhgwvZbIp0Cv2yvPbn4BkmgWTOUIcett+kg3yY9TaGL8qUFBzfkNP5EYLm9v2dqYIWiORqIqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSpvhZBH; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSpvhZBH"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d04908139bso49174615ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402521; x=1787007321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BfExY4RN+PjphJCfLm9GzDgD+ifrz78cA738SdvwwXQ=;
        b=NSpvhZBHxonLBC2okr6pdj7/hZ/UdcEnDgua27usE396E7ev2nOp0KHGc+2BdxNnKD
         O7PaNaP+uipnXlxCSI1vC6pXRd7STE+Bi0dmn/NeYddhleTPRUYbMDA5dmXGBSuYAHWB
         /gqM2PjF0RqdieN4eAc/b5bzkVEsKJTFYsilRaICbxTjgWhUyFcvpT+4VI6Iq4Lov6/z
         eZBU9oUjKb0pc6yBUQHypV7fLXeB9ZrPMMKENOWEGvn5udbydnWpcRfi9egaWsjlabUi
         53FvrP14gGmqAueWDiwg5ZBkZxacIYXoxiDBif9IoMRh7Bbxsm6IYg0fT/E4gp26Ws4N
         6QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402521; x=1787007321;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BfExY4RN+PjphJCfLm9GzDgD+ifrz78cA738SdvwwXQ=;
        b=sh9JldrvJh1FCtsbDvArMQ+Ont5dYLJ39aJWBNHqduklykqxDbI5f9XXNSrCakXEmY
         PLDCWMyU9BCvL5qR/bAHOvwz7AvXGy33oKrdAOZJ8wg21j2cfkNSQqbXwkt+xgD2wkng
         r0jnjL8JuM1TLneSNSbqiv8Z1NxQHLQAb7XzGddfpTTtASqeykX02kpL9Pv8cPRGuYlx
         WzCeLUclG0BEftEuK3mnLerX3qF4KCtRVWLoucdDzobPpA7fzkkxpTOcs9XYEpWH1P1D
         VgTQXyU7lTdzsEDeZFvmmYdcShEK6OxtlPFKGj9jLbYeKajlQ585KEMOky0Y/vjSOkKz
         8oow==
X-Gm-Message-State: AOJu0YwkHiX5J+PsxFPUNmChzQwIoCTtkyoY65aQOvXWzahDZys8yCKb
	0uSPkRV5ygoWZpGSh5q36HcYPcEzK7uE/nkSnbBs1wrh2VvwPgl23icsntRiSw317Bd4C4WTXsl
	mjVaJdQ==
X-Received: from plko2.prod.google.com ([2002:a17:902:6b02:b0:2cf:6c53:48ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1746:b0:2cf:afe8:b722
 with SMTP id d9443c01a7336-2d0ca761e0amr525739405ad.11.1786402520391; Mon, 10
 Aug 2026 15:55:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:52 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-15-seanjc@google.com>
Subject: [PATCH v9 14/21] KVM: x86: Disable preemption, not IRQs, when getting
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
index 76c16a15f059..a8dde1d898fb 100644
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
2.55.0.679.g6767b8d81c-goog

