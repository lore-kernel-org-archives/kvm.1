Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785368;
	b=HJQ8rpvevGA+Vo3I1dA0hyFe966nIgOqCYLsGVweuQsaqY//1HoNooF6RHYOwtmzWOMc
	 bl+Y7GV73IFPCgw+lI7HWAp3AcaBhfXSwOOA1sTWyryn3v9MpdkoZfBIbUpvpsgdKmGjb
	 sf52xvLefcg3zsfw3eFC8wbF+8b6j9Obd82nL6HBz0mo1Y2vdlFPL8+OuyoqzqfX8rGKR
	 YC44KhsdnpTQqceI0pJLd1iMqqyZWDKCMCkRHCvdCm2ZlzD71ZO8BbCS6cNjpGBB4TZzJ
	 k2NxwdcNLKRVBakfwig7s04T125vWMnW/UloaaCDPvA9IylraQ+ZN17FlGjnznvRBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785368;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=FV1Nd4GEHuw3FBCRU+RwMjGE99PLBPBDe37pC1V3alUYUVPk2hs4Vjro8PHa8bKyOiop
	 SSkh3JRIDKbMw9z3zGXqA7W5Medi5fSx4GKK5itIJJzDtX1tOIkhwWveIPdLMLzwioGHT
	 +uL/RtpC2daJGsRE6Cyhzr7Mr05tHDgY/RfeGsqJiyr6na+SNi/DLJCRsMcrMPrwrtza2
	 MRobXbjGqgBPHlNp+NTPzC4+f2oo0gTaAJUUD/Yz/b9cQ550ZItf6CmrXB9NNDZR3A5S3
	 MwHfWnxxYbmdUy6rNxhiRhanmpfSuoW714vpwYk7S1+GzcRceyXWZycbLQXm0d7HJ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VLcMq8w7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5ED606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 09:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5ED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VLcMq8w7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793785367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=aXJafjbT7H4OqzEMgsF1+yzcsgWy5doA494RWx0/MZN6rVyZ627kSbteQzoUbj1LGKZ1ZB
	GyMK1Yyc3d3QNeqs77H49a6hGNntABHrQgH0SIPrcbz4rc2R14r9Un/NhOuTm5cyKMos3I
	84AWRdkaSXPh0VwF0daByu3xyY8UjXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-DIU4YSfrP3WAz8m9LYw3Ew-1; Wed, 04 Nov 2026 04:42:46 -0500
X-MC-Unique: DIU4YSfrP3WAz8m9LYw3Ew-1
X-Mimecast-MFC-AGG-ID: DIU4YSfrP3WAz8m9LYw3Ew_1793785365
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49febef74e3so12100355e9.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793785365; x=1794390165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
        b=VLcMq8w7NjA2seEl+JweYwYbf3dFqMh5ATN+rXrN1ocdvXoR+o9tOUiTCIf1sDgJbe
         0ZLgwNVv+cM4P7T8o/rWL90k7KUO96QvBSkJMsHsSzy+s/QKEx5p05PXiR9E7Hzb02j8
         0cZA7Fx4oe8weJJy6MLMtw46lzRnGNYN8rv86oQZnVVCe1FN/V6Dv6Bdm/W+SLwOfyHs
         6dwvyDNHpBSyPgZM1yyKhaxbzOsMJ34b/A4gqpBqDFYeffHXvEgxLH4IjGeNqHHs6R7/
         JdzxUOJ7bQaIxaRllZtcdFynh/cugCIMqnXB/ZUyCmDN4ujkN+EULfjHwJfardfLm9wp
         QzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785365; x=1794390165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
        b=rszsNaPChg/m2n6A2JQlAtOrPN7A3yikAqCd85MiTjQmC1KiGtmO1ITxZr8uENozaF
         X1Zcmp0iln1XLDtl345b2b6TCiLV6nMUyKeY97Tz2H+Fgzulzdyvj3u6H6dfam7H9oKZ
         iRY04dqztYfLHOaIiSsUWafbLa7C6ahw2GDXNvM6AHeuLfnyxtvZ2brgK9SBRRbRuL57
         MUYxN3VYAVkHQxU+Tr2wR0xXq7Q731EaCmzq5YEZ60Q+reuKVuF923D4bRcAoQNxh/Qc
         AMsm84zp5eo7syFW/DWevVebdvWvsDDU9umHV8ee8RhkbJ0ipJw2DHdnCPCDNso47O5N
         vvhg==
X-Forwarded-Encrypted: i=1; AKwUvBzwNfHGUWFolZxFIK/k4mWC+2W5QlDGxUpHi3PkfTC6lQK3eAyyV1+p/S4+JXQuGpUYGTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nXSaeM/OTSR+pp258EcfvUKTbWu4aCaLb8HmbCRp5JIJCL0Kf
	74Saw87ONSk26CCHio7KiFD3bcCVOpBMjp13Pl2ICEgXh6fum++DWRbboNkqZv6F/Jwlb63bOTp
	gCCqKO17Go7g4EqIkG1+pdO+NML7ih+l+TehjCEp3bTt9HSZzsWomWg==
X-Gm-Gg: AYBFou32zwWFB56PfruyQv9Gtd859LI5x5A2XduJkA37ocBBv6ghE+ooMxwMHtYOgy6
	DXhMkerh2ehlvmqi96kT+aXVT87H04abHIpTa9JV0GkF4lLvKepddWEaml7waQwYmFGcmV/dAp/
	kaonQ6mxRjzHicyzGS4lA3ggv7/0fKuGnUrk4p8lbPpExMgzC+hy6ojxhjexJ3Sb/fblxRJARJt
	j/3kjcr7jbhH8WcECmnpNpVbpYryzgbCncf8c0HPw0YzFx2NTBTfiyOykvjYmOmGkmJB6hVjL4q
	M9rhiBK7nMaPn7AvR+WCBdaEDNeRbE0wR8uiBP+3//dDz+bZwC7zWAe1e9x1rRT/pUfQaETPHCZ
	9VdfpOF4gQ5tfpyV5O7QkiFdjHw2dcQDIbAoBrbnPMdOgWm3zxv+m
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363922265e9.6.1793785364739;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363921935e9.6.1793785364240;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm144133585e9.5.2026.11.04.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:42:43 -0800 (PST)
Date: Wed, 4 Nov 2026 10:42:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <aur96eHKMVO5zMml@sgarzare-redhat>
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

Oooops, I missed this, LGTM, thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

