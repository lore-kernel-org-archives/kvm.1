Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177131283E
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776225; cv=pass; b=DAQJuWkRlFKcjsGl84r1O23S0t0Tz2m3WDiJLK1y5qgUYy/59uvegXfIjY7w7cT+3cgYi/2uIYWlQujyOAwARe3gdjxGa5YCXWjvgTIY8Lp9MteAtfC95MGL7asjc8a31t3i/841LSyEvr2/HRaxLLoXEwgjJab1Fc39NHWfX+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776225; c=relaxed/simple;
	bh=OTtPdODXkYAcHOmh2ZAx8zqavTVFtt9cmndMZdifpPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yz66lpNS1F35RTnpnXp/fjH/dw1b1zr5FijxtdgYLE294jlVXvjMrCrxplHBhbDZUITcpPTTz3fdb/HuT9kewT71UVKKo2ZXvQtwyKWb/xXYvRSYWGaWayZi17RfvI+Ixmx2JJXnZrVeM7CWa5ta2yz9R10/eWA7oVvfdOPx2I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVR+HLkp; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVR+HLkp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso3060a12.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 20:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784776221; cv=none;
        d=google.com; s=arc-20260327;
        b=ZUoyyr5jjOdTQ7Z+mKbA/0q/b7ZUHIKcfPRPPO7hFTTZWgmNk+LgohtUir9gyVlGof
         Yx2/uH+Vo72haXXX2a5PqvYBeIbXF9hD+jiXMIww++z/9NXRNVbWvBT25xJ4iKIfF8FX
         raVEz54VVX9cdXyxR3/ho77MtevWKTnzRQx7z+KPTVrvlzGt9+FPk6Shmuw9NxFuqSAU
         EJQv3ShjcO43Kd4pWoJwnzRIdvL0CT9beU41m3N/wKwqAJh3D4RdGAXbQxL3UsF5HvHG
         WDRs7qOFyrPfQIwKg4n11mUwIv8fHSmB+pkad0zkm6jiwiUYZzL+q+MChNyxDSpGHI8u
         /BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbLnq6v8Q/claMZ0r3UT7Ku3TaaAf3P6/lFlwBQj1fo=;
        fh=dqFcqxu2iqV3XhPeQ/Wa1ndKe6PQZxV3O3zptdqUDYo=;
        b=Ns/CLcVdPzOSJvZI9StZ2oq1Q/wrCU9YRJMDgkqlj4UiyaX1mp/n+gbsyyb97/TJ2x
         CTYaLTJWuM0F7Wws5Mhm1DoRXC9gOfLhhxn5Gs6Fc1b2JARlPEjKlUzr+vUyiutRYI2K
         YirhTleB5lON3DoI3EeqjGnAVZnS5Cd3KcBJUJFnd1tHrtU39/r2FNvT/uZgpNBeSB+l
         v3PuiX6vQvJOFqvRvg2kCIPrEEu6g8IG1UIfBTfXftVrns+mWgRvriGbD+MBTqojDDpV
         GXUNLL6tUxiuYt0f70/82xXpO6P1LT27R8YaH8S03Tg3dTO1Dv/LyFL79KRQLz928K3Z
         RHBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776221; x=1785381021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbLnq6v8Q/claMZ0r3UT7Ku3TaaAf3P6/lFlwBQj1fo=;
        b=QVR+HLkprO763Oq8HkxdwxolEE0B7SYefs+U+ahdqGW/lEonU7Sr1OC2wJfeWrjN2W
         oDzyet+ctOxhgLgyz8bQVhQ+qs41r6O/xcYfQ+9yPxmej44xcdkoIvoiEB14h09+f8pf
         XaJStmMxxZLL5645/VkJOt6kabS/H5L+oV207OxzPRn11nDSzjWFy9hbg1wDkw2uRfn4
         9jxxWY06TcpX0cUFyDDiaJmRTOLanYDimDTwnv/xH43k7z3dcYiEnkIqBm2JMVdQnBte
         mjNMrNE054ke01+y7grZ9PwXABCvYGKzbzYj3revzAKA/8bYSmnMD7CmXu9/5+E34KJ/
         m8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776221; x=1785381021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbLnq6v8Q/claMZ0r3UT7Ku3TaaAf3P6/lFlwBQj1fo=;
        b=bijFsDBioiNWopcpmDDQmPAPw7+z56x+mHjqXH/EPf4JAo9ySaIXBkxAoj86DZXp/x
         ivVxFn3VMhuiG9hREAC2O8wq0AvR6R2ZM1VL36xGRql0yRWR1hy04un5k+qDJtaLMCxB
         nlGNQiAasH88PcACg+I34lAvicK0Ta8Hp8jNbkY9f2O8hcu0Yo1mblnkdVq/XAppfsMS
         5L+287+HYU++hBif4y/ulEiX7Dqq4k5UlIvRyxOFOXFgYhOVazvqAhZd/zl9GOJbQrb1
         OHMfuF3LLkmvHmNehI0h2Qcm4g/eOeav2ZuzOIp1iHOvkJFlTPBKG0Y8j8iKIG/dsCZr
         UaJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3FVlWe54XQTDaNMtwQhvh9e+WjkNuW4mZYC85kuN90lz3Ill0wgvY+YBgmiPvxuBQYP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvvakdPGKi9cskromHv8/9XnpCccJVMVSeq+YhnUvGGZ+m1bC
	Z+9M6wzWc/tdVUXHf1pSqJnGPt6GHO11xLdRIuF9KfsqZEb/Z/2rL093HWrwQ5STmRBvvCjaOuy
	NchjYIh9zYE2AWzqtKJLsq9RCDDAXzI3t+SMwj/kG
