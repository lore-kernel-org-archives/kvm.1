Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028A391E77
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812480; cv=none; b=liuQERIbkXfhSRy1lAvp/kr9cdx9pYBOknt/qd/fcuNh7i8MvM+LNjA1JpB6An2Hzfr9oH0HzA6hlFgHf3obkEhDrdChFIFv1nHEbT5iwOa3wvCSIeG483VHplri1+GvBAcUcNRusfWPFg83zzF6isqPP2cY/ozhKI7Vvibzx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812480; c=relaxed/simple;
	bh=YqmB8gQ2CSWotm3YyLmOYcMApzVTX/fpUiUxd3r4ALA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8ZgPvEgX4WjdZJfv9AtF+/pHIz75sJrjLNfYfwiU9w3GjOEBblEhwpvKfSn5rzaJlv+XyuFwxmawvJXGyQjLgxkLaFGvIgYuuRwy0j+Hi7d6a1mziQh/Cg0YNcFBCf+87rp8Hx1kFgBZEll/NiBDbWT5UNN0JXitELpmimKarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzF9Nw1t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ7dT7oF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzF9Nw1t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ7dT7oF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782812477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
	b=CzF9Nw1tmh2x9OtJlBfxLSmRJaJLGeo/g63vHOLbQlGPMSSX3ukwDtLUem+Kz3NEdq5eWH
	c04CLoTY757TaO+ZVwBgpN9dVXslPYbiQFK3b2+XGqlGD9UdYzssul3xd1Po6tyxhWQM5e
	ND7kfbQ/ckYvNCsC1qNNoGR514lwaxk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-sufNnr7LO5CorZQSUOd2zg-1; Tue, 30 Jun 2026 05:41:14 -0400
X-MC-Unique: sufNnr7LO5CorZQSUOd2zg-1
X-Mimecast-MFC-AGG-ID: sufNnr7LO5CorZQSUOd2zg_1782812473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so33281665e9.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782812473; x=1783417273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
        b=dQ7dT7oF2RDGNQd5S4pmUOsVKHR/kc7gZlJYMGC4Nxjwbk0zSIfJrBdZYwxrCZ1rix
         yBe+WffP77YzzIE0VNJo2xn8vbXSkuQoVmXOa4TpodHOH2WtXkS8AmnTt+eDez4oRkh9
         O3IjrzcCQH9k6mfpd+GZGP4XDv4u+2wGLdiEtNRt66YyWH2rxw3BwEPMIf8N/Ne6dGVm
         3Z/d2QDeicKnX9AAs6V53CM3XpPhsadBguevzSYJqIK8I39fTp6paJKV9JugCBn8QL5s
         /M3gshpdqlqX60DGQxbqfOJIkGtDCxM5R2/yXoWMxZTXvN4faKNIDOQAW2hrnyJh2jIx
         l5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812473; x=1783417273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
        b=k44BseyEzcgKd75cYahKKUL75mevvDnK380UenDnrE8NRcrPkpBWYfdiq1PNvhuFVu
         jlWS7ZX1zdjNtaamEpmo+eFZ+rc6EjxxN2PSoJDZQbw4gKwU91yUEWg4gC+sHRqHWzEu
         3Kp/aZJ/3dU/rpfjCmnYfnQmS0XOQNmX1+5b4uiU1lt7MlpUIiDhTVbQoWdgZsT5B8yS
         bXsPeW0UPUUd/vKjggxBylmtxezlJ/mQ5vwzbD/Fq2uPYgk1Ak75N4otof2SjdaKyIIP
         FkxST0owYzEC+ixZl2qvTSUI/SOKt6jT8OU1f95WbcXjb+JATtZ5g5kQqmAgcS1azQgL
         FMTw==
