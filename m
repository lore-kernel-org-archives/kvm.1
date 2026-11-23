Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410215;
	b=KSXMrnSQbz7m1COAXISbgTO5WtxYf6ks0I8w6jDTKDnTF7EBClYiIki94YAHzKl8MJOh
	 6jhqc1FKwZkQE2qeC/JZGZSE4F2VFHjr4nVB2fJP7NX3DmsRRSqQFOEjgeW0EoNRRsqIo
	 zfUbeTT0Th7IW1z+/pa59ooPgfQzycvlab+37TTYbnmHjuGE9KSa1s9GSdjzA6d6maUcQ
	 6NnqivjowlIOiVNzD8A9/8/ABijmtDVlE/N8JEIehWMZO9LENCafohoVOmzu+KQf8ThLF
	 o5cH/EuwHkuHq66YZ46VjtIS+l6WhOqzHRO2CRVdGbBQk/RVy418GoPgAPhcEzUMCnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ja68ta5Uvv/X7tlfS/FLMn/QCYhgN6RFfe6zUh8PhNE=;
	b=Ataw5TA0tT0NV+E4IBck5eWpejqFUWb/m5lpzI+ikNT510HfBUF+eQfmKaKVD5YDMTvE
	 eDsd/4B2vMjiPPkRTuQvl8/mcvb1KExxCw2aRsts0slRe2StY46BCQTJR00NEw/kiWpDT
	 bHbfAwMS5vnW2DZouWKvbAmjfF+7VEDSDqprPseC1oyKA3hRBTbgfeIScLF8kdWOLZxWC
	 2PRJZPvDgjmJQZynoh7955+qjrhoR2VGsbx0x4AqOmF5sCTVM6Nor7PLzIQcliBtmXfPb
	 N0i2gJUxCIqVIj6XsgyjKDyukawPIJ+AnwjOEvmywzhtDyPK4XC24RLvUYJRfucEGXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDYfBxbU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7371606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDYfBxbU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F391F000C6;
	Mon, 23 Nov 2026 05:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410215;
	bh=Ja68ta5Uvv/X7tlfS/FLMn/QCYhgN6RFfe6zUh8PhNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDYfBxbUjUiajsOIA3Gi0XTFzODZfSTDlj2eGTsSBK2XQ3c1iZmh5emqaXK6C5Jer
	 bBbZtFTzk5Nv0kLYk6b2Xlz9XCueH4AA+KXi1xys9tzInXXflF1BVjk9VWMlvg5aOy
	 qqCwKEsmZ0nNcpasd4mE7eOHw/N6XeF3uWOO86UxIHP5TNGcUE8zUKydJisBNBUTRE
	 QKdnlfrNqSp1saxTA1I1wYBOtKr7KnikDwGhhkogJU/dWzKFW8FChPeoB0m3Md/Ukw
	 fm82MpvN8ySO+DGYMjz2gAwH6TciOM58Y4Oj8uJqfmezu+lcJ8NYpNyqDwkjmq4DDE
	 29m58iLaPAVig==
Message-ID: <sashiko-outbox-228696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/18] iommu/vt-d: Handle reattach of the restored
 domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123044949.3610702-15-skhawaja@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-15-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 05:03:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] iommu/vt-d: guard(mutex) mixed with goto in
  domain_attach_restored_iommu()
--

commit 693fa762fb6f04c8a284677c5b4a1aeaceac5c22
Author: Samiullah Khawaja <skhawaja@google.com>

iommu/vt-d: Handle reattach of the restored domain

This commit implements reattachment and detachment of restored domains to
preserved devices across liveupdate using the preserved domain ID, without
modifying preserved context and PASID table entries.

> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveu=
pdate.c
> index 34651698b8e9a..f907e52576e57 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -444,6 +444,176 @@ void intel_iommu_handle_drhd_restore_failure(struct=
 intel_iommu *iommu)

[ ... ]

> +static int domain_attach_restored_iommu(struct dmar_domain *domain,
> +					struct intel_iommu *iommu,
> +					struct iommu_device_ser *device_ser)
> +{
> +	struct iommu_domain_info *info, *curr;
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int restored_did;
> +	int ret;

[ ... ]

> +	info =3D kzalloc_obj(*info);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&iommu->did_lock);
> +	curr =3D xa_load(&domain->iommu_array, iommu->seq_id);
> +	if (curr) {
> +		kfree(info);
> +		if (WARN_ON(curr->did !=3D restored_did))
> +			return -EINVAL;
> +
> +		curr->refcnt++;
> +		return 0;
> +	}
> +
> +	info->refcnt	=3D 1;
> +	info->did	=3D restored_did;
> +	info->iommu	=3D iommu;
> +	curr =3D xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
> +			  NULL, info, GFP_KERNEL);
> +	if (curr) {
> +		ret =3D xa_err(curr) ? : -EBUSY;
> +		goto err_unlock;
> +	}
> +
> +	return 0;
> +
> +err_unlock:
> +	kfree(info);
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but domain_attach_restored_iommu() mixes
guard(mutex)(&iommu->did_lock) with a single-use goto err_unlock label (whe=
re
the lock is still held at the label and released by the guard on return).
Following cleanup.h conventions, info could be freed inline before returning
on the xa_cmpxchg() failure path, or managed with __free(kfree).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123044949.3610=
702-1-skhawaja@google.com?part=3D14
