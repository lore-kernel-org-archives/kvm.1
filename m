Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63542A78B
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229574; cv=pass; b=MFkgkIdCaFezCVmacJJw/ZiuVyvws0vYmAZNaV53KBEr4cKjLczs+R3bWQ7xBWhjrQ1GiK/buLJxpApkPlrSUtXDlnRviCa5+D+te/8DVM9G34XqfB5+W/ArILfiIOiJUi1Hq824W7DrK8ZUhB4xGFu10/sQGdWRlMIObTkeqvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229574; c=relaxed/simple;
	bh=aL5TuuMwAaQVwOyXsLkpLSm0ZpL31g9SvuoVklTboFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAmUIzOqpwGNh3Cgt3gHEto65ae++wd0b8d3RLMckEw2hM9NI2RpoxYo3QQG9SyVR6TQ3gqpLxj8Y3+BuVdM/I5dTUyA4hfNyehP6VYawmok6cqVc6nLCBr8av/bCDZwpaQ5iPYXoe5SO5veKWs3hq2hEqNlFgtIzMVQg+PIXQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHFdxZCm; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHFdxZCm"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-936c02e58dfso151248785a.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 05:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229572; cv=none;
        d=google.com; s=arc-20260327;
        b=hJm4PzEfURESFZk5WquzZpEVp4hIfIH1WRM0YARXAmmsoVnDgvG8KtVTh8Iwbqac7o
         eKMfm0497pfAzlr8LqJt0Bf5sgkFLibr3ZrN+0exTWMqhg9Fk3DcIcmxB7Z9M4IW0dDo
         yQ3HqDfG5AJuX5wylLQFbtGil3/1zh/SUFbTAoBLelMdaJqL+LTa6ud3mHINt2h4FIhn
         XQB2gf7FiWG7QcjpqJB2/+bDbV6d0BiJ+fyGntCPmAtZ2BRisYk+0kF9QONIqUwQCqFn
         kIUrRl8q8anPQ9pX0jKrWuaW0TNZ4uoy0LJGPV5mDiFDslHnRqveuq4F8aYkf6s0H5aj
         yioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        fh=cCmhEmcRdn5dORUt+RnSpe4OtF9Ln4Ia5FuQaHn+JzE=;
        b=nclDKk6P0vlscmZZdl7TdAaBHA8soQFX1JpMj1W0mAUjr3O9spbP50EtpjMifavu97
         cqVer4uqbSjBZThC0bSkWcvzhN+64I/wpwZ9OQ7zTlMB9mwHIdkA+2PhyL6X+TI0WuX0
         IRnxbWXtW54iImTRZCNaJa5K7FL6cmRCsJWepwbTKmzRAhHYNn/8k8CFmYb24GVytI/2
         Z53d3nm39zxo0uzHqvwmU+rYFSl3Z0ejX8UOH8JlfDZYFgnMRyNbpjEkaXpAS278fYsH
         MPKbREUk9R/ZyFbNVzrhhF5W2wPRHvHi6Minv8FtDyMRIKTd01SgPFGi6QSzSz5e8xJF
         6Ahg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229572; x=1787834372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=PHFdxZCm2Dmv5fzgK/Y4Z3EnFWqeIPggZptGYjJ77AfC07SRxeVOGct9jYrvS16igd
         6IYMQ3KzzINLdo0dmGcvUxKDNOxpn50JLaGEG+yqKjWTN2UhtjegyFgu3m/+lnEX6mZN
         3+mvxoArlHfGc+C8znUTdjf18aQbJASVwG8lE41dwDply2elorcQku9LLaTxd2z1BKuM
         h/B1B8+HJA8/JTA4x4L1BW3dKH5Xe1/RGVwKWPzZGtQCICe0ngFEn8CXv4yuj/mPPmtN
         i4huB9c2+i0njLuzgbcSmizhQ/kfTWlb5alZzZotI5mmU13XQy6Dzkye3APyUWG97FM6
         cWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229572; x=1787834372;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=BCzwRQ6SsefO/SVVkoMgdJa9yRDjGGPtbtCvIG462IA3oRKbTGc3cHhhw3uMa6rALR
         xutwgPEnSthxVccJ7DD3YDMVrk8vsIwTh1LNRjoQDe46wd66Qx4IzoboeBl9yVZxwVj8
         L0JyHAZdpbC1JTMBGHtxSKyb4AYTfv9QX64RiVnUZOVH71GOC0ps8wbmhQlBT3ISti9A
         dE51kH5H8Q1Hehb9H34J2RQg2seuuSU27jTqnkUoTtNT+Fc6BlkdwxMDolZTqR9hve5A
         8vRyZwJSQwN+q6HiXVZ/Ur1pAc65cYHAKNuCBLFawhIlIUx/QSQ/ZktsG+cLWZbv4LZn
         ONKA==
