Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895133F8C2
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566489; cv=none; b=VopBwoFYmwc4XQE3eaI3lWZYnkqLCTZjARbxlQls4CN2aoA9QDpgV9PibeBU4Hg7haK/WAZJVRWNGd3l3ZaEmdGzKvtf8GBJVg3XxnhBhT+vvB6cu0Q2rodYV2OK95QhrT4I6X3Nd5yaHAX77lTAUPA1VDBn31Tr1y3TGQv0YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566489; c=relaxed/simple;
	bh=9W9I6Mut9UlHTkBBzYbcAzGmNn1rzr6XntnFJakWJyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jodvInsyjEQjce2sYYZ1Dy6aQwj+RsFGsqt0lD5YuPe49F7pffmxyCWp5+EX3rCmW4OjmQaL89nub6Bb91rJTHgA6IYZOIoWrd0duipeVDnQF+zkJeJeNKGgp1OcT61kh1a/KAUpyZ6OXSznqyHgg4KynVyBQ/ySGpHVMOETijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH5vbA6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH5vbA6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BCC1F01558
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785566488;
	bh=D+BEtAEyqaIvHmSoWkS3xFEHntHE4DTGSCwZ5pVOqHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gH5vbA6GI0fTjLQQh8A0fwyxXHm1Y/c5i2xrEzyDLOTjWHBijjvOYqJ1IVbco2Cnk
	 EvPPOhexv4Vza44miCYL4jBl7PaVsw8Zea+76jPpd7JjbjgpGKG1i4kEjcqW8Z3bkt
	 OewGUAy3pqxZteaxxLLuOnO/XfhlaKLyPBbf88IIqjQU3TwW0D6CwB+fBhw94+ZOTr
	 zMGs00tmf1vb5n57yEc7fpGQVDczNkGVBLI97M7WzZCOOXF+CrXCo6lOp6Nzk5l12Q
	 2QeOlMy01cHU+cCBNfpaXbHCHTHp2JSKWVwOV8YEiTcFW7bT/LDy5SBtpIsBWyanTi
	 xsh9Y3X91cpRw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15d111ca99so184236866b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:41:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrrEvZvDCjguzkjN6MfJseuPunW+st/35BqTYShEa5bPA/S8L+V3PeLX8uvGN5ZILqDjeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPjpLDIbjrSTz5spRY6LGY97LZn03cPcl9sUjWMnwWrBr4UPe
	kUbB2G+ZSmTemCWSTW2uq6eP9TRtAMQurJPdQYh7fKqLdyFYXAbNpyGjbYts2bXuvK7DA2/NMhB
	USDork2mqUoeVg8q1kKMfLPaRSEF3D7Y=
X-Received: by 2002:a17:907:ea8e:b0:c1f:29ce:76a1 with SMTP id
 a640c23a62f3a-c1fe8109c92mr138863366b.19.1785566487524; Fri, 31 Jul 2026
 23:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-26-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-26-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:41:15 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOKXjiaYer9d1bpDsGqgbRybR-kys7=VS5+bgamhH7LkQ@mail.gmail.com>
X-Gm-Features: AUfX_mxQb6sEWvtwrrsOndPWBioDQAFUn9a21iOp2FspGut8QJ6cNCKx5JQpZ_8
Message-ID: <CAO9r8zOKXjiaYer9d1bpDsGqgbRybR-kys7=VS5+bgamhH7LkQ@mail.gmail.com>
Subject: Re: [PATCH v1 25/28] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e4bda43238654..d7b20941b1fee 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2425,17 +2425,51 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
>
>  static int invlpga_interception(struct kvm_vcpu *vcpu)
>  {
> +       struct vcpu_svm *svm = to_svm(vcpu);
>         /* FIXME: Handle an address size prefix. */
>         gva_t gva = kvm_rax_read(vcpu);
>         u32 asid = kvm_ecx_read(vcpu);
> +       int cpu;
>
>         if (nested_svm_check_permissions(vcpu))
>                 return 1;
>
>         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
>
> -       /* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
> -       kvm_mmu_invlpg(vcpu, gva);
> +       /*
> +        * INVLPG on a non-canonical address is a NOP according to the SDM,
> +        * assumethe same behavior from INVLPGA since the APM doesn't specify.
> +        */
> +       if (is_noncanonical_invlpg_address(gva, vcpu))
> +               return kvm_skip_emulated_instruction(vcpu);

From internal Sashiko:
---
This is a pre-existing issue and was not introduced by the patch under review,
but if L1 is configured for 4-level paging and L2 is configured for 5-level
paging, could this drop valid INVLPGA TLB flushes for L2?

Since vcpu represents L1, the check is_noncanonical_invlpg_address(gva, vcpu)
uses L1's canonical boundaries. If L1 executes INVLPGA to flush a valid 57-bit
virtual address for the L2 guest, will KVM incorrectly deem the L2 address as
non-canonical and silently skip emulation?

Bypassing both the hardware TLB flush and shadow page table synchronization
could allow L2 to continue accessing memory through old translations,
potentially leading to memory corruption or security boundary bypass
inside L2.
---

I need to take a closer look here, but if this is indeed an issue,
even if pre-existing, it would only matter with this series. Before
this series, even if INVLPGA is ignored we flush everything before
running L2 anyway.
