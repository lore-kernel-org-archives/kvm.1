Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98655D889
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095928; cv=none; b=dbSZOaqqkwxWjql9spRS/UJ/cvSCRBZTevgfHQHV2EJNhNiaWUj/bNTVVZEOO+SqGktZcNPYCbj0p1s4+MbtMGXtXWU7zL+QFITSsYuGVilpg9+wFgVcIz1/561bbXyBAZfItn+r5QvfnTXXNIvycQ5QedSAjpUIomLIMKjWRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095928; c=relaxed/simple;
	bh=ohSNWTMc1i9x1RIYDHajEGmflI2MmuOm55ScfjpqJak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzAdh67cyRY9ekwjenb6yF2/gNnD7E18qE6iJ0ppiyEFUEEArtzIZd4lEqv3CmKv+DoUJydVTpFB+rZJm9oQ3+6zRkBWfbF/Gd6j1Ou6huFW1wCsDeaeI/BQHBNFycj/kLpvqvg96ISmo6Q5ROSuX2+DKxFSZKFgY2mPDmyn5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=nhHKUQtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndRC8o72; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="nhHKUQtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndRC8o72"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 02CE41D000BC
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:25:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792095925;
	 x=1792182325; bh=Sww3R/VX25uolOQ8fO9EbTe9gZvDFuDQzrStIIgWqzA=; b=
	nhHKUQtlYos729HPdlJiozjrUQHq6Tf1ZpIUCmN/WUnr/D+9NhYE2wux9i6x76vH
	wXSbeDFpOf3ZNuANrOUN3iNjqqv2Gl0xVDSyw9blevW4I4dL3xVTmd2jkCLtBMCl
	vcyYkVUGTIO0yowBRJ6Hs2KSnH4GWQiB/TjGJgSvlAINtlHtD9oRMOQ1pkJxk/K1
	1Hfs1TGli1s75BVxBAjfC/hUBReM79eCuOn4zc/cE3+eut6HHevgsw/tM7NZP7sr
	EoSBMDO6BhOgeo0g5alyOSBvvCb7sJfgul78fs2zROIKtz6QeWtaFZXE8esuEDJh
	voGoLG82dz8n0P1cOQYbcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792095925; x=
	1792182325; bh=Sww3R/VX25uolOQ8fO9EbTe9gZvDFuDQzrStIIgWqzA=; b=n
	dRC8o72pkljfzsK5UHNunM2CPyiC6AEhp4OrOvMp3Z3gQDmZvjgy3raBewApbYcl
	3iP3QppBQz4WoKx+beVMLmFX6HRKncwlgbsppsqLxCec+qGLpHhY0NL639e+6i5o
	9a37j/Du4GJk0ex7HH6p/+DzU1pwZsXvYau28OegkNIMBQhLLnN0Z8faK9sra+qA
	+ugmRRZLdqQzwodoxgnZIdpPCNomEnirbEE4jAPkil9f8zBiPmvWtJE5NOwVIrnY
	3xBmeJbBtJzy2MKSmnHKk35LXylEHUCiNKSF63RhKsEbdWZ8BAPGQ5cx0rwrv9fR
	KJgb3iB4O+5WPNLdPROcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792095925; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:sIRM43xbspT8tdR3feQDOsz5ko8yAuDp2D46QscId1tWFmE
	d6WhqXQBiJcp3ZCsEHtw27k10yX1sP3uKOWdsHYhAWWdyT3aRW/OrxXZ1+wITGuO
	lcSKofU06ibHZUrM/TbIel5G52iVG0l6tNXUaLwlU4/vSsjN1bQ7AuA7leze7Q6E
	kriwYczQf//7CDmtFwtheLqnLn68QIdAWRF6tEXq5cSy943dRryiAYI80wtKNiSK
	vk02yf/8WDv0mQUHTpgxzIK+UH/4HiPm4zVjlMvrtVURP3rZymcCeg5UzYTQNxRl
	jiJEMOwUlIhlbcRoFu2ZzvSzJ8eH1cs/ugdMXCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D1ZDaf6qxHsza0NFT9xO6R3fAcB3uXofasbHkTinHmw=:ohSNWTMc1i9x1RIYDHajEGmflI2MmuOm55ScfjpqJak=;
X-ME-Sender: <xms:tDbRahFbNadZttAEAk_s_FNOKq6DfMiQUGMj483lkH1cwmw-tjdQdQ>
    <xme:tDbRavp7IrdmofsMlKFxNGfdBXLSZrQBKe_egelBBqQ9_8hpAnPg8YxCgMOHVB02F
    85_AYe5pxm4HPSChtV1zkRAl5YJplu35LMH-cFUwnR1wra1DxMQ_Q>
