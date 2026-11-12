Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493883;
	b=kRQrlBRyB8c4k1lcI04daW3zbRGVnKe+zfMdSLCArVMTfz2KJQzQDgf++AGwYqFraxqu
	 PnsvjvZJhA8GdUT41uFfVuKTJKB/ltMUPUgqvaPKtGZetovByVASeWcguy8OxQPK5H9Ww
	 9LFAtbZenJfaEEHQH7DUcEmqozpbfS9Oer8yTlfvpHXr5BTtD6EHoiEkmBRaG2rzoN6J1
	 g2FwZpn0my0jWjUosI/GZrQe7YD41TXbewLiSsFB/rzxPHxaWCDegU9p3GYMM1y8iOVfo
	 veAQDJ5/B0u9nRESYF5tjAMPIyYHWAIoU171fdjA5q3TlozJTRJRMYZoLWW4k8xQ28g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493883;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
	b=kk7YRwAOQsq4U3MCeSeGoG68YWaeadu8j5x3gCKrfe1eUp3jcPGt8QmKwzY1V9c0wK3A
	 pC7Z+VZj6g/qdN42NIjTx3beVs27x13PKo+LlEd5HwEK1m/NSdFjBOeMp8alrfSpx9Ez0
	 SfFUtygQe1IyKFbI5ZbI4C1zjlD3mdQo7/6pZB5sdoSg5g3Dn4BFqOcw3mWaKxH0wNetE
	 FXFriSImbBPOnDGEUh8bhaSHunP7md16S9rbMILc0Q28C4w4rRh9hKxmKeGoIaxbLgusB
	 vVqj+fYNSswoTuyRcPVg559hYlrAXn51yGVfzJYnvXCG1YJY4UAEcp9Lbu0XEKexpcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CzY0LgZ9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ps8mnj6y;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DA60703B4
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 578DA60703B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CzY0LgZ9;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ps8mnj6y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
	b=CzY0LgZ9rKSXXNViXuNIHTYagjgnqNPqC/EMHk3MyIy89eDURpcfoLHw0OpSN8CEZ+hBKT
	tsVb75aVQYXWFweG9Qvw+6O/9TWtEOsw2qoR/FN4rqQmffDQSTVHYWIKszBzYCVbN3QH/G
	IbptPKmvmPDIy8gOrcZBLH5CtLq/tFs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Dp7GX0JmNi6z0BbzTL20Hw-1; Thu, 12 Nov 2026 09:31:19 -0500
X-MC-Unique: Dp7GX0JmNi6z0BbzTL20Hw-1
X-Mimecast-MFC-AGG-ID: Dp7GX0JmNi6z0BbzTL20Hw_1794493878
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-847e2926d94so8844798a34.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794493878; x=1795098678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
        b=Ps8mnj6y/K5578klqSeu5p96RlsZH+KiVA3Zsjn8QskaSj8YPuIk8lkfT+BO1zxtky
         JlujZHDZ91+6rIf3WfwCGuAUX3F/4fQZsKP1L0o1Ro6gLlTdw2X19z7tovPZD/UF331J
         A+Gyxe09t41ajG+VxGSB647Yfc06d+Qa70mABGfM7U4umWA2CgLv8MLlJ8OYr5Nd2lTj
         ax39p0D+iWp2nBTcecSIakOQFkK9OIdhnxJ3C3X+Hu3eXygiDCWUYuvNJtSebBQcd3nA
         mA3M9cg32UDx7nZ/+vo7AsT/F7E/BjEAF42Hb6cAkHSo8JkCu5dn4bjPsCFd6P1IcE0S
         50Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493878; x=1795098678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
        b=j0Blfikjl607EZQheVsjV8Eb4gmOiDC8MO+GmdCkodG38JKJvHrUmSOB/GAanyTRZs
         JfncdninLDu3B/Nt7PJA5GWJg8FnvC9MsHkdYYh/JKps5DtSNmbUcXFuYvAz6dSFiFGq
         aET/PQr8J2BWdiSlCAZJEonqXzQskjXDYTa+rdKXqvyZx3XxS6y1cA2DDzn7KfVyDCBH
         jpX5iDYLxc+41j2WbR5QlIVyhuxn0gu55rgD1lMNDzfdd3hudDmn/ewIYb5rHLf+XbDY
         slzk77+St/zVViiIfqsLGBmUUwqc/WT+5lPQZH9gmmfcr446Q28jOMOMpIrEoXcgWlO9
         96xw==
X-Forwarded-Encrypted: i=1; AL+hErEumkpOSDanZJT08ynvaCKz9/FTqo5BIKAKXzSydFIaOGygviTrQpGfAkw8xLuK67osroA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+70r3lg9U++VfjuuzdJPf+4iCDLsEAx/LC5puuPyOnTdgXAFRc
	+5MwHp6vZjiASvu+MnrRXatJIOBM5KWh6Oz8hn1feCVwJMVSIs7wtJh+kzkXuI7va9St3fqyR+p
	Go1BwXfS7kvxHzkUjvQ4YJUTH7AX/rymnpLVxvYmL9FBvxSDwbJb42A==
