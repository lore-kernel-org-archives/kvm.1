Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C63D7D6A
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366685; cv=none; b=CazOn8UQaNQK7BUnB7aCJdzk8OsE5qaThjF0fyoLgMyiaRqupIvmdY9ZezSBY5oZFXug8GxZoqz7rg/k+6gRoE6/EHMNaBwwJeZNtl4hUxaTbpC14yTt7dnu0wGTNQipcIPT4NyhbiT00eLJiM8dZPA1r5CvGzIvFGJ2/YZGbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366685; c=relaxed/simple;
	bh=uRW8e72Rqzipki+9LHRLNLqQmu5KdCJEOG4HG3wjS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7DbarSHyN2jjNUy0UADwqrpRhxGHtxgV+yFfvmBINxOYE27cl35oxlYnsFK/WzvsFQbGxvEKRqg2VoqatSppKVd0KWZqnHjVMVEDDAvRGZatogPb14ozJJstwVnN4F0shV6Br1apHzYClQeWEgP8AlkON+qaZaBLK9Ji2pSVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3wtYt3e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAwM32SR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3wtYt3e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAwM32SR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777366682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
	b=E3wtYt3eUxBGj12tW/gIcz50/XmiZPJMM0HzbpTs3U7o5qgwidg+7DAfBSV6siDD0Fi8Gc
	FnflyB0U9xEIiTOQof7fTtKlG09VTJytbYGkZHT0xcumbzFFCR41j4w/vxWJxp7rckVqsB
	/OWxwKlpx1xmzcNHjGCmdSCT996c5+M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-p-bf-w2yMfu96L6kMpKfGQ-1; Tue, 28 Apr 2026 04:58:00 -0400
X-MC-Unique: p-bf-w2yMfu96L6kMpKfGQ-1
X-Mimecast-MFC-AGG-ID: p-bf-w2yMfu96L6kMpKfGQ_1777366679
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so9028880f8f.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777366674; x=1777971474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
        b=OAwM32SRVUIL37zmjCtBd49J8Q3ecj9VpYAuKE/n947vXGaniH1Gyy7cJR5mQw6Ake
         SB1m/ewoTHsEUYt1VHUn9zsf4PPmZd1nM5e723O61RdUCV/QGLjO0bHDdA9hct7VqlXS
         LrX2n8Z4QVhp9fqRVaHTzt+nLpAkBgNBg3YcUcQqWb0L25CIOY3Yi62EKmjb3f/d/INq
         sCznr/pjENHq5VYyhAVneyWUyrVA9FIPdUBMXBdg77xnx+sEPLf6DT0yX57SREB8bRcH
         6LV1DDZldR7O3ja9+Mz8SCaWj+zWqLj8Ek/tCGS1zBni044cG9w8i2Erq18CTDGPlTUy
         yq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366674; x=1777971474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
        b=M8oA3vViuKxYHZJ9iAxwyvITiptLNJApIgq3k9bLcKTLCQotO8+1KXcMSfUe8dEAja
         O32EjLgR7qivYtHbhR3ZslWyG3wmxZZ1YASFz9URWah7UtjLqgPwWNjQUhHQDWWKT1gf
         tFCagN6P8CCR4p31qD4P3HAgrGW5XW9dgI20ZcSyhgL+rBoywM5N+BdggMWVD99418pP
         CammDAzfdrwd2u0wCXsLjMQ46egYtnA78UFFIpiE2aItYJWXeobWGTUpkHa5wYUMKMZz
         r6FrOpCdG3aL1EcP41gK8WzIQdpqO9oP/++MVWzbKoR82I93BaXehtRCGsGPizOYXOhj
         Kzqg==
X-Forwarded-Encrypted: i=1; AFNElJ9203u4kCzgFpgIOX6hOEmkunYxCZKH8ZhRcHcCDEcx5q+nkAe0SWf2jGDB/Ijttf0stP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYt2kyzAJ2Nt81l2rrLZ4gQY7bLo361y/ZiNCrbYU4L/yT1X+q
	g5oM+Hu+M0NvVDj4q8/GE3l1XTHCmVkwRZxLvH9wZeB2A6pi8v2CJ3AWu2SN8+3MYuIXHGWww61
	x+TaujKR9NA/kVHxyekZI0x+7RfMiI6In+3g6eVcIn1z/Y+8qc0lBfA==
X-Gm-Gg: AeBDieutXznXoBZeZM0P3a/DP+ZXTog/yvz/duMzQUUzqaxKsrco/r5tM/4+C9KSIDm
	ckFU2pFt3t3uHOx7INk3tRPEeJK3jLtqvXEeyq8c6xB1YIlZVCMnR6H8y2ox2OntGdOBqv+WRs5
	+fjy2IL+rOtk99BeXrT74QDcXub0x8dO/xSzewl2c2WzhQMVwP5SXtGW76tGjtD8pThIw7KTNKO
	hOT+XI3vdKy0HgOx/jHSWjKgXyHVO6pY23wpyaU4bS3ZxeyKSl4NeEaNMecm1M2LAsvWzbDLeIl
	PGd+YztDsGTKd9kUZPEu+vdXh1PYjgsyAkUgmflVO4jSEMLlxRnAEHdPCTQzvHRzOGIC7v4fFy8
	qo3YAqysYmNszDQQwAdKE7ZQO/nKMcJ7aZlppk3A4b39KjUcx6OnCz0wFfSY4vOdtCPOJ86GgCh
	51JjGqkg==
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894582f8f.33.1777366674233;
        Tue, 28 Apr 2026 01:57:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894514f8f.33.1777366673658;
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fb7e2afsm4634086f8f.28.2026.04.28.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:57:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <afB2QCHtoREOV6ml@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
 <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
 <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>