X-Forwarded-Encrypted: i=1; AHgh+RqmVZTfCeqLJCHS8//DsEs5/wLH23Q+ncPoZd/YRkIt/zcxAOzUTaIH07s4RslVdP0EO7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrfbQc1Xqv7RY1dsLIDO2u8fg//N02OwZmTqBZ2vWPFP99eld
	KV11uc5crOKN7ECS67lgZWh8Tyuj3q2KUCqqR0O0NYR6D3Xlp9FN09NmVggXtSfBDcoFM2wu4/V
	zhruVyth0z0eV/frILZ2kD9M1XHtzkuI=
X-Gm-Gg: AR+sD13i9CIG0CiQQcc6xiP+3/TOE3TN4slLk34uGVFS0U/Kpr3qYw56C5OXB551u6/
	2xMrXfF/mSgpGMJfnAUWte4RC7P9kG40juSuPYhh+CI4gXcUR3pKjdl5mlvmc4u06cvQp8obXiB
	o4JMBKVJyzibE9vKABuRdANQ5I0ZiO645vMrIrsjVb5UhxyT5rVddraIMfu15VdBvzAS6RaQLL/
	4pQWBEYsujIJjikJ97pm1m3lTgmQpPAHykneDmfKfZ/tjx6k1pJu0NpyHkZRRabz6RgYKCbzF+M
	rkg8zKP0jLUDNG2htXJnI8oGz1uZoSZHFWHe5lnbxhqxExYrLHH04QE=
X-Received: by 2002:a05:620a:404a:b0:92f:199:b035 with SMTP id
 af79cd13be357-9371e252a0fmr1102568885a.3.1787229571662; Thu, 20 Aug 2026
 05:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com> <aobCds-JDgs3BiSp@sgarzare-redhat>
