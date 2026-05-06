Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFA3112AB
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098229; cv=pass; b=Khz/VasjZh5NmfFp85iZTuMsYyG0q+cdToIBeqPEEBpr6OBTgD6JzhTG0tKcRhoe2Ox4Hs7yCZ49jg0E0nyiaXWEY197JFEdP7unGUuGc1H7wFkviM7p8gGynWgjlnSzoZjcy11/jrDaQ6lRl4KmhFCmtcCiW6cEmFJyj/QBp78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098229; c=relaxed/simple;
	bh=HXKxVpwqN7WG/qt6E3Mt0H4t0VCTcxfdXh/LdUJM/co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX1em/DMu1ZKZciTJ3OQlVN2uFLwt2noXcV7CfKxgRitx4Zykgu3dzKG1HSSPuIvpVLMMD4BReUwKMcJr/rOwwVf4rP5rogcxeJRLs8kp2ho5sJYi55Zk+LImTKv8YlDv/OLFNcrtr0fvjrhnGaDwkRGeNE2URvWOi8YbGIJS78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=T0o3liIB; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="T0o3liIB"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1305908ae11so339223c88.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 13:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778098227; cv=none;
        d=google.com; s=arc-20240605;
        b=QbUlBXQ9fKnu9PzSOX4IAS3XdiuuXSloJ9/QzcDq0coK6/IdzxdW3uCqy9m4tUoie4
         0xOM96j1Had382lvhWjh0PQwaK1va7v+hrysYB9+xrKiUoKJ3wKyL02ijjLBkO8lTLmK
         bSNS29TAOggKvAogi7FypQZ6HZE4fWSTqBdw+SVjxt5Y1fyhsFpvPmYE8VLOEV1x77OY
         p4jDzubl52UIbZhMimiX4iqtUM9uEjtbgruZGi/fDA2lSxLPo5muazMSgs0933or0fnN
         XsRxvH2JL2GoUvX0+YnDAjCsKtBxX8D6ZZpzz2Xo/XUoWDYqu6Vai7xI+MmsBNPPYrhm
         NIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cex/wPONhORPzEJK5JdKCAXF7D3lemFyzWukLVzQsQI=;
        fh=e8j8Mz5BQh0Vpc2NhJwXsyyDRnUTRETPq2XZZQZg9qc=;
        b=VHTmugfQ8IlJnsY8Pg77rXImI/Zhl368cH+NA0bp8xFkoSE5FVoIUlt+1B8fFiiYDI
         tC1KqnI/p8K1EC+h3psocJDwW4dYyH+Dl95U5OCsRHRY1sjKqF24U03Eb0Ao+TV4GxtJ
         7de6+mlv7f+TwlxQrXgDmhg9fXByYODhFeNa5GMnAisnrpomp03I2R5silCmrHHKCxEj
         BWcygPcVqKZ0gRhnPGm9BGhGHxA53u6wCTShQRR6d13PDXc6SVVG/9019/NGv2B+WSM5
         scikSZuemtZyQ7g5bpdwJupL57EYkOJ4qYlQ4zo0dJFnU+LRuAh4GrtQ8aeQGOmFVDJq
         R4pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1778098227; x=1778703027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cex/wPONhORPzEJK5JdKCAXF7D3lemFyzWukLVzQsQI=;
        b=T0o3liIBTnd/oKPV1lsiPZvgGqmcaojlJq32QOHFEGiIFj/jOm5zwIIlr1B4SjNr6O
         RNrQeXXr4H3MPMeIKPUd0aEKGONVsyXhdSgTNQ5kMm4J26j9+ehq9rcyaq3LdKsTPPd3
         sBNaSgNS3s2CRhuyNm+Wg2PmQBHNOxDSUA/w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098227; x=1778703027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cex/wPONhORPzEJK5JdKCAXF7D3lemFyzWukLVzQsQI=;
        b=q02tUw5bKHyQ88yPD/h+kHpKOgHjkF2JCaNc1haSz6TvqPD42r0RJ+ktco6CvoctEx
         ZFyJHZQ9s8Ez4u5cGAJiMzWkk5WqT7U4nbUJemwbhgvCDgTMLzihTqU0pKDg4qaoLjjb
         vYnZjaL6W2iAMdjdpFjB3JOjciP/I3QrriQrM9coSaj+Pa1H9xCG2F2TfqW2j9lIooEr
         4/hYbge3eePFAzeYTbretUc925jP7oiPilngAfbva6R3Zi5NyjSyBRuxOkvUXLgUIVGZ
         eTwa6OWVXBoxEC9QUICr+nf0j22Vqpvrd+tIsAQp6dZAv78phEciZRPo0HQH1KVC/rwz
         tc9g==
