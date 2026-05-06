Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A228B4FA;
	Wed,  6 May 2026 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046354; cv=none; b=fT0Lq+OPqHFmPVLqmdOJcPWnvgcz85jPattq0u7tVDfFuOZcrmaK+bDPYnlUf2S7PtKWpALh/Ytu/Y423K5RmFGxfteRXYQYZQs6T8nBwWr8iG+AwyZRBIvZe+ls42moAytd8LnvzGIL+oCpDCn6SgkMvqd0MCd/dzE9C4Ov328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046354; c=relaxed/simple;
	bh=UJkH+UOCSGrkXfL3+MCEw4AnA3nxx9o/0Pao4jQFhfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLHs+TA6Is0HZECN6GcKmODf/JvikhC5vc07ZtoK8jkR5rBfMOnEkmmYrGpJ8LoJpCDy+QhOqA5CeSKE7rxBj/Scx6a63Bg9qTzvveKXNXn1UkrL6BoTyDynxOw9b3Cp1FAxJDHsard3BpA0muSV3t6p5Bhn48wNF7J1oP6MGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXRPJNT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXRPJNT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30426C2BCB8;
	Wed,  6 May 2026 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778046354;
	bh=UJkH+UOCSGrkXfL3+MCEw4AnA3nxx9o/0Pao4jQFhfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXRPJNT33NFuGl5qCkoewFO7Ri1QwXvDSBRYAXLDiOghlgawd1tnZX7J7/jgFeIDl
	 8jLCq09ZDNPVndJrApS26WqcSwCdtHGYLlKCla77TZVYbMI6pXNNCpB18gOf2oZyVC
	 TNams3KySlleY6oDlLTT3hWt9A+f/YuGkFZ4ARtenUufPeGjsKLeSqwfWLYUX4sx/L
	 NecS1jM3J3E/Io7H/rMuKInZcwLa6ky8fAD6tFtr4CDZplssjpOP2YYAGU4VBCK2N2
	 tTC/CDy1sb6TFHiABsbHLsNVe0rqzqnW9QJqhEXQ+C/Aspk+hewCLpSxYxEwwHerIk
	 7Ht+ha/LzTYPg==
Date: Wed, 6 May 2026 08:45:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
	joonas.kylmala@netum.fi, Kevin Tian <kevin.tian@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Fix double-put during dma-buf cleanup
Message-ID: <20260506054546.GH11063@unreal>
References: <20260429182736.409323-2-clopez@suse.de>
 <20260429142242.70f746b4@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429142242.70f746b4@nvidia.com>

