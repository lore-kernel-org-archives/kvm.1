Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355C38C437;
	Tue, 26 May 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783536; cv=none; b=p6lZAssWLPZ1zSr5RmmxW3WxihiBLVVLgwGP0N8wYRwwEeL3r8guyHXzPWW3suC9kShYdUWKOJAKRyQwNvZgsil+tMARTONFt4/xEBfVk7IKg6A3mjwnC04R/rAafqW89WN87/BOo2uNJPmYvX0IVy+y9ZR0hYA58GHbXwPbmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783536; c=relaxed/simple;
	bh=7P07CdNOmQGZJg0EfjRUCspGiu3wZVRoU5sO7ejYFVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKD1F1nUMkpDs/pvzS9wuutvrAuvM6Qdfu0Cht+C/C3K76iETbFKF+1PDYv/xf2h38aS0AvHs32Zc7Hrmqsl6v82s0lIDDbnYcoyOYTOQPGe0z7AuNYPppXQa675yvw46WHMRnkY3+owUCvJW1koI3kOSNfgrKknaw9b2ce/1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhoaFJ8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhoaFJ8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B0C1F000E9;
	Tue, 26 May 2026 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783534;
	bh=RXdz+9PIJL9vx3rhCrYf2R/KTQGogpAk1EQvVwIpdTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YhoaFJ8wrC9xwTCjYSyEEnZM5dx/I8fEq65/EY9kz2L9wZEf/dmXSda69IjErci3X
	 h2HS/THuoineYzYBkpICBbL4kaUh0Y08PqkZ/4apbAHZlKStj2yYr6/Jx0MJRsxP2S
	 U2NV55R59Yd60YPK7xq/cxqZCqcyN0XjvyQAjkW/LL2JaYk4oRq1CWH2EMS7AM5X+b
	 nJ1++ZbieLKLvkKCTMhfUzwmU31iscN8rEOcxrYwtP2MFycPdVQtq1ya2xgDUAMBsB
	 GLv6BedlIYhuabuJuNBSTK8l9Be1j+v9nhUhFY/0T8w0H9wbYdHRbtn4OPrbYUiyfJ
	 t8v5uFFLA9hhg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
In-Reply-To: <20260525221834.AD7021F000E9@smtp.kernel.org>
References: <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <20260525221834.AD7021F000E9@smtp.kernel.org>
Date: Tue, 26 May 2026 13:48:50 +0530
Message-ID: <yq5ase7eshw5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The ioctl handler incorrectly truncates the `ssize_t` residue from `tsm_guest_req()` to a 32-bit `int`, causing valid large positive residues to be misinterpreted as negative error codes.
> - [Medium] The `IOMMU_VDEVICE_TSM_REQ` ioctl omits the TSM implementation-specific result code (`tsm_code`), preventing userspace from forwarding it to the guest.
> - [Low] Manual initialization of `sockptr_t` bypasses kernel macros.
> --
>
> commit d5ee59b85809ac88694767fcc899de1ccc2821ca
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> iommufd/vdevice: add TSM request ioctl
>
> This commit adds the IOMMU_VDEVICE_TSM_REQ ioctl to issue TSM guest
> request/response transactions against an iommufd vdevice. It forwards
> these requests through the new tsm_guest_req() helper to the PCI TSM
> backend, supporting CoCo guest device attestation.
>
>> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
>> index 09ee668dbed9d..342fbdb6a6b95 100644
>> --- a/drivers/iommu/iommufd/tsm.c
>> +++ b/drivers/iommu/iommufd/tsm.c
> [ ... ]
>> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
>> +{
>> +	int rc;
>
> [Severity: High]
> tsm_guest_req() returns an ssize_t representing the unconsumed byte residue,
> and the user-provided req_len and resp_len are __u32.
>
> If the residue is between 2GB and 4GB, could it overflow this 32-bit signed
> rc variable and become a negative value? This could cause the libc ioctl()
> wrapper to incorrectly treat a successful request as a failure.
>
> Would it be safer to return the residue by modifying a field in
> struct iommu_vdevice_tsm_req instead of returning unbounded positive values
> via the ioctl return code?
>

req_len and resp_len are both 32 bits.

>
>> +	struct iommufd_vdevice *vdev;
>> +	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
>> +	struct tsm_guest_req_info info = {
>> +		.scope = cmd->scope,
>> +		.req   = {
>> +			.user = u64_to_user_ptr(cmd->req_uptr),
>> +			.is_kernel = false,
>> +		},
>
> [Severity: Low]
> Could this use the USER_SOCKPTR() macro to initialize the sockptr_t safely
> instead of manually setting .user and .is_kernel? Bypassing the macro makes
> this fragile against future layout changes in the sockptr_t structure.
>
>> +		.req_len = cmd->req_len,
>> +		.resp    =  {
>> +			.user = u64_to_user_ptr(cmd->resp_uptr),
>> +			.is_kernel = false,
>> +		},
>> +		.resp_len = cmd->resp_len,
>> +	};
> [ ... ]
>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> index 3870d08ffe0d1..c24886851f9e0 100644
>> --- a/drivers/virt/coco/tsm-core.c
>> +++ b/drivers/virt/coco/tsm-core.c
> [ ... ]
>> +ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
>> +{
>> +	int ret;
>> +	enum pci_tsm_req_scope pci_scope;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -EINVAL;
>> +
>> +	ret = tsm_pci_req_scope(info->scope, &pci_scope);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return pci_tsm_guest_req(to_pci_dev(dev), pci_scope, info->req,
>> +				 info->req_len, info->resp, info->resp_len,
>> +				 NULL);
>
> [Severity: Medium]
> pci_tsm_guest_req() supports returning a TSM implementation-specific result
> code via the tsm_code parameter, but it is passed NULL here and omitted
> from struct iommu_vdevice_tsm_req.
>
> Do userspace VMMs need this architecture-specific result code to
> determine the outcome and failure reasons of attestation flows, and
> accurately emulate the hardware TSM interface for the guest?
>

Will update the iotcl to include tsm_code as part of the response. 

>
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_guest_req);
>

-aneesh
