Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745973;
	b=rLVm7VRZtrmKi/8khPgcc1VQrdvzPJhdwd7YUne+QsKXSGqVrKjGQlrhIbSTdbyTwhPd
	 VYspqRoZNmFPiNJas+rOmuqi5C8a/Ck+i32XD2qc0R87NVYYrDRorEyPB+tli10j9e0DJ
	 sHzZrmcxhQHZ0Yc9A2CMwwec7k+4p3mWU+mJE5ev1m8/JtnIKDuhPeXQQanW7DoHISTOi
	 T5godaguIQsPAzYBQ1CXCmeTp9DRN8omnk6KxIMYTf25KT8ZLI9uW62tn+vYwYMsUMmxM
	 Oy5aJnjA1t2TzLdjgyoysxfBStDz+cXswYWH6R3+mgPAEa3Y5TcCXuwTvJTFwZj8jTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745973;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=p+CZWrgFfkHo8tPZ0mXySilU+u9oXL3M5JdKwfFfvv8=;
	b=t14zmXvJzySD7QlBA8UL6gQkNshhZ8FnCNwmSxgZBCPP/RLmwkDDBIQueQ5bJCh3xvf6
	 RBCJqyhuQkiA4CWUVwNis5iZY7d2lUdoi08qMnI56WB1cSDQS200l0y2XJAlqqOWRqsEL
	 TYqy1D/0YATwBywE+ikLpQr57Y1u9VcEHMpS6pGgI90wFSjYT9uO30dAsUIEdGqjU0F8d
	 MZMvtZjHI9fEY+k0S7zRrV6HZoZbqVcAl1Q6SJmw8gxrOVFn5Nw5/q4ozNuMV48eUolvC
	 PT97HJKpYLE5xIYt46RMRB2JAMhZKrz1y5rw75VDiO9XOrIaMPJmwXyVtYkPoPjaFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iIo82/U3";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7A606A32C;
	Fri, 23 Oct 2026 08:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB7A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iIo82/U3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792745973; x=1824281973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NkRv8z1fvcjDDzk6L4DTc04fc1cw9emCL6L4ICuk5DM=;
  b=iIo82/U3TIb/VpYasGdp9Ne7HmmKXAW1Bodrc+MQ0v5Qr3yHbbV1HQrY
   kkTF7UFZRJ2Gs4T0JWf7WY56II1PVJnB5W2lqg2Y31dzibqn1tdp0zmpM
   ZM97KcRaARQdYKQUCcDWGmFEzMALlb7/F2/yKqXZNx4OR3v1RTIUVkub9
   54kL0b/bcqRSMJs/HdIJtPThuJCU6bcxnIU4FhO+2PUK3wh1FyFcW0oED
   XiqSyG4gmt6DOninQkS0b5CR0ufKmm78llM7zvFCpLOhCHoreZbszweit
   9jXtL3UXBP9jD+ji3PaX1yoZT35JmoEfZi3eSRLodqezkPm/4b4+ODjRQ
   Q==;
X-CSE-ConnectionGUID: zilVgmVmTqW/ux67oHL2mg==
X-CSE-MsgGUID: iVcVsNkBSfacEOPyuhtqmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1406343"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1406343"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:59:32 -0700
X-CSE-ConnectionGUID: RjghvquPTNSn/VJSTo1ghA==
X-CSE-MsgGUID: BOZpR02HRBeDHo18NCIVKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3656910"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:59:25 -0700
Message-ID: <9ef4e795-1222-49bb-a6a5-0823c57afce1@linux.intel.com>
Date: Fri, 23 Oct 2026 16:59:23 +0800
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
Subject: Re: [PATCH v10 10/28] KVM: VMX: Add support for saving and restoring
 FRED MSRs
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-11-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-11-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Introduce support for handling FRED MSR access requests, enabling both
> host and guest to read and write FRED MSRs, which is essential for VM
> save/restore and live migration, and allows userspace tools such as QEMU
> to access the relevant MSRs.
> 
> Specially, intercept accesses to the FRED SSP0 MSR (IA32_PL0_SSP), which
> remains accessible when FRED is enumerated even if CET is not. 

Nit:
It sounds like the patch adds interception. But the patch emulates the access
of the MSR. 

> This
> ensures the guest value is fully virtual and does not alter the hardware
> FRED SSP0 MSR.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> ---
> v10:
>  - Fix a corner case identified by Chao Gao.
> ---
>  arch/x86/include/asm/kvm_host.h  |  5 ++
>  arch/x86/include/asm/msr-index.h |  2 +
>  arch/x86/kvm/msrs.c              | 89 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/vmx/vmx.c           | 45 ++++++++++++++++
>  4 files changed, 138 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8d3999772ac2..0fd5d4edeebb 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1032,6 +1032,11 @@ struct kvm_vcpu_arch {
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t hv_root_tdp;
>  #endif
> +	/*
> +	 * Stores the FRED SSP0 MSR when CET is not supported, prompting KVM
Nit:
CET could be more specific, i.e. SHSTK. I am not sure if there is a situation
that one is supported, but the other is not.

"prompting KVM to intercept its accesses" is confusing to me.
> +	 * to intercept its accesses.
> +	 */
> +	u64 fred_ssp0_fallback;
>  };

[...]

