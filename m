Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E124421233
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661717; cv=none; b=p2qeOJmdnpsw2ltOEP2NQs13/JpEhiefhE4Uqy38ODljfrIr7Ih6sHgfcTM0aeuMJuqtjPsyI7b4fsPI1tT2ZZyPcsvSaBteWNPL75YIZoVBwzK4H8iqZZqh8flbQM3/1geCVC88E+dnBOUbyjUjCIlzfPnA3YPwUTm0Yc1DLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661717; c=relaxed/simple;
	bh=Ip47nGqRYuZ9uP7eugq6vHsOVJqhA+tGe0zMcvunU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTKb3nCh7fk9QI6nQghWE8R/Qq7+5x6LyL3J9jrbOqqX/KDGHCqRbmIJ/xdqISd+3mCxkcWnx1AD8HbYGI8MOd6sU2GcHPNCKEtMKtFq7K2h+Vz95MquWjMZyFLg+kQ1P8gSiSxgT07bZ+M6cSkxx523OEDpLncYxwSOFtoXoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dFjhU9BB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOsIZFY5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dFjhU9BB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOsIZFY5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 78B061D000B7
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 15:48:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 10 Oct 2026 15:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791661710;
	 x=1791748110; bh=Mpk8tuq3ZKdRKx7sF2neLgFdiyY8Y71+3ELpGFZGVYQ=; b=
	dFjhU9BBSsq+SYwRuKmXvJizGAnywZFi1/eB+IKWaddlzr93Ws03rn6hyWP6jAIX
	L0biiWksuNjaF9MYD3/kOScHXYROWWDVTXy70r0MygraMjJ2Yy1G0DgovEwekKWb
	2AAYxcvQhU4PFf0aX4rEcaD1vlvtgHS790qySd+VYh9DlkykLblCdKNUCIAt2BbW
	qdKiiv8Q+dS56f00S7YOeIe5ulQX5a8DTq+5NEBXlszoVIkTOGNN0B2datVSMO58
	Kfmp82CpqzpZw9e63VcxkZz5Yss4XnTEFYgF9bexeBLnifzlwQuLsugQM1dN9Ihc
	TDJTIxC+g/pEwe454q4zhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791661710; x=
	1791748110; bh=Mpk8tuq3ZKdRKx7sF2neLgFdiyY8Y71+3ELpGFZGVYQ=; b=I
	OsIZFY58VCST4QRZs3KHsRpq/uen9aRCRa8z2t6KyVsNTNOzImTeMnHyiJWIvxaJ
	6eMtCdzv0nZHk56e4BGvnTTiXXRAygnlewv3+22cXLyvp7ssUluomO7vZ1PrLZJe
	y1rrcOrxm1r8o6gajhFsE6FZMjSz8ONvLvbDdr3FaHxrcZQy8zAGye/EXoJUjU1t
	c8fVgqo64Ep47EaSAVYIwg1mxTWbIFQ72fQTYB68MuUJKC488UvfF4GyAYpugkou
	mJJkE95yEDsO1aitkpgWq7+kmi1UNh3JhEyxVSvUx51G5Fu39EPiLm0+Mh9MpT2/
	Jqt/wCU+97H+0Vl7d2ccA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791661710; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:vnmtID0B8Vuy8ySbipdaW5x2Ry7V01KzIrb+Og1XMFIDacC
	5PJho9gJl8BCX707WKBNBp2hJUPoiBS/dXScuuczISIOGp2NW1jnP9atJOugd8Hy
	yJjuTt3y4DBDPq3HI0s2yhrI+vufbwj/F7mkGbzF/6mJdkfk6b4k0U+8Z+ZNx90F
	KwvsbLKLav16Aah4CJwXLTET1LEd5MWIBWjgg8wkxgTA+M26Zn/VSgzCghMkdXF4
	mUqifwOaUKGDLN9Z9xBg7PsbAbenEfclCp1cf1Q5CNXLULijN8Vd+DrOg648+w/t
	Od+A4bwjYCSC0ul9/yEA/PXyZOvZmyRzNENJF9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JQECRrIdci2KqkwXkXpU46/1WsnESaEY885b570AcOU=:Ip47nGqRYuZ9uP7eugq6vHsOVJqhA+tGe0zMcvunU2E=;
X-ME-Sender: <xms:jZbKam3LnieqAYm0CkTRcJiGlwhkuyqX6KdbH2lUw7Cm5nXmXlCDNw>
    <xme:jZbKaqY8rjX0jTnexfrsqKJpqCSwrtSvItTnrZ4mTPkxV_wyMwbqibzgvFQm5eHcx
    bW1_nEA4QSKFHj7C_XyYNJqf8crjo8pR-NdTzdLSk6E-TaVEMgL1YI>
