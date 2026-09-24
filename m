Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601044065A
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261746; cv=none; b=lgWYPM4090ubmT8axHCdY/lubskTI/Jl3tK+aEHTO9v7l/tXZbGNOdis4ySBV37McyWTFRSfPTFJ1z86/QfajQcog+pwGrBo+sBff7DFWHiozrXKU6zUKDrrqE31w2pkmDkb/uXHZkPXoM+Pqul+NUFLuLlFuHMWJXr6C2uAHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261746; c=relaxed/simple;
	bh=b5V5cIZLU8hlEyl9xnRq6vDvMkK3WNR9AD+lAL6zb7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OFHq1CCkMGBFSYrQzG31zFqjEECVh73z2oun976nsn1M/BWdpsWsKp40IbiOoYrBtSwj8jfpnl0fNxAl6nkRAvJK9Ve5OtvOK9eLkwhiyqLgy5drKVIpriNhqPbkX1BtUold1vCE5XBdjBKZKqTYGNJ7d4yw71EPXzMiQqa5S0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxOdxZ0b; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxOdxZ0b"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso22058975ad.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261744; x=1790866544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJA6+TyaqV1MSLc4kyfe+npiP/DQmyuJ2EVEHCwB3Gc=;
        b=bxOdxZ0bNqDIjcfJ+O1thU9G4XuwLcnsby+I544PCpChkBYvw7XsiIwjPvOJB9MGKw
         CSUcaUEnv270/XxLEWbxTZFbE7lkI7QVQuflgcljql+X4xWHUA9nSfQHVhQ51qDUVWSh
         ivb9qiIF3eGReqaL6HD2EAJEAd8+eahCwj/SITHFL4R4D0bdYLwj9zjSf3TDCOh6fsDS
         gXL0n3n+9Ljsw5pBwITjxCrgwraKh59kbM0I0UaJzMCfQ9yY0O5+X0D8rRm6s+glqhXG
         qvUutqXxq612VzvY+cg7LqVrSjd8uhvoAdlB/VaMH8qGpRs1Bgv53Z/vEA0KT8VYX9v3
         Kvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261744; x=1790866544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJA6+TyaqV1MSLc4kyfe+npiP/DQmyuJ2EVEHCwB3Gc=;
        b=Dg23tqtwIZIGXp1kO35G+NNrxVC1vCWip5CQ4eFAOtb4T5p81E8ph2qtOz1t8Ps6AB
         YMkl2uQb8mVZicMoL8qITPyJ7CKgeD3tZiQqNFZYaZ/sB6aU//42kPUKvelIkcN/MlOX
         gcPT5A5Mt3jkECaS+itWGP+LcCbC72A7fB3Qa9sBky2qp0kT4uX+B3/jwaYlf4MbOz0L
         FrMhbdplzKnD4I34vmeVyHAy9cNJD2RW4/uuHnkmn6/rMQ1QE92EBUKhdgZq4D4jXO7p
         fExiPH0S8TFv/HP/Q+LwYXrRZLgLg0Ig+s0ZA+v8q1Xl58JbjdevPQDxYtaKzf2rhHCz
         mxuA==
X-Forwarded-Encrypted: i=1; AKwUvBwUI7vOLnfKf1Dw7hHr1EYsFIIeE65dGqrh8SruD2hcVJkP4C57g81KwQCdgxIZkA4VEYY=@vger.kernel.org
X-Gm-Message-State: AFuF++ko7RGey2UvFctWhXmZdmQNc6zpeO8vib5tKsFGeCRt0bObYDXu
	bCo+mJepRhFzv9HBgkfIsBnachq1fW1e0veNReSHwXgLRNmT1pW+hl54jfJODcCTFIjr0lpXJPo
	C1rlX9Q==
X-Received: from plqu20.prod.google.com ([2002:a17:902:a614:b0:2dd:c066:f654])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3804:b0:2dd:c100:424a
 with SMTP id d9443c01a7336-2df7e247c77mr22889315ad.46.1790261743478; Thu, 24
 Sep 2026 07:55:43 -0700 (PDT)
