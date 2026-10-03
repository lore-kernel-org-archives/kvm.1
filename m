Received: from mail-qk2-f27.google.com (mail-qk2-f27.google.com [74.125.230.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EA35C6AC
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071653; cv=pass; b=A9u/P2NX854KoKOaQjhIQo9q1Cw1TeD6GNaPTW1rSiOZeHQaWwIiMFn4yyKo0ds43WhKKTWwpVIOnDRWywHe7fxplAmVHMg/0SlopQG+gQF0b+v5bVy338OTPqG3QI0wNlftJshNrMn20Ej25+QdvX2d+WYQYs69ln9w/h+zseQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071653; c=relaxed/simple;
	bh=tLQXED6TnpPW56Dh+KHvxT+XAjreuYSqEVzU3htBIms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iK0KYGRm1Kxf9p0VVAAk3AxJ5xbSENxGZfqp3psbJRoGs1wUwH+9f4TuR6QM/ltf/8+GsmjDx8yHAcE1RexgYB10ogZOvI0Ut70PovlyMegsFdMsY917R7pNXp4sY27Euol+1ff4JuJK5BWeWx6QfD/vhsYrrS9jF/jPtdzJj/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOTLx3vb; arc=pass smtp.client-ip=74.125.230.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOTLx3vb"
Received: by mail-qk2-f27.google.com with SMTP id af79cd13be357-939ca12ab70so62128785a.1
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 16:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791071650; cv=none;
        d=google.com; s=arc-20260327;
        b=FOCVHYpN6/iwU4WW2FtMDunXZcGaQGvkbnJpq++1AqrtLIiLj+G2YKFts2AmLot+u1
         bpIZ5fgjnPNlQGyNH1KVG+MXXuIvg5ABzwhnMKQpQv0pMakx9NjT7ZTsIkrfoMvhpQTm
         ABaOEha2JliTDHc3iEJOJI3KqdQsdV/aomK5vEZC3kCSayOYPuEc+uopkGJsOJ1simkW
         +VlcGQZ9fDpk/Y68H/KjFZtMc1vcbs9xk/uQaJJVesrNHrjzGnpAwcX32ET7RkYbcquZ
         qUrXjZynP265F/1ZreuaRjAxreNP+Ij1Dl8Jx7jiFYQyQtOoN+D6h/3UttGlZE9I9gFA
         pMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        fh=SpYrx8jLwIJEny39AU1jhCoRWNGfSLqByKuNmp36dnM=;
        b=YLfXcsIfEMDopcl0Zwpneg61h/ER8ilg+QmpLaz61V3Qp9mimIouJVsk4sZkX0W3KZ
         GheamayOqWriyBAh8gsAsrjg/vQ05WvRh0uR9O/3GWdYeODf2iz0ZW1wvwYLjOTSiCzp
         cFof+yFfHfUSlPPzxbL9BlgkvkAA1B10UGvLjqSAzD01/orkHXWQpCWsHnPUuromXHoF
         tPjx1Kp7x2x3E6ZamPXhZPIbEUsJ+CONBtsvvPFn69HBqrN+fkVFXZgMtHXwSJm2xcpM
         +iTUL9tE0O11+6Q0eFaUTxjEfyErO0iRk8vS0+pkcX+FluV31WixzUL4JQesK9Z3ZEsO
         GKfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791071650; x=1791676450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        b=lOTLx3vbCmNNcC61YOW9isx8IwYT2FlJStKtX2jjtwn3yk3NFof4bzqlgAiTswuZ8u
         R0SHVE8AB2O4ZZLO6Nlfeyp+IZk/C1/kBKK9GfB0YmpjZfjaeKPhQgcBAAFVPAAb5oSj
         OyblM2t1V4LNbOTWahhiJvUImHrBx2cnqAq8WYRIYZ44Zf/ZK/iumsX1jw3xYaxqSnxD
         bkmPXSnpvOisx+/z+2j6AuIsXWMBV+kPwzzmHkbWVH/EOpsWcV3b+sA91tX+0JH0ut9G
         KOq+7Lt00rSec2+WogoxqsSDH5fZpfRD4Nztinav+H8hCxRe2LXE1zODy491OTpohsDN
         ZxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791071650; x=1791676450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        b=UCr2dfe4nFv5YO1tZq+JBkZRnQaog96SmZlOV6enxMlfB/toBI2z/94z6ne10p/h7F
         O2zUB1+PPNZcrsA+OvJstoLP5TzLgtVMjIAzd3B7v71pIf/P8/MqqfueFPlpL10H3bcz
         OWRbzdvfE3TvF/UY3oXxujhtPD6rrm4iGahlayFNW01A6twg2GYQ7Yv0q86Bir5sjldF
         pMjpKDU61Hqn5giVL2R5TvfLe4mjG3EfgAD/FrEaeXEvozTzdBb9PqiPC9RTyMOhUKvK
         JYswWrTGgj55jmNvIaePvp2K2UnHjZLgKItkqtEINsu4Y29DnOOwLYQDJ8pA+ZApO4Z6
         FSMA==
X-Forwarded-Encrypted: i=1; AKwUvBxB+ohXN+U9znNx14gbf2O8XsI6z+cC1ayCjK1NaMtbe2UdkMPnjb5ah7kWzvHWfiaHHAE=@vger.kernel.org
X-Gm-Message-State: AFuF++lo2C13iY2Ad2sVxtRmeR6rxQu1IPBshrFbsRuvlGhzTebX9otT
	GYUqsXy+pV6hkRwGsCdY6aTjU0CG8FcgEkUw+W9SFwjDHnXmAv1r9XWUujyuSLemd8mqq37KBjI
	bhsbboVE1vsGTplVqOoeDtvgi54bgzYA=
X-Gm-Gg: AYBFou1iB92fPvpWWCsg+b9EcGeb/yrBBB0qSlroVuvLmLUPin7y1bGNCybaULIGAXt
	2SLaQ/Z0C10ZzzEuJ5IBT8UIRW2XjjQOBPUdoxMC8bVSaHIp7+DWv+x2Ltz/bGIJiFDmA4U5Hoo
	isRbEf/Eec0wQuijOiVsJEIdqheZdZF72z+pT0ASvLUJhFXbGuo3Wgf4GYoWMO92d1tmxyRRH1r
	6mdbY6DFDichp58MM/0UHkG82GTz95+baWj42/z1sH2IEdSejeV0fSymW8Ac2DILfAyquRcWXqc
	UbuDkNAkFw2kMoVEU/GraZnFWu4zWt8v5xazqchEq8Bpw0vj+Lix0C0=
X-Received: by 2002:a05:620a:608c:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-93e4d60d772mr857459885a.25.1791071650174; Sat, 03 Oct 2026
 16:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002074551.318789-6-physicalmtea@gmail.com> <20261003074657.71AC91F0089C@smtp.kernel.org>
In-Reply-To: <20261003074657.71AC91F0089C@smtp.kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 4 Oct 2026 07:53:34 +0800
X-Gm-Features: AclHuK9yiZzs7l16_RtJMlKQwOPOXk2Ehni0GrB9F0m8WE6NLxHkqNqpNjLmApI
Message-ID: <CAJwVaMLBRYhoZ9krgTt5X2e__AYXMtyJQhW_DEQ8_zqCM7WxZg@mail.gmail.com>
Subject: Re: [PATCH 5/5] vsock: defer RX readable notifications until batch unlock
To: sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez <eperezma@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] vsock: unreachable callback replacement abort logic in batching
> --
>
> commit 811453fb266663fdded1db37d3b4cf3bde547c9f
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vsock: defer RX readable notifications until batch unlock
>
> This commit defers vsock RX data-ready notifications until the batch fini=
shes
> and releases the socket lock. It records the initial callback to handle
> mid-batch replacements.
>
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
>
> [ ... ]
>
> > @@ -2015,6 +2040,13 @@ void virtio_transport_recv_pkt_batch(struct virt=
io_transport *t,
> >                   vsock_addr_equals_addr(&batch->dst, &dst) &&
> >                   virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> >                       sk =3D batch->sk;
> > +                     defer_data_ready =3D READ_ONCE(sk->sk_data_ready)=
 =3D=3D
> > +                                        vsock_sk(sk)->default_data_rea=
dy;
> > +                     if (batch->data_ready_pending && !defer_data_read=
y) {
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             goto lookup;
> > +                     }
> > +
>
> [Severity: Low]
> Can this branch ever execute?
>

Unless I'm mistaken, this branch can actually be reached.

> The condition checks if a custom callback was installed (!defer_data_read=
y)
> while a default notification is already pending.
>
> Since custom callback attachments (such as BPF sockmap insertion) require
> acquiring the exact same socket lock, and the lock is held continuously w=
hile
> the batch is active, is it possible for the callback to change from defau=
lt
> to custom mid-batch?
>
> Could this bailout branch be unreachable dead code due to the structural =
mutual
> exclusion provided by the socket lock?
>

The premise that sockmap updates always take lock_sock(sk) applies only to
the syscall path. When a BPF program calls bpf_map_update_elem(), for examp=
le
from SK_LOOKUP or BPF_TRACE_ITER, sock_map_update_elem() takes
bh_lock_sock(sk),

The batch reuse path checks sk->sk_prot in
virtio_transport_recv_pkt_batchable() before reading sk->sk_data_ready. A
concurrent BPF update can replace both callbacks between those reads while
the RX worker owns the socket.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.31=
8789-1-physicalmtea@gmail.com?part=3D5
