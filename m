Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949EF9D9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764995; cv=pass; b=eAad6iybiRgPZW4hpriFwBY+8gCz6WkTDYYtGg+2Hee4utcu/v/IaXBt9/YT6Z5PMez+8q5Tmm5vGOVdsfQM58vXzmmy2xfiO76pkLdrwnvyEME9uuHtbje8TcJm9+hK5PXyDcHY2Xwj+SiOAlgN6e4ymDuOwymSXqdoCa7/Fpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764995; c=relaxed/simple;
	bh=ptdxCOZuZpJNWhzrb1Nh2wNESqFlD7UqOA7OTfjwF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0tvyiJBga1BY1yIpDtinAMT5VR2tJqJDpXfk9YHxjBvwax/570rxgexUjb1exJ6I2xj+iYuvYeJfuoT8hbqkmr5INvJBCtDmOvHpNFqyJ4UFNBbjszoo+nE/ZT6WCEl2uNY2ww19nlumZ2mE/GvHqujSUzfkHychq/W8z+uUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9RacmcL; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9RacmcL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso4005a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784764990; cv=none;
        d=google.com; s=arc-20260327;
        b=lfM83PCRbc2jr5NAcIPjS38Y1+xGZUuddxUFePHlPJB8CXAK49PDRs8dT2LEiBOmNY
         i72goI/pu5Y23P7xR40IKvq/y47brV0vhFe0UjrQuP6mQ/s56FKuDx09gXm0RQnJfnB3
         yMt7NdiaJSG2XO+KmhYYlUffaPP4c7OvABwsm12G8Y+FwTnDdzEJds0gTpFbI7mfnkRw
         I8rf6uG2iJE7JRy1s6MfiXUa6/op1Ub/EMF4YVcXSog6cN0kkdyPJh35UKl31eTcm4fH
         6GjHkg7REgmnhufrNmc51Jd2963ZL6qdDopASpsAeuJ+SCrABqZITGXHOzJCy4guA432
         oBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mc4deBTm6SNmKGbgLHFryac28tsBXJ2tioxgq8DKzQ4=;
        fh=WInmukEei1LbBj9nOCKbDuHiQf2BVadUGwip0RNsNCI=;
        b=iCmjR1dQc5CIkvTTaVWZiEx3LQkTyHOQgVzjzsNLofmvQEJs5DyW9JhrL17+szGpEA
         AI0mqjFi6uDbecHBqxWLnJozSCX1i7UZTb8T4OrjDCW2yvLszKzPcGnhUw/J2Dh0Q+XQ
         ok+gza2zSO+XdPlOtAFWtO2uND06gOGOIsFCv1NvxgQRVPPB5BKUPM/2CXqE0HdiV5YI
         erwpLgyoBJ4HqPXw+DBCVYuAw43AbETytFMcYt+KAoDsQ6QlXbKMuJzPFHySflLUih31
         Yv983nFrW9nWcls8HlF2YRfS6d8CkMwv90d6pTSyzObc5OXeGOQfQIQ/5NFutoCshnvv
         tOBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784764990; x=1785369790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mc4deBTm6SNmKGbgLHFryac28tsBXJ2tioxgq8DKzQ4=;
        b=B9RacmcLVA2N/OTV+7qpGbog9PWCWmbRkXDTJRHOVQh1mZNyGQ05SD17eZn91McJzc
         CAW9O/Wq0xuzNPj+scfBTHfxJ9+vYEn2R6GoB805qebYlQLgYeyct2QTdnWdj9EmOS3E
         UoVw7oy5YqFqTfTIZlFLXvqt+4EkixBU9nnoruKhIAU+puiegTRmxp9vqXrsc8QWQL/S
         yMlvTbUtcPB7lhx6vl5jv5HqI+/4PcmpXVGmiGHl0ncDswhpNZSQCL78gfg6sJLGTP+5
         D0Pxbj69BOmGPT1kUe/ocH7fOI5aqHTvtGUtDd5meiY10VaUrqHqzwvPoN4+dnB4fBpX
         USSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784764990; x=1785369790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mc4deBTm6SNmKGbgLHFryac28tsBXJ2tioxgq8DKzQ4=;
        b=IThBSgY4kB5FIlssuSxzyvMHMAGTkX3DvZcCOsvzlyJIfhR/Pgilq2ZPQZxTSJBbtp
         E/XzOgJFoQN1oigpNexLVzBYmGvHiXSXzefQTzi47o1FYV0GQpGWZPCv1E0xiR6g7qsC
         cayUtLJ/kCqjNdNnQPttexbVkl/LEppWq6RyCkC4EesX7K68p2FUBkMlTBQOSXpPDk+U
         UUJ6+lj8R4ispepRptYsfJGRY0qlNy0uwZtnLPggH2h+BOD0LqiBydUIK3tghvdxC0B+
         whmJbFXmrnKcaQNMlzYG159s4OwtNZT1aKzfj8Hl79aMwuVcI9sSuxZxGPadL3QoNN2Z
         ZLDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9lEWPmIoac05N/sp9vB7i3rNn2B2gH/0QWCEgkpomYNV5C2eUMd1Z02vP8mteN+ErE20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPelZSiNUFe7KcqC+yCb0J5EFyYq8MypkX3lsiPLFInGXDduKS
	BX3d/dkqUOz36CqMR9pFo/y69Z/SGlNIgcrjXVdm68C5foHH25L4BhksVnVVxARcUg7Z3ysBE4J
	KeitJ+7Pq8mcbVMT9A3l1HoXRttPvjma/xejEIkW8
