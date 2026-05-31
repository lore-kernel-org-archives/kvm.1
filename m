Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721E324B33
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780255175; cv=none; b=S+DPF7IB5bGn0YWOVtds1BOZTnCBoPrR63PtRMHYjjnx1YoFZnW1x+MDfL3lFC9HKRmNDhDN8cVG1usBDd7zYTKrfYKCF+7D99hMBjEJEvvXU2AiD1otI05SUtgREJhTqdt1j4hdxfvD0CwSUnjPW0/HHqA0yvYapKDhqMW4x9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780255175; c=relaxed/simple;
	bh=m81szvEvY8tg3G/QpwMup6NYSPbyiDPQIJiBOKTqoKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKdyv10gDVpI0SWlkyxoD6bA6SZzhzZ+6AvjzTE3of3OTLqu1HT1SGKS1jd9TEf86sZ/6oGNF8DZ8EGVZHcSYbpx9/RPdSHQZocLiPyZAy6VAq77v3OHOAP7ysnik/qQ7eryNE/nELWaavy0MjVG7YM0IOnogvhoWFeXcNR5iG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdMMz/nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdMMz/nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176601F00893;
	Sun, 31 May 2026 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780255174;
	bh=E+fvZvrdr6ILXcaA51qV5Raz6cJfh8vcYb9xZKLRbdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YdMMz/nXj7H44zQZ2LISRklCFQ1nYJ8+d1YDaxHtcQDXtZI5Uvaq4w46Vmpoy4rqu
	 2SYBRatyWYH7e+amQ0LYRPy0MM5neo4oKZkOornnxnEDuNyEYe2D6gFdIzIzv9OYGS
	 R6b3O4r8/eUipAndl4XvfdRf9Cbm2qNiNEHfFLjqrZAVvVEA94ZinuL0Y6WWXxIUwn
	 SeKRxSwhDMYv9D3IIqz78MAeqHQybcxDaHzYocgmtvmdNwonGm2Qn2dduNILqVcp9o
	 g4rkmDfELMFgploSxPvdBsxneIZtQT+eD/icMJM+dLKA9MzQZbaMnjftmCWeC03o7A
	 IUcEDXlFiPKgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] KVM: s390: Add map/unmap ioctl and clean
 mappings post-guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531190353.204317-2-freimuth@linux.ibm.com>
References: <20260531190353.204317-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 19:19:33 +0000
Message-Id: <20260531191934.176601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `copy_from_user` is called while holding `dev->kvm->lock`, allow=
ing a malicious guest to stall the VM indefinitely via userfaultfd.
--

commit 5fe548324e0631c69e2b3712b40114f91835f256
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Add map/unmap ioctl and clean mappings post-guest

This commit adds map/unmap ioctls for the s390 adapter set indicator
pages, allowing access when interrupts are disabled. It utilizes
pin_user_pages_remote for the mapping and includes cleanup logic
during guest removal.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2411,24 +2411,34 @@ static int register_io_adapter(struct kvm_device =
*dev,
>  {
>  	struct s390_io_adapter *adapter;
>  	struct kvm_s390_io_adapter adapter_info;
> +	int rc =3D 0;
> =20
> +	mutex_lock(&dev->kvm->lock);
>  	if (copy_from_user(&adapter_info,
> -			   (void __user *)attr->addr, sizeof(adapter_info)))
> -		return -EFAULT;
> -
> -	if (adapter_info.id >=3D MAX_S390_IO_ADAPTERS)
> -		return -EINVAL;
> -
> +			   (void __user *)attr->addr, sizeof(adapter_info))) {
> +		rc =3D -EFAULT;
> +		goto out;
> +	}

[Severity: Medium]
Does moving this copy_from_user() inside the dev->kvm->lock critical
section allow a malicious userspace process to stall the VM?

If a userspace process provides an attr->addr backed by userfaultfd,
it could indefinitely delay the page fault, forcing the kernel to hold
the global kvm->lock. This blocks any other operations on this VM
that require kvm->lock, causing a denial of service for the VM.

Could the copy_from_user() be performed into a local stack variable
before acquiring the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531190353.2043=
17-1-freimuth@linux.ibm.com?part=3D1
