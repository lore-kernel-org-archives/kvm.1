Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214407;
	b=gnnjf+tq83CNgjTk5THHgBJnYJjCDC53soM1T7zD0TN7nMfDz1rBo294VnqKCYDo3Cw8
	 9ePS9Eu5anLCC04tdqxSn7ZcRXxvav84GBohrxrPESu23ylQyTjmVgVaXOul7slze4ZAl
	 ooV6FXdnD+FpzwjOXBfLa4I59Dowmlr024Df0N5bmuzPxTohWT5REu1VaZ+hwyszhWwry
	 FLe0Fwd063Bu8UBv0hjolTkw1yAgFmRqpbKEuCJ4iK2oSYzZfbHd3kddGR3M8MlTMqISe
	 oH4/J2ApC2/kCNquSdMndMzkGILm4QhFpFtEwKYoHyhpp8I3OkQnSatz/rQqDCT8n0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214407;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6t+vf6iGGvmtu53Ld38Ljlix1wD8ca6ce6t34f5kd3M=;
	b=sS8IhDFDTzDk/sUHwS+MGEnyevZgVrBCFj15thdR5ZNVDVTCFrH3Trdrav8ipr3nqTBN
	 vZroAazKvijQp4aBRSpwvVJNN7TdJZpyDajqTuKKH1p2RdOH6b/PPe0xvblyZq8qhn+bk
	 Wrj0gNY3CVIAxJLqtvjgpKY529r3IlHpJWQqqhRrzY9aeWDs2z7aOvblc8V95H9zLT3p4
	 cntPoh9Y7+FRf1NWon55jz3EqoVOon5UTby8pCAwX/OKu4iEWFTBxW0rsjiWrevk0MMEP
	 BZoAn+UHQ99tIA24ZAhPXsE9JKrGdJDEw8UkO8ZKTppXeQqMCmyxsl1Cz2Xa8pLTvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNpScM05;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA19606D80F;
	Mon,  9 Nov 2026 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA19606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNpScM05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794214407; x=1825750407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PDyVAs/P/xjSKJ+msEBqQaraDJZto4lbelsWIOUQKPQ=;
  b=CNpScM05Ns0RBbVM0jDbjWh5GYs8pcJYVU9qjlPY2GeZ9OVju/Kacqeh
   FnGn7kfoHc+jXaDKgl2ztsu3MLuAUPTRxPSs9Ui5+6FaFgYWB2F4B8hNo
   2oVc+l4nirZM+utxlALzT6rN7z58FaViG8I5VExrjllyfJI+i54wC/zbh
   LPkBEAAWWfTDcgpCO8W0Q4/CSkA4Utrj8Ow3w82oG84ri55vwJt/NIQg5
   eUPxA+6fHiz/iQ5TMd2dqZf6LPnOuHL0Zm/lI8KhDGw6t7eo0rRPDvfk2
   zGp3z9k/lyKd5itzvr6XN99l0uRtug5VxuzQGPm1fPCLftnIxJ0QKGN/x
   Q==;
X-CSE-ConnectionGUID: SKerGGctRCuFdvAyT5sFqw==
X-CSE-MsgGUID: 19YoOawcSZef8vGSsv2P3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2947798"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2947798"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 00:53:26 -0800
X-CSE-ConnectionGUID: q/yk6RX0TLeiSS8T5mjpuw==
X-CSE-MsgGUID: h1Nf3eMlRWeBVo2y3gRcPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8156437"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 00:53:24 -0800
Message-ID: <6c3b5480-258c-471d-b700-4931d408161f@linux.intel.com>
Date: Mon, 9 Nov 2026 16:53:20 +0800
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
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sagi Shahar <sagis@google.com>,
 Lisa Wang <wyihan@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Ackerley Tng <ackerleytng@google.com>
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
 <20261106164732.3939387-1-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
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
                                       ^
Nit: missing a '*'?

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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

BTW, the in-reply-to patch didn't trigger a new round of Sashiko review.

