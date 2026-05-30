Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9D165F1A
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127970; cv=none; b=QPlbFmqdiyxOOB9oqW5yuHmxqiOz4ZtM/2eTIQ+KclMAxcnxFf6CTm/6G3FE/JNKBg6Nc5dT9Qi1B0p0yotgogomiWMS9jVFlrDhsTeMOOvQHm975nRzRob+tlKZ02qY4u6Jkc44lBWQ3Ow7ywofu9+Hx8GFF34bprctbwDzK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127970; c=relaxed/simple;
	bh=wv6YhLu68MwUc8u8vX0M8tSGoJaqfUWS91ME9q0Q4Z0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPRIPpcE63E3eAMTmc0Vp8/uka0KtrbqaBzFIslOUXfC5CjDo+gGVxsgSoiM07GR+1b3MTrVOCilFVQYJMRAjSyLj9eQRs6ZBxIwjbg7i+F6kBmAFrT21+kUTNB7RWgIzZum5oCPAgkggwZ0RK3tHIZuweo97iE3yju2qatVeqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSp09m/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSp09m/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B61F00893;
	Sat, 30 May 2026 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127968;
	bh=HqU6T32Jf/evLFIWYILQVGGx+pM4gOjDMMpAIhKlg70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSp09m/CBK14cnpW9g7C50TmBVPsQ++IX/w+3lvU/a1OJwIj16hZ0qmiPplexsOKE
	 2FAfKlp+VJwfpQ/4Uq95oC0bf68d4uJMCadpeBoilYze97qPVYU+P65ugpqjnyHU8r
	 0BlbMjQIa0iiXL9dvZxMZ1ifJt6SVRPtmodeU0+ewziGFSlW+mO2Db6Ksl0qkJo4vI
	 IxxKAMLI6Ou/BSynwFYJocOQyWN2Fv7Q3MPJMS/28WY6ikOm6+MMX7gIo5ta5ArR//
	 p4V4EzwriqGGTS68fQkN2vhmatE670vJxtlcN0GruIQWYg+seU7CzeTTF+CDe1q5Qc
	 KpA8BwumIcTcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 40/40] KVM: x86: Move a pile of stuff from kvm_host.h
 => x86.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529222223.870923-41-seanjc@google.com>
References: <20260529222223.870923-41-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 07:59:28 +0000
Message-Id: <20260530075928.888B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Several x86 KVM-internal declarations and definitions were unint=
entionally left in `kvm_host.h` despite the commit's goal to move them to `=
x86.h`.
--

commit 6fbb37590b9a07586090f255933e9452d592518d
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Move a pile of stuff from kvm_host.h =3D> x86.h

Move the majority of remaining KVM-internal declarations and defines in
kvm_host.h to x86.h, so that kvm_host.h only holds structure and function
definitions that need to be visible to arch-neutral KVM.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index a3c1ff784e5c0..4efad65e53e24 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h

[ ... ]

> @@ -2326,11 +2154,6 @@ static inline unsigned long read_msr(unsigned long=
 msr)
>  }
>  #endif
> =20
> -static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
> -{
> -	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
> -}
> -
>  #define TSS_IOPB_BASE_OFFSET 0x66
>  #define TSS_BASE_SIZE 0x68
>  #define TSS_IOPB_SIZE (65536 / 8)
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
The commit message notes that any "misses" are likely unintentional. Should
TSS_IOPB_BASE_OFFSET and related constants also be moved to x86.h?

There are a few other x86-specific definitions still left in this file that
might have been missed, such as struct kvm_host_values (earlier in the file=
).

> @@ -2361,16 +2184,6 @@ enum {
>  #endif
> =20
>  int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Similarly, should kvm_arch_interrupt_allowed() and the preceding enum
containing TASK_SWITCH_CALL also be moved to x86.h?

> -void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
> -

[ ... ]

> @@ -2382,14 +2195,6 @@ void kvm_arch_async_page_present_queued(struct kvm=
_vcpu *vcpu);
>  bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
>  extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Are kvm_find_async_pf_gfn() and the other async page fault prototypes missed
here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529222223.8709=
23-1-seanjc@google.com?part=3D40
