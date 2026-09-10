Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58737A841;
	Thu, 10 Sep 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007962; cv=none; b=TJkIbMvZ6+4cms4pLBxF8FyF9A8D4DjeprbrxeZJ+b5VtGZfxJwwRIpGUQ/JmegRvJDo9CBYp3EOeMmnm65FmJNrsCLnH+tnOcX16nHxbsUmzhQm4F97IdLl+Gl1JaX8TVy2VFP0PJnViGwkZNVXrsdFeM8FaopxC5vxankU8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007962; c=relaxed/simple;
	bh=Bx1VX/15yWu9NCF3Az7dEIpPPBDhZA23G+v8REPX9lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCwbxOTpEIfkx11lu9foxKKHZ3dApeA23BKG8MFM3NZ5msK0qqV5feYGPjLipAaiEX30ApiLEUT464kO41UjzoYqzdew1EWsDfxlidZ3TjkGmDWWuOfnXAa0KuOUYsriq2+ZIoAoeHKJthtidAqBhHcRYLDMRj3l46SQ3DWyatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZkbskY0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZkbskY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789007960; x=1820543960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bx1VX/15yWu9NCF3Az7dEIpPPBDhZA23G+v8REPX9lk=;
  b=nZkbskY0oxi4lQIegeNcCpdsjLOgRz11iosVZ0oVkyKIEWoDKDBrFKJQ
   WqEuXU3qUymqa4gX+scD4QadBYC/F6fG0Jg6pnWdY707Y2NGC15U9Zj9C
   IMxkch4e1V1slY0Bc553DSXCW6dVMaNTpCO+ep/VYGvcf5YpietchEL4e
   rGC1sN71pnId7blYGjjSeczmTlCFKJPZo680lGG418f8riqCczAz2aYZS
   JnztyQYahHwKItellY5B2CUDY//9RuQbhXeByd2OvTAcnNQ34DvjaTyx5
   NjFfXthHJbdwJLvzyeJV2Y++mFJ7gT9SgciYrMgTncD6A9oe7FJE3LwxS
   A==;
X-CSE-ConnectionGUID: z9BSrL/cT0mGzbzfPSZMHg==
X-CSE-MsgGUID: xpM34bM2TFSbXRjZf4FDBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88392994"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="88392994"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:39:18 -0700
X-CSE-ConnectionGUID: n91tFLOfRoSsBD8hIdUWSw==
X-CSE-MsgGUID: wj+lylllRDuMnixh2vxSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="265290060"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:39:16 -0700
Message-ID: <ac43e7f1-2ee3-41a4-85ff-edab7a7caa35@linux.intel.com>
Date: Thu, 10 Sep 2026 10:39:13 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com" <seanjc@google.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
 <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
 <aqHdwkOFVR4XoS2M@google.com>
 <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/2026 7:18 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-09 at 15:29 -0700, Sean Christopherson wrote:
>> Eh, I'm with Xiaoyao.
> 
> I'm not sure what the disagreement is actually. No one is saying *never* TD
> first I think? Everyone agrees it is ideal to solve normal VMs before settling
> the TDX behavior.
> 
>>   Yeah, *ideally* we'd magically enable everything everywhere all at once.  In
>> reality, different VM types are going to support features at different times. 
>> More importantly, as Xiaoyao points out below in #1, unless we enable
>> everyting in a single patch, which is probably a terrible idea in most cases,
>> we'll still end up with staged/progressive enabling, i.e. we still need to
>> have patches that selectively enable and advertise a feature only for the VM
>> types that actually support the feature.
>>
>> This is all quite similar to Intel and AMD feature enabling being done at
>> different times.  The biggest difference is that Intel and AMD are mutually
>> exclusive and so KVM_GET_SUPPORTED_CPUID always reports the correct
>> information, but TDX already provides KVM_TDX_CAPABILITIES, so AFAICT we still
>> get accurate reporting for TDX, just in a slightly different way.
> 
> I think this actually surfaces another problem with TD-first enabling.
> KVM_TDX_CAPABILITIES only returns the directly configurable bits. Then recall,
> KVM_TDX_GET_CPUID returns the actual TDX module's view of CPUID bits to
> userspace. Then userspace calls KVM_SET_CPUID to actually put them on KVM's vcpu
> so they can match between Qemu, KVM and TDX

That brings up a point..

Today, vcpu->arch.cpu_caps[] is capped by kvm_cpu_caps[] (plus a few special
cases).  As mentioned in the cover letter, this patch series doesn't enforce
consistency between KVM's view and the guest's view of vCPU capabilities because
KVM doesn't currently use its own view to make decisions for TDs (e.g.
saving/restoring feature-related MSRs).

However, if KVM starts making decisions for TDX based on vcpu->arch.cpu_caps[],
intersecting userspace input with kvm_cpu_caps[] will not work for TDX.  I think
this is probably needed in the future?  If so, allowing features outside of
kvm_cpu_caps[] for TDX means we will need TDX-specific handling to construct
KVM's view of vCPU capabilities.  That likely implies tracking all
known/supported TDX features, which is doable, but it will make the allow list
bigger.
> 
> So if a bit is enabled for KVM_TDX_CAPABILITIES, but not yet in
> KVM_GET_SUPPORTED_CPUID. How should userspace interpret KVM_GET_SUPPORTED_CPUID?
> It can ignore it for TDX, but that is how it can find the PV bits today.
> 
> If we have a TD first feature, it could be a documentation update on how to
> interpret it. Or we could stuff the PV bits somewhere else for TDX and say to
> ignore KVM_GET_SUPPORTED_CPUID for TDX. I think we don't need to solve it before
> we begin filtering like this series has.
> 
>>
>>> I don't think "split lock detection" is a good example. We are discussing
>>> virtualizing a feature, or allowing a feature to be exposed to non-TDX and
>>> TDX guests. While "split lock detection" is not a virtualizable feature and
>>> how KVM handles it is all about how KVM fixes the architectural flaw of it.
>>
>> Yep.  If there are actual decisions to be made, versus simply adhering to the
>> architecture, then we'll need to incorporate the needs/abilities of flavors of
>> VMs KVM supports.  But for feature virtualization where right vs. wrong is
>> dictated by hardware specs, there really isn't anything we can do in KVM to
>> affect the guest-visible behavior (beyond things like performance
>> characteristics, but those aren't ABI in any case).
> 
> (Copying from my now aborted response).
> 
> I think it is not just the the behavior to the guest that matters. I agree guest
> behavior should normally be settled by the bare metal arch. But it is also how
> the TDX module decides to make the host side behave. And how it ends up fitting
> in to KVM for normal VMs. For "normal bits" it doesn't matter too much. But for
> anything with extra TDX arch decisions on top, ideally the TDX arch would not be
> finalized before the normal VM KVM design got to some level of maturity.
> 
> In any case, I don't see any big disagreement between anyone actually. If anyone
> has any big worry please make it clear.

