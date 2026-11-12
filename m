Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502970;
	b=UmCw1WWqP/PKwHeF2kjYxDeHFfos0vS7T8VcI9UuDPu3oMooq/BBmshCo7aveoMEyjGl
	 8hEm9B9pitq01iA7T7qZAXwRAGKsvRIkiBm+D5yCZ6vUzSv8eVMh+IxFiX4cPx04yOOxE
	 YdW8tJ5/VisEvOHBxy2vzI+721Vhq3olX6F+Qoe2B+ewdABeBQOc6oOIXlXZW7ftp2Kvr
	 u67xno0tKfhTOH7NJ8p4f6gWyfEmCFMjU5nTpLjiVVu25UBMecesYvtIzalVpZ+emtUnT
	 462nS/ACqnGBxRddzCWle9vwawSJxGIHyzbTYvParEmOO4FNKR/1o7Kz40UjHSupQnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502970;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=IA6oYRkmWWyC1Jc3Za/FJAtCr3RgOPDmKWzesZbDZArbGBQ/P0ovS5uOxMmlF4n6j+Mi
	 Sq+3doQaLxDD+Bzkfj3I3piZqYiJ4yZdv02oCHmZWMZUD6umMMR3gAF6C5bbphuQl59Wh
	 JPKySVtskKO4lDs5rtvTFMfVsQ2f5/UB91VCvjxj7b7xNJVtBwF6S4qRCKq5n7UevFtD7
	 +MPrl5DVAx0oW6g6UsPW0nEtKQZWBLDCAXCMwbkRNUxbsLRUyuS1x7FvCrNYwv8RqfxJR
	 JUXf4bmbrTwSaWK1RGI7xg70YpAIVZCDDyrWPhcOq9AIC2SexB9QfD+afsbbLjvUXuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBA606A323
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DBA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=UQ3lHNAjeOXsmCES4hWjxHOYer6q8c+25QErNO+A2n1KnP5/5APW2ESjNvPWYQc56JgQEN
	MZGJmmOZMVt05+xi0OZ8C8iW+paIyNhLJDRnWxxOJm0h/+h2YbWmcNVg9v9IkOfsSl1Fnb
	kudmPfuvFpNzGevPcZUjA7CKnZWu05k=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-7UOuvfJGPICFRh8weA4sRA-1; Thu, 12 Nov 2026 12:02:46 -0500
X-MC-Unique: 7UOuvfJGPICFRh8weA4sRA-1
X-Mimecast-MFC-AGG-ID: 7UOuvfJGPICFRh8weA4sRA_1794502966
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-70eadc5b37fso3610629eaf.3
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502966; x=1795107766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=Fq7YFxuew4y7VYWcjll5e78rzl8lIIgzpNXpaYN/Q8NWnVIoAajywtbu6NvnCpqxUW
         +1IAiKP12pJlcr+LGTE6q7iwkNzffOFimZkthIQn5OnHflCcBpuOIU4F2vmUVcgEigUo
         XuvFw8xYfhpop8HoWiKm3c498ITO9JXm68E4K22WtAijG3eEqrT4s0Z2oJMcj3QxRKV1
         JPbF2XywvRdd+B1f0ik6ycufeWJuRVIF8Xa2OS9nDUvAIJhq8q6xdaL3vBluXbncjohj
         GrWaYnh80smBPTcYIj4VqyDEw+RsqxujDxB13NBxbkVpU7nsfJToThSwbqKFLRBVEKK9
         gjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502966; x=1795107766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=pfnxJhQPFzemK0PZHKwj0g2/4HtM24m2hHrTP2ZlqN1jq6rukLhBHci2+UbNXPgXk+
         sSKqg/XGm8qWvcS4Dk1SBB5fOW6vPXeMQ43OgC5Wi0XCcz2SV3rkyJTGZWa22pqzp2QF
         Rdn7KA0zY9CHWDjqL7N1HNvI3iKZx9xZ7RX1xQLtm3PE9zPWofSUpVd5lTKGfXFdCsBW
         jBcB9mwXC1Jm9HmZkVIJ+WiQ0j0wuyUOFMawrfAKHoSRsJZ16Ry64KO5BBsI8ruYkMa6
         2MPGwXN347bNxBcRGbL9u9MNG85WnWZVFZJAiFQenk2e5zN2ZDmVYJaKKr7hsaVqktU9
         xkCw==
