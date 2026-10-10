Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1428B7EA;
	Sat, 10 Oct 2026 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615150; cv=none; b=JKSItv9ZG3ov3SipbCscjI/mc/SjHRLI9qcDQcNzjjM6idG7x7uqHntWSHmVEdWEHxFmGobDlkpEe+SKmMlapI6hsP+vSTknOF9NpdeLFrhP2WNTbuOgONOSrjsJEWlgw9B61n7Iv3IpAM3YhGqFdoaVEi37b79J2oD4cpej+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615150; c=relaxed/simple;
	bh=Gbi6SFAjCtvXAIgPfIiBdeKs+atE7HsSQwa26RJssGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvBvV0lv5H5bORbZWbUSxvy8vL+9JIreLmI3UVlvPCdwgi1Mji1Ju1wqLmjUXABaf6ytGE3L2HOI9ND4veAxflSraKFUC4AXmT/dacMeZm8Xbjg6is972lWWM66hpeCufRduZj/YWT8B4XOCqXqiRmcADCWwb0+aBDSi18PyTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEKmtWz7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEKmtWz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791615149; x=1823151149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gbi6SFAjCtvXAIgPfIiBdeKs+atE7HsSQwa26RJssGc=;
  b=KEKmtWz7HdVdaQ3JoDOkTRPbOLfxENxwCp5Mr2nRAIovQhTHuADgPPeM
   MTWVlP2g8DOHMldfGwIStSPtU9fYPtrHHrG6R/GFdXaY5pRgGDZDz/swz
   pc87p8Hy0f4QOD98xoEQ1yzKa2f4dInk+PT2J9YQ7+MUVfhPO15QSmigY
   zIQrXhiWhPBpXLH2Nrhx8VwgrfqJQvilOBmYHFTjdHAVpoGZx1TpSqNZI
   B8P1ZS8oTrGzNvBDkD/D81FLKHS8GZD64q6Px2091KqcaigpCLvicX/9d
   V11qrhht2roEmL34xQEHhaJFXT2EYpGkGdEh0pcLr2Y8NKKrP6dAjrAU6
   Q==;
X-CSE-ConnectionGUID: 4wUP0QmORQqN0BXw2tuWiA==
X-CSE-MsgGUID: AefNCr95QXiod8Wt54NfBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="414002"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="414002"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:52:28 -0700
X-CSE-ConnectionGUID: yDVySbpMSaac64jOG9rtiQ==
X-CSE-MsgGUID: P9aXaF++SryqIPqk2Y82BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="574047"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:52:22 -0700
Message-ID: <cf9de0e9-e2e5-415f-a0f3-9613cbbcd5b8@linux.intel.com>
Date: Sat, 10 Oct 2026 14:52:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 21/23] KVM: selftests: Add support for per-VM ucall
 ops on x86
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
 <20261001-tdx-selftests-v15-21-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-21-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add a layer of indirection to x86's ucall infrastructure to allow wiring up
> a different set of {do,get}_ucall() operations for TDX VMs.  TDX can't use
> port I/O (at least, not robustly), as the TDX ABI doesn't allow the guest
> to share arbitrary register state with the host on a PIO exit, and the PIO
> data payload is limited to 4 bytes, i.e. would potentially truncate the
> address of the per-ucall structure.
> 
> No functional change intended, as the ops are still hardwired to the common
> x86 ucall functions.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86/ucall.h |  6 +-----
>  tools/testing/selftests/kvm/lib/x86/ucall.c     | 27 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
> index 0e4950041e3e..3639f03a4da9 100644
> --- a/tools/testing/selftests/kvm/include/x86/ucall.h
> +++ b/tools/testing/selftests/kvm/include/x86/ucall.h
> @@ -2,12 +2,8 @@
>  #ifndef SELFTEST_KVM_UCALL_H
>  #define SELFTEST_KVM_UCALL_H
>  
> -#include "kvm_util.h"
> +#include "linux/kvm.h"

Nit:
#include <linux/kvm.h>

[...]

> +
> +void ucall_arch_do_ucall(gva_t uc)
> +{
> +	return ucall_x86_ops.do_ucall(uc);

return should be dropped.

> +}
> +
> +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +	return ucall_x86_ops.get_ucall(vcpu);
> +}
> 

