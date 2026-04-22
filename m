Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79C5B1EB;
	Wed, 22 Apr 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892824; cv=none; b=qw2eLevo3/NACUWY+3WRtoSyzMuGtFAYPNhNpCwZ9mQvDamiFlIRMSq0jSnwnzCqwa9AvrIfPbn0t+toZmAfeeuyKoFbQVswfwk5oykC/Ud4bw/iEpPvVFoN3d7hHBnx9zS00NgpX5eu0dr23JPeZ1Y4qmzftCVBHQMfdNdlov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892824; c=relaxed/simple;
	bh=qlgGLccrnR9U+HyxTG8ODtt4itTn4LHGK0fCI2Knenk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wvd4MYwER9L2u2Y6wXauGV0cRyuU7UH1g7a3sFwSNUN/eXQr7gPSZEMY48eIvSRa8E1e/RbdHSEpuIxNcMbrwY8LpqysmgUMuDhahzfvLvc0/UVPL4j/iBtsFsvSUrFDZxvpxALxHEvRKUVoBEyJ0n0z4IX+xABTMIB2fEANTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KPvR3QUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJAi2Tp0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KPvR3QUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJAi2Tp0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2DF17A0251;
	Wed, 22 Apr 2026 17:20:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 17:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776892820; x=1776979220; bh=eR
	/NUkWfQTo5QUkViXcypYonvDUZZKimAcycnbazSDE=; b=KPvR3QUk7Ht8m1Sn5U
	5XLqYTUpveAuTftqeH/G2P2aPMo3uhLo7iXu4r4cUaPjTNF3aVsuVlsHh2e0qHAY
	45P4B73Hof8AvVPdpRqBHF6945X635aGO0Ed6DoN/WzdaEnkltdvNi37pNOmvnHD
	50iVVbriCencqCwc9+EnB6F+iRXYGTE/34v6I5Iz9y5DC4TYjH5WWcT83BDu1HSN
	+Yt1GxloVdM4PW4yrdSvttu6PFIa6ZqtvdoFThap64FcB5P0nLyULLx2YdHwWYuE
	uDcfnsqHn7GxyGLmr0PFxpvreO40r1lazEMOmDHuJQ0ND9Yt6Pnl7CoH0kbnwj+0
	yFdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776892820; x=1776979220; bh=eR/NUkWfQTo5QUkViXcypYonvDUZ
	ZKimAcycnbazSDE=; b=YJAi2Tp0ukohJDmk/oxW+muF2GedEGTJPx8PzGoKayBh
	JKTqjI8E4maqoqO+BG+eaatwQJl3y3qsaWv4ghzN2i9uBOG/kCP/UjlHupCoBKP2
	foxCkPQgdWa23aM6yHbQeRUoqStvWVwl4fDQsn/N+wmIwEY6QMRE/VQ+rA1yK3Ru
	54CYYW9ZSCCABDfAbavt64NDr8yngx0+6gXqO5I/ID4HojDYzeh0LFf2YkD9OSwJ
	o5ZnkC2qOyQ2thbdZ9HP1qLa3CcRtk8iAQOoODzwz4GEoY6Qd5Xexlotje4ME1mN
	Iqq9sFB0n++1Ml21cu/WK642AdBVEGD1SA6VJvZetg==
X-ME-Sender: <xms:lDvpaYvxsYRYEQAkpYAwoUSyGk0_evc9-UEN8-PVfXlHdvLRtf0eCg>
    <xme:lDvpaTTICm4NzJ4YkDMBb6wZDqpCMkrvcc6GEqnnuzH9CTUpIX4EXs9FChvGs6AUx
    LrCv75kbRZwgnAm7vnXJuPb2szzTxUC-fJrqONAWAsonbO6WQpZ3pw>
