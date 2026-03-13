Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF52772D
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773377442; cv=pass; b=nH7NTMeJRtcgFd2RKyhjaAUtAvpDQOArVYeHrTJbBd9/Js4AwxA7zKGiDlAuLRHlTzEnqMz1Q0wPubTczs8ZjpwcQNdhmCGidaQw1rF13qaht2Yf0nEr0YJ+vMJZmYaHDfNq3oyexJoBsnIZFDXH8aP5NdxBplRlNnXKXafoXm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773377442; c=relaxed/simple;
	bh=72A9waejWXUVAIEDwV0IdSAciOSXgYBh97oZH41tJ9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScrFVh0VFHRbS9jBMXVTN5hB2Wf9Ap9xG3nW9RcR09gqPcXXA18FS8AGYKUU9dCWvLrTjMxIN31yZLmBml2TOhdjApetHLAnJOkm7unb7hPhj8lzdQnDLtzKf5GBdvEocM4ZUnm++ASHhEtINTMMvFUnFPu9bzOZxkVVZzGw+FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc9KeNqQ; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc9KeNqQ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a1c6dd788so14924836d6.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 21:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773377439; cv=none;
        d=google.com; s=arc-20240605;
        b=WT6+JO/pCCa4sHZmPtN3UYwCT45AoT9cNSf2n3w81JkvML12frGytD8JO3H+on5IP7
         6Z769IzNpvSx17+0U6ryiUZqi2IaVKeeHF/A4d1nKQCdW4XYh8Vw9iUROeAjN8udpv/T
         NdrVegCY0Dc29IrAR/xxttwaaXUwpgUuWdqz4V30COUsHx53yjA95Ca5OKrrfUUjaAVM
         F5SI1qfHFRlaHyOBY6VJfQOB56Nb4xpV6Bw7d9VHUofuW0PN1gx8kcmf9MqvfHq2RKLD
         WDBwU53BpPfomU8bnDZL8xMR1ve7OU/pc4jKfb2hvQ3Jc2NQ0YDq60A5mo/PcecT4d4B
         vUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kio61zYI7mm/YU2bDKE/VU4tMY7Psr4/FGJZNjzbmro=;
        fh=lcKPJ4tT5QRqT3umExoMHa6UNMJ8163XN/EtxkMzCgM=;
        b=K98PYZbr5j6nog0TiGqlh/4bTRU8/IzTdxbTmY9RdtjvwYSLIsWy6axCB2fGL15xeT
         fYLdTMOnxM+rfSmee6jtEIoIGYzCgXcF8+bX5GapPm9HIaohJ4RmoipGr8O+19E3mZk5
         afWifzC1hEX5At1kWMTca6yta3C7iz13n4N56A2MS9xmH2R7xzwf5+eYSp7DE79pC0gU
         NpbaVpR/Q2JWwlksFvHREo3M/tF9Q0OMLLGPa3FglEmwSIhsDp978tbC9Du1UMG+dSeO
         ciug9qgk4i2kI6RJtWBXYkkybjFLci5gQE9O7NoO/ZSN85iT5EHiF8lwJQO8WxTA0kEj
         SfEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773377439; x=1773982239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kio61zYI7mm/YU2bDKE/VU4tMY7Psr4/FGJZNjzbmro=;
        b=mc9KeNqQqd+jzukgOWZShYmqkwcjiWCKJuZcR840KnlsPxpZ3GCnfoRksRB2HBmjOe
         7lR8gfeyIenfXc8uOa6b3i/I/L8UruGL3TPHs/NSCU5Rj5WmgfxVIfQRFLbWw5pFMZfP
         6gPBrncUgRj7EfiOQHZcNvhXCjx16mDHoprtFYQ7JHqmc0dYgAc04Flu3wMcJDEiswSQ
         5uk2VZeDUnYM6we0ylRclWDrWSV9fXVpcCfLO3zc8lObcp5lyoxWubPElMoAcFJsXMVy
         4OpYn17H4tHjS4AeNpYSg21B7UTQ+V066hVudqXNjZEhOW2fLW+fmXPVopQhjOckzwhF
         OWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773377439; x=1773982239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kio61zYI7mm/YU2bDKE/VU4tMY7Psr4/FGJZNjzbmro=;
        b=Sl/i0YX24lp3r/KJ/TAq4t8mp9hGk+ja1lXFLDJaFKB1ya9FYD2cYP8y8VwfUIYNnF
         Ds9GmPAzwkPqzXiktjU9M9PAIzgZW22JEBVcLziFj1hnLrwc8oNchUK+rj3kj87fHUr1
         4QEyJPH5gcHG6N/P4ZsxOLEENIuOn4RMBdKzFMN2rCb0VTDgK5UPw3Rndys0ZxmcpWvZ
         uxBImgITNZAGCo1pkGLJKMnSNNVXAcq5IvrlfvicKDh0Q4jpvdcSL9U9161ZZtbThDYR
         B6gWHWVk8ywotp4Ht1U5jfKJiXlw6Of05oxjQ9uK2PgDUG7UmxuAKz2KXFUWhXnp1W4T
         Rj7w==
