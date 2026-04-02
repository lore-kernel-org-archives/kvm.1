Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FF3AD500
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135313; cv=none; b=jmw+t+i1ZnH0rsGRjOP9WAoP2clRXPx9xRwgkDIv7r9R4lh208xDFKmQdU1HYkj9qvhXTY4su4q7Jqv5G9RD/kpCVTUh97FEOyKTvoEZlA0sq9El+W3res2kOZvMrZtj948yA2r2bEtcoIubaJr/sYPahblzs524c7EvfsN4Y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135313; c=relaxed/simple;
	bh=wm02E3T0a1peGSnmnmR4/hZwBTf9XgjeCN8sySv09FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPAllKqXMCFm/Wc++eJ3WbWvpay8b4COurnUME5QSTv7cFwFogFqnsDdw78kI3OL5cRgfW1zKqENfBHYlQqvDWNENCLLexEpCzKAGoGy/pj9mBik/xalk7BS37AkqeW1pgQxjDyFwEo0pFvyfw5NjLPjBzBISeFUn3cHncVtqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gG4/46a4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYZsG+LV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG4/46a4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYZsG+LV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775135307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
	b=gG4/46a4ML6mtIXsXFmkHW0gF/Pr9BkWpKpDfpfqLON17eOGCNt1+femUD5RAv67/IrjPm
	vC8kBoifyOGfFR4Jz9emkSK6v7bG3OivAj4gVCIjvaHBL0Z29nwKjEtxZyTOKeZkm1b+QH
	tJKJ9ZFBi9dXkcAhgtY9RrRp+5uG/Ww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Svl1NXThNwmxzV9XNdwezg-1; Thu, 02 Apr 2026 09:08:25 -0400
X-MC-Unique: Svl1NXThNwmxzV9XNdwezg-1
X-Mimecast-MFC-AGG-ID: Svl1NXThNwmxzV9XNdwezg_1775135305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so18951075e9.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775135305; x=1775740105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
        b=cYZsG+LVeDHN1bQkWksCIBgA+BAw09xwPLURKL9/PGKjH0adb0lk1Dm1RnrXk7fyZJ
         IL4V25LFmmv4V87wFWfCjS9Ux6UZCa/onfSwQEzHMlrTD59CpWb4SgFx1jH/lvTWlTSy
         hqo+QEdLUqdgzMF30lkw9gIw73GCGiHRmNM8/4y3ESxtbhYzx1wsjY5kcBJggG9zzuH5
         GVNDGHc+9+YYOka7y65daGyWm87vNYIl5t4rK9Pg3+mLPh5wINYDUXWnyEB5Eh1awVsR
         D8oOAAwnl59cpaTTn5iBtnhm0i0YvxRz8WgbcC/dV6wXOe3p9DijrMyAU+fYJ5ZiVXt+
         bibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135305; x=1775740105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
        b=I2jK7JHx3BdjvXwwDHruG0uYhj3e4/JE4Rf81JTpsFcygLJ3I0gOEMVGfq9aVrIYwG
         166IkgAe5lgLmKInM4uvYyg8gpSLRds4j3D6vXMC5XgkmiwtADqiU/j5GdM3ohewD4MM
         0RZEt7xk3xqCxRGsfHxd1Uhcizk4PigL6c3/7L2L+3J4dNgdZyxal2QLracezc4qq5oN
         VLzTHxfG7Uq/SjT62m5XX2KIDWnoJQif913jPQTFvHIMTN4C0tvqfQ4dwr7XMe5Em3/a
         DzZbYQEVspFcNGP7eUv39Md9mI/EcGUP/o6tfe+l796g/ZMgQwWtH0ZpdgHxCc5CwJEP
         Jmfw==
X-Forwarded-Encrypted: i=1; AJvYcCWhuXN47qiXSEca806KTWfxWRE3Z5cQsoFzh/x5A97SvIEBszHr+O5smuYuy7dH3THX2nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PofdjsZ+SaYtP2VcXDgWT8dBTsGc5CSHNgnrNOEIf9E9v7jt
	F24LwrpDMUaaDzV0M8e4tNwtcGSJTTMPa2ktll7MsTAB25LH21vKC9e6n+dqWsj+I8DtHcNvkP2
	R5A0XKvUcsuwFyBpQLu+EtZsPPXD3cbBsi2+5WpNRdPUaVVu9LjAIeg==
X-Gm-Gg: ATEYQzw+w7HQYbqc6TKE0gg/42ICX91FchGAR67MRvjMjMPkibkFgwops6cBkmnXMUS
	8E60hH32fvcyEGceiOYsGzMIv8OnccZC2AVZynTODUab1HjA+Iaq5EKVghrWoOgWS0zxo8lBrUR
	Wf4M+mjGU4mHrxob1qRI5iHSk8dzhzQOBrDbXTlrthwtwrHpecdm4tHVPs+wb3GEaL7t6Wew30H
	P2dt1v5aVdXHWBWhEQYBp1ZELgXBVag18YJXcF5DUM4pix8BSpG5PerrPmdi0Jjz23rZUUMusnH
	QrVjmU4sKRspHEAdunWaww6igZM/3VX0OGvR394MeHJZNa0jEot9yZpPRsJWjgVRFObdt4bVFI6
	MWPnvfs5WiLK/QBOwEBqk8uXAl5Cv5kowxCPdqocILVKPcn2upKIOSPAbuflLfK6R0Nv+j3Mb6n
	JX
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924925e9.15.1775135304492;
        Thu, 02 Apr 2026 06:08:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924105e9.15.1775135303929;
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e967badsm251669415e9.14.2026.04.02.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:08:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Message-ID: <ac5pVRhTSc0Xr2xy@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>

On Thu, Apr 02, 2026 at 10:18:01AM +0200, Luigi Leonardi wrote:
>`virtio_transport_stream_do_peek()` does not account for the skb offset
>when computing the number of bytes to copy.
>
>This means that, after a partial recv() that advances the offset, a peek
>requesting more bytes than are available in the sk_buff causes
>`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

nit:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#14: `skb_copy_datagram_iter()` to go past the valid payload, resulting 
in a -EFAULT.

>
>The dequeue path already handles this correctly.
>Apply the same logic to the peek path.
>
>Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	skb_queue_walk(&vvs->rx_queue, skb) {
> 		size_t bytes;
>
>-		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		bytes = min_t(size_t, len - total,
>+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);

I think we should add some helper like virtio_transport_skb_remain() or 
virtio_transport_skb_bytes() and use it here but also in places where we 
check offset < len or offset == len. But maybe better to do that in 
another patch/series for net-next.

This fix LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