On Tue, Apr 28, 2026 at 01:54:36PM +0530, Deepanshu Kartikey wrote:
>On Mon, Apr 27, 2026 at 7:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>> >Two bugs exist in virtio_transport_recv_listen():
>>
>> Two bugs, two fixes, two patches usually.
>>
>> >
>> >1. On the transport assignment error path, sk_acceptq_added() is called
>> >   but sk_acceptq_removed() is never called when vsock_assign_transport()
>> >   fails or assigns a different transport than expected. This causes the
>> >   parent listener's accept backlog counter to be permanently inflated,
>> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>> >   connections.
>>
>> Wait, I can't see this issue. sk_acceptq_added() is called after the
>> vsock_assign_transport(), so why we should call sk_acceptq_removed()
>> in the error path of vsock_assign_transport()?
>>
>> Maybe I'm missing something.
>>
>> >
>> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
>> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>> >   the accept queue under the parent socket lock. However,
>> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>>
>> Are you sure about this?
>>
>> virtio_transport_recv_listen() is called only by
>> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
>> confused.
>>
>> >   This means a child socket can be enqueued after __vsock_release() has
>> >   already flushed the queue, causing the child socket and its associated
>> >   resources to leak
>> >   permanently. The existing comment in the code hints at this race but
>> >   the fix was never implemented.
>>
>> Are you referring to:
>>         /* __vsock_release() might have already flushed accept_queue.
>>          * Subsequent enqueues would lead to a memory leak.
>>          */
>>         if (sk->sk_shutdown == SHUTDOWN_MASK) {
>>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>>                 return -ESHUTDOWN;
>>         }
>>
>> In this case I think we are saying that we are doing this check exactly
>> to avoid that issue.
>>
>> >
>> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>>
>> Again, better to fix the 2 issues with 2 patches (same series is fine).
>>
>> >and re-check sk->sk_shutdown under the parent socket lock before calling
>> >vsock_enqueue_accept() to close the race window. The child socket lock
>> >is released before acquiring the parent socket lock to maintain correct
>> >lock ordering (parent before child).
>> >
>>
>> We are missing the Fixes tag, and I think we can target the `net` tree
>> with this patch (i.e. [PATCH net]), see:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>>
>> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
>> > 1 file changed, 11 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d..fad5fa4a4296 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >        */
>> >       if (ret || vchild->transport != &t->transport) {
>> >               release_sock(child);
>> >+              sk_acceptq_removed(sk);
>>
>> Ditto, are we sure about this?
>>
>> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >               sock_put(child);
>> >               return ret;
>> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >               child->sk_write_space(child);
>> >
>> >       vsock_insert_connected(vchild);
>> >+      release_sock(child);
>> >+      lock_sock(sk);
>>
>> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>>
>> Also a comment would be helpful here to explain why we're doing this.
>>
>> >+      if (sk->sk_shutdown == SHUTDOWN_MASK) {
>> >+              release_sock(sk);
>> >+              sk_acceptq_removed(sk);
>> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >+              sock_put(child);
>> >+              return -ESHUTDOWN;
>>
>> Since this is very similar to the error path of
>> vsock_assign_transport(), I think it would be better to start by
>> defining a common error path for the function and use labels to exit, so
>> we can avoid duplicating the code multiple times.
>>
>> >+      }
>> >       vsock_enqueue_accept(sk, child);
>> >+      release_sock(sk);
>> >       virtio_transport_send_response(vchild, skb);
>> >
>> >-      release_sock(child);
>> >-
>>
>> TBH I'm really worried about this patch since both fixes are completely
>> wrong IMO.
>>
>> Thanks,
>> Stefano
>>
>> >       sk->sk_data_ready(sk);
>> >       return 0;
>> > }
>> >--
>> >2.43.0
>> >
>>
>
>
>Hi Stefano,
>
>Thank you for the detailed review!
>
>You are correct on both points. I apologize for the confusion — I was
>looking at an older version of the code where sk_acceptq_added() was
>called BEFORE vsock_assign_transport(), which made the
>sk_acceptq_removed() fix appear necessary. In the current kernel,
>sk_acceptq_added() is already moved to after vsock_assign_transport(),
>so that issue no longer exists.
>
>Regarding the lock_sock(sk) fix — you are also correct that
>virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
>virtio_transport_recv_listen(), so our second fix would indeed cause a
>deadlock. I missed that completely.
>
>I am still investigating the root cause of the memory leak reported by
>syzbot. The backtrace points to the vsock loopback path
>(vsock_loopback_work), so I am looking there next. I will send a v2
>once I have a correct analysis and fix.

Okay, thanks for looking into that issue, feel free to chat here, or in 
reply to the syzbot report if you have some new findings.

Thanks,
Stefano

