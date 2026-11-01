Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545952;
	b=eaxuTlITyL4+ocmAISt9KKxGDBxZq1rD8K0gdgjWbIgyvVPt42ci+5P1OCMJ59Dwqdf+
	 naRU368DhIILHXZmSWy02kbjrJsuUktTFbLkT4l43Hoo0w56nnswox+/tA23uRJ1egrGZ
	 sOANKNScYrzhyDfMVoKot207wqTy8d27iJc+Yhi4nxHsO5pcCF2iSRPd+HMVlAETxx682
	 JcnX9oYxgMivKw1nfczBGFtd5HxWH7c4W0eiFuBIknpKtDD7impI+iRyDEdvapgCAw51h
	 ZXbQGlw2lJ5+r3jID+UErcLK8P8SOhzS6Klmb6v4+/F5iGJsv8XbdDThBGP/SwEblvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
	b=Ab6p8ScRBo/bzFTk1Jyk7t+uTx4HkU3AQPxAzPnQ5KnX7iQO5Zf2d1XyiA5o/q7VpRbo
	 E7toQZt6h0dMMeogTmyPxxtzTuuMn4zcIlZQn7wYf7W726JsCTKQU8e1VTK9BMQbGmOUH
	 EYLa3/r+GF8klZfjLVUA/Of/7g6oS+bTBQ+yLQ2108WxcMTqXUByr4OHddUcPlrwwKd92
	 ncSatXstqkx72sQUIvZnUtmtJiZX16eT7iL7u9EW69YBg7NlFP2Xw70YdeovxFwBJFcQD
	 zfP1VJ4W3/Sp5A0xUK6ikmlQIOGEQFh4xmrigt3/guwhL8EeIBgTTrGlAzW5TtuQG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c66KTqbR;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C450606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C450606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c66KTqbR
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1379510e0c.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545951; x=1794150751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=c66KTqbRspE1LbzUnoODsXMOSNl+w9Gclx4wCkMY+MY9x7ZJYPZ3aOr0JmGnZje5LH
         LlNumCa8xwizIeOxvV31ghNVRoQZ1VDyObHto05hW3nQDlokziU4fv6u2qQMUImUThaJ
         ERA4h8llTxu72O9Bgn2yE3PRwtCawaS07wok0as4cOJesaYTmRKX6bxtMazlzWRtoD+l
         gxz+dtrAQC8ADPmQ56kH9TaJazAMNK6c0V1NnLXnq9c/rf8YFG4V1I+EW8t6iSGVHhUN
         /5GsMi7B+wq1mqHJAXfsTy3ddNvxs/MbQG6Qvg2RUAGb0m/8g3sOW6+zCD2EyBsYZKNP
         htzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545951; x=1794150751;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=EhsJjSYGfnnB/L9yY/Nku5fKpBuqGGH8mrACxa/f4x8b9NTOBEcD99KvXz8eHBA6na
         L13aU4SoeUPFGW71KRk/LV1M7S59qcyJgZSEVt0eglVrVRqk3zU37HT9OsQICoNIudv6
         5Bh1EkXpyD+3LQxsuM/2/exBH6eMSQFgppRdt4VgzMCreXczQwrVNWzq9c1ipLt85Aqq
         QqPfnt1mmkyYFr7XGnNEUC6nq6I+21JfK/lXomJk2zmi66lgRyuWWadHmxzHY8VitX2a
         aA6T9UYUDaYunNeMxjjlisD5sn5GNHJTVjULXSWwqcH3nMrSXJuZi3h1OXa1djWzTWTD
         IfBw==
X-Forwarded-Encrypted: i=1; AKwUvBwBKxLMNRCkTqx0LLru4jiazZqnGmGIQri7kFCkbHND7a7FBjnRAuAGZQwAISAbiZ2DtYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN41mwv5JMqClcV+ixKu4+NXI3hsr1ebf0uZikxf5jqhF6ZPLO
	E+Mz7xyMejxCsvHGU9ijENz4SJHS4OtEI6OBvfRLDfxa6T9z7NWpPlm0
