Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBB3A6F11
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448025; cv=none; b=lIRNgTn/iEhKp8t65TFMG97GoJCS2BAqptjMzhYqUyHfWX4kxJdALa8nNYWSQ2GzerEim+maashDA06yUsv6zvsAeKbOW+w6XOTWyVg4jRBqnCzjsdItI7TKouztpzLblbJU09YHsdNO+j/rxmdZER06Pn2iJDFS3Tyl6uMs4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448025; c=relaxed/simple;
	bh=w7iSUrEkyKIfpcXJr36ZtXbPrCa/n9wTF5n6WkXijcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJkcf/YWUpUXLc9YGjWlonwpC85cSlGTRyt5KQ2KPcOmoLhmCrxPNTPhOxkGLYXGDVrf8XNHRHbBU9/V+ZkpoGeJ2ALANTBsvYASpZ2WNKUz9Ic6txz7GbV6oL5aKq78iJ8QVgZTMH++eHsXmR6Oyv9XI61e02cE9gwAtBNnehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX6wp9UE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX6wp9UE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so2617895ad.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448024; x=1786052824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=gX6wp9UER48YblagjXnXhqdtDfisNlj0xYBiHmfgVnkn/la9tQQvXWATCruel+1yhE
         xImhh46q0Rwu6/ysRxWgYDrL3f1ltFMx8bF0Q6Kf1xWtzEBhBaXR9D2rT6ggjojzklK5
         3UwP0JTQdX/i8loJ9xKtxMJjvZPPKAIA9VBxYxYO5j/IWoEUfBJCQe54SnAErle8syoG
         8dnrygT0F0g2u1q9Cy4b0K2VETZKGWhcxMHDNNOt8eoltfb/NvKyQlTcb3rtaHUDKD4h
         evTe057x4Zm2k4cUb+quvjaQPFZ72pt3JhXGNub+K6NvXo8PmqKMGsB/gcQnubRfDXQw
         Cl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448024; x=1786052824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=ND6FeDXSUg6MaQwx74fVO86yZSRhVt30My1j9fxXqKUy2f6B1Vf271f503l6sfOsG7
         6+0WTa+ncYCKj3iFwa1WUisgecooUJozCSIZFVNNae2zgB6q9dlyKlsYLWGBKI8s5H55
         IKjxjpc2mTnGpcwqB/5j2K2jEbt7j8G5wvV814vZ1ls1zY/+wvwFOKenN8YaQeSWRSCO
         zApQLAiJjiEK1welyMgeX2xqDlALwerkyaPe9CEUl7Ig8F6xrYjC03xQFe8Na2c8HhP7
         SZeVu/wz1iu6BX/dBILAHYY9p36VIIXhwSOXx/5UvTfDDbWD/FsNHt3HBZBhsT7N9JgZ
         iZaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKOUlIvVtvaSOkWifoLixNIStiilhb7CLI1OnQfjPQ051J2gI0WzFw41dmRGKIBAfYHB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0JVH9fw8gBGBU0SLF/8zxV154vqwpUiRnG4oEC+nFSb7OtCU
	erk+7R/7fhbNsIcitcGXjzgrWcTLaR6qFz9ygYERrdFv1Iltba48fo+r
X-Gm-Gg: AR+sD134cPTUp9vblm63xKJ1HIk5pjexLIOyAU50BfOc3ysW7qPGfoDXrZMp1PkW7XK
	m39qHD8Xfib5rMce9nMpKtCIr6dX8DN6D98sNS7sfpF45IGta6Eq7T7+dlfdwddRW20wCRr7HV5
	Hd7yaLXDEw4P8+MpLFz4XGZ1IkpQK6MjKW6AHf1vR167/0RiA2vGvje347Ygk/BXGweW2ks2NZM
	h1FUjhSlbfi7wyMcBSwK8Ladd3Z0+gh06T8vWK+8pemvxLXlHSpSe8KW4s753zMoVog7vpjms5b
	+llEsYwe/dMeQRUw8awJTXEivQDxJfbbcxuBuhRrre7IGhTYGFQqFppROEM3LoQvP6Tur3re696
	N0aUIrNe1Si1zKVZw1rh2cMm7Xb2xX6/lC/cjfQxOiW7DnJ3dygOzjDFb0PiDzGQjrU5L2075a8
	Bye/oQkwCBn1h0aD4QdJwEpC1NuPw2+2OJ4gX91tAUlFMxQhJrvSyU3qQoWv9u6KS3uPdWhp4mj
	T6G5UwqQV4=
X-Received: by 2002:a17:902:f652:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d035b9ad39mr42104245ad.8.1785448023652;
        Thu, 30 Jul 2026 14:47:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a151fbsm31736035ad.10.2026.07.30.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:47:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:46:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 1/2] vsock/virtio: read virtqueues under worker locks
Message-ID: <amvGU9j4lHl7TnS8@devvm29614.prn0.facebook.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:54PM -0700, Weiming Shi wrote:
> Commit bd50c5dc182b ("vsock/virtio: add support for device
> suspend/resume") made the *_run flags transition from false to true when
> restore installs replacement virtqueues.  The RX, TX and event workers
> read their virtqueue before locking and checking the corresponding flag,
> so a worker delayed across freeze and restore can observe the replacement
> queue's running state while retaining a pointer to the deleted queue.
> 
> Read each virtqueue under its mutex after checking the run flag, keeping
> the pointer and state in the same queue generation.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 57f2d6ec3ffc..a8e1dd95ba8c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  	struct virtqueue *vq;
>  	bool added = false;
>  
> -	vq = vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
>  
>  	if (!vsock->tx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;
> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, event_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
> -
>  	mutex_lock(&vsock->event_lock);
>  
>  	if (!vsock->event_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
> +
>  	do {
>  		struct virtio_vsock_event *event;
>  		unsigned int len;
> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
