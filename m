Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191523164BB
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380198; cv=pass; b=G24AxRNlbu1DW8Lzf/Qm8G7O1cht/23y2ZiS3eYl4Qmuu929TjFlzy8buqHAHHiBwiq8k1O53W6QyvcparpZo5zGjjBngjCW1LJZJuBGp/5siSl+Y3Q6t0SZZOKuFCnPVMjbxlr+Rv3HI1ghvPJX0dC8bf0e0/wYhF1FMNVJe54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380198; c=relaxed/simple;
	bh=mEt7BTLlT6ZmZ/T1Y186yJ8NgnFN2QYNlg4b2uk7RIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ5wL4JoFFHoo7ScjAvyqU+AV7sHlBT+7NeN9FjmfuOZs94vkzs2nuo8/xcLsIOwh1Gdfew444QiJelScS5LfQlKsw5sOPZ97mUTcNN++3KRLlfwBoXWOzOyreRBFW5E5PgsV9TWq0CVBpz/U5MQXhs9Kuq2WxMRnNVrt2AKb0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBOGXIWZ; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBOGXIWZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a018cbbf8so37034076d6.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 22:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773380196; cv=none;
        d=google.com; s=arc-20240605;
        b=IQXKBN2u7DQY0UV4KpjoW9YZCdYJgzSxxkVYvLhH25mfbM2rLs9uCURQQ/xj64GwB7
         nGfYo8KP5IyqMm1hDvwBoLB/pGzKlu2eUKPH+XU/M74fHGqZzQrGeLXI0k7HHNgHv9Z9
         e8Z/LW4PxyGHzXL/0vx3Pleekpi+gT341LKuo/aJDl/CkoVQdaC8RJlvf9LR87vhwokl
         SyNwCp8ZDUn3mQMj6ECT4g9gkLu42AuOJ8/3SPPFOR4Vujyveo6k8iIrkIAlx1Ar32Mn
         O5g+Y0yp/5VUEmd/MsdEGYckqE9zwqd/zpcUyhY7f0b3E5TJYU7Cco5hq6X+MVp/vwNJ
         B6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gj0nSDykG0Fr+XFA6s/JJt4kLIyT6T9zrksdte2qMsk=;
        fh=bJV2jYsW2s9l6Nh0Ff2eYJaFVhXwzn5xc+jIHBiDHxk=;
        b=Ez9rkTduKl4CoWI6NAQnxwucQyjjuDUnwwnckKHTbZbZZZseAAEynFMwiKUIZsrgEx
         AM7CQA2z3dI0n9DR9/JRwCvDHyVsgceZtla4nhpEnA9Cz0sUA2muCP28cCcjailJqqzV
         ypnUlUeSdM6LF6BmyLB6QipKS2/Eo3p/7bYQVqzICSpVyJ+i2/cj0r3rzC1X728Y64Bc
         QDRIJc35L4Mrn8RthNSpy5/0gnBgolWvH3ozPmlvU04v6M1IbzplSuvAd4UKhoJXZoSc
         6LmzRItxhLdnBP4rk0PFNTKQeOlf3m+14T3s0iEGLJne/SvENvdyPX+KmwSfEAMb39NP
         jRxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773380196; x=1773984996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj0nSDykG0Fr+XFA6s/JJt4kLIyT6T9zrksdte2qMsk=;
        b=UBOGXIWZMScWKLDfcZDBzGt3wpcU2oesbhFu8toekGa5LMf2BZuLLk1ys3c7956jXp
         /M4K9CtaT1JBgy/GX7GaSjcsuGw/ktj115d8kyNnd4zTTDRHKpTKiLHmcPeuT55DmvxB
         wf6CL1hqogeM//i23z0alYytwZjwHBtmPbdJRm7+qfeKbDACHB/eK6qWoMquqVTIhoX0
         0rGYApL7G2zp0uCg3l7J5BOCNmoE1aUAEejicmewpp7k0dAfdd7/T002wWs9276LOqNI
         ElA/RJXMbYhvtaYkBQ8CEZ9R5yaMBk7Y9fLoxHHfjxb8dsg7W7Skc34VvPabEuCtr3rV
         HAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773380196; x=1773984996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gj0nSDykG0Fr+XFA6s/JJt4kLIyT6T9zrksdte2qMsk=;
        b=TotJESgtbUFfE3XHDeoUSPphuD4gk0zHsHBpdJw2kr90miVjwXf7HcbDNR0nOxXpX1
         zKQgbSaeMOPZqmcXM2BiGLieB3d1FUZ0gTCFdydP4MwDDiWYqf4zDuuncRF8KOTEzYYy
         j2l64k9xmKJGY8vbTu72VcVZhVOBWRCyXGCzdufNOgtFnrnrvC6Nq4+C4KhPvHl1/uYb
         GH63/PQMZgV1V0OvN5W/QLsgWr+TYNXevjiXiiq7G1Hu62RbxUmHR5oFg03Mz542HxgW
         upkv9+J7vqYoVkCLRPL/G5mOcSlxn6jEHX4XeboBJxlcCzYzda//qknelZx2QDTK4zNA
         bbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXr62Lj9+gLhoD4FVgqt2kLFybzbMcp7S/G9iMV0EjtntWrikZmuHhxc0sSAU5r7AjjZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzS7jmvpiNrJt/FkP/hA6Jj4bjB0CxbA9Y2kdXkZVR4AsUB4j
	fR5f0E7A/zFJ3dw8mktxnPu5imhAaiR87zIkb/rRf+0fgNxPIhoUEGXjWM2NoM7pSq/Ncor1WwY
	VFzS8hkLSW01bNm6kQooxcFd6YHsUPle7SbAt0bsl
