Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF63DBA0
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584944; cv=none; b=FBydkEdt2tEy1wVrw75BoKcV766m2XzRXEvqGbMFu3wcN9zY4oZhqFcCzRO+FyKmQsC6MOc7Kgvp0+w49x002nHPvHUmVLXrUGr9f8hMEVDke89bjDvqNa66+HrhcQ0uIy0A1jKe401VLXkRNzWDhrhadACEgpSoWeW3+4kU6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584944; c=relaxed/simple;
	bh=e8vXW7Y6e24JG/dDv2Afuc7VMUvsKJwzxVWcCRaVj30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PSrIj4PpCE4/lkbfhLgOC6DCcDduL0jxqq61CBbrj+Z8orWY9N5o7w+dH2Xblbs8V4wOW71WLKiNM/EtZYErGnMAtZEAULyvG85EAV74io8DC0VVpNsJZ8miYwqd5OboicBZevSSFihcCBesHawwNle7cXLdz5q3Y5Lr0lah3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0XH4RDJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0XH4RDJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cf084fe58so3029779b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775584943; x=1776189743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33IQLaYhd9gH09mUphehivsAyB9ydv2uE+uInVVNmNg=;
        b=O0XH4RDJO30+lK9hiFeCYWv359Bup84pWM5hdOCyAlf5mKcFeZJE9SNoVf9OplKIuv
         DCELD6vs6J9ClnHenXuvAR2lMzHeYUrzy+2ADOJsZHpxWUz0EscEhBVlWHm6wFWS360f
         udHj4GngVz+QXCMoM7mowwvCvl/FA38Ib5V9fz22RgWxXlX13T7UyYD6eXWd4JoFI28o
         qOLmaEx6/qWBHsOgb/1fEUV+v7Dnsx3EOMxF9ebPcJZSG9ykjdcv4bfewwMfvVtpX7+8
         OUNtMNH6wCAlwEPm+BcX6dLUwVcb+71N+8vjGdb3058rEmbmQ5ZNNwrFDwZTfpGGfim3
         aCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584943; x=1776189743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33IQLaYhd9gH09mUphehivsAyB9ydv2uE+uInVVNmNg=;
        b=dDG93ndxeB9kENHX+9L2CHIE/LQLQTOLIYAhKLZRMbvndItBgxdGJyFMllGBcpdyra
         CsubIJRwZUSbDpfYPUWwDPmeh8ROCyLpiJYYb7yHuEArcHzBQnGkevlJV3Rkh6906of3
         9rkrL96zgalsuRzF7jrkOQLBcH25BwFAshL4qOuEK9hvtUHszWtPlbvw3YRzmsCjmz0Q
         sDpU3utnyqqF+yIrQvm16m9QTqm6r9atusSI0QNfyWf+kRzwJGmwBdTRDwr9dSQ6UBju
         4xRCKB0grdShNlhlkFYSgYdIQVmx/LIBFFvprMlk7alP7KcVpFtMifSHF0HfOazI4IZH
         UW4g==
X-Forwarded-Encrypted: i=1; AJvYcCVr+x/sPcS0wOuY5z/zkoqbMDqUXToCTNK3h95MVLXevO1VkCt8GXXwLsKLwQDX8MOZC1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqmzTjdBJ2uVmg5L3jkzVp5T/7H8WbgqFBK57EdmmKn+12L6D
	3lbh4oN0bf8eFc63Zn6du7sdQgHSg/TZOiap/UZcW9+HCEu/zQ0qRaepoonAxiRguICUETQPHmh
	jOeLlAw==
X-Received: from pfr1.prod.google.com ([2002:a05:6a00:94c1:b0:82c:9c4b:469f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178e:b0:827:455b:86b1
 with SMTP id d2e1a72fcca58-82d0db693cemr17737395b3a.28.1775584942426; Tue, 07
 Apr 2026 11:02:22 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:02:20 -0700
In-Reply-To: <20260407070046.2336-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ac2LI_UPPrf45vmp@google.com> <20260407070046.2336-1-lei.chen@smartx.com>
Message-ID: <adVGrJaRlRooO4su@google.com>
Subject: Re: [PATCH v1] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Lei Chen wrote:
> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> 
> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> every time a vCPU is scheduled when the master clock is disabled or when
> the vCPU is loaded for the first time.
> 
> Restore the throttling with a per-VM ratelimit state and gate
> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> scheduling does not generate a steady stream of redundant clock update
> requests.
> 
> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> ---
>  arch/x86/include/asm/kvm_host.h | 2 ++
>  arch/x86/kvm/x86.c              | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5a3bfa293e8b..6d3d3f19af01 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1453,6 +1453,8 @@ struct kvm_arch {
>  	bool use_master_clock;
>  	u64 master_kernel_ns;
>  	u64 master_cycle_now;
> +	/* how often to make KVM_REQ_GLOBAL_CLOCK_UPDATE on vcpu sched*/

Eh, I would just omit this comment.  If we want to document the ratelimit,
the function comment above kvm_gen_kvmclock_update() is the best place for it.

> +	struct ratelimit_state kvmclock_update_rs;
>  
>  #ifdef CONFIG_KVM_HYPERV
>  	struct kvm_hv hyperv;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 63afdb6bb078..4a37027cc0b8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5211,7 +5211,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  		 * kvmclock on vcpu->cpu migration
>  		 */
>  		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
> -			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> +			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
> +				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);

To maintain pre-revert compatibility, where KVM did this:

	kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
	schedule_delayed_work(&kvm->arch.kvmclock_update_work,
			      KVMCLOCK_UPDATE_DELAY);


the ratelimit should be on blasting KVM_REQ_CLOCK_UPDATE to *all* vCPUs, but KVM
should still trigger KVM_REQ_CLOCK_UPDATE on the initiating vCPU so that the
immediate update goes through.

That will also apply the ratelimiting to kvm_write_system_time(), though if a
guest is changing system time that fast, it probably has other issues :-)

Completely untested, but this?

---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..f14009f25a3b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1504,6 +1504,7 @@ struct kvm_arch {
 	bool use_master_clock;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
+	struct ratelimit_state kvmclock_update_rs;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..5dc33f207a83 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3522,16 +3522,12 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
  * The worst case for a remote vcpu to update its kvmclock
  * is then bounded by maximum nohz sleep latency.
  */
-static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
+static void kvm_gen_kvmclock_update(struct kvm_vcpu *vcpu)
 {
-	unsigned long i;
-	struct kvm_vcpu *vcpu;
-	struct kvm *kvm = v->kvm;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	else
+		kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_CLOCK_UPDATE);
 }
 
 /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
@@ -13366,6 +13362,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
 	mutex_init(&kvm->arch.apic_map_lock);
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
+	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);

base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
-- 
