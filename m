Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875D305057
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252522; cv=pass; b=Irf0FYaGROqy8Z+Z3fI5DjERw+hgXKL0/2wc2zcgKxrH2nrRO0Yo4uusPAfBx8aLSPV29Zu5QPJmOWl3gyO/RMVAmFJHY+/+Xhpx/ik/rFq/tOQnS+V/jtDjzTUHuGWmsnXl/rNUQbQXlkDj7lSpnteX7/kNvSRNjfgi58JWnFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252522; c=relaxed/simple;
	bh=tz2vfEDrSv+B+5epqzgmFJjNbz/M/CueVCpB15TIBMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mh2zfzopbUQWqt1GdhWNzgHqbgm+lU/deM7DSie2YVQyJZHMwfLcKikrn9Y5iwiitsKJpkNqOdFqVMy6sSaMKPhshiFwvUKlyXytI2El3tkZSe5NbbVg4uGrnKYW2P7BQ8ymLMQEQSdUhAp+JkizxNWkVa06ilVdg4SxJ8CIZWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/+uTiVa; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/+uTiVa"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso10141a12.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252518; cv=none;
        d=google.com; s=arc-20260327;
        b=drP/kf0xWBPOM/pVJ5fuIYeoqmOsnyYjQJoc5s3wFpJSTJh6+W3pivOag0VKQhci2N
         LWRURqiSTjVAHw+iMOOGbygICuvH0fWL4dMqr+WaIz/S/G4J78PlDhCAfEV59EMDsA+y
         p3QsC8uaz5+4TmPItdFn198teJyuoRVQ4gblsCL1kVCJQ7/kHxbU9G+C5dbEfXwy0gTi
         rrPBz8U21YFU1e4Zme4a3mkwgK+L2Dtzz1q1Zox7/KgIQ5+EMyI3QHY24j3sUzwTaDv7
         lFcSjMjos7YSKlh5QF0Jsth+sNk1PzGS7o/9iezROvv/5kUoiBHE5RzC9urSR3ozHaYX
         wSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUVsrP/Nlab3GnLholv+JVod6JE8TofD4PYztbkk5DQ=;
        fh=F2wAZpWJiNqJr3SvcVi0SW3tUiCIT29ihRTr4laBpKY=;
        b=Gru7uMN1eYUFN3a1/ITWx/616vhD4D+atA6Jk+jzT3Z/LfsqsfB+s2/EdG3nm4+xH+
         n4e2qr6TVQmc2+lEUYwBdDzpuRWYEZYUyADIbG12CV6qNHC3udXWTPWfQBR13Gp46o8v
         mj0KKI9qr6eFYLXRIydWZHbggE700iLz2MN10sQwcv19hZ/KyOqGzpyBcY86mhhh6MUD
         1AM+xe+Up4Gmwaxwx9I7z7HPygXaitcNtDM8kKvMh7H6IuIWQHRbNjoWWRC0EWPJU67e
         nhVyvNFqrbZB89Cq2ikLv1rf+WcbRWbHXctSmACNDVT01sTpauLj0mkJr/9lfLs4V2yD
         q6Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785252518; x=1785857318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUVsrP/Nlab3GnLholv+JVod6JE8TofD4PYztbkk5DQ=;
        b=H/+uTiVa+gMZytGE5DSTfHw+S5o5lzoorqP8kfxxzQ0q/tgUVaxlzGq04N6q5rtXnc
         +xf0m4DE6XxtliN1+nI04oeZ/uSZaBiy1yxxLJjd4cb7Lf+7xS1ubrXoyDLhtUXqeVAF
         15qnogyHUrE84lqNkxdlIF6FSTOEzJWjdo/0E8rcBBSUxpkyHDNk8pXm7Wgjy6VWhL9d
         1k6lXSKsVIhMyjrlxMGp3Q4BhAr44JMZ23Oyk6o2mz3PO5gjU72JWSmr2JqhrQBGki8y
         Hp94pekhB5irMPFu5n48XkQ+Jo+ZPeqwbe5FpXn3L14IrVKoeloHWiPTtYCpw1f7hDDO
         r7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252518; x=1785857318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUVsrP/Nlab3GnLholv+JVod6JE8TofD4PYztbkk5DQ=;
        b=DtRk7uJYqj7YHHZCoCRbPIu2N265465xlNnXsB9vwtX2fr+n9sxrstje4IV3Fpqazd
         SGAt8Kd9mTCgjnuhxwGA29fXty+104uW0IT0rGwe7kJEPr+fKx7EuMkyCxOT4vOszSi4
         8mXrxPBreRemRZaDO0vokpltBzhyFGBtY3+2yDJ1S5CGJyDorHcT6cCIMm2SkR4K6FNI
         k5/GxR9IIlOY2JvvtBPBlDekB3kiCXGK7z3YpfDSdDw/6R6VxrGh2DVJWSCwlPjxMyPk
         TFWD0VfMkdE685Hr34FxdsMvYFuETz3iUwiIZK/SYjpB368AD7PQtCtkCvXABI3VM5y3
         re7A==
