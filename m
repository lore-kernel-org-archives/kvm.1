Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCD27F4F5
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966455; cv=none; b=Fnj70w20aXSnvoMbWr+rN6+PSpyZ0jZfPjPg5P2BqcIdAQMwlLU1kZXHPhdPCLpvjsRfFK0dZDbDmrFJMpiJ+R5DJqnOmQXYzE2guRdnISQ8aVUdu4DbvovkCAImf0qvvDbxLK4nEX5A7PXlXaoMDO5qEH8Ar9PqLqqO+SBpvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966455; c=relaxed/simple;
	bh=IZRWDs57EU4EhIGxfs4/tWUV9gr9uByo6+8mo6vYR1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E1rNPbpoK5JiVjm8Lm/gK2nPPUjarQURJXo/3VRSx1bd15OWtvHo9m0IBCBO5z9MLEDk7sginppsBgVOLigEszaLXWj/nW/hz25aqXfly4OqkhLMo/E1cms2YLMW/h86y9KOMZdusMCr9Jhc+vE98p96DDa5gioUYmqSE4888f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7sn0sGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7sn0sGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A481F00A3D;
	Mon, 13 Jul 2026 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966453;
	bh=Vqmsf6jwtpGuvSqJrcgf1Vltwnd/tARNAMhnjP75bSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7sn0sGsPKyASXnT2lgBK6sbfVawc8yBy46USjgygB1C5FB6qqQwoVbw20H72AKFq
	 5mh6xxpvYFmZ9wl+tWEsciSVaYiEyD6U6vl43dumRMKuT2zYMa6D7rqCJsCF/bUhfo
	 iDfYmux4cdBlX5Xo4HPBQxTNDYrGCh+QJAZjdEd7piaE3JmR0pzBKcEQKK+PC4cQQD
	 wcn9lbt0sB/h37MQ/Ak4lidn80ixYeTEWwqd6daTmfUtvvQ40UeTpc3HtkOWsZV2Vf
	 P63SHwGCoZYv6X3sAGEkUonup4qg6QYBJgqJEV6U6ZqSYCHPcbAHO4dNbdCdmJZ1l9
	 ImI6YjQhbtcXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713180153.2728382-2-yosry@kernel.org>
References: <20260713180153.2728382-1-yosry@kernel.org>
 <20260713180153.2728382-2-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 18:14:13 +0000
Message-Id: <20260713181413.94A481F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the return value=
 of `kvm_x86_call(set_efer)` is ignored in `__set_sregs_common()`, leading =
to a silent failure when nested state allocation fails.
--

--- Patch [1]: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREG=
S* ---
commit 6edd9e84461af3c58ac965b84f89b7c4985ddeb3
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: Check EFER validity on KVM_SET_SREGS*

This commit adds checks to validate EFER against both KVM and guest caps
during KVM_SET_SREGS* writes, preventing userspace from writing bogus values
through the per-vendor set_efer callbacks.

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index bd8147798cc3e..8f66438989e47 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c

[ ... ]

> @@ -564,7 +564,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu,=
 struct kvm_sregs *sregs)
>  	}
> =20
>  	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
> -	       kvm_is_valid_cr0(vcpu, sregs->cr0);
> +	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
> +	       kvm_valid_efer(vcpu, sregs->efer);
>  }
> =20
>  static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *s=
regs,
>  			      int *mmu_reset_needed, bool update_pdptrs)
>  {

[ ... ]

>  	vcpu->arch.cr3 =3D sregs->cr3;
>  	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
>  	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
> =20
>  	*mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
>  	kvm_x86_call(set_efer)(vcpu, sregs->efer);

[Severity: High]
This isn't a bug introduced by this patch, but should the return value
of kvm_x86_call() be checked here?

If a userspace process calls the KVM_SET_SREGS ioctl with EFER.SVME set,
kvm_x86_call(set_efer) could call into svm_set_efer(), which attempts to
allocate nested state via svm_allocate_nested().

If the system is under memory pressure, this allocation can fail and return
-ENOMEM. Because the return value is ignored in __set_sregs_common(),
doesn't this lead to a silent failure where KVM fails to set the guest's
EFER register but still returns success to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713180153.2728=
382-1-yosry@kernel.org?part=3D1
