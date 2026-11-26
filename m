Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672196;
	b=Yrr4hY/OhK2FrvMS5ix2FnvXAkwB/rKTB+XlV5iXqJFmwIuBpLj62YcZH2YtnSvw5Hx3
	 eciPca5OyfUbAnBNrIRHntA9kacHlcDi5sp7RHoS/JLLWGACySLZqoG/55xBGXiQNRQcn
	 yBZ1vLZz1PQGn9gngqLkk3L8Yl5YeotxCH/B9bhipk8PWYAEWE+dGLdzc73+KtxT3Gvz7
	 uAj+JnDNg9CknR02mWHHr+8BpRMx0wBCVhF1BmlRk/JwGoWiMfyLcd4XhwlritT7W+vRw
	 Kr1rOfeS1keQQ/1RC8oC3ATQ5S8dZitjoOItemrE02GZ3GZlvjpDo0kG8XgiNgkrzJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672196;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q2kdFumMVq8xMsVV3mrjz27Z1RPydIx5XDUTo0Nb7QY=;
	b=tb0qKKXAhLe+7gjavA8pm/R94b+xN0tG3WY3KnwoSYT/FnguIY5R7GAcdSoAx4JTqTNy
	 rRm5kdkrROaKUuPyXAZNCokaN8Jtu7lgjMf5aeWdvsIrEd8GCBPWS4LKdcezIo1UF+0n0
	 W98mbKtfCL7NICBdYFVEXeKLJM3N+2PCKSujV7/vZU9anCM+QjZ3s7QWRdl7udZ1aryX/
	 FeDfgwlBFzCF5r0rZPXGU6/Htiqb21nfFD2McDB8JRmohVJhIdm7ZKHxZpcwQOyAR9Kkh
	 6rRNf4oqlOup7rMJ8/T3JbcBlnEo1PskDzLMnv/+5qs3ltb4c8V+od8zzvLuMXLt4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=J1bLodVR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TsdoOCar;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF4606A690
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BF4606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=J1bLodVR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TsdoOCar
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AA407A05AD
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:49:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 00:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795672194;
	 x=1795758594; bh=Q2kdFumMVq8xMsVV3mrjz27Z1RPydIx5XDUTo0Nb7QY=; b=
	J1bLodVRFJQkkZ7dLAVyfTQoKU/HstVzGz6ZwxHTlsZxAKvviwRcyePC/VJXmyt9
	eczA2eR401KJJrYKNa0bE6PLBVBinK1KccVhrNfQVjXQa+Ajh3KXeptU1Ht4m9Ad
	HKUmoGM0TwOV3PfSaiy6BSmLuYscqu2Rhfq2dox2yUk2tzrhUoIvpYmuBufDC+pM
	ALwmi6WJSnxPiZ0W8VDhCUTg4G5fevZf6b8fHMdliIKUWGLz9nZmPpnlSdtllb9k
	UxTvqW5hOLocz5a/3GIlU0aA2pzeQEtXOWlP61NxZT64elAquxk7K55ohMjT+muT
	Ostu3nGhxl6fA+FIOkk0Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795672194; x=
	1795758594; bh=Q2kdFumMVq8xMsVV3mrjz27Z1RPydIx5XDUTo0Nb7QY=; b=T
	sdoOCar2rg0JHoglYzSn4Yefuv/R9k6fBBdjV3TuCp3J3vzbjY0s1y+wVYCRr8YX
	oCnSekjKHQFBbly1CDrPSLSn1hMNlgI+azXQHkJn9/Kfv2LQpGH3W/jYXzp8PKMx
	4OH/7VWLoQk6rUSXg7FHk4fhXDr+BN8MjcvtWrv5eysRwTWMdo0UIp8HRR1qc8HA
	DRd0RhE7ljQNjzZRhmEaybNjp0MhFExho13bZkbVDOnOi12iwImF3UrtNkG8G9lF
	4d2sC7wN542ST5uRDyr6IUTLG9dNytCor+NrtRqmiewCcyPpBDYO97goMAgB8CNz
	oIgqFaPnCHlfhflpbgGnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795672194; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BYSUw9rhly4aQdgGsMozHYQpy3QBZB1gExgtnxQnSaO0YPg
	IyDEFV2EkJM9+f25kk1evAH3Wrc46uBOi+1+o9CDTRW9mRvOjYYrrG/60hw54dPS
	29+cecFXArcBexwza2CKlQtSMQj6xcy+KcI9Ziv5Z7TkKMv9Mk0pQqfUNbwA4O9E
	wSnSYXKP/DPkzWvAgpaAMobagoB4zahFHXwzLI8MC9J9xhTYT/JGNERblqeFIVbL
	XydNhOTano1aF/mEfKT4tazIZPuqqo4eaJhzi7GRP5dBQWi05GaM8xSMQfbuA5z0
	ubMiY9aTu2HWJS9DU4xK1xfcqB3pPvxZvZKnjyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Du32KypJBxAkS5OL8tLbUbpIZDT5mgILOOehCkAaWzo=:cZzUQw83C7+I+jnVAy6ulst7k89XEVn4Ov90I/5HoDU=;
