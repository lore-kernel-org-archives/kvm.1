Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3D58E2AB
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095988; cv=none; b=Zz/bdLvwtKvNytKU2eYKKhaeuXfmdJ7wwBT6ncn0axeIVLuq42SjoMZT3ncv6T0+nGPS6sc3yPWZh265fh2prJn5iYQz6X5aYxc4UgJDl5w/eNR0wbulsnrREBmJ3T+aZVqBmIqavMLYXrasfnIpqTI+cIQD2KpSc8ynEvTqHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095988; c=relaxed/simple;
	bh=RK3p64IGuUAJAuKgURL86bpwC4ssg7kppUfonsxqU8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYytoXvModBMlKcam+zVB1kJEgbI2nZdkLMoUNx4W/EJr2xneTF72lr+oPSNvTz79NmQrLRQzsar40JJyWApiqJxQOSDXJ+n/iMivhOga+dtA1GWZaKDk1JvN8NIvb1SBQMbJox+tDhGECbG3OkFKCzkNyzH7ajTYEjZOfPYnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=OZUBwpsv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xM5CzMWY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="OZUBwpsv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xM5CzMWY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E69D21D000B7
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:26:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 16:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792095983;
	 x=1792182383; bh=fV4zq6O4D2UttGCKClLitDfEj8wQyqd/AGMA2e4kXg4=; b=
	OZUBwpsvIqNzW4hteYCPIi9hALC2G8O8atEJcdxpqhiDmCMs9YPRl04bJO+oG9rT
	UV9PT0GtYFlHUpvI+ze+wZnoc+VfJnPTv9wuvrrU1hIs8gjJ5zcqxD+OUd0RHFjp
	fVTJWw1aujqeQmgTGZTs7rL2DaWi2gGbvpgAvdGBylh0+ijF59CSwRcrAG01Biyv
	Trq8O5M5ujjzF4MbmbS3hk7WNAxIp4RsyIF83vSU1VK6X3UBih/IB3lqd/IdPvF+
	xTf9qlEZHVWm1zDo9c4dYKgHGRVbpJQXK/g63xzZ+HJqo5fwQY9ECerSn7o5uDOL
	Y1kLJ2zA5rQoQtSpquAHew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792095983; x=
	1792182383; bh=fV4zq6O4D2UttGCKClLitDfEj8wQyqd/AGMA2e4kXg4=; b=x
	M5CzMWYCkZcbIj7AyPDAoeWscSVCudjWQ0/lq3jsKf2IuQc+/2tKjL9iZComA68C
	5Pc+XewGr5IKGHwVAqKzNCZ6K8z7oceJPOyamGV07sw2/zKno2rqUYmNyQ2oxSsV
	jmZeY52zho2iCV/hxGeoI63jZVYug52eyYJPKA6b26KElRjsOkC9jgNYJFaM1vUm
	czikY/6IMKa5kBbE9eIdG6lDhhQeLz8OjH9lL770AEOmEGvwOjmYMgg4xCiMxSLs
	mQHT7dLin9GlTCZLcNK7aqQ0Gjvp/nk51UrIu2pU6Cyr9oL/uc5Qw0m4ikAlm1Pk
	fL3wTSOZn/1godjz8/NEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792095983; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Qu3o87wXjq+7pwIsrq3pqNQreK9XUMTplKFnyJrZz4Dd3Xg
	bgg6PweMGm5WSCTi+6faisqEFhRcgdTmx9GyAW1MnzSuUxUIiE6enkaXEoj5eUYk
	xoOCCvVHLRDvPNknGgNCjRfgjfx7RG/QL7j0I0/Ko5oYbBERT4NQ8HpB7z1XyBqe
	d89XNn5mSBDBV2VlQOVZb6QNr2EVYYEaQtCsA4w5euRCtYsVMwdXM4X4pHyzeJok
	ctTgRcUAxlGgz8PoquaosGPaVu1W9XlP5QD7icjxdnRpGQzUh0iG6Qk7GS/HGH4Y
	gIyxFag4ms6qNreXzLeUCyyoZt1v7UP5WQJgETA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yJFthmLStpgch4ztfhbjKy7H7Q4qcArqcdmD1OINXyA=:RK3p64IGuUAJAuKgURL86bpwC4ssg7kppUfonsxqU8k=;
