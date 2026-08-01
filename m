Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0C30675F
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564946; cv=none; b=KpL2vKuoILJn0RZP4tm6akMykjRIv+ZyP+wyVU7XZgwPSWojV/vVSLrBRmkYbmMCHZIX9zd5WkyhklWrVGFTimgcEJz0pkliv1R5EV3CLDmWcNOvdXSGMUl7I38TA81YoPKbKcid0y84QM0DE9pLivJxtZCXzPaxCmURsp/JxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564946; c=relaxed/simple;
	bh=PbodEEfZRtjMMfKEr3s6bzvShev0V8zJiHE0xbYkI6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3A8qTnQB143gbbn/MPA8NRNdJ0oNKT++uS6XLs8Oi5iHTVXlIhVEjQplJStT4OaiXDzNRaTdAR3bFzt1m7DJvywRnALXla7gJmdi9uyAIdNkZmoKxnC3a0i5IQBqgdLGtGdsURLmXaS/KNJB/krupc3vjVWiruqQeg/yBfrGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fon3BGNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fon3BGNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153951F00ADE
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785564945;
	bh=camr5nxdYv69+7IxiU28Rk2vN3FmKTmpC4vbb1pvmpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fon3BGNdPc79lARMs5FwFWCdGAVNSv8jG/9mIn9poWSslRkQnggEzv78OGbmo2da3
	 RknX/kXzZGD0lVDm082vzyX13tV/wh9UGx70/ZGDUe8n2JxPQXB33vkMntjAMmI1fm
	 mGg1f5of44uBGtOGsPdNLlN/s0rtyQqs3G3oMG/2UEoWETjCnAJqCAcbZhLewxVwwV
	 679TDSsGAtENl/OJgFmvSb/0lxpL7GGbMgf0WqESrSaeAECWPlcp5YKFzFr0SoJgib
	 3ix4myIrOj+oGzZze051kQ+liX4WfpkGDDFDKDFsbhSE7AMnrT4cKuFziazGNtMus4
	 9pyrl27CvgZbg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c197e7e4e94so297300966b.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:15:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp+qXdsdNsqq+VIbdkxuELRlky6wdmTE7k1VEEF5AYyihV+3n9weiv6NYi079dKgT4VDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YdnFcojtH2X2kYC+VgSOhj7SpLfNm0OJ8dJGJvp0njST4evA
	+RE7pkWRlVlYSZD4vjffV4Z7PvxMnhutlEVIAtmjFr6NQp+Ohu79AKtes7nmPQTmuYOKIkzPvDa
	m5SYvBp2hWsKIqFkyxNS/WUxXf4u/MT4=
X-Received: by 2002:a17:906:ee8e:b0:c1f:7c45:2dfa with SMTP id
 a640c23a62f3a-c1ff2ea19d8mr29606566b.7.1785564944017; Fri, 31 Jul 2026
 23:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-9-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-9-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:15:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPdbGovC=iuge7Gcv87dQMOEotpyQ+gqLp38MPrZQD4aQ@mail.gmail.com>
X-Gm-Features: AUfX_mwp7jwCqisRQhYwiXYgISwa9BoTdzwyNhS9JENS1aoXfP1iKwfXE8YGw-U
Message-ID: <CAO9r8zPdbGovC=iuge7Gcv87dQMOEotpyQ+gqLp38MPrZQD4aQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/28] KVM: SEV: Do ASID initialization at VMCB initialization
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> The per-vCPU ASID does not change for SEV guests, so move the per-vCPU
> (and per-VMCB) ASID initialization to sev_init_vmcb() to do it once,
> instead of checking before every VMRUN.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/sev.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0e5046a12a970..8717da0e9fe8a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3580,14 +3580,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
>         if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
>                 cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus)=
;
>
> -       /* Assign the asid allocated with this SEV guest */
> -       svm->asid =3D asid;
> -
> -       if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> -               svm->vmcb->control.asid =3D asid;
> -               vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
> -       }
> -

From internal Sashiko:
---
Does removing this dynamic ASID assignment break nested virtualization for
SEV guests?

If a guest is configured with both SEV and nested virtualization, KVM
switches svm->vmcb to the dynamically allocated vmcb02 when intercepting
VMRUN.

Since vmcb02 is zero-allocated during svm_allocate_nested(), and
sev_init_vmcb() is only called for vmcb01 during initial vCPU creation, won=
't
vmcb02->control.asid remain 0?

When KVM then executes VMRUN to enter the nested guest, it seems the hardwa=
re
would reject the invalid ASID (0) and immediately crash the guest via a
hypervisor entry failure (SVM_EXIT_ERR).

---

Yeah I think this is correct, but it gets fixed in patch 12 when we
explicitly initialize the ASID in vmcb02. I can fix it if I re-spin,
but I am not sure how much we care about breaking bisection for nested
on SEV.

>         /*
>          * Flush guest TLB:
>          *
> @@ -4829,6 +4821,10 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init=
_event)
>         svm->vmcb->control.misc_ctl |=3D SVM_MISC_ENABLE_SEV;
>         clr_exception_intercept(svm, UD_VECTOR);
>
> +       svm->asid =3D sev_get_asid(vcpu->kvm);
> +       svm->vmcb->control.asid =3D svm->asid;
> +       vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
> +
>         /*
>          * Don't intercept #GP for SEV guests, e.g. for the VMware backdo=
or, as
>          * KVM can't decrypt guest memory to decode the faulting instruct=
ion.
> --
> 2.55.0.229.g6434b31f56-goog
>
