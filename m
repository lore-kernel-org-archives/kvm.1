Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E5503BE0
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863953; cv=none; b=jsNro2x10Vyr0L8yH1s07TFjlQ4qPKINqr0qQLNqhP3h73rZtk/ACpcQmenZPmVq2VhFvQkgNPJV8Iytemmubh8PQwqeglVDsSQOG5tYOQGWunDQoBENSoMRZB55B08sWMqKvYsbUl05hq9L6wLVGnOx7KlwoVA3t57J6CMaA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863953; c=relaxed/simple;
	bh=qHqfBgsCEeljf9vm8b9twmiuzTdhNXvKeLcCrcBZevE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6yyqmzrGW2GgTulT3WthTDsG+8B3G8gtgeHTzbB7JIRHUStH+ORZFON6EiIUv8Xg2S8CDxHARIRHz0Qda8SiXUg+7+v/qgCUmpR0ZdEDF7F1Hz9mTammbOTO7k44xZ/Qb8hjJR3sqVrWqmeK9KtpnvqgkZ+/oGwuUXplf3ixv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HIp0zGsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhOMb4hv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HIp0zGsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhOMb4hv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C140EC016F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 10:12:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 10:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790863950;
	 x=1790950350; bh=ATj4hW1x9LFmtPl4Wl9BUty+fvJ2OV+MQvDPOpVWCE8=; b=
	HIp0zGsF7637I8t2gHWJ9NXMbg+IxRyQUoXKcE1F+33tiFkNfe9tCTcmvJxQChUw
	sZrLTQmJPWOVKx7iVub5dOXGKG/IPP/xeRpcTQ1whVln9R6IpHy6lk17BReBjn7O
	fW5yQCAU34sj7JQA1w1JLKAOqpO99GDhuPD5j363NOUn4GGmkifSO5wo0hL6aNZv
	v7VU4e8a2YkGdUCL3eSqxgt4hAaMI3d0Gl2XqnTawWgjOKg20fwNSOfrHDV0arZP
	Rqzarp3+MRBIz+aLp09UWOMkmorfz41yHwbJ6DCtgocSQy3tRUA8VDhwP6Sp2rrk
	Ri/Ulm3wvpuy5SX2IYz7lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790863950; x=
	1790950350; bh=ATj4hW1x9LFmtPl4Wl9BUty+fvJ2OV+MQvDPOpVWCE8=; b=Z
	hOMb4hvzuky3mGV1EPEZiSKsDlmqI3J/eLh5jlDBSmitAG4dm49YhUqOhPPN4L0R
	ry2Zyzj8Q1KvWUoXsvbHoe9Z2/j2g3KueNagxDbLEZ0MqsPZW0BuEAfdM/JdqCCz
	vkPu9phf4VhF89mFkjj4bb58EMKLRqNICMz1HRRxI8UPar33oBIwD02RbAj4W+mJ
	x5yXHB8E47jB/EI96lBfMf32q4fh+LnO3J0phm6ffuQaiWUAk4EKksCVHHRWu2Cc
	5i/z8DyXbT6OwmS7JfF6X7aeeJe7Gf3m1bRDTI6xUdPMM4YwG2ixxsWmf1b9KveJ
	7JKHFx4/CULLHfrlRF5Ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790863950; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:U0l2RKpGtbY3zCCvZB2dsziH63e6vkDieWLJZMpf9nNajV0
	nqhtLsC9uA/huvArrj8ULyiaUBfvy6y5vT6CeKUQ8sVl5rLfIjwMPOnCJiaHmeMl
	0eA32xlYgdx71CuPfam9CZhQu0IodwdFzCkruxWjxNG1y1Q1Jwvh8+uLPaVggxhr
	qY+7wyyXjR5MlugzPivj5dHfdCLBfnxNuPV15B8NGz/aVUnt378frm6DA9P6mP5i
	cEwtDIu7ak70jMvIt0pQ60wYzoOWsX6dVTJXOvXxnupIiIBre+Qw069BIPoR3Jon
	NJjyKoFrDOtiPGJBzvl+D4BFIkX2zyFScKk6N2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OSrEUGyBkg0M+a65O7qJz0QrO5DVNjdK6k5ba6ssCOs=:qHqfBgsCEeljf9vm8b9twmiuzTdhNXvKeLcCrcBZevE=;
