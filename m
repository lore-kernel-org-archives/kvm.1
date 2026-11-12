Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519174;
	b=CD688aRk41xGLqtzGalN1wq7WjDFnTRG8iFoD2keTHHiQsaFw3WS/3PC9LEYbjp7b/E/
	 zv31q/1tHEqcDq7JKSHaHhbea4hQ4AMdk8fV0bXSUTTKi/2eYH1Pryw/JLJwak7RuqP9L
	 1FgOJFkiPS0MEFgXUOScRTxLxOc5FDyjPy7rnT1JS93jKblm/WtKvygks/9pflMc2Yzc1
	 fJ36gGhmTWNXEdykk2pOzs+3+7S7bpnASQ8NhV29kFOvCFuoWIvwuhaWiYG1WWL8YvMns
	 ME3jWiA9Euyl6DYEL+LDgJbpwx/oZRLz/ph16YIYfKneeI9Xk9pUchDWfT1YIxjpt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0lBFTNDe+Jg5J77y+hWPzWyz7JjBpB2n2+knWRfWSTE=;
	b=wZqJzPUUu9i5mgaZV9MYFb4x2ZhJR6xAMVJtiPpbxMFtWvvLmUKbMLHaUTIn5Gigo6NF
	 Q7xOVUKq4CDi6D+ID2FiQDGbtS34w3E6JrZMKbRSz8h+EqE1p3PHyR0kEG3oWrJ6BQHi4
	 UiDZ8BMjobOP0oXv1gckCBjUEy7F/vpk/7JCRU6w8YqCNt24IFDRS2jJ1d+v+1sZgluYe
	 i9qJQ4IYAkOMGnwmaJ42DKUlo7g/KjZ5vP/QEXd1xwqifg1WmAuKaVN4BAtlXSVVcZnHQ
	 57FSInYmDIkgPItCJel92EutT0lYbEpAPc9eg6q+pCO+/QK/QD8iFMYgZcYZSh51v2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCbU5jaO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096D606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCbU5jaO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A51F000C4;
	Thu, 12 Nov 2026 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519174;
	bh=0lBFTNDe+Jg5J77y+hWPzWyz7JjBpB2n2+knWRfWSTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCbU5jaO2y1ddCmlxWUWpTw9dWjGh0MxFG1UgheYHE8upX6FpOYH7nPDyqmbtcA5d
	 W2C7meBGm1XqinjMUUlEH05Bkv1pEU2FZe/rvVqrV0xkY8WOGxx5mXabZm9olyndl3
	 3AFs6zp0Hg68bARKP9t7qyCc4ezBteG/Te3SH2LofjwlEKxs+3g4jFUESZFMEY9Sgi
	 nTn+BcOdVV3BvaPi6Y9qCf6zFQvuVPjw3RWlRMcZtFeS6nWB5ViDeWUih1ktODnSHq
	 Qyu2O2rqk8jL2wO3gIJyIlDq/dM5Z/OZ5Msl2TgKul5pfTzWWmAHUWtwHjAsYwwMfe
	 gkRomvJ/CMzCw==
Message-ID: <sashiko-outbox-211867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Gate CET state copy in
 svm_copy_vmrun_state() on guest SHSTK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261112212628.265262-1-jmattson@google.com>
References: <20261112212628.265262-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 21:32:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] KVM: nSVM: undeclared vcpu in svm_copy_vmrun_state() breaks
  build
--

commit 11b89023661c173dccf1cc07088879a6b4ff0bef
Author: Jim Mattson <jmattson@google.com>

KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state() on guest SHSTK

This commit changes svm_copy_vmrun_state() to check
guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) instead of
kvm_cpu_cap_has(X86_FEATURE_SHSTK) before copying CET shadow stack fields.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index f9090b601efaa..2a1c279bd54a1 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1218,7 +1218,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to=
_save,
>  	to_save->rip =3D from_save->rip;
>  	to_save->cpl =3D 0;
> =20
> -	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
>  		to_save->s_cet  =3D from_save->s_cet;
>  		to_save->isst_addr =3D from_save->isst_addr;
>  		to_save->ssp =3D from_save->ssp;

[Severity: High]
Does this fail to build because vcpu is undeclared in
svm_copy_vmrun_state()?  The function only takes to_save and from_save, so
its signature and callers in svm_set_nested_state(), svm_enter_smm(), and
svm_leave_smm() need to pass vcpu as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112212628.2652=
62-1-jmattson@google.com?part=3D1
