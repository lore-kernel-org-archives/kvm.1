Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382150;
	b=ot1OK4MW37DJ6m4Z5YZn/fSqlsu3+EcWkXfvEC3Kg002Fgux/BX+NJOwCMG3upki4nTM
	 5hZiWNe55wf+CE9Sq/itc6McWrxNseQNdqIjJtSKhRN/NFP5GMs1fGssS8v4A51q62GYF
	 4pzMSz+Y4Gag0dab4OdmLocjcVo84a4LXkK7g5ZQiKYqZKV8ym30y/pKwO/G/LlGozuKX
	 KDYFZUrI7oErC8jjM/rcckbM5JRog/NbdDFevwpDD7slpUtXgCdIwlP1nZ76Z9juukRGB
	 ZtfCgS6J76bg0fNH72tp/ShTMMfsWTZv2xwOxhr2xIPHHFFkKu8TikKZGdtJ3tb6Osg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382150;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OCeJ6lwv/tnktg1Bj7s+2yY7E0fZdstArZZAdKcTKps=;
	b=3ZUvRWlzimK2yf36a9muNUsNjarIZYslmM/hDRCLsn5Xr5q+Pl/Sw0momY2KZiBHoHfG
	 4tLNmScRawO7TPgt7HXEAOR6g6XQI31nOeM8xR9lp8quMCBeIHbR4vFTEjmaQLsXJUEjV
	 lOUdah3OMEmJuOyvf2ABRJm/LrzwaFBz9E7JvblHzLlsUwy9ByixxWd4t354WGu3zs2E/
	 818DYP0vGJdMF+PjCxoMJSl8mXjGl46pJEQuLdJEAcc4nvFDsfpQ6vnCRItGzLI9Fqul5
	 r54JUwRyIjGzGuWlTHUQchZ/ZSme3LhOMnJDEqEc1+SGxqHOEkNS/eBW9UHRkyDifVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BzW35SAN;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A4606A31C;
	Wed, 11 Nov 2026 07:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BzW35SAN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794382149; x=1825918149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1dekqPkZuYHPocGHKh+uZWwfEHlMKbboO3NOCQnNiU=;
  b=BzW35SANfukiEk5rdRsqM9MXLF6n5EpdUZUS/F2s7rfmJyatsdUq8W6M
   PdmoqsCS+lKzpf8OI9o4l3ovdLqU4SQ8drGOAZ2roFKXtUlXyT70GKyd6
   6wSwXhqqLOkAOddsh6GiUFubLNqlW9thGbImGy11x2mt9Wotfs71UmQ+4
   e39PXZwMEEoQ4ekClEYp0YNZsNkz6kUEWd4JgEYsAW3PppeWZUtCRTzlC
   lNT+ewx0KrjSOYdYWKzUw5nvn+ETafcoLIwwHcVPqkoEKiNLZ1tIF+WEQ
   bl6IRmkubl3/3DfERUIv40+y7gxLf/3uZ71NdEX2WK7L0qShwuyOtJ+Gw
   g==;
X-CSE-ConnectionGUID: Ucjoxu5iRgaBbikLn2zjoA==
X-CSE-MsgGUID: vZbdKOB4T7mEZW9jolqdGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3041487"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3041487"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:29:09 -0800
X-CSE-ConnectionGUID: Bmex/UbwS2acPdMGlIj8Ug==
X-CSE-MsgGUID: VCkBnT3+Q12036NZ2Yxbog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10086889"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.71]) ([10.124.240.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:29:07 -0800
Message-ID: <81872925-d1e7-4f34-a3c3-fea26adc6735@intel.com>
Date: Wed, 11 Nov 2026 15:29:03 +0800
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
Subject: Re: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via
 TDVMCALL_REPORT_FATAL_ERROR
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sagi Shahar <sagis@google.com>, Lisa Wang <wyihan@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
 <20261106164732.3939387-1-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261106164732.3939387-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 12:47 AM, Sean Christopherson wrote:
> Add support for doing ucalls on TDX by abusing TDVMCALL_REPORT_FATAL_ERROR
> to pass the address of the payload to the host.  The "fatal error" TDVMCALL
> is perfectly suited for passing information to host userspace, as both the
> TDX Module and KVM allow the guest to pass (almost) all registers to the
> host, i.e. provide enough of a data payload to make a collision with a real
> fatal error practically impossible.
> 
> TDX can't use port I/O, as the TDX ABI doesn't allow the guest to share
> arbitrary register state with the host on a port I/O exit, and the port I/O
> data payload is limited to 4 bytes, i.e. would potentially truncate the
> ucall address.
> 
> Alternatively, TDX could use MMIO, but using a magic emulated MMIO address
> is fragile (see the TODO in __vm_create()), especially for TDX since TDX
> doesn't support read-only memslots, i.e. doesn't have line of sight towards
> addressing the TODO.  E.g. TDX could hardcode the address to something that
> is all but guaranteed to be unused on x86, e.g. the I/O APIC base address
> or the HPET address, but that doesn't truly address the fragility concerns,
> and it's ugly because ucall_arch_init() would completely ignore the passed
> in @mmio_gpa despite obviously utilizing emulated MMIO.
> 
> Use a simple flag to route vCPUs/VMs to the right do_ucall() routine, and
> take care to set the flag via write_guest_global() so that ucall_arch_init()
> is thread safe (in the *extremely* unlikely scenario a single test creates
> both TDX and non-TDX VMs *concurrently).
> 
> Alternatively, a virtual function pointer could be used to dispatch to the
> correct do_ucall() via an indirect branch, but that has zero advantages
> other than making ucall_arch_do_ucall() look prettier, at the cost of being
> slightly harder to understand and making ucall_arch_init() uglier.  KISS.
> 
> Cc: Sagi Shahar <sagis@google.com>
> Cc: Lisa Wang <wyihan@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

...
> +#define UCALL_PIO_PORT		((u16)0x1000)
> +#define UCALL_TDX_MAGIC		0xabacadabaULL
It's 0xa baca dabaULL. I think it should be a typo.
