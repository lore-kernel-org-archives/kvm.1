Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D63D8132;
	Thu,  2 Jul 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982564; cv=none; b=M7P1FhQxU5oIvXljMWQeSHHXvNxoR0B7ojzTiNIyT0le3IN9o+Gj4JShlgb+g6WUsI91+9adR83GbMKNseB9/65ZzgeL5XBGUdzV2Ch8Owg7wxewBNeUfW3cME0mpXIknr9pRlR0lkCEHmlV9Wgrze6hnz/EJ+130WGx7F0SY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982564; c=relaxed/simple;
	bh=9Ma5KFtkMeDbcnixBHck1T0uu5/NZ47Dlk4RsPkos1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Durx+QvZvd+kNT5rUUekGKxRWZP7WtG04siBNvFfiYgOul54/gMkA6XYnk7VFC0yC/uJ5P6mF7wc4Wg7ojX31/mLiafAovwSguq0d0LV1yyfmeiShdinun9dY576n57uiCAtJWsQ8a3giVODaNoLThm/zcuOIRMEUO8vMXZSQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bxl1Vgya; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxl1Vgya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782982564; x=1814518564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Ma5KFtkMeDbcnixBHck1T0uu5/NZ47Dlk4RsPkos1Y=;
  b=Bxl1Vgyad2NHsB74tiZyrNKxyTJHfv15RS9FMWOCrsHus7VDpjO2ljdY
   yJaZ364/VbOVetSvMNMZzHXf29LXQfJH1gnYyUYqRKNsRRj6du0zzr08Q
   XwfSQY6FbObsTWBUykAkapu+e4uWxJm1KOgmUnhTvJOiSLfvWoR5FJjCa
   s3D6BYWCW4na7bhI3H1Fh+wYyUk1A0etxmZBf73D3Oz9QWbhghqA2djL8
   9EA5+HQoPBz9f6h7FV5yyO1yuvaM9wT93Vezz12E8LALRKQPT2HeZxTuH
   fZ/7mIu/CMKvY+1LmcYcAkK/jd7iw3g90scLzvbsDzq3D2G0C9WJGl2aA
   g==;
X-CSE-ConnectionGUID: eqD1sYGgTGedQrE+2WQTZA==
X-CSE-MsgGUID: 1cdXLP5wQjGV6trTafzHvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83509416"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83509416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 01:56:03 -0700
X-CSE-ConnectionGUID: yBaMW+b0RhKWOyLQ+0D8tQ==
X-CSE-MsgGUID: tcei5PLLQ8SlEsiPcuCO/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="277130102"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 01:55:58 -0700
Message-ID: <a6844562-e973-436f-970b-fa0b68ced1a0@linux.intel.com>
Date: Thu, 2 Jul 2026 16:55:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com,
 pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260526023515.288829-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 10:35 AM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Use control page helpers for allocating and freeing TD control structures,
> such these operations can work for Dynamic PAMT.
      ^
Nit:
It appears to be missing the word "that". 


> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So the kernel must install PAMT backing for each 4KB
> page before gifting it to the TDX module, and tear it down after the page
> is reclaimed.
> 
> TD-scoped control pages (TDR, TDCS) and vCPU-scoped control pages (TDVPR,
> TDCX) are all handed to the TDX module at 4KB page size and are therefore
> subject to this requirement. Replace the raw alloc_page()/__free_page()
> calls for these pages with tdx_alloc/free_control_page().
> 
> Switching between special Dynamic PAMT operations or normal page
> alloc/free operations is handled internally in
> tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
> calls. Just call them unconditionally. Similarly, drop the NULL checks
> before freeing, as tdx_free_control_page() handles NULL internally.
> 
> No functional change intended when Dynamic PAMT is not in use.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [sean: handle alloc+free+reclaim in one patch]
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Rick: enhance log]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

