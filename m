Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64794478869;
	Fri,  9 Oct 2026 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531536; cv=none; b=Aj1b/1pw3E+Nq5VJegX4W7BXl2kJQ0vNs1kw9sw9W1mYDpKsg+nfeWO0lfEbI3/urpWRPDyFo9VVHclATc1bnOEQP3K1hb37Jrzwio6yRijmavQvQsuvO8w7BciueDhaXbbyyIY3ggp2RHqyjYREU+LNa2QO0G3tTbUrs7jJIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531536; c=relaxed/simple;
	bh=Otfcuv5e8JjcFt2LTFU0o+BbtMCAXdqbUvGGmcSnXmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN0LgenSYmyWYdrPlWnV/vHzCTi4nZO1qPE+iesMlZs9lbQIK9q227Cyzv1vgiQ7ggKZxpBK2Xl3Dd0y7MT6M6ooa0KZ84ZX6Sxv9pHom/nHfh5jX7QIFzK6c9vZ5ODeZDJaroHySN3kca442ziptmUEtQd/+NtMu4K4lMSQgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwHuEKax; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwHuEKax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791531533; x=1823067533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Otfcuv5e8JjcFt2LTFU0o+BbtMCAXdqbUvGGmcSnXmA=;
  b=JwHuEKaxvLdgyvs72XjXfzj/vtl4+Pvuyu3pN4S4UKRRg+Q4Qn+mAF2Y
   nCBswkDSnCTzf0xw1zihmSK1Kw5kGVIj9Kv30IOiMXI4b9qCtlGExb1zu
   vqaYdKnPsvJDiRAGwYYmkG50T59l0InLmMW466nnrvPGO0NwZ2aY/q1lX
   WXeJMjj8ITH3JyP6defCTSiQ7P2Ol+dAItcit7Tjkmvei6j0KpAnwnGKM
   FkZ/yt/pLFs+2HnjpsyTt2skouShSGps+ebtOVOiOY8+KUCt5Le1UrOOK
   qvBHD0ozqrhsYyyfvtot5fhgv1ZSDwKE/QhX+WggH+Cu2NdkK0tcLfHVK
   w==;
X-CSE-ConnectionGUID: VGMG28Z5Sz6/sNnsQMsFNg==
X-CSE-MsgGUID: qP+TI2I3T42ph53W2jQUPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="331794"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="331794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:38:53 -0700
X-CSE-ConnectionGUID: n40WNNUYSoqZ+qIwWXGuow==
X-CSE-MsgGUID: BjHEI2hdSlSJzs42ryzYGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="573718"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:38:48 -0700
Message-ID: <0caa7f40-7522-4cce-aff2-912a2c5b1cec@intel.com>
Date: Fri, 9 Oct 2026 15:38:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/23] KVM: selftests: Require guest_memfd for TDX VMs
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
 <20261001-tdx-selftests-v15-12-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-12-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> Force guest_memfd for TDX VMs.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 3f559f207408..7625908caf21 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -482,7 +482,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
>  static bool is_guest_memfd_required(struct vm_shape shape)
>  {
>  #ifdef __x86_64__
> -	return shape.type == KVM_X86_SNP_VM;
> +	return shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM;
>  #else
>  	return false;
>  #endif
> 

