Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395299;
	b=Z2ZKufFpd9q66HotGcpbnd79dYfthBv+2BKAJEorh4aILRfg5ZHx2mvuJUpej190E2RA
	 MR/XXZl+uQtHPyqDLr24J1MN0OyzCWFZbbLSAHm3j4k55dldldcHnfn+EgFWBs1uXXW9R
	 OumX75t3uxakBdhBKc4TQ2iXe0e6vgTwlZYR0RyNJJgkWpn5wab5BSyN0w8hnO2pH7E8d
	 4zpf4L1hqr2okZvq2gLDCl6ajpeNRwqAePVlYlQP5C061u4fQLU2drJRx8I6fPvxiW7sF
	 74u+Iw6SJddkHC13XUzrYhpKzupNkhc7CkdVBbzuSX/YHsVsZQjiYzRu9ksY4/ojCkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
	b=BgzZRXsmsLhpY09qgrSuGGG3DnulS27XbMOJMM/bP6zaQRcLc41zJ3Fi3N6UF1aaN+cq
	 UhD+AfjNA6AjRhAXiC11HMdFgigMU2tWmTMW1U4uGdP9u8CKJbfWvpTMI1Z5ynMxxXk2a
	 VrE6qJR44uHJbTAbd/XK2AxHf0KuwPTOdt//iGI8RAoCS9QohRM0Dc6OrCiYrym6G6ulI
	 cVMLEd5M6FoMGNRsxWKDNstq9ORJrxqph6mMH9jZWJqfvInN0/yDwrO2IXSI04J3//a5U
	 pAAMyi8vMSgyV8iQRFHDxuXR/6GzSpcDwDF6IRbjSwPPdrjvLpxZLf2h5XadTVe2veg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="RQxehEg/";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8591606F744
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8591606F744
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RQxehEg/
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso1402253b3a.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395298; x=1794000098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
        b=RQxehEg/XWHFP9rTtr8cvtxUqkFzjkIGzaRovCJx1pqUuFcKs7CglKM65s7IcJJ4RL
         +9YtSRlU+MW+gr0G+GKRY1hae1zm2SMso8HidOJJZTbenUe1A6ZVAi1lXQE/9lB5Wi6J
         4Ot0xwnF9jx8A70DbF2QIsHNzX157MtO8jy2i1kX/2/0G4m/hfKioRWFSksizWrjdsAW
         RYFVQWtVeN12H/1fISegz09wQo1i2tIXWNJEai2wDrmV0YjWrGVI3oTGq817QJu9BRry
         X5MclJt5uBIhh9Q7IbUsFgV8W8bwNGkC68f35nz9upOHz5Q5ofC2quHMSoNTUvYxCG7G
         J1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395298; x=1794000098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8PE43LpzTPSR1zzdd4igy9DBsWKBaooNuQb+N+z+Bpc=;
        b=2wG8Ac2jR7GwAlq9IDWcZMSfIl+3C8xFZkvNpYeVEAIGkAwS5yD2isXYkgVrt/W9tE
         +MzWfjpYikRGbtDUXijgid0Puzn1Ln21TNVlHqcci6Wg/tswwHuWerTf6avFyEJ/Qvr9
         q4uAo888dj42+1Dw9ZhgqtlFObeuGnl1PbZv0/VuZ6vd3tLCBhPJLdNLsgZrtcvYG+0l
         0JETqdlXl0al7N0nJ0L81aBuibREXcDmwfJM5TeTIfhMC2jTGNzGGtyeqvEmyNYXYcoK
         qKvHfGvHoUundStz6OPgp4eJyvyz3OFWos9KFgE7UM/nKslrBeeWXNaUe0WnT8qruPjw
         zM4Q==
X-Forwarded-Encrypted: i=1; AKwUvByK1P9qD9utVxH5r9Y3fMJq3csNyZy+wsDmz9AgIDRgfHrqn0waU0JH9iUtFnScw22b7RU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAzdMDmWrgu01QY57RevjJaWA2YH6e2zc60T7NTUpp113RwGc/
	PegLk7RhHHPSZetfkJpzGPOHBlvm8yM0a8NsqA9EJCkQTH5fm1MQcs6wNZ+MXadmnwYFuVf96RX
	QKgFZww==
