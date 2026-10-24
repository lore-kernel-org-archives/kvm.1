Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824347;
	b=vXPD/4qKkJ6NKA72InPZFz6C5rdhbCnAxQ93vM+vn9c/fFtyvEIgEcAIvGn6Qs/3B53P
	 NErvCr15FD5HUL4nv0LeOC6cbTS64yAk1smGCJ+tUUfi3QBXJG4pPQfbiMgP+goJOMuwg
	 xsuw3lulEUY8lkwakS3nz9f7jpSPOAEHZR+fSpaOAhBrd/4ikSitGhh9H5s0BL+2P22nZ
	 k/56vczIQnkui236+lrGchYcOx7FR6fgXDTYdaKgHs8MZ7tsyRaQUXA0ZDfe3Re40A6oX
	 QPU0TVI4kKrmQ18xLo5rnoli+WK0Dcld7ekxp4EUGqhQOGfUOxzsQh+mg71swqHuZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824347;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=NAKSGHJmu+36QRvo6oc4MudsFugL6p0g+Tu6xdhFvhuFbOy0VFu8lO4uV7GzGLMArj1m
	 wHaemno+bs6yZF2x3VF9NItZzkvNUXbG3co9u/0A0Y4cRA5YWU40ev57gWyZYAf8W0FcY
	 PqCeBLs5PCCwTMLjZ5aJ/xt2kpmOMsMqbUYhLAVTIem5h7sdTNDUzSXmPmaomxsAAdK82
	 j8JhVnSiUIrN9Mf0JzJhdCd08nKvHdnZk8NFRxIo1dPPA5Adk+oPwAjGkl2cRP07jFkk7
	 zv4nV4RZjHiih0psBj7ftRVwAJNe7n9zPI3qX5ZZypSBM3/RBSetD76d86zaLbJFETA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qyWrtnwO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D82606A31F
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D82606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qyWrtnwO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792824346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=T7+vrpj7S76ce9Leg450qxqwAGfKOdzcByHEMCV2ibOIWLV0Yf7gD14ZuUBcMx3cU1tDZY
	WLJqw0EE4QarMyVMIOeb36TbJh2m0iESBEV+83oJd4cmLyZ3HxzepY8WGIrk/uY1jFr2Fc
	GudSOUYsVOhkCkZuEmh801195QyymVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-zVT6nVJrMa2AtT8GwbF2ZA-1; Sat, 24 Oct 2026 02:45:44 -0400
X-MC-Unique: zVT6nVJrMa2AtT8GwbF2ZA-1
X-Mimecast-MFC-AGG-ID: zVT6nVJrMa2AtT8GwbF2ZA_1792824343
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a211bff50bso9532775e9.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792824343; x=1793429143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
        b=qyWrtnwOQ/VuuWPScSgijCP+M7VHXg8PK7QLyCGp0Y7D/rUTgjc/9RizDiVhlu7dPY
         laBdpxunQICvYpKnx8sKthxhHZJjOx0ApDSXbYDDAvydfZ5Pwtg9CQ2f2cibuL2to2tN
         geljcatw5qL/kWpevQqvu3+UEZSZWAvo8koK20y71iUcLo+oN1a+1q5+TF07rjzggsbp
         cIjbFzXMjS9g714qiKjnMiXHwl++CYOwSHiZCG24Gl+nTFDv5ISdRDcDbB+5qkXGu0xP
         KT1PUJpKc0ty5XGdjOI2QECEAZOdHl3vX6T1MOiyf4dl1f7QWKxKJnoeJhV7h47LCztD
         ZcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824343; x=1793429143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
        b=ZBannxfperqfkhqIBATs2Xq3YzHRep4VkEo2kHI8RS1CYfmi5UphZhw3qPC+uPxggX
         hzkoI2md5T2s/PleML6gILTNNtefOVSN80JQ+dLD4kbGoFR2E9wQq+ganEYN6QTuJKQp
         94DdWu4wE4Z4cZAs6Y2ShnKZpSIpmDZlUB2KiwwWbELvSLYqgdNYO899+uroxwU56qTF
         8efDDFImKvVzZKDhUgtyYnBFQ9z6mOzL3OCAI9hzmGdxsBzPhZQoMYEvQoX3H+qnUaB6
         vJOgQolMIAcWT6DoXjcjyP1mvLHmJWThxIIJ6gS0OyRjF0JujyN9+tI1TusQj+zlo9eh
         eqwA==
X-Forwarded-Encrypted: i=1; AKwUvBwHhcNU6FbIMFDWctojka+bh+5cBpvX5DLJIrvwNQLw4XH1dg9KBzJQiN8MPxsuU/MaZrY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcoVpV5hBIOeqIxDP8gLSk2qWN5IaYTUZyjo8EG7QGUdh448ci
	nSHZ9pl7UeNWkKf10oG4KsIfO1cjqtUWoa96Rdi2hpH6JhSe7YCktcZnLiPCjt3sediAb+5SoqT
	106Vl66sqdCa+3yS4+CvYBYkc64oGEcMD5XDtO3zsS3p5nQdy7SDbXooedM1GPQ==