X-Forwarded-Encrypted: i=1; AJvYcCUU9jrZPaiDUeLavcKjVyfc8UqEnvxVOuLGCMyvRvx8DRnUmHj8VZE1jGCnP41vunlXl/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSjAXJ/w5h7Gk2JOsky+c/oES4LD2P95ydhsuYzkmin4oZdEo
	rcaDMrDxzo6BlKh3Ykvqna8oHnPfjHEDizUtRRNnEkmAz/zy+kyGlUHGuoTNMlUGeHdoGBG/2dA
	cg7A/qARyxI14UBOBrGtbVBqmVYVte5KYiioCGA/I
X-Gm-Gg: ATEYQzwqEkZNMe7HAJWWwFFuqPEfEiQqJ3lz1Y9OzKgBVCPN9LEA73LdqUixShftyqi
	pfFK9bLJW3/iRrvxDuctic61wtsiiI+Iy9MmOdfy6HvZsHCGcZZ0xXSbTowVIMDW+esRIcgmMyY
	WJGF9kFG7R7gZL+JsD8E7wdp3bR5USd34mwPladBj1tpJ84F4z/dGUPSI4njq8mbrZbx5fzthWJ
	L9tNpMxFhA9VxOWMaChFqpKqBxryVnfI/efdMRVekBWiEQY+iL0MDWE6kIfiGTWFtFi6GZ9iwXJ
	U8Jp3xeNblMxTCL6fvqXVv9LLO2y/+BQ+d9F5kTp0g==
X-Received: by 2002:ad4:5ca2:0:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-89a81dde5abmr37146716d6.23.1773377438820; Thu, 12 Mar 2026
 21:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224071822.369326-1-chengkev@google.com> <20260224071822.369326-3-chengkev@google.com>
 <aZ3VCq4s7l9f4JTw@google.com>
