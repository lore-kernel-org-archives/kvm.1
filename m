Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EE23D7DF;
	Tue,  8 Sep 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833933; cv=none; b=VyPl9kCOs0yPmzQUeYMVkvYqF8t0UZl4Cn1qCJq3A3+4I58R9+m2fs33g/CAtUlHsyzpxtv4LP3j1QdGjeCJYatxgXy2feDKX6QZH8ImGll7xYhlT1lddKfrXEUK4s3koXx0VYHYH4xff8aFh/N3TdXJyiGXbF18eCL37NM1LrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833933; c=relaxed/simple;
	bh=H8yu5UWHpf8HMlqYH0d0maZ7HvkrMCdZ8vGMrmgBC44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOXgf4249YA2e4Fl9m2lcjvn/BgdC5K9uxpUTllV1dH1XzO/9mXzeqCYdMErBzB40Gg6hjDl/z/rQKhQ2q5dpbq//qPkx1Nb+8aMHBOJZrqRqndGxUXro3qSFVhZ4hRU2AHtbnj90+yF6mBLT3kSWGuq9FmmtEsg9rIC5Igj5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SF2TKboQ; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SF2TKboQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1788833932; x=1820369932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8yu5UWHpf8HMlqYH0d0maZ7HvkrMCdZ8vGMrmgBC44=;
  b=SF2TKboQAKPwLc28grnT89vOP0cgRq7IsOMFSzxI2YdfzoqN57pizp3z
   h/yJ9awYhGaicUnbgXTsmnq3uYo9pMouzo8zhu4Avd53BIoK7hLqZ62wW
   a2hsTlOrO1AO0QT7I9iS3NL1ruC04Wse6C+r24q0KwE3NoLNeaXx5WLZQ
   6qgXxehuMWfy+8NwMkxtUPbAWKtA+XwxNvgJwLuPgoFTkqcggUYU3eESx
   vKI7WzcQxB/Ww3LSxCS8cPG9MEL/Nstl1xUYm3TorrO+lh63lWBrFtiRf
   dHMrBqRd5Xv46/gUN7yH9vRhxUbKSY5lup2utuvI7hWhRMLTEeJ1smaGB
   g==;
X-CSE-ConnectionGUID: uxUWLKkwS26YXcfhwKFZZg==
X-CSE-MsgGUID: AE5NkpcmRT+vPktKgbea6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="254260801"
X-IronPort-AV: E=Sophos;i="6.25,268,1779116400"; 
   d="scan'208";a="254260801"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:18:50 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 9B5A01C1C704;
	Tue,  8 Sep 2026 02:18:49 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (unknown [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 52831C00800;
	Tue,  8 Sep 2026 02:18:49 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTPS id BBF27823095;
	Tue,  8 Sep 2026 02:18:43 +0000 (UTC)
Date: Tue, 8 Sep 2026 11:18:40 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takayuki Okamoto <tokamoto@fujitsu.com>
Subject: Re: [PATCH 0/2] 52-bit VA guest mode ID support
Message-ID: <ap9wgBjYEDI-27N1@sm-arm-grace07>
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
 <CA+EHjTwPmwPTMcgQB6zt47Kz6NPMr+FkGfq2Qq+Uxu+G427OEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwPmwPTMcgQB6zt47Kz6NPMr+FkGfq2Qq+Uxu+G427OEg@mail.gmail.com>

Hi Fuad,
On Fri, Sep 04, 2026 at 09:14:36AM +0100, Fuad Tabba wrote:
> On Tue, 25 Aug 2026 at 22:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
> >
> > This patch series extends the arm64 KVM selftest framework
> > to support 52-bit guest virtual address (VA) modes in addition to
> > the existing 52-bit physical address (PA) configurations.
> > The motivation is to enable validation of LPA2 guest memory-management
> > behaviour in configurations that use a 52-bit VA space.
> > While the selftest framework already supports testing 52-bit PA
> > configurations, it lacks the ability to exercise guests running with
> > 52-bit virtual addresses, leaving part of the LPA2 functionality untested.
> 
> The series adds three 52-bit VA guest modes, but nothing in tree maps
> a guest VA high enough to use them. The mode-iterating tests map at a
> fixed low GVA, so pgd_index() returns 0 and only the first entry of
> the top level is ever used.
> 
> What do you expect the modes to catch as they stand? The allocators
> already take a minimum GVA, so mapping high in one of those tests
> looks like a small change.

I think at least a 4KB page is allocated for the level -1 translation table, 
and entry 0 is populated with a Table descriptor pointing to the level 0 translation
table. But, no it does not test a nonzero top-level index.

> 
> > To address this, the series introduces new guest modes for 52-bit VA
> > operation, adds five-level page table support where required, and
> > performs runtime detection of host 52-bit VA capability so that
> > LPA2-enabled guest VA tests are executed only on supported systems.
> >
> > Testing:
> >
> > Built and tested on arm64.
> > Verified on QEMU with a V52-capable guest configuration.
> > Confirmed correct operation of high virtual address mappings by
> > exercising guest memory accesses in the 52-bit VA range.
> 
> I could not reproduce "exercising guest memory accesses in the 52-bit
> VA range" with anything in tree either. Could you say which test you
> ran, which guest modes, and on what?

I just in guest_code() of existing one of the kselftests, mapped and 
accessed a page at 1ULL << 49 using virt_pg_map() and on QEMU TCG mode
as I don't currently have access to the machines LPA and LPA2 features.

Thanks,
Itaru.
> 
> Thanks,
> /fuad
> 
> > Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> > Reviewed-by: Takayuki Okamoto <tokamoto@fujitsu.com>
> > ---
> > Itaru Kitayama (2):
> >       KVM: selftest: arm64: Support 5-level paging in stage 1 translation table
> >       KVM: selftests: arm64: Add 52-bit VA guest modes
> >
> >  .../selftests/kvm/include/arm64/processor.h        |  2 +
> >  tools/testing/selftests/kvm/include/kvm_util.h     |  3 +
> >  tools/testing/selftests/kvm/lib/arm64/processor.c  | 87 ++++++++++++++++++++--
> >  tools/testing/selftests/kvm/lib/guest_modes.c      |  5 ++
> >  tools/testing/selftests/kvm/lib/kvm_util.c         | 11 +++
> >  5 files changed, 103 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> > change-id: 20260825-arm64-52bit-va-32f1f4cd050d
> >
> > Best regards,
> > --
> > Itaru Kitayama <itaru.kitayama@fujitsu.com>
> >
