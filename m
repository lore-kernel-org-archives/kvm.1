Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB93BED43
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584682; cv=none; b=pFs6csJ0smuSluxwZkxWqjUpNdiSp/WZ28Kcl1W0FWm0OI2h9+5JWChiPdG0x4o3gFlPfGU2e21fVt0mc3kapCJs6GSJgotit1AENlnR38DHvYSH/XNVuRxSyKZJSn5AdQgeq8O719Z8yaq6EeY4TUNEruV19XViSnb+0TXUZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584682; c=relaxed/simple;
	bh=3pilreO7Jxj4wUh3RXkY1+6fibHwDc1PkYQ0dqDnEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAsDDlwjHX18/1N+DgzuebhhMcqnA/S0PfnsbSMqK9Bk6VgxFv/UYhPsmpDUNR9BEbnrdyC4bLxgPcv1tPxOIinIFKqz1+HDCIOZsEMat0GKA8kedqWSXrHxtiG/P/fmvpbwiRTpCWNXErdSoO8qhgaic0uXuCjpNTFZqpETaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBAvkLU2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRuX/FN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBAvkLU2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRuX/FN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778584680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
	b=jBAvkLU2Iup9kO1Z2nvhy+d6NZJj/gyve01FmKWU6HKJ2EgOVbn2P7clbLHzthjsE+7qlO
	SumMIuJaTFQPMA7BnwyqepJ1nFetxk8yqly2PMwmw5k+vrX/8VDk+QI06tdD7ZbnqvQC5N
	xJaQfAyJT4ma9PF5nWPCOVOgvi8YdYA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-o35qxJ3MP5yeDhSSF3KGGw-1; Tue, 12 May 2026 07:17:59 -0400
X-MC-Unique: o35qxJ3MP5yeDhSSF3KGGw-1
X-Mimecast-MFC-AGG-ID: o35qxJ3MP5yeDhSSF3KGGw_1778584678
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso5161596f8f.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778584678; x=1779189478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
        b=fRuX/FN6dm1C0Ye5oQwmlUqlEQEwx8xz3DrkfMms55t6vKjxQHnQ/FWUSH8OuJDu5H
         UbmgSKwuTPHteKN0LRKiNbRwKEr2u1ltkKOcpEOjnHqI50i0WxgW3OqZSVexGdbCDla/
         aA/Jom1jsqTrftAQipTz9t8gASuO+dxJ2JRDU5CKa2g8rHFmWXR9lJJwX9ku0pee0E7c
         6aKLNHac6hiYlFRFwHt4EMRS83p24An5OfSwmOImKndlBoVot+S7WA4TEqu/Gx5lt17y
         vbR4OBrVdMnWJwYfOJK8+QNbw3fRY3fx0Qpty58z7I3eauiszpeWy6XUIJ82V+6VEDvS
         vt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584678; x=1779189478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
        b=aAlAdqLw8tbJYyOYRWL4esk1D4VSYTIRdaXlZC8qzms2Q+0NQBNpbfcrBaRqd2MdNX
         BVFC8vAUoZdjXoJvdEeFSbFemhvmugJoolECkkPU/gJgLltdl9DucXZi0ruDHFXrXT3w
         +nKQX8zxd6Z+PA/P/Vlom+fl1tU4ygZQV0bZXzU5f3T9/Y6J8kVB1BsUq0lsb8cTO6yO
         eiAMbnS782uw9vvalpQPaEPxQ4B4Fv3tvmHg61whaUIpHOpdFFOOincsWUECTIb0du3J
         gpbFJOK8Zlu1N8WpT32H6HRAlbY4s3S8SV2snpYHya6fLUNlIHlHy3wEZdExDnN/NFFe
         gcxA==
X-Forwarded-Encrypted: i=1; AFNElJ/5qYSlZ8IoaKtm2//+BM+ObF2IliUcolK5t5SMCu3MScTWKtJJPI/WzWCBsQ3GCPRrLzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjCY5S/a8aCuyK+ThO11Ic8X8QEQZWF+PVkxBiwb/4cR6lDm6
	JzK0xoiNxCJiKqrvROcP4KmDBBq8deA12koWzcAmpeX9ggOcZZ3K0ryIERFbVUPOQGU6UNlT0IP
	FJfxNZVsq3Me7fStPXOjmkV39khDq/v+jNZ6OZMinAbKxP5tQMyfiWA==
X-Gm-Gg: Acq92OGJPKlQ8H8Vv0B9+9nJn9LheJoNyQOBFvQ0Gcr8zPo7F8UD6Ckbu6pmwmaEUQF
	D0/dH24txhvNemR/RCPfoj1TxEEHCXEb6pg6BSKv2lzymyw3OWqpt+KU7QpHN4ydFJT0feT/3aO
	geGkDoPNYls0KdIz+Za8YW2YouPxNgsfM7chehaT+txtYIAGWKHejOf+UNgmGEp7OMj50NYZoDT
	0wEOMmfxKT4VMoOSf+JWnlwcv0OvE/ZurT9IwW2ZSRHIq/KG5tDf7IjJVCmZBEaz8IFNEUX0vD0
	iFUCFNNyDZsn12EUvJ/ocgWNNwyJEwapbh+tkznvCjwKX1ESTC2hAdwTWf1DaxVzdoo86HhCB/d
	628aCmMPCtvc1TV1ZOzYWVwJuFc1Wp9M5lxTnxkXB
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750825e9.8.1778584677967;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750065e9.8.1778584677428;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm26866475e9.1.2026.05.12.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:17:56 -0700 (PDT)
Date: Tue, 12 May 2026 07:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512071726-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
 <agL0ewq9R-Br9mUh@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agL0ewq9R-Br9mUh@sgarzare-redhat>

On Tue, May 12, 2026 at 12:03:38PM +0200, Stefano Garzarella wrote:
> On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > effective receive buffer below what the user configured via
> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > silently dropped and applications that rely on the full buffer size
> > > to deadlock.
> > > 
> > > Also, the reduced space is not communicated to the remote peer, so
> > > its credit calculation accounts more credit than the receiver will
> > > actually accept, causing data loss (there is no retransmission).
> > > 
> > > With this approach we currently have failures in
> > > tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> > > test 22 always fails in this way:
> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > 
> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >     Resource temporarily unavailable
> > > 
> > > Fix this by using `buf_alloc * 2` as the total budget for payload plus
> > > skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> > > is doubled to reserve space for sk_buff metadata. This preserves the
> > > full buf_alloc for payload under normal operation, while still bounding
> > > the skb queue growth.
> > > 
> > > When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> > > flooding where overhead dominates), the connection is reset and local
> > > socket error set to ENOBUFS, so both peers are explicitly notified of
> > > the failure rather than silently losing data.
> > > 
> > > With this patch, all tests in tools/testing/vsock/vsock_test.c are
> > > now passing again.
> > > 
> > > A solution to handle small-packet overhead efficiently also for
> > > SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> > > This patch is needed in any case to prevent silent data loss, because
> > > even if we reduce the overhead, we can't eliminate it entirely.
> > > 
> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Thanks for the patch!  I'd like to split this:
> > 1. buf alloc boost
> > 2. reset when out of credits
> 
> Good point, also the reset maybe should have an other fixes tag (i.e.  when
> we introduced that check)
> 
> > 
> > this way we can revert 2 easier later.
> 
> I'm not sure if we should revert them at some point, even though we'll be
> able to handle the overhead better,

I mean we'll prevent the overflow, the condition will never be met.


> but I agree that we should split them.
> 
> I'll wait for a few more comments and then send v3 with the split.
> 
> Thanks,
> Stefano