X-ME-Sender: <xms:gsgHa0mhXO5DZRlJvGuL4lM_sDORNbKbGucPbhyN700IdWL1kENGTQ>
    <xme:gsgHa2FGcrLk3w0zNSMY3DPANfiGM-vIv7_Nx6MOG64uGsqfvVixL9p79oYfekFLp
    Yb__CpYRpw4GhwG2DyK00u_7BUsc55u2Qg5_H142gDVx8nfqZuaz1Pw>
X-ME-Received: <xmr:gsgHa075kpBFc3mkpnxIKbVdPEWga5epYTeMM6-iSq5OwCdrV2iCuPaHjqAgyg>
X-ME-Proxy-Cause: dmFkZTFjRUrUd/pHfat0j/A+uC2EiVxgD5RVtO9ZoeaHU2vPYRO/KOQYpkcUTu5qHBWnVn
    IybgOWETHWv4/qQiqBi/dkh+0bx+Sod5mQZtb/r00rASQ5pCbvb1cX2ih73JneQzwRfVSO
    KcQkUDKOCPAW80RklWRvbqMh4fenKVGswqof6weRxfRTYUtF97xZ+aB7p/+wAC9PF8htEC
    f1R0GHcfmURNOPER3+tslQ6Q8iaTs3+mnMDGzdN7C2RlEIsfzlga+jHvNfsQk6HV6NRAam
    AD/Rcl/lWlj3fVRI/RF9Ew7k6lp3sGcDZlcCL/yt2t4OilwO3A8mkrv0ugZbFoAFrdOoZ0
    j+sX4lRCuIA1dXPZl66DeRnGyTg+XekYumW/fZ+OdxSqJvvL43yEmzY8X66HIztTI9/JBJ
    OK2LaSsQW2HwPvkltFrZOgBVHDjk+78Vfje69JCd4WaGAIcbkCWuwDZ2plKj7aYChWFWpM
    Wb9VxsxWtpA+Sk3c+uOpeRf9uDkEM6rJfLiZDkj1EIM8/GKVpTLmn9NNlUdw08DPPqxSSG
    ST1Ntu76hCcL9TH2FRxrhMXNA9esTyQugYyfr1oda39I076DOzX0GlbfZWzfTwlylLyJRP
    AEqvtmClS6OYwNlNSXj46nkpUhTokCJ8nQ8qXpbP47wbkgYkt7n95jhhrV5w
