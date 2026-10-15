Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F44A841E
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107752; cv=none; b=d5Om+mugM53FBJlARyW5yZdCkBwLrygdm+wfPzJxZtPnMxo12FT3wj+4rg+Ha6WX0cFfRBY27ZjPxbzX9WFRx239Nclo17D9d6TQUWRy3+jAWlPTL9i+c27cDdvgBviKNaNSmSXPIMZ6RE7egZLV+gBxUhF1fp2uKYfmTDAvgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107752; c=relaxed/simple;
	bh=zIfQfyWdm/mRO86YRBRJEHuDEG9JavTCbhEpWUpQpQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mb+3gkvRqzyLdOKHjkrMStAFWArd3P/cT5cYJZzCiKQ8b2No4QO/fPuFBrBgvtdeQOK3tZ1ExF7Xv74U4Qa0UHK1swaksyR0nWj9ubd6XhJ5rQ8+WWdhsE3eqXfTOayFkbcDYLpRx9vZmDb05VkxPPYita2l76xPKEOWGVJxkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAwJgXGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAwJgXGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1EE1F000C8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792107751;
	bh=MHyrrK0NSeUKokoxsXxbF8iSiJx7KDQFcgTZU79vtrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HAwJgXGen3GLw6mh0Kp9pZwu7fL6uR4Lzqex4eQRRqNNdmAYRrbLSdUnHahUjZZaA
	 1XTmTnrVF6hE/5cbDenaQPbKsWCmYj5Gxjh7m+18vjt6RSqUGalqtrM/5t4JlwxuGj
	 8g8pUJ/XzoPqS280RiwIuMR4MpVuZ4rDY5I+lXmM/qUMybFNz3Usym4FMxdQcNWFCy
	 fzm5bhRME3KKo70xT11vQS6v+I24ZZvzcmNND2DLcO7mFu6hocs6Z7+vaCgUpxkJjs
	 SnDG1d2KXej8FIuxwpfLjEfGDFYCmVyt+fmMTmLYuzKIkBgePJ3CcqcphQgqWzfNwB
	 JDsynq1RlYYfA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3ee49054ecso205749066b.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwn60edDcSSU5jAkV1/GKIxeIME6rviztvMtIrQDq450loiTDqFl642hGYRA3EBZCv4vJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg7Hyb21GHH5KM4UgGOr7apYAySL8wi1hVB6rll5tg1ZX8bJee
	WM57YEukO2YK15riRHumOYJTmt9t9RH0XAvmvz22BEEykortZY5eYc9hZSsBFBXwaFj4ecXzjAb
	9dIEiMQQQkIlIMzvCZX4K3DdapXTmz38=
X-Received: by 2002:a17:907:3da8:b0:c25:2d27:5652 with SMTP id
 a640c23a62f3a-c31a9fa18b8mr2025050866b.11.1792107749989; Thu, 15 Oct 2026
 16:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-25-yosry@kernel.org>
 <CALMp9eRb3ExsQ0g24YQyo85sV1fnHZadh33hBChUY=ZGUaT7jA@mail.gmail.com>
In-Reply-To: <CALMp9eRb3ExsQ0g24YQyo85sV1fnHZadh33hBChUY=ZGUaT7jA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 16:42:16 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMt5ZNwr3Y+NfFcAW5Cf4JaerCScSsLxcvsvHYR=DoYBw@mail.gmail.com>
X-Gm-Features: AclHuK_BxDLZx_69rvrkhE3klfjCf7dhg2cmw_bJjPWnJRq4Cq4UBgg350NqnWY
Message-ID: <CAO9r8zMt5ZNwr3Y+NfFcAW5Cf4JaerCScSsLxcvsvHYR=DoYBw@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:37=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > KVM currently handles INVLPGA in the same way as INVLPG, flushing L1's
> > own ASID. This is currently correct because L1 and L2 share an ASID, bu=
t
> > it doesn't work once they have separate ASIDs.
> >
> > If L1 is flushing a different L2 ASID than the one KVM is tracking, do
> > nothing, as KVM will flush L2's ASID in hardware (and sync the MMU if
> > needed) when L1 switches to the target ASID.
> >
> > If L1 is flushing the tracked L2 ASID, flush the L2 ASID in hardware
> > using INVLPGA if running on the same CPU as L2. If not, fallback to a
> > VMCB-based ASID flush. Note that if L2 then runs on a different CPU KVM
> > will flush the ASID anyway.
> >
> > If NPT is disabled, also free L2's roots, as they may have stale
> > translations for the flushed address. Do not try to sync the mappings
> > for the flushed address as it involves walking L2's shadow page tables
> > with L1's MMU context. This is similar to INVVPID handling in with nVMX=
.
>
> Nit: s/in with/with/
>
> >
> > Note: If L1 is flushing its own ASID, it remains handled the same way a=
s
> > INVLPG. Additionally, if INVLPGA is executed by L2 (and not intercepted
> > by L1), also handle it like INVLPG. Technically, L2 could be flushing a=
n
> > untracked ASID, in which case KVM doesn't need to do anything. However,
> > kvm_mmu_free_guest_mode_roots() does not handle being invoked in guest
> > mode, so using kvm_mmu_invlpg() in guest mode side-steps this, and
> > should not happen with a well-behaved L1 anyway.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 8f2542357e78d..436d13f106369 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2468,17 +2468,61 @@ static int clgi_interception(struct kvm_vcpu *v=
cpu)
> >
> >  static int invlpga_interception(struct kvm_vcpu *vcpu)
> >  {
> > +       struct vcpu_svm *svm =3D to_svm(vcpu);
> >         /* FIXME: Handle an address size prefix. */
> >         gva_t gva =3D kvm_rax_read(vcpu);
> >         u32 asid =3D kvm_ecx_read(vcpu);
> > +       int cpu;
> >
> >         if (nested_svm_check_permissions(vcpu))
> >                 return 1;
> >
> >         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> >
> > -       /* Let's treat INVLPGA the same as INVLPG (can be optimized!) *=
/
> > -       kvm_mmu_invlpg(vcpu, gva);
> > +       /*
> > +        * INVLPG on a non-canonical address is a NOP according to the =
SDM,
> > +        * assume the same behavior from INVLPGA since the APM doesn't =
specify.
> > +        */
> > +       if (is_noncanonical_invlpg_address(gva, vcpu))
> > +               return kvm_skip_emulated_instruction(vcpu);
>
> If L1 is in 32-bit mode with junk in RAX[63:32] (e.g. bits left over
> from long mode), the full 64-bit value may not be canonical. Should
> the kvm_rax_read(vcpu) above be kvm_register_read(vcpu,
> VCPU_REGS_RAX)?

Doesn't kvm_rax_read() already use kvm_reg_mode_mask() as per
__BUILD_KVM_GPR_ACCESSORS()?
