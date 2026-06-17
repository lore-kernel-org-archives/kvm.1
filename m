Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211A2E739E;
	Wed, 17 Jun 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668465; cv=none; b=tvIHAp/RAIugw/voL0pC8XvDtoCBFpIA2+bH1RYtDoFTMi429FYDBi53LCEXo5z1OAfp1bK9K6f1kTcS3ouUorcmgzg3Df7QRbibqdDu8B+mDAYPMNCl63gwE5WsVrIrcIHDDGbTNmU2p3203Us6f7VxiQGOcM7UrjIVWJgzLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668465; c=relaxed/simple;
	bh=5RfolcwVlNTHN4wjvZUzwwIQwsj1Hecngtan4yBQW8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2728GUYaDNuSMLVK8ihNP3/cIVfNayeeR33klC19wtKfDu9ZNVSJyV94FjT1T2iOLSLlOThQLy1NwalqxTQyTFJfLT8xmhF60vWFYoc8MIwu+NfHHqe9hc+HWRmh0x/1TNU+7Srkduq+CE23eZ9cVvvtrARwvsjRtKfaox9S7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPRH/X47; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPRH/X47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781668464; x=1813204464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5RfolcwVlNTHN4wjvZUzwwIQwsj1Hecngtan4yBQW8Y=;
  b=JPRH/X47WmbeFHaCrftQI+UaWcFwqrNmXosImAvpxpokeEagTnHqBdaq
   ZX3bAFGWeSVYptM+Q7y4MRmifo2e0PuNeZGMmifi/GB6bpPKFYo2uHU9c
   3Bupp/QQnuyxzmc9zcVxUdKgCt26Yc+N6GR6MfsUrNMfwkmz9cH7PoHew
   yab95LltUv9S98Sv1JZPgCecMe42hZUlyzFBAUle0eX91yir9lNwaMtCd
   /SxtiKHGD0Kli2BvlER7WX2vB9GJNmAgGB+9TAZZ74vqyHuwBSHdYs258
   cAEyC3uziRDf7zbkIGPuHtHT90PUEwe3Ztzw0IHuA19p41X4trFwj4HaN
   g==;
X-CSE-ConnectionGUID: yKHwVXR4SZ+dlLe39Lkg8w==
X-CSE-MsgGUID: 5R5Jyj7HTeGhps4tlLHHjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81581093"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="81581093"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:54:23 -0700
X-CSE-ConnectionGUID: Lbw6C4BlQwGtLAr8pOyWHw==
X-CSE-MsgGUID: yftwUG/UQ7CKQwgHql6unQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="278153512"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:54:15 -0700
Message-ID: <93bb3437-786f-4551-a547-919bd9eb892f@intel.com>
Date: Wed, 17 Jun 2026 11:54:12 +0800
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
> +/*
> + * Filter CPUID based on TDX supported capabilities
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   cpuid_data - CPUID fields to filter
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * For each CPUID leaf, filter out non-supported bits based on the capabilities reported
> + * by the TDX module
> + */

s/non-supported/unsupported/

and break the line to <80 chars
