Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707B34750E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976788; cv=none; b=KWdm7UC2f4pd87HW8UfVtA5AFwkc6IAiZlYFdN7yXQkBypQ4myA0lRcHbDTIiMANw9Ti54bYkxi3QmPmIyG5Lx8sUTa0CtW4y+oGOguk4sGF1r/9wlKVYkAf99LRVhwancw2IuuJ/pBkg8ev1QW3iAvWDUCDt2TtVo0S7sqdjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976788; c=relaxed/simple;
	bh=RRVfVaOkvzElgVyb2yZpLwWWK5VmJ9IAKgLIwU5tDcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7STcEoc1xTo8j8t/8tzFTXcEcQw1NEYsh8mlr+Gt5a/rFr7FC4phlZFIMRmdHBNo/xQsNjjtml9cv8bkh8ajjgdnHF0LIz/DB/YBkmhwEmICeCiAOECkZ4fI4lp4YK5sp35kVbBJ0wgUwLb4QdTZguYk461CCmFe4mObw7CkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEU6+pGh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgS1uo6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEU6+pGh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgS1uo6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
	b=jEU6+pGhCLNhtp37XNNltaRMQaF4OdpaC01Twl8FjNNgUPQU4kdIGxMGVCxYSDdGxtvnl/
	ODaXiJbX74RxRRONZ5hg9nGRN3aB/sex57WD8NIGtrOCuJnlnr1e1yN1hX2YXyFUvVYgMG
	zizwZk5yIXMtD4dvGMIVEzpnRdUKKqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-geQXtHiSM56AUwkVFazDmw-1; Tue, 05 May 2026 06:26:24 -0400
X-MC-Unique: geQXtHiSM56AUwkVFazDmw-1
X-Mimecast-MFC-AGG-ID: geQXtHiSM56AUwkVFazDmw_1777976783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so44259845e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777976783; x=1778581583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
        b=JgS1uo6xmcggPsJkl1C1y+OM04GxvtHWSPbB6lnzgLxjCqCSpm76nTWFbHZoaESpOV
         HNr+BXZTaoTwiHn0vaNOuLHjHb2btdmeXJeO3y90t9ACagZ/Z31RfmoV7p4Fl0uA8wDh
         poj2G1bDUHsGduk1kYHLkxkbfTq7yzodDHTSPxmlEdKOc1JmNeb9Caq7F7Ml7wuGEoFr
         kMPYIFl0sG3G2+AIVhjzyG2kag28zrrgT60gLOKSJkLy0LbzeftrJUx8EQQn3I7dKF5Y
         3px8Eoc90Ww4IMNqYwABYnNN+MjsPo89EptF9eDPyvI0XHlBab17RfAKMUt4JwPI7pcl
         3lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976783; x=1778581583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
        b=eD9kwIWpJA9NNp5ulYKJE6uINowChgdljpo5i9Mf2prwhn1Axq3AozCEGBPZ1tyPXY
         Or/E5miomOnrv6e8vmH20ex26fwc/wdbdjV0zjmD857bmZJJIvy5XN15SMkvvHbv05qd
         SHOInhmEcTPr3UqWDO3awfwUCrF1NsIVkMmWRcjtpsLkRXnTSh6al9Fq5xnB4FWPVjDL
         Fzofh70V4nkdCjqFC4EiQFgsQEHk+9VqX5CycIfJ0m5Q/nQ7e5k7opm0n1/r5NclMhPn
         aJ+U86zFL2ptgvbrJB7rfB+5PqAGhclEFO1ZL6wbP8Y6195/0iP13tQT5UsMG0ECk+Ej
         N9hw==
X-Forwarded-Encrypted: i=1; AFNElJ/2dYwsrZFIxPfHjUlAqa2RicYYoPoGRVRiAWxaYyepsYmlhLg+ag8zOi3ZFcwN88yByps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVMlXSCklKyQNivqCb/DO4ZpVggVp1pbzrjkoQycVGO8XYEvt
	GPzBfhJnyHkGtEy6dI58NcHVkpmtWF4D9WIjiTwVcNadYAQZLA7jlgjof4hPBa1ExB79sGg2X+/
	HtAygE2aCpfxTWm1NJ44Ou/1wsqgDMFuVLg1MrNQWNBe6KXXTx/u2Sg==
X-Gm-Gg: AeBDiesbVown8rVhTxFDLYHhqo5FdZlRUOs16z/QBMmbItTlM9Q2GpGGRcucZCHqbex
	6lvuN0xWJtla9Po1CHCdb7YGT2D4dDnGSIbVmBtN+eKmP8pMVFTeoGaxbhel7b6SM/gThN5PffU
	uBauXy8ZSOlZgTHcBZWA4keOgMmgJq8FeMBWVW52iowAkDHk76Ba50mqpOV/ltscEoK6bMKd8X1
	fh6PhR46Stx3QdBhGxYYFsWGXWkZYkxBjW9Xe0kKZAQ2s9Yj5I/ZHVPw3sUzKczGDJiUHUy9Qg0
	aERq36WHF/19+XvgjzWqxX0s/B+YQSSXpgQRCbo0YXxM8wi8eUS4dPRMLZN1uYwOIwkNIHP4Q1M
	KLfgSi0r3gDJO6StYc1JiTCkRcAhOUuCYIqLH10YMX6bT9paVFkBoKnDniVPqQjTe6pA=
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48869335e9.10.1777976783418;
        Tue, 05 May 2026 03:26:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48868885e9.10.1777976782990;
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17714dc8sm28079685e9.4.2026.05.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Message-ID: <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
Date: Tue, 5 May 2026 12:26:21 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
To: sgarzare@redhat.com, stefanha@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 9:11 AM, Yiqi Sun wrote:
> vsockmon mirrors packets through virtio_transport_build_skb(), which
> builds a new skb and copies the payload into it. For non-linear skbs,
> this goes through virtio_transport_copy_nonlinear_skb().
> 
> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> As a result, skb_copy_datagram_iter() sees zero writable bytes
> in the destination iterator and copies no payload data.
> 
> This becomes an info leak because virtio_transport_build_skb() has
> already reserved payload_len bytes in the new skb with skb_put(). The
> skb is then returned to the tap path with that payload area still
> uninitialized, so userspace reading from a vsockmon device can observe
> heap contents and potentially kernel address.
> 
> Fix it by initializing iov_iter.count to the number of bytes to copy.
> 
> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 416d533f493d..6b26ee57ccab 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>  	iov_iter.nr_segs = 1;
>  
>  	to_copy = min_t(size_t, len, skb->len);
> -
> +	iov_iter.count = to_copy;
>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>  			       &iov_iter, to_copy);

@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
pre-existing issue you should probably want to address:

>  	to_copy = min_t(size_t, len, skb->len);
Does this length calculation account for the offset when a packet is
split across multiple transmissions?
If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
but to_copy still evaluates to the full length of the skb.

/P