X-Forwarded-Encrypted: i=1; AHgh+Roxqrys1EohzkVB/c9UtWvEgd+v0D+lQw892QAOzPI8i5Ng4hOY4WtJoHKcVblRLYl7lGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVALbymDTmQrHyc7Ej9nFgWUffxbI8fUSxexPr7rqPFSVGgh/u
	Le9JpwqwIZUNSBy+HecT0o19FoiYc3foqkrI2aJvP1OZ62RgI67mgAR9JqDv2sVSFaPj+lI4Xs6
	WQnLznOfixqtDACy4e7sFzBa4CcWACo8pbfoxvlIe
X-Gm-Gg: AR+sD12/HzT7+4w3FTD3bgrLJCIsNSEEyPIdrjjcZL104GsLvJ0iGambqXS5cI5LOw6
	HWItAnS4Mdkbel4hEB6B+/rQqLvlq7Kpv2wGsgTb11q26r2pu6mfNrsJjhtVj8H5aA7ud0zIUy6
	XLx/fZVSdI9wx36woQsOW97vNo8mR/kP5aA6igVBOeuQCnnkZu8DQIWuB0eXxpmkWaSvdHq9q5g
	nRLLgD5Sb8W0Zog33ow6QxkB7juAkysve7Ifba/Rfhj+Mta5SFDZouPlxmgdA==
X-Received: by 2002:a05:6402:458:b0:697:5678:bc77 with SMTP id
 4fb4d7f45d1cf-69fbf0f0fb2mr156599a12.9.1785252517914; Tue, 28 Jul 2026
 08:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724234914.987987-1-jmattson@google.com> <20260724234914.987987-3-jmattson@google.com>
 <amjEw9QcQN7owHKF@google.com>
