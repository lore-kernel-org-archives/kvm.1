Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55940B6C3
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820319; cv=none; b=cbEkNlR2ochXC4I+cKIZ2guhiQc+yjSQ+RbC9scVg8+YjbcDUl0SWHD2c2oA2wYs6LT4E0zDv6N+EpQ+WgZwz+MeT14yFPByFw2gjulVNVx7WxMriQf8KM3Nk0mSEXhlob2uy76L+ted1qHyVFYebBVx7F5DFF8lI9EvMRnOfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820319; c=relaxed/simple;
	bh=Cg7dczjcT2ZewLtHQrJjhi+FX0sH21uHc8VAENcNe9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa4Cz8ZKOOks4TmVmlqCzheGEF8sV4lZWl0X6MjLG6w9v84vpEcssQDaB+SUnIizjAqFTU19UJ9uNNPxS1ifBf4uzk/p5fjz2/YZ4p2vahk6OgL7WB6TpJuZ91NvDU+XowIFitgQ6yuKukYCVd0G4HLMWcHdFMDOZrO1//IW7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvqzgu55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvqzgu55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121AD1F00A3E
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779820318;
	bh=eEPiWcBYWLBQgSJw8g/tV0hZMvXuK3lxYxueGxGt+7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rvqzgu55ae/a4FtK8pAxCRxbNyvHVkY2MXJXHKnQbF2N/LzO+eZUwtbM4laAzK0YT
	 s07r7XitpBZylW5ZjbepOgm2/Si/e/JVsvTv54pAYcSRhEP8uYnSgqvRyKOZ37+CO4
	 /pRQ04YeSmvN/X5zWOifaeTmZdSVuzt1pFlS0bRsq2olVjf0Kr47Z9EymBDymXAtFI
	 UbglYS3Lcjajug0LrY3RVGqdONLDsdbl3HEW6QueVPd8F4imPEhckL1LxNStng8NyW
	 xCIdB7gExB/Yx2xNee3Sin1XUcn3TRunAXpHPdMItGFttzcOMOozxMOHOhQgChKQqk
	 sa4K4qUxzo0xw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so1507628a12.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:31:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vuonEMLbAwoCpcHYQuArr8bwxAAzrdCHBUDcSl9GXP+mhYyX2e5saZd++7yt9rgxQ5g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVL1kC+950iGskATmbmLwQiK6lrauyQeB630aCl5aoAXmu6g/
	KQw/EPytMSkw8RAU405wrDBS9nqIjnFw5BsSSiqVcm/saFQZg7oHfrhh3UOF2y6jEgIa9xMuADZ
	b2Seg5KOvJ49DY/lPbCa+flXiPVaX8lw=
X-Received: by 2002:a17:907:a80c:b0:bd5:ec9:e063 with SMTP id
 a640c23a62f3a-bdd267cae6cmr1198794666b.49.1779820316976; Tue, 26 May 2026
 11:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-4-seanjc@google.com>
In-Reply-To: <20260522232701.3671446-4-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 11:31:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com>
X-Gm-Features: AVHnY4J_1fdnhkQ0Py-uRXObO7sDEeAhFrVHWci4hpsgIrEd2EUWmPz46ue-Xnc
Message-ID: <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] KVM: SVM: Fix nested NPF injection of
 PFERR_GUEST_{PAGE,FINAL}_MASK bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> From: Kevin Cheng <chengkev@google.com>
>
> Fix KVM's generation of PFERR_GUEST_{PAGE,FINAL}_MASK bits when injecting=
 a
> Nested Page Fault into L1.  Currently, KVM blindly stuffs GUEST_FINAL int=
o
> L1, which is blatantly wrong given that KVM obviously generates NPFs for
> page table accesses.
>
> There are two paths that trigger NPF injection: hardware NPF exits (from
> L2) and emulation-triggered faults, i.e. when KVM detects a NPF as part o=
f
> emulating an L2 GVA access.  For the hardware case, use the bits verbatim
> from the VMCB, as KVM is simply forwarding a NPF to L1.  For the emulatio=
n
> case, propagate the GUEST_{PAGE,FINAL} bits from the access field (which
> were recently added for MBEC+GMET support).
>
> To differentiate between the two cases, add "hardware_nested_page_fault"
> to "struct x86_exception", and set it when injecting a NPF in response to
> an NPF exit from L2.

hardware_nested_page_fault is no more.

>
> To help guard against future goofs, assert that exactly one of GUEST_PAGE
> or GUEST_FINAL is set when injecting a NPF.  Unlike VMX, there are no
> (known) cases where hardware doesn't set either bit, and KVM should alway=
s
> set one or the other when emulating a GVA access.
>
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> [sean: use plumbed in @access bits, massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
[..]
> @@ -39,19 +39,32 @@ static void nested_svm_inject_npf_exit(struct kvm_vcp=
u *vcpu,
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
>         struct vmcb *vmcb =3D svm->vmcb;
> +       u64 fault_stage;
>
> -       if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> -               /*
> -                * TODO: track the cause of the nested page fault, and
> -                * correctly fill in the high bits of exit_info_1.
> -                */
> -               vmcb->control.exit_code =3D SVM_EXIT_NPF;
> -               vmcb->control.exit_info_1 =3D (1ULL << 32);
> -               vmcb->control.exit_info_2 =3D fault->address;
> -       }
> +       /*
> +        * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
> +        * available in the hardware exit_info_1, since the guest_mmu
> +        * walker doesn't know whether the faulting GPA was a page table
> +        * page or final page from L2's perspective.
> +        */
> +       if (from_hardware)
> +               fault_stage =3D vmcb->control.exit_info_1 &
> +                             PFERR_GUEST_FAULT_STAGE_MASK;
> +       else
> +               fault_stage =3D fault->error_code & PFERR_GUEST_FAULT_STA=
GE_MASK;
>
> -       vmcb->control.exit_info_1 &=3D ~0xffffffffULL;
> -       vmcb->control.exit_info_1 |=3D fault->error_code;
> +       /*
> +        * All nested page faults should be annotated as occurring on the
> +        * final translation *or* the page walk. Arbitrarily choose "fina=
l"
> +        * if KVM is buggy and enumerated both or neither.
> +        */
> +       if (WARN_ON_ONCE(hweight64(fault_stage) !=3D 1))
> +               fault_stage =3D PFERR_GUEST_FINAL_MASK;
> +
> +       vmcb->control.exit_code =3D SVM_EXIT_NPF;
> +       vmcb->control.exit_info_1 =3D fault_stage |
> +                                   (fault->error_code & ~PFERR_GUEST_FAU=
LT_STAGE_MASK);

Do we need to do this in the common path? If from_hardware=3Dtrue, can
the fault injected by KVM have different flags from the one produced
by hardware? I guess the answer is yes, (e.g. if KVM is doing
write-protection?). Might be worth a comment.

> +       vmcb->control.exit_info_2 =3D fault->address;
>
>         nested_svm_vmexit(svm);
>  }
> --
> 2.54.0.794.g4f17f83d09-goog
>
>
