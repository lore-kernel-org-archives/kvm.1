Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EA2D12EE
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566088; cv=none; b=b9lqQd+3rbCdVRIlZLwcrkUkaeztPkG1GlioG2FMziZpc8oyb3gYY5eyd56G02WuyTptT3G4tjWAs5+0ImFO7TqPhmV8Ei2qXtmyuCxLMPFUSMYvymkEUX/mlELQXZVPvma6oirc+wJRSw6T3SqufIMnKu4W2KAISisWrhGgTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566088; c=relaxed/simple;
	bh=oi1W3NLbeXxYdC5S2uq+tjxxlqM49zMNzuaPvr0tJEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H57C5/VtzwP39P6a8NSC7jFL0e8TemZPuGpL/e+dIg63Us/0Oli918hYyPxbjj/6gXYznLnuMQGVdk5axox0rT/MYptxS3et0wHFySOAsGm7duU1E2VRNC+OuesifDzgUqE04nTiZkCCHovfoRXZPvrWLx5rWTRHAb/SVm4hnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOo7LUiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOo7LUiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941321F00AC4
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785566086;
	bh=viEcGw43l3/qu2oiS0HVN8jBSSg678iOH4Bba7bOiyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TOo7LUiAKcxAHH5JfKdL6w66Wycs3hl/3t6kzbiUV/k29hu7i8JCvL0MnUWS80Nmn
	 lvz39yy3REACq8n3A2CP9RvcvvDnSYcfGhOJAz1QFuKTzt3i7Io03cpDqkAwA4UudI
	 VKziJ9du1z/GTQh0eqSg+aS+qT6CSf82Eu0ZpaNEU8P1xLMClDH3DSzQ4QlacnYLjE
	 cvy+kdUccirN2I3iqPfyLYbBAO64zbd6naLo8yObvKlQmax+DT+4e5ALpcHg+Crxgp
	 eRL+O6K1xaAiwFaUf2D8wiJT38sZMmF5/hw6PSO6F8uyxIDtCek2+IESKz1Ei+bCv2
	 CZo3uZVd5CanQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a08a2b7e5bso1627374a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:34:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpV4Ij+VLi9F+CRFuOEE4TPyM8hVGBQavDAicbrmqxBof9wm0Q4VSiwKWEwnseTdP3Rab8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAyEXMUGXG4eg8rIeXAqvSskihZxdu7/dvvba1j/iJUHSLZUv
	DQztbtURvxIFSYM4xrQC70keu+HjSVVIQM6L20/6oAF3L2qeI6KFLs1W5B7iYWEN8onROYq6CmD
	7ApBsSsFF0kR16djCkaLgq+QPYNmnTT4=
X-Received: by 2002:a05:6402:14f:b0:6a0:50d8:142d with SMTP id
 4fb4d7f45d1cf-6a09aaa1ce4mr1622572a12.0.1785566085571; Fri, 31 Jul 2026
 23:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-13-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-13-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:34:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPoeV6H61vwO06Wj=ed+5_tUC8LVqEf=zp-U-axvxNt3g@mail.gmail.com>
X-Gm-Features: AUfX_mzH20a-P4n3dnVx3GzQwnjl850rbsMOJrvZQRzwlA8799UeimG3r9gIFvk
Message-ID: <CAO9r8zPoeV6H61vwO06Wj=ed+5_tUC8LVqEf=zp-U-axvxNt3g@mail.gmail.com>
Subject: Re: [PATCH v1 12/28] KVM: nSVM: Add a placeholder ASID for L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> In preparation for introducing a separate ASID for L2, introduce a
> 'placeholder' ASID that is still the same as L1's ASID. This will
> facilitate future changes that need to distinguish L1 and L2's ASIDs,
> before actually using a different ASID for L1 and L2.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 5 +++--
>  arch/x86/kvm/svm/svm.h    | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index ed4af5a08f794..eb60d6b959d86 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -698,7 +698,6 @@ static void nested_svm_transition_tlb_flush(struct kv=
m_vcpu *vcpu)
>          *  - Honor L1's request to flush an ASID on nested VMRUN
>          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
>          *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
>          *
>          * [*] Unlike nested EPT, SVM's ASID management can invalidate ne=
sted
>          *     NPT guest-physical mappings on VMRUN.
> @@ -928,7 +927,7 @@ static void nested_vmcb02_prepare_control(struct vcpu=
_svm *svm)
>         else
>                 vmcb02->control.bus_lock_counter =3D 0;
>
> -       vmcb02->control.asid =3D vmcb01->control.asid;
> +       vmcb02->control.asid =3D svm->nested.asid02;
>
>         /* Overwritten later if necessary.  */
>         vmcb_clr_flush_asid(vmcb02);
> @@ -1498,6 +1497,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
>         if (!svm->nested.msrpm)
>                 goto err_free_vmcb02;
>
> +       svm->nested.asid02 =3D svm->asid;
> +

From internal Sashiko:
---
Does caching the ASID here risk leaving nested.asid02 stale during an
intra-host SEV VM migration?

If userspace restores EFER.SVME on a destination vCPU before completing
the migration, svm_allocate_nested() is called and nested.asid02 is
initialized with a normal non-SEV TLB tag.

Later, when KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM completes the migration,
sev_migrate_from() updates the primary ASID but misses this new
nested.asid02 field:

arch/x86/kvm/svm/sev.c:sev_migrate_from() {
        ...
        dst_svm->asid =3D dst->asid;
        sev_init_vmcb(dst_svm, false);
        ...
}

When L1 subsequently executes VMRUN to enter L2,
nested_vmcb02_prepare_control() will assign this stale non-SEV
nested.asid02 to vmcb02->control.asid.

Does this mismatch cause L2 to run with an invalid non-SEV ASID while the
VMCB's SEV bit is set, resulting in an unconditional #VMEXIT_INVALID
hardware fault?
---

I am starting to hate SEV..

This would also be correct if the vCPUs are created on the destination
VM before it's marked as an SEV VM. This is a recurring theme at this
point.

>         svm->nested.initialized =3D true;
>         return 0;
