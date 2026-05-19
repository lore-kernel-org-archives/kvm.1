Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8843F65FF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182885; cv=none; b=im0fkovJ79NdDQDxLidR+BV8SdSJIFB1rFlTm4N/u3MQ+17U89GLMMfKofbZtCNCoSor1WnWUG0c7HgTrEVql+7Lj4Z2yOO43Y+X7WVniN81vOwxy5xNyPCWi023Rle6oINLiDVs1m0rcYrj2DAAIHrzv+14krgVuQRt9wx/pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182885; c=relaxed/simple;
	bh=uDEw9No4oP0gv6j/Ado3aaG16haNPWRnDa/SWjuSB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1WkvkuuOGTAI9AgDcH19dg52wv/jjkHmgdS0XPLWBbNS/vlnrnAhm4p5JR8h3Z+e/wxZXWPz6lkC+kXXJGKK3llm6cK2nr4PqUFGgiId1KnA0Yup9lCu+ka9JI46WcglF1fPvk1ZzuqSv1SfZNu75GrY8taSEO5sBWt5HXLoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rtn3n3hH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp5g2XXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rtn3n3hH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp5g2XXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
	b=Rtn3n3hHjeG06wrmahBmrpvnEhYR+jEb0NsM4qrjeozaOK42WG43ypBvnE4KiJJJ+LeWtB
	jhV/N1K3EfwrVY6foEddYR3kH+jT9yvLKxcyWqtRASXBSsavLA11kIzGxgjX9iL5F/04VC
	/GZHN1APwLtybUvFv44BJbWblwjL9QY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-kZCpDCPIOQaEn9_4_JVXRA-1; Tue, 19 May 2026 05:27:57 -0400
X-MC-Unique: kZCpDCPIOQaEn9_4_JVXRA-1
X-Mimecast-MFC-AGG-ID: kZCpDCPIOQaEn9_4_JVXRA_1779182876
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449dcfe8005so2666051f8f.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182876; x=1779787676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
        b=Qp5g2XXcUW5pzt09Ok1DfcXRCqJOSLPS5Ths9SasBz3va0oZXd96CZJiWEnmmTg5ju
         ulT2vzEKejVy2Ybn3f0FTNm33XADihQGTYChOCTEjAIbH8+J8EQJgQ9h8lco/13ofs+h
         neQVPFURGpFYz/Ggzut/7i0wVxgWOGbt0VW8ZsdO0Ya5BTr5cRQJt+BiEqPJMzOsSJKz
         0qOUv6tejOWJfPmqENslLKQMINFZ6YdKWrtdVhIq4Rl8bQTNN97dymbC6xFrTRoZcpEX
         FLlqILASe6JlPlEQ8ORNJ6KyMtqvF9P8mYdDO2MHjfqYUfU+OHhjLNpXAsfBCjuV18Rz
         xHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182876; x=1779787676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kq5cy4odtanFj4ZmmMjmdUGGp4uB2ZhMg4n7iuzQNs=;
        b=RGaQRbV30AZ7TIE8ZjYSWp7zAKPze4gWX6ERmQ3YUmE6uuobbkrShkLtrBbMlsNULo
         XPppRMThrYp+UQOoye7WzObRW0Q/53OeeYanEDISzKXESdP7d0vQydpDydIQTbW8jhH1
         2h0Qquxd0n8DtN61gCB0B9X7x3E65M2OA4dYJp2quEx2EUa3HvL5UXDYJIgrNlqAUBHD
         BLCCnfvMH9xp3t8iN47RAtGv8YiO1FnBte4foC3SFez/0tY+HDpS8sE6IZUu65CllVn2
         vV5zJgbns1QQZ0+0l/kjNJy48yjOWhpUOhJtZj7mi0EyvEzehh+tVHy2jyEmApDvcOGK
         mLJA==
X-Forwarded-Encrypted: i=1; AFNElJ9qUtRNXyzraz+LUr9KVj+ddnzSSxUVkib3ZnoJrjAjSj4XYruYmZAr3dqUMCf4sp2qXT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eJw1bkvAz2g+P4vH0XcoCrp8TgDNASBCbPqcPjjw3gaDa/Bl
	YUDmSFW5uAYsEJtmN1LYUy4fgA6MlIjjJtoam8fHyRrRcQrQqyMHrM8nPNyz1tDmMrHqVzMncxS
	14wR7YPkkbFBDp4sCvqulbh98fc62X30AQ68PxmMXVTQGXsv11LJNMg==
X-Gm-Gg: Acq92OFzUF/HKi1mUoisVKB3lRnbz1FZkWyZHHcX9hmdTVi9fIT2UsLvdLIjFxjZev0
	Ie4U34VnOzvlyYiRC39igr7GzNlibv276xg2m6EqMbnunqcpQUFQikuKDBLYRc+eoo2mGcdAUng
	5bTXVYIuTNrwK3A0WF0tUTyv+WRm4ExoFW4zVfSJKPu1bsGuRjZjUdsAAAYEAK2Mb9s0ZnHzzzi
	55EvXWm5NY8bVe/Kat03LiMH90AMVTpeVr7e/un9gd+eqtSfzOP6LAopbypwyl/sEFi8gMBs1Q8
	RJ5waUrMghkMk7WUe8+TqB7T77IRO6Vsdnslp3kPo4TLwUaOWFqZvm9idyW4ykwtDag3f0JSOv9
	xQdguef/e9CAkRvJ2CibdaiQPEbM5LwrrVUpiYG5+0ZvGfjSjOjqgr2oSzOBM/3AsZGOs4sLa3g
	==
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869422f8f.42.1779182876042;
        Tue, 19 May 2026 02:27:56 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45e5c6137f0mr31869195f8f.42.1779182874171;
        Tue, 19 May 2026 02:27:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43178925f8f.16.2026.05.19.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:27:53 -0700 (PDT)
Date: Tue, 19 May 2026 11:27:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agwrrRSEZ9akIrx-@sgarzare-redhat>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>

On Mon, May 18, 2026 at 11:06:54AM +0200, Stefano Garzarella wrote:
>Patch 1 resets the connection when we can no longer queue packets,
>this prevents silent data loss, and both peers are notified.
>
>Patch 2 increases the total budget to `buf_alloc * 2` for payload
>plus skb overhead similar to how SO_RCVBUF is doubled to reserve
>space for sk_buff metadata. This preserves the full buf_alloc for
>payload under normal operation, while still bounding the skb queue
>growth.
>
>In the future, we plan to improve how we handle the merging of packets
>to minimize overhead and avoid closing connections.
>
>v4:
>- Split the buf_alloc check to be sure the credit is still respected and
>  to avoid overflow of buf_used [sashiko]
>- call virtio_transport_do_close() and vsock_remove_sock() to properly
>  close the connection and remove the socket from the connect table
>  [sashiko]

sashiko reports 2 issues on the second patch but both IMO are 
pre-existing: 
https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com

The first one related 32-bit architectures should be fixed, but can be a 
follow up since not introduced by this series.

The secong one related to a low value set by the user as buffer size, 
it's also pre-existing and I don't think we can do much.

Please let me know if you prefer to add another patch to this series to 
fix the first issue, or just send another patch.

Thanks,
Stefano


>
>v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
>- Split in 2 patches [MST]
>
>v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
>- Close the connection when we can no longer queue new packets instead
>  of losing data.
>- No longer announce the reduced buf_alloc to avoid violating the
>  spec. [MST]
>
>v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>Stefano Garzarella (2):
>  vsock/virtio: reset connection on receiving queue overflow
>  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
>
> net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 6 deletions(-)
>
>-- 
>2.54.0
>

