Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B966417BFE
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694320; cv=none; b=kCOIrZvcsTCyUaLIamKwK14vVQeRiRKjcAtK/h54v5k1CkJcUMhf0QNb5jpqn09VyYm/Wy3ACh1rRv2gD9FSLQBRTg3airb0k9O9R2XMKszvxMQtV+7baSzknJ5jlU8Dk7H9PHgB1F9WyJbJs1Oh03VoGlfH5IhH7q1o+od6Dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694320; c=relaxed/simple;
	bh=8Kg+ScAaOCNrKwZS1J2hG59QX910+I//yXlSdISGGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGkxU2NsFcwb/G1b5jEZKO/QzUl4Bb87tO5Ry8X1SVnOn1RjusOhJlNtPcCvADocY4iv92ckjBiwGdmAUIZ9p52Ykvs8FSmCsczsvzeXMr0V3275W0Ajdsoj+QlD2lWiEAwnQlXLdxMLg0V/6K7gUihbsdRe1SZMRtBQp1h6v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WArXOc4B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0BPZw2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WArXOc4B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0BPZw2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
	b=WArXOc4Bhw9+bEq0GAz4sYhVxLlsyJS4myD4peh85HC4JnC9EfUOL/P4m1o0UW7/xZjLuq
	211qGsOxjh5t7NoohFCNpOcCGN2FcyN20gh2NI3tYJrPG3i1QOXH66SzF0DafnnMlNDKnn
	D/IHS2TV5/qcdF4oTN1o0s7RgYRWg84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-fUYBhKv2MsGLrxbG4NDkqQ-1; Fri, 14 Aug 2026 03:58:35 -0400
X-MC-Unique: fUYBhKv2MsGLrxbG4NDkqQ-1
X-Mimecast-MFC-AGG-ID: fUYBhKv2MsGLrxbG4NDkqQ_1786694315
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso5573845e9.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786694314; x=1787299114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
        b=R0BPZw2NCcTfdCB6fl2h9jW3Adxaqi/qjaO+0Wa6PHvDKkuc1f/u35vu4w9bJ+CemQ
         RWko/FdmZjo/NbbyPnjuY2rF+Yg9DfRZgWMHIh4wXsznUkxlz7bBcP3J3sxkkiTjb3s8
         LI8L0hNdTXEak31/LLIGvJIdA0RxqBr85mOzHFdfvQue91373j6Ly2lTvG+YU0hB7pRT
         ol7IWnGFaRiGofgzqHDUGl5/MrUQQcrcoWklUrEGXApLHjQ1qz5LI3U/h5vp9j+VgrwA
         hP1kfp6WFFkMWKph6XN/+MonQ4f0oGhINMIboCJ8CUbDdo/a0VaEAAvrl1XoyXzVapaR
         wfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694314; x=1787299114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
        b=BOQHG/UPKP4e7IYXWWHDjoaS0dqbu9RoAXR4li+O1zGHmf7LiUw4HEs6KslglWa+Ho
         m/Go+ADjZBkJABzE06KnZrNkpac0Qw5kuwM8NGXsAhi1mvIXRYbdQ14njOxZN3T90k2y
         SlkUE2fsjeAmHG4YqUGw9JEzkWy58OeAWMv69FBBoejLoCDZJs3oAtUgUREQzVhi6L3/
         q0wxBjAYeqbewOm/7sskSdZNlZ95T1RcL/eEu/+rOHoRQTGfeY9k9W8OYQa4+CJ1jjPM
         /ZNnFuVNFOPaVBPMvAYBxP9TYJuujORoMVFGR7LKgxYyQVcI5TdNK1I5atTi5++3WOVg
         B65Q==
X-Forwarded-Encrypted: i=1; AHgh+RrA1RF/wNTHyOk2gcNEb0w/XPKN/JV6X2Gcuup/y+Ac8VR2kuC2POMzxMg7Q1iKbm39jSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAsVFq01V/HlyCqISjGSKkfYWVaRZtXXA38BTiNx6gAzQhpe6
	DUgeeyC9bQ8tOb9c0G3IMSQnQ1QtOds6zcDukfrc7fR9sxjj/0dSW4hCE1jx74LeI3RxgRVpb4d
	niR6gAHaz9N4rO2ezte1FrEet8ibo2RIoDG09Ot01iB0o9ESsI+aEQA==
X-Gm-Gg: AR+sD13r1O5eEKB08iSTluYGLPOrfkoOeY1s55Kz2jR8tBJV6lyOGE0KmdZaFsyF9M7
	/BLp6C46PjFuLnWQjUjzHAMzoXsDH5rukX625OR4O7bPtPWNiLZlNdFO7F+Jo3r810WJeKC3ZLT
	31ODXtPVLcY50RkXaY+HFUwNb5Vjj32ioWAzJBwg4CUWpsmjvNGJLYZNy4/ouF9Gq68Jjd/AKJ8
	9VB61cpMh62G++yitdelqfElijlCu87Mn6IbiDFBhRwP/zIVNQ7Si62Tmd/ldmuu3GRoeVBIINc
	PDhSFOUfmx8Bpx+cuApk7svjvZ9vA6CmwE3fgWMqw0g0GYbnZyf2dCxrZOZMSlM8hf5yZ7ApiL/
	KmjE1u0/Wk4aSvzR1hl/DgEmiaGscX1i8Lo1AY9gpN9m+gy1QPr4C
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8118225e9.2.1786694314559;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8117435e9.2.1786694314130;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa63sm9164715e9.1.2026.08.14.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:58:33 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Message-ID: <an7KGaKyX_I4B3uQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-2-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:01PM +0800, Jia Jia wrote:
>The device IOTLB is shared by vhost backends, but clearing it requires
>dropping each virtqueue's IOTLB pointer and metadata cache before the
>old table is freed. Add a common helper for this teardown sequence so
>backend-specific feature code only needs to decide when the table must
>be cleared.
>
>The caller must hold the device mutex. The helper does not update
>acked_features; backends continue to update that state in their own
>virtqueue loops.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 25 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 269efad90369..7eaa61d9ceeb 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)
>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;

Should we move the check of `d->iotlb` here? so the callers doesn't need 
to access to an internal details.

Stefano

>+
>+	iotlb = d->iotlb;
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		__vhost_vq_meta_reset(vq);
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

