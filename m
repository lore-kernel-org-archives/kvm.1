Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395763;
	b=qlOfj+mafiym7Ru1QyMVk4LcxVEvzFWaIpupneFvK0lobdwISwlzmEkk8vT5EOcbbJLC
	 473ipm5E3IcXK6f7cjrMPNwg0wYCnxxE/5p9u4XjJojmsR67hX/KItQT3cMFtDAbY0Phk
	 ueD0/XmXs22czvCzCKNxWpMv4mQ60hIAHikXnxtYokblHh6SlN3FTglWsIVpqx7DvbTGf
	 EnXi1cZk7c3n/v6hnF2Hasrv9OKCjyCMHJrWSksqgkoMcwwhzSRQkdyuGYfZ9Oams7He2
	 xIHDqZRhahE6RRfuiXtS1R3XKI0wFwKUOa/ePWydSWJmWTu9xGVo0BTUsnFTYCQljgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395763;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/TtaVSFKvzC2yENzQ36/KvlJVDiN10OL+L/u8Jlvl9k=;
	b=zlHsJ+ay5cgjl3SfcQ3ybbEgOKlwXL9P+pLLyM+uNdEAmHq3TyhnPVbeTr5QgKaJTkV3
	 HDhQfLdqQ+vQ12OUAgBFPDwASa5Vc8cT2LLDhVwqxzq771e9ScUyujmECXM52TxtiDqXQ
	 zuu36t3T//VOkUgceclmZIIbcvzWDBPnn7G3mJC+Q82a678NjTC54kETB7PvVYuu3yFRT
	 ytDozTPOvxp0LKoyqQM0fghu5bEzImN/WWuiXPfxiu2wBhZGmBQGM4fi+1+ADDEzeZu62
	 NhSXioJUTZpW/rrz+b6kX/Eqz5bVaGFMCLKcgOQSUPfYiv/xNDUnRUjab18gv1WYrqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D2zxLyq1;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEE606A31A;
	Mon, 23 Nov 2026 01:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAEEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D2zxLyq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795395763; x=1826931763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yzUdFlARRD9nuCVT+/V+p2PL+/Zg/cexYbCr0fYyoEQ=;
  b=D2zxLyq16Mn/BWuazL2/LRdScky2oZlM4JEVgNc+Fa6sop3Gnwdj2w77
   5MbpIkYD01+bsmidKmB5P8m+jfgDsel2zEkyB91ekeHx0vRMEeVQCN55t
   2Kqhz31NTWyMUKOlhaTVRWeAMSLokEP6tjcBikO5WRFEscNA+s21H8CEE
   ZAkYJNGVKCqFdtPjdV8Bb/fQ9GlL8MV64eRQfO3ddeeMV5s7nVQdTlXwj
   Fk36xLzcfvBEr1iHwDwIRn+pPVTVmC97l0priSDZxcjvIkB6EcjFikp7s
   lbngyUFgIkQcdbFmYpeQZiJ0VXotMl/6qF+E/uTDMzZlR8soWi6wcvX4y
   g==;
X-CSE-ConnectionGUID: CQ1iKdUuTyuVu7CCGSod/Q==
X-CSE-MsgGUID: zzcaUQL7T4qZgShj0seIfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4103813"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4103813"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 17:02:43 -0800
X-CSE-ConnectionGUID: bgeXPCpaQruRABoF7vH5cA==
X-CSE-MsgGUID: u458ZpNSTBWp7NUmdEk09A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11466865"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 17:02:40 -0800
Message-ID: <3581bb9d-4183-4baf-83e7-2fe3e97acbd4@linux.intel.com>
Date: Mon, 23 Nov 2026 09:02:37 +0800
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
Subject: Re: [PATCH v4 1/2] KVM: Disallow prefetching PFNs (for SPTEs) via
 VMAs for gmem-only memslots
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Alexandru Elisei <alexandru.elisei@arm.com>
References: <20261117011513.39419-1-seanjc@google.com>
 <20261117011513.39419-2-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261117011513.39419-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2026 9:15 AM, Sean Christopherson wrote:
> Disallow prefetching SPTEs via fast GUP, i.e. by VMA lookup, for gmem-only
> memslots as the whole point of gmem-only memslots is that KVM MMUs should
> get PFNs *only* via the direct guest_memfd interface.  More importantly,
> this will allow skipping/ignoring/eliding mmu_notifier invalidations for
> gmem-only memslots, since it will be impossible for KVM MMUs to have any
> mappings based on the to-be-invalidated VMA (as is intended).
> 
> Fixes: 576d035e2aef ("KVM: guest_memfd: Track guest_memfd mmap support in memslot")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/all/avdAIMDfgL_wy1rx@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  virt/kvm/kvm_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..9938b753948c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
>  	unsigned long addr;
>  	gfn_t entry = 0;
>  
> +	if (kvm_memslot_is_gmem_only(slot))
> +		return -EINVAL;
> +
>  	addr = gfn_to_hva_many(slot, gfn, &entry);
>  	if (kvm_is_error_hva(addr))
>  		return -1;

