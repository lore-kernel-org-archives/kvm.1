Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88F3FCC;
	Sat, 13 Jun 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319805; cv=none; b=PUqS0sw7IYgF76WK0LFnrcsIfl2EVOYdOhMx21w5iqTcg47aZEb0mZfAwcSWCkkQO/6G6oaR1+hzVthuXcou7DW/MZRmRG0yMOkVv7a9abYOcsu6HlxIl8S5wYwcY3CjlbfM5YVnfJIMrwim4lk7iweR0uSkREWGRJn2E2mwhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319805; c=relaxed/simple;
	bh=4xt+4xk0Hc3YMw1aNHlRBQaT0gBOUbECiVq0tCcnseI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls86r+aG7AahJVms5Vyj6MjBQLmH0kB6BQj7L/BzSrlPaOwLJEjaCiInNrgh4EgpnvF3RMacyFjaPL/MXpY7TX97COCDe1QGfQXNjoYWzu/BFCl4tYCwVQ+yr82HSgbRruTdo/3CA+EfKZIGlfXpq4LxH2GewlMykYre61stFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVJkxMm8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVJkxMm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781319803; x=1812855803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4xt+4xk0Hc3YMw1aNHlRBQaT0gBOUbECiVq0tCcnseI=;
  b=kVJkxMm83OKP4W6cpMoXdp8kJV2lI4IggB6GKb7mMoW2r4jGkejbVDRZ
   Kfhu+ZtbRjl5YvqutmreC/BqLa8nOicOg3608t/Tnbz8Uk6E+Xk6Ve7qz
   AtGXM3QqX696HbBox0OJsty2XVLE40a2B5VB4VsZbVnA83lGDhzYN3zYN
   1De3Qc81R+4fXe/R9AAo/OMgAFpFid4yE0ZaBv9PzKTprbOR5swE+8srT
   oxGxgdGZCLiCLJMNd2vjM0n7xFhHuIebsjLgwYWf7OysdBlm1QhdRIm9A
   rgHxvedalvR+0K8i/OL3GReeVKZGVWk4KradMyGnwxqQUJQntiHOpJGNJ
   A==;
X-CSE-ConnectionGUID: PUw2tFT1QB6cBj+lIP431w==
X-CSE-MsgGUID: fwlYRGhKR22RWB8haoptXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82261892"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="82261892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 20:03:23 -0700
X-CSE-ConnectionGUID: vxHDOxuNQyOXrSIrb6P1Zw==
X-CSE-MsgGUID: l8eRTb/IQP+iDLA2PysOHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="247044250"
Received: from unknown (HELO [10.238.0.202]) ([10.238.0.202])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 20:03:19 -0700
Message-ID: <141a4dff-adb8-4af0-b25c-f87b2189cbae@intel.com>
Date: Sat, 13 Jun 2026 11:03:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
To: Jim Mattson <jmattson@google.com>, Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>, isaku.yamahata@intel.com,
 pbonzini@redhat.com, erdemaktas@google.com, vkuznets@redhat.com,
 vannapurve@google.com, mlevitsk@redhat.com, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, chenyi.qiang@intel.com,
 Yosry Ahmed <yosry@kernel.org>
References: <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com>
 <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com>
 <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
 <aiJlAhqnU0lwOAcG@intel.com>
 <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/13/2026 6:51 AM, Jim Mattson wrote:
> On Thu, Jun 4, 2026 at 10:56 PM Chao Gao <chao.gao@intel.com> wrote:
>>
>> On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
> ...
>>> With respect to EMR, you wrote previously, "A mitigation for this
>>> erratum is for software to program the VMX preemption timer for values
>>> below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
>>>
>>> My question is whether the exponent, 25, is a fixed value for all
>>> CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
>>> saying that the exponent may depend on IA32_VMX_MISC[4:0].
>>
>> Let me double-check this with the internal team and get back to you.
> 
> Have you discovered anything?

Chao is on vacation, let's wait one more week.
