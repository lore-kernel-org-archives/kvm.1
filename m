Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A23D9DB2;
	Fri, 15 May 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865768; cv=none; b=UFDi0vFp59IckriSGKPYvPwl06H2ED6IzO5u/j0XYukO6OQ2pcMNeF2NtsiYCfmYfCb2Mbk+8YBLpQREfKCt5k8zl5tG7MuwHlVdyRbJmQ/KmaPxUznn2bkyNUEVksphhmCO6MGSWrQroXm2Kz+RgmHme+Y7NEkqWBKgPW8WBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865768; c=relaxed/simple;
	bh=J7jCgCg8v0Ufr1cehI9PBUzxi7Fi0zptSnL4p/q440o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b6e1Cazt+gPRXzaxVRsoY9wG5PRv9v3DPM6BltZ8Roh14xL3Gn3aYBBp03dpkTaIzcpsougt+k6H2HCc1+Ppwac4n4/bK4NNM0KPnztCasHgtjKz4aqTm27MHxmCJ863w9Nq2a8BCwlfwK8s39/iIehNp7zcRPjG2gBw0CX4SWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=vq+aRg7f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCNO2bAD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="vq+aRg7f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCNO2bAD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 15E401D000A4;
	Fri, 15 May 2026 13:22:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 13:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1778865765; x=1778952165; bh=b1
	O0vQaggyeaYrggFVOhe0RFihlTVE3EOBHmkdL//W4=; b=vq+aRg7fT+oIOjTY3R
	VALTN7toED/u1Ytyn/pkWH0Ea/dfShTKtGFuE1dhxS2nqyKNoEDB4vYdJQPDNVmu
	TKrN/XcMhggpNtj1dT5oxglB8EIvgOcFA+a6kn/FZOM/Y4EOUKTObmG16QbK1HMJ
	HVNyGfPhFc5huFvoNuvkp/Das6Ks40YPEFIKj2Rvtz1L4XVnlOAYDQTpZdiu7ntw
	RY83nscrnz1i5s1bAHuoBR7a8FWlSOudoRk0YDDdq2hFSFw0UoYgMTUO2hPf1u9u
	ubgzv3expY080bugKOuaXg4CKzLLQehXEW+hVeY0fXBp0bRIpoqgRuGBSDKEPHzI
	sIoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778865765; x=1778952165; bh=b1O0vQaggyeaYrggFVOhe0RFihlT
	VE3EOBHmkdL//W4=; b=gCNO2bAD/B6Xl6W4HFh1KhXphjk5fYOrFV5bFjiFjKF3
	v9HbWKjS+4sW0mm3nnhq9T9XzaIpDd16tUSSWhC+Zfg4hGNAsZd3IxCXoLQVNH0V
	x0E1agZS0txbvxn4WaL6WsKzirThjJ1tNlmpQ28v4K2gNRljBpihD1CfECbEL3P2
	CmSvu461ZXPnj+jQW3UUJklpFXTUGQPAq1FGr7NvB7bVfAvZbCQ6Bz8xGV6zy51b
	188y0mcYl1CCR9/CeyzGhtRRU6DkgA93Wla2uTAHj6Jqzw1eslihr0OcimaiInd4
	vzUr59u4MqOSMTCGPOzT/sTBb0NPxEKnR+qSDyaJGA==
X-ME-Sender: <xms:ZVYHah-QJrG8cQSsZZn4Gx0BQ-VFoLJxVKkHRHnGjscVkcPUkHexMg>
    <xme:ZVYHajhFm6pnHELkOHBFtcUc40FLv0TdQTXue3NcILUF0fRD0NmAnYJBruV4DCF7g
    NhTpZLNqXVklUFsmA3mK4DUetmt91Y2qQouOPiU8oNrzeTDnayTdQ>
X-ME-Received: <xmr:ZVYHapf-LTG5WtpvpZ3LdSSkAdMymeSB0jXy8jkEpQ1sEopVJ88wLInMHO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetteelieeffefhffevteeufeektedulefgueekleeiueelveduheffhefhkeeg
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgi
    esshhhrgiisghothdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZVYHaipeGzfuEvUm0ktzqP-LvBOrgJbxb4V49zE3MvVDKqnYkAZwaQ>
    <xmx:ZVYHamDn48870eI0kmKBXFpkmqYAnxVT-frKeUNNN3eRxrxQ-xlg2g>
    <xmx:ZVYHanaqlu2Q8fP3HxI1sswJjyY7DtscNxNh2JIYenRpd8xwmyO50A>
    <xmx:ZVYHah4rJ6Jc4nkPXdw13bYxoB-xx5U_tuAhOx3OUcNXn2agqvooaQ>
    <xmx:ZVYHapa8H6BEvTEVh53g5DH_dUGsIZ8U3BXtd9MKZYeUu3dGV7Vb2TPL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 13:22:44 -0400 (EDT)
Date: Fri, 15 May 2026 11:22:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v7.1-rc4
Message-ID: <20260515112241.39f9df48@shazbot.org>
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

Please include for rc4.  Thanks!

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc4

for you to fetch changes up to 702809dabdecca807bdd50cfdcc1c980feb2ba62:

  vfio/pci: Check BAR resources before exporting a DMABUF (2026-05-14 11:39:03 -0600)

----------------------------------------------------------------
VFIO fixes for v7.1-rc4

 - Convert vfio-pci BAR resource requests and iomaps initialization
   from a lazy, on-demand model to an eager pre-allocation model to
   avoid races while preserving legacy error behavior.  Fix unchecked
   barmap access in dma-buf export path. (Matt Evans)

 - Introduce an implicit unsigned cast in converting vfio-pci device
   offsets to region indexes, closing a potential out-of-bounds
   access through the vfio_pci_ioeventfd() interface. (Matt Evans)

 - Fix a dma-buf kref underflow and stuck wait_for_completion() when
   closing a previously revoked dma-buf. (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: fix dma-buf kref underflow after revoke

Matt Evans (3):
      vfio/pci: Make VFIO_PCI_OFFSET_TO_INDEX() return unsigned
      vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
      vfio/pci: Check BAR resources before exporting a DMABUF

 drivers/vfio/pci/vfio_pci_core.c   | 37 ++++++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c | 42 ++++++++++++++++++++------------------
 drivers/vfio/pci/vfio_pci_rdwr.c   | 26 +++++++----------------
 include/linux/vfio_pci_core.h      |  2 +-
 4 files changed, 66 insertions(+), 41 deletions(-)
