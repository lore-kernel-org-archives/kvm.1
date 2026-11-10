Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312718;
	b=TO4rMjpz2ah87AVbM+ZJrLJoCbNuDRdKMjpolLdpVPVrxehFUJyOAMd1cOLje55RdcCJ
	 1w0emrhAo+UatfbAAxc6rIGP6uORvl3Lv9CwN7yyxVggZWocY5+M6d16d0nQxTfp9UMXO
	 ky4sDsLe1nPmW+/PRZeuvIUD/7vGLcKndETU+Irt64qEpFlyl+YeyNss3twK6ublLSgOD
	 ujkPfB9lpGYu3GXnJVBbeqnJ8pq+wT9stN9+K1McicadWLHkJcWVqV+fuwReh/uLEMU8X
	 GzGD09zbFc5fSXqVQSd5ZiCB72AMzrkqTeDpX9DJYCAaX+BUTsw6UqNbkdUHao62ImQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312718;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xPi/3K5EgSO8uxLuJimni9tpMpXLjb9QZkfq/GsXYRI=;
	b=2MFE5OIdsVvbgHFfNxn18w1FpYECuA+8udGtzY/VCxaEBAtZazSIqa36ItYyJzqqTmDx
	 5cDd6NP8HS7hRE34l4mST0sy5XmSNP5OO/AWXiJK1rZbhJRlOBGVmFu8rbJ1goNZ9zJ5X
	 eiBeF+ogTMZnIBN2gaP2wxXpfjiad055ndu2Z6NgVnvYAVU0s1E6g0JfXNE6DXhisQl8p
	 XOeBh8q3N7ei8Z8bThE978VSvdtFpUOOiR7cgfAHsBk4d0FG1Z+z0d4KIQJ0P8RIOh+Ft
	 gr6bUWUmOAguuaBPBuVqyEM1X6VabMgUp+6YI6Cm37+1FeaX4FhfSPWbXvKr6B7Dq7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DgKtYllK;
	arc=none smtp.remote-ip=68.232.139.130
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B278606A33D;
	Tue, 10 Nov 2026 12:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B278606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DgKtYllK
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1794312717; x=1825848717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Eio9nYqq1HUIYESAuWhCyeK9Re+Weog6uesd4h1oSo=;
  b=DgKtYllKTeTwRZ213gzZEjfL7eD+fqSfJAhsmkaqP1AGBn+eY26t9L4C
   +p/vbR84Zq2DQurFs7azQBD0BP0NvKOXWKv3cRwu4GmUrC6brnlSrwojW
   m5BNujLqDiPx4gLEeSHHPXLv/fybBFjgcnZEAeY1hn3i1Hb9GIjusieKp
   dWotSKLGlPstqR4mtCZvcUXwdcuQqkKLNiI9ezPuFvAJH+PIrSkRINKl3
   g/KrEt5C7O5J55mde5yKfR6VqlzS/9w1agRw8RobzVb8KENS2v837BA1j
   6TV5OI2R6HVscAjSj6tJI0mWaxF3cfWxiB7u5kPVq/jmU8+flf9tKGgI5
   Q==;
X-CSE-ConnectionGUID: VzIQzazDQDWy8ViB7/XKKg==
X-CSE-MsgGUID: 5qkYb5xfTi+7nhE6TDQUnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="259489026"
X-IronPort-AV: E=Sophos;i="6.27,205,1786978800"; 
   d="scan'208";a="259489026"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 21:11:49 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id D4C581C01688;
	Tue, 10 Nov 2026 12:11:49 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 87A0314003DA;
	Tue, 10 Nov 2026 12:11:49 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.34])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with SMTP id E5AFE1800A47;
	Tue, 10 Nov 2026 12:11:40 +0000 (UTC)
Date: Tue, 10 Nov 2026 21:11:39 +0900
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
Subject: Re: [PATCH 00/11] KVM: arm64: CCA: Prepare Realm memory management
Message-ID: <avMI__K5XBf3z7wv@FCCLS0092175.localdomain>
References: <20261102141304.126883-1-steven.price@arm.com>
 <avLgdqlfUPMAI-r9@FCCLS0092175.localdomain>
 <e9bc3885-4e29-44a0-a186-463337f57d9e@arm.com>
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
In-Reply-To: <e9bc3885-4e29-44a0-a186-463337f57d9e@arm.com>

On 11/10 11:54, Suzuki K Poulose wrote:
> Hi Kohei
> 
> On 10/11/2026 09:24, Kohei Enju wrote:
> > On 11/02 14:12, Steven Price wrote:
> > > This series adds the memory plumbing for CCA building on the basic
> > > plumbing[1] that has just been merged.
> > > 
> > > These patches add the internal realm VM state and RMM feature checks,
> > > prepare realm stage-2 setup and teardown, and provide RTT mapping and
> > > invalidation helpers. Realm memslots are now contrained to the lower
> > > half of the IPA space, because faults treat the protected and shared
> > > halves as aliasing. The final patch then connects these helpers to the
> > > KVM stage-2 MMU operations.
> > > 
> > > There's also an integration branch[2] that builds on this series and
> > > includes the realm descriptor creation, REC entry/exit, activation and
> > > the new uAPI. This series by itself is also available as a git
> > > branch[3]. However the new code isn't generally active without the full
> > > integration branch.
> > > 
> > > [1] https://lore.kernel.org/all/20261007073537.2454351-1-suzuki.poulose@arm.com/
> > > [2] https://gitlab.arm.com/linux-arm/linux-cca
> > >      branch: cca-host-mm/v1/integration
> > 
> > Hi Steve, thanks for your work on CCA upstreaming.
> > 
> > For testing purposes, could you clarify which TF-RMM revision (or commit
> > hash) you tested with? Although this MM series itself doesn't seem to be
> > particularly sensitive to changes in TF-RMM, testing the integration
> > branch could be affected by subtle changes in the RMM.
> 
> Tip of both the repositories should work (tf-a and tf-rmm).

Hi Suzuki,

Thanks for the clarification.

Then, unless otherwise specified in the cover letter or elsewhere, I'll
assume that the latest revisions of both repositories are expected to
work together going forward.

Thanks,
Kohei
