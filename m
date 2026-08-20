Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E363AEB27;
	Thu, 20 Aug 2026 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205711; cv=none; b=LKMry5uRYs1RzT5vxjVYzAZT1NOQmHn7i7+haSIcW7WsDCQptGEBcKMqd9amQSk2YJPd4bFotBUXmx2dEsOCDgE5HaFLZV8VpUZQExqTdlOUpIKzBZAiyW7utRHc5dDT/boy1XBJ9agOkQpfBCGqP0kNWgGGwYXUveORrix9v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205711; c=relaxed/simple;
	bh=hlVKKwJa/qsIl0IqakzkZdRDu9fR1X2KEBA/MJTffiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9y2OmpdcUOfFLt/GBei+xK1Bu1iz2lQ7muZ3eFycLp7BMH/VVJhdlEUIet5OSHp4IgjMbDX0wp0y99SdXUqRIlkOYSVNnvTEwBWFNQP90JNTtYb9ci0Wzjz3iFDwwLh+lzpRURTH/wk4/BwtX9bIY7NyFsirAnKYdAvxdFiDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ksm37Lgx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ksm37Lgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787205710; x=1818741710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlVKKwJa/qsIl0IqakzkZdRDu9fR1X2KEBA/MJTffiE=;
  b=Ksm37LgxzLF0L4xQjPNHOvSiwuvlpMEeVh5UTEP0+azfrGSqAXJSWkqL
   oAQRtoEuDIh7KIgWoBui2ySMnsMprZBpDNrXdEOoginZPyhPLxrI8WH4H
   ph1NBjT4u5CBZpJc4azaIlfvokDZB1rACehso7/y2+74Kc5awraglELkC
   TYJA4KLwU3tujMPHosm2p9GRvNH74ZxfjVWkuNe44zjwGW/Za74mpB5sx
   c+Mk1hASxm0K/KU7UcYlbQzQtNfzVyl9Z35dPc4UeqiWPCvqoqQa4Nsv4
   otAZz7YtgKVtt6fT50RStIIV/jHrQsnMbw4RRnvf0WzOpBVYaKNVDEeCp
   g==;
X-CSE-ConnectionGUID: tOgxSUCESQaptZA39iNS8w==
X-CSE-MsgGUID: 3P2oHi76TlurAx8iF6i0eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105113435"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="105113435"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 23:01:49 -0700
X-CSE-ConnectionGUID: d5rlhjhDROSm58pc3bSzow==
X-CSE-MsgGUID: 6thpdJTlQCCdMxk2EnlhZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="259689734"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 23:01:43 -0700
Message-ID: <73ad830f-271d-423f-bd91-628f1011b7b2@linux.intel.com>
Date: Thu, 20 Aug 2026 14:01:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] KVM: selftests: Add coverage for LASS CPUID and
 CR4 handling
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang <kai.huang@intel.com>,
 Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>,
 Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Matlack <dmatlack@google.com>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
 Kishen Maloor <kishen.maloor@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-7-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-7-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> Add a LASS selftest for KVM's handling of CPUID advertisement and
> CR4.LASS. Verify that a guest write to CR4.LASS generates #GP, and
> leaves CR4 unchanged, when LASS isn't enumerated in the guest's CPUID.
> 
> Extend set_sregs_test to cover CR4.LASS and verify that KVM_SET_SREGS
> accepts CR4.LASS when LASS is supported, and rejects it, without
> modifying sregs, when it isn't.
> 
> Don't try running with CR4.LASS enabled in the guest or attempt to
> trigger LASS violations. Selftests run guest code in the lower half of
> the address space at CPL0, so enabling CR4.LASS would make the next
> instruction fetch a violation and triple-fault the guest.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
