Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7734DCF3
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713330; cv=none; b=L/nlx50fa4iUR8itaT7dxuCkMTuK/qqRr668fg3qHcxkt2o1ctmPZyFCh7XS86l8arbR2fjCTOw7rDMjCF1KBH5jZx1rSEJeqAPsa7bxYe6X3btb//yfcurj93YNKXrajpXsl2k1ZnV/DuDInrcoKdy5BALJv+gyvR6HoztT1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713330; c=relaxed/simple;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BymSjY6myRVzzdk4dh0+53HFOks6L/CUVywwqyIaGoihSvI10U5QGhu2n2pW6rSDkr5eXDelAiYdZE1PliTReuM6lOhb5kCnDMFxZRQ7JNCJbspFRa6yJWpq3Mv9jaQdr5/Md9s31E7epDPofisNT2ccCJ9UMVPInTytjK84zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRXYwaaA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjRkhazS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRXYwaaA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjRkhazS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779713328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	b=bRXYwaaAa8s1JnjYJWcGQpJjcfn68eD38Phxp2dE1vKEJsWRd+UZgfwjVaUpoZFJVPZF7p
	jxmwo1AMehVcZ4ro+x/xo+njry/6zIEqa3nMoctY+PLZVN1C9Wp5lGtaDst77K2ECNW4Xs
	iOC9FPcmz74DniL/ZF6LkAGDUFMMRU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-SicFfy3uP9ehx19zYkbcug-1; Mon, 25 May 2026 08:48:47 -0400
X-MC-Unique: SicFfy3uP9ehx19zYkbcug-1
X-Mimecast-MFC-AGG-ID: SicFfy3uP9ehx19zYkbcug_1779713326
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso6580269f8f.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779713326; x=1780318126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
        b=kjRkhazStr15+7M/Ih3LPfMYwvXmc9W0UoohV4MgAtxo4qWvWH78X8oynXxVFZS9vg
         aKv9RnK9poC7OclDSANsH1otIjHiggPMD71ar+hJtfoH0/i+IYmKIy2KCkVCfES/vxi7
         lW4dyzLz0lVBgod1Np8zLRc0hVMYsBJHfJEr8+bevD8Dszj0nCcGaZfElFD+R3+/GxZm
         PmojGd7knEiWEIh+kJCjUWREt2gjWdU3vkKcV65i55DUXdl/7OdW5Aj8aRGC5j8his2q
         ikt0kYJoJeU9WLTwCItY5dfCPtvG4EhptRGGN4gNLIunHWdIQnvRfEkNWjXdSRhhH3Hi
         2hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713326; x=1780318126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
        b=UdKQVyv97pF3DGEPsYOZJlEqbcYigihf50RYfSRrSgR94+R6YiQ5HeeSXutxvZXlKZ
         LmnlHRkbgHIsft7rSTeub6HMHVdvhz8KdWSHWZUxTrsKS316BXOQmX8Rf0lBxE5e1KCK
         tC76yAEoycn/HxRe7TI88jh0q/OGWw3La5+FWdBPHzeYDWXYOnn0pDq30H+qyujuaLIb
         UO9GvzJGuSpD71Twq2vqI3X7okGU++uoFsDumgKViKxMKd080f82gAXHg7TGzhJEEmyI
         3+OOsbcj8U6rYZfL4+dKkXyN79FF8zcVqXuWGOsf2POPCXbHirG+oTm9ZVjla25sgE66
         vkYg==
X-Forwarded-Encrypted: i=1; AFNElJ/wgeHxjiDz2MVKg8CN6OZEEGgTUEB0lrd29TNLNzPSP5w+NtgTDK8kiouXMJ+TmCe44n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV588lbwM5/GYp/Ly7S1uuYQabrGn5dPr5nRNx8fAlbPQrjn71
	EaV0ugnryel0kFspRMvwaDTTO+9sINOOC70YAZiwhOcG4WPKWAGDR9ocC4drf5xsyLdUc1jdPQk
	gDe5XFfyWdwN/jPUYj3dPUcpguBPC3/AwWT738mSimyhhFN1jfYjSpA==
X-Gm-Gg: Acq92OEzwDErIU+Vm3yVN08dVogf5qd6VG2msiMJjdSsvC+wKAWWblpWqjhTIa/zS4E
	cFtu2WO5AvDNiGmTYpaP7b9j6aR1OWWtidEMZcHxkby7r384qKSadDrzgvcSzlOOq4rx6gV4XF1
	G3+t1tis1bFb4bJ7Lj9pdIpJQzyPNCYxrxQAIQGOlA9b9mt297N7ANf4i0hngWygBEhbGyakKGu
	BL6LNDbjlrT7uEqpI/5xuuUNYPG0MKXCat2HLw7+fKN8HBPSjbioL8l1gv4Ra5vpCVw8GHbh+XC
	/HHqS8U3RW5usVicTfRBQa8Dt4kgm/KfVRAo0T+mpOgpPi0+Xo5JTxdaN4oGNoonnPxF03E+1OW
	k/mT8o3hrIOZb2ewCPGIx9ZWadL0Ssq7LGjqQ69Dube8rWNQ8qps3sCYmmX9r4aBJlokg0zs=
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209950235e9.26.1779713326046;
        Mon, 25 May 2026 05:48:46 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209949785e9.26.1779713325422;
        Mon, 25 May 2026 05:48:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904333146bsm143470125e9.0.2026.05.25.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:48:44 -0700 (PDT)
Date: Mon, 25 May 2026 14:48:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	tanjingguo <tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, Chenzhe <chenzhe@huawei.com>, 
	cenxianlong <cenxianlong@huawei.com>, cuirongzhen <cuirongzhen@huawei.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <ahRFCaqFwdEFA9CK@sgarzare-redhat>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>

On Mon, May 25, 2026 at 11:15:12AM +0000, malin (R) wrote:
>From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
>From: Jingguo Tan <tanjingguo@huawei.com>
>Date: Fri, 22 May 2026 19:53:45 +0800
>Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
>
>virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
>before entering the send loop, but virtio_transport_alloc_skb() still
>fills the skb before it inherits that uarg. When fixed-buffer vectored
>zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
>managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
>to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
>skb_release_data() falls through to ordinary frag unref.
>
>Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
>before virtio_transport_fill_skb(). This keeps control or no-payload skbs
>untouched while ensuring success and rollback share one lifetime rule.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Lin Ma <malin89@huawei.com>
>Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
>Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
>---
>
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

