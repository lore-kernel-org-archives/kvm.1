Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662531;
	b=KIZP9jvPRJ/HU+RW4J7YfYmwpc10LXjlncFQ+wk8ueQhkgqUUbaALHCa8SfbgHh2v0Uw
	 NYJV1QbXeg5WKzgw3lqqhwCQqpSHgPa7fkz2WKEmgRab+IPHwLABf7xy5vHl/Cruy76xg
	 BQloUcodMrsYMYxpqkgBGe7f6/0WaPYwFPoCXQL0avAUgwVtwTxA4AwQEs5D8Ld+Df4Uu
	 wVVHcLRy2WULSFz4twb3DD9XMw21fOVxCnksr7o8viM4zeTXHWkJvJ6jlZ4eacusFECaw
	 70oVTIlfWE8odfvcSnjzxZMxTTZkn//t2h4qENIcd8YdG0LlmZ4bVwqKax/4mTdoWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662531;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Visoc9hzUWFmpwG5W1YReX0mRk9Q7LNHgZtsezfYlGI=;
	b=IfQBf4snrxLjcNctVVqaNDAw2Iq6UjFNfhR8bFTXN+RYjJouzmVLh1RJ1hYQFP74nN/a
	 BK7ZsY6I4nSaGn+Jlv6QSyXBw2aD3Pdg/dm5ZN51gwcQNiO1RaaalGi9tf7NxhgxohSa+
	 5ECI252ZeZunpsqqTtK0zSM79uFKuCWG5VCMorrAOzrn1v9bDsca++JNQZID3wEC9qkx/
	 0PEPCXz844uEsNjsLqpQ65xS+15L5DoSeTKC5mYA8kSuoLrFN0mt2KwsoHdXV5LhcEodZ
	 /N8zl8NsFq/XbFgJO/g+Bc9+24uA9leSO1vrxVZB1TC/vDByI/n88Rci76csH25vcuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nf4ycdoD;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBA606A320;
	Thu, 22 Oct 2026 09:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AEBA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nf4ycdoD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792662530; x=1824198530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FPMesYIn6WeTiP8Se+MxVcPotRRnpgraCVC6qWkv2o8=;
  b=nf4ycdoDW6Ijo3dipbMSIcL3Oef6HsOPAma8WipUCFKMBIyNKijVhpbA
   c7/puGxxU6S13q7yS29diG2LHSgJAHu/pkSm/njByWEoQrm9AxYWleyA7
   yTllhc6kRfDWywt6N+WR4MAfwSCaozLPl/UBBlsqcAeu88vOB8++OBY2z
   sV6Kf8mEONLri1J2+jVNLrp1KqnknDEbrXyITGPW7OPktEu/8z//GACMk
   d+hphJL3kvtC44hoSOtEMzulwHyp0/cQrX8/iG0LS3zRmk+d5ITtlR//M
   PZwTinoq/eF88BOIb86ORX7hmvcpPojPpvHTEIZhnhOEMKqL44Ao4ytwT
   Q==;
X-CSE-ConnectionGUID: d1nEcnChS8yy6J4oFYW2qg==
X-CSE-MsgGUID: 2jdPLZC+RsO84wZC4wDFwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1416128"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1416128"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:48:49 -0700
X-CSE-ConnectionGUID: Psjhy0ZrR/eozmB73zes/w==
X-CSE-MsgGUID: vjO3P3GtR7eKRnb6J+d9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3201084"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:48:44 -0700
Message-ID: <acc168cc-e021-43dc-8846-ed1b2d69facb@linux.intel.com>
Date: Thu, 22 Oct 2026 17:48:42 +0800
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
Subject: Re: [PATCH v10 02/28] KVM: VMX: Initialize VM entry/exit FRED
 controls in vmcs_config
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
 <20260911213659.2025974-3-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-3-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
[...]
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b4aec4218b7d..062631e2dd37 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2778,6 +2778,8 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  		u32 entry_control;
>  		u64 exit_control;
>  	} const vmcs_entry_exit2_pairs[] = {
> +		{ VM_ENTRY_LOAD_IA32_FRED,
> +			SECONDARY_VM_EXIT_SAVE_IA32_FRED | SECONDARY_VM_EXIT_LOAD_IA32_FRED },

I think it can be break into two lines for much better readability:

	} const vmcs_entry_exit2_pairs[] = {
		{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_SAVE_IA32_FRED },
		{ VM_ENTRY_LOAD_IA32_FRED,	SECONDARY_VM_EXIT_LOAD_IA32_FRED },
	};

Oh, it also fixes the issue reported by the sashiko.