X-Gm-Gg: AYBFou0LX6pYo8GZBXxqUgl5sqZFm2ON6tdZhOwKyrGGcJl4FDYwaSxzPszPUTIlr1s
	h7oZdMPw3St4uOJJA+GJpEQOzrIomGade2cigDYAdsNdmxvyL61x0H4CBhtKdocynJBVbT+IA0J
	oeTnRqHg1mSTnMBNl3XI9UWidyx0JTuoR049dsO8z5Qd1J8gUiZ8nNgN0RLaadlwtdx3n30PnAp
	cwjvalBXcPW4Gb35ABJ+UGaH00EDWSIhZpt/W7Lrjn9cMiKQQr4elkvPp/n1SLQy+Njl1ZdUVa/
	+/qa6Po4r76IrXlXVY6qJjbzZeHdpfSH+4feSNK290RB8aypU7Is8RMCzcs4ZbC9kFEoO9IgjXY
	NZ0B8YVrTK0zkZfgo9G1vSpjVzIb9JM+xf7OvjgSi27USu6yvg+OHm04rw5r7g+jHEd1u5HMMK6
	VLAf0CAa+aDAxeTpfKbt8fNqFBeeczyJqu3eVsc4Yh0FCFbvgl7bi4Bx+msVmF0wpSEmKZQf7aa
	+UCc/BVpxQkdqWdqNhzNTSl892umMDd8D7ZYWpvfkDD5xhT4yVcuubIMOO0uJ9xnzQ+PJf8uwUD
	MOwf3sK9Uksv/yD6PZ6TU5sZ4BlP9J4zcGHF/IikhmOMxADiJ0Hqd66j8VjZ0zdYDixd6e9Rpa5
	mPfZbep8cq1OXP/jc2ePH4ViqkzxlGAqtuc1EeIW+yeruzYdgH07vh/bFEepOtuAk+Q27
X-Received: by 2002:a05:6122:c250:b0:5ec:7589:f9e0 with SMTP id 71dfb90a1353d-5ec758a14bbmr1957487e0c.11.1793545951557;
        Sun, 01 Nov 2026 07:12:31 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bba011sm8346081e0c.5.2026.11.01.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:12:30 -0800 (PST)
Date: Sun, 01 Nov 2026 10:12:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.9c17365c41b3@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steffen Trumtrar wrote:
> For the skb, the timestamp is read from the header before the XDP
> program runs, so XDP_PASS keeps it even if the program changes the
> packet. XDP therefore works with rx timestamping enabled.
> =

> Add xmo_rx_timestamp so XDP programs can read the timestamp with
> bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
> is not enabled or the device did not timestamp the packet. Install the
> metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
> rx_hash returns -ENODATA then.
> =

> Like virtnet_xdp_rx_hash(), the callback finds the header relative to
> xdp->data, so it has to be called before bpf_xdp_adjust_head().
> =

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> =

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 23af10c613b48..e79b65653fad7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_=
md *_ctx, u32 *hash,
>  	return 0;
>  }
>  =

> +static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *ti=
mestamp)
> +{
> +	const struct xdp_buff *xdp =3D (void *)_ctx;
> +	const struct virtio_net_common_hdr *hdr;
> +	struct virtnet_info *vi;
> +	u64 tstamp;
> +
> +	vi =3D netdev_priv(xdp->rxq->dev);
> +	if (!READ_ONCE(vi->hwts_rx_en))
> +		return -ENODATA;
> +
> +	hdr =3D (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_le=
n);

    Reading `hdr->tstamp` in place from `xdp->data - vi->hdr_len` violate=
s the XDP
    metadata area contract (`Documentation/networking/xdp-rx-metadata.rst=
`: drivers
    must copy device-reserved metadata out of `[data_hard_start, data)` b=
efore
    presenting the frame to XDP) and breaks standard XDP metadata consume=
rs:
    - `hdr->tstamp` sits at `[xdp->data - 8, xdp->data)`. Standard XDP pr=
ograms=E2=80=94such
      as `tools/testing/selftests/bpf/progs/xdp_hw_metadata.c`=E2=80=94ca=
ll
      `bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta))` first, in=
itialize
      fields in `meta` (e.g. `meta->hint_valid =3D 0` at `[xdp->data - 4,=
 xdp->data)`),
      and only then call `bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_ti=
mestamp)`.
      Initializing `meta` overwrites `hdr->tstamp` (and `hdr->hash_v1_hdr=
`) before
      this kfunc runs.
    - Calling `bpf_xdp_adjust_head()` before reading metadata also shifts=
 `xdp->data`,
      reading arbitrary bytes at `xdp->data - vi->hdr_len`.

    Wrap `struct xdp_buff` in a driver struct on the stack (`container_of=
`, and in
    `struct xdp_buff_xsk`'s `cb` verified with `XSK_CHECK_PRIV_TYPE()` fo=
r AF_XDP,
    matching `gve`/`igc`/`ice`/`mlx5`) and stash `tstamp` (already extrac=
ted in
    `receive_buf()` and `virtnet_receive_xsk_buf()` before XDP runs) and =
the hash
    fields before `bpf_prog_run_xdp()`.
