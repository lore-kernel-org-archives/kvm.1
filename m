Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E83D6CA9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504275; cv=none; b=DY85OqfYRPsowYR6wdxr9CQ6a/aZoxdUdN2nbr7o6e6hiCQaUZZbkYWWvxvVvkwPBBh9b7R/8ZpAI0wMQQOfDc/lOCj+oFx6SKA/J3+Vr97rNlq2F0bAA0L2YbeiZZ5ilkN7xKAIsbybtn/9Td9kqePXaJ31uGMEacgU1RgFqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504275; c=relaxed/simple;
	bh=DJWTE6LFn/FwtziRLu35rzbUGYWKFLSBVuWW63zTWyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMreRJsijKlbZa7I9ebkV/1tRYTHquaUrnpC6aAFJ5QaovHmg7wLw0XFstnpIRaNH8wg4oChYipjKV3dSCmmae4RXC9ruCwafa+nnHnqNGZ+Jo83mPezLYJpN/Xf2h7rY/A4WBeSeDgOT8Jbmru39JdusFf6c6aH7lnyG7GBm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyfx2HdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyfx2HdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E18B1F00893;
	Wed,  3 Jun 2026 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504273;
	bh=JT+vGYtb12uWOvpeTnL1p++YnSgeDE0Alq4/hwR4iw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lyfx2HdZp/EUOxYkSPOQURxXiZji9bOsg2W+vKJxqhJodl4acI1c8XFxzqgzma3Ox
	 J5sK3XDLgGzpGqQbAdc8aAVa3dlu91aEp8a5gTVRRFcy/dfrz67sri4N16ueGdXheZ
	 MTPIUx18eKw/R5Mr4Q9tMho8NPneVg9NEDJcAsTsS2YzOvYH0QoEAQTwm8TXbCE+Pm
	 SFvI4aWRtUimMH4oG18A4zJPsXe6RHu+v+Dq4qKUlAIVsRMkAIDl/ZJYMEwMG3N1zQ
	 1pE9o6xgUgvxZSeNTHOZKiO5lCiUwQBR5KP7FlDraPt6QnHrd+lRUl1M0OyATQcJgn
	 gAXOoB53kgAuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 30/32] iommu/io-pgtable-arm-v7s: remove deprecated
 iova_to_phys wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-31-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-31-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:31:12 +0000
Message-Id: <20260603163113.8E18B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm_smmu_iova_to_phys_hard() returns 0 on translation faults inste=
ad of PHYS_ADDR_MAX, which is misinterpreted as a valid physical address.
--

commit 559ce0b481cdf56b10eb2174df50ab821772a973
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/io-pgtable-arm-v7s: remove deprecated iova_to_phys wrapper

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM v7s io-pgtable, as all callers now use iova_to_phys_length.

> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtabl=
e-arm-v7s.c
> index 62198e31a3937..da065747e37c7 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
[ ... ]
> @@ -641,18 +641,6 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_=
ops *ops, unsigned long iova
>  	return unmapped;
>  }
> =20
> -static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *op=
s,
> -						unsigned long iova,
> -						size_t *mapped_length);
> -
> -static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
> -					unsigned long iova)
> -{
> -	phys_addr_t phys =3D arm_v7s_iova_to_phys_length(ops, iova, NULL);
> -
> -	return (phys =3D=3D PHYS_ADDR_MAX) ? 0 : phys;
> -}
> -

[Severity: High]
While this patch removes the wrapper that converted the error sentinel from
PHYS_ADDR_MAX to 0, was arm_smmu_iova_to_phys_hard() in arm-smmu.c missed
during the transition?

In drivers/iommu/arm/arm-smmu/arm-smmu.c:

    phys_addr_t addr =3D 0;

    ret =3D arm_smmu_rpm_get(smmu);
    if (ret < 0)
        return 0;
    ...
    if (phys & ARM_SMMU_CB_PAR_F) {
        dev_err(dev, "translation fault!\n");
        dev_err(dev, "PAR =3D 0x%llx\n", phys);
        goto out;
    }

    addr =3D (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
out:
    arm_smmu_rpm_put(smmu);

    return addr;

Since arm_smmu_iova_to_phys_length() directly returns the result of this ha=
rdware
translation path, it will still return 0 on RPM failures or translation fau=
lts.

Will this cause callers like iommufd and vfio, which now check for PHYS_ADD=
R_MAX,
to mistake the error for a valid physical address at 0?

Also, since mapped_length is not set in this path, will it break the caller=
's
mapping size calculations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D30
