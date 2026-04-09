Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F040DFA6
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739797; cv=pass; b=sntAYAdg2dNy1zCYM1J1WfylYzZWa3UXdnhz2G9LbCkn9s9wF78W8VV2UIxsmS7/+mDSPBkZcl5finDHgDbrDlQDpG9wf3m69qtc24zUkapSRXC+ZZsKwWtOVpQ6FfvJhPqguXZWlRqwCi0FWvyEv8uhyPALZLaT5tzZKuAN42E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739797; c=relaxed/simple;
	bh=TjdgwJDItfvcfsdrQxd0cKLXZLD34AImbnFsN1pOsC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJA2tmpbjf4c782/tvHa2HS4MwJG1Zcv795ydFEt/dDAVVk2h4v5Lm/ERFQ7UI1UihrImfTLGlG4VBTBzSlTAgwaerlYnJyC55tluJ/lpD2+jZ5iDFe3OvVDS43yz22G/AV7a4fVtvHczmNHQrGb6Im0MyHmUvIreCr2pKMmK18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=uFnu4ezb; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="uFnu4ezb"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38ce8a5bc20so8461361fa.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 06:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775739793; cv=none;
        d=google.com; s=arc-20240605;
        b=EDomsRW5+OKXGDdAxtRgYEY2f7CJIgl2SrZBVwv2IKv+19e3EX3XnYqTW48QDMRQFA
         E0gjqLmays6UjRytjN7qq10yG1Qk9jT7D8CVBKDwDMSGwpt8I+TJNP1q37b12b0cD/8f
         aRvFnPh+ZFKrtpvsql4vEOjpGvvPdhb/sHTw1h6CW62xnqsYe0Uz9BNvb40fdskuPsUm
         o+NefcsqiPPM7NbINb62jXT5ocCELRCftKBRmPby4ITlVQeUNAVlD4A5/LaKRDYqi5ab
         ZZRskayYGghj5zG3tlrIIZ3zVSVJX0fhvQzfxq5vUCpwV1Ks94RPOSxZTVUkSNSZjcaW
         W4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kHcyxl3C7uupMaUDTKWdH58eLzuFIe6+lDrkFmlLNMA=;
        fh=5NvXV3K09d6bYRpPBNb9SEClIjZjpYnG2ELbxqhBR4I=;
        b=Je+Uj0BbHq4HxPcJ1gBoJ1WgXicIx4aZIYqERAOqItVXU4YzJlXOmrRvmxvDqItOHt
         PTRmG6kFMtrrr9iSQVFUadGdHsFyLpMa6bsCjJ7PNtdPRHgIAli/v+jUNcQo0tEodTJB
         GxWeNxIeflLjKdD+qNztcMR4tnUpDNYJiTiYhwz98odNdu8AIV/ssit84kZkVZVVVwvf
         9re3ze0aF2cHz7IWWPu421CPC1KdXBKu13Qb3RiQDWphLuWdWpsqTlW3ak5xsWzpVa8U
         h6F3kJoe2CowLnvkGEGp+tDmsEjGDw4iHTqyFe4qUB9wudWuoswD5GPTbcW8Xvw8x3wD
         GDRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1775739793; x=1776344593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHcyxl3C7uupMaUDTKWdH58eLzuFIe6+lDrkFmlLNMA=;
        b=uFnu4ezb52kdaCwltMSlTYrxVF0s9mV4o6JGW3QThMtZssqganbnJZmpdZZt6x/xIF
         FgWalIarvjfTV+uebQaYt3mKJB2kkExdajXBpq94ZtFZLmaSnY9nvzmi864yCTHH73A/
         mSwji94yX4tguEDl3rO6Pl9Q7uzGYdbyRXg1wgm0adIzDziNpRwCGjnVJ2jSEpLBmFUF
         h8jm3/0DyTxQ2JcHBKH+fBue6ZJpmcQbtSRqu44f94i9PzvwjtJzqlYuq7PqYuWBWk1A
         PbLA5NBLPHQCLk7DeCZlh4Kg9GZeFlIQtauSvFsaWYqRD9IZnzSWmCPRWYeNsaetW8mP
         9Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739793; x=1776344593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHcyxl3C7uupMaUDTKWdH58eLzuFIe6+lDrkFmlLNMA=;
        b=R/Om8OefDZNR8JipSQ6mN+kEcdlmG2hUAsATtQWhRhCVZ3BOWkHukBI4wV4y/hZui9
         EUo1SoQo+MS4KEwyZNr8hd5I8CXAkTBcMeg3ImpbaME6OYTTifZiBWboLLuYs/garUAB
         lDCu7hCWoJ37W/+ZkFX9b4kucMuzyTZTDXOuig/x8afuqx3Rf98xhoPAbPcn4DB766NR
         1LTAagx4QeRWFEeLIq96qMqArAXYIMdEucvQ9rI9g8KM+RiKjY+rIatPkq/40nW+R2tW
         /zfwZSaFgb5Whvmv0dRzT+gUmnXUJevqPB/eVV3SwNrFQLIvycMxRiRDpSdCkSdE0knS
         G/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJrBvkAfSS1Ryg/C+YjV1M2S0Ttm48V9bhsYwKF3CYxH1Ve7OJhUXSrCNG3ZYWus5ophI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29doxSAbObqII3V3f8s5nFGsfr+WJrhJu5yQNfYsJ9lAfczH2
	IfbNVlA1T0uRQTSmnuvsH/bz7ppkI6a01PGSVvKN4NrMvuxfx7f1souHVjzoJPbb5T3QyjZCxdi
	0/nbT9Q9/Q0gGbd1aiNxfHEgnhAvoHDcVftPsamDfc01+4rDzfSM/cWJrGfr+nRzlQuAasr/8bw
	asuwmnqI27Ns6pLwwDzbO2qg==
