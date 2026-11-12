Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503079;
	b=A1XDEIFVfNupaMh1HPdmJximlf9PtYu4vqtbVOHj/8tO5Gd8oXnNVKYpuC2Q6FH9OIMc
	 Ms6yB7jsF7FrGw8jVN0zG5ZO7cOMriB9Az/dtkLVuqsF5uPQURDX+FFzlQyKRtaQiWECx
	 wKzyH9SpMFz11L/l5u08k+5S/9Nx70E7KI/rJLcjMJWaSIUZGMLSbnN7Ei2RjDSshglIv
	 xsvnzIhQ3lTItKoBPchwD+1NERUQWFJgJdf/yGUj9cnYZ2B9ERUWhYTtMq+O3UNyR+46k
	 rifcWtOvlYkKPDuaS5gPxfoZ5NIcWpoiuSbunkYlBCjBvgC+L29ssRVH+JHRa1vnVoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503079;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=VlBrhbrqQaaC5R776vd5/NFmMf/1maTdJjvb+hPLqxoI2T1ZKqJ3RfO3Cv0MWsCgxZqG
	 QRKRAuzQGwotXbSiMB6812mGmlEocSfUoVTt7JXbhSt7FpPnieT57c4g6qrrfhw8eZLd5
	 b/tT0BlvBC6y3ysYOMjyYxI/RB1sIRC4GSDM/szLuTS6mJud+0mQQExhGRzdbNbYBBpfx
	 SrwVxM3OwPmAzTzVPlX22LXywksNXhiHA8HLssPmj5DsS1igjjsSABvQKqNdoUeGRVPJ3
	 rkhuQX+AUHHxCFclP1slJ5AxXjn5QJvxZxo+3auuKYz5JdbZHGdMTq5/gGzGVt/tY/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6ri4AEr;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j1MT0Aag;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D2606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 17:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6ri4AEr;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j1MT0Aag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794503077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=I6ri4AErRxA6WV+hkDDx6zlpwp4PaNngP9iT6CGCdWaVb6KjdseXBqO/Nsq4GdELvSNWvZ
	pAhRhNEsMLP/YjiEq657e6e3Fx7or9rvSm4/dTWdHM49ItOw3jfKBlKAFSpM/vy6TkDCw1
	nrHuAIKHJ8k0nQSEjcUauxRUNpPWWXI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-tlLgT0V7NkW7yoqtZ7hLIA-1; Thu, 12 Nov 2026 12:04:36 -0500
X-MC-Unique: tlLgT0V7NkW7yoqtZ7hLIA-1
X-Mimecast-MFC-AGG-ID: tlLgT0V7NkW7yoqtZ7hLIA_1794503075
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c046843f1so644846d6.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 09:04:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503075; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8kyGXw6mTFdkdckckbpV+DZq0RDwN2xzE7+kFVT2atniGmey8Oi4yUNYp3HYz0vhI
         vB/IYYZyPg2wDzTLH7Df6E6ipZUIz17XfBMY7jVpEKjg8DwMPCYkpkbsH/MVm+0a1akd
         tzss8/8h2QTEH9spqGJRfyLSxgEzDuFzo/g4Vu8lnpE0IWfDJiuaxgnDb+DIAK1bMrWK
         5ED8JtmamoKjlDaVJpXN/iJVBeyTd1YY7VfoCCNlg+huVqMw8ANyMutR5gSIzwiEUzzD
         gx6DIoiWmzgOCjgKUlodQ3Xd8Rn2EWspEQt/IGXYDnnEpd6NVuGK0/WuZeX00ivxaP4L
         wmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        fh=j6vnxYeHorpqu2eIPxAJ+sFA848cLY5zpptBpCuQuTE=;
        b=VnO65tshnNXvuw5xDu33zzmr9x8mr8rquwfHBICcr11f7U3S+VXxXlxbPG5l2p/6UN
         R/k7NvzA38nQWdXxNPBRoA34xaUPIO8JPM37iA/GRk/jHaweMhLdpxuMVBmpU/dJ53MM
         xv5ux5vRINL4+K8oZmTgDzDkecjJTlOFq/BOHX1IY9mmmW1NPuWNLfXj2m8tujUL1KPd
         i/+OX5SxlcqDM7LortgT6PTrphN5mZau2are4OdMe5KtrYO9b6c78imjqUfW/fkbJ9pm
         A6QbpCiXYbvZGowBfg+pDyoPGijxx7DDmTGKwCA05jegUr9YdGyEHe/H9ZS5+5p3uQkN
         k/Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794503075; x=1795107875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=j1MT0AagyoJNEZdNKleHIZEQIBW9wPTUIkQC+rWJSyVlQRA6uuWD9QN3SRdvkg6y6J
         KCpCZcdctv7ZMKFJ2w8PQFu0vruy9/xKScfXgqScsEFs57t9xM8e3Kz+6q2g0XjkLBoJ
         tpCMgF1HVlVZdktMmJXFMJIQ0CovIEBFHAT26gCtwrkwA0cGswgUIVnUMjfHnmn6q2QS
         Q0CzFITPtni8av1b/xUltkMgM2EceTexQvdIAYmhb9nDnQWUQMN5bFqwrNhIAek+6zOg
         J3ydNWOw2mRiZLpbFqY44OWQ7DaIpEJ/a6JHmYt2e5UFCk89A8VvPVtRvNoFotYYNO5a
         5APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503075; x=1795107875;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=WJc0T6xGhlIi4QxOcr/XxkfOczelcZ8efH60fAryambvRHytZe0yHcKEGCPutdg8Bx
         +0kgh60iHxAr/yn4abIx/I+H4l6+Qo4xwCSLQsC4Nq+0XJy2OlyR+oMrcX9z0ggL8SZm
         OwFmVm9mpAlXvL8EeYWo5lWFA9k7a8slI19/bdqgEH1v1zJeyP9obZQyEZ/QADEe6zf8
         JtNRnO/EV9ubKfdCBK2uIL9/wsudMqyLUisLPEh7ZLg/mJDP7mXcKtHJ4FCSUXTM/tlP
         bkUbOhq9W03JiVefwHWUxlVpplAXpCGktdH/AJeJ5YKNbm2yp1pf9ki6PiQXnQ6bkFvz
         uMKA==