X-Gm-Gg: AYBFou16o2txP9ypfsvjzaHFtNqxkLffitGA89yuErtasTwNetNzB6mIx+z/XPE6Y7A
	IEzjJNDP+gULpTWUl3WkeDyC/uS9p+9PZdMOTQWw+Qrq8+e8Fl5epHPP2WLiW2tQUWqPoT/k9ie
	vp6a1rql8XnFRTaB8DV8Uby0uZe5EaSYZwRu1qnfqfLP4enTNO/qhoegbarl3eScVVo8yRh33jF
	NoMeg45VHiRBjl0aGrx3azRQ9NouICbYwAVjKfP2syXN9CSBpcNxXtZ4sKX4vAU9ECnGGZPB2jE
	trcdd+5itN9/JQeQckuh+8NUjpITlNJWSxHdZEH2kGukB655ZE4uTA2/6AtDcEl0DssfhU4=
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890865e9.9.1792824343218;
        Fri, 23 Oct 2026 23:45:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890615e9.9.1792824342728;
        Fri, 23 Oct 2026 23:45:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm63050615e9.0.2026.10.23.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:45:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Message-ID: <20261024024028-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
 <20261023080824-mutt-send-email-mst@kernel.org>
 <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>

On Sat, Oct 24, 2026 at 10:11:01AM +0800, Guikun Yang wrote:
> On Fri, Oct 23, 2026 at 08:13:22AM -0400, Michael S. Tsirkin wrote:
> > Which backend did you use? Sounds like you did not set
> > TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
> > That's the issue then.
> 
> The backend is a tap device attached via the normal tun path:
> TUNSETIFF (IFF_TAP|IFF_NO_PI, no IFF_VNET_HDR),

Ah, no IFF_VNET_HDR *with* vhost. That's a weird combination.

> then
> VHOST_NET_SET_BACKEND on the RX vq.
> 
> I re-ran the repro with TUNSETOFFLOAD declared before attaching the
> backend, listing every offload bit the interface understands:
> 
> 	TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
> 	TUN_F_USO4 | TUN_F_USO6 |
> 	TUN_F_UDP_TUNNEL_GSO | TUN_F_UDP_TUNNEL_GSO_CSUM
> 
> TUNSETOFFLOAD succeeds (0 is returned, so tun accepted all of them,
> including the UDP tunnel GSO bits).  The result is unchanged:
> 
> 	features[0] = 0x108000000, features[1] = 0xa   (tunnel bits on)
> 	VHOST_SET_FEATURES_ARRAY ok
> 	TUNSETOFFLOAD ok
> 	--- RX buffer first 32 bytes (initially all 0xAA) ---
> 	hdr: 00 00 00 00 00 00 00 00 00 00 01 00
> 	     aa aa aa aa aa aa aa aa aa aa aa aa     <-- offsets 12..23
> 	     33 33 00 00 ...
> 
> Offsets 12..23 still contain the stale 0xAA fill.
> 
> The reason is that vhost_net_set_features() computes vhost_hlen purely
> from the feature bits passed via VHOST_SET_FEATURES(_ARRAY):
> 
> 	hdr_len = ... sizeof(struct virtio_net_hdr_v1_hash_tunnel) when
> 	           HOST/GUEST_UDP_TUNNEL_GSO is set ...
> 	if (test_bit(VHOST_NET_F_VIRTIO_NET_HDR))
> 		vhost_hlen = hdr_len;
> 
> TUNSETOFFLOAD only updates tun->set_features and the tap device's
> wanted_features; it does not feed back into the vhost feature bits or
> into vhost_hlen.  handle_rx() then writes vhost_hlen bytes of the
> virtio-net header into the guest buffer while handle_tx() / the GSO
> path never touches those 12 bytes for a header vhost itself built.
> 
> I could not find TUN_VNET_TNL_SIZE anywhere in 7.3.0-rc7 or in

Apologies. TUN_VNET_TNL_SIZE is an internal macro that header size
is set it. TUNSETVNETHDRSZ is what I meant.

> linux-next (drivers/net/tun.c, drivers/vhost/net.c, include/uapi/linux/
> if_tun.h, include/uapi/linux/vhost.h) — is that an interface from a
> tree/series I'm missing?  If it is meant to gate vhost_hlen I'd be
> happy to re-test with it.
> 
> Meanwhile the stale 12 bytes are observable with a plain tun backend
> that has declared full tunnel offload support, so I believe the patch
> (Zero-initialize the largest header layout and copy vhost_hlen bytes)
> is still needed.  Happy to re-test under whatever backend setup you
> had in mind.
> 
> Best,
> Guikun Yang


I have in mind simply disabling this combo: vhost + !IFF_VNET_HDR)

I'll research a bit whether anything anywhere could reasonably
use it.

Can you reproduce any problem *with* IFF_VNET_HDR?

-- 
MST

