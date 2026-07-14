Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145A1D5174
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063738; cv=none; b=IAdiFymMPupU1SFucscD1Xt0suKbq5K0cH/CjB+50yHVmOZAloQCqWU9HaKrXqm6mnyoA6KPOzSAHMbgj/bD9ElH8P9r/h6tWRhh935nWI2XWikbW5PfFBEWu/Y8ONKNGCgrHycmOBGVgB9li/PFIXY/3mW2T5u+3LAR58BqM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063738; c=relaxed/simple;
	bh=Rmwx1CDLmP7RaBkRyUS3XeWazo6jnzVDSY8IF0uxTIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qm1UHUTf7bOo5NWcvCzCYEYGiGwcPQfrd9ORcvXQ9HirWrtUfl5YcYHRx+ICErx8Gfa2Nhs/G3wkQYvIyViZz7Og/OqjuGjMRX0/3mig5zE6MHSCtXt2oswgQ0uUgU5uQB2nRdNPC4og78byC3lPo+dfQlSzleeHJN7cHjCY2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBIjeszF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBIjeszF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB911F000E9;
	Tue, 14 Jul 2026 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784063737;
	bh=kKErBk/3Uq/oYibwOkI7H7R10DabeLhRs+U7a9mM74s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBIjeszFbKr9fIx+Ir5n5OfFHaH11Xf4XFCYRtRIFW37JVtLrheTIl7qjUMCml9EB
	 mQ8Iwa+9aH3cgHVjh13+jKK+AxvwxNnEDJSgEzmHBsOpOSPcOr1jK3xqQWPXCcnGjh
	 j+abggkZPevKX/YubFweL3rvmyWFMjrph3EwVQQ47nzot2Ks7jWHZ8wdr1HCrZuIos
	 uJea1mACwH41MfRbWs/U5KXO07Ojmi4shjZn4AmaEjOAxtoKn1XqEn5XpLT25W0tk9
	 43QOaom/IXWQSTrBcYJ6Sug8t56V7JyKR3lbf/Zlt2CoehBR3k46pfa1kHUIHt0sLC
	 j6QuWhVyQGD4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vfio/type1: Periodically try rescheduling when
 unmapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714210303.3967981-2-aaronlewis@google.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260714210303.3967981-2-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:15:36 +0000
Message-Id: <20260714211537.6AB911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of `BIT(PUD_ORDER)` to rate-limit `cond_resched()` evalu=
ates to incorrectly large values on architectures with large page sizes, fa=
iling to prevent the scheduler stall.
--

--- Patch [1]: [PATCH 1/2] vfio/type1: Periodically try rescheduling when u=
nmapping ---
commit 2d6c55cffed789bb39f187cfc28ac1de6edd70b2
Author: Aaron Lewis <aaronlewis@google.com>

vfio/type1: Periodically try rescheduling when unmapping

This commit adds a cond_resched() to the inner loop of vfio_unmap_unpin()
to prevent CPU stalls during the unmapping of large DMA regions. It
attempts to rate limit the reschedule check to once per 1GB using
BIT(PUD_ORDER).

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
[ ... ]
> @@ -1196,6 +1197,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iom=
mu, struct vfio_dma *dma,
>  			next =3D iommu_iova_to_phys(domain->domain, iova + len);
>  			if (next !=3D phys + len)
>  				break;
> +			if ((++i % BIT(PUD_ORDER)) =3D=3D 0)
> +				cond_resched();

[Severity: Medium]
Will this rate limit fail to prevent scheduler stalls on architectures with
large page sizes?

On an ARM64 system configured with 64KB pages, PUD_SHIFT is 42 and PAGE_SHI=
FT
is 16, resulting in a PUD_ORDER of 26. BIT(26) evaluates to 67,108,864 loop
iterations.

Since each iteration processes PAGE_SIZE (64KB), the loop would process 4TB
of contiguous memory before calling cond_resched(). As noted in the commit
message, 67 million loop iterations can take over 1 second, which vastly
exceeds the 100ms scheduler tick limit.

Could this use a constant size limit instead, such as (SZ_1G >> PAGE_SHIFT),
to ensure the interval remains consistent across different architectures and
page sizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714210303.3967=
981-1-aaronlewis@google.com?part=3D1
