Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCD423EA2;
	Wed, 19 Aug 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130106; cv=none; b=i94sEWU8+HnPbBUDExOtBhO5uQYbJp8G+iMUXCIY/+OT92gryWe+ionaVc6q2mPYHG5gNO0OiMhfVdCQN8kbMhywoT9WuEcdjyFE/G2FZNMFZg30U+MbBUc+nt0LxH2WDlEtDhxmATALryD74sYYovoRW4XyTDNTal5HI7Eb+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130106; c=relaxed/simple;
	bh=98dOTjBq3wFdgdqGwfTTN7JMPJ0QM80kncC/dhsAaEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjWHLbul53wRzblYb6lte2yzrnKuad/JQ2pNP0Nkp4Yqc9Wb9yCDawJGoDyPY7v85KR8Q6wTyLWUlTN5X4/kDgE45NR6pCaGXK784vJu6pZh5oO1S6aJQkqEnXzYukq7PnpaGhbVsUQKJd1khuYIKbmby9dI/k4vbMe2P0HJlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSXRDztE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSXRDztE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787130102; x=1818666102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=98dOTjBq3wFdgdqGwfTTN7JMPJ0QM80kncC/dhsAaEM=;
  b=hSXRDztEuzK+vfxlEy/1ccqN6GCuPuovXdXysoD1h1iPqYv7jrVOCKa5
   OsZWYAP4Wj89yslv9bXROmkbfotQ5gOSmkOCO6e23jlZjgp264DAWCvKz
   NgK+4Mtq/Bdx+2UMUyBvWYzgYC5Hb8I8idzrWtnjzNMY3q6KPrLFGW4uM
   I1+AvxdZtXkQVazYVmxBOshPIMl4aseUvBgWZPGpNQzPZO9xhjdzn2Iae
   xB3AV3idyX4Mp7qzpJ3Y6WijEWhJqbdl2hB6ytNluVkdm6LfctGnXLU0o
   Nsq/rTn5DUNPgy60hm22rEcKpwJUNNiHbSbId53nEACkYy5ThGaTZWQGr
   w==;
X-CSE-ConnectionGUID: l4ZPcnSRRAy2LfEdhY2SmQ==
X-CSE-MsgGUID: r418o4NdSISl02Jar7NfXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87656950"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87656950"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:01:40 -0700
X-CSE-ConnectionGUID: 9ez7glO+TTyq5jZ/07zDlg==
X-CSE-MsgGUID: Msh0ANjXTbieZObaUkO15Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="270702846"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:01:33 -0700
Message-ID: <481a39fa-d99f-4139-823b-1d9327c3a9c8@linux.intel.com>
Date: Wed, 19 Aug 2026 17:01:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: x86: Virtualize LASS and advertise support to
 userspace
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
 <20260806011536.4172258-6-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> From: Zeng Guang <guang.zeng@intel.com>
> 
> Virtualize Linear Address Space Separation (LASS) by letting the guest
> enable CR4.LASS[bit 27]. Allow the guest to set CR4.LASS only if LASS is
> enumerated in the guest's CPUID. Set CR4.LASS in the emulated
> IA32_VMX_CR4_FIXED1 MSR so that LASS can be enabled in nested VMX
> operation as well.
> 
> Keep CR4.LASS KVM-owned instead of making it guest-owned. LASS is
> expected to be enabled once per vCPU at boot and rarely toggled at
> runtime.
> 
> LASS is enumerated by CPUID.(EAX=07H,ECX=1):EAX.LASS[bit 6] and only
> works in IA-32e mode. Advertise LASS to userspace on 64-bit kernels and
> only when it is supported by the host. Notably, it will not be exposed
> to userspace if the deprecated vsyscall=emulate mode is set on the
                                                   ^
Nit: mode could be dropped.

> kernel command line.
> 
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
