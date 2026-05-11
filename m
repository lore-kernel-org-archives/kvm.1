Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF836E493
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505495; cv=pass; b=UTdzNe3HYKf7cxZFymjvbrhmNX7a5x/Yg+YZpfw+Y8Xqy6NpcobhSLBlJivjDO8ByiQ5srjjxt8rgSu+jLk1/eceg9oQuDfbW4cGjaLOvZQgAZ3KEFIk908AriLU9oJdiTTmtZkjHGDrXcP8OnoLtmJ5qXBH1qvavovP5wvJF1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505495; c=relaxed/simple;
	bh=8m538UYatqrcDeaeCf1K8yM2CBjU8sYXskeMrAupKZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAELddWdR55bJjKkNzfDysJyEEmepEdosPMEaoOIoQkhn3qtTlH2hM7WPQ+zR/yqyrIXdYNe+VLijBQdJnwgOfCIt3dEuyDH9l7s2wSBMdszIJfKC9vd4aJJsLD+DNc6A6fuMGBKriGaHfhCxH8SpRXJg+0tD3nnSHVxOcK/2cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc4Cb+mf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nSCVlJZt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc4Cb+mf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nSCVlJZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778505492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
	b=fc4Cb+mfj6v1WGUXMeaFt1U7tsKVlKeHrgE7tQJ8GZK9Kt7ghsPoPBhXx7oc+CY+vHiy7D
	tjPGps+3bNC7uEhw2idAzHDESu09X+Nunp5yYx+ly40ientPJ/i19gwnMZyYwOEbw8DlM7
	eIF5kK71uXt5cG2dpxyqhR5SJ5LdCUE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-wg8WSlsNNAGwB0WM8CzUmA-1; Mon, 11 May 2026 09:18:11 -0400
X-MC-Unique: wg8WSlsNNAGwB0WM8CzUmA-1
X-Mimecast-MFC-AGG-ID: wg8WSlsNNAGwB0WM8CzUmA_1778505491
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bf0b47d2e2so90443587b3.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505491; cv=none;
        d=google.com; s=arc-20240605;
        b=G+IOiqmAox7PUmwaCpUKuRjr6dxTdFwHQWUD0PK/SQcMCJPqgQnlbQL9esBaorapVl
         sONUV9P2319UDh+s+3CiTiy1mLE53mDJttIKjEHuBScF6zgmoV4Vru11jZX7onphdgg5
         wpAKf7wME4z1wWUrRTbuBd6SCPRPzyYdbqzZ3WduCfsutI2oV6VJ3JTD5Xzukksz0NA8
         9CxgJUFnf0R0omIn//BwCs64rgosEwuexn2Nb2zlCEti2LUChahm+u0X41qRM1l88w56
         W0SH7kNiCuV+wQuURF5fSxR1+buMlqEsYeaxRS1rvzi7eJ4EYHoYU97k9kdvHXBvE9UI
         6cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        fh=UqR4QMOMC12QlX4XY7KkbmTFTv3n4tdpz+ikoEh1tRw=;
        b=k2P/XR6mDRFSKwcbFGnZOQskYxIHscMR7vVrOBu0bUXL7rtyYuzd832fn6byCpggNa
         MOBTPyH4C/abxoNZyb+0qJ6xw2B6KD9rbD4Rt3TfWcJoYVJBXEvbhQHaWlCLYGr6OTbs
         e1f6c3p00d/dezosOuAAC86Iogn2gAwI7WZcNFRo5B4+3ZNbIh/SyE9EY4iyoxzyJv3a
         L/T6WA9Hhcbv4fFv7ov8zjeeUQg9QgkxonFXCzlG0frckBVpLAT51guuRfxPGsUzeAf3
         CYeiIUIthmI8lLHY4Ne0l3CuRD1C4pkijPsXvKmbhHlWWwYVNN0flEEuNiFhwckNAOPl
         cwbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778505491; x=1779110291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        b=nSCVlJZtLnl3MK07OMC8YwPpdBxtJ+2vQ16MyCVkKia/GqoOGOh86HzYdWYPWI2d7c
         +kIFHnm4bYMdNYSVRZWEIY/Z5K5uFXXsFVm92YBSv5rocZPzkZ5DtsPdsjZ8psjNgUkS
         kEfOACVg67FkPlQjjt0m8k9u+qgV05cpb12mc6yWXY7txgFF/e/U8321PV4ODJ9suU7C
         pNrs12sK93si1ne8WFtk2Ovdj7T6iVPQ3wEIAo0ccFDRPk2Cz5GOvNJv5maXDPZQASSz
         nznQ6Ujbyc1l2aEbC0jWJJ3ssV73YZ5XFzVTDLUqigNvhpVNKHsS4d0q0fynM6lVp9Nn
         K+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505491; x=1779110291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        b=GTnk0VYPz8j6QeALyiT3T0NdEOYR2V1UnnYYJb7bhddCiUCs4zhCPF214Y/NYU3iJu
         Z+yzCxNCe5wBLFIKsl9AR2llqlWu8x2RibmW3eWDgF+wIppGciPbjRLqe4BaiwrHmLuk
         PvZyoSfXo9Ao69HZnu2yZE53TZNtofrEFXLgTA1xnCBWEOyhEd1pEk+7nDUisNASCxeq
         9QjDiNmKqG+98Aou8ndDg/0tS03XemjuHKqU8rEf1KUNbSAiIktcJUr6Fkq6NhISBpYx
         UQApkz6FoRcQVe4oqkTPoMZyRbzV245SNayhi7x9AI5jqT1eh9hBq48lh++PNhACRcba
         znaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rKu+94u661e1aAxh0bXpAFoX+M9w3JvUSvucg7g7nJICToNdVCfoUg90ZlSpG+2VlOEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOkE9/WXSFFQlo0WnEWe0Nf116aDbFs0jFc8+biGM2gZOUspt
	+mvvzmwavl/w8f+kmQT6OH5ZeN8CLvH9dlb01z0NhwbuSQoj7fckWBPmupn9zdOdkeEXMBBLsij
	7eTW/CRE5s6p9rJZmh2dA1HuPR1h7i62e2iOYhrsIX0zQnxP7lH8bP1l++zdwiUaVglwE1nRdVZ
	EV4FXvgarwkaGrXwo/hNjfiSNjfcRA
