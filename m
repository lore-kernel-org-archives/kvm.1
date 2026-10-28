Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208334;
	b=BD3HydQ28CFHqpB8hfNwnVyZJd2rdfcfw6WtR3CxnDZi7kfYeWcJgQM2rsOlKI2cIANz
	 GDahR2A9AvWEYPVJsloOPp21QQj4RJKsLsfEpcJ5Y5uEc+eOuNdET7+Wp91CHEYIlgVTd
	 y0UVxFMy/JlS2uRd7hA/2GpXiUxZAGMgCNtu6AMBUzWlsxUcKID2PlcRozL65rAnYGyHc
	 enlx/A4dOZbZ0foRxPoSoM0+S/tK7fpXx6W0kiMBec6MAocEztJJUO0iG/KPnOWlvxZfd
	 VnKUci0l0NFybRLx/RYqSxcWGApKEUlXwbVOCt0q8cYJnWTrUvIkJMeBYP/GYICKAyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
	b=YhymmXoLdMrzecFUszGIyNVIRNN+VkBRepFVChx6os+ODXr8WJ8KX/Ih5T/fMOV3M7JF
	 kQzJndiRzZhLpwChHJpseMVqjduChQmrWgcpzST2bWvxQJRlB/rWvbCc11K3itq1755Kv
	 ivQUDUWBhzXivO2+qIu7MWpM1Lp6oCWvFAY8N8LSH4rtbRY2P3XNs+xm3GE+Emr+jcq6B
	 fX5yryssIlWkAfNtsV4BiBpulkDcfUuu5zvufZHkyE9jg9nt0ZqdSbduyZg59raHzpx1k
	 KVFnAeUmE1aJImQQYDvyVGZq1PJJHEh5I5uVZP2Fw7M3LrqxhgIQ/DxDawlTIi2xZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af7y52Ro;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850C606A321
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E850C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af7y52Ro
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc751eddf25so889820a12.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208333; x=1793813133; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=Af7y52RoNQXZRESfNzlA5nWU7zYO0dfLPezS+5rNH3Tx4+4DsnOMyhABRaQvfQPhli
         WGDEJ6zWLk88idrS1IRmCJxUBASFuuPGGngNzQZZ7LzmANcSte3aAEFKuC2VjHtOK2z7
         yjKMj+n+y7innZ39T/IQMUNxUrOFGpd7ZgkibuW592Y5ybQz3HYIMsH9Gk9Vo/7F25Aa
         q36OaknOzdG878FRgHSj5M2t3J2VawgIYj7j4isik5KORWNcsNhJEboFyrcCLGCCUvS1
         gSvujDxwZjfi6G+bKCVFt8XzBT2Fk2cA1mp2Ztj8lzO/DQBvE/UHm9uoMPtJq1mQY/nw
         HIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208333; x=1793813133;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=pTiDe7v+oKAtiGFWs4OtTOSy2nnD+5fc9f+ScWbA7evKIGY9/R12EajZ/+Cjg/Kr90
         mOkQ0o96i8AQ+7mNr5DTLIynTpLjusrP9vhKeFnUp/jH04PySWxk3ImyQrL184cVxg+j
         gFkKvFQaXQbafgcCWF+boXArP/v+uouZK7hWiw4yYqtv1hUP91GJoxYfcyRr3BZn3Mas
         EC1QidnSMh2eK8OI0njjjzZZTVD+aXGcnC+mYgng/8r7ECWQZSM3WEwHhAfAtemFGY8g
         w33lp4Sz6qxyIZEci3Tn1P/u+PwsJdMIOjMWg0wMvpFBg5lZMBXK2s12pWL8Z8nTVQuJ
         nvow==
X-Forwarded-Encrypted: i=1; AKwUvBy8gUAhTTsdLGhpXUDt7GHQQ3Qpl/xJt62J8nZff7K10Dae8E0EGXwLUshjo3l1JaRUcqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrQ5eWpkb9rreEePUUUsJuMaJS54WBFTiRIZ2MofC6eHfukT4g
	devjj33SRmhkuiWmOoDKEAc9g6aMY84M23eTJs/PKXTocdtF7zJzoM0H
