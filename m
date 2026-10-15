Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0129B216
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105425; cv=none; b=nhhmYzZS74jPJj2m1L5mXN81tNzzln16yXMGN7fRUop0tGkWSfxqYkj0LOcxgwPZElL0b+MFxaWNrzkx5hVWk1BvBSsEBmvaMnMOnjMPjgvhNkvZ1SOWzk7sPxwd1/Jo2pP8628g6KqVrvL55/wGLNQIiwJEwEAb2TRHXIlKPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105425; c=relaxed/simple;
	bh=DKF5cq/VsYFkoapTDKuX27Bdb1xfZ2g6cxZ3EO61jFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YySvZj30l3TjRyw5NagUeK9qD96ecsPThMnurBP7y20jpdJg2EqZj9FsD5hNiFQFoKFzJh5Uf25fRb3vgSiyQISijbrv15Sjd5XmeDcJI7LNH26PM1fAgn4upclKeUnJHkbegmfLq2vXNCHS/z5Xlr7NbuJP1zwDuMGkBg8OlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DA+U3Ql4; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DA+U3Ql4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792105430; x=1823641430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DKF5cq/VsYFkoapTDKuX27Bdb1xfZ2g6cxZ3EO61jFc=;
  b=DA+U3Ql4Vq5M7uFdlIzjiq490UTtJOHYsFoYPUvTcCYJP3k6BAMczoBT
   FC3A36d5yrEpd7CeM8OoagtVcTq9IsaIcXXymK5ux1FmXUsolwq2mUiSs
   gPWHEMJmvO2INvZuBV01pz01goxYTU6pkk+HMOQJpQr2tJZtkaoWgzu0y
   LQx+PeaPxCLuTOOHKNuG+4veyB4mNlQFayobWOYj/UXdXjV2E88lu71l0
   PohKfzVQ7BcZ6XHN5PSu2r4aEiWJM8REKKs3G8Coqi9ns42wtyQ6ueOIr
   ZyjnwhRmEZm5L46/Zb0qzyIz1shhb4gxC0dPfgzl172xcWKk6Jh089SFQ
   Q==;
X-CSE-ConnectionGUID: YQKXNVp/QDSTYX0nqdSjGw==
X-CSE-MsgGUID: UEIVkxUTQ+OowHEMO7KvBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="246307839"
X-IronPort-AV: E=Sophos;i="6.27,160,1786978800"; 
   d="scan'208";a="246307839"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 08:02:39 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 3990B1C016BC
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:02:33 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id E6A84C00825
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:02:32 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTPS id E18E91004B0A;
	Thu, 15 Oct 2026 23:02:28 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:02:25 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>
Subject: Re: [PATCH 0/2] KVM: arm64: Cleanup the HCR_xyz macros
Message-ID: <atFbgc76lPx44Psn@sm-arm-grace07>
References: <20261015173605.1072963-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015173605.1072963-1-maz@kernel.org>

On Thu, Oct 15, 2026 at 06:36:03PM +0100, Marc Zyngier wrote:
> I've been postponing this for some time, but it finally happened: no
> more HCR_xyz macros.
> 
> This series converts the whole thing in one go, using the script
> fragment contained in the first patch. No AI agent involved, all bugs
> are mine! I intend to take this in for 7.4-rc1.
> 
> Patches on top of kvmarm-7.4.

I've applied this series on top of kvmarm-7.4 and it builds with my
.config. The kernel boots fine with QEMU in TCG mode, some vgic_*
kselftests ran without failure.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.

> 
> Marc Zyngier (2):
>   KVM: arm64: Convert HCR_xyz to HCR_EL2_xyz
>   KVM: arm64: Get rid of compatibility HCR_EL2 aliases
> 
>  arch/arm64/include/asm/el2_setup.h      |   4 +-
>  arch/arm64/include/asm/hardirq.h        |   6 +-
>  arch/arm64/include/asm/kvm_arm.h        |  79 ++--------------
>  arch/arm64/include/asm/kvm_emulate.h    |  18 ++--
>  arch/arm64/include/asm/kvm_mte.h        |   4 +-
>  arch/arm64/include/asm/kvm_ptrauth.h    |   4 +-
>  arch/arm64/kernel/head.S                |   4 +-
>  arch/arm64/kvm/arm.c                    |  28 +++---
>  arch/arm64/kvm/at.c                     |  18 ++--
>  arch/arm64/kvm/emulate-nested.c         | 116 ++++++++++++------------
>  arch/arm64/kvm/guest.c                  |   2 +-
>  arch/arm64/kvm/handle_exit.c            |   2 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  14 +--
>  arch/arm64/kvm/hyp/nvhe/host.S          |   2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S      |   2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  20 ++--
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c   |   6 +-
>  arch/arm64/kvm/hyp/nvhe/pkvm.c          |  32 +++----
>  arch/arm64/kvm/hyp/vgic-v3-sr.c         |   4 +-
>  arch/arm64/kvm/hyp/vhe/switch.c         |  12 +--
>  arch/arm64/kvm/hyp/vhe/tlb.c            |   2 +-
>  arch/arm64/kvm/inject_fault.c           |   6 +-
>  arch/arm64/kvm/mmu.c                    |   8 +-
>  arch/arm64/kvm/nested.c                 |   8 +-
>  arch/arm64/kvm/sys_regs.c               |  24 ++---
>  arch/arm64/kvm/vgic/vgic-v3-nested.c    |   4 +-
>  26 files changed, 182 insertions(+), 247 deletions(-)
> 
> -- 
> 2.47.3
> 
