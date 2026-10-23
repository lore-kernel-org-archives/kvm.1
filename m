Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735687;
	b=R+C3/hjhdG+cwIIza/kw/H0T9q1xr9h6MO8guJTo0WBytkVwYlSRJNzMa3pFSVf+Eslv
	 8Hb4ASVAvcRuJjht384MLhNLLkqFulM9Gu4akPF3AxpITpPJllgJDn5Zn07PugFmqFwPC
	 JepLFrE8flHtyOw3wKYJ/yHWoa/VvbUh93oP5cF0gy0UqU1yizm9A7F2GEvSYfvkEhK43
	 1oXYdOE0DAyEDPcy8l1yNynwCmsYczEsqTO8NqXn8b/659V7KkSDs9c5NjbQC7jeONYx7
	 gFWPUs4225YzoK8wKL17XJ5RmypPTNY4bNfqzt2JU0LV21U9wfwtfOiG3yGMIyk+bvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PtMbD2L/4lUTkQw591ynv8uNvYteldWADj8nmIYhx9w=;
	b=WqpCeIoIaXTiz0nRu39rGegTHvw/QTruL12TgBvzzJt6fkPnka0YcO5BI83Unqqex2s4
	 kT7m7dCsVgF4MSVB8qCjEJiMi+RRNKZjBzn2qrK+LNin3QpUYJAwQ2kZXTkurV5UnX3n9
	 4FvAawNhKvYx6ZyfkQPiUiNI84/gVVTLZcLRXVoOSFDxGbr9ZkhJWaqiWAWAQXVlVZMZv
	 N19YN1o/adbpFYIhxNbIkJ+9e8aB9EpTr7Yg75EHQyw1L0n+aC3PPnDTsC3wQxo7aog4L
	 hoc8G8gHDgiH6LJqZuyi9R1gjyW1FZ5IB9jPZjfYwMJvkA/ziTDwgKGjcjuQhl8R0rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SEaClo2N;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381E606A31A;
	Fri, 23 Oct 2026 06:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0381E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SEaClo2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792735687; x=1824271687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C81i/82DeDeE1JH62JhWsNHM4gE4jeuRndx5t5ttChs=;
  b=SEaClo2NQIaW06zL7l6Ya5IrE7Ai8AZpeFMVRq0rjHIT1S6X2OcfpBPd
   ZtdBbR77y2CKjeIYDoCYfneZfHlNHqFXktnYsIFNiwHBRHZdeBBjEMfCG
   Z4UctXPEFHu0OOQGlbiniJOvrzP2RLrqn4IKMNh1ynQYdK0zEkdwh7dh4
   8EZJUQU2Oe1NZTrCKnOlrdQ6OYalJNmrEadieNq0KazHMTto5vFPmyrVY
   l7PcWlfLA0YG/v6Pt2eBGByEDDYuiymX7ujlJUTlBbpC1xxJUNT9orWDD
   kizjXrI7MK+UsVKFdrW/4dEQyTFCYu/GNWc/fTo1hX6ZEUB2z8SbX1Lt9
   Q==;
X-CSE-ConnectionGUID: 5ki/el3GTWujjChBfZlZPQ==
X-CSE-MsgGUID: p52PFYlJTeeBE4OLLNMrpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1599103"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1599103"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:08:06 -0700
X-CSE-ConnectionGUID: jbxrQI+LQeyEO93z/LGx9g==
X-CSE-MsgGUID: oty+PjFtR7aIMb5gzI1E2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3592890"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:08:00 -0700
Message-ID: <64e27c4c-23e1-4539-a812-e81d5f322003@linux.intel.com>
Date: Fri, 23 Oct 2026 14:07:57 +0800
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
Subject: Re: [PATCH v10 05/28] x86/cea: Use array indexing to simplify
 exception stack access
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
 <20260911213659.2025974-6-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Refactor struct cea_exception_stacks to leverage array indexing for
> exception stack access, improving code clarity and eliminating the
> need for the ESTACKS_MEMBERS() macro.
> 
> Convert __this_cpu_ist_{bottom,top}_va() from macros to functions,
> allowing removal of the now-obsolete CEA_ESTACK_BOT and CEA_ESTACK_TOP
> macros.
> 
> Also drop CEA_ESTACK_SIZE, which just duplicated EXCEPTION_STKSZ.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]>  
> +/*
> + * The exception stack ordering in [cea_]exception_stacks
> + */
> +enum exception_stack_ordering {
> +	ESTACK_DF,
> +	ESTACK_NMI,
> +	ESTACK_DB,
> +	ESTACK_MCE,
> +	ESTACK_VC,
> +	ESTACK_VC2,
> +	N_EXCEPTION_STACKS
> +};
> +
>  /* Macro to enforce the same ordering and stack sizes */

Nit:
Is this still hold ? ...

>  #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
>  	char	ESTACK_DF_stack_guard[guardsize];		\
> @@ -39,37 +52,22 @@ struct exception_stacks {
>  
>  /* The effective cpu entry area mapping with guard pages. */
>  struct cea_exception_stacks {
> -	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
> +	struct {
> +		char stack_guard[PAGE_SIZE];
> +		char stack[EXCEPTION_STKSZ];
> +	} event_stacks[N_EXCEPTION_STACKS];
> +	char IST_top_guard[PAGE_SIZE];

... Before this change, ESTACKS_MEMBERS() is used both in exception_stacks and
cea_exception_stacks, so ESTACKS_MEMBERS() can enforce the order and stack
sizes.

After the change, ESTACKS_MEMBERS() only used in one place, so it doesn't have
the capability to enforce them.

The order consistency depends on the consistency b/t ESTACKS_MEMBERS and
enum exception_stack_ordering now.

>  };

[...]
