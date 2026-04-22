Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23937F748;
	Wed, 22 Apr 2026 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894724; cv=none; b=S719BcpjR0i5ylgq7sCS0ggsXb0XcAGV8cwaED9LtWM/2Dfhyv9meVTBfTy1VmkAiyHEi5GqtDFQR8hJFbZQrU5lsZ0ztL2PKu6C3DbkreRJxeCI4tvHOweA+3E78iTZSoPCXG5bpHfuT7CdexDKBo0BLUqyd4jTrBeLqcZldjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894724; c=relaxed/simple;
	bh=4hA9OFT+TPIXbKEYP00KqviwuGS6nWd52nQD9wvJwKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+hGGnSo7PGry21D6r6j2Wo/n0n8DwGxI30DrWYdhfYweOH/9FmFABJesm0YoOcjdumgQKlS6qBRfKtDcWeBsCSlj6bF9O0sXsECOvE5+1R0Z2axgaoMhMUgQtqtKdqDc+/4fY5/Z/qEqJATlm//UJMu+I/ZcAXSaga1LRCZd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JYn9jppJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pG3l27/o; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JYn9jppJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pG3l27/o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F48C7A013C;
	Wed, 22 Apr 2026 17:52:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 22 Apr 2026 17:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776894721;
	 x=1776981121; bh=NSnpkk8xYSBOxOPINgOjxenZ4JMIPecr2wPyzONj7pY=; b=
	JYn9jppJ4EM5GyNrIuuBAaB1NNOecCbqPQwZhAHfd9DrbyOI/6Bi1LR6sd4eAmPg
	I/Lxl7hXACXCzauuwXKyBZxEjkFWC6p4Bttfn5zRjgzYKia/rVfEC/Fohoqew6ph
	AnNgJT/SK/IZ/d3sZU9hor+Zld5hHYxu5t6+yCjTxMHdudrJ0BFEowf31qBmqVbT
	nhFEo2x+ZW5nE7MiPppwazGcoQgJuBJOWoLSGK1LnIi5rC9dzhrXb2wMbScJCzpH
	rXXKh7VzuE1zTyL3wsxezDOjQ1Ewj+G60Tk1bK4uUUchAkW9drJgyahx64w9xHc/
	Mf4e+H6MPP3GleOaic1LIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776894721; x=
	1776981121; bh=NSnpkk8xYSBOxOPINgOjxenZ4JMIPecr2wPyzONj7pY=; b=p
	G3l27/oREjiMQqwYdhycquvPuPQ0YGEYOrys01Wnagr0nXGurC3qZvymcBphHUqY
	WbeOdnjmbVTB9nVz1eUgRHRP7UWp1RvqmOzL+DXLo04kLLFJjheeJuVKZwVyMtac
	R1ZJGEO+UZ14i/ohqiHafMy/o6fhobmtRCWoUhhgQWdLK+NXDCxA4AhIdI0i90/L
	OEfZtkrhOe+mQnMa6iIEWceBj73/Rzl9s47I/fl96bA78A+NkKb3axO9h6b5uiGZ
	+wap0PlfmO+Wv7A9AKGzop0sNloXasg+yuwoDqzuIW6eDKAArb6glAAaBzODttmU
	5bKHiHtyGHy7MfjXndutQ==
X-ME-Sender: <xms:AEPpaY5LzMlg7VNprmbe5byPqTQrRdx4GJMD2bqHzrw1EqmyUfkITg>
    <xme:AEPpae10UlCSOz4xnxNLj8brLUmrNglrjzrMLMKvPMz4RToXXsU9dwTmlxo02Ws-R
    OA4o_q8drjKrWQ9f9p8TJOz49AF2He45HU0ESbM9oIiT-R1kiSo>
X-ME-Received: <xmr:AEPpabvmJBpN8b7D-4ffcJM9-MX-HLyU1O7qKiCgJBCqpNdb09yb7pVQKf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihhrohhnghhqihhnghessggrihguuhdrtghomhdprh
    gtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopehkvghvihhnrdhtihgr
    nhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphho
    phhplhgvsehnvhhiughirgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:AEPpac71BzmVPkKpYmRHo0UKZwaKMNuUGWwyiomdqTpDKpvVShiuDw>
    <xmx:AEPpafe4KXYvYxXrTWi4NgC9tpOaibwTPWNDGxUDKoQX91io0xMTWQ>
    <xmx:AEPpaRyScflSoXUElUvgQpTiztdu_TFP-dFHZO957dfljyCcnL9dLQ>
    <xmx:AEPpac-WFqz5zRIAO9WT0R1veIvqaIZX1mTpYsdn8Gxn4XJBEtzhtA>
    <xmx:AUPpaWDgeZbLlP5dBv8lgsozLt_l4jGV2bSUqDJK-hjTCaUJUFlAjY8_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 17:51:59 -0400 (EDT)
Date: Wed, 22 Apr 2026 15:51:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Ankit
 Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alistair
 Popple <apopple@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Allow disabling idle D3 on a per-device basis
Message-ID: <20260422155158.527a0765@shazbot.org>
In-Reply-To: <20260422081307.2550-1-lirongqing@baidu.com>
References: <20260422081307.2550-1-lirongqing@baidu.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 04:13:07 -0400
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> The disable_idle_d3 module parameter currently toggles idle D3 power
> management for all devices handled by vfio-pci. This is too coarse for
> environments where only specific devices (e.g., certain GPUs or NICs)
> have issues with D3 state transition.
> 
> For example, some PCIe devices exhibit hardware bugs or firmware issues
> when entering or exiting D3 state. These devices may experience PCIe link
> speed degradation after transitioning out of D3, reducing from Gen4/Gen5
> to lower speeds, which can significantly impact I/O bandwidth. In such
> cases, only these problematic devices need to have idle D3 disabled,
> rather than all devices globally.
> 
> Introduce a new module parameter 'disable_idle_d3_ids' to allow users to
> specify a list of vendor:device IDs that should have idle D3 disabled.
> 
> To support this, add a 'disable_idle_d3' flag to struct
> vfio_pci_core_device. This flag is initialized during device probe
> based on both the global 'disable_idle_d3' parameter and the new
> 'disable_idle_d3_ids' list. All runtime PM decisions are then shifted
> to use this per-device flag.
> 
> In vfio_pci_dev_set_try_reset(), update the logic to iterate through
> all devices in the dev_set and respect their individual D3 settings
> when performing a bus reset.PCI_DEV_FLAGS_NO_D3

There are device flags that can be set by quirks to handle this:

enum pci_dev_flags {
	...
        /* Device configuration is irrevocably lost if disabled into D3 */
        PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) (1 << 1),
	...
        /* Do not use PM reset even if device advertises NoSoftRst- */
        PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),

Ideally vfio-pci.disable_idle_d3 would be your debug tool for
evaluating issues with device level D3 support.  If an incompatible
device is found, we should attempt to resolve issues, like link
re-training, or at least contribute a quirk for the device so that all
users benefit, not just those with a magic list of broken devices.

You also have the reset_method sysfs attribute at your disposal to
manage how we trigger a function scoped reset.  Thanks,

Alex