On Wed, Apr 29, 2026 at 02:22:42PM -0600, Alex Williamson wrote:
> On Wed, 29 Apr 2026 20:27:36 +0200
> Carlos López <clopez@suse.de> wrote:
> 
> > When a dmabuf is created for a VFIO PCI device BAR, it is added
> > to the device's list of dmabufs. If PCI memory access is disabled,
> > vfio_pci_dma_buf_move() is called to revoke the dma-buf, dropping a
> > reference via kref_put(), and setting its revoked field to true.
> > 
> > Currently, vfio_pci_dma_buf_cleanup() does not check if the buffer
> > was already revoked, calling kref_put() on all dmabufs for the device,
> > potentially leading to a refcount underflow and use-after-free, as
> > reported by Joonas Kylmälä.
> > 
> > Check priv->revoked before calling kref_put() to avoid underflowing the
> > reference count.
> > 
> > [  216.397532] ------------[ cut here ]------------
> > [  216.397540] refcount_t: underflow; use-after-free.
> > [  216.397542] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#5: python3/3269
> > [ ... ]
> > [  216.397851] RIP: 0010:refcount_warn_saturate+0x59/0x90
> > [  216.397859] Code: 44 48 8d 3d 09 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 08 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 07 bc 35 01 <67> 48 0f b9 3a e9 4d b4 70 00 48 8d 3d 06 bc 35 01 67 48 0f b9 3a
> > [  216.397862] RSP: 0018:ffffd05f83a03c60 EFLAGS: 00010246
> > [  216.397867] RAX: 0000000000000000 RBX: ffff8db0425a49c0 RCX: 0000000000000000
> > [  216.397871] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb0364910
> > [  216.397873] RBP: ffff8dafc9fc0550 R08: ffff8dafca8f90a8 R09: 0000000000000000
> > [  216.397876] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8dafc9fc0000
> > [  216.397878] R13: ffff8dafc9fc0560 R14: 7fffffffffffffff R15: ffff8db0425a4980
> > [  216.397882] FS:  00007fc096c06780(0000) GS:ffff8db74ea75000(0000) knlGS:0000000000000000
> > [  216.397886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  216.397889] CR2: 00007fc096932010 CR3: 000000014040b005 CR4: 0000000000f72ef0
> > [  216.397892] PKRU: 55555554
> > [  216.397894] Call Trace:
> > [  216.397898]  <TASK>
> > [  216.397904]  vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
> > [  216.397923]  vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
> > [  216.397935]  vfio_df_close+0x4c/0x80 [vfio]
> > [  216.397946]  vfio_df_group_close+0x36/0x80 [vfio]
> > [  216.397956]  vfio_device_fops_release+0x21/0x40 [vfio]
> > [  216.397965]  __fput+0xe6/0x2b0
> > [  216.397972]  __x64_sys_close+0x3d/0x80
> > [  216.397979]  do_syscall_64+0xea/0x15d0
> > [  216.397988]  ? ksys_write+0x6b/0xe0
> > [  216.397996]  ? __x64_sys_pread64+0x91/0xc0
> > [  216.398003]  ? do_syscall_64+0x128/0x15d0
> > [  216.398010]  ? do_syscall_64+0x128/0x15d0
> > [  216.398017]  ? ksys_write+0x6b/0xe0
> > [  216.398023]  ? do_syscall_64+0x128/0x15d0
> > [  216.398029]  ? __x64_sys_ioctl+0x96/0xe0
> > [  216.398036]  ? do_syscall_64+0x128/0x15d0
> > [  216.398042]  ? do_syscall_64+0x9f/0x15d0
> > [  216.398048]  ? clear_bhb_loop+0x30/0x80
> > [  216.398054]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  216.398059] RIP: 0033:0x7fc096c9a687
> > [  216.398063] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> > [  216.398067] RSP: 002b:00007ffe422781f0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [  216.398071] RAX: ffffffffffffffda RBX: 00007fc096c06780 RCX: 00007fc096c9a687
> > [  216.398074] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> > [  216.398076] RBP: 0000000000a83590 R08: 0000000000000000 R09: 0000000000000000
> > [  216.398079] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc096f43160
> > [  216.398081] R13: 0000000000000135 R14: 0000000000a83590 R15: 00007fc096f43168
> > [  216.398087]  </TASK>
> > [  216.398089] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
> > Closes: https://lore.kernel.org/kvm/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
> > Reported-by: Joonas Kylmälä <joonas.kylmala@netum.fi>
> > Assisted-by: Gemini:gemini-3.1-flash-lite-preview
> > Signed-off-by: Carlos López <clopez@suse.de>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index f87fd32e4a01..deb9c351c4a6 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -389,14 +389,20 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> >  		dma_resv_lock(priv->dmabuf->resv, NULL);
> >  		list_del_init(&priv->dmabufs_elm);
> >  		priv->vdev = NULL;
> > -		priv->revoked = true;
> > -		dma_buf_invalidate_mappings(priv->dmabuf);
> > -		dma_resv_wait_timeout(priv->dmabuf->resv,
> > -				      DMA_RESV_USAGE_BOOKKEEP, false,
> > -				      MAX_SCHEDULE_TIMEOUT);
> > -		dma_resv_unlock(priv->dmabuf->resv);
> > -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > -		wait_for_completion(&priv->comp);
> > +
> > +		if (!priv->revoked) {
> > +			priv->revoked = true;
> > +			dma_buf_invalidate_mappings(priv->dmabuf);
> > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > +					      DMA_RESV_USAGE_BOOKKEEP, false,
> > +					      MAX_SCHEDULE_TIMEOUT);
> > +			dma_resv_unlock(priv->dmabuf->resv);
> > +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > +			wait_for_completion(&priv->comp);
> > +		} else {
> > +			dma_resv_unlock(priv->dmabuf->resv);
> > +		}
> > +
> >  		vfio_device_put_registration(&vdev->vdev);
> >  		fput(priv->dmabuf->file);
> >  	}
> 
> Thanks for taking a look at this.  I was putting some AI to work on
> this AI sourced issue as well.  We found a similar solution, but
> ultimately headed in a direction that it would be best to return the
> device to the dmabuf creation state rather than allow this invariant
> refcount to exist.  There's an alternate option below that Leon and
> Christian can weigh in on.  I'll post some selftests additions that
> trigger this and exercise the expected flows regardless.  Thanks,
> 
> Alex
> 
> commit 744d9704fb83e843d511c0c668c16d43175c6ad7
> Author: Alex Williamson <alex.williamson@nvidia.com>
> Date:   Wed Apr 29 12:19:34 2026 -0600
> 
>     vfio/pci: fix dma-buf kref underflow after revoke
>     
>     vfio_pci_dma_buf_move(revoked=true) and vfio_pci_dma_buf_cleanup()
>     ran the same drain sequence: set priv->revoked, invalidate mappings,
>     wait for fences, drop the registered kref, wait for completion.
>     When the VFIO device fd was closed after PCI_COMMAND_MEMORY had been
>     cleared, both ran in turn -- the second kref_put underflowed and the
>     subsequent wait_for_completion() blocked on a completion that the
>     first run had already consumed:
>     
>       refcount_t: underflow; use-after-free.
>       WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>       Call Trace:
>        vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
>        vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
>        vfio_df_close+0x4c/0x80 [vfio]
>        vfio_df_group_close+0x36/0x80 [vfio]
>        vfio_device_fops_release+0x21/0x40 [vfio]
>        __fput+0xe6/0x2b0
>        __x64_sys_close+0x3d/0x80
>     
>     Collapse the duplication: vfio_pci_dma_buf_cleanup() now delegates
>     the drain to vfio_pci_dma_buf_move(true), which is idempotent for
>     already-revoked dma-bufs.  cleanup retains only list removal and
>     the device registration drop; the dma_resv_lock that bracketed
>     those is dropped along with the in-line drain that required it,
>     memory_lock continues to protect them.
>     
>     Re-arm the kref and the completion at the end of move()'s revoke
>     branch so post-revoke state matches post-creation (kref == 1,
>     completion ready).  This keeps cleanup's call into move() a no-op
>     when revoke already ran, and replaces the explicit kref_init() that
>     the un-revoke branch used to perform for the un-revoke -> remap
>     path.
>     
>     Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
>     Reported-by: Joonas Kylmälä <joonas.kylmala@netum.fi>
>     Closes: https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
>     Assisted-by: Claude:claude-opus-4-7
>     Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Alex,

