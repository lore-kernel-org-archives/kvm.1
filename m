Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF253BE165
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578987; cv=none; b=tTkzOgJWXmqow38YrXuWocFRwvHWn7A6cU4VbSrztJM4BzbaLhLlvf/8k1SYib/7n3vHva9xgFn5ScCdqFrZz8JABBDfYuEcD20UXp7mlvFqEADZ+bXudTx31F2Be0ZyqqJJWAkWnrBDt8LW9gfSrsd8lUFdLdrQ1+hH51VJds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578987; c=relaxed/simple;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODq0AbH+2GdthfXeihgEkQ5B3g37sYdPZ04+VX3RXTeY0zknjqkS8L1Ma/xpIF9c2E7MXRTHiaT7wyREHEbZ0IxZgEqAJF1O7OycCoY7FSxajayiyYI4We4Me3aLMyOR3nb/Z7msNHGgzCjycQHAtXCMZfF7AyWWaYQ5130j5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1MpukBy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rkhyfNt0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1MpukBy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rkhyfNt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	b=L1MpukByvkXfaFCbyJt/KafU9FypzxPVkq8ukYAGjzBBPiQrEQYD/p3Hu1t2wlv64TUnZa
	oGN12hvxXR+FDePTBB47RA2XNQKT3s/Bc/yVqj+6obagKLMdApvdEZsN38h/yo1fg+ujfQ
	PO/iRdPsTBn5Fxjc/IlQsJed6ZWEUis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-R1ClQWIVOMiZfr3a0ezPYg-1; Tue, 07 Apr 2026 12:23:02 -0400
X-MC-Unique: R1ClQWIVOMiZfr3a0ezPYg-1
X-Mimecast-MFC-AGG-ID: R1ClQWIVOMiZfr3a0ezPYg_1775578981
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4887d32788bso42029825e9.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775578981; x=1776183781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
        b=rkhyfNt0DhhexR1fdlfDmdC9vdkAvvXrdHngl9fGv7ESfGJoaoWtC+ixm4G/UCWpkJ
         zwW2k5V87Qyu2ujp20BE+Pu9oEx9wxOM/5T8ecZxOxn/oa33eoqH2NUfYilRB5cIoN/N
         IXVsHhV1bgj8AjZow9120Fmr1ZDS3E4JvO6G8EgepeyRjLpqYvH8gIONBUeJKuuK+SLs
         ev8vdQ4DN8dj1QkB73muNyOWvS/ctfzlVf5QKcKxlGkXjvTtU4l9REG9nc5G3zX1zbfo
         iaKKHLxMuNwfIAMN22CPnI/2SQH83gD4f+87oXdOszaJzIIevoCpswL4x+OBhVpV9VPi
         /bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578981; x=1776183781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
        b=iakKQjyJgJb3INjOfZbKv3o+l5Yv6IYsaABD+YpBJgAnadvH3t73qw9Wc556mhPkvB
         JnYTFPAW4CmFuvpT+wdRws8s7TqYaN0GhHIuUYreX+YQOWIRyt5HKdHldD5ydxeX9iHA
         vGvz5BAjlCi99X1i0X0qjGmvM5Y9S0dAqjM8Nh20vphqrQgNrhQK1OI+UisRdVkv+TQN
         8Zxos2DbTBnavgvCNL2OJjgM/4iSsIaX7MMcCUCP0oOc9hxM3DlfGfHAZ+obZh8Rjk0z
         9F01Jt7Y3IBc2wnvX51jM1/FWOKdsdIDvmoiPvrt1aVHwYGSd6Oc0TYP+Yw/49BoCjI+
         +WEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT4krTSSHtyrkO5wklM5kZbFmoaJy+8SzY3NDhu+/StJBA7A7AiARbcdWJYj+QmQd1gT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLjXMFraVcUjsQFCJRCNJLz764mfhJHBPeQdU/+TA+Ub5OYkX
	XvUlCsMI+IirFpZPl17Cl3Co8Dy6IFV1BHuhImeF9GsOvY5zRAaTZxlpsvXsNJy3W5vLmb5rky0
	PKCfTciGIFybDUCahQcvcugg8s0lqFz4cOBAcglFmz/3kF2pw9ZbQBw==
X-Gm-Gg: AeBDieu/Yz9zRMf3uzYeMxEE7SNM1tv64VNdRyPK1RKSxqPy8IF3lZsbJ58IK2v1fqw
	IJdfF92PECLFwuES+shcQEduueMB7jlK+GQZ2gU9zeQuGALrQC7Bm+MyP4ZPYmiF0RnCdDLYTsd
	pqyJ1TUSAVd2TtjHMIlAmOr9Unmcb37pQijnJW27hA78WAeDxJng+yqwMrSHOrGL2AQYlBRG3v9
	HX9W73QC4I7YCHg0WVyLfUKsNGbGNgaMvyNlSmtfd9zZSyLdimYNrsTigDbyNJbzjfM+9wL5kO3
	swFAOHpERQtnRe+/23FtIPwcG2pzK+BE59+0wPaEs4M6CYHSJGZ9Lumvowgn2OfpjUs4moUZSS4
	FGrvLgWMUOPkaBfKUQeJXTNNZqPo=
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226451135e9.2.1775578980907;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226450755e9.2.1775578980501;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm60518000f8f.11.2026.04.07.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:22:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvRegULccN0hiL@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <20260407121515-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407121515-mutt-send-email-mst@kernel.org>

On Tue, Apr 07, 2026 at 12:16:27PM -0400, Michael S. Tsirkin wrote:
>On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>>
>> Remove it.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>but I think we should drop the Fixes tag.

ok, should I send a v2 without the tag?

Thanks,
Luigi

