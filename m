Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1E3002CF;
	Thu, 24 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258120; cv=none; b=INcuNwNb0BXpMMHjVMEWV6l9hAWXcyroICoeRjjtn5JV2vyCeyOenR+2NC7WU/Gy4Todqtd8Rc9CCq3illnupT7NKannzsyd115XflE6R0QMTXLKqFbiQnJixpmSCro34LjBnP+RjCdVkZHw6WElGpr5xoW7WhtHshJX6JUO7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258120; c=relaxed/simple;
	bh=i0m8X0NeKCKWHI8I4JyxU1Si9NAvo3LDWQUg6AYtzY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu97GTn0DjRwqEUpmiU7r8hKbk9PslnBVnsI5SErwLSuIipDGh6CcGHmDQRnTrSLLXTuQmqgOIdNXjEpPWa9Deu+RDSfKDhCfv0rZcC3Wx4vlEQRVz9D+uscfF/8nDQqjbXBivyPCrB3lbiuN5rF30trz2GGG5D+3dNmmb4fouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRoVtjgq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRoVtjgq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790258119; x=1821794119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i0m8X0NeKCKWHI8I4JyxU1Si9NAvo3LDWQUg6AYtzY8=;
  b=lRoVtjgqhopCFYS6HqjwZ5NeL3Qi4DjBGWCKzkDOGFkUIKCUDmx7PCnq
   l/pFSEPGjzWNAwJHxYaKLaW684SH535IgU6475cZ8eXuK4NDrO1ITuATL
   jSIq0TsuOiyjx6TbgIJbaliDhkeR0J4yCTn4RuBjyMwdAo6qeyVuesBOm
   dZkFj6GkE0lmhWtr9FKlLP+2D5DbuxHMStaWz03xyzsWtJZhynWpGRL/c
   2RDxghueLYY/qeb9kPBHOgr8ea+MPOGdu9cIGLrjHGm+71YzE6p0WIxs9
   Wy9yT8qhOlt0O3eiiQgQSU2xH2DYZASJR5E65NP5t47GdVCvmSFs+qdzj
   A==;
X-CSE-ConnectionGUID: OK1ZKDKBQ+q63ZTKKR8qzQ==
X-CSE-MsgGUID: zbCyR8plRWSZDS5Qtl9s3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93747394"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93747394"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:55:19 -0700
X-CSE-ConnectionGUID: Hy+8FGAnTAaVAQwvALjFyg==
X-CSE-MsgGUID: r6+PzA13SL2McLPGOBW2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273608809"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:55:15 -0700
Message-ID: <3278bae0-1a30-478f-8488-c762ac0246fa@intel.com>
Date: Thu, 24 Sep 2026 21:55:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
 <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 7:41 PM, Binbin Wu wrote:
...
>>>> As for "features forced to zero when #VE is reduced", do you mean when TDX
>>>> module supports "#VE reduction" feature, the features becomes fixed0? or when
>>>> guest enables "reduce #VE", the guest see a 0 value even though the feature is
>>>> still configurable to host userspace and host userspace configure it to 1?
>>>
>>>
>>> #VE is reduced means the guest reduced the related #VE, i.e. TDCS.TD_CTRL.REDUCE_VE
>>> is 1 and the related bit in TDCS.FEATURE_PARAVIRT_CTRL is 0.
>>
>> I think "features forced to zero when #VE is reduced" doesn't matter at all
>> here.
> 
> I think it still matters.
> 
> If there is a feature that is virtualized by the TDX module itself, but KVM doesn't
> support it for non-TDX VMs, I think it should be allowed.
> 
> These features can't be added to the allow list because neither TDX module nor
> KVM do the virtualization for them.

... <snip>
>> I think all the bits that are directly configurable but out of kvm_cpu_caps[]
>> and not supported by KVM fall into the last category. You can just list all of
>> them instead of my "for example".
> 
> As I mentioned above, if there is a feature that is virtualized by the TDX module itself,
> but KVM doesn't support it for non-TDX VMs, it should be allowed. Although I don't have
> a concrete example. I think we still need to mention #VE reduction to some degree, but
> let me see how to simplify the description.

(This reply only concentrates on the discussion of "if there is a feature that
is virtualized by the TDX module itself")

If you are talking about the features related to #VE, I think there is no.
Because if TDX module itself can virtualize the feature, then it shouldn't be
#VE at all. #VE means it needs para-virt support from host VMM.

If you are talking about the features unrelated to #VE. I think it's just the
case I argued for in previous v3, that we can support a feature for TDX first
before non-TDX VMs. I think we all agreed that such case can happen and we
decided to support such case when there is a real case.
