Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71592369D6E;
	Thu,  2 Jul 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017250; cv=none; b=dmA9Rvp3ZoyTLPuyJsFyROl2GCk50x2gNAnuYBSYw3rvXQTsWI8y45F5Cm+8VqrqJNGGSKAtDL8Sldl+E07dAgbYK5gIml5PvssbITrMppumSqUC+zDbP6e9ic3Vjb/EqChEfJMshKKze2+QNgQsT4H1PyS+HqYjyOunXpFw3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017250; c=relaxed/simple;
	bh=lGFdy8BjEXTWwPlUhh+s21HGqxTBJpAvzj//nRAhBSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hLGxMuaLs8Ilm1OeXIvIRw99x9WPTKXSf4LCKg1r00ThPZ0CfAtXKhJOtQN5xIPbpMykyv0Dp5S9ScLq/TO2VYynpaVIVX7JUET25lQY2OEBvFi+hrMSsZR3mf10TsLw48j78U58v/WASyGtzlcIyByPejH27QvAxDUCX9/6o7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GiGVrnEe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijIARc7f; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GiGVrnEe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijIARc7f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84A3A7A0081;
	Thu,  2 Jul 2026 14:34:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 14:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1783017246; x=1783103646; bh=u5
	iIZBCqxUlgvySpNKdsPPfbBzPvioQpMRb5Ah7+Zuo=; b=GiGVrnEeQ+yCGiu13D
	oMJWC/KnJoFeoRZqQ58bBzMit/wSUnDBdlQNrj3NV2KIZHU4gVTVwkNE41r4TlFE
	AyCEllQD/1G7tsIoc5TasnPP+/Tj8nFvkKwHBKR0+M5wFJ+eRlEes8Io8DfFRlc3
	k21HxAQ8Cvp1ZM+dKw+4a1QGiMWbgyVeop1lgHPSvh/vfc7nvbyzOajnK5gEbPv2
	WJlEr6UpsDBdupqrcXmIdYFhFf1PJ8XmZAm2AOcyTMrQH9E60LaT62XTamTw7qbz
	TnixpIfpN727RPeJ6fhAfoJ4vCQ5jgpWN5+FJ2Fys8DO4n70RdnArfbDy1Lhgtf9
	kBZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783017246; x=1783103646; bh=u5iIZBCqxUlgvySpNKdsPPfbBzPv
	ioQpMRb5Ah7+Zuo=; b=ijIARc7fYKxaz/xq5gniaL8LR1QPfq3uoHBC+D51XGZW
	qxn+88RtqELWcM0pkx0d+PGVPJZYunVyKofGhDLfC7BJeTL80Es63Md3A+jlCStN
	wrIkLNd5YYbw591XxzJufNtj8/VGPistt+F9TqJgiijidxpMATd0X5uLMvijmS32
	Q6MflGkClENWaJcSgmtVKvSgNojcCLixtJEDgvzzhQA7ieU1n8lLrJMOX01zhsdW
	Y1QTP/aT7t+EaeYHxikJEyNVMI+bU48AQD5NMo7OfBuM1bOYe/W6IATPZnMuGasO
	EGdEbpe5tCA1PZu2gGHCMnn8EZNVRgZ8wWFIjTdBtQ==
X-ME-Sender: <xms:Ha9Gaip_KsYOZGNcHg14pkdkQgu3JM63wcBQyrRR4qOfzb4hMOt3pQ>
    <xme:Ha9GaufuLw6APLMffCBBwBBF5a-1kQ_blOHCoxc5oDn2JulrAfNkiXXrP7Y5nT5WS
    nw1BPWfMzH90VN0qCAFyhS3e4KC5KCegvyfZRJazUsYX7746wlErQ>
X-ME-Received: <xmr:Ha9Gahp4QVd0IKCZ6xuzYt9QIvwiwytcZF9KN7pzqrr94vvIb-fFeJMbl_Y>
X-ME-Proxy-Cause: dmFkZTFiXHjOIZBXsoTNkT6/njTwZks0j705bDQ+aT00vJhT9yE0iJKgrOEiw+S7SVfAjj
    59IxGQwFp3j3TxgwN7Kwl1yDrQIXSzD9xs/zkNxAtgCPtf/pmTRWO33XypR31LwNPgOhlJ
    n/+1mEUiE01wWcQH9QZrl3hFVnLremY+uxHOkHz1IWH01vqImG/nuZwWS5PZz3wOB0equ8
    cEuurd4VsicE2BJIFH3oUyysClBSQMedbd846gVP2UW3g0H3tHGBoZbKdZOgn8MnH1fnez
    qs0bZL8+bJ+tKcoJESpNAvKPz8MS+TNCaA2xvZuS3MSUpMnfseZbPbo3Pd7SgOca5MnDBk
    VzfV4NQ/ydVFIJaxiAAhuMDYE2s8v9olbKF6tmfCnlJXdc2Bf2tQFsvV4U2SFC4XfbtKo7
    vfoNPYGNuVibWvbS86YffiArtlCaFMtYLr8AnI6WzCLeskJbEjhrxir0Nv1B0za5Rye+Cq
    tUBveAItBbgOxuQOEpfMAVX+uGkEv4aLMGS0HyWR03DY1jvg+Gy+sgdi3XwMCvANKw5GfL
    Z/rXuB6i89H7hP87tceVxybGVaxXhBWtOO29HVDO2Nt0dlEBNZE/51TAeVB7XTAb12/Hsy
    9IcwivnB9mq9ySrCMwrLDbUI4EGCJyA5Yk0ot3rd6kw+Sc9iRPEr8dQgRAlQ