X-Gm-Gg: AeBDiev5c4f2m7X7+35ENLjE7jaK5iudUbH4rehLuUPcn+Q8NiXYaI6XyzkInNnKWUk
	LWsaYpAjtFXNWnUlIn2hRjbwlbNsPl6gxnt9zx1JDc9YktZo3ssSuchZjxrF8guv0EV9KPpF3EU
	vQ7gRgC/9sfp6BhMbVqjtQr3+8ht0dOpo/791tGgM26ptXmqc39W6kgENuJZAv6+nD9UKZuglM2
	vsqYRaCuF3HrQdtG6BnQ224rZt3NdjGJyaObrvRSUdeNKv8kuySBDgWRLyRJ1SbfYI2n2zjxG5i
	+rL/q7CQD7jn
X-Received: by 2002:a2e:a5c3:0:b0:38a:a77a:b15a with SMTP id
 38308e7fff4ca-38d8d368e51mr72169241fa.4.1775739793404; Thu, 09 Apr 2026
 06:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac2LI_UPPrf45vmp@google.com> <20260407070046.2336-1-lei.chen@smartx.com>
 <adVGrJaRlRooO4su@google.com>
In-Reply-To: <adVGrJaRlRooO4su@google.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Thu, 9 Apr 2026 21:03:00 +0800
X-Gm-Features: AQROBzALB5WazLJj7tAQWemn868yqkRTG4XgzHMyYepmgpeNNXtleF3TECjgFnw
Message-ID: <CAKcXpBwhv2LR8Ym3XT5FrR7fqR7GYhkKE-J9RkhQkxL_iCZ4GA@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: Rate-limit global clock updates on vCPU load
To: Sean Christopherson <seanjc@google.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 2:02=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Apr 07, 2026, Lei Chen wrote:
> > commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates=
"")
> > dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> >
> > As a result, kvm_arch_vcpu_load() can queue global clock update request=
s
> > every time a vCPU is scheduled when the master clock is disabled or whe=
n
> > the vCPU is loaded for the first time.
> >
> > Restore the throttling with a per-VM ratelimit state and gate
> > KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> > scheduling does not generate a steady stream of redundant clock update
> > requests.
> >
> > Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates=
"")
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> > Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=3DiZVFNVKQNrXQzVsn=
-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> > ---
> >  arch/x86/include/asm/kvm_host.h | 2 ++
> >  arch/x86/kvm/x86.c              | 5 ++++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 5a3bfa293e8b..6d3d3f19af01 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1453,6 +1453,8 @@ struct kvm_arch {
> >       bool use_master_clock;
> >       u64 master_kernel_ns;
> >       u64 master_cycle_now;
> > +     /* how often to make KVM_REQ_GLOBAL_CLOCK_UPDATE on vcpu sched*/
>
> Eh, I would just omit this comment.  If we want to document the ratelimit=
,
> the function comment above kvm_gen_kvmclock_update() is the best place fo=
r it.
>
> > +     struct ratelimit_state kvmclock_update_rs;
> >
> >  #ifdef CONFIG_KVM_HYPERV
> >       struct kvm_hv hyperv;
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 63afdb6bb078..4a37027cc0b8 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -5211,7 +5211,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, in=
t cpu)
> >                * kvmclock on vcpu->cpu migration
> >                */
> >               if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D=
 -1)
