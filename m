Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858829ACCD;
	Fri,  3 Jul 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048529; cv=none; b=rf67uhLHsgbKFDT6MnV4bcBfh/jmhOuvNG5Lq+QEeLDGRgbLsrH4IAhdzajEp8ROhIqw8UtjW6Lzo+rqFYr6m7rqTdZUdkS2R0BWqQmd7Dj5fKUTQm+GPzRhu/b9ostblRjHau9Sq/7rx/+zt6q574Rfbcb3zFhOMXcudBQRGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048529; c=relaxed/simple;
	bh=DPdyY/KryuIpPeuNVxGFguCV74/1D7Y9l2tLvmguTak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZwHhtSBb8GVfDSrm3uSAfPUGKi9JWYWJlAyeI4ePukLr9MfRXY2qIR2aiLZ0hW9UCZI48ppqC5IuzQe5PxAz1uI+nuTbnGGDfjbAV8GW1HbBUH+8eqJrvcpXypyvXq5xd8+BMq+PRrWbpBGTJ+aQjNFgMSlTOwOcRXlLh99QpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTiLGBXy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTiLGBXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783048527; x=1814584527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DPdyY/KryuIpPeuNVxGFguCV74/1D7Y9l2tLvmguTak=;
  b=WTiLGBXyJeBO8n/vMg4hDT1vnv4flxJDQjMKGkQaghDPXxlbjPjhhu8C
   HDGnCChzXasIh9VJ3t1jOq1k5b+AAHSed8UQZMgFQ5IhxMJ3qYhLx0plv
   03hzBUDXuSleL1yyINAw9N33rNq2A2qaePggllLAvLIovgIPWPMo0w2D0
   eNTaVy/ObrzIOaeToELn2mi8+Gi5/ljWBeUtOyDG8Tq+2AnnZ3rg7Ff6E
   yj0I4h17Q48yGXcu4kF1gQrxC73m8FInYyP+ILE2M5aqLOU8ReTL6bSeY
   eIaZ+waILSqmqu3e5BUu7ORB8ZIws028fjlYtYTQwmu1ide7jEhKRmOlS
   w==;
X-CSE-ConnectionGUID: yWwqsSy1SI+4Fe9wZE94CA==
X-CSE-MsgGUID: LIUXqcMpSpymRPbcpv+SPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95305539"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="95305539"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 20:15:26 -0700
X-CSE-ConnectionGUID: /rT9kzZTT3Gx0X0l2GtdaA==
X-CSE-MsgGUID: f9fXgfZhQN2X2obLEbYXQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="246629285"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 20:15:22 -0700
Message-ID: <0c31fcdc-048c-4ff2-9e89-1ba112815c84@linux.intel.com>
Date: Fri, 3 Jul 2026 11:15:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com,
 pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-10-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260526023515.288829-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 10:35 AM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
> adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
> removing guest memory (PAGE.REMOVE).
> 
> To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
> TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
> the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
> only supports creating _new_ mappings in page (pre)fault paths, all of
> which require an active vCPU.
> 
> The PAMT memory holds metadata for TDX-protected memory. With Dynamic
> PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
> with a few pages that cover 2M of host physical memory.
> 
> Releases are balanced via tdx_pamt_put(): every control-page free goes
> through tdx_free_control_page(), and guest data pages are put directly on
> the successful tdh_mem_page_remove() path and in the
> tdx_mem_page_add/aug() error path.
> 
> Assisted-by: Sashiko:claude-opus-4-6 GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

> @@ -1669,16 +1683,29 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
>  static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
>  				     enum pg_level level, u64 new_spte)
>  {
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> +	struct vcpu_tdx *tdx = to_tdx(vcpu);

Nit:
Is it better to move this after checking vcpu is not NULL?
Although tdx is not dereferenced in between, if vcpu is NULL,
it means container_of() does arithmetic to a NULL pointer.


>  	gpa_t gpa = gfn_to_gpa(gfn);
>  	u64 err, entry, level_state;
>  	struct page *sept_pt;
> +	int ret;
> +
> +	if (KVM_BUG_ON(!vcpu, kvm))
> +		return -EIO;
>  
>  	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
>  	if (!sept_pt)
>  		return -EIO;
>  
> +	ret = tdx_pamt_get(page_to_pfn(sept_pt), &tdx->pamt_cache);
> +	if (ret)
> +		return ret;
> +
>  	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
>  			       &entry, &level_state);
> +	if (err)
> +		tdx_pamt_put(page_to_pfn(sept_pt));
> +
>  	if (unlikely(tdx_operand_busy(err)))
>  		return -EBUSY;
>  
> @@ -1691,8 +1718,14 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
>  static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level level,
>  				  u64 new_spte)
>  {
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);

Ditto 

>  	kvm_pfn_t pfn = spte_to_pfn(new_spte);
> +	struct vcpu_tdx *tdx = to_tdx(vcpu);
> +	int ret;
> +
> +	if (KVM_BUG_ON(!vcpu, kvm))
> +		return -EIO;
>  
[...]
