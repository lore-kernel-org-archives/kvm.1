Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.36.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788087;
	b=qy7ACGNeRjoXj9Z5PWo574XO7C+y1TaMo8OD8P3fMH1Z/gAx6V8lDEEGyWjZoOTMCqVH
	 cchm28uBJO34dN05PeyF5oDJM3Ajm/cIJg+2+EycIDJDrjFk1m0hqRXhbAv3LuBNN8B5T
	 J/iYGmiHYDzKQTP7DE3pD7EZPnF/V+VAwnShVcV+eA5xdO9gzreXtcLv7mDbqEoBskgvI
	 2Tx+WashgrIX49tg++747kPWBGjrX/I5L4SRs3k8ZJ7e0nDZQH2i+QUBobydwKNVFRIV1
	 1U4ct0HUeQmfsL8sxBLxN+SkK2Pt7I2JzjFDKlIU4lqMOTsz8wnGiApYA0z1Zu+aECA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788087;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7veRrT8eWAeBKJG1Q0lJd1x2zWh4g6/qHWjAZxV9nEY=;
	b=Zv3IxsIXCrlk9bPLbesgba5PLEJqQ50wgc7mpSs3C9j6g2B5rnY7mMyNVCnNfj6x4b97
	 sGl/YKStCs2Auwg7XKd8/LlZaTU+aChEtmZO6aRP1IGHlzF/OacCAFjLpY+o4VIPSN969
	 LDek3XIJW0t+1AWlwtBBS3t02M0kXfKPwz2Xtx2TsOjlyUE39wbHgSQMBE77gsX9iJJAY
	 ip/pK+M/fKUy82HFCFobxwvFYz7fxZj+vtNvBMSghUdssnzHhogxTUfrUU7ZLZjSiQYJP
	 5Rx5c5c+YiwWhx01DeQpeEKJzeSCYzbu9qnvQGJVUn4qaOwjdvd+UrjFw2eK9pX3p/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=hPZv5LCv;
	arc=none smtp.remote-ip=139.138.36.223
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3B606A32D;
	Wed,  4 Nov 2026 10:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C3B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=hPZv5LCv
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793788086; x=1825324086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wlmr7Aue0wdrqc12Gk8qvFNC+7tKFeGN9AZd173LYv8=;
  b=hPZv5LCvDWR0FdeUaYhDyDEqCZFhA36AuOTG8IUKr6kMdSMcxZHg1x/X
   0vScttnkX5kBRkGfyJIwmKCF+GQL2wwdEq4Q6SZMoFiYf0Ft4/U5Nhtuk
   8dpT72PURJjhSPluRnu5WvBux0LyPw2Qky+1C0KVGzcl1UVFrgzgqJUEs
   06lf7pTKSnpVmKu8uD313mX2PbXzeG065tmm4TPJuDB2A3sB5F+yutHt8
   rPak6dGm6rJPc4FITJipI7EqyD3sHWM5ioKjal90MVLTCk363tbhnkeLM
   qDmOjuhj6L3Kmmv871hDKm2F/QDfD40W6Ez/Fs6xoDaQ4uAysT57pnJMt
   w==;
X-CSE-ConnectionGUID: EuywL0MeQw+fb7n/VpJK+w==
X-CSE-MsgGUID: WYR4WEt4SsCtHqBNXco7eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="248111870"
X-IronPort-AV: E=Sophos;i="6.27,195,1786978800"; 
   d="scan'208";a="248111870"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:27:59 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id DB26A1C1C734;
	Wed,  4 Nov 2026 10:27:58 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 8908E8D29E6;
	Wed,  4 Nov 2026 10:27:58 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.160])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with SMTP id A62E61800599;
	Wed,  4 Nov 2026 10:27:50 +0000 (UTC)
Date: Wed, 4 Nov 2026 19:27:49 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 03/11] KVM: arm64: CCA: Check for RMI support at KVM init
Message-ID: <ausIgejq7Io9VjZL@FCCLS0092175.localdomain>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-4-steven.price@arm.com>
 <ausEnXB1TE_moI0E@FCCLS0092175.localdomain>
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
In-Reply-To: <ausEnXB1TE_moI0E@FCCLS0092175.localdomain>

On 11/04 19:23, Kohei Enju wrote:
> Hi Steven,
> 
> On 11/02 14:12, Steven Price wrote:
> > Check if the RMI support is sufficient for using in KVM. Specifically, we
> > will only support creating realm VMs when KVM is set to 'rmm' mode.
> > 
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> >  arch/arm64/kvm/Kconfig | 1 +
> >  arch/arm64/kvm/rmi.c   | 4 +++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index cecea0820e52..d067063a3686 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -34,6 +34,7 @@ menuconfig KVM
> >  	select GUEST_PERF_EVENTS if PERF_EVENTS
> >  	select KVM_GUEST_MEMFD
> >  	select KVM_GENERIC_PRE_FAULT_MEMORY
> > +	select ARM_RMM_RMI
> >  	help
> >  	  Support hosting virtualized guest machines.
> >  
> > diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> > index 5ecc8b349869..9d118768550d 100644
> > --- a/arch/arm64/kvm/rmi.c
> > +++ b/arch/arm64/kvm/rmi.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2023-2026 ARM Ltd.
> >   */
> >  
> > +#include <linux/arm-rmi-cmds.h>
> >  #include <linux/kvm_host.h>
> >  
> >  #include <asm/virt.h>
> > @@ -12,7 +13,8 @@ void kvm_init_rmi(void)
> >  	if (kvm_get_mode() != KVM_MODE_RMM)
> >  		return;
> >  
> > -	/* TODO: Check if the RMI is available */
> > +	if (!is_rmi_available())
> > +		return;
> 
> From an admin/operator's perspective, kvm_rmi_is_available would
> silently remain FALSE in either of the following cases:
> - kvm-arm.mode=rmm is set, but RMI is not available for some reason.
> - RMI is available, but the admin forgot to set kvm-arm.mode=rmm.
> 
> So I think it would be useful to emit diagnostic messages for these
> cases, for example:
> 
> if (!is_rmi_available()) {
>     if (kvm_get_mode() == KVM_MODE_RMM)
>         pr_info("Realm VM support is disabled because RMI is not available\n");
> 	return;
> }
> 
> if (kvm_get_mode() != KVM_MODE_RMM) {
>     pr_info("Realm VM support is disabled. Use kvm-arm.mode=rmm to enable it\n");
> 	return;
> }

Sorry, the indentation got mangled :(

> 
> Thanks,
> Kohei