X-Gm-Gg: AR+sD13/k9NT6smcDCGiPSimlUN7sSdxNYlXi/gAWIHLfwPhdz+EdepWN1z8Mt1jpVg
	cYX7RlNkgnrd5oR48pO4pIyHLhgmGPQD41iHh63nBvOJWiZ6H2qL1Rsdq0ZJEMfnHadgqZlqmgT
	kJjHj6Tf8aS0GWsuvxb+lszJ7bgrunRn6UeCAvj8k/JRjB2TNcdIvI4InzRZVDfcmnVmUw4T3uJ
	GHsNZHZ8wuggaZr6L3fUZF8M5/3ebXClYz7yAlw+rkx72yh3sB/FewtHWk4jPwB2HK6WTkS
X-Received: by 2002:aa7:d393:0:b0:69c:83f3:4831 with SMTP id
 4fb4d7f45d1cf-69f6ccf07a7mr16657a12.7.1784764989890; Wed, 22 Jul 2026
 17:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-8-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-8-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 17:02:58 -0700
X-Gm-Features: AUfX_mw7K-0VoDx68n9Mwz_YWhzJ4S5ZR9o3i9Hs5Fi_F9_uxKKmf6_iLVznzBg
Message-ID: <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:29=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> If the host has the PERF_METRICS capability but it's not present on
> the guest, RDPMC interception must be enabled and KVM should inject
> an #GP when the guest attempts a PERF_METRICS RDPMC.
>
> If the guest has PERF_METRICS but RDPMC interception is enabled for
> other reasons, KVM needs to emulate RDPMC with type 2000H.
>
> For simplicity, Metrics Clear Mode is not supported.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v6:
> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
> - Reject non-zero index.
> v5:
> - new patch.
> ---
>  arch/x86/kvm/pmu.c           |  7 +++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 8ef2d4761790..04b9c840f218 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_=
vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> +{
> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> +               !kvm_vcpu_has_perf_metrics(vcpu);
> +}
> +
>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>                 return true;

I know we have a strong disagreement here, but I really feel that this
must be secure and future-proof out of the box.
What if we added a module parameter, enable_rdpmc_passthrough, which
defaults to false?

Then:

if (!enable_rdpmc_passthrough)
        return true;

Is that a reasonable compromise?

>         return kvm_need_any_pmc_intercept(vcpu) ||
> +              kvm_need_perf_metrics_intercept(vcpu) ||
>                pmu->counter_bitmask[KVM_PMC_GP] !=3D (BIT_ULL(kvm_host_pm=
u.bit_width_gp) - 1) ||
>                pmu->counter_bitmask[KVM_PMC_FIXED] !=3D (BIT_ULL(kvm_host=
_pmu.bit_width_fixed) - 1);
>  }
