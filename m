Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06290322B8C;
	Wed, 24 Jun 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317259; cv=none; b=dHmoQ0lf9RdyWFBGg077zdVTzDQ9D7KpC63M68NSaYr06+1Ij680dQo0b444zf36ucQAURaERcu/QIR0FwOFnU9OKDI4AhjW5zlmVWnPuXVXf6aqwKvpMJyp5rM/vkf8MUTiw6Ta0F+ySAglGQcq4W9tsD5w4Fe9NYrth+fbCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317259; c=relaxed/simple;
	bh=11GcyBMUEaMVpP2tNUELZmobxFuiGR8sDyQRMOunA+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBLV6BJK60LbofK/zQ5QMQc+lwWD2TIFNmwpBdvhEEvVdBVyzLgWaXcyO6Ulgk7j25NcdBzU5WQN/v9KA3EjP/0LDgyfYbPQwIga50dxlCGz4VtwcbYMg4WvvCR5bXJLkQJQ5abyAISvSbTHvm043epdzKjISioXZRKSToehQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN4FsWHK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN4FsWHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782317258; x=1813853258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=11GcyBMUEaMVpP2tNUELZmobxFuiGR8sDyQRMOunA+o=;
  b=EN4FsWHKVsCZQXYPNFFkfbqQSZw1Nwm/eq944zGJA9Jp2p4cHumkzN9U
   6sx+ANQJBOlXGE+7z+HXYsrtUxvwDmVz4W8WtpfAK2nwGljl/ScO+jWdV
   HdFPbjed+7eej2cQteWA34SJoBOuk6QP1kf19q0uyyLyo7r5ALxilWNDH
   ubv9SOArhyasN0QsEEpqMLoc+EV+cdsKwFswTBV8wiHxG+w4KIU1rwKvs
   SQ6eLAEneeIJOWfpDpFCNtuzW6jKT9+uGMB8uifafWDmO0HnADIyWTbzk
   51t6BwpRGx+rpS6R7OYIMCe54CDX/8eadfebMAFLAQ6Jr3cW/ggE5udgH
   Q==;
X-CSE-ConnectionGUID: 4WW/3JLzTmKHu90a6Dj8iw==
X-CSE-MsgGUID: w4WLlCa5RAu7Smk/AHS7/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94480817"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="94480817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 09:07:37 -0700
X-CSE-ConnectionGUID: vXFfLJdiQz++37OKCSPH3A==
X-CSE-MsgGUID: IkydLMwlSeGusOq1cDIDaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="250073156"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 09:07:31 -0700
Message-ID: <03aea6bd-4747-4583-b072-5b5b4a825123@intel.com>
Date: Thu, 25 Jun 2026 00:07:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/22] KVM: selftests: Set up TDX boot parameters
 region
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
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
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-11-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-11-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	u32 cr4;
> +
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXVYY_4K);

Why TDX needs to check it explicitly?

x86's virt_arch_pgd_alloc() already has such assertation. I think we can 
just drop it.
