Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523243933D;
	Fri, 14 Aug 2026 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695057; cv=none; b=oyUXpnsd1yf+JqW1l2/9ueWSUbUrNcbcQvTxBGTBPStFJJXyvvxXfmVpSqUeRgDSw1mlbfmxDgiHZmZ73Lsx6cXmB4OJhsSfoehvYemEH6dVT9c3bkfzjohDOOPbVykC9o/OXyWl3lfj7nwgDBVa8+Rc2zYe/6yFjGWoLbKKqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695057; c=relaxed/simple;
	bh=TCo4oSBCLYQ9tZ2Jg7BbfO8LlZ51oESg/QABBLpe7q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg/AwaiL1BXL3jegur2tq4AR2hAlllJ6iGMgMhnuehAnTEwqp5OGMoqDhKJvqA90UMeFujub2GrISUwo92hm84VYjRIy3ZiWVHlTPINa89oKarmKqP9wydqGvxIDx9pz9g+5Cm8CulMz3UcnS1AtbQiFuPDSXvktcCqAXKmSsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDHbPUSO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDHbPUSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786695055; x=1818231055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TCo4oSBCLYQ9tZ2Jg7BbfO8LlZ51oESg/QABBLpe7q4=;
  b=SDHbPUSO9xWzkt6TfejIxuuIPdrvHsnphH+El4OqTX/XQUUDe0WJK26p
   15SQlfuyteh8/lnlg2Q97GjNzGKgldN4cbDI+YrT+I75SzgmQFG6M0U6u
   /p+tv6yw269NztOkOdN30wL1ByOptUes3DTr3L3Ouwwz0sl7o4jxpDhPl
   HQQpCawI045P1cmqN/AJ56IDtjVW7EH5cfpttJMADw9ROWxtQnYBGgtIl
   XvBTTO+dAGSqZYtFak2de3cOdejibvc/TZIm2mlXZEuXT/gUyb7Eg/+Np
   crJbcPgi9KMxks5pKyMk4CkmKeigE029XoN8i9tLxpPOOvZjVX3x6ymVC
   Q==;
X-CSE-ConnectionGUID: eDfI+JJXSPu/jiQ/70mb4A==
X-CSE-MsgGUID: WmOjo6ZaTYe1GYK3JqTHuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87296788"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87296788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:10:53 -0700
X-CSE-ConnectionGUID: bmW3pYeoTT6o7eRHfs86Jg==
X-CSE-MsgGUID: TO7aI/dkQZ6jLYNEMqqdLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="263719606"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:10:48 -0700
Message-ID: <693b060b-accf-462b-a069-245e05ff6283@intel.com>
Date: Fri, 14 Aug 2026 16:10:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/22] KVM: selftests: Expose function to allocate
 vCPU stack
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-14-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-14-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Introduce kvm_allocate_vcpu_stack() to allocate a vCPU's stack
> in preparation for TDX to allocate a vCPU's stack and initialize
> its stack pointer.
> 
> TDX VMs' registers are protected state and cannot be initialized
> using the KVM_SET_REGS ioctl() that is used for normal VMs. A TDX
> vCPU's stack address will be a property of the TDX specific boot code
> that initializes the vCPUs' stack pointers at boot.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

