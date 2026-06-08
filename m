Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD933F8D6
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935976; cv=none; b=hrMXck3czUOpCLKMWL5mlB0vwwyoJoN23NAOiCHCXlG2rW8IDb8czaiPTLdSa9LYKESUpPBJbBzlgzi+XiaRaHpqNwkgNUGn8IpOphJIH8oN2Yreq6QirO6xObjQVa0Ch6Vtu48knj0F/V46GUZDap/90SfpUIeaX/ns+8qk89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935976; c=relaxed/simple;
	bh=Q67hG9Yc6XgZMuYbbp9TFj1vf+sBjRNVsuFCvIsUeDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CWUAWtwycp5LN7biYZ0YjMIbUT/+1GVw933egABd5HYlN6AiSiBwnJHHRTw7tgslnleSv6tCk9UyfO4dee6m/CVQAdunN72v+MugXvhw1HjftR64YvF4dOTzoJImSMLBD+VBNJLBsVZEiab3jxSh14pKFty4d9CUm+JRatc4iGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOKd+fsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOKd+fsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD921F0089F;
	Mon,  8 Jun 2026 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935975;
	bh=fN4A54eWzWyNOG0hHwlqs4WO+WO6Hs56p/rU7UmXfu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOKd+fsOlkuzpMag9X4B1lMQmDZxnzhymiP0SlpXDYknYpD9veqzeLHc0wE8z+s1N
	 ZDC/Q4923jGOZBAbMSlGxDP9pg5g1aXnA5eGJtJGSz/0+vyvz7le9BDsglghvQhJ4B
	 PaLfkCHtGq2mOgAmRINYNmssUZJwh8JoK90PP2Wa7Vy71QFmdVIPRZwZHh1RqVoAXr
	 ljHEbZqDc14cso5Uc4U7fIBdaqCw3Hx2GrTptxDzWDXQdpJNn2zNLOAGiOHMW1WeHw
	 adNXcExwa71Gh+kjCgAPDyTZbyek6U2pqhZmQFwh8/7LFexD1Xo+3WtHpjy7G8kUEy
	 KIvuPrINbIYGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/60] kvm: Move kvm_vcpu->rcuwait to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-19-joro@8bytes.org>
References: <20260608144252.351443-19-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:26:15 +0000
Message-Id: <20260608162615.7CD921F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Host kernel panic (NULL pointer dereference) triggered by MIPS out=
-of-bounds CPU ID in interrupt ioctl/MMIO.
--

commit 1db0b07fbf183499e26c76e72be724cdc1b067cc
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move kvm_vcpu->rcuwait to struct kvm_vcpu_common

This commit moves the rcuwait member from the architecture-specific
vcpu structure to the common kvm_vcpu_common struct. This ensures
there is only a single wait object shared across all plane VCPUs.

> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index f928ba105104b..6469ec246dd60 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
[ ... ]
> @@ -507,7 +507,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
> =20
>  	dvcpu->arch.wait =3D 0;
> =20
> -	rcuwait_wake_up(&dvcpu->wait);

[Severity: High]
This is a pre-existing issue, but is there a missing NULL pointer check for
dvcpu before these operations?

Looking at kvm_vcpu_ioctl_interrupt() earlier in this function:

    if (irq->cpu =3D=3D -1)
        dvcpu =3D vcpu;
    else
        dvcpu =3D kvm_get_vcpu(vcpu->kvm, irq->cpu);
       =20
If irq->cpu is out of bounds, kvm_get_vcpu() will return NULL. We then
unconditionally dereference dvcpu at dvcpu->arch.wait =3D 0 and pass it into
kvm_arch_vcpu_get_wait(), which could trigger a host kernel panic.

Additionally, if kvm_vcpu_ioctl_interrupt() is called with a NULL vcpu
argument (for example, from loongson_vipi_write() using kvm_get_vcpu(kvm, i=
d)
with an out-of-bounds ID), it would also dereference NULL when evaluating
vcpu->kvm.

Should there be a check ensuring these pointers are valid before they are
dereferenced?

> +	rcuwait_wake_up(kvm_arch_vcpu_get_wait(dvcpu));
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D18
