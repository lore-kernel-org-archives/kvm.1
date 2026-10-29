Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263317;
	b=2b3eYe0zNOt6m8pS3lpBqcyooME0aQCz/WaKNIPpuLC17o+9Sh1C4hElxzr70wllm6RX
	 KxShbeT1GBKdNv494mR82dGd9XNbPZ3cWXOztG5sAxHE31t+JaeZYj2cbv4AlgiBuinga
	 7EC0RfXNV8WiBgXFwJa/D71Th4RbzHYvuFTVymKY2LpyVtf3u58CSCXFh7KWKH7DM86wQ
	 ZsoWZFsLJTg8g7PlsGdw+QcabcJv6KmBcqRFPrkiwVLrhG+wdO47dAxQh5HB42a8+1T37
	 rmJHhPaMKbj1t9H3xGbEEwQn2VhQ0bafPhR5WN102I4wsO+A3Mr8ArZ/eGoKGpS4DuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+iHG5Nv7QtD3HvoUzsxeataN0HwPw98x2EhIsYF3L+A=;
	b=2GVqvC2UQuHtGAe7k3kxwx3XGGEp9FxiY90J4FugMcKwhBnKbP+REp9V9Sc3cjxHTftg
	 0R27zUH1ZDDTb52Xd2oXHGDMD3QGJ1121emFqup2oWr0dlULRo60jqfPLhjooAzzQpZhZ
	 2JKHGS+BJCgWeaGiSJP2HPjDNGXCB5N5JHdEUxxvV9gbgacAYkeYtHCHjJqkPnJywsj1/
	 PPO278Uf4chvBsqG85RypLJZ9FvczhrNU8FWlPz6o4yw4xDWiWPyuL0ON17yP5eV3l6Xc
	 D8zMbQdaK+RXJfGOBRlXmwR5QptrNHyfclNpFLXkfz0MCIzRYBdKkaRoutbMCEhLtng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Gh/q5g/3";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F4606A322;
	Thu, 29 Oct 2026 08:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0F4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gh/q5g/3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793263316; x=1824799316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JC5hKSpzmc00gb8cESNfe5ryL5VkO2PEYB0+W435hzY=;
  b=Gh/q5g/3g/s8Ngt2/o4MP9iXWhRobZAom4i4dGGEA/Mbjo5Gy3Myg1pP
   1QIUAzI4mfGGuu3uw1t6ylnW46xv/co9xDgosnDNHmL+WfGAUvx3b9YX6
   3n2Sr6bwBBfzIozOY4ijZc5u3amKHKJVzYiz5mUkxYp0nd5xaxDjhAm6m
   EbuTGD7/F+klFHmKztVwNKCwHxfZTiVTrkSB7g9Ac2s05wdjoimNURqhg
   xQuU96qDHf0ZIJs5L84naSEXr2Vbo9Sbi6cX5nzYsE8WldPC/uWoFosW5
   Qm74tWLXnWbN79Wr45HcmDVckGCxF8kxUa9HKhqRFq3JA9HJyPEogv93v
   A==;
X-CSE-ConnectionGUID: cLW3LCChSDyQlxHQSvTSyg==
X-CSE-MsgGUID: ayuzNsVoStSOpicasvWA4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1892353"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1892353"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:41:55 -0700
X-CSE-ConnectionGUID: G3YTq7HSTKCER1pld6MiJg==
X-CSE-MsgGUID: hsGJeeYcTR2RewFgXvJNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5089359"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:41:50 -0700
Message-ID: <a77b4273-4d3f-464c-8ced-f6b958eac9e4@linux.intel.com>
Date: Thu, 29 Oct 2026 16:41:47 +0800
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
Subject: Re: [PATCH v10 13/28] KVM: VMX: Virtualize FRED nested exception
 tracking
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
 <20260911213659.2025974-14-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-14-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Set the VMX nested exception bit in VM-entry interruption information
> field when injecting a nested exception using FRED event delivery to
> ensure:
>   1) A nested exception is injected on a correct stack level.
>   2) The nested bit defined in FRED stack frame is set.
> 
> The event stack level used by FRED event delivery depends on whether
> the event was a nested exception encountered during delivery of an
> earlier event, because a nested exception is "regarded" as happening
> on ring 0.  E.g., when #PF is configured to use stack level 1 in
> IA32_FRED_STKLVLS MSR:
>   - nested #PF will be delivered on the stack pointed by IA32_FRED_RSP1
>     MSR when encountered in ring 3 and ring 0.
>   - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP0
>     MSR when encountered in ring 3.
> 
> The VMX nested-exception support ensures a correct event stack level is
> chosen when a VM entry injects a nested exception.
> 
> In addition, save/restore the nested flag of an exception during VM
> save/restore and live migration to ensure a correct event stack level
> is chosen when a nested exception is injected through FRED event
> delivery across VM save/restore and live migration.
> 
> Note, like the other fields of struct kvm_queued_exception, the nested
> flag is meaningful only while the exception is pending or injected. It
> is not consulted otherwise, and so doesn't need to be cleared when an
> exception is dropped.

Just try to understand the sentence.
The patch clears is_nested alongside pending/injected in two places:
1. kvm_clear_exception_queue()
2. When the exception from userspace is converted to a nested vm exit.

So are they needed?

> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> [ Sean: reworked kvm_requeue_exception() to simply the code changes ]
                                                ^
simplify

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>

[...]

> @@ -8978,6 +8993,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  					   ex->has_payload, ex->payload);
>  		ex->injected = false;
>  		ex->pending = false;
> +		ex->is_nested = false;
>  	}
>  	vcpu->arch.exception_from_userspace = false;
>  
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 0f5919b092e4..2d6bae66cfae 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -158,6 +158,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
>  {
>  	vcpu->arch.exception.pending = false;
>  	vcpu->arch.exception.injected = false;
> +	vcpu->arch.exception.is_nested = false;
>  	vcpu->arch.exception_vmexit.pending = false;
>  }

