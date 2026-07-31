Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4D449B11
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517722; cv=none; b=mZI/bssgrLZ1sVkDA+jo/Qqpdll2rK7NiK1xvOnVPknRRus0OJJ/uEGcIE4OyRvTnf4ZC8RCNPuWIn5zgBOhK+sj+dN22JFwPRxJnW1drYIaGRJ4v6Q454XTVg7/55gL2vU8oTIuaUEF7ALXTkHXrOmN/3zIZxec6NL+fvVsbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517722; c=relaxed/simple;
	bh=2TpKWBoTN/DrGsd5lycbOX0YAHForGoWbU2RUCRu6RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiYxeRaZda+99meEW35wzY28v/Q4JXaFx8nPbPqeMQdJ/8d0HwB6XB9zsgWFzml1dKervZ/mHPgcf2MScDjEnsNVgpWz+chs8wfr//bEYbuyMtCYz9AK5Ga5RpC5g+HgisKZBJbegwqdkYwrdF+esRMaC99V+CVwLXLmT/plHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUB0DzTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUB0DzTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C71F00AC4;
	Fri, 31 Jul 2026 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517720;
	bh=z+SmHUmNPTP4wE9HFsbKwlHHj5g5tELCiA7GWd+zXfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gUB0DzTURPDb2JHijMZDWk6eZTu0xS0ItH6TCLM5CpeCegNKcmNxCimFqxkK2kUbf
	 KAeWMWID6esublkNpg46LiaIPrr5sArC++SViaNwSDbhWLyEZpXGv7laozFuRpUwhw
	 2tFY3ALrWE8EU7hlZZsoNVBVVxaSge6xuBdBhpktqo9uf4gslTQT72kYt2jq5TaupA
	 yr4sMhBh8U9LDwvyPVLqj0Gj1CLKVl5JOLVBFuk6YAs7BkXq2eLdB/50MWRwm1e4Wo
	 5tWVR2b1axWAM+hzGPLKRZKmov9AuOLB6GN+x4SQ/rWl6Iz1OP+9Keq56VGoyf88+K
	 YPAIqrMKPGY/w==
Date: Fri, 31 Jul 2026 18:08:36 +0100
From: Will Deacon <will@kernel.org>
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org, Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH kvmtool] virtio: 9p: Order used ring updates before
 notifications
Message-ID: <amzWlInb1rgkRy_4@google.com>
References: <20260724091046.1868685-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724091046.1868685-1-xb@ultrarisc.com>

On Fri, Jul 24, 2026 at 05:10:41PM +0800, Xie Bo wrote:
> virtio_p9_do_io() signals the guest immediately after adding each
> request to the used ring. Unlike the block and net backends, it bypasses
> virtio_queue__should_signal(), which provides the full memory barrier
> needed between publishing used->idx and injecting the interrupt.
> 
> On weakly ordered architectures, the guest can therefore handle the
> interrupt before the updated used->idx becomes visible. If it observes
> the old index and goes back to sleep, the completed request can remain
> stuck indefinitely because no further interrupt is generated.
> 
> This was observed on RISC-V with two 9p RPCs blocked while the host
> used->idx was two entries ahead of the guest's last_used_idx.
> 
> Process all available requests first, then use
> virtio_queue__should_signal() before notifying the guest. Besides
> providing the required ordering, this also honors the driver's
> notification suppression request.
> 
> Fixes: 1c7850f95903 ("kvm tools: Add virtio-9p")
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  virtio/9p.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/virtio/9p.c b/virtio/9p.c
> index cf3e547..d2680e9 100644
> --- a/virtio/9p.c
> +++ b/virtio/9p.c
> @@ -1372,11 +1372,15 @@ static void virtio_p9_do_io(struct kvm *kvm, void *param)
>  	struct p9_dev_job *job = (struct p9_dev_job *)param;
>  	struct p9_dev *p9dev   = job->p9dev;
>  	struct virt_queue *vq  = job->vq;
> +	bool completed = false;
>  
>  	while (virt_queue__available(vq)) {
>  		virtio_p9_do_io_request(kvm, job);
> -		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);
> +		completed = true;
>  	}
> +
> +	if (completed && virtio_queue__should_signal(vq))
> +		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);

Why do you need the 'completed' bool here? Can't we just rely on
virtio_queue__should_signal() instead?

Will
