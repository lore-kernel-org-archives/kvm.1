Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330023BD02;
	Fri, 14 Aug 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675014; cv=none; b=B4HLE772faPn2PvCox0s5sAtG0l9yMjSgtpZtGqiwl+Yoh/f9RzLqWLa7GeaK2ml2VlD+V7TB//CSIFNY/W2BVDg4JvdSbrtAerU1G28q2QZ4fOikI+/FEveUn3ljFf559tr1pCgEKd8HVQnO3nnJjXH7iDOKYB5716JqJxiDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675014; c=relaxed/simple;
	bh=5u2WCyPog3z4h5CcvpUP743luQzWWT+PMRaV8cjoB2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE+iLHRqI1P+QpVtDZ4fIyVktudYN5uJYPuS1DcrjIUX17MNoHiAxCwvNp9ITwPdDBUeHTBW94K11ifMGc9EKopFDNpEI5UvdKa/FILEWLgHjT4bOLog3pVxME0WNfuj2NrtOVyvYwyQB3rCnoe7IJvyt5wSuZe91WpzvKyTLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2APYGbA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2APYGbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786675014; x=1818211014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5u2WCyPog3z4h5CcvpUP743luQzWWT+PMRaV8cjoB2s=;
  b=j2APYGbAOhZ1s/CXk6vA7qeOxnKNROvDoS35Z7XZUxFwChtbvcWbPwTQ
   0Jbg5n6CrFXRwje7cDKmGlTjw3EoylSaDNRrT8CTX6uN2Qt00O5icK2Fo
   lYOi1fyli3XdxjtWfND7tR3DjMNj2ut41t3qNON74aovaNupT0W2QQzkI
   G2SZfw2a9qdhkqrJbpQIpUL0htpsQJntFZKrOpgoDEkA1goQn22/yTpo2
   aD6AJCuoz7R2V0kzyNvXcuf1zFxHKZNa9ysL83uREOgesKBerg6IPMPZZ
   p2GeFo9I1ZLeVM6AZaTHZ2XyjTnyATvJwCqSptO39T03mz/sowVIubgye
   A==;
X-CSE-ConnectionGUID: MRXm/XXHTEOvUSbd5D7i9g==
X-CSE-MsgGUID: PLqCI1PoQNmOXLGVj8cynA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87276720"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87276720"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 19:36:53 -0700
X-CSE-ConnectionGUID: twp2HZdETWaBCDN87WccPw==
X-CSE-MsgGUID: JI8gvfgkRq2nZ8bwI4rGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="294030900"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 19:36:46 -0700
Message-ID: <7782f61a-1384-4960-85c3-5613fbf27729@intel.com>
Date: Fri, 14 Aug 2026 10:36:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/22] KVM: selftests: Expose functions to get default
 sregs values
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
 "oupton@kernel.org" <oupton@kernel.org>,
 "wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
 <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Wang, Roger" <runanwang@google.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "jmcrey@google.com" <jmcrey@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
 <b7f7ad93360d7e0fe59ab7f3b0ed6fa79375001f.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <b7f7ad93360d7e0fe59ab7f3b0ed6fa79375001f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 8:44 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-07-22 at 23:13 +0000, Lisa Wang wrote:
>>   
>> +#ifndef NUM_INTERRUPTS
>> +#define NUM_INTERRUPTS 256
>> +#endif
>> +
> 
> Is this necessary for this patch? I see why to extract
> kvm_get_default_idt_limit() because now it's used twice. But why extract this
> define too?

kvm_get_default_idt_limit() uses NUM_INTERRUPTS, and 
kvm_get_default_idt_limit() is extracted as a helper from .c file to .h 
file. Shouldn't the define of NUM_INTERRUPTS be moved together?