In-Reply-To: <aZ3VCq4s7l9f4JTw@google.com>
From: Kevin Cheng <chengkev@google.com>
Date: Fri, 13 Mar 2026 00:50:27 -0400
X-Gm-Features: AaiRm52yLnLHRjylHDW06lqPmbISCceiZtPDCd4StfZlTt0rPWQM6nssC1S82Mw
Message-ID: <CAE6NW_ZAMp68iUzv-6m05LuU7g-fUy6e3mcD_+4NbvWp3RgCeA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] KVM: SVM: Fix nested NPF injection to set PFERR_GUEST_{PAGE,FINAL}_MASK
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 11:42=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Feb 24, 2026, Kevin Cheng wrote:
> > When KVM emulates an instruction for L2 and encounters a nested page
> > fault (e.g., during string I/O emulation), nested_svm_inject_npf_exit()
> > injects an NPF to L1. However, the code incorrectly hardcodes
> > (1ULL << 32) for exit_info_1's upper bits when the original exit was
> > not an NPF. This always sets PFERR_GUEST_FINAL_MASK even when the fault
> > occurred on a page table page, preventing L1 from correctly identifying
> > the cause of the fault.
> >
> > Set PFERR_GUEST_PAGE_MASK in the error code when a nested page fault
> > occurs during a guest page table walk, and PFERR_GUEST_FINAL_MASK when
> > the fault occurs on the final GPA-to-HPA translation.
> >
> > Widen error_code in struct x86_exception from u16 to u64 to accommodate
> > the PFERR_GUEST_* bits (bits 32 and 33).
>
> Stale comment as this was moved to a separate patch.
>
> > Update nested_svm_inject_npf_exit() to use fault->error_code directly
> > instead of hardcoding the upper bits. Also add a WARN_ON_ONCE if neithe=
r
> > PFERR_GUEST_FINAL_MASK nor PFERR_GUEST_PAGE_MASK is set, as this would
> > indicate a bug in the page fault handling code.
> >
> > Signed-off-by: Kevin Cheng <chengkev@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  2 ++
> >  arch/x86/kvm/mmu/paging_tmpl.h  | 22 ++++++++++------------
> >  arch/x86/kvm/svm/nested.c       | 19 +++++++++++++------
> >  3 files changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index ff07c45e3c731..454f84660edfc 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -280,6 +280,8 @@ enum x86_intercept_stage;
> >  #define PFERR_GUEST_RMP_MASK BIT_ULL(31)
> >  #define PFERR_GUEST_FINAL_MASK       BIT_ULL(32)
> >  #define PFERR_GUEST_PAGE_MASK        BIT_ULL(33)
> > +#define PFERR_GUEST_FAULT_STAGE_MASK \
> > +     (PFERR_GUEST_FINAL_MASK | PFERR_GUEST_PAGE_MASK)
> >  #define PFERR_GUEST_ENC_MASK BIT_ULL(34)
> >  #define PFERR_GUEST_SIZEM_MASK       BIT_ULL(35)
> >  #define PFERR_GUEST_VMPL_MASK        BIT_ULL(36)
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_t=
mpl.h
> > index 37eba7dafd14f..f148c92b606ba 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -385,18 +385,12 @@ static int FNAME(walk_addr_generic)(struct guest_=
walker *walker,
> >               real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(tabl=
e_gfn),
> >                                            nested_access, &walker->faul=
t);
> >
> > -             /*
> > -              * FIXME: This can happen if emulation (for of an INS/OUT=
S
> > -              * instruction) triggers a nested page fault.  The exit
> > -              * qualification / exit info field will incorrectly have
> > -              * "guest page access" as the nested page fault's cause,
> > -              * instead of "guest page structure access".  To fix this=
,
> > -              * the x86_exception struct should be augmented with enou=
gh
> > -              * information to fix the exit_qualification or exit_info=
_1
> > -              * fields.
> > -              */
> > -             if (unlikely(real_gpa =3D=3D INVALID_GPA))
> > +             if (unlikely(real_gpa =3D=3D INVALID_GPA)) {
> > +#if PTTYPE !=3D PTTYPE_EPT
>
> I would rather swap the order of patches two and three, so that we end up=
 with
> a "positive" if-statement.  I.e. add EPT first so that we get (spoiler al=
ert):
>
> #if PTTYPE =3D=3D PTTYPE_EPT
>                         walker->fault.exit_qualification |=3D EPT_VIOLATI=
ON_GVA_IS_VALID;
> #else
>                         walker->fault.error_code |=3D PFERR_GUEST_PAGE_MA=
SK;
> #endif
>
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index de90b104a0dd5..1013e814168b5 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -40,18 +40,25 @@ static void nested_svm_inject_npf_exit(struct kvm_v=
cpu *vcpu,
> >       struct vmcb *vmcb =3D svm->vmcb;
> >
> >       if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> > -             /*
> > -              * TODO: track the cause of the nested page fault, and
> > -              * correctly fill in the high bits of exit_info_1.
> > -              */
> > -             vmcb->control.exit_code =3D SVM_EXIT_NPF;
> > -             vmcb->control.exit_info_1 =3D (1ULL << 32);
> > +             vmcb->control.exit_info_1 =3D fault->error_code;
> >               vmcb->control.exit_info_2 =3D fault->address;
> >       }
> >
> > +     vmcb->control.exit_code =3D SVM_EXIT_NPF;
> >       vmcb->control.exit_info_1 &=3D ~0xffffffffULL;
> >       vmcb->control.exit_info_1 |=3D fault->error_code;
> >
> > +     /*
> > +      * All nested page faults should be annotated as occurring on the
> > +      * final translation *or* the page walk. Arbitrarily choose "fina=
l"
> > +      * if KVM is buggy and enumerated both or neither.
> > +      */
> > +     if (WARN_ON_ONCE(hweight64(vmcb->control.exit_info_1 &
> > +                                PFERR_GUEST_FAULT_STAGE_MASK) !=3D 1))=
 {
> > +             vmcb->control.exit_info_1 &=3D ~PFERR_GUEST_FAULT_STAGE_M=
ASK;
> > +             vmcb->control.exit_info_1 |=3D PFERR_GUEST_FINAL_MASK;
> > +     }
>
> This is all kinds of messy.  KVM _appears_ to still rely on the hardware-=
reported
> address + error_code
>
>         if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
>                 vmcb->control.exit_info_1 =3D fault->error_code;
>                 vmcb->control.exit_info_2 =3D fault->address;
>         }
>
> But then drops bits 31:0 in favor of the fault error code.  Then even mor=
e
> bizarrely, bitwise-ORs bits 63:32 and WARNs if multiple bits in
> PFERR_GUEST_FAULT_STAGE_MASK are set.  In practice, the bitwise-OR of 63:=
32 is
> _only_ going to affect PFERR_GUEST_FAULT_STAGE_MASK, because the other de=
fined
> bits are all specific to SNP, and KVM doesn't support nested virtualizati=
on for
> SEV+.
>
> So I don't understand why this isn't simply:
>
>         vmcb->control.exit_code =3D SVM_EXIT_NPF;
>         vmcb->control.exit_info_1 =3D fault->error_code;

