Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CC3264D4
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161714; cv=none; b=Lbt1AhbLXZYOv6ZKCctdawDjhYwZwM4ljH7NSV+k8F8rO18Ai8sDetLKfYYK3twn5pW7N9cWnaA5VCU9dmhi938O/4pZk0QX7gQgh3snckJvN6dwQVZTDayZPqd2fJm2XLJTQXx5AylPmYZb7/pZcFCI8NC19C74CEzfPz1SvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161714; c=relaxed/simple;
	bh=dgTw/bNXEf+PFjjzz7RJeve7a93xTMBR5AbMAsmSsLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GpTwVsFFyJG6K7QfpXh+zZeuG7xX4HHa/kWcTxldjL+DPyz5wjigOtzIgCdgNK/ezDpcP51eo4ou3yTXgszB5L8ntGPih3c336cCPcfTlAlnEsp97OfsA12WHRIly4J+FMiLgNLkAeirjZSsPWsw0Ou8kTPGkEfxLsHfZ6tA28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYb4UmWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYb4UmWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BC81F00893;
	Thu, 11 Jun 2026 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781161712;
	bh=gEw4wAkUWGk3o1Sw/Yf3KGQurRWRDfOps78OcrLgbbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYb4UmWQt2L3Ie36PlxV7KpDom1DiuzgFRhw2AYbLzfmuDkjq1cPrDFUT76rrY+dU
	 xISqrQvFbUDFbTEpzw6Z12TgiH96c6s/x6K9md/2xMOm/O9Sqc3hrPoyG6Dw93cVet
	 uz6RQBeZdZZBrHpGUZ9MPIPputQc9WgjxOR8quP0/sRSGU0vNzW9R/I7XksL8wzz0f
	 YF98qg15oXSXDtub0ETArg9oSPxw49Vx3wyrvtEhMu0gRqaT5OuNFkbOZ0o3D8IwRJ
	 D+jW+SKnf7iCHxJ0VWhcN6KxormRiX8tTx2y30q/q+f05J0ssiywDNQQliKzeZpQA5
	 A47vEYb45GBNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] LoongArch: KVM: Check irq validility in
 kvm_vcpu_ioctl_interrupt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611065815.1439154-2-maobibo@loongson.cn>
References: <20260611065815.1439154-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:08:32 +0000
Message-Id: <20260611070832.A9BC81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Un-ratelimited `kvm_err` enables host log flooding DoS from unpriv=
ileged userspace, and valid IRQ 0 (`INT_SWI0`) cannot be queued or dequeued.
--

commit fd892c086057b77e1ae791d2e1126c1532b41bbb
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()

This commit adds validity checking for the interrupt vector in
kvm_vcpu_ioctl_interrupt(), returning an error if it exceeds
EXCCODE_INT_NUM.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e682..df5be9b265e8d 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1487,6 +1487,11 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>  int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt=
 *irq)
>  {
>  	int intr =3D (int)irq->irq;
> +	unsigned int vector;
> +
> +	vector =3D abs(intr);
> +	if (vector >=3D EXCCODE_INT_NUM)
> +		return -EINVAL;
> =20
>  	if (intr > 0)
>  		kvm_queue_irq(vcpu, intr);

[Severity: High]
This is a pre-existing issue, but looking at the rest of
kvm_vcpu_ioctl_interrupt(), if irq->irq is 0 (which corresponds to INT_SWI0=
),
both the intr > 0 and intr < 0 checks are skipped.

The code then falls through to the following else block:

    else {
        kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
        return -EINVAL;
    }

Since kvm_err() is not rate-limited, can an unprivileged userspace process
holding a vCPU file descriptor call this ioctl in a tight loop with
irq->irq =3D 0 to rapidly flood the host kernel log?

Could this create a denial of service by locking up the system via a
serial console or exhausting disk space?

Also, does this logic fundamentally prevent userspace from correctly
queuing or dequeuing INT_SWI0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611065815.1439=
154-1-maobibo@loongson.cn?part=3D1
