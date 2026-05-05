Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779347DD76
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989122; cv=none; b=WkmLjhsRLtEAczFfkdTFaXI14U2kDrd93BmpwGOa9oA40pMaSH2k+1qKQrI7mmAsa30qCRPI2QpmESqc4AM4rFWngg4GWF6vkfCAJp4TYYy66hFCDi3VIiwhIN85myaqMh6oy7hWj/k11PY04U/YWhF+2a6YUzhR/cCCNeiDML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989122; c=relaxed/simple;
	bh=FYwyJcUh1yGE5As2Q/7Ku6QHLAJWBWFMlQ45xYvu8B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpH+utKOxkeyMe+qrgUk+1VbB4jF4IOLFkXsVL3x1FTN56CDVt7CvjvV/fG70kJEkK16skVbGULCfvOSWbOhAiiKsUzOn1ooGX0sFruDtG0Tiht3mxKI6UNmBzVKct1FaoX4iP4IEgK6N1sc6AQlFdCZ2BEX+rr7X+2No515Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce+Jvckf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9kJ6hfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce+Jvckf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9kJ6hfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777989119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
	b=ce+JvckfeVDypvea8PrEAdlSCop5kAu1KFxR0PacpX3nCjjys1wLNRs7sc2IJFIzN5Pm6D
	MSEx5ae2TdCpdPlffDdI+7CiZEdCuKjZYUARjEK5Zyu1m6TS6nx2HcDgveZl/U4xSP8WK0
	ipTdGh1qrusUkIWflterRhniPejKLdg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-5jtZT88BPkqEQuRHtdAizA-1; Tue, 05 May 2026 09:51:58 -0400
X-MC-Unique: 5jtZT88BPkqEQuRHtdAizA-1
X-Mimecast-MFC-AGG-ID: 5jtZT88BPkqEQuRHtdAizA_1777989118
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43fe791a398so4749622f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777989117; x=1778593917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
        b=N9kJ6hfeziR9L54uFCw1qd68Fb6j26vTNLiIhyLG62rdVROFavQYgE7uvYSBZz4FEu
         bfxy1VPy0YOhPhuGffpSdvLhJyuj894vNYzTOF9NDNGtGcDJ1Jq85hzZEdXwQgmVnFCg
         f4wo+MFMzmy56717skPLH79f3rgk4Kene6eyJgPFr/skVScqZJVJyxi0PlY2LapWgzD8
         OW8A50mm5QTHZgGXkyvJufOicZAmq1ldPi2QahUZhGwcWvhZDhGpK9gXlqXmnUgS5hIP
         X47mpzEM8zFiDcn6PXYrmtlonkjnexKfQ72uk2lsgMYgPntbj0Cz4uDH6jWyF3rxl+P+
         67Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989117; x=1778593917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
        b=ouEKluiGUI1XGlWK/MUvmVjJF5d6Hc6AkzTei6LKI9eKyKmmjCo3KK1x/6nmiS0Qjz
         iy5hDhiWsEGNF67LXsOKgAbmBrbObMJeAUZLnx98Z9ZT3zxdXJXJLls2t+wSuo7Lxzp9
         DwziIHN84U+yKkjBPisHt+V/3ovpJAiGHM9NqXFhuhYbWHYuTtn0U532uRBRoPSRSvRy
         GKPuH70ZmWMV6igzRvG7fmQVAlmWugG15HLiIEdw/TbhVTFMlCasAclo2GNQ4QD27VFC
         bodOFOR6Tb5yH56Q8r8VRb6o8WvISFlTi9KNz7tCVCrdqN28W74CD4ANof9kgNX3/l++
         jUJA==
X-Forwarded-Encrypted: i=1; AFNElJ+jkIopXi//lQtxZ/JbFB0jT8mCC2oDtNbDB/7UnG8BBGOlKgVuMlffp8jfk8ymzBuTy0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0WjMdVSl1uWyse9fRBS1pcUcvaWPYZM94RMQOfGry86PsaI1
	avb+C0hAqCI+xvl/0TUxs9KwdXpgiS8XqFYNv46PuokVrMwZh8Ec99EKvBFlMy7HetRSWqO3jgc
	bfg+l/kJDCn1HKKeZQLl4iHyQoquVZvnrbbAMZsWHFHkGVMzTO4eY8fWv9Ww+Zg==
X-Gm-Gg: AeBDieu80ZDNlRY62w0VTGGFqrTe/AGKRNPqEs9n0YmKU2WP2UXGcudAPqJaPmazWgr
	NZVjK0+766VFqr0yzpn61aJpqZ9OQvQDIvW0A4eBOX2mIx0v50XPlyTxBROJ/B3Cvt+SBoxMxtu
	OgwPhI3Ix2h424E1KIDZj0Ln2fp/juNV0+WXdLG3Xsv+juN0lBjYnnRue7UnwQXjPdvn1AbF1UC
	0VafKNbldN/qRszVqFADaRbSDm5e/whMcJCNgFXGE91abi7qoRVVE74s7In5T4fFHdNPRvo3S2E
	GFa5l25Pay07rlTtgyb34e+OBMw8GCbhiNBnk7N7fmszlcs8rxk//GaFLqyjA0VAy3f7+MSALhU
	u4mk6kjOulioUJfq218LiNuDw2oxpzCsWZ3v20Q1BiVdX5cGzI+Pa+ZRsPC4UksWRBgy44OQRfA
	==
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938871f8f.24.1777989117058;
        Tue, 05 May 2026 06:51:57 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938787f8f.24.1777989116454;
        Tue, 05 May 2026 06:51:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2487dsm4641869f8f.35.2026.05.05.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:51:55 -0700 (PDT)
Date: Tue, 5 May 2026 15:51:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afn0ZdvZWswBuDMm@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430122653.554058-1-edumazet@google.com>

On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: "Eugenio Pérez" <eperezma@redhat.com>
>Cc: kvm@vger.kernel.org
>Cc: virtualization@lists.linux.dev
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->buf_used + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> 		return false;

I'm not sure about this fix, I mean that maybe this is incomplete.
In virtio-vsock, there is a credit mechanism between the two peers:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003

This takes only the payload into account, so it’s true that this problem 
exists; however, perhaps we should also inform the other peer of a lower 
credit balance, otherwise the other peer will believe it has much more 
credit than it actually does, send a large payload, and then the packet 
will be discarded and the data lost (there are no retransmissions, 
etc.).

Thanks,
Stefano