X-ME-Sender: <xms:TWq-akJ349tD8isl3-KCFtctc5uqNpw8lbKmqEx6Smb6dNAlHN4EWA>
    <xme:TWq-ah8h9wLRf2x_ieEtZycurmmlRg5hzZnwK4Qh4oIfb3q_mAfaK-4y-Gn5oyE8X
    tmVjgt7T7jcliFDVaSWZaW9UnpVQtzXdgFmc7OBWqjF1AZaPpYnQDE>
X-ME-Received: <xmr:TWq-avIp0GLeV9_ihg7nQyVDPxcQARnRXsOki4-X0i-Zjs0XajkNYeg7hArV5A>
X-ME-Proxy-Cause: dmFkZTENZzRQMMP6NTk/k0Uhoq2oYvTQbTJ2Mi9/DHCC3vPgyVfx4igkBQlVMs5u7PK7Jo
    S1ok/VqC/2bkgbRqw6H34gXKZm/tnDcbE1glwwdjjwZsneRo6g5xRv6u4BiaNTLYcNDe/g
    YFmxK0NVoF5M3X33w/TulcQ0kBXp5ABbC40a2C9ofScystrHoXtQ2VZc65RnmEkr9tl2aX
    QKPpfC6NWNPi24+mKkNukrrPozXi+YQlp0JGtMmbNaPx7t4aVQaG4PMiqQKZcbK6Jgu7S4
    En/KzlBBF7XhI+nF5zjryWliB41Sc00wN4YEqubseBwZKMVwT1v5EWwOXlEu02J9yDn5Em
    RSqzTI1bU4iTPdxoqouF/48HDGCwNGWV75sMLMfj2S8Qk+NdvuQHI/nJrph++AP3a76k5R
    XdOLNLorqRqmRjlznXfr27JgosgAkEiRwlw1ne0c+DVl32HNXZ0Ion58nyHaTZu2HvD7MQ
    FnXee/AlTuwqk0GhbuqC+vmJ+KBkP7oCbTXvsnc1rnN5jYGkD5xlLIoco6TFZfFdyCLmip
    pGUcOsmuzuRpDtSCiV2eNDW34ROuWlXNoAqiaaw0ENpj05pH+t0wWNGL5WaZaCe/jPH0Up
    Re5HNAlKIU3vCOurJyIoVPMtx3VbZwH2G6hFP2V33iZfG8yRjBnbsN7z66Ig
X-ME-Proxy: <xmx:TWq-aumV_-1K4OPfE-cIN0xWPXndCN5JFJhm-8r-JJpNFjMXAnkwPg>
    <xmx:TWq-arM9Ob-6M12l71jHDXjCz0mEiFpMRAcyYZnt84wFEPR9Cg3XAA>
    <xmx:TWq-as39_g7qAAHTb3OdQvdP0w6oW2DV7iSS2-Mqe8ZSyhz3HEgllA>
    <xmx:TWq-ainRptxxE-j48Jvzjx-XE37nsROuhXBz9Nr3l4nxGNIgLORYPg>
    <xmx:Tmq-ald2kls5rw2N8N__T59Gnt-q8ncWr1oDDshWHjznq2Mc5ePez2S->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 10:12:29 -0400 (EDT)
Date: Thu, 1 Oct 2026 08:12:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio: cdev: Reject duplicate bind before updating KVM
 file
Message-ID: <20261001081227.18eaba1e@shazbot.org>
In-Reply-To: <20261001093152.1698474-1-aneesh.kumar@kernel.org>
References: <20261001093152.1698474-1-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 15:01:52 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The cdev path only supports one bound/open device fd, but
> VFIO_DEVICE_BIND_IOMMUFD only checked the per-file access_granted flag
> before capturing the KVM file reference. A second fd for the same device
> could therefore replace device->kvm, fail later in vfio_df_open()
> because open_count is already nonzero, and then clear the active KVM
> association during error cleanup.
> 
> Reject the bind while holding dev_set->lock if the device is already
> open, matching the existing cdev single-open rule before touching the
> device-wide KVM state.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/vfio/device_cdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 1d9515c967b0..ab46563604ac 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -124,8 +124,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>  		return ret;
>  
>  	mutex_lock(&device->dev_set->lock);
> -	/* one device cannot be bound twice */
> -	if (df->access_granted) {
> +	/* The cdev path only supports one bound/open device fd. */
> +	if (df->access_granted || device->open_count) {
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}

This is already addressed by [1], committed as [2].

[1]https://lore.kernel.org/all/20260911170429.1642480-2-alex.williamson@nvidia.com/
[2]https://github.com/awilliam/linux-vfio/commit/258ba46543abdd36844f04bba8b4022a5731d873

Thanks,
Alex