X-Gm-Gg: AYBFou1aaq06jpkSaAtXulZKq1bQFshfmYAVshtuPFDN+oPN/46O0mwC60+zxabVmZS
	k3Dib1MDm8UEh+qbU0wEQ4Yoe60hX/j8DX/Gr3c2kPeTRZCDL2df2+b936sUOKmW7yXZ3wemLZO
	gcIon28LOAbwRJCxyo3nUgA0WxrBD/R2Z399iF66aZw8P8Y5uPgmPX2StLR1dmLz37zpizHBeTg
	hACMvHq/fQA6hssF9I5FSW1rsf9UEulkfs8AN4bqmLctfwWK2HIMqWxjRMRSemswPUTQlDcgqNE
	bPivw4+csnk7X2/dnr3WznTZW2RxKqdKlf0+IAgxLWf67TagOHWrDAeWLgPpTux254/glu+l+2W
	XDm2xpohoO1sZOewuhtt4BT4pEOebpuQWyL2iWP2vU2A3Gu//qUwR
X-Received: by 2002:a05:6808:30a4:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-56b980309bdmr5402621b6e.50.1794493878289;
        Thu, 12 Nov 2026 06:31:18 -0800 (PST)
X-Received: by 2002:a05:6808:30a4:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-56b980309bdmr5402575b6e.50.1794493877673;
        Thu, 12 Nov 2026 06:31:17 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e24b33665sm42678b6e.13.2026.11.12.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:31:16 -0800 (PST)
Date: Thu, 12 Nov 2026 15:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock/virtio: bound the send credit by bytes
 not yet consumed by the transport
Message-ID: <avXMHPSHc2jtVESG@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-3-green@linuxhacker.ru>
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
In-Reply-To: <20261106050244.602625-3-green@linuxhacker.ru>

On Fri, Nov 06, 2026 at 12:02:43AM -0500, Oleg Drokin wrote:
>The send credit is
>
>    min(peer_buf_alloc, buf_alloc) - (tx_cnt - peer_fwd_cnt)
>
>where peer_fwd_cnt is taken unchecked from every header the peer sends.
>A peer that never consumes what it is sent but keeps reporting
>fwd_cnt == tx_cnt gets unlimited credit: every send() is accepted and
>the skbs pile up in the transport's queue (on a host, vhost's
>send_pkt_queue, for a guest that posts no rx buffers). The skbs are
>GFP_KERNEL allocations charged to no memory cgroup. The peer learns
>tx_cnt easily when the host side relays a stream it also controls.
>
>Commit 8ee784fdf006 ("vsock/virtio: cap TX credit to local buffer size")
>bounded peer_buf_alloc, but not peer_fwd_cnt.
>
>bytes_unsent (maintained for SIOCOUTQ) counts what was handed to the
>transport and not yet consumed by the device. It is local knowledge, so
>bounding it by the same window limits a lying peer to one window of
>queued data per socket.
>
>For an honest peer, bytes_unsent can exceed tx_cnt - peer_fwd_cnt only
>by data the peer already has but the transport has not yet released:
>
> - on a host, the delivered part of an skb that vhost splits across rx
>   buffers smaller than the skb: the peer acknowledges the pieces, but
>   bytes_unsent drops only once the whole skb is delivered, so at most
>   one skb (64 KiB);
> - in a guest, tx buffers the host has consumed but
>   virtio_transport_tx_work() has not reaped yet: vhost passes the
>   packet to the host socket before it marks the buffer used, so the
>   host's credit update can arrive first.
>
>Either way the window shrinks only until the transport catches up;
>nothing stalls and nothing changes on the wire. The writer is woken by
>sock_wfree() once enough of the queued skbs are freed, as it already is
>when credit comes back.
>
>With a user-space vhost-vsock "guest" that posts no rx buffers and
>acknowledges everything, one host socket queued 256 MiB in under 2 s
>(SIOCOUTQ 268304384, where the test stops); with this patch it stays at
>one window (SIOCOUTQ 262144).
>
>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM, and reproduced as above.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1e762a480df4..74a8fdf825d5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1031,14 +1031,17 @@ EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
>
> static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
> {
>+	s64 tx_buf_size = virtio_transport_tx_buf_size(vvs);
> 	s64 bytes;
>
> 	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
> 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
> 	 * does not underflow.
> 	 */
>-	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
>-		(vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = tx_buf_size - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+
>+	/* peer_fwd_cnt is peer-controlled, bytes_unsent is not. */

Would be nice to explain a bit better what we are preventing here.
Not a long description, just few words.

>+	bytes = min_t(s64, bytes, tx_buf_size - (s64)vvs->bytes_unsent);

TBH I found this code a bit unreadable, what about this:

         in_flight = max_t(s64, vvs->tx_cnt - vvs->peer_fwd_cnt,
                           vvs->bytes_unsent);
	bytes = (s64)virtio_transport_tx_buf_size(vvs) - in_flight;


Thanks,
Stefano


> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.56.0
>

