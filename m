Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52924DA528
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108591; cv=none; b=iPyzqQWt6WK76y1eiw5IhIkg9Kxq5Tnl+8VGX0A6DHknbNst61TE/3Oei2yNOIrWkSob+jzon/cqsr2Sk2yenCb1rK1z9K9UCbP/u9e9p8mi8oOqo0vcSOYgtMXgpQDCzcSRw4uU0UqrYBIhZG6kYiI55N1mfr1725XncDt6Aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108591; c=relaxed/simple;
	bh=M6x6pMPn7hS3pliUyufEBnEmjCorQDdf10aV0PartTA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l5kyT3w+8JvJ99XlWXGXwJ/I4CdD03i0KpTkVxMfJZlrbMh/MOwT56A+oLrYxVTUKcbcis28YxRLxXG5/K9QGRbP+Ac4U70N7i1XZvxOvvmwlDDxwvtWn0MyX5rdoJwGrOsJ9S3fFY/jJEwLHyVN+/o2+EcvPdH9PEdnSkW9HcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blWCMkhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blWCMkhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344EA1F000C4;
	Thu, 15 Oct 2026 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108587;
	bh=kDE2hZCbdzTMamqXYj66yP92DMCUEbPg+pLesRI5lbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=blWCMkhVCSh+bjPjyedzOJHHSb6rrtrsshMctPqAsk8ZTx8zcnWjj7gn3L9VXWX8D
	 Ij9VUihtJhgbBtl8SLLh+urIPwDg0UI+sDY8sarwZ5u2FE307z3X0Xb+J2sMyGgLK1
	 Xj2aLmyHzXTXDGyVmxzRTBFBYPZ5vCmyCD1AC4clzMdEOCc0lWFhm+hntUwAQYnbkn
	 MI7QBedD69I5XPpbLbxkzN4QUyuaSdu9NMVGxZq5iy2e8K80hVpL3l2HPZbwD0kGNJ
	 Cdamu/+y8Z0zUFyouBLUtfiMwhg8NZVYs3AK0fCh05i9/0jjXYwYX06ANkF+aL8ovu
	 RUOqo0m1Uo6cA==
Message-ID: <sashiko-outbox-173496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] LoongArch: KVM: Reject repeated PCH-PIC
 CTRL_INIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015234638.1077815-4-cui.tao@linux.dev>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
 <20261015234638.1077815-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 23:56:26 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: loongarch: missing rollback of s->device.ops on IO bus registr=
ation failure
--

commit d13a3fd9c70a7a0b0118a0e9dbae30ac5e61efaa
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT

This commit adds a check to prevent repeated PCH-PIC initialization. It
rejects multiple ioctl calls with -EEXIST by verifying if the device
ops are already populated.

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 51e4a6a39dc06..a4c35ed704be8 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -281,16 +281,21 @@ static int kvm_pch_pic_init(struct kvm_device *dev,=
 u64 addr)
>  	struct kvm_io_device *device;
>  	struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
> =20
> -	s->pch_pic_base =3D addr;
>  	device =3D &s->device;
> +	mutex_lock(&kvm->slots_lock);
> +	if (s->device.ops) {
> +		ret =3D -EEXIST;
> +		goto out;
> +	}
> +	s->pch_pic_base =3D addr;
>  	/* init device by pch pic writing and reading ops */
>  	kvm_iodevice_init(device, &kvm_pch_pic_ops);
> -	mutex_lock(&kvm->slots_lock);
>  	/* register pch pic device */
>  	ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, =
device);
> +out:
>  	mutex_unlock(&kvm->slots_lock);
> =20
> -	return (ret < 0) ? -EFAULT : 0;
> +	return ret;

[Severity: Low]
Does this error path leave the device partially initialized if
kvm_io_bus_register_dev() fails?

If kvm_io_bus_register_dev() returns an error (e.g. -ENOMEM), ret is set
to the error code, but s->device.ops has already been populated by
kvm_iodevice_init() earlier in kvm_pch_pic_init().

Since the function now uses s->device.ops to check for initialization,
would this prevent userspace from retrying the initialization? Subsequent
calls will see s->device.ops populated and return -EEXIST.

>  }
> =20
>  /* used by user space to get or set pch pic registers */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015234638.1077=
815-1-cui.tao@linux.dev?part=3D3
