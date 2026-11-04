Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787827;
	b=4S/1sPlvOn9BDmVegUPGSuPRDL6ubN6kLebKjZfJcEsPlzeM+9ptcxTAgkukNPUmjmd2
	 M6B/T8J+l9+cIh+r/U0zBqEN4UYh2Kb06jY4GQgXQ6a3EDllcGRkIzNm6GmhWv2Megp8U
	 osksAuMxeYO25VLzYx1fnEIKBm/JZtMv57HSDDL4+gNClL1kESeKx3y23WZMnzDthr/a4
	 x3u/IIzwN/qTXUiEAuFGhC4quOLWp1bpE9X2JIswktZEfZcfa6pWcx8bSSGGsiNSOtKGd
	 apJISppOvxQYEvxtdVjsjqqG/TQaFzFvDHQ2SYoWp1uIrqQTSNo7dwarqWq18CUdoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787827;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=n4Ps0qSkWYG+d69oSo/IEmxe2Snl/v2IpZ6SrpXA0rw=;
	b=Hj9whr47Q1BoGiU4ZgXRYwjX7+fLxg0ENuBE3ThrE5DTep1pBhm3TJeC0czkweF8JqVb
	 K8vuIH1dLTw6JH+lHTZ3HRB7CjodNALAe2+Q1QYxMf0VCSX6XYj/RCljVY8UuPo6ce+rc
	 8U0XgJD6DoHNGF3ONef0PRd5hnbdZ/mb5+tZa8TiClKXTmrUM0BnSd4rv34w2gjkCHRcJ
	 yyUFZNLrYeEZF5QskBGTfsn7uKg3BPbfNNhjM8WO07xe6lTD3edTdm2W4mylSrqHlEYah
	 51JWvb4YW8jNKejf90BOZUtEpp0JO1RLNG9WMZt3tK9lZyAXecAgqS8A2HJt2zhzKrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=TC91HNUy;
	arc=none smtp.remote-ip=139.138.61.253
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B079606EE9C;
	Wed,  4 Nov 2026 10:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B079606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=TC91HNUy
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793787833; x=1825323833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSpsS79pjRX5vqOjgAJTbb2PTGzrYCU3NoXWTJpFtPw=;
  b=TC91HNUybe0sNvKP63DiV+NeMuHNAhTyatCFDX7Vl1RE2KO1TFAWAuBS
   ek+/Lt0uTkq0qvQUcM1wLYKsSIRyTN7GFz3u3jfjrBh/DSmJdRsRTOdjk
   Vp4l34J/tQEPCRTqxcVqa77o4wYabD0dcGKPYL+uP54u+HyUIHCsSF8UM
   eNzP0oByWsqaoO5pGpM/UFOVlP3/g4OwktTbWexX9ZysQWEg4CPwggX+B
   o6gDBsnPP2VWl1iS+CMwLut3f98N71AIQnC7Wl90bKAAw/3SHiq2qg9zb
   MVVxM6trDtUZO28/6cNbAghEJi2HCPfXqHur0L0cCSAhEAGcQEkWrS/gX
   w==;
X-CSE-ConnectionGUID: 8El1mhocS8+FWRnVMyK7Dg==
X-CSE-MsgGUID: FQEoC/YgRUWmdaptku2JDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="248544362"
X-IronPort-AV: E=Sophos;i="6.27,195,1786978800"; 
   d="scan'208";a="248544362"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:23:46 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 8689B10000C4;
	Wed,  4 Nov 2026 10:23:39 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 397971C002D2;
	Wed,  4 Nov 2026 10:23:39 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.160])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with SMTP id 12AB04059A5;
	Wed,  4 Nov 2026 10:23:30 +0000 (UTC)
Date: Wed, 4 Nov 2026 19:23:29 +0900
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
Message-ID: <ausEnXB1TE_moI0E@FCCLS0092175.localdomain>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-4-steven.price@arm.com>
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
In-Reply-To: <20261102141304.126883-4-steven.price@arm.com>

Hi Steven,

On 11/02 14:12, Steven Price wrote:
> Check if the RMI support is sufficient for using in KVM. Specifically, we
> will only support creating realm VMs when KVM is set to 'rmm' mode.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/kvm/Kconfig | 1 +
>  arch/arm64/kvm/rmi.c   | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index cecea0820e52..d067063a3686 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -34,6 +34,7 @@ menuconfig KVM
>  	select GUEST_PERF_EVENTS if PERF_EVENTS
>  	select KVM_GUEST_MEMFD
>  	select KVM_GENERIC_PRE_FAULT_MEMORY
> +	select ARM_RMM_RMI
>  	help
>  	  Support hosting virtualized guest machines.
>  
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index 5ecc8b349869..9d118768550d 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2023-2026 ARM Ltd.
>   */
>  
> +#include <linux/arm-rmi-cmds.h>
>  #include <linux/kvm_host.h>
>  
>  #include <asm/virt.h>
> @@ -12,7 +13,8 @@ void kvm_init_rmi(void)
>  	if (kvm_get_mode() != KVM_MODE_RMM)
>  		return;
>  
> -	/* TODO: Check if the RMI is available */
> +	if (!is_rmi_available())
> +		return;

From an admin/operator's perspective, kvm_rmi_is_available would
silently remain FALSE in either of the following cases:
- kvm-arm.mode=rmm is set, but RMI is not available for some reason.
- RMI is available, but the admin forgot to set kvm-arm.mode=rmm.

So I think it would be useful to emit diagnostic messages for these
cases, for example:

if (!is_rmi_available()) {
    if (kvm_get_mode() == KVM_MODE_RMM)
        pr_info("Realm VM support is disabled because RMI is not available\n");
	return;
}

if (kvm_get_mode() != KVM_MODE_RMM) {
    pr_info("Realm VM support is disabled. Use kvm-arm.mode=rmm to enable it\n");
	return;
}

Thanks,
Kohei
