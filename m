Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5146347C6;
	Wed, 17 Jun 2026 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665479; cv=none; b=VkXeKTn5yfPsYPG/j+tHZxl9bXiVemCSh9FGBBFFBv9dlkDjbQjSbh9Owni2YOENZkS8WnVzVbxDgRAkK513RI8QwW3Ec1juhkcZ1Pogf5AMH4Mi0DYm0DwKOrH1GXGDN7tvq2o/v0UqjCp2Yh2K8JXknJIurECtthEqhqpwZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665479; c=relaxed/simple;
	bh=H4ydynFSsshwEIH3dpamwI/BxsImmPBYTlJKbEbi59M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4FLx+qcTYZmEgKXfwzY2P4OpFb9amkExq7YEqp4wZYrTp2bVEVRMKod9xoOvF7Fr8aZe5DcZNihUY3Da+uDm/kk57VM1rwzuuQYzuVKqaa8hyUUS6m9LLrZH3vnhWBAu+kZfWz3OSxIQ8ZhV2tQrvF90kJPHiIVdANNTS0f1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWZWcSAf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWZWcSAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781665477; x=1813201477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H4ydynFSsshwEIH3dpamwI/BxsImmPBYTlJKbEbi59M=;
  b=EWZWcSAfm+rhUEIRxjKghX9cE80rcbMGPvZgUbdUOIRFtIIkWvhPowYm
   +iABLYNIhDczCKrLgM01QcRHo4MLkI1hoh7+KvvsXaiFu2DgQJv5jtRc3
   cTBSPUzoltrdYiaHlR/HzM7rY0gRdzjjPD3cPAkBXWobT+ii+1D1m1RzN
   ybe87YR0ZRwutNU6TAj3avIMiOsTXQRo2HVlLBySJ+LUd/BATk+vpEZ95
   vaXsq3k2uedvaSayHuMYrhCubgJ0W8bTXFJCpd9M3SHkrY4N86ZTlozHf
   oIFNOXKShoUA8IAKv+S4J1rvvvqhTFq7q2E4v563oTN0ALdd739Kj5UC+
   w==;
X-CSE-ConnectionGUID: D+IiCuJSSxG20KCdZq1yVw==
X-CSE-MsgGUID: Z1nhfbaSSLyCWFFmW3dYBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82648265"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82648265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:04:37 -0700
X-CSE-ConnectionGUID: oY7QmKPpR3SM1762toGLGw==
X-CSE-MsgGUID: cSQoqFtsS3aFRa1zAs5RhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243567773"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:04:29 -0700
Message-ID: <a92a8101-469c-48ab-8425-0302da3d735c@intel.com>
Date: Wed, 17 Jun 2026 11:04:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/22] KVM: selftests: Add macros to simplify creating
 VM shapes for non-default types
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-1-6983ae4c3a4d@google.com>
 <e0b99e9a-c20f-4def-ac4b-0070996c10ef@intel.com>
 <ajF-9isiWxPyzxci@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ajF-9isiWxPyzxci@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2026 12:51 AM, Sean Christopherson wrote:
> From: Sean Christopherson<seanjc@google.com>
> Date: Tue, 28 Oct 2025 21:20:27 +0000
> Subject: [PATCH] KVM: selftests: Add macros to simplify creating VM shapes for
>   non-default types
> 
> Add VM_TYPE() and __VM_SHAPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
> 
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
> 
> Opportunistically move the existing VM_SHAPE() (now __VM_SHAPE()) macro
> below the definitions of VM_MODE_DEFAULT so that all of the SHAPE/TYPE
> macros are bundled together.
> 
> No functional change intended.
> 
> Reviewed-by: Binbin Wu<binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> Signed-off-by: Sean Christopherson<seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

some nits below

> ---
>   .../testing/selftests/kvm/include/kvm_util.h  | 28 +++++++------
>   .../selftests/kvm/include/x86/processor.h     |  4 ++
>   tools/testing/selftests/kvm/include/x86/sev.h |  2 -
>   tools/testing/selftests/kvm/lib/x86/sev.c     | 16 --------
>   .../selftests/kvm/x86/sev_smoke_test.c        | 40 +++++++++----------
>   5 files changed, 40 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index dc70c6da63fa..46bae183d7fc 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -221,18 +221,6 @@ struct vm_shape {
>   
>   kvm_static_assert(sizeof(struct vm_shape) == sizeof(u64));
>   
> -#define VM_TYPE_DEFAULT			0
> -
> -#define VM_SHAPE(__mode)			\
> -({						\
> -	struct vm_shape shape = {		\
> -		.mode = (__mode),		\
> -		.type = VM_TYPE_DEFAULT		\
> -	};					\
> -						\
> -	shape;					\
> -})
> -
>   extern enum vm_guest_mode vm_mode_default;
>   
>   #if defined(__aarch64__)
> @@ -270,8 +258,24 @@ extern enum vm_guest_mode vm_mode_default;
>   
>   #endif
>   
> +#define VM_TYPE_DEFAULT			0
> +
> +#define __VM_SHAPE(__mode, __type)			\

inconsistent indentation with below lines.

> +({						\
> +	struct vm_shape shape = {		\
> +		.mode = (__mode),		\
> +		.type = (__type),		\
> +	};					\
> +						\
> +	shape;					\
> +})
> +
> +

one extra new line.

> +#define VM_SHAPE(__mode)	__VM_SHAPE(__mode, VM_TYPE_DEFAULT)
>   #define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
>   
> +#define VM_TYPE(__type)		__VM_SHAPE(VM_MODE_DEFAULT, __type)
> +
>   #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
>   #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)

