Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458630AAD8;
	Mon, 14 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369456; cv=none; b=gsK/CTleuyE78YlC8wnrfQj9/Qb+dV0SBCOjW3LCZ7Nps0N24pkmO9IOgvQ5vcQQ2NmEjUNXmOkf7Cwe088pJOB1bq+PU9sYWNxkFXg3iINiKFv5nFhvl575M/G1amPN3pM0EfCnhIkUrfSD/zBiuHFuagUgnTIOGOX36ABa1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369456; c=relaxed/simple;
	bh=1Mv3L2QItE8RoxwCenyGeU9TirmqvmTopUEpRBc7Pj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAZARxXm6m4qDXvaA9IHthLMP0saw996wIS5hmG2C14Pyxcyz5zuTEtItJqdPesUpAGTpMAEz9oqWn0lLjvmmXIkLwj3mliJrjed/ycr+xHBGBGj4nddfvnaVh6RZjw/lVD5+9HwlUTNyKG02nEupD3VdW8nf2Ayyfo9GjIQx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYGcAxK2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYGcAxK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789369455; x=1820905455;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Mv3L2QItE8RoxwCenyGeU9TirmqvmTopUEpRBc7Pj0=;
  b=iYGcAxK23cXRtqZQrcN94GGJ1s2lsZtyDXP7U9/c8WpHc5DzIK85eEBi
   ZSa7rD/fKTHSg/fHPfYdS6xa6vMRXFLlDH5PojRwCa0iCOkniwUxQkGmw
   ERkrxPNEonqlhpLmV5ybM4xOfVpEVTXBooTsKXtVLMA8Hzh55WbVimTPQ
   NEt3PnrMeV9+jYxvlmSAJKZqJQ6kpQsgXVMO6QMOS4Nc1ddAEZGEspdAE
   MRh5bsppDahEZxHbN3vhEBLRmoYI0VKv7fyvW9qgim0LrRiIUJLfmOV+9
   VbjPIkrjTX4WH1gavchTofPbMopgx5iMccTJ5dASdR74gqgWwLJLHmg7X
   A==;
X-CSE-ConnectionGUID: YTmbsZOGQX+/FvW7OUvCzQ==
X-CSE-MsgGUID: LEbSOpALQ0Koj7Kq+N1pgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89761903"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89761903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 00:04:14 -0700
X-CSE-ConnectionGUID: 9MS817mvTFuMVOm6lsPOtQ==
X-CSE-MsgGUID: g7h+fQMETdC/lGzje22yIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="310837852"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 00:04:08 -0700
Message-ID: <dd7b17e4-8d84-426a-9962-3ae693dcf401@linux.intel.com>
Date: Mon, 14 Sep 2026 15:04:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/28] KVM: VMX: Save/restore guest FRED RSP0
To: Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org, x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-10-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260911213659.2025974-10-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Save guest FRED RSP0 in vmx_prepare_switch_to_host() and restore it
> in vmx_prepare_switch_to_guest() because MSR_IA32_FRED_RSP0 is passed
> through to the guest, thus is volatile/unknown.
> 
> Note, host FRED RSP0 is restored in arch_exit_to_user_mode_prepare(),
> regardless of whether it is modified in KVM.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v10:
>  - No change
> 
> Note, an equivalent TDX side implementation is missing. No TDX module
> with FRED support exists yet so this would be an issue for future
> platforms. A generic discussion regarding this is ongoing at:
> https://lore.kernel.org/kvm/20260827031837.2863609-1-binbin.wu@linux.intel.com/

For old KVM versions, we want to defer the opt-in design or backport decision.
(https://lore.kernel.org/kvm/c6b240bd-3c45-4abe-b17c-72a1a7da582f@linux.intel.com/)

We may finally choose to backport the TDX CPUID filtering patch series to stable
kernels. If this patch series lands first, should we add FRED in the deny list for
TDX as a temporary solution to avoid having some version(s) that allow FRED for
TDX without FRED support in KVM? 