X-ME-Proxy: <xmx:gsgHa2moJ6FxC82CLtgQ97yYra17ojHr4kdxzW3G6sSv5sk5cA_7hg>
    <xmx:gsgHaxrfsdVnSTy3xzYw-38z5kgc1cWlZcua1p9kHDKg3g9YKKg0Ag>
    <xmx:gsgHa9u5clVAAaW3Vk8oguiy05_kDReR12aAvBxtw755xRc3FmibjQ>
    <xmx:gsgHa-E_kihCUlh9bd1G7EGwUOrsAS-YGxArh0YPsIQJd6dF6GULDA>
    <xmx:gsgHa6mBDrsD5NFK1Wcc_4rc1LfoORmSKwEGSThyDrbNwwSEPXYlZCmL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:49:53 -0500 (EST)
Date: Wed, 25 Nov 2026 22:49:28 -0700
From: Alex Williamson <alex@shazbot.org>
To: Qican Ma <goonsomeway@gmail.com>
Cc: yishaih@nvidia.com, jgg@ziepe.ca, skolothumtho@nvidia.com,
 kevin.tian@intel.com, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3] vfio/mlx5: Read the resume buffer pointers under
 migf->lock
Message-ID: <20261125224928.26a961e3@shazbot.org>
In-Reply-To: <179551955962.71139.3396358892015584482@gmail.com>
References: <179551955962.71139.3396358892015584482@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 19:25:59 +0800
Qican Ma <goonsomeway@gmail.com> wrote:

> mlx5vf_resume_write() reads migf->buf[0] and migf->buf_header[0]
> before taking migf->lock. The migration file is opened with
> stream_open(), so concurrent writes are not serialized by f_pos_lock.
> A racing writer may free and reallocate these buffers in PREP_IMAGE or
> PREP_HEADER_DATA, leaving the other writer with a freed pointer.
> 
> Read the buffer pointers under migf->lock, after the
> MLX5_MIGF_STATE_ERROR check.
> 
> While at it, move the f_pos check under the lock as well, as f_pos is
> protected by it. This is not a functional change, as f_pos is never
> negative and can't get close to an overflow.
> 
> Found with an LLM-assisted code review tool and verified by inspection on
> v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of mlx5 VF
> live-migration hardware.
> 
> Fixes: 34e2f27143d1 ("vfio/mlx5: Introduce multiple loads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qican Ma <goonsomeway@gmail.com>
> ---
> v3: correct Fixes: tag to 34e2f27143d1 and rework the commit message per
>     Yishai's review; no code changes.
> v2: resend via direct SMTP without line-wrapping corruption in the diff.
> 
>  drivers/vfio/pci/mlx5/main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index 18a6d224b1f..ebcc22bcb75 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -884,8 +884,8 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>  				   size_t len, loff_t *pos)
>  {
>  	struct mlx5_vf_migration_file *migf = filp->private_data;
> -	struct mlx5_vhca_data_buffer *vhca_buf = migf->buf[0];
> -	struct mlx5_vhca_data_buffer *vhca_buf_header = migf->buf_header[0];
> +	struct mlx5_vhca_data_buffer *vhca_buf;
> +	struct mlx5_vhca_data_buffer *vhca_buf_header;
>  	loff_t requested_length;
>  	bool has_work = false;
>  	ssize_t done = 0;
> @@ -895,10 +895,6 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>  		return -ESPIPE;
>  	pos = &filp->f_pos;
>  
> -	if (*pos < 0 ||
> -	    check_add_overflow((loff_t)len, *pos, &requested_length))
> -		return -EINVAL;
> -
>  	mutex_lock(&migf->mvdev->state_mutex);
>  	mutex_lock(&migf->lock);
>  	if (migf->state == MLX5_MIGF_STATE_ERROR) {
> @@ -906,6 +902,15 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>  		goto out_unlock;
>  	}
>  
> +	if (*pos < 0 ||
> +	    check_add_overflow((loff_t)len, *pos, &requested_length)) {
> +		done = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	vhca_buf = migf->buf[0];
> +	vhca_buf_header = migf->buf_header[0];
> +
>  	while (len || has_work) {
>  		has_work = false;
>  		switch (migf->load_state) {

Applied to vfio next branch for v7.5.  Thanks,

Alex
