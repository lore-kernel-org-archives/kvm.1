Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776235;
	b=mFABDhoq+7px+u6Yaz8vDWOj594/9nW3Vms52U+18aNsNbv5Vt6WjMcTasaIQQ0FbD/I
	 hlEL8V6ucAWlD8RGeyb6qxjhzKwHL/SCJvK8v6QyOmfIkNoTmQgVuC8MhOvgyXQ63iS34
	 20fSnSkvWhKs4C+AhTpUfXKWH3hp9fkztspFhnWzcIaNFuhbFXBFwPQllvxocpQGrG7r4
	 jcCsOGUL0wvhaLTNbPfMudkO7zAzNgDoV0WH+f/3x6+G3X/Q490z8OyEwBWB2jA3rAFT8
	 2fcqZLGMsmM01ZDKeVWJ6h5iHBCNt4DjWOo1sFumXkagmyX8JjXX6GaVyvkQ2C5KGNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VqhqYv5xRCJh3PZJ4l1J28vhc8YpfgaLTAOZMf1YNvc=;
	b=bST/Gd3zuwNm+GkPt7pU2taD3pIBfvOKd6IMFVNJnACp044vuSqHNdcVzkA+tY9BPGwz
	 lLFcJEcAw4AlaZDgHkacUz7nugHKZN/wEeIfKPTV4CjuxbtwG0dMtiE84MRABKPFMRRxs
	 ZQXDZDmQnbqxNqgd7ydeIQUZh/ry1l+8D3Du8Wii/dDhurNhj67GZqlQWrN34vKFQTiYv
	 Tv/mSYEdI9Jjrf5cmWLWxVa52aVT/tuAjQK2Ho8ZLdd+JLcaPY85LnsBgfAeVPxo78lZW
	 3dOloIpD16nwna9MgH+9jIcf61UEhEavKYzC0ZFnfm0kLIXSQ9GXK3Q9DV6WXwtowKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UFlhlFnU;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADF606A31B;
	Wed,  4 Nov 2026 07:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDADF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UFlhlFnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793776235; x=1825312235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lb589BYUiqB+Eo3EFeccpweIuip/ffeL/F1y59tM/VU=;
  b=UFlhlFnUfdnicz+mhSETKeTz5u+HQseEWUZErKWoHVCrX/dU6Cr9iYxT
   UcSBz4AMjRwmqC8TNwM06JFRdHktjfppXer2iJlN/2dh2bb1UqM9eA2fA
   w6WTGM8dk3/1JOWDfgDfe3d5cUNCrVUC3ObIWERH8og4v4dUAM3N17WAo
   0X4jN43Yjbm0P5BvpJ0z2EN05f7C3yfLg5l1gDO5JaNsyvNX3JxGCjxTi
   R3q7s7S88opHXJApLFhK49DFPRz7Sr56xcwOs73J5W3rGG2mcqSuJn2Nx
   FqlnUEwOTdfmpLH4bIY34o+yiD0BHzQQoMt1ddQY1UYRjEzSjRbEGXp2m
   A==;
X-CSE-ConnectionGUID: I/sufF5lQvKPf8+W3lQ+ZA==
X-CSE-MsgGUID: oRZkvDk3RhOnvjJEaWh6bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2554061"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2554061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:10:34 -0800
X-CSE-ConnectionGUID: Z9dqWEFJRkmo0iqgeO6AoA==
X-CSE-MsgGUID: RDgCXPhUQIq6gX05VrV3cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7201705"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:10:29 -0800
Message-ID: <bdf4c5dc-7532-4451-8b3e-0f6459be523d@linux.intel.com>
Date: Wed, 4 Nov 2026 15:10:26 +0800
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
Subject: Re: [PATCH v10 23/28] KVM: nVMX: Shadow ORIGINAL_EVENT_DATA and
 INJECTED_EVENT_DATA fields
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
 <20260911213659.2025974-24-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-24-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Add ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA to the list of shadowed
> VMCS fields.
> 
> Shadowing these fields allows the L1 hypervisor to access them without
> triggering a VM-exit to L0, optimizing performance for nested
> virtualization workloads that frequently query or inject event data.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
> v10:
>  - Split out of "KVM: nVMX: Guard SHADOW_FIELD_R[OW] macros with VMX
>    feature checks" (Sean).
> ---
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmcs_shadow_fields.h b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> index 67e821c2be6d..bdd56f3ca6c3 100644
> --- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> +++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
> @@ -74,6 +74,10 @@ SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
>  /* 64-bit */
>  SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
>  SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
> +SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA, original_event_data)
> +SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA_HIGH, original_event_data)
> +SHADOW_FIELD_RW(INJECTED_EVENT_DATA, injected_event_data)
> +SHADOW_FIELD_RW(INJECTED_EVENT_DATA_HIGH, injected_event_data)
>  #endif
>  
>  #undef SHADOW_FIELD_RO

