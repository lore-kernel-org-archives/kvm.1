Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97A3859CE;
	Mon,  8 Jun 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903398; cv=none; b=AKg9cJ75tVnAhVmUDaxoM7UGhm17Cfxo3xPfzPzwTPnMaBfiFsR+UIwFjWtvjJy/8/DvAHBFDt06CDxFAZ+JvsUvr6MhdNjzJ/28gdR2PNRcB7VDgb8Ce5pEBZuiHVAv1c1dPyK9zZFGLfPDL4Zf1rcurmns8D2BckvxhoZ1lFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903398; c=relaxed/simple;
	bh=C5Te/2htTWSeWTIybL+XiLOsacJn/MAyORmkF0yYaWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQks3qoy71s/KlxR0J3fzo+xELNlapt06EjwyjRNkPUrsETmNm3bxnt5HWffnvklUD1PADTMYRI55IUpu54yniEISVi4hnOZEQzTAikPqWXR/BcnOWGb6j0pa6Pxs8CFQQdQxfqZoH3qnWN3q0cIlPPpkljF22d2lev2eWTH9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRV3jkLM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRV3jkLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780903397; x=1812439397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C5Te/2htTWSeWTIybL+XiLOsacJn/MAyORmkF0yYaWI=;
  b=CRV3jkLMAi083ixozN2f3dz+s6oHe8S1BqpI8RroiPx2TwvVASW8qB6d
   pkc8w5xkkIhlBCfSCSVT9/5B3wYgT+58EmGgTmCySO6PLdpWPhyxvsHXt
   2kW5mPBWNI7Lhk0WHNH/rQQIha5tFVjeDs+WGYMKbRjw5toQc5CAY+lPy
   H4/x1BultvK8IKM2Pcf+uGr4XhWJAB8fWNkxcIoD5qKNbYYpPgjtDXe1g
   PnDk39sevA7OsVIKFoYgFf806jfyXsehyNQIJ038+Fw5pP66l6bgX6ttg
   LfhdH8zY37/kLvmj4iFkLF8ilY0hlm1o4skF84cCLToB93ILeFO+aCGrb
   Q==;
X-CSE-ConnectionGUID: X7uGOWutQX6CzV8+60roUQ==
X-CSE-MsgGUID: ODEr7E7XTOuWaBl6mpCA+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="84206178"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="84206178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:23:16 -0700
X-CSE-ConnectionGUID: 5SrVRyPbRK2KdUQcbNJP0g==
X-CSE-MsgGUID: UPleJuXdRDas6zednTjEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="242494266"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:23:09 -0700
Message-ID: <ef2bb2ee-e076-47e7-8266-11c517957440@linux.intel.com>
Date: Mon, 8 Jun 2026 15:23:07 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/22] KVM: selftests: Set up TDX boot parameters
 region
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-11-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-11-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
[...]> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	u32 cr4;
> +
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXVYY_4K);
> +
> +	cr4 = kvm_get_default_cr4();
> +	if (vm->mmu.pgtable_levels == 5)
> +		cr4 |= X86_CR4_LA57;

This should be removed after the 5-level paging code is added back in
kvm_get_default_cr4().