> > -                     kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcp=
u);
> > +                     if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_=
rs))
> > +                             kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPD=
ATE, vcpu);
>
> To maintain pre-revert compatibility, where KVM did this:
>
>         kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
>         schedule_delayed_work(&kvm->arch.kvmclock_update_work,
>                               KVMCLOCK_UPDATE_DELAY);
>
>
> the ratelimit should be on blasting KVM_REQ_CLOCK_UPDATE to *all* vCPUs, =
but KVM
> should still trigger KVM_REQ_CLOCK_UPDATE on the initiating vCPU so that =
the
> immediate update goes through.
>
> That will also apply the ratelimiting to kvm_write_system_time(), though =
if a
> guest is changing system time that fast, it probably has other issues :-)
>
This patch does not impact kvm_write_system_time, which works as follows:

kvm_write_system_time
    kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);


vcpu_enter_guest
    if (kvm_check_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu))
         kvm_gen_kvmclock_update(vcpu);
               kvm_for_each_vcpu
                   kvm_vcpu_kick(vcpu);

This patch limits the rate of GLOBAL_CLOCK_UPDATE only in kvm_arch_vcpu_loa=
d.

Maybe I missed something?

> Completely untested, but this?
>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 13 +++++--------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index c470e40a00aa..f14009f25a3b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1504,6 +1504,7 @@ struct kvm_arch {
>         bool use_master_clock;
>         u64 master_kernel_ns;
>         u64 master_cycle_now;
> +       struct ratelimit_state kvmclock_update_rs;
>
>  #ifdef CONFIG_KVM_HYPERV
>         struct kvm_hv hyperv;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..5dc33f207a83 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3522,16 +3522,12 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm=
)
>   * The worst case for a remote vcpu to update its kvmclock
>   * is then bounded by maximum nohz sleep latency.
>   */
> -static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
> +static void kvm_gen_kvmclock_update(struct kvm_vcpu *vcpu)
>  {
> -       unsigned long i;
> -       struct kvm_vcpu *vcpu;
> -       struct kvm *kvm =3D v->kvm;
> -
> -       kvm_for_each_vcpu(i, vcpu, kvm) {
> +       if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
>                 kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> -               kvm_vcpu_kick(vcpu);
> -       }
> +       else
> +               kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_CLOCK_UPDATE=
);
>  }
>
>  /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
> @@ -13366,6 +13362,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
>         raw_spin_lock_init(&kvm->arch.tsc_write_lock);
>         mutex_init(&kvm->arch.apic_map_lock);
>         seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_=
write_lock);
> +       ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
>         kvm->arch.kvmclock_offset =3D -get_kvmclock_base_ns();
>
>         raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
>
> base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
> --
