Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523275;
	b=nMf4Xe6M/3PnK/Mnvtf5P2sRctLqL0j1dFQDJGEs4Baxz2nyCry8SwoG+VSLpK4l1yHu
	 8/dQsFaQjQ1X+ZpZyn58NS737toKz7ViUl+3/rpgJgccRQv2RgQkpLQhKZzcF1vrTe6rf
	 DmjkwBj4L+XnOj7VJc5X7tofHOehmbnmCKq2IzgDLqApZ/yLU2pXmfUgQCtaGDE6ogLn5
	 6/+aTXVRDhXqR2B0+/+G6M/YkhrDglKHhmrrsU2pS2odtVvOdCY5m40eW5YYnwlIFcQVX
	 RLDTx/8BIqABsJVHtBFdaBSPb6TtDWcfGI8Y2WkkHa4yYVKUR93Raz+NgCFKYb0zDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523275;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8Mqlwa6EX3DhYKNmeMt2IGTARTOODXfafQJowRn4dlM=;
	b=3mNMlODQ58aRNE9j7Tpweo4qxqDvlHVCXkUm4nupNHUOkhyIk8bU6zoxLcNb4B00RKPY
	 GaI9IaACAG4Cv+Inc00vUTQCUM+Slp8No8Yct3qeiuU9zcoApgyNNZdRTKv6++2wfiPh3
	 TdK7Jh4upkwmxFBKviBUER5hqzKaqsyzDBQQzDIRaHUV0FbPlC7rWQEYsddOG+wd5sMRB
	 gTOqce1vd3OnwqKqCqlTe+CJXOJmL92zZW4taz1oWd6MbxKp5irOrbJfEJXOkGQkcjMRl
	 Qua6IjG7XdAEY8/n3PpCDGvyxFUPlwdC6dej2ixJ0CwpNQg5nT1lWrITE61NCeqXQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEz0rFk4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916E606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEz0rFk4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E41F000C5
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523275;
	bh=8Mqlwa6EX3DhYKNmeMt2IGTARTOODXfafQJowRn4dlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iEz0rFk4pcrqXqU+BQldjX3tyQ2671GVCvFqd0kWoAc8QviKfCEIeiN3Kx6uhPxdF
	 utPgLyhtTsNElrHLA04HCJJu8sUzswM0Di/1xwsJZaevuXjEEX5S80dmE7iQ7u9PK9
	 ryz4/odhO85LJ8cdMxBnc9sMjC9ccJb0VCtOhppwx6GlgYo3yVZLt0KKsYvHqxELYq
	 Ztidx9YkbQnprLVIWjwfE4CtHwKOxKLYlXvfSUA/1q1dWTwkaA8OOGWUu7rnKQOsyT
	 JUumxDhRGaMh6J+Z0D+vXFbcKaPzzzWf74pIHEz9mIPLGHoV4SoIka1fJO5VUoyYg3
	 X2F04FUeyX+bQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40f29667e6so35867466b.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:41:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE8TkFPSIkbSeMW9SoBVjC0uTg2vpphtAMz2MOPTJrVUDV7poA4ApeDc+gFYMS0QfbDWRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z++TJG/nDe6Q1wxn7jJzeh/RVA2JRtXeOZMe4Yof935nUFYT6Ug
	m4GGSJqEAiKuJ/l1KwuYCOdSCvQGvSFQI+lAI357s80jheczDxjbwB+nRt1JyqH6/gBTGotvddj
	2K2g7GVT+Zb0dFyQ33rLjYBYX29S6/pY=
X-Received: by 2002:a17:907:d7cb:b0:c50:6222:7b0b with SMTP id
 a640c23a62f3a-c509619b3c6mr57994366b.2.1794523273963; Thu, 12 Nov 2026
 14:41:13 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112212628.265262-1-jmattson@google.com>
In-Reply-To: <20261112212628.265262-1-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 12 Nov 2026 14:41:02 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMkKXRT0N18haYG+=jyO6FvL7VE84-=n9kpm7vnARH5UA@mail.gmail.com>
X-Gm-Features: AclHuK-hQsdGLd3NwGyUYGMiZEoeH0DYgS5sqPTrrpIqwcFjykynjnQHXUyAQXI
Message-ID: <CAO9r8zMkKXRT0N18haYG+=jyO6FvL7VE84-=n9kpm7vnARH5UA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state()
 on guest SHSTK
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:26=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> Like nested_vmcb02_prepare_save() and nested_svm_vmexit_update_vmcb12(),
> svm_copy_vmrun_state() should gate copying s_cet, isst_addr, and ssp on
> guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) (i.e. the feature is advertise=
d
> to the guest). Instead, copying is gated on
> kvm_cpu_cap_has(X86_FEATURE_SHSTK) (i.e. the host supports shadow stacks)=
.

This is a bit confusing, nested_vmcb02_prepare_save() and
nested_svm_vmexit_update_vmcb12() are about vmcb12 <-> vmcb02, so L2's
state, while svm_copy_vmrun_state() is for L1's state. I think the
patch is correct, but the examples are confusing.

Perhaps a better example would be __kvm_set_msr() and __kvm_get_msr()?

>
> Check guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) instead of
> kvm_cpu_cap_has(X86_FEATURE_SHSTK) in svm_copy_vmrun_state().
>
> Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from=
 vmcb12/vmcb02")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1299fdadeb73..b73bc9c3ebdb 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1248,7 +1248,7 @@ void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, st=
ruct vmcb_save_area *to_save,
>         to_save->rip =3D from_save->rip;
>         to_save->cpl =3D 0;
>
> -       if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
>                 to_save->s_cet  =3D from_save->s_cet;
>                 to_save->isst_addr =3D from_save->isst_addr;
>                 to_save->ssp =3D from_save->ssp;
> --
> 2.56.1.703.gf848ed807c-goog
>