X-Received: from pfbjw38.prod.google.com ([2002:a05:6a00:92a6:b0:8a0:afff:6594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:600d:b0:892:e080:4ed8
 with SMTP id d2e1a72fcca58-8a9bd7dc8bfmr2989556b3a.47.1793395298189; Fri, 30
 Oct 2026 14:21:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:08 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-21-seanjc@google.com>
Subject: [PATCH v4 20/23] KVM: VMX: Explicitly remove dying vCPUs from the PI
 wakeup list
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly remove dying vCPUs that were blocking when the VM was released
from the Posted Interrupts wakeup list instead of very, very subtly relying
on the vcpu_load() in nested_vmx_free_vcpu() to take the vCPU off said list.
In addition to helping avoid future regressions, e.g. if an enterprising
developer were to optimize nested_vmx_free_vcpu() by bailing early if
"nested" is completely disabled, this will allow dropping the load+put pair
from nested_vmx_free_vcpu().

Provide a dedicated API to remove a vCPU from the wakeup list, i.e. don't
_completely_ abuse vt_vcpu_pi_load(), but do reuse the core logic for
updating the PID control word.  Using a CMPXCHG8B _should_ be unnecessary
as IRQ routing has already been torn down, i.e. no IRTEs should be pointing
at updating the PID, and there are obviously no other references to the VM
or vCPU, and so concurrently modifications of the PID should be impossible.
For the same reasons, updating the destination should also be unnecessary,
as nothing should ever send an IRQ.  However, relying on those assumptions
begs for WARNs to ensure they hold, along with fallback code to avoid the
worst case scenario, at which point trying to take advantage of the fact
that the PID is unreachable would be *more* complex than what is now
__vt_vcpu_pi_load(), not to mention KVM would have two paths to maintain.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 68 +++++++++++++++++++++-------------
 arch/x86/kvm/vmx/posted_intr.h |  1 +
 arch/x86/kvm/vmx/vmx.c         |  2 +
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..4406e344ae6a 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -56,35 +56,13 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 	return 0;
 }
 
-void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+static void __vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
-	unsigned long flags;
 	unsigned int dest;
 
-	/*
-	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
-	 * PI.SN up-to-date even if there is no assigned device or if APICv is
-	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
-	 */
-	if (!enable_apicv || !lapic_in_kernel(vcpu))
-		return;
-
-	/*
-	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
-	 * full update can be skipped as neither the vector nor the destination
-	 * needs to be changed.  Clear SN even if there is no assigned device,
-	 * again for simplicity.
-	 */
-	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
-		if (pi_test_and_clear_sn(pi_desc))
-			goto after_clear_sn;
-		return;
-	}
-
-	local_irq_save(flags);
+	guard(irqsave)();
 
 	/*
 	 * If the vCPU was waiting for wakeup, remove the vCPU from the wakeup
@@ -103,7 +81,7 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		raw_spin_lock(spinlock);
 		spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
-		list_del(&vt->pi_wakeup_list);
+		list_del(&to_vt(vcpu)->pi_wakeup_list);
 		spin_release(&spinlock->dep_map, _RET_IP_);
 		raw_spin_unlock(spinlock);
 	}
@@ -129,8 +107,33 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		new.nv = POSTED_INTR_VECTOR;
 	} while (pi_try_set_control(pi_desc, &old.control, new.control));
+}
 
-	local_irq_restore(flags);
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	/*
+	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
+	 * PI.SN up-to-date even if there is no assigned device or if APICv is
+	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
+	 */
+	if (!enable_apicv || !lapic_in_kernel(vcpu))
+		return;
+
+	/*
+	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
+	 * full update can be skipped as neither the vector nor the destination
+	 * needs to be changed.  Clear SN even if there is no assigned device,
+	 * again for simplicity.
+	 */
+	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
+		if (pi_test_and_clear_sn(pi_desc))
+			goto after_clear_sn;
+		return;
+	}
+
+	__vt_vcpu_pi_load(vcpu, cpu);
 
 after_clear_sn:
 
@@ -146,6 +149,19 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu)
+{
+	kvm_lockdep_assert_vcpu_is_unreachable(vcpu);
+
+	if (!enable_apicv || !lapic_in_kernel(vcpu) ||
+	    vcpu_to_pi_desc(vcpu)->nv != POSTED_INTR_WAKEUP_VECTOR)
+		return;
+
+	__vt_vcpu_pi_load(vcpu, get_cpu());
+
+	put_cpu();
+}
+
 static bool vt_can_use_vtd_pi(struct kvm *kvm)
 {
 	/*
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index c5860ea828ae..1d9ccbc2bb6f 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -10,6 +10,7 @@
 
 void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 292001bbcbff..1f9e43c5b4c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7514,6 +7514,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	vt_vcpu_pi_remove_from_wakeup_list(vcpu);
+
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
-- 
2.56.0.385.gac671c819a-goog

