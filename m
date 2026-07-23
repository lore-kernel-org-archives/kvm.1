Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CB334C1D
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773549; cv=pass; b=iEKUa7o5yKnMPUcO2k8uGyo0a7Hkihl1sOOZ0LCO4orrVJtRI+TTUkSsqTd29hnPwbqSkNs5rW331PaMzN6J30Gul59eziNU4EQ3YKxxoDOEHlSnxS0U5MW8vWLl/OedFH9kGRUNzEhtS2hE35LOXaeshwCgPnKaX/X4c2gWms4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773549; c=relaxed/simple;
	bh=n6rrddAT+VvS+7T75lGeEbJQILXehIGQgEzbLNtD8t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAWOBGDZSC54V/5Q2kfa34QmKdLAtrofOgKALTU9IpdbS8M3PW8J84WeuduRrzH9bnC7+KzbJk9ANEAyxkozrio1aIGiRUgBhNUxJVJaJgOCwB9B2W3wQLS8rc/xJBtSYdJsTqkgQcnmham+++thnG269DxyT/qEeOg13+sFQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYBnhKAe; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYBnhKAe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso2799a12.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784773545; cv=none;
        d=google.com; s=arc-20260327;
        b=oFDiUOqGSEczKp1Jq0GGeVLO4QZXn0GpU2bwCJwJBJxRSjM5COkzyVReI6mv7KzkOk
         3P78wRprJAqHU4ZSczf4p1EOYmq0EKwOYqAf5HlevdeJTHW5FolhqGjISjA/Uf+fkuwQ
         XTKF2aDEf4gUvqwVxpJu8rtQrCYy0TnPcCi/OyTeSyje49NbZFMda3KAWgUD0G/ZenXc
         gvvO+Icl3FeuRk23/FJ5Kzsorn63wbWIp63GP1ZNqBOSR4gwj3AbaNSjamUqN66soeYW
         +2Jldh7HIzg7fh3w9lgz6NgQe4Z0q7HYSNweyjVU6SZWt1Ta/AI2p6+2jbH5wMtMGFih
         lLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QUaVftBKd4sZ3yoYfdOr5JkxQmQgALmihe6Cj7gaALc=;
        fh=Fur0GmCbG32SiUYNTeC62dPts7LhlyykV5S+iifKBLU=;
        b=fG6WPpHLsfBZPBFamkEdXl8IphONQ937dvu7dCFaiRHtw++JnUC9NIaxDtU8bzUWY9
         Xka3Vk8hgOQXZAneq5oZW0/i0z8/n6HjA/NE/qlXVaJOijKy2XC8LA5yfdzNIYeHcpiF
         3SLjewUZ7VB9/6kIggUtUJUZ0D4qrx1qmTDjLbcZEr3HWwkygtqGQ6pQKSoTk8kdKeUh
         Kj10WPPYP4qaD0B7QmxVJibcQ7v4UEi/JC6eTGLCn2hQ5Y8m4VwA3pif8c2WrvDchnzG
         Y+nbPRKjNw/00aDpBIek+DLZOY72IQrwdRJtO4cgQgHXZcBgSyV79ZpdyXUGY1h4Hjpr
         QT+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784773545; x=1785378345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QUaVftBKd4sZ3yoYfdOr5JkxQmQgALmihe6Cj7gaALc=;
        b=BYBnhKAeJxdi+USfKf6doxw/0szx1AB57n3Qrhaxru3jtXX/G8snMuhr5BatqhvE/o
         Xb795b+Zc+curC0kz0qMHF5hJLdVHdAfGVEj0ZnFgVdG+G8sx69O8zMj9wi0xi2FbBic
         mSyYh4nX3XmtL7tELWdfKsVjuxTDAM5XiA4+J/jZ+LowJ4ri0QijDBe1pz2Nbt2tQMwn
         gH61VwXDpfF84pjUspb1Pr1IQ8PfdRV+OnZ9fNkO8fBYJYnwUqRxDEUMaKtfjeEFFY9g
         pzJYLUtkNS3AxCKT96f0mp9FUnnEFCc1JXR9djsKnbGrwM0tDmNsgA5KBSV2sELL28WJ
         Tnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773545; x=1785378345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUaVftBKd4sZ3yoYfdOr5JkxQmQgALmihe6Cj7gaALc=;
        b=Ujk9m/fg84Vd3hMcXSWRxSUJfOS9x5K/LjbBU8GCfI3tJTJIkh0jjiXcZH3c2l0yJB
         RYdo4+Ka5edqujxVBfwC4h1KknYfIO+IP6cN56JGv168xJyjQlX1p/50AvISxc3dnEuz
         6GmwIjaCFEZB76vu4ZfqWvU3dq6/n7+uaIMgR31/ZFgUI0r6G7eppnuYxxmoVHg8b/mx
         j+slr6RBTcMDdqM0pVpBsMLiDx/beJXyZm3YbWjKp9RYRpleyx5tzG3ca7j8tjPVcAxW
         wBURWReeGVJkQxIUgQT/3n+7jqzmbalgYL8aVzT4qGKuKkDOqtsEgW1AquTIP37adBzJ
         HHiA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg+7ryoWZvSkKiyGUeCKsXkuNOizX7kkIm+RFm2wFEwwKozrvhlQ3ROYGXBUVaW01IjAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRXfYYCTTmJQsiqELwdqMspUxyucG5lHxPH5l5Z4M9psaygAe
	KT9LlevjljRkXJLnrUuohfUYk3pUL1j9xICQOURuUBuvjc2iCinKryOOZ9Rm32Q5FTVOCb1TB/v
	7GwMILn17xSdFa4O75JOjfNdBonOX3TyU4ZHFSpl6