X-Gm-Gg: AR+sD12E3zwX3OUkBC3/XqdNpDWpPvIL3pmDahz6ks0h7V4CzqWlc8PI/VKVBwaPmF3
	RX1ge5Z9k+TfP9Ms8Ld4Jislh98NOT2MciRvqlZFz58bY19VKrrkocdhgO35doD4OuYMHZewuxv
	Ldr+O+Z6vTVCbQxyz/fbBaNZu859g3Q/Q6jj+3tqY/O10xQhHsZV2XMHXCsL08ycLwqae2UH3zl
	UD3OYoBjvGNs0angNQqZSc1RILQ5ShnupmocF5zuUKUzmM23/Cg/C8qJJxvtQ==
X-Received: by 2002:a05:6402:a6c9:20b0:697:5678:bc77 with SMTP id
 4fb4d7f45d1cf-69f6cd0cdb9mr17539a12.9.1784776220652; Wed, 22 Jul 2026
 20:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-8-zide.chen@intel.com>
 <CALMp9eQyMe6MfYPkvYAZPm+6A+FK6ZYpGv5Wx+nVvi9GtumA+g@mail.gmail.com>
 <f16aea7f-6b5a-4980-91b4-a41931b797ec@linux.intel.com> <CALMp9eQapUpDBd5iwvw7OVkm8oUaVcD9KQwdgyA57mNiWe9jgw@mail.gmail.com>
 <1a21ba1c-a195-43aa-9a9f-c0326a78c0a5@linux.intel.com>