X-Forwarded-Encrypted: i=1; AL+hErGXHVLBrdhxOZ/uRganAh+hm7+b4TxYDQxHvm9Y7Km+Z9x37LIMLEEav+MB7sfKkLJWpuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8La3KiAJgyjNCcLzPKa6dO5kCvUYgABNw81jLahWqm1yXlW873
	Y+yApNWfcs+6uBD3kAqotnOiB542d+mqmLr5ytCvZgTSzXZrvG4go3JhxjRd+tlUDTERerPXcyg
	N1ToFXkmsyCIJ2dKvkajYXxe2b/EJpsJuieb5ksWxufDcgq49RD34GaejwpSizdtUwdxZqnrwp1
	aLrWuTad2aqksuaWxmBH4k23+Zg//8
X-Gm-Gg: AYBFou1LnWPcAucfmrRb7nuoVyndjjf8OL9FaQBoFzvLPAmrBEwmbmCPwgYRABPjmVb
	MRV8gCUn39guIq2Jp+DHlK1cpspwT15EE/3VBNjYi9CbL2Z4j5l8uXzRQ+UOARXIxPmZTUQUuHV
	6xbX2mQs1QCjKXy5mwjRzqUw2W/bGXcbAp+sBSeYYv3vUmXGGWDJ0y0Nw=
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91f040c0da4mr105370856d6.28.1794503075086;
        Thu, 12 Nov 2026 09:04:35 -0800 (PST)
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id
 6a1803df08f44-91f040c0da4mr105356616d6.28.1794503063345; Thu, 12 Nov 2026
 09:04:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:04:22 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org> <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:04:22 -0600
X-Gm-Features: AclHuK8-kXlDfbY9EpdjADOfLMjXVcZNZptS66ye_0dxL9--qQit5gRpAYjKWyc
Message-ID: <CAAiTLFVrvmrLoFxAdJ+ObY5trjgKvNJW5im7XaRQ+K1PG-_M-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
>> This series implements SOCK_DGRAM support for virtio-vsock and
>> vhost-vsock, allowing applications to exchange connectionless messages
>> through the existing AF_VSOCK datagram API.
>
> The cover doesn't say who needs it.
>
> Bobby and Amery took the same feature to v6:
> https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
> Stefano said there that it can work well and that the virtio spec change
> is the next step. The last mails of the thread have Amery's v7 WIP and a
> short list of what is left.
> The cover doesn't mention it. The spec change is still missing.
>
> Why not finish v7 instead ?

The previous series is more that two years old, and vsock has changed
significantly since then. I thought this deserved a complete refresh.

I should have linked the old series in the cover, though. I'll do that
in v2.

As for the spec, I asked Stefano and we agreed it'd be better to have a
series that's pretty close to be merged before sending the spec change,
and I agree that's a good idea. In fact, adopting SEQPACKET's strategy
for splitting up packets in the vq would have an impact on the spec.

> This RFC goes the other way in these places:
>
>   what               v6                        this RFC
>   -----------------  ------------------------  ----------------------------
>   (cid, port) space  own bind table for dgram  shared with stream. The 2nd
>                                                bind() gets EADDRINUSE
>   vsk->transport     empty until connect(),    g2h or h2g, picked in
>                      lookup per packet         socket(). -ENODEV with
>                                                vsock_loopback only
>   routing            one helper for stream     2nd copy of the chain in
>                      and dgram                 vsock_assign_transport()
>   recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
>                      no dgram_dequeue()        dgram_payload_len() is new
>   VMCI               fallback                  first. No virtio dgram when
>                                                its module is loaded
>   dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
>                      the error queue
>
>> Datagrams use destination-based routing across guest-to-host,
>> host-to-guest and loopback transports while retaining the socket's
>> transport state. VMCI keeps priority as the dedicated datagram
>
> A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
> bytes_unsent. They serve SIOCOUTQ only.
> virtio_transport_alloc_skb() does skb_set_owner_w() already.
> udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.
>
> Without them a dgram socket has no transport state, like in v6.
> Then no need for the owner transport, dgram_transport_match(),
> fallback_transport, tx_accounted, the skb destructor, etc.
>
>> transport.  Guest RX buffers accommodate complete messages when
>> datagrams are negotiated, preserving message boundaries.
>
> That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
> It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
> that each SKB fits in a 4K page").
>
> pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
> charges more than 64K to sk_rmem_alloc of the guest socket.
> The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
> queue is dropped.

Thanks for the review, I'm putting together a v2 addressing these
concerns.

Cheers,
Sergio.