X-Forwarded-Encrypted: i=1; AFNElJ+S/A/yHZBFvewi5O37fEMvJ5SylEyw2diBOjcqWNM4YEFYSbHDNWL/le1j0CWWIR+WkDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQFhqkgzbsJnd5C+wSS36Q6wVq54clvTy0upaY0MRkf28hRuf
	ufqBnjT+WUhz447TuIRGNphnQSd3hebpCXSVaA854SGlIbA/l8MDgyyw+kpMPbRlnTG7FAJYGMt
	wNg8yPd+AtYYiggm5/baWvLT4R54pYLUbLEBnQOvzvp77QH6Kn/Vg7tig
X-Gm-Gg: AeBDietXslHArx2CxS1pAotKXfhU8TO5/7ZgarR3qF1cyNoqVXfg8cSUIk0nraaa+Jd
	X+4YkGa7gg5p2UlYdkQypOjJRaO5hEZIh8VhrmJr+6gkxf4Al+OcrayzjhTU4dFpWZMvWJk/eQq
	fiirJCdsIAte9EG0DWuHV2VYp1bU3a34IuoRzJnxIPV880PkTnDT7mBBOV0aAy0cWW660h3Xs1M
	WUMvXJJfBhx2eY6WZrD2/VP5dDGYopgrHUMGMiroXYT8nyTkxcVfBeWYzA00FxhXb9aMkCfmJqt
	Hj2Emk018dTW802Uds6HdcWhrxLxLQ==
X-Received: by 2002:a05:7022:6087:b0:130:a519:9b53 with SMTP id
 a92af1059eb24-1318ea2b2f6mr2577620c88.31.1778098227235; Wed, 06 May 2026
 13:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
In-Reply-To: <20260409142226.2581-1-lei.chen@smartx.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 6 May 2026 22:10:00 +0200
X-Gm-Features: AVHnY4I4G65hMxzlloJnhKnGaAdz1z-s9U-A27PpkSeeZ6is43q4IBS_5oJDNAk
Message-ID: <CAK8fFZ7-eTzMtjYTB+R9FcdaQ45o9JS+GRYz1HjxnS=B_hC_HQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
To: Lei Chen <lei.chen@smartx.com>
Cc: seanjc@google.com, igor@gooddata.com, jan.cipa@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"

>
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
> CHANGELOG:
> v2:
> - remove comment of kvmclock_update_rs
> - make sure kvm_arch_vcpu_load make KVM_REQ_CLOCK_UPDATE for this vcpu
> - add RATELIMIT_MSG_ON_RELEASE to kvmclock_update_rs
>
> v1:
> - initial version(https://lore.kernel.org/all/20260407070046.2336-1-lei.chen@smartx.com/)
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5a3bfa293e8b..5e750c49d21e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1453,6 +1453,7 @@ struct kvm_arch {
>         bool use_master_clock;
>         u64 master_kernel_ns;
>         u64 master_cycle_now;
> +       struct ratelimit_state kvmclock_update_rs;
>
>  #ifdef CONFIG_KVM_HYPERV
>         struct kvm_hv hyperv;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 63afdb6bb078..a534e8391611 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5210,8 +5210,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>                  * On a host with synchronized TSC, there is no need to update
>                  * kvmclock on vcpu->cpu migration
>                  */
> -               if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
> -                       kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> +               if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
> +                       if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
> +                               kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> +                       else
> +                               kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> +               }
> +
>                 if (vcpu->cpu != cpu)
>                         kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
>                 vcpu->cpu = cpu;
> @@ -13189,6 +13194,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>         raw_spin_lock_init(&kvm->arch.tsc_write_lock);
>         mutex_init(&kvm->arch.apic_map_lock);
>         seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
> +       ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
> +       ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
>         kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
>
>         raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> --
> 2.51.0
>

Hi Lei, I tested the v2 patch on a Firecracker host running vanilla
kernel 7.0.3 with this patch applied, the IPI storm on vCPU load is
gone!
