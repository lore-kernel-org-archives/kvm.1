Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA237333730
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936028; cv=none; b=PMYNgawt92mykZ/a+CXT/f8cqHC2H3mHNfPLHtq9Za665o8co9gQvxGgdYivRaag3sikRCGQv111caHn1HjcpOrStGwAY3c+MpvhnxnUcBjQTX+kLYJIARweF+EWjqL/XEbB8WP6y4KcG6uuc5OyhloWS6rjck4ASPrqYLRyk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936028; c=relaxed/simple;
	bh=/aCKtALrVl7N8WNnj9mrSALIqO/DuNPZt5SYukVt9S8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPWPLYDz+oq8mpuASA6yxsfH0c/6Kx9jbegzZNlBnnzflzlzsR4a1yvfF/tWKwj+g2HeTSAlndCRdaZpkr8B8eTszBboxaS9fzI3fWOPL4+ZM1iWIqKwlbqSW8F/9VdBfSkcTtV3anZqOjiMrE+ApcAXQ1fCzyvLlHah0acDSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEz0Zs2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEz0Zs2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CA21F00893;
	Mon,  8 Jun 2026 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936027;
	bh=c1cNVYQfKalLEbJV/TANaQ/a1JJo7CdqszY+i5zIwas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fEz0Zs2nHTdtBI58hE1I24WjG4C/82+4k2Ai4i2yCR6bgTbOq6+OwTvKjfZIYAofs
	 cIPH53vaePKSf1HfADa1IkUuwtvC5XoZ/5tH8iN8yPRsBqtWn7fzrLTbyHgu7RKsGP
	 4Az9Db9m7Z3UbiDoHZUwTwuHig5mLgJTPxbtEPBJ5bj8YrRNjjKeaBqSDvw/LhtehP
	 1/WwxkX3fQiBjebzPbR/+J37kdU10ikggZJshgkb8ukEB5DC+JcnfMuHbBCZUyJhLa
	 KK4Kz+zUsk50/XhxJQYeE4U+KoG5R64CfU98nugMCDbX/Fxny8Tvy9Lqoi+O0sAI2B
	 LRzdoYc2S6XSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/34] KVM: x86: Activate master clock immediately on
 vCPU creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-8-dwmw2@infradead.org>
References: <20260608145455.89187-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:27:06 +0000
Message-Id: <20260608162707.39CA21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional masterclock update causes O(N^2) overhead during VM =
creation
--

commit 8f4737a975ef2b2f510c7316ea3baa233e41c647
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock immediately on vCPU creation

This commit updates vCPU creation to activate the master clock immediately,
rather than waiting for the first vCPU to process KVM_REQ_MASTERCLOCK_UPDAT=
E.
This allows KVM_GET_CLOCK to return a valid host_tsc and realtime pair right
away without requiring a dummy vCPU run.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b7e5f6e3dc6c1..c1897d939da91 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13098,6 +13098,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vc=
pu)
>  		return;
>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL);
> +	if (!vcpu->kvm->arch.use_master_clock)
> +		kvm_update_masterclock(vcpu->kvm);

[Severity: High]
Does this cause an O(N^2) scaling issue during VM creation if the host=20
clocksource doesn't support the masterclock?

If the host lacks masterclock support (for example, missing a TSC=20
clocksource), vcpu->kvm->arch.use_master_clock remains false after the=20
update. This means every subsequent vCPU creation will re-trigger=20
kvm_update_masterclock() unnecessarily.

Since kvm_update_masterclock() makes requests for all existing vCPUs=20
using kvm_make_all_cpus_request() and loops over them, creating N vCPUs=20
would result in O(N^2) lock acquisitions and iterations. Could this=20
cause noticeable latency regressions or soft lockups when booting large VMs?

>  	vcpu_put(vcpu);
> =20
>  	/* poll control enabled by default */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D7
