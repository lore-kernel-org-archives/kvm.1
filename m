Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420343CB8FC;
	Wed, 19 Aug 2026 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119144; cv=none; b=sXkSzkpe8BhidP5dajCj5hwTMMo60gv6kSRpxrM+eY9H7S/LIvh4zi0aoo9Q9M+OVkXo24/WTrrORBitaFGEsH/P+gbeL26gK0bwMTv3S412dDYy0JRI2ykwXXruRkXRZnbduo6UyOisVxVdeKxAxI4u9E2PlsWKERJEU2dYE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119144; c=relaxed/simple;
	bh=3ijK5leCDO5dBZ1nUjU6DYQQJK1cQwzFUFG62d92HLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AteQQCimjSdx8OTw3Lg9129scCmXkLEv1phk2uEv1QU8V3I02dALj2pSTUSanUH7OQACyd9xMKpJknPbt1IR8C80lK4YliWCTcT7bgwNFvUsBRdZBGOV1paHW6xsHth790wueAGFRwDOjRyBxK3mb398eyjZkDO6mzGzl95zc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIrgAYXs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIrgAYXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787119143; x=1818655143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ijK5leCDO5dBZ1nUjU6DYQQJK1cQwzFUFG62d92HLY=;
  b=NIrgAYXsdBMTBzoA5NnsKxE63IPCk4WMsV7vU9Bc9d93NQDUxa2oN7Sg
   YlQTx99fc6VvseNGocBjA/A6yvUnlx8YMKMWSToq2T6kEjATspp0WOPJ2
   bRnN+5/zBh68tmqM4iomErAhxu4PDh7hJcUEFAqI13yyQSzNWM4A26cy/
   +CbZB53hbKQFHD+cC7gIk0c4BtK076/evlBL2MUW7AKOqZFk7Icg+HhcL
   cU8bu8HjrrAjHkHNp6ikZCurZo8UqgUuTB3T6Y1hw8Sa2zwco9RU3JPUF
   ovHoja67z+zBGQQrOGDn8BSiuBU3sKz8iUltDZHTFUgZuWZ0rmgbKEZGy
   Q==;
X-CSE-ConnectionGUID: v/QV/H5GRkOFmI6b7F8QTg==
X-CSE-MsgGUID: hXFwkr4PSVaoDrEzMTVn7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98779846"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98779846"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:59:02 -0700
X-CSE-ConnectionGUID: NbDRFx2dSr6fBOOoo14+Pg==
X-CSE-MsgGUID: 8rr47MQwT1a5RqUD+F32lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263709444"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:58:57 -0700
Message-ID: <074e463a-0203-4170-b8ec-cf4905f3e148@linux.intel.com>
Date: Wed, 19 Aug 2026 13:58:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] KVM: x86: Add LASS violation checks during
 instruction emulation
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
 <20260806011536.4172258-4-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-4-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> From: Zeng Guang <guang.zeng@intel.com>
> 
> When Linear Address Space Separation (LASS) is enabled, the processor
> applies a LASS violation check on every access to a linear address. To
> align with hardware behavior, KVM needs to perform the same check during
> instruction emulation before consulting the page tables.
> 
> Add a new callback to x86_emulate_ops to let the emulator query whether
> an access would trigger a LASS violation. The callback takes the linear
> address and the size that describe the memory access, plus a set of
> flags that convey the type of access.
> 
> Add the LASS violation check to __linearize() so that every explicit
> guest memory access is validated along with the other linear address
> checks. The SDM (June 2026), Vol3, Chapter 4, specifically states that
> there is no relative ordering between the canonicality check and the
> LASS violation check. Also, there is no prioritization specified between
> the faults generated by alignment checks and LASS violations.
> 
> Implicit supervisor accesses bypass __linearize(). So, add LASS checks
> for those in linear_read_system() and linear_write_system() and tag the
> access as implicit.
> 
> For now, emulator_is_lass_violation() is a no-op. Later, it will be
> wired up to the VMX implementation.
> 
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

My SoB can be dropped.

> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