In-Reply-To: <amjEw9QcQN7owHKF@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 28 Jul 2026 08:28:26 -0700
X-Gm-Features: AUfX_mz8gL_LwKirwTjibhjfAQrGDUm8QpJS2xyMLT0c_F5ehlCjoHCQx4XnF8Y
Message-ID: <CALMp9eRFinq-wUPJ27OvvB5pUsAC+Mxvw9W0uordbx8jSbFdCw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, chao.gao@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 24, 2026, Jim Mattson wrote:
>
> Sorry for the late review, I didn't actually look at the code in the prev=
ious
> versions.
>
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index a07faa066ef0..ebe83a641473 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -153,6 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
> >  #ifdef CONFIG_X86_64
> >  static int __read_mostly cpu_preemption_timer_multi;
> >  static bool __read_mostly enable_preemption_timer =3D 1;
> > +static u64 __ro_after_init preemption_timer_limit;
> >  module_param_named(preemption_timer, enable_preemption_timer, bool, S_=
IRUGO);
> >  #else
> >  #define enable_preemption_timer false
> > @@ -8306,6 +8307,26 @@ static inline int u64_shl_div_u64(u64 a, unsigne=
d int shift,
> >       return 0;
> >  }
> >
> > +/*
> > + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> > + * VMX-preemption timer may expire earlier than expected when programm=
ed
> > + * with large values. The workaround is to cap the timer value to stri=
ctly
> > + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> > + */
> > +static __init u64 calc_preemption_timer_limit(void)
> > +{
> > +     u32 eax, ebx, ecx, edx;
> > +
> > +     if (cpuid_eax(0) < 0x15)
> > +             return 1ULL << 32;
>
> Tracking an exclusive limit is cumbersome because all of KVM's usage deal=
s with
> the max value, i.e. it forces all usage to effectively do "- 1".  I also =
think
> we should go with "max_value" instead of "limit" so that there's less cha=
nce for
> confusion around whether the limit is exclusive or inclusive.
>
> And we should provide a local "const u64" for maximum architectural value=
.  The
> other option would be to initialize the global to the max architectural v=
alue,
> and then do early returns here, but I like explicitly setting the global =
before
> checking it against use_timer_freq.
>
> > +
> > +     cpuid(0x15, &eax, &ebx, &ecx, &edx);
> > +     if (!eax || !ebx)
> > +             return 1ULL << 32;
> > +
> > +     return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
>
> While I appreciate Sashiko's paranoia about "((u64)ebx << 25) / eax)" yie=
lding
> zero, I think we should treat that as a WARNable offence.  And to avoid a=
 false
> positive due to running as a VM of a misconfigured hypervisor, I think we=
 should
> only apply the erratum workaround on bare metal, i.e. use the maximum val=
ue if
> KVM detects X86_FEATURE_HYPERVISOR.

That's fair. We always emulate the VMCS12 VMX preemption timer with an
hr_timer,  right?

> So this as fixup?  If this looks good to you, I'm happy to post v6 since =
I've
> already got it locally and tested on CLX, ICX, and EMR.

Go for it!

Note that, like you, I didn't actually look at it. :)

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ebe83a641473..dae41842a9ce 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -153,7 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
>  #ifdef CONFIG_X86_64
>  static int __read_mostly cpu_preemption_timer_multi;
>  static bool __read_mostly enable_preemption_timer =3D 1;
> -static u64 __ro_after_init preemption_timer_limit;
> +static u64 __ro_after_init preemption_timer_max_value;
>  module_param_named(preemption_timer, enable_preemption_timer, bool, S_IR=
UGO);
>  #else
>  #define enable_preemption_timer false
> @@ -8313,18 +8313,25 @@ static inline int u64_shl_div_u64(u64 a, unsigned=
 int shift,
>   * with large values. The workaround is to cap the timer value to strict=
ly
>   * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
>   */
> -static __init u64 calc_preemption_timer_limit(void)
> +static __init u64 calc_preemption_timer_max_value(void)
>  {
> +       const u64 ARCHITECTURAL_MAX_VALUE =3D UINT_MAX;
>         u32 eax, ebx, ecx, edx;
>
> +       if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +               return ARCHITECTURAL_MAX_VALUE;
> +
>         if (cpuid_eax(0) < 0x15)
> -               return 1ULL << 32;
> +               return ARCHITECTURAL_MAX_VALUE;
>
>         cpuid(0x15, &eax, &ebx, &ecx, &edx);
>         if (!eax || !ebx)
> -               return 1ULL << 32;
> +               return ARCHITECTURAL_MAX_VALUE;
>
> -       return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
> +       if (WARN_ON_ONCE(!(((u64)ebx << 25) / eax)))
> +               return ARCHITECTURAL_MAX_VALUE;
> +
> +       return (((u64)ebx << 25) / eax) - 1;
>  }
>
>  static __init void vmx_setup_preemption_timer(void)
> @@ -8338,7 +8345,7 @@ static __init void vmx_setup_preemption_timer(void)
>                 cpu_preemption_timer_multi =3D
>                         vmx_misc_preemption_timer_rate(vmcs_config.misc);
>
> -               preemption_timer_limit =3D calc_preemption_timer_limit();
> +               preemption_timer_max_value =3D calc_preemption_timer_max_=
value();
>
>                 if (tsc_khz)
>                         use_timer_freq =3D (u64)tsc_khz * 1000;
> @@ -8349,8 +8356,7 @@ static __init void vmx_setup_preemption_timer(void)
>                  * value.  Don't use the timer if it might cause spurious=
 exits
>                  * at a rate faster than 0.1 Hz (of uninterrupted guest t=
ime).
>                  */
> -               if (!preemption_timer_limit ||
> -                   use_timer_freq > (preemption_timer_limit - 1) / 10)
> +               if (use_timer_freq > preemption_timer_max_value / 10)
>                         enable_preemption_timer =3D false;
>         }
>
> @@ -8392,7 +8398,7 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 gue=
st_deadline_tsc,
>          * It's possible that it fits on later vmentries, but checking
>          * on every vmentry is costly so we just use an hrtimer.
>          */
> -       if ((delta_tsc >> cpu_preemption_timer_multi) >=3D preemption_tim=
er_limit)
> +       if ((delta_tsc >> cpu_preemption_timer_multi) > preemption_timer_=
max_value)
>                 return -ERANGE;
>
>         vmx->hv_deadline_tsc =3D tscl + delta_tsc;
> @@ -8426,7 +8432,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vc=
pu, bool force_immediate_exit
>                 vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
>                 vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
>         } else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
> -               vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer=
_limit - 1);
> +               vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer=
_max_value);
>                 vmx->loaded_vmcs->hv_timer_soft_disabled =3D true;
>         }
>  }
