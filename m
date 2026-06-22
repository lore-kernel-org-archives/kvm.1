Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290437189B
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115708; cv=none; b=ofE7mMxY/8viSwBYZaaLnXr7gPZPkMi1tlL0Lb2aveJQhMSeiGUyBXCHjV/mX/Wb7aZjwWNSpPLkqzBVygbZ6+u3+F141SiKyM8JCaWDFlKPxRp0vpVSBm7Z4Xh1Ae9AV4kQEa8Qvkrj5en0mZjHmlt4yBUSSpTfWaTEml+AO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115708; c=relaxed/simple;
	bh=dVYKGZjCx1m1xTsYQ2cQn4cP2rLFXxoydzeYlvsPO0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/MygWbR2KBdIWR2RdeK3kwmFCZWjHCWRMI/ErQhISAskQEYI8Gf1DB87WGTzxANggZKkRjC9QZAFL/TQ01g/KNEKnXTwgnQiZCMxUpMfnfO8qoY2qmPXVirppQ9AbdcSG5sTgB7uEFkdAVKggsmi/M5sxTmeKXv5HkSn8NpPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW07nGez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW07nGez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3431F000E9;
	Mon, 22 Jun 2026 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782115707;
	bh=+xiziGSlrOnRW2OEnrTpa5Fd9Iari0cB2pVQmBlBu2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FW07nGezb4Y+Z4mvmonIxDflyaP1UsWcroRzliw6XCmUKNaoksqqj2uiCZNZSTh+q
	 X6eeugNgB+qu9RvtiBgQ+T10TPzA7bS2MTGs88FRziP91iAPqXDUlPq4/MJmQLIPn0
	 SlWJyKPyU/qi22hV5KOsRy3nQ+dTX241FRYMIesIfag7dyZr6uWTy6UyTtg9toAwHS
	 uiRYcmsJarVpZnTuVKwMHJe/vZukBrSMNj1qSVxUyAgRMu6pOLELw649/c7/u62Rx+
	 WuxSSS6FZsJN/oPgpkHv82kMjvBQZYXXuSrOZOavV1q9nHsGUCHlQZhavlkbE/NBMc
	 7LVvWDgm5exhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: leixiang <leixiang@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622075103.35164-1-leixiang@kylinos.cn>
References: <20260622075103.35164-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:08:26 +0000
Message-Id: <20260622080826.EB3431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ARM64 completely omits setting `irqfd->producer =3D prod` in `kvm_=
arch_irq_bypass_add_producer()`, which breaks vLPI routing updates and rend=
ers its `kvm_arch_update_irqfd_routing()` hook dead code.
--

commit 52f3fa02a57237a69e9a84a214e25fb38e380184
Author: leixiang <leixiang@kylinos.cn>

KVM: Nullify irqfd->producer when add_producer() fails

The commit fixes an issue in x86 and powerpc where irqfd->producer is
left dangling after a failed add_producer() setup. It nullifies the
pointer in the error paths to prevent a use-after-free when the vector
is later disabled and routing updates occur.

> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 9519fec09ee6f..c5c2f778c6692 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -488,8 +488,10 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypa=
ss_consumer *cons,
> =20
>  	if (irqfd->irq_entry.type =3D=3D KVM_IRQ_ROUTING_MSI) {
>  		ret =3D kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
> -		if (ret)
> +		if (ret) {
>  			kvm->arch.nr_possible_bypass_irqs--;
> +			irqfd->producer =3D NULL;
> +		}
>  	}
>  	spin_unlock_irq(&kvm->irqfds.lock);

[Severity: High]
This isn't a bug introduced by this patch, but ARM64 suffers from a related
omission where it never initializes irqfd->producer.

Because irqfd->producer is unconditionally NULL on ARM64, the core KVM even=
tfd
logic silently skips calling the ARM64 hook kvm_arch_update_irqfd_routing(),
rendering it dead code:

arch/arm64/kvm/arm.c:kvm_arch_irq_bypass_add_producer() {
	...
	if (irq_entry->type !=3D KVM_IRQ_ROUTING_MSI)
		return 0;

	return kvm_vgic_v4_set_forwarding(irqfd->kvm, prod->irq,
					  &irqfd->irq_entry);
}

Should irqfd->producer be initialized in kvm_arch_irq_bypass_add_producer()
for ARM64? Any future patch to fix this missing assignment on ARM64 will
immediately require the exact same error-path cleanup (irqfd->producer =3D =
NULL)
that this patch implements for x86 and PowerPC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622075103.3516=
4-1-leixiang@kylinos.cn?part=3D1
