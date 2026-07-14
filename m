Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA43F1ADD
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015142; cv=none; b=bGXW+zQH9u8HfvbP5qGTeGkM368T9EO4cItEo4DAOWvCqSmbTUpzp/vtXr+iWjGxkn3gxNILwonAf7iP3vx1zmx/4PQHw5YUpYK+9rHy0w5hjP0Jy2aXAFbT/4z/4vQk+CLzo8j6gTXvyVJCWqB7w02lZHEJzyiZ7UaOnfkPc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015142; c=relaxed/simple;
	bh=PNQpWUkjt8ku7bDKq+GviBoB3R1Usr4szZy4So25e1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qN4cWqO9mgxbPcD5iDaP4zR0McoBMyYa6Q1tzMXO1Hpw1EbquKm+T4QjU9G/nANlnNVqNa6jIyXnJ7m2Vu3fIpeK7ZYn3JxUN2Sp10Yc90MSWsriJByvMB91cq37vCZ72QZgU3KgjNGKRntGnJNq29GqgkBUJPWerdzLOas6WpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwPV7reR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwPV7reR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23791F00A3A;
	Tue, 14 Jul 2026 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015141;
	bh=Nf9pl+aLBBp+DGp9d/ziQDqj3XzQNMJSN6+fSIVCxas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwPV7reRogKnq+4gtk1NSL6F7+bgsoWjyGvfdtwKi7kHFfG1TJPo9EVVfKyUPB+gw
	 5GVcDdCq+0xBjBrRhOi3qtxl+CZwUYvUKho6MYUTo3gLurEldl/VWiFwgFRMWmnp3s
	 m8BpGLtWjRiebGGF0F4VGkq7d/eRGo6MLVj2t1Kc0vUV+F+Ch44SOm59QphUUIYZq1
	 0dzMNLycPi+Y5MtEPHyPXv7hexRdrcD5kkzpOXy6y4i0w95KEkcjCqI1JsVgUBrEvo
	 pIE0m261cMmsVJZUk9S6NOTEj4PxJAG4La3neoJi0iQtJ6f3GkwCGn2Rl1PecoVuVG
	 0GIuEz3W4QyKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] LoongArch: KVM: Return directly when IPI address
 is not aligned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714072520.2745942-3-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
 <20260714072520.2745942-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:45:40 +0000
Message-Id: <20260714074540.E23791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-triggerable host log spam (Denial of Service) via un-ratelim=
ited `kvm_err` calls across multiple IPI and interrupt controller handlers.
--

--- Patch [2]: [PATCH v5 2/5] LoongArch: KVM: Return directly when IPI addr=
ess is not aligned ---
commit ee58d22f0a0ca959fcdaed9af721908e0d1dcd00
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Return directly when IPI address is not aligned

When an IPI address is not aligned with its access size, the code now retur=
ns
directly in read/write operations and prints a ratelimited message instead =
of
emitting a warning. This matches the behavior of in-kernel extioi and pch_p=
ic
operations.

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 4fa0897d7bdb0..928f9bd5e1f12 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -186,9 +186,13 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu=
, gpa_t addr, int len, void
>  	uint32_t offset;
>  	uint64_t res =3D 0;
> =20
> -	offset =3D (uint32_t)(addr & 0x1ff);
> -	WARN_ON_ONCE(offset & (len - 1));
> +	if (addr & (len - 1)) {
> +		*(uint64_t *)val =3D res;
> +		kvm_pr_unimpl("%s: ipi not aligned addr %llx len %d\n", __func__, addr=
, len);
> +		return 0;
> +	}

[Severity: High]
This is a pre-existing issue, but while you are using the ratelimited=20
kvm_pr_unimpl() here, there appear to be other un-ratelimited error prints=
=20
triggered by guest actions in these handlers.

For example, when a guest performs accesses to unknown offsets or provides=
=20
invalid CPU IDs, the code uses kvm_err():

arch/loongarch/kvm/intc/ipi.c:loongarch_ipi_readl() and loongarch_ipi_write=
l()
    kvm_err("%s: unknown addr: %llx\n", __func__, addr);

arch/loongarch/kvm/intc/ipi.c:any_send()
    kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);

arch/loongarch/kvm/intc/eiointc.c:kvm_eiointc_read()
    kvm_err("%s: eiointc not aligned addr %llx len %d\n", __func__, addr, l=
en);

Can an untrusted guest flood the host's dmesg by repeatedly triggering thes=
e=20
conditions, potentially causing a host denial of service? Would it be safer=
=20
to convert these to ratelimited prints as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714072520.2745=
942-1-maobibo@loongson.cn?part=3D2