X-ME-Proxy: <xmx:Ha9GavHMVYuhrroiZeKJRNmV7X4ZyGe6Z3oeP6dvBKrt_Tpt6CvLFw>
    <xmx:Ha9Gahvcv90aMuLEpOQmbjbhY7T5kfNB9RhGRPomzH3ekGx8irolhA>
    <xmx:Ha9GahXggTh2WdaG0nenwzFQ1MdNMdONXztXolP0BZInUGpbO2jArQ>
    <xmx:Ha9GatHZDSuj_2XUH3dn91sg1SgbFrzdTQxCSgTljOtPPlegf_Nzmw>
    <xmx:Hq9Gah3KBsOoIJaX-A0uTJTDIqYstlk8bait4WdO19a0dglsDREm94pB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 14:34:03 -0400 (EDT)
Date: Thu, 2 Jul 2026 12:34:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v7.2-rc2
Message-ID: <20260702123402.7f173c7c@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Mostly straightforward fixes here, inconsistent runtime PM handling due
to global device policies, bitfield races, unwind path gaps, teardown
ordering, and a misplaced library flag.  The overall latching of module
parameters per device could include Fixes: c61302aa48f7 ("vfio/pci:
Move module parameters to vfio_pci.c") [v5.15].  However, since this is
largely a module parameter mechanics issue, I chose not to flag it for
automatic stable backports.  The per-device latching also leaves a gap
in debug'ability, which is filled here with a debugfs surface.  Thanks,

Alex


The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc2

for you to fetch changes up to e242e974e812e7a47e3088860c80d9492fac314f:

  vfio: selftests: Add luuid to libvfio.mk's list of libraries, not to the Makefile (2026-06-30 15:50:55 -0600)

----------------------------------------------------------------
VFIO fixes for v7.2-rc2

 - Fix racy bitfield updates in vfio-pci-core and the mlx5 vfio-pci
   variant driver with a binary split between setup/release and
   runtime modified flags.  These were noted across several Sashiko
   reviews as pre-existing issues. (Alex Williamson)

 - Fix runtime PM inconsistency where the vfio-pci driver module_init
   could modify the idle PM policy of existing devices through globals
   managed in vfio-pci-core, leading to unbalanced runtime PM
   operations. (Alex Williamson)

 - Restore mutability of writable vfio-pci module options by further
   pulling policy globals out of vfio-pci-core, to instead be latched
   per device at device init.  Provide visibility of the per device
   latched values through debugfs. (Alex Williamson)

 - Fix missing VGA arbiter uninit callback in unwind path.
   (Alex Williamson)

 - Reorder device debugfs removal before device_del() to avoid gap
   where debugfs is available with stale devres pointers.
   (Alex Williamson)

 - Move UUID library linking flag from vfio selftest Makefile into
   libvfio.mk to avoid exposing such dependencies when linking with
   KVM selftests. (Sean Christopherson)

----------------------------------------------------------------
Alex Williamson (7):
      vfio/pci: Latch disable_idle_d3 per device
      vfio/pci: Release the VGA arbiter client on register_device() failure
      vfio/pci: Fix racy bitfields and tighten struct layout
      vfio/mlx5: Fix racy bitfields and tighten struct layout
      vfio/pci: Latch all module parameters per device
      vfio: Remove device debugfs before releasing devres
      vfio/pci: Expose latched module parameter policy in debugfs

Sean Christopherson (1):
      vfio: selftests: Add luuid to libvfio.mk's list of libraries, not to the Makefile

 Documentation/ABI/testing/debugfs-vfio      |  26 +++++++
 drivers/vfio/debugfs.c                      |   1 +
 drivers/vfio/pci/mlx5/cmd.h                 |  15 +++--
 drivers/vfio/pci/vfio_pci.c                 |  30 ++++++---
 drivers/vfio/pci/vfio_pci_core.c            | 101 ++++++++++++++++++++--------
 drivers/vfio/vfio_main.c                    |   8 ++-
 include/linux/vfio_pci_core.h               |  18 +++--
 tools/testing/selftests/vfio/Makefile       |   2 -
 tools/testing/selftests/vfio/lib/libvfio.mk |   2 +
 9 files changed, 152 insertions(+), 51 deletions(-)