X-Gm-Gg: AYBFou000E5NZsjyBrj0GMqVdSy7y9d0rhAY3L2TGOWGTP5A+fKGOM9OkfEENDtxwH9
	OOyrbRGHW58kwO6VtmHuc5mAMTDRG7iZyXjWyrrFc8Rjb2xudtixXNtvNqaIt9dzCD/a45epv5s
	8ScsD0MJgmWVr0auKUPI6BULcyQpwDxer65/9iIv9BJcmFu7EexFa0yTMMvT2644CPeZSupIkOz
	vgdJFd5et9e8hP0+FuT1BNhujCQHNwzkbOOkrDzYQhR/Mufu1B+EpbnbGt0+Z2o5KMR4E8/DD3S
	LGUu2CZpRfeDGOUWCnvyzbyDZ4aCXYrFPEHWsY7vX/d/cq/DbXk7LnhymtRk9EY6Y8NPcZFNPdv
	UcGDg8AL7Y2KQnSFufBDePpovULUlEISC+NeOn7lJHkvJbY8fMFjABaYn7gTdpgZJfLJ//zHPtB
	cA8InUTEK1pfBFz0TPjvdVIOqr37vv/jk5poPiBfLKNlyncvJM0R5nBQa8EownX/SpUtsWVeIyz
	UGAPmHZlpqvKDaBILu0/Xi29A90SgT/gKI054qFW7VdWFLMOzWERcZyrvNJRgw0/qQl1ybgaTH5
	YB9lwHElFUWoEJUTVBn1WBgCibaAE20ZTrrKX8iVjaBMLQ7KN7P3ykqUycNDjfKgtxltYJvuxGZ
	l8xBI4BgnPCm8DnKaCLb5gyYF1L360KErMg==
X-Received: by 2002:a17:90b:3a46:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ae581b7b3fmr2290113a91.10.1793208333116;
        Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm397200a91.10.2026.10.28.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:25:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:25:31 +0000
Message-Id: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sergio Lopez" <slp@redhat.com>, "Stefano Garzarella"
 <sgarzare@redhat.com>, "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Bryan Tan" <bryan-bt.tan@broadcom.com>,
 "Vishnu Dasa" <vishnu.dasa@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Stefan Hajnoczi"
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang"
 <jasowangio@gmail.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, "Haiyang
 Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>
Cc: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-hyperv@vger.kernel.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
> This series implements SOCK_DGRAM support for virtio-vsock and
> vhost-vsock, allowing applications to exchange connectionless messages
> through the existing AF_VSOCK datagram API.

The cover doesn't say who needs it.

Bobby and Amery took the same feature to v6:
https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
Stefano said there that it can work well and that the virtio spec change
is the next step. The last mails of the thread have Amery's v7 WIP and a
short list of what is left.
The cover doesn't mention it. The spec change is still missing.

Why not finish v7 instead ?

This RFC goes the other way in these places:

  what               v6                        this RFC
  -----------------  ------------------------  ----------------------------
  (cid, port) space  own bind table for dgram  shared with stream. The 2nd
                                               bind() gets EADDRINUSE
  vsk->transport     empty until connect(),    g2h or h2g, picked in
                     lookup per packet         socket(). -ENODEV with
                                               vsock_loopback only
  routing            one helper for stream     2nd copy of the chain in
                     and dgram                 vsock_assign_transport()
  recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
                     no dgram_dequeue()        dgram_payload_len() is new
  VMCI               fallback                  first. No virtio dgram when
                                               its module is loaded
  dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
                     the error queue

> Datagrams use destination-based routing across guest-to-host,
> host-to-guest and loopback transports while retaining the socket's
> transport state. VMCI keeps priority as the dedicated datagram

A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
bytes_unsent. They serve SIOCOUTQ only.
virtio_transport_alloc_skb() does skb_set_owner_w() already.
udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.

Without them a dgram socket has no transport state, like in v6.
Then no need for the owner transport, dgram_transport_match(),
fallback_transport, tx_accounted, the skb destructor, etc.

> transport.  Guest RX buffers accommodate complete messages when
> datagrams are negotiated, preserving message boundaries.

That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
that each SKB fits in a 4K page").

pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
charges more than 64K to sk_rmem_alloc of the guest socket.
The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
queue is dropped.
