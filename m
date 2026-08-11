Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E13FB055;
	Tue, 11 Aug 2026 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434223; cv=none; b=gmyi+rl2eqBJEhJk8AUnpjxPR7Ysw/u4QRLxbMgkn0y4VL/bIk26jFk2K5+H2HTYe8Sm2oW2qXkFkNq9rq+VZKTDCutbLUZ7UD8bmhtp6N11RYb/V0bCCV0ynUxb78ghAZL6OJfrowESZ+DykSaxZOi9dHo/Ztmh1h3M/SXIKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434223; c=relaxed/simple;
	bh=eyAG6Jmsv9SrSGFS/sxLFSdUlwwtvd30wm4wtCIQRnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi+7zMkKbNVSJwKnI41Tav2q0nu45AvVfovesQmAgfvmk0oeVzkrlJYFtcy7ZSszuDBVoWzCB4LSaK4xNck2sU/PFIPQBpJXEogfW9hlFXo1zXpfUZR7BoOu++wIVTL/xpcuD0gWxJIOwrlCMoehRk22/O9AIrB+spBDhHLrRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht8P1SBq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht8P1SBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786434221; x=1817970221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eyAG6Jmsv9SrSGFS/sxLFSdUlwwtvd30wm4wtCIQRnY=;
  b=Ht8P1SBqAdw9yemATyt+o3c/W6TOj2ZnnHi72oNhy+TvWeSDQM0CNH53
   RoKPcf3ULiZLeHZD0FSQXxPy8DyhQGpEyEowSjxKefEcc0HiG6QYD6qgD
   7LYXz4S7PaG94KIZjB1uRkVk4yH/5zcbTPiAyxjC8mmIdjNvkyFtV5u0H
   M9637Ag3FxlU/uq/mRy68ATDYSUVbhpNtW/29f9P3B+sLUgY0CEtT+2tL
   9+d8C4A96a0tNREMulEDu6HCWr06JfTsg1CKuyxnFC2IO+wi7eSpdsQoF
   JoTQ7c7wcQpFRKT6krxG2cWtLCROutWytuQTvpddcbfjibzkwWcmfmv+j
   w==;
X-CSE-ConnectionGUID: zD/GVcvXSDKczzgM2QYWYw==
X-CSE-MsgGUID: cfHlDrSxTP62+4JgFJkUUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86719633"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86719633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:43:41 -0700
X-CSE-ConnectionGUID: wNlDlRZARwiYdikmBanWjA==
X-CSE-MsgGUID: utH7HKWvSh2JspRfIAjlrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="293207295"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:43:35 -0700
Message-ID: <12ab0d52-b432-4c16-979e-2198a34e8d65@linux.intel.com>
Date: Tue, 11 Aug 2026 15:43:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/22] KVM: selftests: Require guest_memfd for TDX VMs
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-12-15ad654a50db@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-12-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> Force guest_memfd for TDX VMs.
> 
> KVM supports guest_memfd for TDX private memory. Without in-place
> conversion supports, all pages default attributes are private. Thus,
> set page to "shared" for shared pages.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 2 +-
>  tools/testing/selftests/kvm/lib/ucall_common.c | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0b9d2d383bfa..4a48c4b42095 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -472,7 +472,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
>  static bool is_guest_memfd_required(struct vm_shape shape)
>  {
>  #ifdef __x86_64__
> -	return shape.type == KVM_X86_SNP_VM;
> +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);

Nit:
The parentheses can be dropped.

>  #else
>  	return false;
>  #endif
> diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
> index 029ce21f9f2f..c03dfc763172 100644
> --- a/tools/testing/selftests/kvm/lib/ucall_common.c
> +++ b/tools/testing/selftests/kvm/lib/ucall_common.c
> @@ -27,6 +27,7 @@ static struct ucall_header *ucall_pool;
>  
>  void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>  {
> +	struct userspace_mem_region *region;
>  	struct ucall_header *hdr;
>  	struct ucall *uc;
>  	gva_t gva;
> @@ -37,6 +38,13 @@ void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>  	hdr = (struct ucall_header *)addr_gva2hva(vm, gva);
>  	memset(hdr, 0, sizeof(*hdr));
>  
> +	region = vm_get_mem_region(vm, MEM_REGION_DATA);
> +	if (region->region.flags & KVM_MEM_GUEST_MEMFD) {
> +		size_t aligned_sz = align_up(sizeof(*hdr), vm->page_size);
> +
> +		vm_mem_set_shared(vm, addr_gva2gpa(vm, gva), aligned_sz);
> +	}
> +
>  	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>  		uc = &hdr->ucalls[i];
>  		uc->hva = uc;
> 

