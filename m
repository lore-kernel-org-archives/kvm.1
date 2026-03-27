Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2430CD82;
	Fri, 27 Mar 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628821; cv=none; b=dEJJRCLzOZoT/kwKq4Lusq6B0bfXLn5SqSdI2s/gLdaRb8OS5fNyg/z7aW3VOKvsIYUh7v8CkopfuU93blza1LiDiC1LVSFybMz6n+/pZndSSFQWd5M6DKp1/9wEM5pSZkcQE2pgcFu7vytM/crq9Cq8LVHthhhXSfNHrgMdtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628821; c=relaxed/simple;
	bh=r9fSo491Pr2ZPkxIr2VxF0cwVsGRuIjHOyLSjWQE3Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mYIm8038LaRH5r1hm2pONNk1keSs0jMYznriBGq720ifJzU1fZeoZxgdw95CJI+JDv3Cj0rJ8Bh96hLQ5hQH86C/vFnieutcbryiN4GUNfZS2q2tNtGmX+KerBKfsxmR8xcxbBH1Is1AO0AHu3AY53Z8pdZ+QnCkA90nrl/pmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=e0B35BCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZhm2nTZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="e0B35BCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZhm2nTZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22BAE1400176;
	Fri, 27 Mar 2026 12:26:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 12:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1774628817; x=1774715217; bh=gI
	yHgX6wvfbHEELWQCcnLBdqvwXGGWhdsHi15lqfS5E=; b=e0B35BCCRUL4TSowdd
	3KshmhAd9lU8ALbHBpxPKI1nXCXDSZXGkmnFPHZngvVf/BuxA91VUextySMJgo0v
	KNUF7hzf8evolTD25d0diS56YHX7LPNRde4I4z3Ob8vyPMeOVIsSxFllLejlnhSS
	mqHb+2LPJG11BL5q7Ayt6mjTxSp6X8/d16eoxuNj3Fi3cQ1btuOcoio3o/b4CXV8
	7r4oITO5xDsUn4T3/CILa+cGTrIF/BuF0jmcmHZ0ETwf9MvlHiX0WnGNgVnmDTRz
	Ztq+nthmSQFgx/yKImiRIwoYkGbWgPFMlmbM6SuCl06UdoJlTSjeP6BGiKqS/Sbj
	gEnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774628817; x=1774715217; bh=gIyHgX6wvfbHEELWQCcnLBdqvwXG
	GWhdsHi15lqfS5E=; b=NZhm2nTZn5lvtudOod/VpPoK/7soVd+M4rxrNrC2aIFi
	ynJ+g8YutJ++HCXFGmXzQO86XIIC4xQCa6EmzNNb7WOj5mpYgGdm5eJoiT1wIAXO
	iykosHvZlh853I60qDeCQazq00snI3zC4YstUBiUlgZuMk3pZzPStHiqRPfpnbMU
	jQm9WG0RmBJqmgRPekFWFfUQsOwot9W9zdh/Szf3RGPTJ1/uBoHSibhovf7HcrbO
	UFdsidJFojIlMm1+5R9iftXHb40MqsLBB+n8cY7+HzCeOqEfRkOubvNVpJWtj9qS
	tH31WWTWwDIm4/Rs5x7uuzR8S408grAUuzhZ9rhcQg==
X-ME-Sender: <xms:0K_GaQYzz79R5fw7xX34IAnpRATlG-fzHmJ0ltjReUlPpUzmUvz11w>
    <xme:0K_GaZMruOna2jH7h4mSf-XC5mRM9x6gd5TJR3LhxiBc4soc9yo7KoCLq6fiZ4MfX
    QYBOst7kkpIcymTxQlsFW3gaVcWcEnvDVY9WyaILbDmyZ5aW5u04w>
X-ME-Received: <xmr:0K_GaVbVVU0fc6Yag0rPElEbzL_zClWuNCpZZV9fjp7RYkFLMBe3FwY2uLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetteelieeffefhffevteeufeektedulefgueekleeiueelveduheffhefhkeeg
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgi
    esshhhrgiisghothdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:0K_GaX1nFZnICwyDSxm8g2WW5bFspH-ll8OzvYo73lmiH35xOU-RvQ>
    <xmx:0K_GabdxPr7u8z7todL-zkh9OJGhX_ty4IoNa8aqM3lkRTTPA5JL2Q>
    <xmx:0K_GaYG7obwoxNvNcBlnqVgNP_RQthq5gng725szzrz7Sny6yRlNVg>
    <xmx:0K_Gac1OUfvjmGwAdppnply-blmh0KjUFQ0-RvX3bBFUqV1e9PnHZg>
    <xmx:0a_GaamLUNjg2eE5m_pFkjLRM7XIiZWg_6QH0D0KEoUO47oLA4ODVqON>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:26:56 -0400 (EDT)
Date: Fri, 27 Mar 2026 10:26:55 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fix for v7.0-rc6
Message-ID: <20260327102655.65cc762c@shazbot.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Please include this fix for rc6.  Thanks,

Alex

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.0-rc6

for you to fetch changes up to e98137f0a874ab36d0946de4707aa48cb7137d1c:

  vfio/pci: Fix double free in dma-buf feature (2026-03-26 06:38:27 -0600)

----------------------------------------------------------------
VFIO fix for v7.0-rc6

 - Fix double-free and reference count underflow if dma-buf file
   allocation fails. (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Fix double free in dma-buf feature

 drivers/vfio/pci/vfio_pci_dmabuf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
