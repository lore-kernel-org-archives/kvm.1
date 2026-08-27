Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E18361657;
	Thu, 27 Aug 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832583; cv=none; b=ty6Vr/Lo/MOVYEc/LJZZ5ZHh9xCKwBIxIJvqHonCEAT6IAQocTZGjxH/Qxh203WgoSqw4gX5GarEZTLPljvGuQmDDCIhEqxMVfWH9L6KAWUcglwv14gwQu78NUlHwKKbonEe0/uqgUSiCE/XO96OKDYUdyE806ewnTz/BmcylnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832583; c=relaxed/simple;
	bh=JRvlOElT6TmzC89Oveb4gR0vmINpmjM3tG5TOYB0KaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbEKCOhttQzdmIyoetSyd0WecMansFY+nSO74NklDtsyFIU2lFzYuOxGVFbv93BknybM2eaa0rc+rhthGHTz/TXRmsWaadTKkL6dWa/76KAm7Zb1+FDZUwJTAevQ2w3F90S4PkZIHtbgznjLEdeMjLfOLseH4ROtoa0Oe3ouN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IA6h0bYO; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IA6h0bYO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787832584; x=1819368584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRvlOElT6TmzC89Oveb4gR0vmINpmjM3tG5TOYB0KaU=;
  b=IA6h0bYOZK4g7Ia6TbuQRthaLadH6T5lPLt8UTby7KZLkG/p8dHuLBrD
   sa3Xuzqb21M47OLiQWLco9mzp431Vjinnlo0rwU1T7t224uYckQWjaSfS
   jfT3kfZT4vsrvcl82jyGrTsP3N98nUe2pnV0I/n1dHeXMhZ9r4LC54+Jo
   A1Xx0e4jDmegcr8Eskgl+xGAnIiJCVb2Uep7PHnSR/O3nsIzdgDhsaYoB
   brH+bzDGQBkZawrUKVxkDPo1HiTUaCcZODC9UV/XajHRqNc5gxM8jDXJz
   o/PgvUtHiK3gUWatbeCZpMnbnU5PEOcV135D2U0xBzM7qAiS9aq/ZABhK
   g==;
X-CSE-ConnectionGUID: eDpo6XExRq2gF/sxV0H2+g==
X-CSE-MsgGUID: bUdJRO9fReCLS7CzX5BLug==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="256568375"
X-IronPort-AV: E=Sophos;i="6.25,246,1779116400"; 
   d="scan'208";a="256568375"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:09:42 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B958F820C3D;
	Thu, 27 Aug 2026 12:09:38 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 741BCC00544;
	Thu, 27 Aug 2026 12:09:38 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.202.6])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with SMTP id 6A37710001F0;
	Thu, 27 Aug 2026 12:09:30 +0000 (UTC)
Date: Thu, 27 Aug 2026 21:09:28 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v16 44/45] KVM: arm64: CCA: Require ICH_HCR_EL2.TDIR for
 realms
Message-ID: <apAn76fFvpDZ_eBF@FCCLS0092175.localdomain>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-45-steven.price@arm.com>
 <anlZCIauOq4Lvv0I@FCCLS0092175.localdomain>
 <86wlty1fds.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86wlty1fds.wl-maz@kernel.org>

