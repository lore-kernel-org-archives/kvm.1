Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AA2868AB
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316828; cv=none; b=CQros4yDAlQkAc2HMjiid/gPRrF/VUUyiT/xlwMxOIxr0LXXxdYcg0T98Y8KagJade81C8amnSWA4vWo1BZwCBxoDdkzc+gWfPAF6O9sz9UsX9pSy6cFZ9+ik99UnNGNQOy0Jv4kPcyrKakOXJxlrgWxzlUaJvyEmjw73i55cZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316828; c=relaxed/simple;
	bh=5IN0z1ZZrUobt1+FBF8TYpgY034UGdiu0Zc3yJMpNMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfCHXiTthOJNjYI/urK93oq2hga9G61Fz2If9AFGXSjZiurG/RIKt0LH4vH+zyUgHL/d3JsPPas31fgrhKbxEltaW1aNcpPWEqYcxnQgpg5xmxce6SV9m29vVv8x/gOd15iBkzM7z7ziA/2QtKUz+QVdSgqpB8KC8t27OpiwHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQUrVujl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQUrVujl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788316827; x=1819852827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5IN0z1ZZrUobt1+FBF8TYpgY034UGdiu0Zc3yJMpNMY=;
  b=lQUrVujllHt2xTJ48v1JFeuCyTPDvwN3juMtkSncmzrT7TDn9BFXnq28
   ESf2+Wr9fy8nOmL6yZMEUpbolOXOr0fDZfnFmtAQHMsUZ7dHxoedcKtFJ
   TaahzSmV9AsQ+B1kLj/TkRPI7MTfyP4ClId0BXmaukxyevzUkCKLm0iWk
   TuPSH/sjzsLwcpZjkKbBIixbVNhjyaN5rmBYIOST0qskLlLtFFFJVFZBd
   cPcCyaPd997+E+W69sar+kY0lyOi2hTiniSti4H1lrdB2GIODaH8woNtp
   3LeD7H42EqwdZ3s0JTcc9f8CwSYnQOrmU9CVTuu7c/WuBF64PvVtMlYOY
   g==;
X-CSE-ConnectionGUID: 8Bd5nhz1SMuu/F2tO3DGwg==
X-CSE-MsgGUID: OwfchJ5cQYWrWY7cNVreVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100116824"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="100116824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:40:26 -0700
X-CSE-ConnectionGUID: oHUYpSz2S4KS3trJWD3L8w==
X-CSE-MsgGUID: FDlN/uNLTVOMzU1QaP7wQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="264982787"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:40:23 -0700
Message-ID: <12100e0f-0730-4f12-81db-5e9dd18fef79@linux.intel.com>
Date: Wed, 2 Sep 2026 10:40:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: Add support for LASS
To: Kishen Maloor <kishen.maloor@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, farrah.chen@intel.com
References: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/2026 11:57 AM, Kishen Maloor wrote:
> This series adds QEMU support for Linear Address Space Separation (LASS) [1],
> an Intel security feature that prevents a class of side-channel attacks
> relying on speculative accesses across the user/kernel boundary. Paging,
> along with SMEP and SMAP, already provides mode-based access protection,
> but enforcing it requires a page walk whose timing can leak the layout of
> kernel memory. LASS applies the equivalent protections during
> linear-address pre-processing: given the usual partitioning of the linear
> address space into a user half (bit 63 clear) and a supervisor half
> (bit 63 set), an access targeting the opposite half is rejected on the
> basis of bit 63 alone, before any page walk.
> 
> This series enumerates the LASS CPUID bit, recognizes CR4.LASS,
> and exposes LASS on the relevant Intel CPU models via new versioned models.
> LASS is not emulated by TCG.
> 
> Exposing LASS to a guest also requires KVM support: KVM must validate
> the CPUID bit and CR4.LASS, and enforce LASS violations in its
> instruction emulator. That enabling is currently under review [2].
> 
> Tested with a Linux guest on LASS-capable hardware: LASS is enumerated and
> CR4.LASS is set under KVM, and not enumerated under TCG.
> 
> [1] Intel 64 and IA-32 Architectures Software Developer's Manual, Volume 3A,
>     Section 4.3, "Linear-Address-Space Separation (LASS)".
> [2] https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/
> 
> Isaku Yamahata (2):
>   target/i386: Add support for LASS in CPUID enumeration
>   target/i386: Add LASS support in CR4
> 
> Kishen Maloor (3):
>   target/i386: Introduce DiamondRapids-v3 to enable LASS
>   target/i386: Introduce SierraForest-v7 to enable LASS
>   target/i386: Introduce ClearwaterForest-v5 to enable LASS

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> 
>  target/i386/cpu.c    | 26 +++++++++++++++++++++++++-
>  target/i386/cpu.h    |  7 ++++++-
>  target/i386/helper.c |  4 ++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 

