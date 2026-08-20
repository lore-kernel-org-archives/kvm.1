Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B03D8916
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217201; cv=none; b=OhVx/iP+pWCphlrjeHX4w8uCtrSg5IUkaEZoAzhDKWZfYO1OFxInDDAYrOX/lRJqCdL0+D2xMnBpzynIwhJHZ3ggGWfgqfZzx4ugG0Ooh8BIP2t5eeDzuPAhYpP+anHuzRYS/ys7o2hm21ji7GIU1ODvfsjOAFRzuybYBq2QtGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217201; c=relaxed/simple;
	bh=hPrJc7tLhkydvuvGvf8xRiI2Fvb0aBBPRteZTc4WY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr2R6FjUmwCoGI0xzK64CUNF+EwOW1RzJhWCwT9ONGwM9YwueHSWPKXKMMpF7la0Ykij+HdNlv1U0l0/fLIl0D8n5X2W52dKOA1zTTSvYv9sLL4XihelZPHR0qEWvgjgFiazCLRid0xaItj/yu5ncTVgRYl9YQU+22gQu3TWVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGE/vZTp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N59eC3mC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGE/vZTp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N59eC3mC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
	b=QGE/vZTpNy9ze6qD4UHE0CSVAytNORTnHK5CItipGYYG7H6snHrBtnbtJYPB5w0Rk6IXB+
	tE2MZ+gLXBIA/gsIMo0MVv6EDVv3iNdYFU4Hb6ec2O8s6x/l7Ap3/wc7oCqQBwqV2Nf4pf
	OGh57LaynZlPmZHjphgGIhEDDeEHJJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-aZGE4f4IOTKNp3YHwOVDwg-1; Thu, 20 Aug 2026 05:13:16 -0400
X-MC-Unique: aZGE4f4IOTKNp3YHwOVDwg-1
X-Mimecast-MFC-AGG-ID: aZGE4f4IOTKNp3YHwOVDwg_1787217195
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso20830665e9.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217195; x=1787821995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
        b=N59eC3mCXAMklYF9sZ4EJKksVRbp7AFM8jX118dP49W+Ub8CQNg2d3HeJy5MdUlJ40
         h4Jpjo2XY5JS8ccSaI6qYO9qS6oMdfzqj9js+WRC+iC7W2fw77LMDtB7JZ5o7zBbL7EF
         I+db5Oc0KHyyLK7jrYw3ilCeABIV1+MjvQ0Y10PEGQbut1BkJVUEupAFj/pI0TBtn5yl
         hLyS3vKWtOxHjYc1ddLsC69knx3NNWq84p9GelJFiGHux0IH+wqWsctmDsAjcTP8CLYI
         bryeYJP5iW4oQZvuAk3CFvnRYAx3aJPPDY955xzMGC6y7aqE+DKMiWcKQ8Kqre6pSPsD
         kXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217195; x=1787821995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
        b=lKQZPSglamEAu90mnyEAZdFk1P5vybrbnmp+rh6/tUzQ0NRQphOvalDo1LyXhQ6gJZ
         FCdArhs6AIYILo8MgDVzRhP6YCC8jBRW+zhLkgJTn7sVQ5piBvdFeJbryKT0jy1EDmSW
         y4kUMz5J83yNFsqk6MMrKnggq6DBVRIsDkjc027WW1W+Z5Oaejp11d7/fcyBL7nRtaZT
         Csx9KqJRyBE5XaGo7twGuKYjX6dF3LzA7uwqZT/fqqc91u5a9LCnK1h4uZmQgLcOvbmu
         inwji+E8Aez/oDg3MpKLRB//PuahtRW+p4NdoT+xL4JqRho/YRQ/kAfsSxWg6363rmt8
         bpXQ==
X-Forwarded-Encrypted: i=1; AHgh+Roce3hGt0BhdcoEe4E5yTLI6BRtfhImYO5HmRNYGZ7QAZJiyrRM3Cuiadyfkk2kldaQO10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFWKLE1DK1P0J8uYk+/ArEh6GuH/JNOZD1NETQ747XN2Clz4d
	kFEWEyoycbq0GwhMVtnWAcIICbHy7fKveH7oYu6rgw118pyS6r3Ah51o4vB6nqAi7mhbKWQwWxt
	b4TBJwEMbmynq5V9NkBwoiq6LH7aXIoM+krqQombzkNdOy8pV4qzHvQ==
X-Gm-Gg: AR+sD11IyyF+nf7MKKAnVcyzwjufdKxjAdHFFMJO+IYQEhCpVgQDzxhENOie6c6sB9d
	gguHowuR5GB4IzKGsD5bsNpyy8cSzS+7KGWZJ2T9oQ/mqOX0k1VA4hBfNgdMzlsqNMqz2sN1rzw
	bqLCpJAPcFQrr84Pvu71B4j/IeqWhCIdkoRoE3o7P1O5r1zM4AQzAL+NeU+YRGNGzo4cHHUIqbl
	eiVaw2gaiK1MjsgHLogeQtFTwnbYUubC4Pcba1vSSUESl9k3Q/1gCYKB3fzMfdSuqxtrWDlybs0
	NT74ya6yP1PqT4g4lnWTYLXRyt5CncIZDLVDcmdJqW5O1EN37N0qYtCYkPO2Tz2bBRVTxb2zfFK
	Q0Rd9S1J5KYfxkkev8f4fPZaRvgTQjYit4IQecJis1oLJ1B57sYUR
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209390575e9.10.1787217195305;
        Thu, 20 Aug 2026 02:13:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209389755e9.10.1787217194814;
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd7a9sm164548055e9.2.2026.08.20.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:13:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <aobEwtvZ2WELwX15@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820080332.313933-3-physicalmtea@gmail.com>

On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
>Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
>Otherwise descriptor translation can continue to use mappings installed
>before the feature change.
>
>The common helper invalidates cached vring access and applies the
>transition even while a backend is attached. The backend remains attached,
>but userspace must configure the vring addresses for the new address mode
>after a successful live transition.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..e1e9d002d6ae 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {

Unrelated change...

I think I've already pointed something like this in previous versions: 
for a patch that fixes a specific issue, these unrelated changes should 
be avoided. Please keep this in mind.

Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
>+	} else {
>+		vhost_clear_device_iotlb(&vsock->dev);
> 	}
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>-- 
>2.34.1
>

