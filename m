Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660740;
	b=qEvVfZ2kKel/LY7SpHuZio88snZ1+xC9rnywmMUcBJqjinL2UUisraxgKi9v3Z559tJk
	 QRlUqAQz7j9JdCGhL9eLFls8PiaOx9+izvbjSO9WSOnped+EcA74HEvs9Ql9kstJJ2q+x
	 tIbjuTncFC1r9SzswiII9sDf1nlVOfzz51MhMTv6401hGSzD7Xv+6b6M6NVuIrLIsGMKR
	 VGpng73fWLC+pE64wTd/+G2y5V2SiJDWxpya/03neFRJyJO7sybLCVFqzcjRfdDTHg3Uo
	 z/uoYeNh1IFC+uQfH0pOuPQiSrNCyoT6RnaOB35Wo/nSiJQP8pPj9aqF88WAAJPD40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
	b=nfqAZCqZTuXYOSHw41gY+TN0ZPDJfbt30dsZKqLyaSXfo5/15CUAcZPQ/qYSemMeIs26
	 ibyq5GEiNL3eJzrGQIkGtlsnB4hPiDwhIjUDMYkZKkdlHSrlPK61/A9cy/nXAYQmRNh/C
	 uyLG/vsQWgWbxdfB6+C0g5AL9yVyChH790qVzVP3uD1efTYuhVb7dmvPHqhGhOnM9Ck4S
	 mTiV3PjIllt8z9oaAk99bBSkUWghEzmMYCYZ09Frvz0fKxEKf8qemsi0wbAl/xqemt1sF
	 sfg6Qz3yLOvmVhyrubeocrKRmzHGmSFYAgOt8G39nMqgIw1yu00iF7Zlh0lfGuPunFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e1FUsMFr;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C2606A328
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 09:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 070C2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e1FUsMFr
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so3064711c88.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660738; x=1793265538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=e1FUsMFrTAW6QUpswIa27YiiEcGG5ijLLfxGR6RmpqWQsR4NH+jWQrxhV4Cd+WZeqY
         SilvJXZEpx8dcyIkaaG3dqf/oi7lQCdZL+hVZunr6sh4Xz9x5EkYUgclVMFHIEoFcMqR
         WqjZl8Cd1Grb3KGpm5TB3loCliDh2wioVKem9bzi8huMz+rIPBvWX4cJnJ0k659DA7Xc
         y5M61fbbg/QUgdxQdy5EkaEHvmYzS+AJBOM3weQgQR0F6yzcdhkdN6S25ZJY8SSkNGeh
         LVESuY1D4biD13sEGWrOUFQsr+/HnjxyVx0rlOXU2oXSzxWSKgm+Q6/OsvgJEdaxt2C3
         xorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660738; x=1793265538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=2HShdMms+CJSBPLpiNDfVRhrJv3tatvOpCkynlU6Mn/pRxESNEy308ejRLZWCrzMHn
         gVJwekRtoodDaqmnC2tpjZNQsqCN+/Rvx/iUJwGxUYrID48DEleeqtF230fClGlbkiSj
         i2oZt31u2KIZvNO8aUq/BW86CGDYAmAFKm3vo1JP0cB5a8nZFtoBFO5OvEBULeakLvaE
         pDt7LaOhxVgMe97VJWyVfaBy8Th74B5/hUoparOG7xKoP1lkWwjCkSZoG8RqQeWLKjbO
         ZPgpSXScaO8O8giEwBjYqUL1uyFvIani3UPHkKawoq+QuIj8i9zxZIrvWHtQzHjvp3ic
         4Fug==
X-Forwarded-Encrypted: i=1; AKwUvBzVrcFqs29/pSIxuNKTnkV3H7qN8af4BC7D0pdgbNJUoe8j8IIsauTlrl1y7T9/VYIoa54=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF4dlWznTzPa82q2cjqzuAuWdlA1WhNpZc8c3EcDMElPIO4j8O
	H6PggOnQ9JfKwxQK4JmpMl68r48SJuK8UO9WHf6VWuxsjgPdqXWfmCqI3P1bzNDCY7o=
X-Gm-Gg: AYBFou1w/EFlzlP6q9ESf49KlnS0dGydSaxhDM18oTChzzrzcf3WUqNVxF9C7Ut1DN6
	VHA//KsDL6V6DoZEkbCW9ZvJlv7CJCpCbRhnfQ60wbmzHHDrZxg9saKcX+K3iCu7nFTnnhO0r20
	kA6f4v+51pQafbk3bwDo+zs6ovFALkQGesa2V90BIhdgxXFhCJvg9SKm2ab1yfqs54FjqjlFvxz
	y1Z41Zz4Ai+IpULoX2FEPHgPIKAAJ7EzcUnNWg+BuK+IGtK/XynNTq9zyrWj8hyGZ3FFnbtYb5W
	yNlyvTYsXCXKrqrtOlC/2cmaykqvL3HL62tVEyirCH8TsTp620vVpWmsFdI6Lr9GpM/gotjWwFU
	fvo8y0xX2AXMi7rmtT6YZGKkDrBcYVuyhi/OXVfbTvrQvd/V6sCQ7j3NVGLUemrx2BVesoSLVxX
	H/YLijw1PRPYeJBPBuonB2bqhD5vk4B0IGfJrnR11xdHmrDv5uTwEd2lPTAHdVbv0pQDv6Gb5fr
	7I6wgPTjw3r4JirLXpvFlpbFRm7UKn4ke8oN6E8GquP6ZXDl/G9Jvb1IAFJskE5LPQznKDV0Joq
	lso7/LFkmfLXYsjrRtvp3MexcKe15dq7FzsUA5Lp
X-Received: by 2002:a05:7022:ea57:b0:144:f089:b189 with SMTP id a92af1059eb24-190a74775b8mr5453836c88.36.1792660736253;
        Thu, 22 Oct 2026 02:18:56 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926035sm11607230c88.1.2026.10.22.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:18:55 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: zero-copy path can expose uninitialized packet data
Date: Thu, 22 Oct 2026 02:18:47 -0700
Message-Id: <20261022091847.3654028-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

The experimental vhost-net TX zero-copy path can hand TUN a user buffer
whose effective vhost virtio header size is smaller than the TUN
device's configured vnet_hdr_sz.  TUN computes an skb copylen that
remains larger than the bytes actually available after stripping its
configured header, publishes skb->len from that copylen, and
zerocopy_sg_from_iter() initializes only the real payload.

The resulting frame contains an uninitialized tail.  The tail can be
read by userspace from the TAP peer through normal forwarding.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with:

  init_on_alloc=0
  vhost_net.experimental_zcopytx=1
  TAP vnet_hdr_sz=200
  vhost TX total length=256
  real payload length=56
  TUN copylen / skb len=128

The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
frame.  The corrected trigger delivered 128 bytes after submitting only
56 payload bytes.

Sixteen of sixteen corrected triggers produced the overlong skb.
Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
Several contained recognizable stale kernel allocation content from
previous skbuff_small_head users, including fragments of environment
entries.  Those bytes were never supplied in the virtio TX buffer.

This is a userspace-observable kernel-memory disclosure on a
network-forwarding path.  It is configuration-gated by experimental
zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
stale tail in this test build.

This is distinct from candidate BR-023/BR-025, which exercise
IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
zerocopy_sg_from_iter() branch.

I found no direct upstream fix or CVE.

The vhost ring reproducer and complete program/console logs are
available on request.

This was found with a multi-agent workflow; the
information disclosure was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