X-Gm-Gg: ATEYQzw5Q8lcBqCfKAoS3M6HwYarwN0hXpz0xhtb69mjb/2RabVHIcIKabnSi7JpwlT
	7SgrQzahtQkdfTnNoiE2LrMrAGUPxBveFUhs1Mw9Q3szdy8u8jo75j2J5jyTB+xhHn6SdM+su58
	7n6edv8IF34XwFLtigSmtPjdFJE7XFMSZVrMC0BFmOpEqgnXYVofEjUrU+75+rvXwnVCpi5n9lk
	A7uDb8E/bmLIF5XzbD8t92adazEaMIOHGLWi7CSdObfdqdqgMSCwYumUapMiDp+FL/VnqfDwrdt
	R2u0lf1vKWAK/2sP0o5oG8n6BvlyoqUQpmBHZkZ/Ng==
X-Received: by 2002:a05:6214:2aa8:b0:895:4d9b:a436 with SMTP id
 6a1803df08f44-89a72ac6a7bmr81371716d6.30.1773380195520; Thu, 12 Mar 2026
 22:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224071822.369326-1-chengkev@google.com> <20260224071822.369326-3-chengkev@google.com>
 <aZ3VCq4s7l9f4JTw@google.com> <CAE6NW_ZAMp68iUzv-6m05LuU7g-fUy6e3mcD_+4NbvWp3RgCeA@mail.gmail.com>
