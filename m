Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E223A8759
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661546; cv=none; b=AiyjlOuSdC+U5rOOKnfx6B4mUL7P2xHIBKQ2os9WTrretHHI+oeAtGFW3Xa2sOp0lzhON/wYHi6OTx/Gl9ktkm10gNjlz3C/DzGZgVfaO8VjRA2pLTBIBHYXHxQFTb7KXF5VljlJmOoZaKNC95xueuVdVGAf6NBju4ZUt/HxrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661546; c=relaxed/simple;
	bh=f8xaBSmaK2Zm/vtSY81QIsjj194l9S2TFlvJtf8mH7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qOuCqi/DV0kG6MkAWqV/7WqzdeMNIOa8qOzgj1awMru9BpaKS2sjG4JtIYu6h++PzzbXrf0aTRuUyAa/P6Xg29K+Y4Nlx+Y0PAi4jAjI/Fwt8OPRTppZN7nfCisTjuOjJMdnR1+AKe9XPlJdvQYUK9Lrv9kFYVvq3o0593e4PoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUJ+HtuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUJ+HtuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543991F000E9;
	Thu, 13 Aug 2026 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786661544;
	bh=qJEfPNtwW6Lypc28zjRFnewd58bpUDKPZ+4Vs/yXX0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUJ+HtuHyECVMbelHw08BS82g1OvJ4oA7WeTK4WSXEG/Av87xqOu6D29oHAlInSyd
	 Mvzc1RS3Mc12HjqagAM4mcIdRNASBvVZpeth0b0UeGLa1ATJaZqZ3S2VjqXn6IM/Q+
	 gMm6AGFaSrX/qqYtewmr4lqhZ+8c2PTPhUvFzbbsyQw1yZ7Hc6l84e3fn0Ainv3yuW
	 iibShekUUmSgz4WiLOHLQXQjJ2p1qHs1gpoHwArBrPVK4/jvlLvFELepCMaNZBhSYH
	 y7vvBaAiqYlwWaoTBPwUkdhlhVbwDwsOJE00iQlFC6/FdjCcyI3F5i40d0f2biFsh6
	 laPuDGHEbqNDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chao Gao" <chao.gao@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260326084448.29947-8-chao.gao@intel.com>
References: <20260326084448.29947-8-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:52:23 +0000
Message-Id: <20260813225224.543991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The module pins itself in memory and becomes permanently un-unload=
able due to a reference cycle.
- [Medium] seamldr_init() failure propagates to tdx_host_probe() and fails =
the whole tdx-host module.
--

--- Patch [7]: [PATCH v6 07/22] coco/tdx-host: Implement firmware upload sy=
sfs ABI for TDX module updates ---
commit 805f010d78ca6bd2ca042a5f57d4d4c84f3c2978
Author: Chao Gao <chao.gao@intel.com>

coco/tdx-host: Implement firmware upload sysfs ABI for TDX module updates

This patch introduces a sysfs ABI using the fw_upload framework to allow=20
userspace to provide TDX module updates. It explicitly chooses fw_upload
over request_firmware() to give userspace full control over module
versioning and non-linear update policies.

> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/td=
x-host/tdx-host.c
> index 01f68c390a49e..d4a5528530211 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
[ ... ]
> +static int seamldr_init(struct device *dev)
> +{
> +	struct fw_upload *tdx_fwl;
> +
> +	if (!can_expose_seamldr())
> +		return 0;
> +
> +	tdx_fwl =3D firmware_upload_register(THIS_MODULE, dev, "tdx_module",
> +					   &tdx_fw_ops, NULL);

[Severity: High]
Passing THIS_MODULE to firmware_upload_register() increments the module's=20
reference count.=20

Since tdx-host uses a root faux_device without a sysfs unbind mechanism,=20
the elevated reference count will cause rmmod to always fail with -EBUSY.=20

Does this effectively pin the module in memory permanently and prevent upda=
tes=20
without rebooting? Should this pass NULL instead of THIS_MODULE to avoid th=
e=20
reference cycle?

> +	if (IS_ERR(tdx_fwl))
> +		return PTR_ERR(tdx_fwl);
> +
> +	return devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
> +}

[Severity: Medium]
The v3 changelog mentions "Don't fail the whole tdx-host device if=20
seamldr_init() met an error", but returning the errors here propagates them=
=20
back to tdx_host_probe().=20

This causes the entire tdx-host module initialization to fail if the option=
al=20
firmware upload interface fails to register.=20

Did this inadvertently revert the v3 design intent? Should this function
ignore these errors and return 0 instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260326084448.2994=
7-1-chao.gao@intel.com?part=3D7