The issue with this is that the PFERR_GUEST_FAULT_STAGE_MASK bits are
not set in the walker fault error code for hardware reported NPFs
(non-emulator faults).

The active mmu after an NPF exit from L2 is the guest_mmu. In
walk_addr_generic, we only set the PFERR_GUEST_FAULT_STAGE_MASK bits
in the fault error code if kvm_translate_gpa returns INVALID_GPA (i.e.
when mmu =3D=3D &vcpu->arch.nested_mmu and the translation fails).
Otherwise, kvm_translate_gpa just returns the gpa and we don't set the
PFERR_GUEST_FAULT_STAGE_MASK bits in the fault error code.

Even when we NPF exit from L2, the hardware-reported exit_info[31:0]
isn't accurate which is why we drop 31:0 in favor of the fault error
code. I observed the hardware error code vs fault error code while
running the KUTs (specifically the tests that expect faults) in
https://lore.kernel.org/all/20260312200308.3089379-9-chengkev@google.com/
and they were not as expected. I believe I saw different error codes
because the entry existed in L1's NPT, but not yet in L0's NPT? The
hardware-reported error code usually did not reflect the L1 NPT page
permission restrictions, only the type of access/op that caused the
fault. Additionally, the present bit was not set.

If L2 has never accessed a GPA present in the L1 NPT with restricted
permissions, we could see differing error codes between hardware and
the fault error codes. I think that is why the code before my change
dropped bits 31:0 in favor of the walker fault error code. I'm not
entirely sure though so I could be wrong.

Since the guest_mmu walker can't know whether the GPA it's translating
is a page table page or a final page, I think we are stuck with
combining bits 63:32 from the hardware reported error code and 31:0 of
the fault error code for the non-emulator NPF injection case.

>
>         /*
>          * All nested page faults should be annotated as occurring on the
>          * final translation *or* the page walk. Arbitrarily choose "fina=
l"
>          * if KVM is buggy and enumerated both or neither.
>          */
>         if (WARN_ON_ONCE(hweight64(vmcb->control.exit_info_1 &
>                                    PFERR_GUEST_FAULT_STAGE_MASK) !=3D 1))=
 {
>                 vmcb->control.exit_info_1 &=3D ~PFERR_GUEST_FAULT_STAGE_M=
ASK;
>                 vmcb->control.exit_info_1 |=3D PFERR_GUEST_FINAL_MASK;
>         }
>
> Which would more or less align with the proposed nEPT handling.
>
> > +
> >       nested_svm_vmexit(svm);
> >  }
> >
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
