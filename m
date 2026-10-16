Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0984E66C9
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169469; cv=none; b=oA1uv1pSqyWxJrHGYK8BaWCAICOPGo36X4WhRCxfHIgVczSo13kJQhvVEjNp+UG7KQqzJPj74F4ONAU/U4J8rRg8nmbmrXGidm/WZb3IALmjjkzEMyzndD5MTRZRYpGOtvROP2odB/DFp/HV2E9vOSSZxWhVRwD/K7spzQmAioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169469; c=relaxed/simple;
	bh=1qYWCAKTkhmKcOwT31wEJeKAJhbyN0fE6ogE2fCnyyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7003ULB3a1VKN5MOTavRR+ZW9P6jMxGRwir4QUQ7A9LpJb+5ih5YHqWTOtlMXj4IBplFvnwE+m9w1wCJRaf9J4pjhoOfVhLyQOGINf1DZb7mT0t6CsPu/g9VaXpPEli516SHxY1VyG2xfRagC+QD7HcBaOTVtYnq3SnD4P1wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NmltWcTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlL1mJXF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NmltWcTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlL1mJXF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 161187A00F9
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:51:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 16 Oct 2026 12:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792169464;
	 x=1792255864; bh=Ra1TtkI4ooI5DONSEwts9vxaOUDseQDBqDPzSb+JDls=; b=
	NmltWcTyz26kCRY3Q2UDN+Tu2nFMJf2mtTQ7KKbYAnsMAomue6fYHlg6HdkHkv3J
	aiCTtabcMUtAwujTL84C95PIu9va8x/wFYEdJhVH2JhF22GLUqKozke1llm9MD7B
	niWDO0C3FOTl9FZ5T5EHqttjLriRSHsBxevqAS7jEsrj4eNn+AqIp8gAQ4frOYpV
	dgwDZLf4N+PE+66JGejJYTYy8w+htM95hcsHPdqAsNz1P28jtX/OSemkUHw0vINE
	afb0mdAJI/cxy6ob1+Jpq4zMeVGhNqAoFcA+NOz/OpdFrdFVk3WVSfAzZt+gSAB0
	ncgBf4/HEr5mzxDgGyNzpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792169464; x=
	1792255864; bh=Ra1TtkI4ooI5DONSEwts9vxaOUDseQDBqDPzSb+JDls=; b=q
	lL1mJXFfZcsO572+lyKZRvBxS472YmQZgw7VswkPhdo5+pzD1/Y75WnbuvAumd6M
	HFlCQwBw1MqYwC/fHDp40/ADEdSFr3ViBYiwJbuGmtlBXGax2gvkKtSPpTJm4GK7
	jEnAEpDaOUK/kAqEk0iFNDWRsOD+aeyxjr+B34FFeFQpn20a5IywtaEpURC9YUw5
	Rf4v8CeFbN81uHcZOFzwF4z4e0Yy7cFW6OiVwQ3mj0jz/Mtsm/LZiWtWNsfFn0u1
	Cu8TIyL+wQXf6JFDzjBEKsS9MKsPpupuTroWhMYXQDMGXOFCfmMJUgPj/BitofAy
	geQtlyXD8J5SZzSTYoiWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792169464; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:s+UGl8p9aR9tlO4dPx8ApXhGmaq9senvoLjuEu11MLwwEqn
	m7mhBPhJXBMyMMg8j2lAlGnyQ7XTrPyKaAL7N83FItkIeW/yzTQiSUtlFVVE5l4K
	Ht0bLw+uz2XM3KWHiQSvDSXdgGigWiMdGaE4AVD+jjq/uW4OIHSDqM7fuh4YL/Uj
	aWXHacCJw2HX3PuyKQbJsT5M4JdQ3MCjugYx089wNZ2j2ICRegra4aQpTxVq7VJy
	31RqZECb7o2C2+YLhA7nuoU35v7ZdAP6YWhPNb00gaMGs5M5/2oGlN5voJuxo+jI
	7kSbuzI2Ve3kKkD5pdgLb51ggtbfhLhgtJbuiIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SzDpePWH6uPmF+REI6xlkInAQKnZPagQrDhOOc7MqcA=:1qYWCAKTkhmKcOwT31wEJeKAJhbyN0fE6ogE2fCnyyM=;
X-ME-Sender: <xms:-FXSantN3UdZpwW0kh0gnI7svsQARFnmA0qzfyIi9TAdI3ZeSdZwBQ>
    <xme:-FXSariAr7ShND5JoLFHvTgcNUcTsvaRZ1cDoOoZm_-nA0RcDnn9H2SK_5chgSoUJ
    HNa2kibPd29KG6CIPgpsOkIUxrd32z5xYu2MbulAGCEufyXjTjKdpY>
