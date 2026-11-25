Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600598;
	b=hZpDNJTytVxAwi6WLd46XscuMP2o1GmGr+r2VPMU/s27/tZgCpAENp4bJ/KzVJmg48hx
	 pA6tjHmkIZOn+9ejkuDmJLYWi+TpDptjvPr7V1WFbqrz57D/2XXv3W63+bbaPUt5crHTD
	 PHrzywKg19lOnLv0PkSaXymJNc/G/kM3V8Svq2xkwE2wOIZo7FNEpz6GXtw3UlGRQvOfW
	 1wmiLuMB0tRBp6GfW3lgCm9u7fJggq39cG7Ex6Dpx1+RhRE2oRx9v3cshHDo4rdxZ2olt
	 6hCuj50iLxyEMrDbRvlaRCwZqJKA/6nc7OVeJ2abqBOVvqRAkGzT0ty0AUF9UrK8nVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=030mMfUA3CgdGvOfPr2ROX9zWpZyZC3p0L8bknHDb9Y=;
	b=KvaokiwzKEpTtylKVZHojiEXR/9yHEknvclUlPB8rYNtSUThoD9DdYbPMMNhc/axgD5v
	 TgDLPLTDV+LocOxTvUSUjN+XYs5kRtv3UmU9YpY4gw9cP23UMbgqNpSuxGSnZB5lpNB71
	 XPlE5976DgGPau86eMZU++J9t6sYyW7qCYHGcki77aOK+/MDSscTBykiO36PX2qaE9bI1
	 gEChvNKYVZiT8wMWTDMtR0ubOOC/Oe0QMYWJU+3qFR5GN3dcZzLOyzm5QfvUk51cYIOSN
	 oXRSSwoiXty5kNP7FQgfH2ylzLEgsJwWZkQR3Kv34B+cbh+AmZ5XBQ1oorgfKZIRN/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G4vLiDGG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B3606A321;
	Wed, 25 Nov 2026 09:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G4vLiDGG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07BD1339;
	Wed, 25 Nov 2026 01:56:34 -0800 (PST)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A013F86F;
	Wed, 25 Nov 2026 01:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795600596; bh=FcV8Pf60rmiTE/HQHTp46CgyrXFeo+tXVbv4KqGJRPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4vLiDGGblmvMsSfpGOhYy1HayDIRGyISeVLSN9pYp6SUb4+4QfYEPa1g/C0KVRNY
	 Yo2m5pVba4FdLbUYT7Qbww9Alz+rEPjJK6ME4Di5gr8ShGwSK+2P+gWb7n+NIToNkm
	 jjR+uiEoAU54KbMVBC8W9YYYX3FWmEPjdK0E4pTw=
Date: Wed, 25 Nov 2026 09:56:18 +0000
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Colton Lewis <coltonlewis@google.com>, Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Steffen Eiden <seiden@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Dan Carpenter <dan@pereq.eu>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Discard undersized TTL hints in
 compute_tlb_inval_range()
Message-ID: <n4ii5ih6szqxjklqxbqzun3bjd4saku3aqqvhq4wf4kq3dipoo@3r2j3exwocw5>
References: <20261123232647.3733149-1-coltonlewis@google.com>
 <20261123232647.3733149-2-coltonlewis@google.com>
 <867bi2z87n.wl-maz@kernel.org>
 <20261124202215.3731849-1-coltonlewis@google.com>
 <87a4my7yhg.wl-maz@kernel.org>
 <20261124221616.4155034-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124221616.4155034-1-coltonlewis@google.com>

On Tue, Nov 24, 2026 at 10:16:16PM +0000, Colton Lewis wrote:
> On Tue, 24 Nov 2026 20:42:19 +0000, Marc Zyngier <maz@kernel.org> wrote:
> > On Tue, 24 Nov 2026 20:22:15 +0000,
> > Colton Lewis <coltonlewis@google.com> wrote:
> > > [1] only catches TTL hints smaller than host PAGE_SIZE. It does not
> > > catch a hint that is >= PAGE_SIZE but smaller than the mapped block,
> > > such as a 4kB L3 hint on a 2MB block on a 4kB host.
> >
> > Why do you think this makes *any* difference? The hint passed by the
> > guest is utter bollocks, and the best thing would be to not invalidate
> > anything. It's just too invasive to do elegantly.
> 
> Architecturally [1] is fine for the TLB, and before guest_s2_mappings
> landed in v7.4-rc1 clearing the block was harmless. The problem with [1]
> is a host memory leak in kvm_pgtable_stage2_unmap_tracked():
> 
> 1. L2 faults in a 2MB block. kvm_s2_fault_map() installs a 2MB block PTE
>    and kvm_record_guest_s2_mapping() inserts a 2MB
>    struct kvm_guest_s2_mapping into both interval trees.
> 2. L1 runs TLBI IPAS2E1IS with a 4kB L3 TTL hint (4kB == PAGE_SIZE, so
>    [1] returns 4kB).
> 3. kvm_pgtable_stage2_unmap(..., SZ_4K) clears the entire 2MB block PTE.
> 4. kvm_remove_guest_s2_mappings(..., SZ_4K) skips removing the 2MB entry
>    because a 4kB range does not enclose it.
> 5. L2 touches the address again, faults because the PTE was cleared, and
>    allocates another 2MB tracking entry.
> 
> Looping steps 2-5 lets an L1 guest leak one struct kvm_guest_s2_mapping
> per iteration until a larger unmap or VM teardown (I measured 832kB of
> slab_unreclaimable growth over 8192 iterations) and turns later TLBIs on
> that range into linear walks under write_lock(&kvm->mmu_lock). Patch 2
> avoids exact duplicates for the same (nested, canonical) pair, but
> remapping the nested IPA to different canonical IPAs still leaves each
> stale entry behind.
> 
> If you prefer not to touch compute_tlb_inval_range() beyond [1], another
> option is keeping [1] as-is and dropping the cleared tracking entry in
> kvm_remove_guest_s2_mappings() when a partial overlap leaves no valid
> mapping beneath it (zero cost on valid hints).

For the other option, how can we recognize when a tracking entry can be
safely removed?
i.e. No more shadow mapping in the tracked nipa range.

We don't even know for certain what shadow mappings exist in the first
place.

Thanks,
Wei-Lin Chang
