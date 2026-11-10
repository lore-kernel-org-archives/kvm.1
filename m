Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302676;
	b=FQGeuQrqXTZgcVUDX0VJ/16AhzWm8ys3NKoKogoBVFowztTX1hxlopsSyue0d9PrdCwb
	 5XruqSXKGaz1dtj4xdjZTQe/In1YPGGRnESuqTuqSzw4oFFl09Zo1HO28nFwx1IZvlfOZ
	 IIu5BsF/AHvJFHM6L0BRCdcWhkvdCmcfKRjDA7GvxElwhGVkxcPyYlL+g1WZ9Jw6V6GO7
	 0Qb34eY2/d2++1A/93X/xnst2hw3yfPwUQnqiHnASCtz2EEhs1Cs2I2u9+YuEl6iELnTD
	 d9mT29Pe5yFyMQbtfp4ikXEYlVZ50KCgbKHr5ZBneDskF5Jgw1K4pdUd4GduOrYO6Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LWR9vxDpfyJAKF5RgruZrTkh8ttPuorehv2eynfAWfY=;
	b=pEVnOgEhAZ2PmJSAFerKRqD+ApEFFLE89opOnM5Q2vUpXm+N9wGNS/v4ZPldfngf0W9I
	 Uv1gxsvN97Hwa2fxEGE347sNHvjGDI++2whXmA5OQUQfRAV3d7rbNoAnw0ihrlLpCv8v5
	 rdsi8LELcLWgEm3GHT7bZViFW8kwoJMay8AQwCBm3n5JNRhifE5Lfaquv9g99CAMBRdcw
	 v50ec6EeA/kZA0S+gl83fqDIXAfWObk0uFF2DBufDzMVkb1lNBro1wM/pnfFLwFlZFjlJ
	 LZfW1dhyKWEDrc9lREflYnfIw0Jztvol1JcrDBwhH33Ybs1/hQ5jhHMooOhMZO4py1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=EaeWgrwa;
	arc=none smtp.remote-ip=139.138.61.253
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2307606A931;
	Tue, 10 Nov 2026 09:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2307606A931
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=EaeWgrwa
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1794302675; x=1825838675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tAn9etkH1K72b0If4iL3ZP13Ct439bRX2/j7e7dhMuk=;
  b=EaeWgrwaDOP2uWivmn82R+CgZA/y9lrW5an6zb8Pgswinl3jQ3VrgC/r
   vUSzKo6U3a1R8a/Gbcd7nIhjzUTNej9mPqLlcYZ/FKMaRkfTZsyJ6E5C7
   WwkdiLK+5M2pVy2K8vkwoVL9+80z3j1/0i4cnf8YSGK73AMN4n5SvLr7t
   kPall5bXyN4g/hKp8mMVplvGSCQZsywS4ZPw5nBj0X9LcefTMQpl69AGz
   AQvC2rkTRMqD2mKxSNbAgbHNEo1bDszphpJbrfAtodLf9uZ6ruQVXRml+
   okCZaT4cwFliLgnPtzzLqj1O2OwCrxyKgOO0rXaS0CMrz0ugHjq3VcCZB
   w==;
X-CSE-ConnectionGUID: /ckuOwG0T1ye/yfEKCRCUg==
X-CSE-MsgGUID: m5wMWlCXTYyNN2Mytkc13g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="249236744"
X-IronPort-AV: E=Sophos;i="6.27,205,1786978800"; 
   d="scan'208";a="249236744"
Received: from gmgwnl01.global.fujitsu.com (HELO mgmgwnl01.global.fujitsu.com) ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:24:27 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mgmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id DCC1226E1;
	Tue, 10 Nov 2026 09:24:27 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 9650618026EB;
	Tue, 10 Nov 2026 09:24:27 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.34])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 3ABC11019053;
	Tue, 10 Nov 2026 09:24:18 +0000 (UTC)
Date: Tue, 10 Nov 2026 18:24:17 +0900
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
Subject: Re: [PATCH 00/11] KVM: arm64: CCA: Prepare Realm memory management
Message-ID: <avLgdqlfUPMAI-r9@FCCLS0092175.localdomain>
References: <20261102141304.126883-1-steven.price@arm.com>
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
In-Reply-To: <20261102141304.126883-1-steven.price@arm.com>

On 11/02 14:12, Steven Price wrote:
> This series adds the memory plumbing for CCA building on the basic
> plumbing[1] that has just been merged.
> 
> These patches add the internal realm VM state and RMM feature checks,
> prepare realm stage-2 setup and teardown, and provide RTT mapping and
> invalidation helpers. Realm memslots are now contrained to the lower
> half of the IPA space, because faults treat the protected and shared
> halves as aliasing. The final patch then connects these helpers to the
> KVM stage-2 MMU operations.
> 
> There's also an integration branch[2] that builds on this series and
> includes the realm descriptor creation, REC entry/exit, activation and
> the new uAPI. This series by itself is also available as a git
> branch[3]. However the new code isn't generally active without the full
> integration branch.
> 
> [1] https://lore.kernel.org/all/20261007073537.2454351-1-suzuki.poulose@arm.com/
> [2] https://gitlab.arm.com/linux-arm/linux-cca
>     branch: cca-host-mm/v1/integration

Hi Steve, thanks for your work on CCA upstreaming.

For testing purposes, could you clarify which TF-RMM revision (or commit
hash) you tested with? Although this MM series itself doesn't seem to be
particularly sensitive to changes in TF-RMM, testing the integration
branch could be affected by subtle changes in the RMM.

It would also be useful to know the TF-A revision, if possible.

Thanks,
Kohei