I think that your fix is the cleanest one.

Reviewed-by: Leon Romanovsky <leon@kernel.org>

Thanks

> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index f87fd32e4a01..fdc22e8b4656 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -354,19 +354,18 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  			if (revoked) {
>  				kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  				wait_for_completion(&priv->comp);
> -			} else {
>  				/*
> -				 * Kref is initialize again, because when revoke
> -				 * was performed the reference counter was decreased
> -				 * to zero to trigger completion.
> +				 * Re-arm the registered kref reference and the
> +				 * completion so the post-revoke state matches the
> +				 * post-creation state.  An un-revoke followed by a
> +				 * new mapping needs the kref to be non-zero before
> +				 * kref_get(), and vfio_pci_dma_buf_cleanup()
> +				 * delegates its drain back through this revoke
> +				 * path on a possibly-already-revoked dma-buf.
>  				 */
>  				kref_init(&priv->kref);
> -				/*
> -				 * There is no need to wait as no mapping was
> -				 * performed when the previous status was
> -				 * priv->revoked == true.
> -				 */
>  				reinit_completion(&priv->comp);
> +			} else {
>  				dma_resv_lock(priv->dmabuf->resv, NULL);
>  				priv->revoked = false;
>  				dma_resv_unlock(priv->dmabuf->resv);
> @@ -382,21 +381,22 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  	struct vfio_pci_dma_buf *tmp;
>  
>  	down_write(&vdev->memory_lock);
> +
> +	/*
> +	 * Drain any active mappings via the revoke path.  The move is
> +	 * idempotent for dma-bufs already in the revoked state and
> +	 * leaves every priv with the kref re-armed and the completion
> +	 * ready, so cleanup itself does not need to participate in kref
> +	 * bookkeeping.
> +	 */
> +	vfio_pci_dma_buf_move(vdev, true);
> +
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>  		if (!get_file_active(&priv->dmabuf->file))
>  			continue;
>  
> -		dma_resv_lock(priv->dmabuf->resv, NULL);
>  		list_del_init(&priv->dmabufs_elm);
>  		priv->vdev = NULL;
> -		priv->revoked = true;
> -		dma_buf_invalidate_mappings(priv->dmabuf);
> -		dma_resv_wait_timeout(priv->dmabuf->resv,
> -				      DMA_RESV_USAGE_BOOKKEEP, false,
> -				      MAX_SCHEDULE_TIMEOUT);
> -		dma_resv_unlock(priv->dmabuf->resv);
> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> -		wait_for_completion(&priv->comp);
>  		vfio_device_put_registration(&vdev->vdev);
>  		fput(priv->dmabuf->file);
>  	}