X-ME-Sender: <xms:7zbRalRiq247MdH09IxlvCMPJARs914vtsajgAjj1zJ-_bDV6DZ3Uw>
    <xme:7zbRah1XNccUk87PfSPcgEzBqHRYqmnxzhu4-Ip_Gs4vtp7oBhfVqfbMG5eglhF6h
    CkxXnhc-vDzdJc8UoMT3ylWwE-JLtACcTQSlhLwYDVcfC4iJyeolN4>
X-ME-Received: <xmr:7zbRalf9046Hvd6oYJ4Now4m7OVMmyACOYKSlVPtPsVX_lweqKz4vSASKvm5pw>
X-ME-Proxy-Cause: dmFkZTGSBh+u/WB0I4vBywTDuV3rilsEfn4/VUrR9TO/n5FHfxHX1eiIRdgJYx+TiNz3PS
    JX8XD5roOkVedVYp58M+UD2mAhXa+qUz4MeOoZFhQXP8QmbVYR3T//Xcz/VDSZ+Zfr+Gc0
    xMx1RxiPqgUiDuh2HyM7o3/HHkZFsKaz5XhUv/gPHVCECcj0rytjI0YYOTV43Gd3wwxZTM
    7S5F/kYnE7vdbTCxd+rWmVxsqrRtOdctGXmL1n90/oTlCuNcQ4eAut5IAgWLOh0Tv9G648
    s19oLIb62Q3V2/dMHsf6oHupJG+heroZT3VuptRXBN/f24ftR2ZzU+SRqwlDlH63nHeqk8
    9AkVtmxAEHQgI2jZq0uSuCWZrZ6JhsiBGFjFpX66uRR4nlDw+A9XXS8/ztoBtUEH9cWbc8
    gUirTLGysNCMRQIG8rCUczC0mcnaXiIHNHqQg01OA9JMI9GAC0U1+aSUm5iyShR06xTR3u
    Aov9+VN+RfAK90+X0YUUmX1wPDFZ0Cli+TSL4GapIrDa6DOYsIoEyb+/v7P/52NAjYc7lB
    whufdysZULmYjtWB+vr44O73H/rh95K8vvjuhZ0SjL8hKO4bhedh+p5UiftqOyMa+d+oGB
    auloUvSPjedpRWhOwFV5i4cCTJxxmubwwIciU6+u2y1MtXhg0j08oScvAiww
X-ME-Proxy: <xmx:7zbRapN_FR1H_ikTfsODzbNUuVhOBhnsIMZHz9Kq4qMNti4-eeAKcA>
    <xmx:7zbRapXMCVxrFZC-Y0JANXW-664G8TyJpRwl5920oa3kEt3BsgkxsA>
    <xmx:7zbRahwKyI-0HhnMkJ7FBJVPcvFb5z2S9bpltuGNS8G6y5p0ZBBalA>
    <xmx:7zbRag84jBTClOrUfDTD9vxz0zfF8YmyLedReBnxMs7nOUMVl5NjSw>
    <xmx:7zbRar9mlqwmgvWRp6lO3J-C-eMRmZH5jjG0pR9bC-R2fPtCO-p5yXB->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:26:22 -0400 (EDT)
Date: Thu, 15 Oct 2026 14:26:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Jiaqi Yan
 <jiaqiyan@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH v2 0/2] vfio/nvgrace-gpu: Separate the fallback-mode
 open_device
Message-ID: <20261015142621.28afb9e5@shazbot.org>
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

LGTM.  Ankit?  Thanks,

Alex