X-Gm-Gg: Acq92OFYhaopKp4V9fHpGZeLww/6wnMIDwiTbr7h4NtFHJrLX+cHq6wmsBPkT5idvEx
	xOh14v5XeBS4eWYQjmP9Rpz9ztEUeUGg4eVgc7oEOIT9wmfEPv+52wz9ximK0fapWh8Lis+zN6t
	4SHey+8/0piQtgnWU0Zl1UnJXMQ9d4D7bAkYHHuAx9R1beQ7dFDdyPlrE7OXCGOmXhQDnDpfe9H
	ncLEH98MiL1zRRu
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7bdf5e02b03mr239670647b3.15.1778505490909;
        Mon, 11 May 2026 06:18:10 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id
 00721157ae682-7bdf5e02b03mr239670197b3.15.1778505490349; Mon, 11 May 2026
 06:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508092330.69690-1-sgarzare@redhat.com> <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat> <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat> <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
 <20260511084551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260511084551-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 11 May 2026 15:17:56 +0200
X-Gm-Features: AVHnY4L6LnZli-Ox_nOVNet2zhzvaOzPcipKZYQZqFtNKms-_nGPKvzOHkJ7hsQ
Message-ID: <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve
 full buf_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 14:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> > On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com>
> > wrote:
> > >
> > > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >> > >
> > > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > >> > > effective receive buffer below what the user configured via
> > > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > >> > > silently dropped and applications that rely on the full buffer size
> > > >> > > to deadlock.
> > > >> > >
> > > >> > > Also, the reduced space is not communicated to the remote peer, so
> > > >> > > its credit calculation accounts more credit than the receiver will
> > > >> > > actually accept, causing data loss (there is no retransmission).
> > > >> > >
> > > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > >> > >
> > > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > > >> > >     Resource temporarily unavailable
> > > >> > >
> > > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > > >> > > check, the advertised buf_alloc, and the credit update decision.
> > > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > >> > > The function returns buf_alloc as long as overhead fits within the
> > > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > > >> > > slow down.
> > > >> > >
> > > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >> >
> > > >> >
> > > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > > >> > it helps.
> > > >>
> > > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > > >>
> > > >> >
> > > >> > a spec violation because the spec says:
> > > >> > Only payload bytes are counted and header bytes are not
> > > >> > included
> > > >> >
> > > >> > and the implication is that a side can not reduce its own buf_alloc.
> > > >> >
> > > >> > no guarantee because the other side is not required to process your
> > > >> > packets, so it might not see your buf alloc reduction.
> > > >> >
> > > >> > as designed in the current spec, you can only increase your buf alloc,
> > > >> > not decrease it.
> > > >>
> > > >> We never enforced this, currently an user can reduce it by
> > > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > > >> introduced, should we update the spec?
> > > >
> > > >
> > > >it's not that we need to enforce it, it's that all synchronization
> > > >assumes this. as in, anyone can use an old copy until they run out
> > > >of credits.
> > > >
> > > >
> > > >> >
> > > >> > what can be done:
> > > >> > - more efficient storage for small packets (poc i posted)
> > > >> > - reduce buf alloc ahead of the time
> > > >>
> > > >> That's basically what I'm doing here: I'm using twice the size of
> > > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > > >> the other peer just `buf_alloc`.
> > > >>
> > > >> But then, somehow, we have to let the other person know that we're running
> > > >> out of space. With this patch that only happens when the other peer isn't
> > > >> behaving properly, sending so many small packets that the overhead exceeds
> > > >> `buf_alloc`.
> > > >>
> > > >> Stefano
> > > >
> > > >what is "not proper" here, it is up to the application what to send.
> > >
> > > Sure, but here we're just slowing down the application by telling it we
> > > don't have any more space.
> > >
> > > Again, without this patch we are just dropping data, which IMO is even
> > > worse.
> > >
> > > So I think we should merge this for now, while we handle better the EOM.
> > > If you prefer, I can drop the part where we reduce the buf_alloc
> > > advertised to the other peer, but at least we should drop data after
> > > `buf_alloc * 2` IMO.
> >
> > Okay, I thought it over over the weekend, and I agree that this patch
> > still doesn't solve the problem and would still result in packet loss.
> > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
> > coming to stable, I'd like to rework this patch so that we only start
> > dropping packets when the overhead plus the queued bytes exceeds
> > `buf_alloc * 2`.
> > Removing the other changes to reduce the buf_alloc advertised, but
> > terminating the connection so that both peers are aware that something
> > went wrong.
> >
> > Any objections?
> >
> > Stefano
>
> Let's try to first fix it upstream properly please. Discuss backporting
> later.

Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue") is already in Linus tree and will land soon on stable. Which
issue do you see on having a patch on top of that to close the
connection instead of losing data and breaking our test suite?

IMO we need that change in any case, because the previous code also
discarded packets without any notification, whereas breaking the
connection would be better in that case.

Stefano