X-ME-Received: <xmr:jZbKajj7493WMz4bJ9mvht12sRfpSln34-cmd9GQXbvAqh56-Y5gYnDUGt5Rsg>
X-ME-Proxy-Cause: dmFkZTGZTlwi8RbFEdb3MRZvUXZMBGNIKNyjY6VEepwpFmCKfXHuxsMoE+NyeflJwrIBhH
    IOz8Q+AH2x3zxMRSqt/OhPnXZXQhEh8JP+XiW5lxSXWl9nmxYWaL8Tiw9zab7V8YTLFCxO
    oE6Nd7TBUZklfkBpYEE3+OkCaPfS+Hi2LfcIXGZtE8Rnufb5CTEBTX2C6KD/Txqnpp2suU
    UdDB/Cc4Vvhxcvm5tCrFeLr2WhDzqG/Yr8r3a7BK0dgvJFczwSOcCmWfnVwkk4+2/mRTyo
    NCaPQ6SZt1qbWh6n/nWeTPORAaaabRggJeVzaLpx7q49ZRVQpchYcnvlFzZgtP0b2hywBN
    +2YlZG7EESVGKvez3+5GF07nOO8Su7Vf2oYHqeDaAQ/cqodAS5VXgUmVdJZHH72JX5yTx4
    0oIxpS00m9JQ4BRNhqBcwLFU1c2UkoQXvgSsmtOlvjK8o+KZRrVYhBSmWtzpXRmdqVm3Nn
    oVazj5QFHfk0HEkBDUjnL3EuNbufHBzKGOq5HsSmY4axPMBdlhzNA1/ew0zIbvG7EFfQ7/
    /KVwfYdY84AJZLssQ3VHm8h20j7yc8W4V/RtJkLSOQxUqS5z/jxbfwlKRRRPAozJoeaefw
    NPoXFelxKjHYNPoiESHmZjCtMmoNsie89aLgrv1YRM9cR8Q1J1Q6zU2T8rvw
X-ME-Proxy: <xmx:jZbKaqjuISDcq9ZlOAlMS52RWsyY63tvtTkoquijc6wW762u_4cp4A>
    <xmx:jZbKagAr4yOdSBuKxZ8edWGIsexj0fEvxYUXipShdHyt0idTTwGkRA>
    <xmx:jZbKai8WyB9d03bD3JijSsuI_bMTOFV7RBnGpE-8gbCfgty8IxJvvg>
    <xmx:jZbKapDvMVY4HrsLGCiUDtTNHmOaRN6-N-ZNpR9dlc2QqMKzV5Knyw>
    <xmx:jpbKauew5nhyOsnavNOIn9pdNfOHnqPPDvisgAizHdXOE0xuGqRdFyiB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 15:48:28 -0400 (EDT)
Date: Sat, 10 Oct 2026 13:48:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: <jgg@nvidia.com>, <dakr@kernel.org>, <acourbot@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v3 0/1] vfio/pci: Give drivers control of PCI
 driver_data
Message-ID: <20261010134826.55364f0f@shazbot.org>
In-Reply-To: <20261005184236.1946167-1-xinmengs@nvidia.com>
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 11:42:35 -0700
Simon Song <xinmengs@nvidia.com> wrote:

> Hi all,
> 
> This patch lets VFIO PCI variant drivers store their private structures
> in PCI driver_data, removing the requirement that it point directly to
> struct vfio_pci_core_device. This also accommodates the typed driver data
> used by the Rust PCI infrastructure, as discussed for the proposed Rust
> NVIDIA vGPU VFIO driver [1].
> 
> Runtime PM and AER helpers receive an explicit vfio_pci_core_device
> pointer. VFIO_PCI_CORE_DEFINE_CALLBACKS() generates per-driver wrappers
> that retrieve the driver's private data and pass its embedded core device
> to these helpers. Each driver installs its own PM ops table.
> 
> VGA initialization selects the decode callback in vfio_pci_vga_init()
> based on vfio_vga_disabled(vdev). Both callbacks use pci_dev directly and
> do not depend on driver_data.
> 
> Changes since v2 [2]:
> - Drop the unused pci_channel_state_t argument from the core AER helper
>   and its callers, preserving the PCI callback signature (Danilo).
> - Wrap each driver's PM ops pointer with pm_ptr() so unused tables can
>   be removed when CONFIG_PM=n (Sashiko).
> 
> Changes since v1:
> - Extend VFIO_PCI_CORE_DEFINE_CALLBACKS() to accept the driver's private
>   structure type and the member containing vfio_pci_core_device.
> - Store each variant driver's private structure in PCI driver_data.
> - Select the VGA decode callback in the core and retain the one-argument
>   vfio_pci_core_register_device() interface.
> 
> [1] https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> [2] https://lore.kernel.org/r/20260930143641.4160785-1-xinmengs@nvidia.com/
> 
> Thanks,
> Simon
> 
> Simon Song (1):
>   vfio/pci: Remove the core dependency on driver data
> 
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++----
>  drivers/vfio/pci/ism/main.c                   | 19 +++---
>  drivers/vfio/pci/mlx5/main.c                  | 13 ++--
>  drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
>  drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
>  drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
>  drivers/vfio/pci/qat/main.c                   | 12 ++--
>  drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
>  drivers/vfio/pci/vfio_pci_core.c              | 61 +++++++------------
>  drivers/vfio/pci/virtio/main.c                |  8 ++-
>  drivers/vfio/pci/xe/main.c                    |  8 ++-
>  include/linux/vfio_pci_core.h                 | 41 ++++++++++++-
>  12 files changed, 159 insertions(+), 95 deletions(-)
> 

I pulled in Dave's topic/pci-vgaarb-rework-2026-10-01, which gives us
93d41424caf7.  The vfio_pci_core_device is now registered with the vga
client so we no longer need to derive anything from the pci_dev.  This
makes all the VGA changes here unnecessary.

Applied to vfio next branch for v7.4 with the VGA chunks (shown in
the discussion thread) and commit log paragraph describing them dropped.
Thanks,

Alex