In-Reply-To: <1a21ba1c-a195-43aa-9a9f-c0326a78c0a5@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 20:10:07 -0700
X-Gm-Features: AUfX_my7q19_NdMuTKOOJHH3aNM69JPdNAfB0-4ZPzRnGkX0YR__KlReqDC5mdU
Message-ID: <CALMp9eTOQJ1_QMazU3v_TAXupNfZTLsYta9wi7iRBy37P8WqTA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:53=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/23/2026 10:25 AM, Jim Mattson wrote:
> > On Wed, Jul 22, 2026 at 6:44=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 7/23/2026 8:02 AM, Jim Mattson wrote:
> >>> On Mon, Jun 29, 2026 at 4:29=E2=80=AFPM Zide Chen <zide.chen@intel.co=
m> wrote:
> >>>> If the host has the PERF_METRICS capability but it's not present on
> >>>> the guest, RDPMC interception must be enabled and KVM should inject
> >>>> an #GP when the guest attempts a PERF_METRICS RDPMC.
> >>>>
> >>>> If the guest has PERF_METRICS but RDPMC interception is enabled for
> >>>> other reasons, KVM needs to emulate RDPMC with type 2000H.
> >>>>
> >>>> For simplicity, Metrics Clear Mode is not supported.
> >>>>
> >>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >>>> ---
> >>>> v6:
> >>>> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
> >>>> - Reject non-zero index.
> >>>> v5:
> >>>> - new patch.
> >>>> ---
> >>>>  arch/x86/kvm/pmu.c           |  7 +++++++
> >>>>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
> >>>>  2 files changed, 21 insertions(+)
> >>>>
> >>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >>>> index 8ef2d4761790..04b9c840f218 100644
> >>>> --- a/arch/x86/kvm/pmu.c
> >>>> +++ b/arch/x86/kvm/pmu.c
> >>>> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct=
 kvm_vcpu *vcpu)
> >>>>  }
> >>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept)=
;
> >>>>
> >>>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> >>>> +{
> >>>> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) =
&&
> >>>> +               !kvm_vcpu_has_perf_metrics(vcpu);
> >>>> +}
> >>>> +
> >>>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
> >>>>  {
> >>>>         struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> >>>> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *v=
cpu)
> >>>>                 return true;
> >>> I know we have a strong disagreement here, but I really feel that thi=
s
> >>> must be secure and future-proof out of the box.
> >>> What if we added a module parameter, enable_rdpmc_passthrough, which
> >>> defaults to false?
> >>>
> >>> Then:
> >>>
> >>> if (!enable_rdpmc_passthrough)
> >>>         return true;
> >>>
> >>> Is that a reasonable compromise?
> >> Yes, this is an option. Another option is to add a helper to explicitl=
y
> >> tell which platforms are secure and can pass-through rdpmc. Maybe like=
 this,
> >>
> >> static bool intel_pmu_can_passthrough_rdpmc()
> >> {
> >>     switch (boot_cpu_data.x86_vfm) {
> >>     case INTEL_ICELAKE_X:
> >>     case INTEL_SAPPHIRERAPIDS_X:
> >>     case INTEL_EMERALDRAPIDS_X:
> >>     case INTEL_GRANITERAPIDS_X:
> >>     ... ...
> >>         return true;
> >>     default:
> >>         return false;
> >>     }
> >>
> >>     return false;
> >> }
> >>
> >> Then rdpmc can be passed through by default on these known secure
> >> platforms. For any new platforms, the rdpmc would be intercepted out o=
f
> >> box until we confirm it's secured and explicitly support them.
> >>
> >> How about this? At least for me, it looks like an overkill to disable =
rdpmc
> >> passthrough unconditionally on these known secure platforms.
> > The F/M match would only apply on bare metal, since you can't trust F/M=
 in a VM.
> >
> > What if we combine this with the module parameter, but now the module
> > parameter defaults to true? Somewhere in module load, we have:
> >
> > if (boot_cpu_has(X86_FEATURE_HYPERVISOR) || !intel_pmu_can_passthrough_=
rdpmc())
> >         enable_rdpmc_passthrough =3D false;
>
> It looks good to me. :)

On second thought, it doesn't really matter if L0 has lied to L1 about
F/M. If the hardware supports more RDPMC types than the L1 virtual CPU
does, L0 must intercept and emulate RDPMC for vmcs01. Even if L1
decides to pass through RDPMC to L2, L0 will still intercept and
emulate RDPMC for vmcs02.

So, we can drop the module parameter and just use
intel_pmu_can_passthrough_rdpmc().

To keep the list short, I assume that any CPU with only three fixed
counters will return true.
