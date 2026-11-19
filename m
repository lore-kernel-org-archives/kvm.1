Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073183;
	b=KVYJV4ZzhuwcZN5ZBNKWl/TtnaIycQFSP+G5RfrKRBW0QGwtIYmM4uPzx+KKBgcnTvc5
	 3e5L5IyjB41sIw/k/ZtE9kL5A5/9t5xIpB5FQsPfNIkVJd9NUwV5gu3WTX2XaVJHyLi0R
	 UFpfmaCXIZVGpR+ngGoBmrhjW6lOWwTFSwH+PedHmNJlzlw0FDRton/zkxACBI1YGqJR1
	 bjh9h8S6s6X1lD3Dq020zmCItmJD70NtuDJmlmyhhhdXvbNIlHcQBe5EHl6+abAX5Fjsl
	 mdoEo5AZQLO+UMLrVqNRCvffXUsVnsaLfret+SPhYNnQ4+2qdQWCVMri+BX4N9RBSDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073183;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mutt-Fcc;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=jZT3vkaFIA1GlbaQdteehKXEw54KTWvkhEi18jNY4A0p8RZvddmQOt8Why+aGyJvTKtR
	 gwPoRJwp1LsvnabIg5vndd8ewLt/vT5oHuPeMUAcvyCzadWm6wRZwskMzXUORMD70qAfw
	 TAzOwGlY16396Fo+vB8z8+bFjX+Jk5Vdg6Tm1+taR+35BY1wLsVJwGxtakSUk7aGGY2sg
	 xRSZbPi4IjIDQdJn3IuQqoB6TfVP+YMXF4I7oKQzBrqBVWWllEkNIQO5z6u+zrbO452kq
	 f07aAiRM5ug0Mk+hihdL9GsIUNfIChcaxqimN0UArP0K6D2olgFhO950eHM5y1a9Wtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdeH2uDW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F7rRIAyt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E9606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3E9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gdeH2uDW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F7rRIAyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795073181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=gdeH2uDWu8itjh6NHKhUx86u22inkN6eOj7JOIjIaOssT3k1IbkiGiHmooIpkV52lt2ldj
	kFDpVwUGei0XCR3OCPyQQrtAHdDTQM8yji8S4ngIneTCHttdtOFBnelgx1J2LjKpyq6IEi
	1K1RPS8s57f7KLUCUurBdEOQ0rFvmWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-AThboTxhNLeHCXY-eZCCvA-1; Thu, 19 Nov 2026 02:26:20 -0500
X-MC-Unique: AThboTxhNLeHCXY-eZCCvA-1
X-Mimecast-MFC-AGG-ID: AThboTxhNLeHCXY-eZCCvA_1795073179
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso573491f8f.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795073179; x=1795677979; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
        b=F7rRIAyt3wWCkr/uIq7CcsZAeA9N2ckYQaSb9PfrHzzdrhLoatK0jPKUtp+a7bx4zw
         Ke1VCtmj7C1COq4SH1DMhKo2Ccl9K7tOI42jExCQFi7YHv1F+j0DeQnYLHFOJllMVk5T
         t2Hal6qIZufy2ggOPnNvB12f4qax7PvUPO5vOts5DVv1q8s8jnGomTr9maN07NLHj81v
         GsL59um+fiT/322vCvC1fsnbBl1QmFpLuvWWvkOEpUPm4fWEQ51aFMUTyFQ7v0lGn2U6
         ZCM/9e2zx93L7vZkG4kMo77jDjMqrJlJiTu6EWtXGU/v1melySXVeVmdbJPyQnN6s+gP
         LWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073179; x=1795677979;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
        b=AGfCK2nP6SdvSOg42sVTMKsJmTi2Hb6352VlnrBXV1woqfgpQwHHc0RAPgKr1EIgzZ
         Co4rymEFP/qDdjt/ic4x5to7I0x+o9PD448a2UAY+E+DTTkR31Z0ouUXWX4hBvVQhH8G
         UQckr6DS1o7JmbL5K16zA+IMrSqqAobROnp4TCxpIyBZib6T/GF6X20QpcK736JxVLeg
         Z2oq0Zt7bvVVZx5S9B4eIyw8MREG+i1rN+J1Ea0DL1szJqCb/4sytUwmvEz4P1HPfgeV
         YZ1oTK0CweHhHYxLayZW7Sku/IdBLd3+wWe3A5wo/OXw537/KWr9UM2s1LBijjZ2HTWH
         I86g==
X-Gm-Message-State: APuU4Z9SzqDtyh08tsAfysrZePYJYwHtyY4KApWYsxs7jshgYj0pkSKN
	QtNHN5VDUhwQzTgmfX0pfFq6Bxu4Axqyu4AQ5Nbh+VKWzC/T/RKKuZl3ApA9CX8Nu1SiEQT9zrr
	Jwve7q05qeHVDsNZTt+H8YOMj6t4nZxH+lDA3yjLg4M0P3QE1zwf+4w==
X-Gm-Gg: AZFdTZdDeXtDEiqAmdv9YyPIhu4XpXrildw2XyN8mp6bC9YoF+PYv9w5WpFYtZYGv7F
	mldO+kSK//1nQj68YUwSp8Z8Z5TvhmwyTlF8fnJoc60c+K9X41pBIZ2sNt9Nj+79ikrzJQKTwUJ
	sz+MR9Nm01tX9gYZgRD9KmqfJcyH/7kdZlRcwfA2eyRfPgDhQ/9cCM1LgX3mFfF0/hsH6LSWiIN
	tRBJambawRRvCqQgSSTS+6GQYR3ugVW2mNyFCfx4gSV0hwcO32YVbatKoME2k6DcIG2MAzmsr2e
	ndOz1V/W9omklsb98gV19C/YzWFq6VIiCZPUWkVhXcU5IEydIcnOHY87I8bBmcyg2FefpWivi8B
	HiIgdOKJV3aftXHy8U2Pp/44U3ckSK+pPVtl/GeupZ+A=
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871395f8f.5.1795073178840;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871351f8f.5.1795073178254;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3f7sm9540259f8f.24.2026.11.18.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:26:17 -0800 (PST)
Date: Thu, 19 Nov 2026 02:26:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bioloidgp@gmail.com, jasowangio@gmail.com, minki@morningstarsec.dev,
	mst@redhat.com, stable@vger.kernel.org
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20261119022615-mutt-send-email-mst@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 1a577f9402c1780cc1e663f48d5dd54c02051b09:

  virtio_pci: don't take the MSI mutex under cpu_hotplug_lock (2026-11-03 07:32:14 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5570a998b884c988dbe105430d7e2d8e9411e37e:

  vhost: split out-of-order used ring batches at every wrap (2026-11-12 07:44:36 -0500)

----------------------------------------------------------------
vhost: bugfix

One bugfix here. I am testing a couple more

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      vhost: split out-of-order used ring batches at every wrap

 drivers/vhost/vhost.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

