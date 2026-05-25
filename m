Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D04391849
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779747516; cv=none; b=iepIUXUt1mXD1rnethJTbsS41us4LK62M9Z2gpg/ow1iws1zduSmT2Etzbe5HdpobVbu6aWgKP1RqavqU7WhiR6DfZZpX8pWs7w6Xj19tyMS4QcYPVBqtgwNQbl5UfaHMfyRkmwaF3maUhspleWTiMnohjGdV4ZwzdNJntmpGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779747516; c=relaxed/simple;
	bh=NFv3DQlS3uYPbNXFT+VtHuR/eXG9+aZzF8uaAc26LLE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkjU1aWSBTLWu6p/bUnvtXlhcjZmC/Ou1MXDz7910m+pQvfWj4nT9PKUjmQRppv1ZGajPvkUGFCtwE/mXnmjqzDQzVjZRKw9OQ/aIP9XZw47NboK6G5+qklau4DbW2ULNK4hSTX5QDtXbimWdGaviSS3TiWNBCY9NKVqTGpvE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzMa0yEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzMa0yEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7021F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 22:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779747514;
	bh=KTCPoQMut77fHL82cZbX/ctnP32auDjBhu+RSLlB8Xg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CzMa0yEifxslrQT6EEqV9BhckhdzIflODAygpy4JggRvahDR+bXgbDLytOZFILK0H
	 nV3H8RArHm4xodmILhKzOdu8srnegeCHmBT2H28HiqLnw0fKhUs8J8ZsuPtDMM1A8w
	 a03VMAUBNEF45AQ3sQT/fF6GOX3Bv+in5PCJ8vtUOF86oboFcVenT7yjZ23Vq7y5nh
	 brpwR0Z5aW1o/5tywV/HupjUVmTXC3mxKpog4saYtRdTsYQlMgKSH1U5ueWNxcZwo5
	 PHlVLxIKGV2PxliDr07duJ+uXLrCKWnu7AbPqzJXd0980Z4/Y5nlWq/Noma/CzPmyw
	 23Q8750K1ko3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525154816.1029642-6-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 22:18:34 +0000
Message-Id: <20260525221834.AD7021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The ioctl handler incorrectly truncates the `ssize_t` residue from=
 `tsm_guest_req()` to a 32-bit `int`, causing valid large positive residues=
 to be misinterpreted as negative error codes.
- [Medium] The `IOMMU_VDEVICE_TSM_REQ` ioctl omits the TSM implementation-s=
pecific result code (`tsm_code`), preventing userspace from forwarding it t=
o the guest.
- [Low] Manual initialization of `sockptr_t` bypasses kernel macros.
--

commit d5ee59b85809ac88694767fcc899de1ccc2821ca
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/vdevice: add TSM request ioctl

This commit adds the IOMMU_VDEVICE_TSM_REQ ioctl to issue TSM guest
request/response transactions against an iommufd vdevice. It forwards
these requests through the new tsm_guest_req() helper to the PCI TSM
backend, supporting CoCo guest device attestation.

> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> index 09ee668dbed9d..342fbdb6a6b95 100644
> --- a/drivers/iommu/iommufd/tsm.c
> +++ b/drivers/iommu/iommufd/tsm.c
[ ... ]
> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int rc;

[Severity: High]
tsm_guest_req() returns an ssize_t representing the unconsumed byte residue,
and the user-provided req_len and resp_len are __u32.

If the residue is between 2GB and 4GB, could it overflow this 32-bit signed
rc variable and become a negative value? This could cause the libc ioctl()
wrapper to incorrectly treat a successful request as a failure.

Would it be safer to return the residue by modifying a field in
struct iommu_vdevice_tsm_req instead of returning unbounded positive values
via the ioctl return code?

> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_req *cmd =3D ucmd->cmd;
> +	struct tsm_guest_req_info info =3D {
> +		.scope =3D cmd->scope,
> +		.req   =3D {
> +			.user =3D u64_to_user_ptr(cmd->req_uptr),
> +			.is_kernel =3D false,
> +		},

[Severity: Low]
Could this use the USER_SOCKPTR() macro to initialize the sockptr_t safely
instead of manually setting .user and .is_kernel? Bypassing the macro makes
this fragile against future layout changes in the sockptr_t structure.

> +		.req_len =3D cmd->req_len,
> +		.resp    =3D  {
> +			.user =3D u64_to_user_ptr(cmd->resp_uptr),
> +			.is_kernel =3D false,
> +		},
> +		.resp_len =3D cmd->resp_len,
> +	};
[ ... ]
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 3870d08ffe0d1..c24886851f9e0 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
[ ... ]
> +ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *inf=
o)
> +{
> +	int ret;
> +	enum pci_tsm_req_scope pci_scope;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	ret =3D tsm_pci_req_scope(info->scope, &pci_scope);
> +	if (ret)
> +		return ret;
> +
> +	return pci_tsm_guest_req(to_pci_dev(dev), pci_scope, info->req,
> +				 info->req_len, info->resp, info->resp_len,
> +				 NULL);

[Severity: Medium]
pci_tsm_guest_req() supports returning a TSM implementation-specific result
code via the tsm_code parameter, but it is passed NULL here and omitted
from struct iommu_vdevice_tsm_req.

Do userspace VMMs need this architecture-specific result code to
determine the outcome and failure reasons of attestation flows, and
accurately emulate the hardware TSM interface for the guest?

> +}
> +EXPORT_SYMBOL_GPL(tsm_guest_req);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525154816.1029=
642-1-aneesh.kumar@kernel.org?part=3D5
