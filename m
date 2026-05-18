Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69A3D0BEC
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089077; cv=none; b=TiYnjQ/Auqalkz46EhOGs+8F1ww1+XQwbxiV+dub0yHuyfMFuOgKgg3mNV1D4UuLrnmzMaT5mVoRV0z/Dt3iJD0rX+yimifArPEmLER5XRNqP9RzlZr3hmp/OlnQCZ1iVcvZN/2FR6ZKMhOJo7YIDxl+GONanJ670Gz5GUuwDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089077; c=relaxed/simple;
	bh=wF9KcoPmy/FjOpzl7nah2ti46sRlufDcZPEHTsbRTck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F35FSoa7CbmDPSvtB+e8I0mOee4eqTfl1eLOHg7zfktFnPP5Ll2me/8QWdPw6xeT6QihSm2APDODzLh8T34NF3Y2Y/pMd4EH1GtdBtbLKF4KpV/0ELQzkSc2i8b6eBFMD2+fWCb1L/FSVoEM2EvDmEM0VMem0bNKJ5tzKovWfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBRShDkV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBRShDkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089076; x=1810625076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wF9KcoPmy/FjOpzl7nah2ti46sRlufDcZPEHTsbRTck=;
  b=CBRShDkVripwj/Sz7pwg9xmY0Nwe+RL0U4XBAZUBXQr8mJ56KdjmWFGi
   RUZ28GRO2EJy07mtk41U1t0e5Z9k3nGVH6CYNxnznBpoZXad0YDxOfYEi
   hKBW3RBMWEP13q4C9clVN6kj+PpMpgiX8xKrJ7LQmdrS9joKjU+Mj3025
   gpYWW5NICWRs8mwzBhSd9l5CFnLoy1I2HwEMShO+jW0UKHJs59MGphaYB
   Esk4HreregliiioA7YaP84AKpBmWwTUofWI5boFpk4j1pddwOsDhLbUbX
   /1at1HB5mRhxs/kjrQplknEKWykNT7RbKyoJdSNLNJ0eLSOk53v8Ou7as
   g==;
X-CSE-ConnectionGUID: vjrhTEMiT9uBtfz8ZKAU7w==
X-CSE-MsgGUID: qIBRmA5FTg+KBDZLq9ynBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="67463342"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="67463342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:24:36 -0700
X-CSE-ConnectionGUID: ik1SRPzhRxmja9YmUJ6Utw==
X-CSE-MsgGUID: +/7GSeI7TqmSbg3YBMqjzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244331729"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:24:34 -0700
Message-ID: <ec9a3882-4505-45f3-b7f8-634cca3a18ce@linux.intel.com>
Date: Mon, 18 May 2026 15:24:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <c6d216fd-3ca5-4ee8-91d9-ffb088c72fa5@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <c6d216fd-3ca5-4ee8-91d9-ffb088c72fa5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/18/2026 9:38 AM, Xiaoyao Li wrote:
> On 4/17/2026 3:35 PM, Binbin Wu wrote:
>> Originally, we had issues on TDX when a new hardware feature, which is a
>> host state clobbering feature, is supported by new TDX modules/platforms.
>> A host state clobbering feature requires KVM to save and restore the
>> feature's related MSR(s) on host/guest transitions; otherwise, if the
>> feature is used by TDs, the host state will be corrupted, leading to
>> unexpected behavior on the host.
>>
>> Currently KVM hardcodes a deny list for unsupported host clobbering
>> features for TDX, i.e. HLE, RTM and WAITPKG. However, KVM can't keep a
>> list of bits that it may not know about (e.g. the upcoming FRED support
>> in TDX).
>>
>> We had been working internally to propose a TDX specific solution to
>> solve the host state clobbering feature issue. But during a PUCK meeting,
>> Sean mentioned that KVM had a more permissive CPUID configuration
>> interface than desired and there were problems due to it in the past for
>> normal VMs as well. Sean suggested that KVM should introduce a more
>> paranoid mode to check CPUID from userspace for VMs in general, as well
>> as an opt-in interface for userspace. And TDX should use the
>> infrastructure to enforce paranoid mode non-optionally.
>>
>> This RFC patch series adds a paranoid CPUID verification mode for KVM on
>> x86, where KVM must be explicitly aware of every CPUID feature exposed
>> to the guest. When the CPUID paranoid mode is opted-in by userspace or
>> enforced, KVM will reject any unknown or unsupported feature from
>> userspace. And it starts to enforce paranoid CPUID verification for TDX.
> 
> This series misses the (important) part to use the TDX overlay to guard the setup_tdparams_cpuids() (and also mask the supported configurable CPUIDs in init_kvm_tdx_caps), to solve the initial TDX problem.
> 
I think the patch 27 is what you referred to.