Date: Thu, 24 Sep 2026 07:55:42 -0700
In-Reply-To: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
Message-ID: <arU57oqykUfeKqv2@google.com>
Subject: Re: [PATCH] KVM: x86: Wake blocked vCPUs before offlining a CPU
From: Sean Christopherson <seanjc@google.com>
To: Jinmeng Zhou <jinmengzhou22@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, feng.wu@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jinmeng Zhou <zhoujinmeng@bytedance.com>, Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 24, 2026, Jinmeng Zhou wrote:
> Posted-interrupt wakeup state is tied to the physical CPU on which a vCPU
> blocks. CPU hotplug migrates sleeping tasks before KVM's CPU offline
> callback, but the vCPU remains on the old CPU's wakeup list and its posted
> interrupt descriptor still targets the old physical APIC.
> 
> If a device posts an interrupt after the old CPU becomes unavailable, the
> wakeup notification cannot make the blocked vCPU runnable. The vCPU cannot
> repair the stale notification destination because that happens only after
> the vCPU is scheduled back in.
> 
> Add an architecture hook to KVM's CPU offline path and a corresponding
> optional x86 vendor callback. After CPUHP_AP_SCHED_WAIT_EMPTY has migrated
> tasks away from the dying CPU, have VMX set KVM_REQ_UNBLOCK and wake every
> vCPU on that CPU's posted-interrupt wakeup list. The vCPUs then unblock on
> online CPUs and the existing load path rebuilds their wakeup-list and
> posted-interrupt destination state.
> 
> Fixes: bf9f6ac8d749 ("KVM: Update Posted-Interrupts Descriptor when vCPU is blocked")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

SoB chain is wrong.  Whoever sends the patch needs to come last.  And presumably
there's a missing "Co-developed-by: Guixiong Wei <weiguixiong@bytedance.com>".
The patch also needs a "From: Jinmeng Zhou <zhoujinmeng@bytedance.com>" since
you're using a different address to send the email.

> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 4a6d9a17da238..2d6cca1606bd1 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -266,6 +266,29 @@ void pi_wakeup_handler(void)
>  	raw_spin_unlock(spinlock);
>  }
>  
> +void pi_wakeup_cpu_offline(unsigned int cpu)
> +{
> +	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
> +	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
> +	struct vcpu_vt *vt;
> +	unsigned long flags;
> +
> +	/*
> +	 * CPUHP_AP_SCHED_WAIT_EMPTY has already migrated tasks away from the

IIUC, CPUHP_AP_SCHED_WAIT_EMPTY just waits for task migrations to complete,
CPUHP_AP_ACTIVE => sched_cpu_deactivate() is what actually initiates the migration.
That matters because I think it means we can repurpose CPUHP_AP_X86_KVM_CLK_ONLINE.

> +	 * dying CPU.  Force blocked vCPUs to leave the block loop so that their
> +	 * PI wakeup state is rebuilt on an online CPU before the old notification
> +	 * destination becomes unreachable.
> +	 */
> +	raw_spin_lock_irqsave(spinlock, flags);
> +	list_for_each_entry(vt, wakeup_list, pi_wakeup_list) {
> +		struct kvm_vcpu *vcpu = vt_to_vcpu(vt);
> +
> +		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);

Hrm, KVM_REQ_UNBLOCK is going to cause spurious wakeups for the vCPU.  That isn't
the end of the world, but it's definitely undesirable, especially since these
flows are shared with SUSPEND+RESUME.

If we attach to CPUHP_AP_X86_KVM_CLK_ONLINE, can we do a bare __kvm_vcpu_wake_up(),
so that the task (temporarily) wakes up and gets migrated to a new pCPU before this
pCPU goes down?

> +		kvm_vcpu_wake_up(vcpu);
> +	}
> +	raw_spin_unlock_irqrestore(spinlock, flags);
> +}
> +
>  void __init pi_init_cpu(int cpu)
>  {
>  	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
> diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
> index a4af39948cf04..41414c583a063 100644
> --- a/arch/x86/kvm/vmx/posted_intr.h
> +++ b/arch/x86/kvm/vmx/posted_intr.h
> @@ -11,6 +11,7 @@
>  void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
>  void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
>  void pi_wakeup_handler(void);
> +void pi_wakeup_cpu_offline(unsigned int cpu);
>  void __init pi_init_cpu(int cpu);
>  void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
>  bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..ea0ded5d64509 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9820,6 +9820,11 @@ void kvm_arch_disable_virtualization_cpu(void)
>  		__module_get(THIS_MODULE);
>  }
>  
> +void kvm_arch_prepare_cpu_offline(unsigned int cpu)

I don't love adding an arch hook for this, because CPUHP_AP_KVM_ONLINE is tied to
KVM_GENERIC_HARDWARE_ENABLING=y.  I think I'd rather turn CPUHP_AP_X86_KVM_CLK_ONLINE
into a slightly more generic CPUHP_AP_X86_KVM_ONLINE

> +{
> +	kvm_x86_call(prepare_cpu_offline)(cpu);

My vote for the names would just be "cpu_offline", i.e. no "prepare".
