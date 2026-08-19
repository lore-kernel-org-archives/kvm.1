Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68433AA1A6
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148594; cv=pass; b=uulS/edhOe5hrfj4oP6rfrOnslZjHFdAVAhaWVrmRMsTpnHsBn8neI2DEAtgHAQPN7LQUF28SiF+AgPYa3QnrWMY4jwCBDa62H5Nlorz4/VZPIxZym2Tph/aI0TzGwqFjTaW08vF9scApEu96W/Lcac49XqcONJ4Q4FIEKwJBDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148594; c=relaxed/simple;
	bh=mQJhKOEjw9O3sNOjoGU+M3F8LtVcSFzmDVvu0spcCd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR4yCuSeQv+u53no6+Z60jCPcwrhRe3xy1vEq4YPGd3/2mSo4O3J3oug2IKh17+wSnkMsOq9QK+W4ybuB96oHVWLKw7SMczGFdMK4Xdnh3NFu4AK5iWyF/+PJL2qsaULNgdUVXCSEE5laR/e9oEzAyoCY3AaavMQSVfqYTJV7SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkcJpyf3; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkcJpyf3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f4e5eed1so73193985a.2
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 07:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787148592; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0UgfKlYWjK7MhcgUzRAd3A7JNX6p7u/0gpEWzEq/yEJPEoK/eNUpkHw3WJxaLyZxc
         Tlf/uXztfqM7qGe+e/RilZoOeFDmP2OXimk0IucB8f2FK80Lewib+4zk6b3isNmRXpjv
         EKXEzYhVHQotKyy252zFFFj2vESPWP3oSk++XJWXk9B8i72p8/+OQ+oqxRuL8u66QKQL
         lBA51AdgGYiYNjpKSOz/xjCc2pIBdDVcvucFp8p+KohepCIMH9erMwy4rgh6AOo05RqB
         IPGZS6mT1lB/EEYQ5Y40S9KVwfQiFMwHwVKVSPis2SjY6FKy7ius+Tqe4v/RTyJP1dme
         AFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        fh=3k/cIZzF/+xHo2d66G5ZiImWP6t2g1RqczrbWkMzSyU=;
        b=lybZr4yDPPtmexbHtCjPECLE5vA0fKS/4C4YV72TFV7WUjTaSrRS6T3Z4x7tanoFhu
         CW8CQGJLbOPiEKrv2Fofc/p6wyNKKUBz1pdTY8fSufSzFfI0OJ7rXOyzUiF46963Nmwy
         KSpydvqQxJJWiU8ThVNHWGyS5SmDg7lZek8gdej9Nz8s1Zy2jrmYrhDeP58BZM1Q8oba
         u4aYfgDrHZ388KKqwbOrteFeHsGnC8uGuxrDT/HfJsZacJgEpSDDBAcRsePCIJ65T28w
         dcIh1GMGOJLlWOqLzrHeiZlz6Bm5B5OsxrhrtdohblnohNrJXk2Pqj4vUhFJk0X5/pwx
         /+QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787148592; x=1787753392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=gkcJpyf3J3p6BFsKympMW9+6ubgXYD/0yXt/Wo3eQyE+bACdgsXfJquQ+ZLqsUL3D/
         fQQKASBYvm7tLPpxfsaA8cU9hJ/OWAhCrJSAFCbkdtE7HR0p1PTKFbYPZgPWREgrS2oe
         4wqO4Fo5O3+KK8Hir9B+5j08VJxzpYuwyU1zv5JM7iEcjPH9xUTlIFvhSAby9brzi600
         1BI0Oa7cZBjWbfHafqC+kZeuVw6+sP+mxEb+vEmE+LaL4b8K/rfo4jiYHFqGDh2d/iVH
         eWiFy3pBOHuKEoQG/dTROxDOhp9ivfAsR9ecLaU9cqY1gr8w1qf9oXunaTsmMeUseXAj
         Dhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148592; x=1787753392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=sw8974j3i10sTNVCWezMQr1LTpsGa9nea3Wx4taPJqzlHNGMKuVYq/Oz3qRGU8QsLz
         ZwR4R+mNqJxrQxjajsSRqpfKymaYHso4yKiW8W9ps2Wshk6yI9V5HYQiFwIYwtGFz5TI
         f6hayre2zWABZrTPckADvyJJisxF4+SS/WdkxcljJ5jFkxWuT9XJ9Mp2WQiYJO8VBqpR
         4ioI19VpZX/2tXTXPbzxp86wLXpbongEjA4nD8+gtGNZPqbxCQ2Ovk2feLMsTlSAcxQJ
         wgY3UbE+OMm2cVELVFYviL3+t1JGCCPPwVWQGKd8Ew4hRgAc8WFpHk1jn9oFb3K1gu2B
         AyMA==
X-Forwarded-Encrypted: i=1; AHgh+RotGgHkTwod3qoGuR6Nnh4UamWsxzUFpxviCs0rUnEBgJyzf3XNVi59uvsfDFyPh4i/gME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznq2y41F3uyIJ8oPv0Sq+fFjnJbhyuhJmXDiLLEE6vXH8R1LMP
	rV58H7bN1J8KjnLujUDSJBxMFEtwwF9otGFo01W6Re6/mP0StEHo+XrROhRJsHssr6JtZaGk1t5
	N65Mc4z/G6keERXQWmN1tJUgRRT/ld0k=
X-Gm-Gg: AR+sD13lTmLysjb2DTqN6w+ifj+mWI4xOqN1XLIUNH9G05pUIaL9MF0nzHLeZJXbgjL
	XDuctlRgJ26iCP5cuSJr8U7gUyAfeY3aTN3v0bEnanjqYUDlfOaWbtQC38671GeJzxCWvMxUPPD
	VFiDE8czvfvtJtMyJbwenKFiL2ry0f/yN+boo3lF33tg/jpifjfX6msqruNerDzRYGvbbT0uJAO
	MsQeEqj+Cb/MBqwu+lMdCT1lQc2lijgV1QQ2HLLadxWP881l1U+b7LSBhGkkj2ZmNJf5JljN95t
	MxUEbVu1pPSAYgLzGEA01/w33Eoa8YwA5N864SvF2JMF4w==
X-Received: by 2002:a05:620a:6989:b0:915:6a2b:6265 with SMTP id
 af79cd13be357-9371e67768fmr433513185a.44.1787148590518; Wed, 19 Aug 2026
 07:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-2-physicalmtea@gmail.com> <aoVkRe_BN6L_5XZn@sgarzare-redhat>
In-Reply-To: <aoVkRe_BN6L_5XZn@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 19 Aug 2026 22:09:13 +0800
X-Gm-Features: AcwNN1Wyv_sTsBQBf0-FqnHUDP5OfgUj3xn0SY-WfGW-HK_cGsBtdxAB-mDAfmg
Message-ID: <CAJwVaML_qrz3hu-7ZyFDEz2M3vAsGPnmNua35dAgn52E+jOxUw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Aug 18, 2026 at 12:26:11PM +0800, Jia Jia wrote:
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
> >
>
> Please don't leave spaces here!
>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
>
>
> This patch doesn't apply, I tried vhost tree, net tree, and master.
> On which tree is this based?
>
> Stefano
>

Thanks for checking. I confirmed that v6 was generated from an older
local linux-next snapshot with local changes on top,
so it does not apply cleanly to the current tree. Sorry for taking up
your time. I will fix this first. Thanks again.


> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..9f74537b1c1c 100644
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
> >@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
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
> >       niotlb = iotlb_alloc();
> >       if (!niotlb)
> >               return -ENOMEM;
> >@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
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
> >
>