In-Reply-To: <CAE6NW_ZAMp68iUzv-6m05LuU7g-fUy6e3mcD_+4NbvWp3RgCeA@mail.gmail.com>
From: Kevin Cheng <chengkev@google.com>
Date: Fri, 13 Mar 2026 01:36:24 -0400
X-Gm-Features: AaiRm52WTXhf5zRPMFn33miV0djPOneYnNZS5bMY4Jd7XKb3QZlW98OPJqv2670
Message-ID: <CAE6NW_Z1vRV8OzWqNAKUbDHUgX-Mci1o26SGT79564VV3YdH1Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] KVM: SVM: Fix nested NPF injection to set PFERR_GUEST_{PAGE,FINAL}_MASK
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 12:50=E2=80=AFAM Kevin Cheng <chengkev@google.com> =
wrote:
>
> On Tue, Feb 24, 2026 at 11:42=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Feb 24, 2026, Kevin Cheng wrote:
> > > When KVM emulates an instruction for L2 and encounters a nested page
> > > fault (e.g., during string I/O emulation), nested_svm_inject_npf_exit=
()
> > > injects an NPF to L1. However, the code incorrectly hardcodes
> > > (1ULL << 32) for exit_info_1's upper bits when the original exit was
> > > not an NPF. This always sets PFERR_GUEST_FINAL_MASK even when the fau=
lt
> > > occurred on a page table page, preventing L1 from correctly identifyi=
ng
> > > the cause of the fault.
> > >
> > > Set PFERR_GUEST_PAGE_MASK in the error code when a nested page fault
> > > occurs during a guest page table walk, and PFERR_GUEST_FINAL_MASK whe=
n
> > > the fault occurs on the final GPA-to-HPA translation.
> > >
> > > Widen error_code in struct x86_exception from u16 to u64 to accommoda=
te
> > > the PFERR_GUEST_* bits (bits 32 and 33).
> >
> > Stale comment as this was moved to a separate patch.
> >
> > > Update nested_svm_inject_npf_exit() to use fault->error_code directly
> > > instead of hardcoding the upper bits. Also add a WARN_ON_ONCE if neit=
her
> > > PFERR_GUEST_FINAL_MASK nor PFERR_GUEST_PAGE_MASK is set, as this woul=
d
> > > indicate a bug in the page fault handling code.
> > >
> > > Signed-off-by: Kevin Cheng <chengkev@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |  2 ++
> > >  arch/x86/kvm/mmu/paging_tmpl.h  | 22 ++++++++++------------
> > >  arch/x86/kvm/svm/nested.c       | 19 +++++++++++++------
> > >  3 files changed, 25 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> > > index ff07c45e3c731..454f84660edfc 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -280,6 +280,8 @@ enum x86_intercept_stage;
> > >  #define PFERR_GUEST_RMP_MASK BIT_ULL(31)
> > >  #define PFERR_GUEST_FINAL_MASK       BIT_ULL(32)
> > >  #define PFERR_GUEST_PAGE_MASK        BIT_ULL(33)
> > > +#define PFERR_GUEST_FAULT_STAGE_MASK \
> > > +     (PFERR_GUEST_FINAL_MASK | PFERR_GUEST_PAGE_MASK)
> > >  #define PFERR_GUEST_ENC_MASK BIT_ULL(34)
> > >  #define PFERR_GUEST_SIZEM_MASK       BIT_ULL(35)
> > >  #define PFERR_GUEST_VMPL_MASK        BIT_ULL(36)
> > > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging=
_tmpl.h
> > > index 37eba7dafd14f..f148c92b606ba 100644
> > > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > > @@ -385,18 +385,12 @@ static int FNAME(walk_addr_generic)(struct gues=
t_walker *walker,
> > >               real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(ta=
ble_gfn),
> > >                                            nested_access, &walker->fa=
ult);
> > >
> > > -             /*
> > > -              * FIXME: This can happen if emulation (for of an INS/O=
UTS
> > > -              * instruction) triggers a nested page fault.  The exit
> > > -              * qualification / exit info field will incorrectly hav=
e
> > > -              * "guest page access" as the nested page fault's cause=
,
> > > -              * instead of "guest page structure access".  To fix th=
is,
> > > -              * the x86_exception struct should be augmented with en=
ough
> > > -              * information to fix the exit_qualification or exit_in=
fo_1
> > > -              * fields.
> > > -              */
> > > -             if (unlikely(real_gpa =3D=3D INVALID_GPA))
> > > +             if (unlikely(real_gpa =3D=3D INVALID_GPA)) {
> > > +#if PTTYPE !=3D PTTYPE_EPT
> >
> > I would rather swap the order of patches two and three, so that we end =
up with
> > a "positive" if-statement.  I.e. add EPT first so that we get (spoiler =
alert):
> >
> > #if PTTYPE =3D=3D PTTYPE_EPT
> >                         walker->fault.exit_qualification |=3D EPT_VIOLA=
TION_GVA_IS_VALID;
> > #else
> >                         walker->fault.error_code |=3D PFERR_GUEST_PAGE_=
MASK;
> > #endif
> >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index de90b104a0dd5..1013e814168b5 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -40,18 +40,25 @@ static void nested_svm_inject_npf_exit(struct kvm=
_vcpu *vcpu,
> > >       struct vmcb *vmcb =3D svm->vmcb;
> > >
> > >       if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> > > -             /*
> > > -              * TODO: track the cause of the nested page fault, and
> > > -              * correctly fill in the high bits of exit_info_1.
> > > -              */
> > > -             vmcb->control.exit_code =3D SVM_EXIT_NPF;
> > > -             vmcb->control.exit_info_1 =3D (1ULL << 32);
> > > +             vmcb->control.exit_info_1 =3D fault->error_code;
> > >               vmcb->control.exit_info_2 =3D fault->address;
> > >       }
> > >
> > > +     vmcb->control.exit_code =3D SVM_EXIT_NPF;
> > >       vmcb->control.exit_info_1 &=3D ~0xffffffffULL;
> > >       vmcb->control.exit_info_1 |=3D fault->error_code;
> > >
> > > +     /*
> > > +      * All nested page faults should be annotated as occurring on t=
he
> > > +      * final translation *or* the page walk. Arbitrarily choose "fi=
nal"
> > > +      * if KVM is buggy and enumerated both or neither.
> > > +      */
> > > +     if (WARN_ON_ONCE(hweight64(vmcb->control.exit_info_1 &
> > > +                                PFERR_GUEST_FAULT_STAGE_MASK) !=3D 1=
)) {
> > > +             vmcb->control.exit_info_1 &=3D ~PFERR_GUEST_FAULT_STAGE=
_MASK;
> > > +             vmcb->control.exit_info_1 |=3D PFERR_GUEST_FINAL_MASK;
> > > +     }
> >
> > This is all kinds of messy.  KVM _appears_ to still rely on the hardwar=
e-reported
> > address + error_code
> >
> >         if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> >                 vmcb->control.exit_info_1 =3D fault->error_code;
> >                 vmcb->control.exit_info_2 =3D fault->address;
> >         }
> >
> > But then drops bits 31:0 in favor of the fault error code.  Then even m=
ore
> > bizarrely, bitwise-ORs bits 63:32 and WARNs if multiple bits in
> > PFERR_GUEST_FAULT_STAGE_MASK are set.  In practice, the bitwise-OR of 6=
3:32 is
> > _only_ going to affect PFERR_GUEST_FAULT_STAGE_MASK, because the other =
defined
> > bits are all specific to SNP, and KVM doesn't support nested virtualiza=
tion for
> > SEV+.
> >
> > So I don't understand why this isn't simply:
> >
> >         vmcb->control.exit_code =3D SVM_EXIT_NPF;
> >         vmcb->control.exit_info_1 =3D fault->error_code;
>
> The issue with this is that the PFERR_GUEST_FAULT_STAGE_MASK bits are
> not set in the walker fault error code for hardware reported NPFs
> (non-emulator faults).
>
> The active mmu after an NPF exit from L2 is the guest_mmu. In
> walk_addr_generic, we only set the PFERR_GUEST_FAULT_STAGE_MASK bits
> in the fault error code if kvm_translate_gpa returns INVALID_GPA (i.e.
> when mmu =3D=3D &vcpu->arch.nested_mmu and the translation fails).
> Otherwise, kvm_translate_gpa just returns the gpa and we don't set the
> PFERR_GUEST_FAULT_STAGE_MASK bits in the fault error code.
>
> Even when we NPF exit from L2, the hardware-reported exit_info[31:0]
> isn't accurate which is why we drop 31:0 in favor of the fault error
> code. I observed the hardware error code vs fault error code while
> running the KUTs (specifically the tests that expect faults) in
> https://lore.kernel.org/all/20260312200308.3089379-9-chengkev@google.com/
> and they were not as expected. I believe I saw different error codes
> because the entry existed in L1's NPT, but not yet in L0's NPT? The
> hardware-reported error code usually did not reflect the L1 NPT page
> permission restrictions, only the type of access/op that caused the
> fault. Additionally, the present bit was not set.
>
> If L2 has never accessed a GPA present in the L1 NPT with restricted
> permissions, we could see differing error codes between hardware and
> the fault error codes. I think that is why the code before my change
> dropped bits 31:0 in favor of the walker fault error code. I'm not
> entirely sure though so I could be wrong.
>
> Since the guest_mmu walker can't know whether the GPA it's translating
> is a page table page or a final page, I think we are stuck with
> combining bits 63:32 from the hardware reported error code and 31:0 of
> the fault error code for the non-emulator NPF injection case.
>

Oops this was already pointed out in
https://lore.kernel.org/all/aZ4J0flo0SwjAWgW@google.com/ lol
