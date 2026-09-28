Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A0399007;
	Mon, 28 Sep 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626235; cv=none; b=sNmW7Df9GySXD2AiQ5aJXa3x/mIt4hjAkUEzt9JZrYR2czK+3bJIdmSWnsUb4UHOCL0axbWyz+OPUNbDwAWMA9sQGNZ/Oj3xnIeIIcocpm9txsfaQ6FXL3NPJQGdmbJvDAtEcDHeMQPWMBJX0IlQMm1607Y17cVk8BZgwfWxG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626235; c=relaxed/simple;
	bh=ClzI61/dFegTk2b9eXbAJM4SOfyG7+1VGzXQIbfnW4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEdSdoztL8xvyaul/Bsm6USxaRNn9IqB0CuuUTHIKVT4CBB5IFK20pFhcsNKSthdFQBzHKD0Z39CcG0QW+BEs7Vt7+yQtPKcbJnH7lH85HfM2lWy9wZ7jwgIqtTw7T03EYUmEFUH5LfxMukZ1d15yWjivxiRzSSlg+wFEYAuwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7VF6FTk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7VF6FTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790626227; x=1822162227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ClzI61/dFegTk2b9eXbAJM4SOfyG7+1VGzXQIbfnW4Q=;
  b=Q7VF6FTk8wy12Rp09ap69clB/6AgjCwtC84WDvgB4HHd7Vi1olCRmxqf
   frYPi/kKxjT9mtGMN1LPhEHJH5bSsI8/cHMJkRMqomqUqaa83kDxd08DV
   /WcNWHEg2e0SlVwZfWEiQ6T7jXa6zHGJ7E5WJ2kYp8poVWPpEwoLC1uGF
   sDFbvfLIlqTrV3yQL3mWTG5VUuh6Tpo6bQPg7xsCj5kEinDKIl1KXvnvC
   H3TV2uiwN/Wf8/q/xteXWLF8SW4DV7rqjnlkcXVcK0ObNHVQGSev8hdWP
   jg4e67TVkc42AvbMBBU3ggV+shCe5+3HSQDkBWM9LTS15Ex/VUGIOBa/j
   Q==;
X-CSE-ConnectionGUID: EYazKDdOSLOQZwdzWauDWA==
X-CSE-MsgGUID: aG0aX3MSQm6qvI3yYbnjiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90463258"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90463258"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:10:22 -0700
X-CSE-ConnectionGUID: pKauvFHHSxSalIyRGMdtnA==
X-CSE-MsgGUID: gEXQ2ZmrRl2HxQVIQitUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274690164"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:10:22 -0700
Message-ID: <04403c0e-423a-4929-9652-fac9e307a47e@linux.intel.com>
Date: Mon, 28 Sep 2026 13:10:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] x86/tdx: Take the Quote buffer as a generic
 pointer
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-2-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928100913.2265687-2-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 3:08 AM, Peter Fang wrote:
> tdx_hcall_get_quote() takes a "u8 *" buffer unnecessarily. It is never
> used as such, since only the buffer's memory address matters. Let the
> guest driver give the buffer a type internally and just accept it as a
> "void *" instead.
> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> v5:
>  - New patch. Prepare for a typed Quote buffer. [Dave]
> ---
>  arch/x86/coco/tdx/tdx.c    | 2 +-
>  arch/x86/include/asm/tdx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index f904a636d449..bcaf4180a8db 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -191,7 +191,7 @@ EXPORT_SYMBOL_GPL(tdx_mcall_extend_rtmr);
>   *
>   * Return 0 on success or error code on failure.
>   */
> -u64 tdx_hcall_get_quote(u8 *buf, size_t size)
> +u64 tdx_hcall_get_quote(void *buf, size_t size)
>  {
>  	/* Since buf is a shared memory, set the shared (decrypted) bits */
>  	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 89e97d5761d8..a3c37d61e676 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -81,7 +81,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
>  
>  int tdx_mcall_extend_rtmr(u8 index, u8 *data);
>  
> -u64 tdx_hcall_get_quote(u8 *buf, size_t size);
> +u64 tdx_hcall_get_quote(void *buf, size_t size);
>  
>  void __init tdx_dump_attributes(u64 td_attr);
>  void __init tdx_dump_td_ctls(u64 td_ctls);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

