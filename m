Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787105;
	b=a0zfPmVUwuBHUgR3HM7pfv20avJSFuRWPxvdR0evLCBwyGeytUbHgMAhZUURPPlYTbXb
	 80M18ZtG9VOcBdjL0WHoVQ7BSWlc4UQxIT77wkNA6y78EfGaNL0Qfq79SZ5y/tRuqOFLD
	 uRywRC3OZgB+FXKkbLDRmmW+Vl+9CJR9oCOAPP7Cedw3baguznRuVgyBvCoQdqqKZ0h7H
	 7+zYx2cYxwqDEQH6YR2+k5JNyqlRsBJBk6Q8PniXVWnwY/4MlBztLP93Qbe0I8HTJJJxY
	 8+njCTgFhBY83b7p2OEXoWH1SluFnmGCYzDxQtuRjSEYRLBB8BN7PFvW6GLUfud5ULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787105;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=IgcqjjcAm4ghUcSVq0SC4FrbU8rrvar57kkq/83Kws6otZfweOSGEuYfRgzY6SEnbua1
	 0Pro8lmaMX8nNl5vaqlVvSWjmuV8zgzQUC4Jn7eDEJbhZGSoNpV/mcAB1M7DrKNdZvDuH
	 7ywwuNZakKrOPNGDVXWw2Z7giPE6UUihltcrHU4yQKyW3guXpcFRR7xhg4cgvLkKMlTH6
	 dZ4wYvIPTQuVCIqB6pjPQYMXSNVkK8lKNd+70+7nGse7cx+8EqENJj/R7VRF0bJJr1568
	 W1Pa/isPsmPS+RJfqVz8AFoB/A/8P4X3H6mhIOCMUTBHIL/aH27mrD8pkPuBJoCEIzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMxfqLM1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ARyq2B07;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A00606A33B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A00606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMxfqLM1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ARyq2B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793787103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=DMxfqLM1OeoinGXprJ4HKCTd++PcuBPZWZik4x95OGCsh5ZTxRNvan5Ax4pNW8mQJ0/SFw
	8QKcXgWirxT3tkLcWDgr7sHgF3UGfpsAUrrPmKDeMD8F4LXYFzI/1ViJiy6Ea5Pcm1WJcr
	SlXF6BKC3cS5VZEPE/hjB5i//4X852E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-s9MbhO6pOQOqwkouniWK2Q-1; Wed, 04 Nov 2026 05:11:40 -0500
X-MC-Unique: s9MbhO6pOQOqwkouniWK2Q-1
X-Mimecast-MFC-AGG-ID: s9MbhO6pOQOqwkouniWK2Q_1793787099
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso408202f8f.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 02:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793787099; x=1794391899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
        b=ARyq2B07sVI7UWCqJLjDG1Fp1kBBO4hBUEDYM4VF8wi8wMoxVhe6Xce3O8RbTxTfSw
         q0tbzawMnnFgBiU8Q4dH/fYgRcW+JvMoV4cu42sBPD/tG4RWsCdfPJq+pMW7Re0fmL/H
         LygfXBpaD51nJcQYMEDgDSSRaDBAlKS/LeLyW/fJyaZsbuQwkK1+4q0ah6suDgpKQxLX
         ri2RxFrsy3XT9m353pX5ryFJbhXy4rrFjPxpTecnHNWmqIlsU3L8OMR/XF8uS1iSvImg
         sd4xl43WuKeLrorp6Uw+d4bPKaurhdPn9Kdqn5ykbydQBABgyCOrsv/LBbDhUGqQE8s8
         4szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787099; x=1794391899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
        b=eCh2RdNUHQJV/g/BtEHiEKQ/l9OrWnzbYQMnkQdUyfMYSnYoNT3KRnGN7aPT8iTsvc
         aPN8MV4oy3EhDY4eb/gxNAmT2Xzn9Bf8qnsxXkELxwuJ3IWjB1gt4wTp/J800Q8UyZdG
         u4RhY76iNAm0suIZe6ukVKxGvlc3diqEnDzElh7d8gcd7rR9DAdkeBmOmI0xozCdRa1l
         8budLlcn+oPO/v6jbWFMnDz4OCNIXlvTKgDNtG2P2UF5/h7gh4kSPIpYRM4ayUTSB2Xb
         /DOWhwLrQ292R2APxL1sdfPC/UvrU9kOKMPq+V9ZAplhfWwdyzKnLhTXlsCwBHirrdcC
         dLHQ==
X-Forwarded-Encrypted: i=1; AKwUvByvgHs4hZVZgoS40zdo/ttu6/zevgXoaheAOqgZXNpHdyjTZdFQLHMYVWt2/njwLpTkYOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j0bfobzLjstaKceWbk8LzIrUsYjvbarxVl+99Bqhf1yFojBsP
	3s+eCra2FB8YztGfWV7qP2Y6zQxUvhhx5bwe6In8i5BKzI68LvQW4ngfIaijay6TkW2WawL/Je7
	2jBsHNrRDxoZvPSnnokG0QyLjiChnnYTO7vbdwPzOIoiZHG/hJIPF5Q==
X-Gm-Gg: AYBFou1LPfH071oMrV7AOQ47i4ZgdRkgYLW6uJsQbSsoLRMmYKMvQKv+GX/kkP5XeAL
	YGYSDTqlXG7YGuReZ1gWhugX5J9vxCth6WKJu286CIgcZpER7vUiODONJldfVGaLVEjWt6dLT/c
	kKZMY7cDsHwVLgvt7j6MvSTfrfccO2hP2dlLjpiCJGRKr6/+k6j8WnW/JvXfR0ACh8PwOopw16k
	ul8a0gMFpRqgo3h/N+RP8GfOktCenENDuc6iK1GFRYN5B81UM+okFyktDIdjxGs6Ne3+ZlV36H3
	JNQJZ/QLn6zNcaDB2CjpYReB83VbO7qjBAX4CVDchDIl4F1WBvqORMYB8oFDntBctgbqTWAx7pq
	/i7HpzhUAcbY0Jnvz8h9KHlMf25bu0ApwwNPKBA36d5yHVd9W4ciz
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250726f8f.15.1793787099113;
        Wed, 04 Nov 2026 02:11:39 -0800 (PST)
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250672f8f.15.1793787098615;
        Wed, 04 Nov 2026 02:11:38 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm3214680f8f.6.2026.11.04.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:11:37 -0800 (PST)
Date: Wed, 4 Nov 2026 11:11:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <ausD3NBfYVn-n5ra@sgarzare-redhat>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
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
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>

On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>guest controls the descriptor length and hdr->len independently.
>
>A guest can therefore provide a 64 KiB descriptor while declaring a zero
>payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>remain unchanged, and only the fixed queue-entry budget limits retention.
>This is not a lifetime leak: the skb is freed when dequeued or at socket
>teardown.  Repeating this across connections can nevertheless exhaust host
>memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>a 262,144-byte receive buffer; a full-payload control retained 265,984
>bytes.
>
>Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>from the descriptor length, introducing the allocation-accounting mismatch.
>
>Copy the header into a stack object and validate hdr->len before allocating
>the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>capacity no longer determines queued memory.  Check payload_len against
>len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---

@net maintainers, please can you queue this?

I just reviewed since I missed this. I also had a quick chat with 
Michael and he didn't queue because this was marked as "net", so let us 
know if you want Michael to queue this.

Thanks,
Stefano