X-Forwarded-Encrypted: i=1; AFNElJ+Fho6EE/U/V4Qf+xcu8JHstIkZBr2JQinlkDffn7FStX6LjCFu5/oeyCEh9wsfOpF8NgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4xxKCVz1f6a4t5dbtBnEqptQDlGPZdLAzoOIl1rJbOw/6ly5
	vpu5cZKEE4epMUVov1U0seK2Bk6Bm4uCuHyHGyAp8JyxQpJKOQYFFjZDTmNbvfbQRdxHQ7y3UFX
	tUk9gNfXkkQH4mOYk3Vj0zQreKGEe81491Cxr3OETlVbRw4gZ6I29pQ==
X-Gm-Gg: AfdE7cmPSsQxFRG82Nw+EHD0+iLFQf8r6OD5th/OgHfCBv619MMijQfya5vGeq5oSOx
	mk7cwdkQ89vxJfvCBkXQ+d3Z0iWjibkSofQHY99D2DgoLfnc3KZt6TpEspedZjpZS/+LnYuB0H0
	uz0EXiLZtVdk3qXdhgCmADqe0bdaTe29Iw3m5yEFT6SqzoNtIvvvBofzrji0zANAbt67sPQxGgP
	cAi8g+GyASb7JEoE37NVN9rCBmxe1IxzXGRjxXmtfbrfV9v/OYnUDLHlPaG6V7n7bPksvTWkAIv
	GjBtLB2H5hsD8DWEn97OgpmjUuDuPz7HCQjjNetMJvoChEE6LrFhWoYVZK/sSsHkLkZxvkJA3ZW
	3/3Niv70TOEyv2D8Y6VEwy5Cpkh1UrWlGcOSaRFAQpLKSWMhONG88G1NTxtZ/
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092615e9.31.1782812473041;
        Tue, 30 Jun 2026 02:41:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092065e9.31.1782812472479;
        Tue, 30 Jun 2026 02:41:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0bbbcsm64869355e9.13.2026.06.30.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:41:11 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:41:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <akOOf7ShQS4OBJrd@sgarzare-redhat>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so to make further support
>easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
>this way, patch also adds handling case when 'msg_ubuf' is already set.

Thanks for this!

IIUC the result will be similar of commit eb315a7d1396 ("tcp: support 
externally provided ubufs") for tcp. Maybe I would have added it to the 
commit description, anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.
> Changelog v2->v3:
> * Update commit message.
> * Remove one empty line.
> Changelog v3->v4:
> * Update commit message.
>
> net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
> 1 file changed, 22 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..41c2a0b82a8e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	if (info->msg) {
>-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>-		 * there is no MSG_ZEROCOPY flag set.
>+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>+		 * handling from 'tcp_sendmsg_locked()'.
> 		 */
>-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+		if (info->msg->msg_ubuf) {
>+			uarg = info->msg->msg_ubuf;
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>+						    NULL, false);
>+			if (!uarg) {
>+				virtio_transport_put_credit(vvs, pkt_len);
>+				return -ENOMEM;
>+			}
>
>-		if (info->msg->msg_flags & MSG_ZEROCOPY)
> 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+			if (!can_zcopy)
>+				uarg_to_msgzc(uarg)->zerocopy = 0;
>
>+			have_uref = true;
>+		}
>+
>+		/* 'can_zcopy' means that this transmission will be
>+		 * in zerocopy way (e.g. using 'frags' array).
>+		 */
> 		if (can_zcopy)
> 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> 					    (MAX_SKB_FRAGS * PAGE_SIZE));
>-
>-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>-		    info->op == VIRTIO_VSOCK_OP_RW) {
>-			uarg = info->msg->msg_ubuf;
>-
>-			if (!uarg) {
>-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>-							    pkt_len, NULL, false);
>-				if (!uarg) {
>-					virtio_transport_put_credit(vvs, pkt_len);
>-					return -ENOMEM;
>-				}
>-
>-				if (!can_zcopy)
>-					uarg_to_msgzc(uarg)->zerocopy = 0;
>-
>-				have_uref = true;
>-			}
>-		}
> 	}
>
> 	rest_len = pkt_len;
>-- 
>2.25.1
>

