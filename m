Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1813A0EA5;
	Wed, 17 Jun 2026 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689832; cv=none; b=XpYNsXumJQ+hgxfCTa/vEdiu2f1Kcs31F0AcyIWfr91+cWSXSnVbkV7cTOiFm96/0l2Jsj0MDvWyB20KU66e6DOtu82Kcd5JXV2GMrBIrVcqRitowEqKSRUUF8IVZ6ndOGJfJqpfv0lxxPn6DvVtUfmjlb3viBARqploGK6jiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689832; c=relaxed/simple;
	bh=W8RX0ViKBHrns3CDoofxIxoT4qhfugZi9z/OSeO9IcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9c0yRBDltxMAbDgwUkMJg4z5LSArGgK/3NGiy+bUX6+An/P6wh8IPeSeBrkzzzwZoFeIWwNJiPDMyF2jO+06RJ08GHBV0QCVbTXgWwnv3bFmCwTihHTd3byrj9zkOn+TZPkNVSoOeJR5f3bNPNcZskzxpEY9sOmn7pJNhNJfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQITthyc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQITthyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781689832; x=1813225832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W8RX0ViKBHrns3CDoofxIxoT4qhfugZi9z/OSeO9IcE=;
  b=fQITthyck+bTo0nD0P1+VU4f3Ml5PuWFT+A7J6jmM6jFm85b/ZCaIkuz
   RTXpPUj33s37wZRKbFVtR+8N58LIGLkLkjK70+i+5giNY4E9TW2J2H41V
   bwExmHcHjfg3H8moJYtCsgYt0fIQUVYbC6raz+VnaHVjk0/Pbj2VynsTZ
   0nsb6+Ro7A5ho4Kz+YF/pddbnN3ia1Ja8/VmOARVaWIwySPPR3EjFETeD
   GfW2JEfEgGc95lLYcZKNjVeBLjm8DcF50/CoCxbK27UG/KB+/SpE9B1cn
   MhxZldIwGWyUOjVzlKZXJve0NPAjYNc9iEzvWe/Fav2TrrvND0UcpY4te
   w==;
X-CSE-ConnectionGUID: IVsWpB3ESYmD6yDs9P/aRg==
X-CSE-MsgGUID: mdDjKDtBRd+m8aWvYr+4RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86316936"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="86316936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:50:31 -0700
X-CSE-ConnectionGUID: +xMQWYpsRweHe5eYa4wAcQ==
X-CSE-MsgGUID: OvrGfcnrRt2rbLiJkx/54w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="245643470"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:50:24 -0700
Message-ID: <55be1f42-0197-443b-ab37-681f98a23d41@intel.com>
Date: Wed, 17 Jun 2026 17:50:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/22] KVM: selftests: Initialize the TDX VM
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
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b68ad1dc7e02..8d06e7186df1 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -802,6 +802,9 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
>   		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>   	}
>   
> +	if (is_tdx_vm(vm))
> +		tdx_init_vm(vm, 0);
> +

It fails compilation:

kvm/tools/testing/selftests/kvm/lib/x86/processor.c:806:(.text+0x212c): 
undefined reference to `tdx_init_vm'

We need grab the change on Makefile.kvm from Patch 10 to this patch.

diff --git a/tools/testing/selftests/kvm/Makefile.kvm 
b/tools/testing/selftests/kvm/Makefile.kvm
index e5769268936a..0107ba02b01c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -29,6 +29,7 @@ LIBKVM_x86 += lib/x86/sev.c
  LIBKVM_x86 += lib/x86/svm.c
  LIBKVM_x86 += lib/x86/ucall.c
  LIBKVM_x86 += lib/x86/vmx.c
+LIBKVM_x86 += lib/x86/tdx/tdx_util.c

  LIBKVM_arm64 += lib/arm64/gic.c
  LIBKVM_arm64 += lib/arm64/gic_v3.c
