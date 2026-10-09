Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA703F1055;
	Fri,  9 Oct 2026 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525654; cv=none; b=cETqSiI3nDz/sQP9b4zOnrWbTgB88QQii1J755ANftJRW3XleUk0q5dPcGAC1FBe4r0Hf79xT5Uh8pzzX0KgvT8EsYZRpEP+k5HpUoRLmyJFvEFU7Ae3ycCCbzNO3RJhwYcqEoSvZ0f+wISBnTrlZLLJ9w1n7VERylADk90JGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525654; c=relaxed/simple;
	bh=AktVquTxQWQlF2kZ7qqbaa5h3+h8P2oAsmr1aAwhhAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azBQnql6VbgAC631SwPaUhgjtdjnza+ax6sIvsiQa1p3K+B0ShIRT/hAdVoX7Gx7aaJsgyY4baPxfJRsrSUMR28elvfdlSPchNNo/NdpCBiwdHflwK3KzSmufoq1dGnrLAJr2sYNQocnV21Wi3ewSojR14vuzi33y2bQIF8KRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPDHGDhN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPDHGDhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791525653; x=1823061653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AktVquTxQWQlF2kZ7qqbaa5h3+h8P2oAsmr1aAwhhAQ=;
  b=JPDHGDhN8bihjLWWBNFtGE4rSVL52FrXU680Dpbt5bX8hsP/d9OlmfWP
   ZYCrF4dmceJDHX5vWUN7oytplgzg8qNfcPyJlZ4IVj/jFceJC/Prd/EWc
   Z7t2sf8Er/j3f0xDfT3Qqj9OKC/xn13B34SRwOWgUddLPW/H5PncOWAZn
   X0lBLczBrnvORDhTxkcxpGGQH8xCDp0vsmUwTtMJ4Cp8y02S6cJNJEfXf
   GD25ebDvV6HVDncK1Ty80TZ2ky6U+REugkwS0Z+g2G8sCJHlr7DEARgP4
   WTwsOoys9OrJRJ7GpjS4ooTUofKhHPDcdv6YRhmMZ8NNYEJyatRAQ215f
   Q==;
X-CSE-ConnectionGUID: DUKd5PTyT++Y/5j7QNrHSg==
X-CSE-MsgGUID: pHMn5sUZQ1WBA9LMm3WPog==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="223474"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="223474"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:00:53 -0700
X-CSE-ConnectionGUID: 1ONRRhUoSwu7bky7twv/TQ==
X-CSE-MsgGUID: sgynZKE6Q9W5kby2AgXruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="2050635"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:00:47 -0700
Message-ID: <43382fac-f6c4-47dd-8030-ef07b6073988@intel.com>
Date: Fri, 9 Oct 2026 14:00:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/23] KVM: selftests: Initialize the TDX VM
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
 <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	u64 hw_error;							\
> +	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg, &hw_error);	\
> +									\
> +	TEST_ASSERT(!ret,						\
> +		    "%s failed, rc: %d errno: %i (%s) hw_error: 0x%llx",\
> +		    #cmd, ret, errno, strerror(errno),			\
> +		    (unsigned long long)hw_error);			\
> +})

The cast to (unsigned long long) catches me eye. Can we use

  "hw_error: 0x%" PRIx64

instead?