X-ME-Received: <xmr:lDvpaeMrp9-hrAaHktnSDEX9vHqcIcxyDh0x-5ki_wr-6iZhztUf4jKb1u8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukffogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucghihhl
    lhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueekvedtffehjefhhfettdeigfduudejudegfedujeetiedtvdfggfehledtteel
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgr
    iigsohhtrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrghdprhgtphhtthhopehtohhrvhgr
    lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhv
    mhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lDvpaYbvdQn1EH9St_FsbibmbHICKQpcS1skZVHaR-V26AJ_jdvx-g>
    <xmx:lDvpaYxz3IeP3_ImaSM_uMd-Of47YiJxHRZ4-7hC13Jl4Tr5VJLyEA>
    <xmx:lDvpaTLh6fB09cY20JpRS3oThkvPychEH8lv7d0P0AZgiWB79YFVdA>
    <xmx:lDvpaSphEk1MOYQnrLBdffXeqNtzKgroLubl49hkmeUYU9RCCF8F3w>
    <xmx:lDvpafIY_1PrjDyA0pJQSQOSYV54hWjnWl9hqPUT46x9y237_ljYVhPP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 17:20:19 -0400 (EDT)
Date: Wed, 22 Apr 2026 15:20:18 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v7.1-rc1 (part 2)
Message-ID: <20260422152018.3fa67154@shazbot.org>
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

Predominantly fixes here on top of the previously merged feature pull,
but hoping this can land in rc1 as well.  Thanks,

Alex

The following changes since commit 4ee64205ffaa587e8114d84a67ac721399ccb369:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2026-04-21 08:33:26 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1-pt2

for you to fetch changes up to 30471982cd667972ba93ce894765d4b8544958e6:

  vfio/cdx: Consolidate MSI configured state onto cdx_irqs (2026-04-21 12:01:22 -0600)

----------------------------------------------------------------
VFIO updates for v7.1-rc1 (part 2)

 - Fix ordering of dma-buf cleanup versus device disabling in vfio-pci.
   (Matt Evans)

 - Resolve an inconsistent and incorrect use of spinlock-irq in the
   virtio vfio-pci variant by conversion to mutex and proceed to
   modernize and simplify driver with use of guards. (Alex Williamson)

 - Resurrect the removal of the remaining class_create() call in vfio,
   replacing with const struct class and class_register().
   (Jori Koolstra, Alex Williamson)

 - Fix NULL pointer dereference, properly serialize interrupt setup,
   and cleanup interrupt state tracking in the cdx vfio bus driver.
   (Prasanna Kumar T S M, Alex Williamson)

----------------------------------------------------------------
Alex Williamson (7):
      vfio/virtio: Convert list_lock from spinlock to mutex
      vfio/virtio: Use guard() for list_lock where applicable
      vfio/virtio: Use guard() for migf->lock where applicable
      vfio/virtio: Use guard() for bar_mutex in legacy I/O
      vfio: replace vfio->device_class with a const struct class
      vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex
      vfio/cdx: Consolidate MSI configured state onto cdx_irqs

Matt Evans (1):
      vfio/pci: Clean up DMABUFs before disabling function

Prasanna Kumar T S M (1):
      vfio/cdx: Fix NULL pointer dereference in interrupt trigger path

 drivers/vfio/cdx/intr.c             | 38 ++++++++--------
 drivers/vfio/cdx/main.c             | 19 ++++++++
 drivers/vfio/cdx/private.h          |  4 +-
 drivers/vfio/device_cdev.c          |  8 +---
 drivers/vfio/pci/vfio_pci_core.c    |  4 +-
 drivers/vfio/pci/virtio/common.h    |  2 +-
 drivers/vfio/pci/virtio/legacy_io.c | 17 ++++---
 drivers/vfio/pci/virtio/migrate.c   | 90 +++++++++++++++----------------------
 drivers/vfio/vfio.h                 |  4 +-
 drivers/vfio/vfio_main.c            | 27 ++++++-----
 10 files changed, 107 insertions(+), 106 deletions(-)