X-Gm-Gg: AR+sD13ZlvNMIFjUqYbnrtHobfK9rzPslC4baJhEFOQFwnpJilJtlW0LUZRwEMDBjCu
	ZTwZDYSEQxTD5v1bn5L7RMeI0m4qq+NVc1zyOvGH4OlgqWjJJEwFDQNCyQS2KxyL5TdqJNlumwl
	twXxqgIWmpWzbz0QFnznqFW9z+rSHgx6E0kxXISgGqvv3UpgAv67ET1C+f3xjxIJZDXe+1+mLZb
	p4cDfDh9Fv4EAf4Vx/3onpsXDOk3tx4/IGLpc97guqAJnch3g/CXIfa2vXDvg==
X-Received: by 2002:aa7:c74b:0:b0:69c:39f5:7e36 with SMTP id
 4fb4d7f45d1cf-69f60d9e156mr40184a12.0.1784773544387; Wed, 22 Jul 2026
 19:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-8-zide.chen@intel.com>
 <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com> <f16aea7f-6b5a-4980-91b4-a41931b797ec@linux.intel.com>
In-Reply-To: <f16aea7f-6b5a-4980-91b4-a41931b797ec@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 19:25:32 -0700
X-Gm-Features: AUfX_mxGDaDDBUNYf_pnyueKvqwloQ09Q9ZK8W93zVqi_1L3aYQrMIVAGr7jm3c
Message-ID: <CALMp9eQapUpDBd5iwvw7OVkm8oUaVcD9KQwdgyA57mNiWe9jgw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:44=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/23/2026 8:02 AM, Jim Mattson wrote:
> > On Mon, Jun 29, 2026 at 4:29=E2=80=AFPM Zide Chen <zide.chen@intel.com>=
 wrote:
> >> If the host has the PERF_METRICS capability but it's not present on
> >> the guest, RDPMC interception must be enabled and KVM should inject
> >> an #GP when the guest attempts a PERF_METRICS RDPMC.
> >>
> >> If the guest has PERF_METRICS but RDPMC interception is enabled for
> >> other reasons, KVM needs to emulate RDPMC with type 2000H.
> >>
> >> For simplicity, Metrics Clear Mode is not supported.
> >>
> >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >> ---
> >> v6:
> >> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
> >> - Reject non-zero index.
> >> v5:
> >> - new patch.
> >> ---
> >>  arch/x86/kvm/pmu.c           |  7 +++++++
> >>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
> >>  2 files changed, 21 insertions(+)
> >>
> >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >> index 8ef2d4761790..04b9c840f218 100644
> >> --- a/arch/x86/kvm/pmu.c
> >> +++ b/arch/x86/kvm/pmu.c
> >> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct k=
vm_vcpu *vcpu)
> >>  }
> >>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
> >>
> >> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> >> +{
> >> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> >> +               !kvm_vcpu_has_perf_metrics(vcpu);
> >> +}
> >> +
> >>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
> >>  {
> >>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> >> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcp=
u)
> >>                 return true;
> > I know we have a strong disagreement here, but I really feel that this
> > must be secure and future-proof out of the box.
> > What if we added a module parameter, enable_rdpmc_passthrough, which
> > defaults to false?
> >
> > Then:
> >
> > if (!enable_rdpmc_passthrough)
> >         return true;
> >
> > Is that a reasonable compromise?
>
> Yes, this is an option. Another option is to add a helper to explicitly
> tell which platforms are secure and can pass-through rdpmc. Maybe like th=
is,
>
> static bool intel_pmu_can_passthrough_rdpmc()
> {
>     switch (boot_cpu_data.x86_vfm) {
>     case INTEL_ICELAKE_X:
>     case INTEL_SAPPHIRERAPIDS_X:
>     case INTEL_EMERALDRAPIDS_X:
>     case INTEL_GRANITERAPIDS_X:
>     ... ...
>         return true;
>     default:
>         return false;
>     }
>
>     return false;
> }
>
> Then rdpmc can be passed through by default on these known secure
> platforms. For any new platforms, the rdpmc would be intercepted out of
> box until we confirm it's secured and explicitly support them.
>
> How about this? At least for me, it looks like an overkill to disable rdp=
mc
> passthrough unconditionally on these known secure platforms.

The F/M match would only apply on bare metal, since you can't trust F/M in =
a VM.

What if we combine this with the module parameter, but now the module
parameter defaults to true? Somewhere in module load, we have:

if (boot_cpu_has(X86_FEATURE_HYPERVISOR) || !intel_pmu_can_passthrough_rdpm=
c())
        enable_rdpmc_passthrough =3D false;
