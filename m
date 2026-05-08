Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E543D813F
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258848; cv=none; b=AbY/DDxe2EkcMi4syK0pa6TreMohpXIiarQvczwipYQSdADGc4ZTF3GrCy1o9u/EQeX/GyftGKfepsayi8AdDMvSO/f/OBjw818w/u0MkZ+XCGgKP37cpYyUX9Cvfq5T6OUWJPlJ4skT3DU+LGE340yotVN0wbYX2QbENUvqQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258848; c=relaxed/simple;
	bh=+GlTIpRQZ5vV/lIQfJdZ/NWxJDB5jBGX6KC+RdsOsLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ30FnI3zqKed6sT6pP+WMqBBnVinEuZtgKrXsie3/UhPkZ81T3KEMPLJ08B+OpOASesls3xKVY3+ARBLUX5J/bOsuZeSArLa4XKl8h7YmusGph1LtyxBpP5DdlBXCA2XmtsukkkoUQP0T2BtoYkBDHfJdZEzffSN5jJxJyvsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIK/kCKu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3UmYKcU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIK/kCKu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3UmYKcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
	b=SIK/kCKuAJwyDE8EmbQNQVd7A+FzZri8ZFO2/afWkSJJTDDDhSdcjydd3uyelzVdUz+UqE
	s2liHW9Up73U3U/SgEY6pInloX7I2NL1W+r8t6zL/Zj6wY/YVSuaYNLTdtlQTvRNAjtKUf
	wyB4zBV2J+fNx+4bZXsHeBDsMWjhu50=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-m6ItE4c1OWu8vEkitznC-g-1; Fri, 08 May 2026 12:47:23 -0400
X-MC-Unique: m6ItE4c1OWu8vEkitznC-g-1
X-Mimecast-MFC-AGG-ID: m6ItE4c1OWu8vEkitznC-g_1778258842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d127eb013so13199595e9.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258842; x=1778863642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
        b=L3UmYKcU8HuqVyTxVg012aNEenn+4LD8ZuawR0RNOZow+ZdHh3rtA0wvz09TLyHyZ0
         P1S9rBUc8WdhtVukkRlwZ5Sf5WzRbSoix5sELNOPiVAhTUvnTPz9ulkvYZzvwTHBoUJu
         NZVEqu4CbHfNH9fP/dHnUtzzpRzzLalH8ofmUt1TUebc340kikwBeb4Vh3EU2xjrCO8C
         KU3NiJedZo9TMH5NRbYyPAyC0tWGpk+rQEgxar02wqdbrJ3Rc9nmaQmpwvksw21pZbX4
         fpCO9L5b9hCJHFKS2EC+YwkT2Dn7iMqG4SqZicUFdeaFn2Apk93kqgt1xa0w186Rm+Vc
         z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258842; x=1778863642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
        b=qJTp9XnXl5kURcfWRxpXBTAtj1lnnE7a+5wV0b1pRPPGe6JQTJRFkdYvA9bNl0ZBm7
         jEBAchMDYFu+ayoc0G69T8xG+Xx90CAgGh1iht4YxWdz/Lodrceb8likR3CH+uME1nv1
         8wKjCtYZi6s8Em1F8g/+3IpFkV7NZ3FYrhtxi86KUwsacns1eFfcE+bt6Ios6EdKXXa9
         XhhcUEdUltZp8h/sB257u8PlyPNWpeJAs0xG//vtZHZiosHr48Fl2K/fx7x+Z5V0nvCI
         3BtT9mjjweUkBwSWHl0huUVybN18HM5SyltixeXnxwBpU2Sjoriav9WTu0BlZQxwloLt
         C9XA==
X-Gm-Message-State: AOJu0YxRj1GGABVmVk3llY0/8MiEnkigBB1XC6ccbNwG+jnQDh6EM/Hk
	cNS+I1Q89CUEbGMpASdB7d1mABWwYIkpQAhqMRpeOrWwE9wL3F3M8iDldy31JiVInhN635phjQK
	McD0xuPKKLXIQ9i/TUQcdP+Carpst8ng1srmnoRcuuooGycEOEfLmAg==
X-Gm-Gg: AeBDiev5lglvnQ7IHp44ADeeSm+U9iJanGIZWgk7mQCm5TqUTQmnN5OojrV/EyxPj48
	wl1O2+iCWpFYc+dcj0DAON2PjVd6V7K2v+IwO5F4KTl74nFB7py7MSVOdrbO2AEdIvedrAovekm
	Ryje+72WvWRh/IyOh/8ABOHW2CYzK07+qPrPWy60BI9revm+5YmJ99psmS4cWp1O9Cb2IRYaH9b
	0zrAAhjNTXLE+mCdZpWXi9yo4zBC4e6RsuXdDSF3uAypEYevI2Bp4fSasTzuP7u1Ch2F3Dr35ev
	HVvjVOpDQOD4FK4OxPDhmb4TcIrvKkNhmGpFU4bPsvOq7T6hr7qDkCQZHpJm0gPg0PaVcfzh2fp
	hdl1Mei3YzYEs2p3US9t5J+0dKFQ//q3d/LBH+Wc11yjgVkJeCun4JUF+3gT26OpvFDDMIhQy+A
	==
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54988565e9.23.1778258842219;
        Fri, 08 May 2026 09:47:22 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54987955e9.23.1778258841600;
        Fri, 08 May 2026 09:47:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd2c59esm6805945e9.1.2026.05.08.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:47:20 -0700 (PDT)
Date: Fri, 8 May 2026 18:47:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <af4TLgAsn8zS7cGs@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>

On Thu, Apr 30, 2026 at 03:11:10PM +0800, Yiqi Sun wrote:
>vsockmon mirrors packets through virtio_transport_build_skb(), which
>builds a new skb and copies the payload into it. For non-linear skbs,
>this goes through virtio_transport_copy_nonlinear_skb().
>
>Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>As a result, skb_copy_datagram_iter() sees zero writable bytes
>in the destination iterator and copies no payload data.
>
>This becomes an info leak because virtio_transport_build_skb() has
>already reserved payload_len bytes in the new skb with skb_put(). The
>skb is then returned to the tap path with that payload area still
>uninitialized, so userspace reading from a vsockmon device can observe
>heap contents and potentially kernel address.
>
>Fix it by initializing iov_iter.count to the number of bytes to copy.
>
>Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Yiqi Sun, thanks for this patch, but as I mentioned in the sub-thread 
I found another issue and also another way to fix this, please can you 
test the series I just sent: https://lore.kernel.org/netdev/20260508164411.261440-1-sgarzare@redhat.com/

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..6b26ee57ccab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> 	iov_iter.nr_segs = 1;
>
> 	to_copy = min_t(size_t, len, skb->len);
>-
>+	iov_iter.count = to_copy;
> 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> 			       &iov_iter, to_copy);
> }
>-- 
>2.34.1
>