X-ME-Received: <xmr:-FXSalb2HDLxMHxuRCzeI_q6HJ3JVxwKT5cOIXq3-3du8hTSG1iPcOfz9QzomQ>
X-ME-Proxy-Cause: dmFkZTGfp9DYtFpIWflhSEcKnl9D+LKiGYgtMQnr4eHzyx6i8eXv0cf/RffRQh/9m0XbT+
    k2UQ+2zo03iz3nqmutVkT19I4vAnjlE6iP0cIiP/pAhpGBUTc87JVmh8qrA5wFPzy+b0I4
    GxlK/Y0dEcXO0icPjN22dmf8Zjif/JDvYdahTCzJMi2szyNVbF8DlMqbPIcTyolGp559Cr
    ujnYbmAEozlQWFmEIFFwVNXuyelM6coyaKqpae/tVCihHZhYUDLv1mJBsCVNCrFF41703+
    z+7ouRtMIBHQFhd5VT55hc0w3M5pDW7ysiuRXix0sBgUtsDZW0afUIGRMw5qZz9r/klnPk
    jfgilf8HrzUKllfyOO0uMr91YVrrZHXFC8OzP/HtyszWRd4bTOQx7bV438LDkImq7LqsPz
    Qov0VDerzsFnw4zWY6PVegWvhl60i6aJIuVJ6Fy0r2ItjTDOpHHeQmGvP9+tzDHq7EHiDf
    LonMNpQWHdd79GjtTFp8jVymbb6nVBPJ6FuAxkfcFOFewcPNaFUzEDuKTKs5/Z8Y5vNza7
    7nAO5GW74Mvlb1xeUEmXBFPldYlfS63C7P67ui1N0AjAicdviRLQjUlxyNwjMr9AfjqMZZ
    1NNAVD06icpAcL+LT1bbeCHtx8gxuE/hkR7KjoUu32Bu2JzOTvZzI72vHIBw
X-ME-Proxy: <xmx:-FXSaiae8N_3vAreFYX5PhPjk5qY1pRtJEmUSCEv44YQpdqns_HVuw>
    <xmx:-FXSaizjUdpxFFVRUSX8MF2lDQANwtF4zRoT3WFbvGrOtwQVRak0LA>
    <xmx:-FXSamdS-d0BMzvMwVSXbHDHO9nB7E2WsO4vAQOCsbo28sArOq0b3Q>
    <xmx:-FXSav5hn1U18-ivMLSlW81nAjTIL6HnRadwAe8OJVpjbBN7UNUHWQ>
    <xmx:-FXSambvb2zZlT7Qc2STZw0uGDBc8SRwVZulxI7fpFqj6QQZF0eE34RC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 12:51:03 -0400 (EDT)
Date: Fri, 16 Oct 2026 10:51:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Jiaqi Yan
 <jiaqiyan@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH v2 0/2] vfio/nvgrace-gpu: Separate the fallback-mode
 open_device
Message-ID: <20261016105102.32b769fa@shazbot.org>
In-Reply-To: <20261015081937.405320-1-parri.andrea@gmail.com>
References: <20261015081937.405320-1-parri.andrea@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 10:19:33 +0200
Andrea Parri <parri.andrea@gmail.com> wrote:

> In fallback mode, where the ACPI memory properties are missing or the
> C2C link is down, nvgrace-gpu opens a device through
> nvgrace_gpu_open_device() but closes it through
> vfio_pci_core_close_device().  The open registers an empty usemem range
> for poison handling that nothing unregisters, so a second open fails
> with -EBUSY, and the first open after an unbind hits a KASAN
> slab-use-after-free in register_pfn_address_space().
> 
> Patch 1 gives the fallback table its own open_device, as Alex suggested
> on v1, and is marked for stable.  Patch 2 drops a usemem length check
> in nvgrace_gpu_open_device() that only existed for fallback mode.
> 
> Tested on x86-64 under virtme-ng with KASAN, not on Grace hardware.  A
> QEMU cxl-type3 function, bound through driver_override, takes the
> fallback path and is opened through a noiommu VFIO cdev.  On v7.3-rc7
> the second open fails with -EBUSY and the open after unbind and rebind
> reports the use-after-free.  With patch 1, and with the whole series,
> neither happens.  Patch 2 only affects full mode, which this setup
> cannot reach.
> 
> Changes in v2:
> - Replace the usemem.memlength guards with a core-only open_device for
>   the fallback table (Alex)
> - Add patch 2
> - Fallback open no longer fails when BAR0 cannot be mapped; Ankit
>   confirmed fallback mode does not need that check
> - Rebase on v7.3-rc7
> 
> v1: https://lore.kernel.org/r/20260925161024.189771-1-parri.andrea@gmail.com/
> 
> Andrea Parri (2):
>   vfio/nvgrace-gpu: Use a core-only open_device in fallback mode
>   vfio/nvgrace-gpu: Drop the usemem length check in open_device
> 
>  drivers/vfio/pci/nvgrace-gpu/main.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

Applied to vfio next branch for v7.4.  Thanks,

Alex