In-Reply-To: <aobCds-JDgs3BiSp@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:38:55 +0800
X-Gm-Features: AcwNN1V_ozKiep3YvThC-YsxIdIa8Rks0gJmRuoU636bafPM8R_uE-RRSwSYMDM
Message-ID: <CAJwVaM+WZhw_GCfqcEkNpe8vsTmW_OSRpiQVBXR8cpuvWiTjmg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
> >When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
> >used change meaning with the address space. Clear the cached vring access
> >state when the device IOTLB is installed or removed so stale IOVAs cannot
> >be reused as direct userspace addresses.
> >
> >Keep device IOTLB initialization idempotent and apply the mode change even
> >when a virtqueue backend is attached. Drop the device-wide IOTLB first,
> >then clear each VQ state under its own mutex, and keep the old table alive
> >until every VQ has completed the handoff.
> >
> >A successful live mode change leaves the backend attached but invalidates
> >the cached vring addresses. Userspace must configure the vring addresses
> >for the new address mode before data processing can resume.
> >
> >Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 14637cff0bd4..31fff9800045 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> >               vq->meta_iotlb[j] = NULL;
> > }
> >
> >+/* Caller must hold the virtqueue mutex. */
> >+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
> >+{
> >+      vq->desc = NULL;
> >+      vq->avail = NULL;
> >+      vq->used = NULL;
> >+      vq->log_used = false;
> >+      vq->log_addr = -1ull;
> >+      __vhost_vq_meta_reset(vq);
> >+}
> >+
> > static void vhost_vq_meta_reset(struct vhost_dev *d)
> > {
> >       int i;
> >@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
>
> Is this the right patch where introduce this function?
>
> IMO should be introduced when we use it.
>
> About that I'm not sure if it is better to squash the other 2 patches
> with this one, otherwise will be this bisectable?
> I mean with just this patch applied (and without the other 2) who is
> going to free the old iotlb?
>

 I'll rework the series so that the helper is introduced together with
 the vhost-net and vhost-vsock callers, most likely by squashing the three
 patches. I'm also reviewing the existing IOTLB replacement semantics
 before preparing the next revision.

> >+{
> >+      struct vhost_iotlb *iotlb;
> >+      int i;
> >+
> >+      iotlb = d->iotlb;
> >+      if (!iotlb)
> >+              return;
> >+
> >+      /*
> >+       * Drop the device-wide view first.  Each VQ then drops its
> >+       * per-VQ view and its cached ring access under its own mutex.
> >+       * Keep the old table alive until every VQ has completed this
> >+       * handoff, since a worker may still be using it while waiting
> >+       * for its VQ mutex.
> >+       */
> >+      d->iotlb = NULL;
> >+
> >+      for (i = 0; i < d->nvqs; ++i) {
> >+              struct vhost_virtqueue *vq = d->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              vq->iotlb = NULL;
> >+              vhost_vq_invalidate_access(vq);
> >+              mutex_unlock(&vq->mutex);
> >+      }
> >+
> >+      vhost_clear_msg(d);
> >+      vhost_iotlb_free(iotlb);
> >+      wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> >+}
> >+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
> >+
> > int vhost_init_device_iotlb(struct vhost_dev *d)
> > {
> >       struct vhost_iotlb *niotlb, *oiotlb;
> >       int i;
> >
> >+      if (d->iotlb)
> >+              return 0;
> >+
>
> IIUC after this patch `oiotlb` is always NULL, can we remove it?
>
> Thanks,
> Stefano

  Thanks, I took another look. I don't think we should simply remove
  oiotlb while keeping the early return, since the early return itself may
  be too broad.

  One case I need to examine more carefully is vhost stop/start. QEMU
  unregisters the IOMMU listener while vhost is stopped. If an IOVA
  mapping changes during that interval, preserving the existing kernel
  IOTLB on the next VHOST_SET_FEATURES may retain an entry pointing to the
  old HVA. A later lookup could hit that stale entry, so no IOTLB miss
  would be reported and no replacement update would be triggered through
  the miss path for that IOVA.

  The original replacement path, including oiotlb, installs a new empty
  table and safely keeps the old table alive until all VQs have switched.
  I need to review this lifecycle more carefully before deciding whether
  that replacement semantic can be removed. A logging-only feature update
  may want to preserve the IOTLB, while a restart boundary may need a new
  one, and d->iotlb != NULL alone does not distinguish those cases.

>
> >       if (max_iotlb_entries <= 0)
> >               return -EINVAL;
> >
> >@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
> >
> >               mutex_lock(&vq->mutex);
> >               vq->iotlb = niotlb;
> >-              __vhost_vq_meta_reset(vq);
> >+              vhost_vq_invalidate_access(vq);
> >               mutex_unlock(&vq->mutex);
> >       }
> >
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index 0192ade6e749..3c75e8089373 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> >                           int noblock);
> > ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> >                            struct iov_iter *from);
> >+void vhost_clear_device_iotlb(struct vhost_dev *d);
> > int vhost_init_device_iotlb(struct vhost_dev *d);
> >
> > void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
> >--
> >2.34.1
> >
>
