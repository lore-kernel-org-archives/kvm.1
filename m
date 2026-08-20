Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D636DA14
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217089; cv=none; b=iiJOdDvvFP/fDjIZA287+N7UVc9tcwpJGM9Rq5xWrg4+5Bx2EkZd1Cj2/E5F27MGKwTEYa/KOtAe7JjqN4CY455ZMCiSqREZcbTnNQgNmRZfp1SqPWMmy033ovyarp1DgrT/aTN0C21SK3ix7yy4UGD9FMPlCSf3LkCTDo5tfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217089; c=relaxed/simple;
	bh=Pqhe1/gUDvPffZ3kxx5/azyvzD1TsrTgTISNWYyFtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DavNsnaylHmkCMBOmp6Hc18aZIVYhk2S6yOTBZwpeC1DsMwvhWlbXL9XD0Y+UAN+q4dCA0WoAdQxj2lizL9+OX4fgpjhFPf5ASfBoqDgho3AvvwkKYPGRSwCJUBSIiAVuk9DDjML3pb5jBPmfZPmywEMZi02a2mKjB2TabCM3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4NbgwUU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VN5EgLDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4NbgwUU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN5EgLDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
	b=D4NbgwUUs/pXKuIFSlZ5dG+KCqAHk1OvNz3vw/TtUZN6KJk47b1H15C6NoApb1eW1eBEni
	sXCxSDSCOVyLAHVnGYIFCD9NxiovqvGpcxgwm4T1aYcX/Yd/EoJmPrDsVkmxVcWUpTthtO
	piqD+wGfL8TovAVWuvgNRqXvBtGoJUA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Ic4Bl-UDOmKgPGf1jd3-bQ-1; Thu, 20 Aug 2026 05:11:24 -0400
X-MC-Unique: Ic4Bl-UDOmKgPGf1jd3-bQ-1
X-Mimecast-MFC-AGG-ID: Ic4Bl-UDOmKgPGf1jd3-bQ_1787217083
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4815b878101so893474f8f.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217083; x=1787821883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
        b=VN5EgLDDFX2vOytakAjfysoBoH2G+XB+v+dLjx7hQ9SuzELKhvlrU95sVs/wgWEl6F
         mNYr4/CcLohk+0tlermMoZp2iTWeCfKMDoOdEBBdtTPkrFJnq3MiayRR1pfaI+vXxnMv
         G+acpWborldEikVGcmBsnirIFmuXwHMWI2eaYDGOyDcObzZxJ8LJRXLHoQKtDKwoN1RY
         +ft8MBJ0KT4FL7mhPCZFH2GDegRV7oU2uO/qkmjC7lmGlnQYoN+znKpP+V9/62yMip+F
         y0FC0jqrBJdKLphMxY+kfDiyX1b8E+juGldkSpCdngM66Kmz6IB8gW+3e398iEiKqZPQ
         L9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217083; x=1787821883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
        b=b8dChvdQGVTODpvKvzcbJsuvG46qdVTrvlL2eGNUv+Ut/4u8kKNJOzsEUskBitevQs
         kE+stdzh0FNvbIqKldAlBTMui2TT7Rmene+bzhk0oT9J7CYOu6cDcII0pbGI6gmAxTvD
         p9M01N3B7yrThfvylBTuS1YwCJfyggnkDOVo5qBELJ3ZSbXT4KL0MT+GC26+DMANqHt6
         vBB2Unl3DQWby3sC+HVYpnXqE9nZNDnb3seNz68nQ+xZYcgYc2jt6xkAQwiSxNazdAif
         XF1+XtVS4wlJUzG9Su+gD6Mq7ip1yjLZpeQu1/EzeStE5ms5s157MUyqh+H6/7vNXXcw
         gOog==
X-Forwarded-Encrypted: i=1; AHgh+Rrxhn0kmCJO1iJG7fsa/Cjk6eUmZRaGLkKRqXJjiznVYT5vh7yZD0toDiKVggdNVpo+xk0=@vger.kernel.org
X-Gm-Message-State: AFuF++llzBOA3DIFl6yXSEdeo981dhPsoiRGKqwIR5850y5OergPVPkv
	sK35rWL8Adrz19O3KNSnKuxqz16jYLZFK7DgAof7EcYWiNR+D9jERX7Mmjk36fcpzZVhG4h7lW3
	vb1K+aV7P93ZYmZRH8MPO+vKSsYlnzose8QatofjCnM3WP3HbPDr58Q==
