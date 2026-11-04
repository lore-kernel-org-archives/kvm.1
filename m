Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789252;
	b=dnqWJZB0tfKzHZWEZGZwKmP7bDYzu8XzYJt+Dt5m0BgMV2BYjHIJhf9MlbrHyO0o8f0r
	 1M06Q819siVkPqROKQtOhJzGtTr94cRELMUuw2XwzNWVcUL8usM/JcGIN2DxTI46K0FR6
	 30G0AVIayIMbo4KOPYkqEJg+ZjNrT5AlW3l/V0R7rcG8rcd13lYIdhz42ESvxBTPTxg78
	 Dr0OOb07Vp0zOangUL2o7L+U89VySAGx6b7zArGN1aN2V7WtZTXDYQfpPOGoKTN4caz8u
	 ImY1Bfrc1gBK/t/DzhGiWhJPy+lflbKVzN4hwrRTlRlAAxgyCTeD1Oa/Jf8y9QbpX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789252;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=22l6K0vc3gDu3+b6teU5yRSj5i9d0PgiGkuk6VorJmM=;
	b=gpMD/ykEZ+wiKcd4f1BkGMr/EW69GRU8+JN59ISio8qLaubTt3gXe5HPk3OkuhSLGYmQ
	 qnVYaj9q5kcj3yYcRXVVt5ux9X5TBCZDXFUNmjuEifdeCfAwLwdyvb3pOcUDq6JcwYwdw
	 +T0lo9fbSFPo2Ko67VyTfqDG9yqfoVE8/SSAMvJDXnhgK6hfXlQjWL7rbCFPap0hTRMkH
	 uR//lahZSXzTG/bWEoqh9lRZvphdKxqcwyJnG9UfgPkF3Id9xAOHziYUrykgKxesiAdPC
	 zk+beBKXJdbz/xWQZE7FWM20UBxo2SsZsElO1QIqUe9Pk38MFl2ToaKWSnkTi2/0nrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=OCMRmMCT;
	arc=none smtp.remote-ip=139.138.61.252
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B374606A331;
	Wed,  4 Nov 2026 10:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B374606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=OCMRmMCT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793789251; x=1825325251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bX+/GudjC/kKj8X2pfBeTqIEajpanRfKGl78WAKq9sc=;
  b=OCMRmMCTniiJX89CtofPAk1XkvlkxlUlukGasjd5EBvB1EiuNGcdTn10
   gWTGD3aRoLoLagJDSaKC2d7z78g7RUrVBbYcP8T3FzmGJaJqTsNUK1ko6
   DMzQn5lNTx9hSstw7cVub+Yli9rV+H6/Gr8T0UjqMtlLi/tTavdJxfGqi
   mS7P/YKOdNyfZHRKFrrSFAn+7t131Y0cYC0tt5rUSL4kIxRioWNMlD6W6
   PVvziNp8rZWWoMXCmT49mv++7274fIyfU3YQYb5FzmJzqRO4nSdcHdL22
   0KmyS98cFYpFMm2EMy/G80JkOqVykgH/I4DPq/Oprgy7qZsy7OWxDpdbN
   g==;
X-CSE-ConnectionGUID: 7FHHPqQXTP2joOQKyp/UJw==
X-CSE-MsgGUID: lqi9HaqMQpa2Cel04XkqhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="239465831"
X-IronPort-AV: E=Sophos;i="6.27,195,1786978800"; 
   d="scan'208";a="239465831"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:47:23 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 9F2AD1C00643;
	Wed,  4 Nov 2026 10:47:23 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 4DCC01000864;
	Wed,  4 Nov 2026 10:47:23 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.160])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 246CD100A6C9;
	Wed,  4 Nov 2026 10:47:13 +0000 (UTC)
Date: Wed, 4 Nov 2026 19:47:12 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 03/11] KVM: arm64: CCA: Check for RMI support at KVM init
Message-ID: <ausMpjow5k9wnO_Q@FCCLS0092175.localdomain>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-4-steven.price@arm.com>
 <ausEnXB1TE_moI0E@FCCLS0092175.localdomain>
 <ausIgejq7Io9VjZL@FCCLS0092175.localdomain>
 <415f6a96-9ac2-4256-a9b9-e976bd0e73a8@arm.com>
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
In-Reply-To: <415f6a96-9ac2-4256-a9b9-e976bd0e73a8@arm.com>

On 11/04 10:39, Suzuki K Poulose wrote:
> Hi Kohei
> 
> On 04/11/2026 10:27, Kohei Enju wrote:
> > On 11/04 19:23, Kohei Enju wrote:
> > > Hi Steven,
> > > 
> > > On 11/02 14:12, Steven Price wrote:
> > > > Check if the RMI support is sufficient for using in KVM. Specifically, we
> > > > will only support creating realm VMs when KVM is set to 'rmm' mode.
> > > > 
> > > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > > ---
> > > >   arch/arm64/kvm/Kconfig | 1 +
> > > >   arch/arm64/kvm/rmi.c   | 4 +++-
> > > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > > > index cecea0820e52..d067063a3686 100644
> > > > --- a/arch/arm64/kvm/Kconfig
> > > > +++ b/arch/arm64/kvm/Kconfig
> > > > @@ -34,6 +34,7 @@ menuconfig KVM
> > > >   	select GUEST_PERF_EVENTS if PERF_EVENTS
> > > >   	select KVM_GUEST_MEMFD
> > > >   	select KVM_GENERIC_PRE_FAULT_MEMORY
> > > > +	select ARM_RMM_RMI
> > > >   	help
> > > >   	  Support hosting virtualized guest machines.
> > > > diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> > > > index 5ecc8b349869..9d118768550d 100644
> > > > --- a/arch/arm64/kvm/rmi.c
> > > > +++ b/arch/arm64/kvm/rmi.c
> > > > @@ -3,6 +3,7 @@
> > > >    * Copyright (C) 2023-2026 ARM Ltd.
> > > >    */
> > > > +#include <linux/arm-rmi-cmds.h>
> > > >   #include <linux/kvm_host.h>
> > > >   #include <asm/virt.h>
> > > > @@ -12,7 +13,8 @@ void kvm_init_rmi(void)
> > > >   	if (kvm_get_mode() != KVM_MODE_RMM)
> > > >   		return;
> > > > -	/* TODO: Check if the RMI is available */
> > > > +	if (!is_rmi_available())
> > > > +		return;
> > > 
> > >  From an admin/operator's perspective, kvm_rmi_is_available would
> > > silently remain FALSE in either of the following cases:
> > > - kvm-arm.mode=rmm is set, but RMI is not available for some reason.
> 
> We could add a kvm_info() message for this.
> 
> > > - RMI is available, but the admin forgot to set kvm-arm.mode=rmm.
> 
> But not this one. We are additionally planning to move the RMM
> activation to gate on kvm-arm.mode=rmm. I will send out a patch
> soon.

I wasn't aware of that plan. In that case, this scenario will be
unreachable, so I have no concerns.

Thanks,
Kohei