X-Forwarded-Encrypted: i=1; AL+hErFw07d8saz1hnK0rPGHi1hef+oPbKP4X6Ts1V8X52JDIoKT1RckDDeJfjCTIsmjZlW3KDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iJqJlghMjapw8O1i2p6gntlaXLBJK28gbNkBg7mgduHoUmiAk
	LwdUVsSwKtfeeA4jok/VM7oh5qwOidNwE7tgJOKhT75dpEmNLdV+4bcwDLU/pL+Llkb2LEG9MEA
	ueqcnzwxiWnlkNjlJqzCcr8r5kZotzo1WUqAWUIeilOuwDsI/PL64yA==
X-Gm-Gg: AYBFou0e9+kKinVjMYqdynAWwzXpvamPyabLjHX134Y34IGxI/Cqy8MuOnCC9pUOop5
	nI7WnFYidMMi1I1XNz6Cz2ck6HHQijx6voqo5v+tkkNp/goPQnaHyTTFFzRSkwtX6gGABEf/mOj
	qdf5PUg+gzbYdrUM7pDDHHwQLEwIPnb3BI886gVbDRO4RwKzw+n/O4nLbVj3jBDHrJLLlU/HLWr
	evjXlsansbYXeK87RwDkBa09CBuwJGh9RdP4rMPPu48z8lwWurBnWdg3TlL6ZWuCKERRoUqMa1l
	nXmq3kycoYjvbtMpMrcyz0IKqyozQrZsspZ4GSAxZP0YJCZ5FC8ccJlaI2Y44QPA9sgk90LTqe8
	6BO5ROlHAEGSJbe4LWJ4+8oDSLydiA/T8Ewp5nbXHJwrff6H/wpFB
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797268eaf.73.1794502965970;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797227eaf.73.1794502965373;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm5433524fac.6.2026.11.12.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:02:44 -0800 (PST)
Date: Thu, 12 Nov 2026 18:02:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <avXxFnqVLMgBMjBP@sgarzare-redhat>
References: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>

On Mon, Nov 09, 2026 at 08:39:24PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: the detach
>loops would pass NULL to virtqueue_detach_unused_buf(), and a second
>del_vqs() would free virtio-mmio's IRQ again, which only WARNs in
>free_irq() ("Trying to free already-free IRQ").
>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>and virtio-mmio by failing the restore with failslab, without other
>kernel changes; the virtio-mmio WARN was found by the netdev Sashiko
>review and reproduced with v1 of this patch. With this patch neither
>report appears on virtio-pci or virtio-mmio guests, and the vsock
>vmtest.sh single-VM tests pass. A find_vqs() failure after some
>virtqueues were set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v4:
>- Say why the early return is needed: the detach loops would pass NULL
>  to virtqueue_detach_unused_buf() (answering Stefano).
>- Say in the message and the comment that freeing virtio-mmio's IRQ
>  again only WARNs (Stefano).
>- Move the send queue purge before virtio_reset_device() (Stefano).
>- Message: the use-after-free also reproduces on virtio-mmio.
>- Rebase onto current net; rebuilt and retested on virtio-pci and
>  virtio-mmio, and the vmtest.sh single-VM tests rerun on this version.
>  The moved purge ran with an empty send queue only; the ns_* tests of
>  vmtest.sh were not run (they need root on the host). The reproducers
>  are available on request.
>- Link to v3: https://patch.msgid.link/20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

