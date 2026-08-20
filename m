Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EE3B0AD4;
	Thu, 20 Aug 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207783; cv=none; b=LG3hocuW7ZhUl6OgTDvgbqhETsc16dGQ1DWfmCov3A7rTJVVpIimA4R0EMKGfCNh6aN48glozBnSlu2rV2nllSTDx+MAMIKo8czzSNeWtFpKn3ibjyHQCDSbHN+rIYevJIUlgWurJ1aCt+MQ2w33QWl7ygYYjnCmcGiHyOejxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207783; c=relaxed/simple;
	bh=bu2viIWiLrmgk/PG9G5rHnttUDD9cg27yQSbLWC1b+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nefJ7NdtPdsT+a0gSHLJStxfcgdJPpSYHfjaCoRSJkv0xX+jNPl9Br8tkaCyCKHwYPg5XVIOnVt/T1pptib/Z3nQ21uVIITl9D71MFlekrBWKXHGhsjUQ+Rc+e+z/hkzcJINOgiRxvm/I8QBYHdgx+dcWcxbDVidnsAWYICftUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf8+jp15; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf8+jp15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787207780; x=1818743780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bu2viIWiLrmgk/PG9G5rHnttUDD9cg27yQSbLWC1b+8=;
  b=Qf8+jp150E+ylkx09vPLoZfE391J41C48zRnZ5vN+uy2UTot50sBxRSZ
   8fxNBB9FP4Z88eqZDXX+gNKK/nVzVUmddD15942tNog+rboImjHbs4xpE
   m7pR2rcCSgRbou/7IQS0ubkbHQAguq9M3m8AMx9kKzSMlQzDg/M+0g6xe
   j8ktFg4cOXvw3HuVsH3tvE9YxTu98Qjq4MzTtuWJt3fgX1A+uzwkZG/A2
   Be2nlYYzGPyW4mGLw7N04eQFNd/zppZdlKxA2S3fBs/+vCD52j2ofD5vd
   B8DHbhBhk2oFloh2axqhfjfqK1gRKwzYAthumcGhQIkX5XHnwWWimKL8b
   g==;
X-CSE-ConnectionGUID: L7tu2V76RYC8+m+81WpLeA==
X-CSE-MsgGUID: NBWt75geTwOrOgk9zmAPJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99257312"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="99257312"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 23:36:17 -0700
X-CSE-ConnectionGUID: 4hpV9L85SHmdZsGb3xnJHA==
X-CSE-MsgGUID: ewdbwCg+Qu24nyIqYcgR1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="295789356"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 23:36:13 -0700
Message-ID: <e6f853c7-ec9f-4e1a-bf7a-3b97ff84d3aa@linux.intel.com>
Date: Thu, 20 Aug 2026 14:36:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests/x86: Add a userspace test for LASS
 enforcement
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
 <20260806011536.4172258-8-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-8-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> With LASS enabled, a user-mode access to a kernel address raises a #GP
> instead of the #PF that SMAP/SMEP would produce. Nothing in the x86
> selftests specifically tests for a LASS violation. The vsyscall selftest
> exercises this flow but doesn't verify the resulting #GP.
> 
> Add a test that reads, writes and executes at a canonical kernel address
> and verifies each one faults with a #GP and a null error code. For the
> instruction fetch, also verify the fault is reported at the target,
> since LASS does not check the target of a branch.
> 
> Skip the test unless /proc/cpuinfo reports the lass flag. The CPUID bit
> alone does not say whether the kernel enabled LASS.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

[...]

> +int main(void)
> +{
> +	ksft_print_header();
> +
> +	if (!is_lass_active())
> +		ksft_exit_skip("LASS is not enabled\n");
> +
> +	ksft_set_plan(TOTAL_TESTS);
> +
> +	sethandler(SIGSEGV, fault_handler, 0);
> +	/* Only to report a #SS; LASS shouldn't cause one here. */
> +	sethandler(SIGBUS, fault_handler, 0);

So the purpose is that if there is an unexpected #SS, fails the test instead of
killing it, right?

> +
> +	ksft_print_msg("Accessing the kernel address 0x%lx from userspace\n",
> +		       (unsigned long)KERNEL_ADDR);
> +	test_kernel_read();
> +	test_kernel_write();
> +	test_kernel_fetch();
> +
> +	clearhandler(SIGBUS);
> +	clearhandler(SIGSEGV);
> +
> +	ksft_finished();
> +}