On 08/10 10:41, Marc Zyngier wrote:
> On Mon, 10 Aug 2026 05:58:10 +0100,
> Kohei Enju <enju.kohei@fujitsu.com> wrote:
> > 
> > On 08/03 14:44, Steven Price wrote:
> > > KVM advertises realm support when the RMM is available, and allows
> > > userspace to create a VM with KVM_VM_TYPE_ARM_REALM on that basis.
> > > 
> > > On CPUs that lack ICH_HCR_EL2.TDIR, KVM uses ICH_HCR_EL2.TC for
> > > normal guests so that ICC_DIR_EL1 is still trapped via the common GICv3
> > > CPU interface trap. Realms cannot rely on the normal hyp-side trap
> > > handling for that fallback, so advertising RMI support on such systems
> > > lets userspace create a realm that cannot safely run.
> > > 
> > > Require the finalized ARM64_HAS_ICH_HCR_EL2_TDIR capability when
> > > reporting KVM_CAP_ARM_RMI and when accepting KVM_VM_TYPE_ARM_REALM.
> > > This leaves normal VM creation unchanged on systems that need the TC
> > > workaround.
> > 
> > Hi Steven,
> > 
> > Thanks for your work on upstreaming CCA.
> > 
> > In the v15 discussion [0], you asked whether the system I was testing was a
> > "hacked up test system" or closer to "production hardware", and I said I would
> > share more when the time came. I can now say that this is not a hacked-up test
> > system. At Fujitsu, we have real hardware (FUJITSU-MONAKA) which implements CCA
> > (FEAT_RME) but does not implement FEAT_GICv3_TDIR. The hardware details are as
> > follows:
> > 
> >   - GICv4.2 compliant implementation
> >   - Supports FEAT_GICv3, FEAT_GICv3p1, FEAT_GICv4, FEAT_GICv4p1, and FEAT_GICv3_NMI
> >   - Does not support FEAT_GICv3_LEGACY (deprecated)
> >   - Does not support FEAT_GICv3_TDIR (ICH_VTR_EL2.TDS == 0)
> > 
> > For reference, compared with Arm Neoverse V3, the virtual GIC configuration is
> > largely equivalent. The only missing non-deprecated architectural feature is
> > FEAT_GICv3_TDIR.
> 
> A *very* significant difference. Given the cost of trapping between
> R-EL1 and NS-EL2, something as simple as accesses to ICV_PMR_EL1
> result in an extremely expensive trap.
> 
> > 
> > The issue I see is that the CCA KVM code currently does not support a
> > configuration (non-TDIR/common-trap) that normal KVM already supports. For
> > normal guests, KVM handles systems without TDIR by using ICH_HCR_EL2.TC and the
> > existing GICv3 CPU interface emulation path. However, Realm guests currently
> > fail because the CCA path bypasses that existing emulation path, as Marc also
> > pointed out in [1].
> 
> Plugging CCA in the emulation code will solve the *functional* aspect.
> The performance aspect is still there, unfortunately, and there isn't
> much KVM can do about that.
> 
> > 
> > Also, this is not limited to systems that actually lack TDIR. The same failure
> > can be reproduced on a TDIR-capable system by booting with:
> >   kvm-arm.vgic_v3_common_trap=1
> 
> This is a *debug* option for broken hardware. ThunderX, for
> example. You really are in good company when this bit is set.
> 
> > 
> > So it seems that the current CCA KVM implementation does not yet cover a
> > configuration that normal KVM already supports today, rather than this being a
> > limitation of the RMM specification or the underlying hardware.
> > 
> > I've included a patch below which reuses the existing GICv3 early emulation
> > path for Realm sysreg exits. This patch does not add any new vGIC emulation
> > code, and leaves the existing vGIC emulation code unchanged. So I believe this
> > is in line with Marc's request in [1]. With this patch, Realm guests can run
> > when the common CPU interface trap path is enabled.
> > 
> > I tested the exact patch both on our real silicon and on QEMU, and
> > confirmed that all Realm-related tests in kvm-unit-tests-cca passed.
> 
> KUTs are unfortunately not something that people run in production. I
> wonder why...
> 
> Please run a Linux guest compiled with CONFIG_ARM64_PSEUDO_NMI=y and
> irqchip.gicv3_pseudo_nmi=1 on the command line. Run any significant
> workload (hackbench, for example), and report the overhead. This will
> give you the expected impact introduced by the lack of TDIR.

Sorry for the delayed response.

Understood. I will run a Linux guest with CONFIG_ARM64_PSEUDO_NMI=y and
irqchip.gicv3_pseudo_nmi=1, measure a representative workload such as
hackbench, and report the overhead.

Thanks,
Kohei

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
