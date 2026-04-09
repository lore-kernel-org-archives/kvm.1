Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7713382D3
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741788; cv=pass; b=LArWPNAAkjQ4rlLqNUXCrIfkNtlqm9lVlfOka8Wpm0QwgZLIrK+tj1EKlQ0Rrz/xu0O+g0qYPNkPKvVLBW0pOKV6hQ538BF19hshP+i1BYWW6eggAzC6Vtt8ooZoRq4snExAKV6juJV9oxslRRZuMxKE/dth7C23zuGOuz6Jk5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741788; c=relaxed/simple;
	bh=Hg0IGiR/RhlgUXgydoCNMh1ivwrksQBZtIXbHnkz6Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHaKyXLI0RRmtXAqvCj5xFzNcp10MBD3cfjICmmbd4z1b9zMRaupPIW2o0tE4VNBbSml7+eRBAn/RKvVNqFUdvKxZ8iiyIoX3iXWBlEM1bysYNIfbLRukrintvCcKlJsv9F87CdlJPGqCdH0s6fGpAaAjdIS++ZE6d4fR3vDFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=x433Tfv4; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="x433Tfv4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38cc0b91b01so7174951fa.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 06:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775741783; cv=none;
        d=google.com; s=arc-20240605;
        b=d0IdP9gXKQwTBznXIg3rJxhc1c5EEASvgk8sgRyWvKa0ZBXG+G+jS37t6fqhelKILB
         jX9hcozFGOfyvFF3tlNpl/DJF7pqD2KpmB+z/2G2Q7SmlAnBcatUtBLH0BHHkWSmNZ1F
         H/cDhhi+M8XvmvQu5mJ3fXMRh/okI/Oj6H8p019eZglVdjNI1s1MF6OLuHtgu3fbRu05
         3Whc2OJ7jH4snow2t7x54y6YE+d6LSdWW+knqTYuFQDcC3brjZ0Kk8X/iVc1bL1k8B7w
         u1x1WCKwGGJesmL2+HlE/gog2IcJXtmhQ3SS4RAEAMmSwC3ba1c7xCk1d4deMmzmaEC3
         koWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LGhq5Wuonmxw4tuNdv4409R6BjDNCijJVo8Tfj3nif4=;
        fh=8mVXm06i+3vz2kg8RTAbO5CsJFCAd3+TO4XtcJ3wIw8=;
        b=iHjIWFLPBme51ujbamw8QQH3iVcmtFohZ/Ra6TPZwwW6A35m9+yOYc/kgS3zjeu50G
         +bink16FEK0fjIKDNgQzNoQ4Tf//Nj/JlHOefyxDuaG+wfLWoTwmd8mB47fPWtPFjaVJ
         MmQJNyCkCdsoMNpvmb+Qxot87TOiC7lqXbsYDw/kLsruv548f0/ucfOtpr6rrPc3/YMO
         txJzPQaGVZFIs3FIvP4hGYIu0Z+yQvkWfUDlGl4vLwldeY0J9Dz7/KUXbJtuo+SV2OAJ
         5xEk9GeFs4jibzsR+S1jX+qW4ueVi4HuDuTxRRx5/kAFRTJVqKB0LA40lyv0GV79Gph1
         LT0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1775741783; x=1776346583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGhq5Wuonmxw4tuNdv4409R6BjDNCijJVo8Tfj3nif4=;
        b=x433Tfv4MyI6+UVlPl2+8wa497GgJGpg0y9nkXfP+cwvBwzSmwHR2tzdQaANkEkodc
         KbQZ6V2oKJU71yPfkRcelZnLz84GO5LURsJguajnmNSOAD0vCkEeLipRVpmpDU6SAzZ7
         87U25jlKAjIx502RCNtuN5VPySNsF5t8OFWz55zu8s9zEvs0zxsacltEz3fTGZqDhHR4
         Oh0Py/ml+08RmhPNc06dbklbP19/4s4CdbG6zoGZ/Rk7X0qFKah2YFoPK204Cqtv4WAr
         g9xGvRiKf1+czACF8Ousaf9mLYK/nT3mLkqWFWZHRlzYDygQmBt6gavpgdb7fQqS+nO7
         FevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741783; x=1776346583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGhq5Wuonmxw4tuNdv4409R6BjDNCijJVo8Tfj3nif4=;
        b=LayhvhfdN3r2Fdun1die3rQEyKEheQA2qg0E5qZGuOaXjBoe95vjZLUC2szE1h5w/g
         Eib+xUp2x/sPp2sq04bM1xA4FWROLksCAXNQWJY84i/AftRVsF8yBJB2XpqZ/1ra4bZ5
         Pi9xa/6JGlj8R+oXmJQ6ix+GW8EPdJRSK4bXtkshVLnTqwJK/k4FyCk/23ddrbM1gF57
         MTOXpvGmTObhDm3kdspqoxeg8ZbstePJSG7C1GGfzdw2VtVg+q8K1lpzoxzVcHtQN6co
         dsfJmK/y3FDTppj183p++RwGlElAro4KPlF6KyzHB1BNd5DScSzkgTAT3p/29+WToCD0
         9n0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZWlQ1ZkTCq2wUFs/aw9u0D73V/kwDMgRJiX85gKCNNk6O48o+VGRi1hClrue4XitZoes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIhh+CekHIeOx2Nof2PgrESi66ImZ+bigLjM+zkmuO+qNfloX
	4qFhoj4YPxwzmRfyiI01JQZ5yvqYD0pn5ypJb1aZ5FxWONLvWYZ0cj1l23Xm41F4qfY5JZMm2d3
	Ov2eT1jX3V7hLDwiVVO4j6McJLdn3ug2i3IteRikg4k61fVxs5KT+AISaJOeNjmL+FVLvBivPnE
	kDg4tCWn3emW3T7sefq/AcWQ==
X-Gm-Gg: AeBDietjYw8690HjcgBwiPd6UfaHCEKSVm5WuHHZ2paZST+WzRFAZxwRfACkT6Re4Mj
	RL89RX6jnv4yGWSseofzlpHwESrKivl0a7DG7MakI6cAba/O6vpDV+SJ2ImjIMlY5BynPCTc7OR
	XMX6rlNDURjWkDn4XVdYMmWnQ1FrmtVTcslhqPwu65L043uCq/NeFYg/5zlmDxyprltp5NCMF7o
	RDoLFo3nrE6iMTEalUUGtCX/1WhaqC7iJyD5f26zOM3myLXO6Ni+1znrsmCMnufvlrWd9i2kQew
	EgD6S+Ohq/o2
X-Received: by 2002:a05:6512:3b1f:b0:5a1:1e49:66 with SMTP id
 2adb3069b0e04-5a3375848demr7946518e87.29.1775741782414; Thu, 09 Apr 2026
 06:36:22 -0700 (PDT)
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
Date: Thu, 9 Apr 2026 21:36:10 +0800
X-Gm-Features: AQROBzBj6za5GsnXQBTuRUGwmnNIFKrPbfDUsS2ZGkIANliyUgUh7VnKADEJUek
Message-ID: <CAKcXpBw8YVNJxdQA22U-c-2pfB5O2e8T1sJNiomzjwJNmMH63A@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: Rate-limit global clock updates on vCPU load
To: Sean Christopherson <seanjc@google.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

Thanks for your review.

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
OK, I'll remove this comment in the next patch.

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
Yes, this is a mistake, I'll fix it in the next patch.

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

Best Regards,
Lei Chen
