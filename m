Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE7360ED6
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536642; cv=none; b=nUFrYwEacYmRD7PfoOr6O5Bu1kQ/vbgmBHqvlxQXzUy6vDJE0Nn1f1x3Gfa7pnh4UaQvy40qjW8wql27IRJ3K15p+DAy2WsZweWxq2tdSS3fLLINvZQYJufycjcged/9XXur6CjX5d6mhyQLajsi3f00a6ey5bTxcfrH/QmZl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536642; c=relaxed/simple;
	bh=yPAasUyJRo2QHNrAw0MbFXUq0FA4pynz1N1k9q9rhNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqlWE6ek/gVGopY0fpWQ39gTqxsbK3a90ntC/wtslXWXHOEJMupCxqesFS2sui07xRhEQ+ObGEHpEPzeVm21NheVjyXeI7dbJ4r4r7AdELoP4HzB7p1PR58ONto64cMncxINPcNRk0H4XDeOLFoslv+NiHhQCunsoWMD/Y8G9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdX8tk0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdX8tk0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC7D1F00AC4;
	Fri, 31 Jul 2026 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536640;
	bh=jA03Doh9TCXs+aTg7+Rre2d2PC1VSv2ljTW6qhfEpwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RdX8tk0VCX+RycXDvKn8BAr/fPiaxqTXNJmKvw8D9m6rPmUAo05NYbnA/4xmWEMPM
	 D0IGNrixMxBU3j6kKptXyfFRk0GrDqWWu9IqCh/C/eL4O1tt8Gw4Wa3c9zzrQPg38f
	 jByMgD0tj1YAGJJrVcaLcxR8mDpYYMhL+F+YLAjxOwj5A8ewCp9PtlyZ/zoY+kIqN4
	 J4c44OrfZemo5s6VOzeMy4ZdF9KkS+ESrGwW+wG2ldXJ9W9Os37SerjlOfWgIF4/QC
	 f/Y5iJ0mMgHhFbcbVBPFIRXgnHbs+FfkXAI07QXLU0LdVOc0VM9rwW2d6RqgIOaXZZ
	 LKY7KIjtssDbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vhost-scsi: use kvzalloc for vq array allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongli Zhang" <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731221116.236791-2-dongli.zhang@oracle.com>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:24:00 +0000
Message-Id: <20260731222400.8AC7D1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `max_io_vqs` module parameter is parsed as an unsigned integer=
 but assigned to a signed `int` in `vhost_scsi_open()`. Setting this parame=
ter to a large unsigned value (e.g., `4294967295`) results in a negative va=
lue (e.g., `-1`) that bypasses the maximum bound check. This leads to an un=
dersized allocation followed by statically indexed Out-Of-Bounds (OOB) writ=
es.
--

--- Patch [1]: [PATCH 1/2] vhost-scsi: use kvzalloc for vq array allocation=
 ---
commit 3573b684f78f79b1ae3460e4a7625cb917f76044
Author: Dongli Zhang <dongli.zhang@oracle.com>

vhost-scsi: use kvzalloc for vq array allocation

vhost_scsi_open() allocates one struct vhost_scsi_virtqueue for each
virtqueue. With large max_io_vqs values, this array can require a
high-order contiguous allocation and trigger a page allocator warning.
This patch replaces kmalloc_objs with kvzalloc_objs to avoid the
warning.

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c50..0c0634eea1443 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2295,7 +2295,7 @@ static int vhost_scsi_open(struct inode *inode, str=
uct file *f)
>  	if (!vs->old_inflight)
>  		goto err_inflight;
> =20
> -	vs->vqs =3D kmalloc_objs(*vs->vqs, nvqs, GFP_KERNEL | __GFP_ZERO);
> +	vs->vqs =3D kvzalloc_objs(*vs->vqs, nvqs);

[Severity: High]
This is a pre-existing issue, but could this allocation be undersized due to
an integer overflow in the nvqs calculation?

If a privileged user sets the max_io_vqs module parameter to a value that
overflows the signed integer nvqs (e.g., 4294967295), nvqs could become
negative (e.g., -1). Because it is signed, this bypasses the maximum bounds
check against VHOST_SCSI_MAX_IO_VQ.

When VHOST_SCSI_VQ_IO (2) is added, nvqs becomes 1. The allocation is then
sized for exactly 1 element:

    vs->vqs =3D kvzalloc_objs(*vs->vqs, nvqs);

However, the code later unconditionally writes to index 1 (VHOST_SCSI_VQ_EV=
T),
which would cause a heap out-of-bounds write:

    vqs[VHOST_SCSI_VQ_EVT] =3D &vs->vqs[VHOST_SCSI_VQ_EVT].vq;

Would it be safer to use an unsigned type for nvqs and related variables to
prevent this bounds check bypass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731221116.2367=
91-1-dongli.zhang@oracle.com?part=3D1
