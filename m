Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E84E2F08;
	Fri,  9 Oct 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560706; cv=none; b=tqzWRDxrF0eWrNuou3QlhOP4eM9SHtEi8HsZe3vwrjBXL2WYc7wZyuGB9iQD4MwDN3rb9A1QSL/9q7+w12kms4ziaH+WWd4JVefT2LmhRGKHzHnwdwrq5TTftX1PpuP7DgroiblX9ZVZrdOu2fdEiG3OQvSaZHmcbf51G9Uril8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560706; c=relaxed/simple;
	bh=fip7VI4RxW9/THSoP5eEW65d5uAQ6PqFRVmadq9QyHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZFq8mJ1Hen75zExY2vka4MEUlBWQ6CEfkNHWpIF8+DcNyY3Yx9KzQT1sBw+hp8dq3CWEikLAkaoVSVlwAPBaytLk2bngZm/hW8+pOMpmf0JZBO3nMw54Kr3/AJnDQi/dfjnokNmTGddDCN3QMFpQ4J348LsuEFOJgD254P4qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeaELG5H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeaELG5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791560704; x=1823096704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fip7VI4RxW9/THSoP5eEW65d5uAQ6PqFRVmadq9QyHw=;
  b=LeaELG5HqD5C45GTEwIGUeKa7tdiq/7beayme/OjPhdpYjT5ZpI3OTyM
   itDqdMPkUyTCnhG9tpU+LzKfz47vbwVUTGk2ioyyiRJ5J4zAe+N8X+rie
   X3fW9qsaWL6TyduI8SazMY85WLjdO2pSCXSDmVHtUlk/M7ZxgaRK2bDs2
   TpgB90jN4GuZh2jMT9xl/hdpADthMRAzvtSeOwdBmZy+vsr7uwWFEI3nL
   6VTVNNuc3vi3oXK8d0zNOa9VULA2jlJzoTn6fWkUlAVL4YMycnBsmi5W8
   D0zEViE8+bYhb2d4RbV240yR+o5Dh89Fg62/TDHE40aIviFYOhFKwluti
   A==;
X-CSE-ConnectionGUID: oG0CQMdNS8+yJpRqHCQFGw==
X-CSE-MsgGUID: +EBQLUsASO2hViRPV+7+VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="388998"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="388998"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:45:03 -0700
X-CSE-ConnectionGUID: smsCV1cITQ6LLOV8QsS1Jg==
X-CSE-MsgGUID: W+Z4XyD8SM+BeJqhZDz0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="461742"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:44:57 -0700
Message-ID: <7ca516ea-a931-4497-b3c8-b62110ae006a@intel.com>
Date: Fri, 9 Oct 2026 23:44:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/23] KVM: selftests: Set shared attributes for ucall
 guest_memfd pages
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-11-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-11-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> The default attributes for guest_memfd pages without in-place conversion
> is private. 

This is wrong. The default memory attribute is of a @gfn is shared without
in-place conversion, i.e., with per-vm memory attribute.

We don't need this patch actually. And I have tested with reverting this patch,
with both out of place conversion and in-place conversion. Both worked.

> However, the ucall pages need to be shared between the host
> and the guest. Thus, set them as shared.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/ucall_common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
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

