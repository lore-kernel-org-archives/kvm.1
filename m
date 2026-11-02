Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640613;
	b=5UeaaiP+7NyzTSGQK5Hj8IZ+XpdFwmndMkVbNRUIjHVrJVU3V8IG977VerbQwXgP9xw5
	 +ZWoBXyC92jsKlcu6Dniz2GL9IaZwkIyd90xSC2RFuz2HqGCYNVCCH21cjPkyLEU5Kmxt
	 Ztm5eQj9LNf0kuJnskFMOpoXu9mkYSYhj6nYSysPhbEAucXmQfGazngwRnCR323JiMd9W
	 /DMcsI8c9Y+BpJiT/uL3rDu4RXO49EXYXghQjowgSrCHwGedTTelSdiKr+vb+tlCklV+P
	 wcaDibDSsPhV9QOGR0EDsBP+z5akKECni8NatIbj0bZB8J7eHXow7jUFgL5WI2EK1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640613;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=slcZ2Ts67rhM0Ua4tuD+5dK0jKr8cTcxhQZIXfQdRCvQoNdgmtrpLjueySTZXzhQPAF/
	 jbH4I2EFJ1FOia+m95MeEMKNiTMaFy+nskuWuAJxwrIU1/PhrRVvJSDacTg4u4oyQYXp1
	 Ts/AdmRct8EcxDRnw0Fs3eyxXy9ZPH1pb07X2aWqJGYv6ZWNBDoYdIa0Da6JZ8w3/wr4C
	 8Ft616HH3JvuMIlhMk5VVH+rAm/56G5ItpPQo9CqoS/kz3korp9RU4MyejrLuc5NXbNUo
	 av7/TqpHAFob/VH1GUbObRpyoS40lJqgqnOsrrRRnzsy01jAipPUfir10NoqMuW3CEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="D7OX9rf/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D36606E026
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D36606E026
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7OX9rf/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=D7OX9rf//5YzUCNe5WHvsdWYy4QUBKI9EewIG2bPgMolg1hblOBpsfReBWKvdO+2LfXnlM
	BelE1qsCNjMEYLRLNqoieGQ0EB+Pmyb404uGRoawTQ1FoBUAIrNnsozudssRT3MFwj8fMJ
	bv5qEKgJp3E9ksdZ7eDMHQSu3xYZsH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-QNmJbN7SN_Wh86jZ1rjQ-Q-1; Mon, 02 Nov 2026 12:30:10 -0500
X-MC-Unique: QNmJbN7SN_Wh86jZ1rjQ-Q-1
X-Mimecast-MFC-AGG-ID: QNmJbN7SN_Wh86jZ1rjQ-Q_1793640609
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2944281f8f.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793640609; x=1794245409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=O4pI9YlU92DDxrrSy6abElpco/qX3degbuogWx2SVyZyGnQ8Ljm8FwI4vtxoPyfDyC
         rhCe1JAnalublysmvZ6emIRr4ywccBIFc/TvwrdeH/FMuISwOSIg5cHb6MSYJ7MzZu0y
         yFsgAi16SjhXDtpLRy7vETL/sUyNwc/N2NMNodNJ1l9y/dGEvLTF4VA2p5XJdmE7+kzQ
         kEebFLK9C9ODAhgFXrTA1Gqx4IU7k9Bj9P3/jQPyW7Kmze2YxH2EFHVfP2KGGOCElP4M
         G9zeKnZ7EUvP59V4zJiHeV/v/BkOMR99FE1/Bjog31DElcdlOg1M5UQSgwPTzPtD52Vm
         ZixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640609; x=1794245409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=T7G6479ed56GR3VXV8R5eEa2HQmX4DQTbGYcPGrS5vBR2PXKsjoH6qmsYs8mUCmaTe
         qRqWR1EMFd8Sbl87ZAsba216za4Nxgb7W4iYt2gO+GfbJLZtrOqdqiqJ/HDLLNRszM+j
         Qf8PHkj9+R+KaaE92CVdmL5HQW/vsQaM7BGa4qHIVL3IxZuTKN0ngIt0R96EGnaIpHi0
         DViuxcG4qAqOJ2xx0fSC4VW3ZvjvMyXff9ndD6xaK04sU+mpzdanPlMNuiU5GIbI2aUv
         kPvr4N/E7V47iet77ZI84BH9Pb0fl4IeczI47bv5xvIcGzMTH8gJP9i0gCVLUu0V7Lcg
         YBJw==
X-Forwarded-Encrypted: i=1; AKwUvBwWrAw8MQl12gdGb9GR8e/Dlf76Go0WKfrcagi/QD0fxgPbpxWn6Ti6XxiH/2T9KRfkvdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhpQAIBOtSDSnuv2x1so6rqE/5NNhUu1Cvz/FHBlSmOLifwlSH
	cDpQ0n2uhyjfFAlnGTTNdUWJdwCYTHeqkADDg4qY/zuA3K8VmW+9O7N++sPC7yhWiaY9VJ4Diey
	NsND0+i3dZUy6NrXM/C736QPYOiF0bpwn4e1KWdKzwXwstBmO4yw4tw==
X-Gm-Gg: AYBFou1gjNW7f9VkCsi1m+eM0LuycI5MwB9c/GIw0FPCqhka+llcv2UYczPtws4Y0hH
	eJJclHi1euRONjHJ07o7YQyVhoMyGtuVRwfkCei1TdFkcUwfj+TH4xpCO8BABA1YlZji+B/fYw8
	sWUb4Gu0JxqVtCBy7EgAoVp3rlA4negllvp40Ypw8RxkH2HBkl5qVrj5QlIf5WcE0tMcNEMZ0l3
	2cRKqeAA4+RqhAsQnXQuE6XUxKKgnFUP1FkOxp2IrUKch07SbCX0aptU5slQ+jmUFDEdQchUIKc
	AnTUYbRJdw6d0FVmWJAewaAxs861zyDj+BTo9MYQ45QLkPZC4p2OKugyWtntvDh6wck1Ajdw2GM
	OtlSGYUED2nBFX/3/tlYr7JaSUy8gtW+FEww0xYIRxw==
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165297225e9.1.1793640608968;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165296615e9.1.1793640608457;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60ca0sm1461205e9.7.2026.11.02.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:30:07 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261021070242.75009-1-fangxy@xiaopeng.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021070242.75009-1-fangxy@xiaopeng.com>

On Wed, Oct 21, 2026 at 03:02:42PM +0800, Fang Xieyan wrote:
> move_to_indirect() accepts an indirect descriptor with a zero length,
> setting desc_max to 0. __vringh_iov() then reads descs[0] before
> checking the descriptor bounds, resulting in an out-of-bounds read.
> 
> Reject a zero-length indirect table in move_to_indirect() so the
> caller returns -EINVAL before dereferencing the table. Also use the
> converted length in the warning to report invalid lengths correctly
> when the vring byte order differs from the CPU byte order.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>


Isn't this already addressed by
Subject: [PATCH v2] vringh: reject empty / undersized indirect descriptor tables
that you posted previously?

> ---
>  drivers/vhost/vringh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..ce4f5a02c8d2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,8 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(!len || len % sizeof(struct vring_desc))) {
> +		vringh_bad("Strange indirect len %u", len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

