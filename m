Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68D30BF67
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763223; cv=none; b=NuKsGkk7HFsBTmFA3P4h3blHae4+CvFMhOGYaW3rvBcUr9CSPU9FSVhpFCeQtfMn2hQg+cLFqwJmeRal+74tHQxFDbrYM61gJfkSnSLCxXQSlbtGi2dZtUU419QoAPK0ahDjXXJ1WRW/vmHovzCGnuFBbHIqn6mdg9z82qoNEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763223; c=relaxed/simple;
	bh=wiA156QzzAtrr6cEb4b4b8QfPRg/ovPdcoha9/Mpmx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AkQK2/OPXefW0BX2DkLVVP4c2SWpZ0HudEcuaee8Sx0r+0PZym224EMZstO0r+JmiH6Kx5dd8TiqawZmMZPVpGI1EeGUyPRB7Dg2S98J3ATdAZAuDxdWPXqlf671pt3B4XKcHEjva1L6HY1VnXMfE811TbDSj2XtYXNrj7D2bU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng7j/itt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng7j/itt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15001F000E9;
	Tue, 26 May 2026 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779763221;
	bh=q95h0hq2o67cu9oyjrf/hCGVPUAgQ/EQoEX/eDthSa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ng7j/ittOwcJFo1CZ6sCo9dmBIeKrhlwMLWNsVeYEwjHPPFO45qMGciTT4sfakfcs
	 4elSkq4No7ehla/rrnier4wFFcnE/fKjfskhu80P1IHChQwvyiZvQOBINE7wmzIeTI
	 zrKWjUrMV95t9makFN4+i8IIxk6Lm2vlje7uxKt3gssA19LN4HkqW5EU/wzc3N/qEH
	 VZcqbCUtZGrteHkPaCTj384TDmaGu0013ZNRGuRURQYx0kShcfdzIcJHB5bdu7Mrkh
	 2y50ioz8+1Zl+W2yDIh6F9ZDNkDg83dUfAXxWbbHzGObuwyjEPDLx7xvSpKBxXpsvM
	 MEu/tL0KXq9eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] KVM: s390: Add map/unmap ioctl and clean
 mappings post-guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526015323.207343-2-freimuth@linux.ibm.com>
References: <20260526015323.207343-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:40:21 +0000
Message-Id: <20260526024021.C15001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The register_io_adapter function acquires dev->kvm->lock but fails=
 to release it on several early error return paths, causing a permanent dea=
dlock.
--

commit 846f99f02dcb9dca2543059b14bd01a7e4a020cf
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Add map/unmap ioctl and clean mappings post-guest

This patch introduces map and unmap ioctls for s390 adapter set indicator
pages to allow access when interrupts are disabled. It adds logic to clean
up mappings upon guest removal, and fences the ioctls in Secure Execution
environments to prevent longterm pinning.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -2412,6 +2412,7 @@ static int register_io_adapter(struct kvm_device *d=
ev,
>  	struct s390_io_adapter *adapter;
>  	struct kvm_s390_io_adapter adapter_info;
> =20
> +	mutex_lock(&dev->kvm->lock);
>  	if (copy_from_user(&adapter_info,
>  			   (void __user *)attr->addr, sizeof(adapter_info)))
>  		return -EFAULT;

[Severity: High]
Does this code leave dev->kvm->lock held on the early error return paths?

If copy_from_user() fails here, or if the subsequent adapter_info.id
validation checks fail, the function returns an error directly without call=
ing
mutex_unlock(&dev->kvm->lock). This would leave the mutex permanently locke=
d,
potentially causing the VM to deadlock on any subsequent operations that
require this lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526015323.2073=
43-1-freimuth@linux.ibm.com?part=3D1
