Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00197423EB0
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777732; cv=none; b=jjNk2XZEtWd/TAbCKA5x3YVFAjrJ/RlZJhC/SMhpS6Tkhi8cPlRaLfirizi6qAO99sfUJyhmHUfIa1dnTLjXZ0eTA95QI/vk6Uv7EQOXRrAp9IqYjuPCKLThv4s7FwgXu5mFUfCsWCOI9WVMye0y8FhoJu6KVTX8zaciLKWmYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777732; c=relaxed/simple;
	bh=gTgQSmBE+r+iar07Jae2NQ8DsEkJUSa+ZqcZKGl3F8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePhPGYHeimZaBQdy0w+2dJmRj05EQeL6Y1KKuNE0IYhTFXegd7PNAYNnM8d1zgBnSSDzpGNemkQe3DUqGtk6T6/NpN19aHo4etVRbzT/ZD/6Kd+BsRIdC6/s3M337T1b9XahWJbaEG+9Vy6zcSeVGe0rELJgntDzMSfIwtgij5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVtFfAsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVtFfAsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08AB1F00AC4
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777730;
	bh=Yk5slSieC/CU7tsLjWCOdn7b11iCwR3umpnuQdQLwak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PVtFfAsFoNkwyF9wScBe39Unh0qWbabS1YgzBv3XR59zYW5FaB3JC8+OAlWgi3w6A
	 ckd7i9lqu/bkgpUfUH60vtEAu0lGnXwjsdjLsgnJT2DOLZrL4PLenb2KaMduGKv1Ko
	 wuAq12bQUD/29KaWYoUcKSakMNai6irebNPLy0S2ty3BTulKyeqOBRDVrS7OlPOKvl
	 dQSvau6XyyBOYSytOgX1AkxpP+Xwf+VsXn9CmzKspyBACIARFCzsNM/z7CwM4+XB8a
	 Jr2Y/lZlBTr/KCZkkwYTyyJuBbQBKL+1XvSDvdg8AmWf5jE/cZp3swtwNvmVD3Bfsi
	 JKKxc6f547grQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso215949a12.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 10:22:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqqjQRRnpTdnZr5zte80p8YKCfjhXlbGmQUeTANb1Z4oEtVH4gGgZYznCseMe1p7bFKd3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vQC8Kb8lmYLkuMhH47113pUnDSXvo3cgRStLhuitHEpzXLaA
	zsrs7a5zHBFa37eYQHhC7jni2tKIMsRs9FCnl9hEEpKLjTw+eplXYSgSRRXuELaGXDg+4VJ+7Cn
	zJBPYOiEWFf/upSLbjrGgxcRGXpn6eAQ=
X-Received: by 2002:a17:906:7944:b0:c12:525b:4e7d with SMTP id
 a640c23a62f3a-c20247da30cmr35710366b.15.1785777729744; Mon, 03 Aug 2026
 10:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-26-yosry@kernel.org>
 <CAO9r8zOKXjiaYer9d1bpDsGqgbRybR-kys7=VS5+bgamhH7LkQ@mail.gmail.com>
In-Reply-To: <CAO9r8zOKXjiaYer9d1bpDsGqgbRybR-kys7=VS5+bgamhH7LkQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 3 Aug 2026 10:21:57 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPq6j54qjSpx974+7LJ_behFs0R2Nk9yziVbcgbiro76Q@mail.gmail.com>
X-Gm-Features: AUfX_mz7YWhrREaV4IA-vywsQPLiJzkZFwq8IcY9HnCKrftBoH0XoxO7Xhr6Hhs
Message-ID: <CAO9r8zPq6j54qjSpx974+7LJ_behFs0R2Nk9yziVbcgbiro76Q@mail.gmail.com>
Subject: Re: [PATCH v1 25/28] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e4bda43238654..d7b20941b1fee 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2425,17 +2425,51 @@ static int clgi_interception(struct kvm_vcpu *v=
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
> > +        * assumethe same behavior from INVLPGA since the APM doesn't s=
pecify.
> > +        */
> > +       if (is_noncanonical_invlpg_address(gva, vcpu))
> > +               return kvm_skip_emulated_instruction(vcpu);
>
> From internal Sashiko:
> ---
> This is a pre-existing issue and was not introduced by the patch under re=
view,
> but if L1 is configured for 4-level paging and L2 is configured for 5-lev=
el
> paging, could this drop valid INVLPGA TLB flushes for L2?
>
> Since vcpu represents L1, the check is_noncanonical_invlpg_address(gva, v=
cpu)
> uses L1's canonical boundaries. If L1 executes INVLPGA to flush a valid 5=
7-bit
> virtual address for the L2 guest, will KVM incorrectly deem the L2 addres=
s as
> non-canonical and silently skip emulation?
>
> Bypassing both the hardware TLB flush and shadow page table synchronizati=
on
> could allow L2 to continue accessing memory through old translations,
> potentially leading to memory corruption or security boundary bypass
> inside L2.
> ---
>
> I need to take a closer look here, but if this is indeed an issue,
> even if pre-existing, it would only matter with this series. Before
> this series, even if INVLPGA is ignored we flush everything before
> running L2 anyway.

I don't think this is an issue. is_noncanonical_invlpg_address()
doesn't use "L1's canonical boundaries". It calls
is_noncanonical_address(.., X86EMUL_F_INVLPG), which calls
__is_canonical_address(.., max_host_virt_addr_bits()). So the
canonicality checks depend on the host support, not L1's CPUID or
configuration.

The only potentially interesting case is if hardware
only supports 48-bit addresses and L1 decides to emulate 57-bit
addresses (e.g. emulate 5-level paging on HW with only 4-level paging
support). In this case (if it all possible to begin with), I assume
it's L1's responsibility to make sure this is emulated correctly (e.g.
intercept L2's page faults with higher bits set).
