Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395796;
	b=aMFcn2TNSZY2f1dbcATb2d8YCeD6Ub1PkMfdmdLCzKw6I115khPhNKN1CV3dkdSdPiTa
	 UbE+v0x8yP22fzYgngQy9SYpQyahkpRKIYvulAzY15V2F5UxUh5tYIrfMgb+oubu6BdIY
	 49DS0mO8ks0UAqJ/12s8nnnusrYU+kVwUtG5VPPr2K/Sr/299D5VY5TQMB6LGvjaa5D7M
	 lNPFrfKeGTlraMgUq07bJEi7tZkcp0hSa3SHD4VPZKYOWTcTwZ3SVSc4/l+MdAJaZ+jH5
	 btQ8sB7QpoquLZZTi8pX7oc5vrVIDgwMAaAlhLjEIqrgjvR8JUyJ2rpjnz29c/Rtdaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395796;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wXwVlOMUg0Gf5TYfdk4Le3TcS6+D30wddziXN4/+dTY=;
	b=YP+Kr2szM2EiPGwL77FajniIQk4P/y+QH1ec9l8QOn208DAjbUxhJTvyrCpkCEMNY0fM
	 VijoBuKMYSNfhrOR4EmcgZMedIv7CaUDSgpk9tuFeRVpsa6O6KnijlqeEMg+XQAAyXHnG
	 HBTmGLxipIpHrpGOlUiPDX69fdR2N8mj7+64VfjDO+WFQyw+mf1EV00pL5oIthpf3qxeK
	 5E43ZEeNkgjFSfnmLe89tgbbu0rr001DrLLmIxPXoN/yqECn7Osm0skbBA+hP5UfmnbVk
	 IrvtJCuUM2UyLDUV9L0y+bLpHLLUSP80g2jC8c8F9s9sFtizv8qMQIeJ06cNz3j2bsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FLgtTtN9;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C6606A31A;
	Mon, 23 Nov 2026 01:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FLgtTtN9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795395797; x=1826931797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9n8NgUBZkrhrbWY+88ZHr9pyt0E9dLpjgtsFacqXGI8=;
  b=FLgtTtN9MPKdlfiMxDIsn3eN3v+gu+phg0tAlLVLtCyUiclgbg/MvfUA
   IhKKHjh+lD8vSPthly+HekINnxmWI8Z0Fzhruuc+kyO5DGObvbfplHziM
   71uL1D+q5c20lMFDe/CzRtqGNKu/mglgTvAP/T43uuTZtyb6FAHdgDVvi
   Tpgdr57uOUvYQ7V4d2DgE+zINXI3941fOMetJW/G9xXXGBmfwN767o2Fc
   2FIH+tRlf5ywiu4MOBPZ7jh7VGrip2YkErYWSAZFN6xlj3aBT2DbFY48p
   KKoeRjRLGrmBFQmxm71FRvdDv6KoQUD1f+N2M1r/N9+1OhaVaDYvETN/B
   Q==;
X-CSE-ConnectionGUID: rQyyHjsgRK6VT8Kh5Yr7qw==
X-CSE-MsgGUID: yCZxLA0gRU+i6vuChvxchQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4103828"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4103828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 17:03:17 -0800
X-CSE-ConnectionGUID: 9b+YkXoaQAOwW/OkLGJnng==
X-CSE-MsgGUID: amt3vq6PTYSh+VednyeP8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11466940"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 17:03:15 -0800
Message-ID: <58aa1669-68b9-4123-9852-6c7158074cc8@linux.intel.com>
Date: Mon, 23 Nov 2026 09:03:12 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Alexandru Elisei <alexandru.elisei@arm.com>
References: <20261117011513.39419-1-seanjc@google.com>
 <20261117011513.39419-3-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261117011513.39419-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2026 9:15 AM, Sean Christopherson wrote:
> From: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> Don't invalidate gmem-only memslots when responding to MMU notifier
> invalidations, as the entire point of gmem-only memslots is so that KVM
> doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> page faults are resolved by going straight to guest_memfd, using the gfn
> and the associated memslot's gmem.file.  I.e. whether or not userspace
> happens to have valid mappings to the same gmem instance is irrelevant,
> as are any invalidations for those mappings.
> 
> Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> detect and handle relevant MMU notifier invalidations even if there is *no*
> memslot whatsoever.
> 
> In addition to the obvious performance benefits, avoiding unnecessary and
> spurious SPTE zaps and TLB flushes will allow KVM to support features like
> ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> both of which rely on the pages *never* being unmapped from the stage-2
> page tables.
> 
> Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [sean: rewrite changelog to capture the new gpc behavior]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  virt/kvm/kvm_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9938b753948c..f0d95e8c37f4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  			unsigned long hva_start, hva_end;
>  
>  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;
> +
>  			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
>  			hva_end = min_t(unsigned long, range->end,
>  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));