X-ME-Received: <xmr:tDbRaqY0_3FzgqDtxjVQI1bsnDO4S5MloUJpJmTXjkhDknHKkxxu0Li91v9PjA>
X-ME-Proxy-Cause: dmFkZTEHmFmM49NNe27fqs5QH7E5eRsDwnB+o9tR4Hz6D539LuhgIMDtTipijxaPtcylM5
    rSCBW8II8rnvpu9BffMNrH6QeDo66Sn/OME7Oi9T9dQLG8wXuOXgv3KP5PhPr/rd0/ECUI
    3LBLdxBoshzwbZhb3/u//vNxNu0z8gbMCtiX+soq5on/jkN3LG4TL2AKSlDvxHaB8j71au
    mu+iXsLiQiyAK5yjqggTzL1CRH6uT92GUYqqwsksLsW/Jbaj+OWv5IBJuLkRJI3JAuV0rC
    Vveedlv5sj2ENScqsAkRMcmgcO0669d1bFm2eepH5tSFseZdM/ax7Db1N1yuWm9Uzo8CBC
    /geWnA7LSe/Y39Oy9oj0IZ59opAX+aeXpZm5rsl885Nv1UTraX01tzO1sg1DFQyG9iXcWi
    /g48nJtKgMsZTLNhdJTrXru5Idqb0IQIppFWjOaycMCbn6BZrMg78wWU4/yjIYT034piSN
    T0fGvmjzGB9tbQUyWtmIfHyNCgO7WZXB/3IcpepS3vSCZ0vL25cKNnQ0uHjb3H5qxCVGeM
    qD8wtGTQ6lVEmDrnwxT7DQzwbfct1C+68jbqS99tciUd3aiPpb/VZ6GeorigI64abDxUep
    Hc9FpRdvxr0CtWzdzsA73y6XwwEMkH2NuuSNaJUS6xmgoXqtssOnDoEnWeFw
X-ME-Proxy: <xmx:tDbRaoWtLt9HnCT5y94qdO02P4jdXiiI-9BlATfpPcW4cDcWsAMYeg>
    <xmx:tDbRaj_WaVGrViBR0qa0dhVkWflxyaYi6waJkO0RtEOQtRjEr_UCtA>
    <xmx:tDbRah_XbuPn6oo78XEFQCPSOgT-_P7L2WinARG8VSdo_O2zSwVbsQ>
    <xmx:tDbRajROT4m6vl1zkYaExzFaTASSRJlV6xEl41s6SUspzva0v_PX6w>
    <xmx:tTbRagxXR_bMfTf0OzTzjqCe5DITWbP4SBpPNIKqFj7gRMeQOudSAerB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:25:24 -0400 (EDT)
Date: Thu, 15 Oct 2026 14:25:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v6 0/2] fix two issues in hisi_acc_vfio_pci driver
Message-ID: <20261015142522.085c6e5d@shazbot.org>
In-Reply-To: <20261013071929.3988687-1-liulongfang@huawei.com>
References: <20261013071929.3988687-1-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 15:19:27 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> This series fixes two issues in the HiSilicon ACC VFIO PCI driver:
> 1. A NULL pointer dereference in reset_prepare() when a PF is bound
> to the driver and passed through to a VM.
> 2. A 64KB page incompatibility on QM_HW_V3 hardware that breaks
> migration and the guest kernel.
> 
> Changes since v5:
> - Fix a potential NULL dereference in reset_prepare().
>   Open code &qm->pdev->dev at dev_err() to drop the local variable
>   evaluated before the mig_ops check.
> 
> Changes since v4:
> - Removed dev_err() log from reset_prepare().
> - Removed redundant pdev->is_virtfn check from probe().
> 
> Changes since v3:
> - Merged the set_reset_flag fix into patch 1 (was a separate patch in v3)
> - Replaced pf_qm guards with a mig_ops check at function entry.
> - Moved the 64KB page check from open_device to probe, selecting generic
>   ops instead of rejecting the device.
> 
> Changes since v2:
> - Remove redundant qm->io_base check.
> - Drop PAGE_ALIGN for BAR2 configuration region.
> 
> Longfang Liu (2):
>   hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF
>     passthrough
>   hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
>     hardware
> 
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 46 ++++++++++++-------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 

Applied to vfio next branch for v7.4.  Thanks,

Alex
