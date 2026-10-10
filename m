Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BB3BC68A;
	Sat, 10 Oct 2026 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600428; cv=none; b=sMO3CJ/FYYhi3LrNEH+LNo/2Aw4pKCloln+hBDJRhmioDipz+B0odnL48E1Ky1F+ZzPgA51xFU+dGcmQO7+qRX+BXTD/tmG+587DHIk+PCMsJlHQR6zKPron82jdu8k+gTFcHNowDddzXFIahNFcSQZ00vG6ru6k/3U5VBq8d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600428; c=relaxed/simple;
	bh=TwvxuliLdqh6Kvf8xBvOYb5mrkLELcwTdcUa6mDjPbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQQuq4FmEj8nEcSUXAhJ8oolVvawrfr3EyluHjdJdiUw+EHnKCJO3m2IwppPa4VZu54SaORLss5NObro7WeUD2RHAf+Y0vX5W0kpjMPMXZRQ8jiTrcW3PttoPyK2a49ByFsOX7cg03kZDunJvLPoQRA5+pYAurN6ZGu5hWGd/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFslxJwc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFslxJwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791600426; x=1823136426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TwvxuliLdqh6Kvf8xBvOYb5mrkLELcwTdcUa6mDjPbo=;
  b=NFslxJwcFLYTcY5nJ4lNzMAeUuZOtnaFtVpnYo5Qco50v7ywDXPgPI/5
   tLI+XNc/bEw+/FQJ++oGr9mLOhU2Z+x8tsnjmSuGbkfFgJ2Qmd1DR15zN
   YwqUqqkzTvQMjsdahAEcYa/iE9nwKgolmC1xiHazGwVRB4pA7mKHME1Xv
   sMhnhhBv/oadlZhZUZ4mPNBTGI1dZwDHOa1KT6406xB6xDdP1WHFFvg+3
   DskpvK4qIJN3JiYzWu4IIcbD6J0U4tNV/3qfn8FGMeyCj4G2rXRXNPdg7
   Ym0SFoH8XzTfrYd33YcGZ1VFR1xBMdQTh7O/3Z71DMnv8i5N9iZsf5a7q
   A==;
X-CSE-ConnectionGUID: ++oJL6JqQjiY2q5ab39iyg==
X-CSE-MsgGUID: yXk+FAHBSrKC7Xu14T01XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="406743"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="406743"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:47:05 -0700
X-CSE-ConnectionGUID: B8KXmx6rTC6C1JQxgMBDDw==
X-CSE-MsgGUID: 0oFwvbnTT4mKrLi7+6ZRNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="792483"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 19:46:59 -0700
Message-ID: <a1fc92af-b2f4-4fe4-b113-0b206fb728b7@linux.intel.com>
Date: Sat, 10 Oct 2026 10:46:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/23] KVM: selftests: Set up TDX boot parameters
 region
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

One nit below and the issue pointed by the sashiko.

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

[...]

> +void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
> +{
> +	size_t boot_params_size = sizeof(struct td_boot_parameters) +
> +		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
> +	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> +	const u64 gmem_flags = 0;
> +	gpa_t gpa;
> +
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
> +		   TD_BOOT_PARAMETERS_SLOT, npages,
> +		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +	gpa = vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_SLOT);
> +	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc\n");

Nit: the tailing newline can be dropped.

> +
> +	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
> +}
> +
