Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661270;
	b=HmFo6cfKT80/KXuQEZtGcDa66DrMKiSaAxFzLcs4RfgdFCcpI5TXHksbXtMLFZo5/Wnm
	 DJ1Q523BNo+PFnF7ezWvQMDaKbELjD/j/K0bK/GHzAQY1wxTAf1/4KM5nb0PSRW+q+SlA
	 7ScVg4B/JJcNry9qAgFt9iu82oPIPtzicDHiSX+AvXdobJPyREU8nqVkE2/ZKBjP3lLe8
	 3nNS6u0UQOprEjsuOSPJdbYo+2vXhP/TT2TCdg1c9OOe9avDD0d3kOp0iNpScSccH5sDe
	 OsJqLYxEtOYeV4HoLa7uapra2te6SYa1joo0LSxyrh6zslUuciRnkG9doDdc+c1kaIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661270;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+ONt4F1TGuj2D4gQ5Y9zhiAKxe2DyLjInWzcKZuuWlA=;
	b=q7H0ca0hOtuim8A7KHRrY3FCwhVs/NS42eyv+HaFdfg6JvWV8jIy9kW38zY/CilBoA5t
	 cf3PDAZqf0UzWsT4b14qoDko8Kh2EhJ95Y2C2QPou7tEGIrvM20swyEoXurTYxU/IrEFh
	 b/BndfCk/YE9sz39gfSwIrG4ZcyDkYZBH5n7ymNaN6vKpDhaizrQhV9gRMltvMDYWrE65
	 VfdZS8CEu4/2nVwzB72UvW7HzPezxmYIXOu2TDCBBUu9qHlW7K5sT50+t2aAUDoqc+Z6L
	 TJEu8os4mITgIyMAtsNqkzRKHVPIVsPpQX4zTpbL5fGRtLgwFev3X8/NMe+R+wRH8hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ShdJO+V6;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6C606A32F;
	Thu, 22 Oct 2026 09:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE6C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ShdJO+V6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792661270; x=1824197270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rK5sIX1DXwk1tF+cbYqZC1RpKRClNvCK9hC7fUt7PpE=;
  b=ShdJO+V6REirnz1pz6uKRgBhNLE2fBibKr4TlyEV5lx141c6edaxYWES
   qqyDSbe8TW5iKbMvgkgt7p00k145nQ3v7Dc58ECoE/FNcFAcNU+05vroR
   wJYS4+QmQupYjVglEMxTcixAiSkVVW6vCv/gcPzW8n+8tqgHIhuwAorqh
   PG60OtWWwxNoNLYo1PXeyBJcHADh3ZpsVav/dFRpJknKyeZ5jmTfkBs9g
   zc+PxP3dGsrQbzAtKw+a/cXqRfkuNgNrXwnrXLAElKE4wSkKS+3+/AGJc
   S9T+8lRyqU8+MsvS4UO8vLj51z8LcMXEYSVwBp9dsy9wEL17b/nl1WIdO
   Q==;
X-CSE-ConnectionGUID: 8cTjpWbdSbaHD1DVkZSYOg==
X-CSE-MsgGUID: rtR1K3WARySoa2eAExVktQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1276480"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1276480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:27:49 -0700
X-CSE-ConnectionGUID: 5ZcempBrR2CHCHyjA59+2w==
X-CSE-MsgGUID: eEQlHikqQoqFh/RjbTax3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3675540"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:27:43 -0700
Message-ID: <1e219be9-e7c8-455c-a3ff-10f80515d4dc@linux.intel.com>
Date: Thu, 22 Oct 2026 17:27:40 +0800
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
Subject: Re: [PATCH v10 01/28] KVM: VMX: Enable support for secondary VM exit
 controls
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
 <20260911213659.2025974-2-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-2-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Introduce infrastructure to support secondary VM exit controls.
> 
> Always load the controls when supported by hardware, though all control
> bits remain clear in this patch.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

[...]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 504630f0eb40..b4aec4218b7d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2751,8 +2751,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	u32 _cpu_based_exec_control = 0;
>  	u32 _cpu_based_2nd_exec_control = 0;
>  	u64 _cpu_based_3rd_exec_control = 0;
> -	u32 _vmexit_control = 0;
>  	u32 _vmentry_control = 0;
> +	u32 _vmexit_control = 0;
> +	u64 _vmexit2_control = 0;


Nit:
Could be _vmexit_2nd_control to be consistent with _cpu_based_2nd_exec_control
above, as well as vmexit_2nd_control in struct vmcs_config.

>  	u64 basic_msr;
>  	u64 misc_msr;
>  