X-Gm-Gg: AR+sD13EPuIXi4PMXD59FYHMSn2NnFw7djuPbd/g65b0zlMc19sfPHDjdFuB7IgEMLQ
	5o/MlrU4lBZXexun+GvbeJdlahbJXI0bxvx3TBo++eU53zTGfPuqlDioV9z1EJDgQYQCIVmC1+s
	MPr0TTdlCxfdO6yRR/FqyHaT52HxCy3YEiALrlhF/CI/aMRYVohyWwV44S8tMUopu7xD6hJrnuL
	JuPj7o3EQYiZTMNxfdnADWsIw+nxoRLYRkQ5w5ghvgzGjUpEDOOJXm5ev4xpzIzqH4de23Immgh
	fiSHAk5VH20PGqXlKlYG4r556cjchmadac3vrGPdJG86ZdkIc4Smzr2rYtRC2x93rPbwU2B9XWI
	8EzSEEG/+ShEu7+ltpAv14FGr4nZ1yc70chTLvrPiwyYt2jsrS+cb
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067503f8f.2.1787217083004;
        Thu, 20 Aug 2026 02:11:23 -0700 (PDT)
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067399f8f.2.1787217082530;
        Thu, 20 Aug 2026 02:11:22 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8038sm10520293f8f.20.2026.08.20.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:11:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:11:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB
 transitions
Message-ID: <aobCds-JDgs3BiSp@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820080332.313933-2-physicalmtea@gmail.com>

On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
>When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
>used change meaning with the address space. Clear the cached vring access
>state when the device IOTLB is installed or removed so stale IOVAs cannot
>be reused as direct userspace addresses.
>
>Keep device IOTLB initialization idempotent and apply the mode change even
>when a virtqueue backend is attached. Drop the device-wide IOTLB first,
>then clear each VQ state under its own mutex, and keep the old table alive
>until every VQ has completed the handoff.
>
>A successful live mode change leaves the backend attached but invalidates
>the cached vring addresses. Userspace must configure the vring addresses
>for the new address mode before data processing can resume.
>
>Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 53 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 14637cff0bd4..31fff9800045 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> 		vq->meta_iotlb[j] = NULL;
> }
>
>+/* Caller must hold the virtqueue mutex. */
>+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
>+{
>+	vq->desc = NULL;
>+	vq->avail = NULL;
>+	vq->used = NULL;
>+	vq->log_used = false;
>+	vq->log_addr = -1ull;
>+	__vhost_vq_meta_reset(vq);
>+}
>+
> static void vhost_vq_meta_reset(struct vhost_dev *d)
> {
> 	int i;
>@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> 	unsigned int num = vq->num;
>
>+	if (!vq->desc || !vq->avail || !vq->used)
>+		return 0;
>+
> 	if (!vq->iotlb)
> 		return 1;
>
>@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)

Is this the right patch where introduce this function?

IMO should be introduced when we use it.

About that I'm not sure if it is better to squash the other 2 patches 
with this one, otherwise will be this bisectable?
I mean with just this patch applied (and without the other 2) who is 
going to free the old iotlb?

>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;
>+
>+	iotlb = d->iotlb;
>+	if (!iotlb)
>+		return;
>+
>+	/*
>+	 * Drop the device-wide view first.  Each VQ then drops its
>+	 * per-VQ view and its cached ring access under its own mutex.
>+	 * Keep the old table alive until every VQ has completed this
>+	 * handoff, since a worker may still be using it while waiting
>+	 * for its VQ mutex.
>+	 */
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		vhost_vq_invalidate_access(vq);
>+		mutex_unlock(&vq->mutex);
>+	}
>+
>+	vhost_clear_msg(d);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
>+}
>+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>+
> int vhost_init_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *niotlb, *oiotlb;
> 	int i;
>
>+	if (d->iotlb)
>+		return 0;
>+

IIUC after this patch `oiotlb` is always NULL, can we remove it?

Thanks,
Stefano

> 	if (max_iotlb_entries <= 0)
> 		return -EINVAL;
>
>@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = niotlb;
>-		__vhost_vq_meta_reset(vq);
>+		vhost_vq_invalidate_access(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..3c75e8089373 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> 			    int noblock);
> ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> 			     struct iov_iter *from);
>+void vhost_clear_device_iotlb(struct vhost_dev *d);
> int vhost_init_device_iotlb(struct vhost_dev *d);
>
> void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>-- 
>2.34.1
>

