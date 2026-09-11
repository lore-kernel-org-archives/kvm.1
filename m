Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951024293C;
	Fri, 11 Sep 2026 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088143; cv=none; b=Uk1nrOfl90flcIcR9YJjxb3vzGZLdCuujAh/5VFwiOxZP8iT0zBK7qZ045Fb1NjI18KD+n+vzeu65T3tKXuWhLaaRc6PUXbYhDHuxNpWheJGX3ec0r8rf17vZAElhgS7LQQrMnOYPJT3cgjyYXBL1/vxmNlqY9dPJshIo4oeWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088143; c=relaxed/simple;
	bh=iKFMECzhiLFZRng3x4Ia6J8n9Cwgl8A3jDXgObk9LkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myuhNfaHhrjtvexOO7UdNSmolIZrmVaOsFmcK9dGvewDtaAA7/tpVvuRMlcsUUALzSFJiJbXYri+SlrmRavZbRIYxEqJnxePQQh4lK+Pf0GQWC/E+r9nV7PvXrfyhsjiW8UJGBJDPIPKoC4x54qjuRJsLLgYjZXavqatLHYEb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0MCThFX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0MCThFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789088142; x=1820624142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKFMECzhiLFZRng3x4Ia6J8n9Cwgl8A3jDXgObk9LkA=;
  b=R0MCThFX3RHuP/qeIuRBHFugGpy1EdTTKPVVQUCRqMdG22M3vTr98xAk
   ElWZ1BuImnzNeFta0jBOuzbQ2w8B1yOURKZaHHUaWMpsxaTdz+57CIS4V
   ZuD6vJGRGl3dmUtDbT/ZL0ZFRnRh75QzplGHnA5Hubh08Eqqe/JzZ7Hnt
   5DyQWK412SIGeNH8OKHgE5MDURmBhfauaqzy+bTqNV/s6ZxkBEEr0YGvg
   SE7n1GK3VExq728eMQiyDKLNUin7p35ok18SAX5Nk6+xPzp8s2gMpzs/4
   s0AXKTy/Y1LhH8vapzY4XsmcKtev+WsXF2cM3+C0fW08yPxt/PPAgzGhc
   A==;
X-CSE-ConnectionGUID: jRrMbUBGR4CJ4HI8779J0Q==
X-CSE-MsgGUID: tYOKfgATRrSHvi+MlnS16g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93241276"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93241276"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:55:41 -0700
X-CSE-ConnectionGUID: c4Tab6B1SLew0gRBrmbGzQ==
X-CSE-MsgGUID: JZNtVDoeRtC1gThLdRqTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="267501276"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:55:39 -0700
Message-ID: <4e7edd44-d15e-48c9-89a4-a5baeba4fa12@linux.intel.com>
Date: Fri, 11 Sep 2026 08:55:36 +0800
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
 <ac43e7f1-2ee3-41a4-85ff-edab7a7caa35@linux.intel.com>
 <18b2e611bf1d166dde6e27a68719fa5053151af6.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <18b2e611bf1d166dde6e27a68719fa5053151af6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/2026 5:29 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-09-10 at 10:39 +0800, Binbin Wu wrote:
>>> I think this actually surfaces another problem with TD-first enabling.
>>> KVM_TDX_CAPABILITIES only returns the directly configurable bits. Then
>>> recall, KVM_TDX_GET_CPUID returns the actual TDX module's view of CPUID bits
>>> to userspace. Then userspace calls KVM_SET_CPUID to actually put them on
>>> KVM's vcpu so they can match between Qemu, KVM and TDX
>>
>> That brings up a point..
>>
>> Today, vcpu->arch.cpu_caps[] is capped by kvm_cpu_caps[] (plus a few special
>> cases).  As mentioned in the cover letter, this patch series doesn't enforce
>> consistency between KVM's view and the guest's view of vCPU capabilities
>> because KVM doesn't currently use its own view to make decisions for TDs (e.g.
>> saving/restoring feature-related MSRs).
> 
> Not sure if I'm missing your point here. I don't think we ever want to have KVM
> enforce consistency between KVM's view and guests. We just need to provide
> enough info to userspace such that it can make them consistent.

Consistency check prevents malicious userspace VMMs from lying to the KVM about
some host state clobbering if KVM uses guest_cpu_cap_has() to management the state
for TDX in the future.  

> 
>>
>> However, if KVM starts making decisions for TDX based on vcpu-
>>> arch.cpu_caps[], intersecting userspace input with kvm_cpu_caps[] will not
>> work for TDX. 
> 
> vcpu->arch.cpu_caps are actually already consulted for TDX. I remember seeing a
> bunch of the the guest cpuid feature checks during the base enabling, probably
> working on this problem. Let me what we have today.
> 
> From a Linux guest boot, guest_cpu_cap_has() returns true for:
> xsave
> smep
> smap
> fsgsbase
> pku
> la57
> umip
> vmx
> pcid
> lam
> unknown
> ibt
> x2apic
> 
> Since we share code with normal VMs (and manage shared EPT in KVM), some checks
> are going to happen. If there is some new feature foo we enable for TDX. And
> later KVM adds new logic around vcpu->arch.cpu_caps for it, then there is a
> small risk of being pinned down when we want to add new guest_cpu_cap_has()
> logic for normal VMs. Since we already are hitting these checks for TDX, the
> general case is not theoretical.

... Yes, this was my concern.
If in the future KVM adds new guest_cpu_cap_has() for a host state clobbering
feature and it is used TDX, it would cause problem if there is a mismatch between
guest_cpu_cap_has() and the real value exposed to the TD.

> 
>>  I think this is probably needed in the future?  If so, allowing features
>> outside of kvm_cpu_caps[] for TDX means
> 
> Yea, I think allowing TDX features outside of kvm_cpu_caps is for special cases.
> And filtering like you have is good.
> 
>>  we will need TDX-specific handling to construct KVM's view of vCPU
>> capabilities.  That likely implies tracking all known/supported TDX features,
>> which is doable, but it will make the allow list bigger.
> 
> In this thread we have been talking about what "normal VMs" support, but in the
> code and uAPI it really is about what KVM supports. If we let TDX use a feature
> that *KVM* doesn't support, it is the risky zone.
> 
> I say we punt on this. Let's remember it's dicey and if we find TDX feature
> enabling is being blocked all the time by normal VM enabling, we can work on a
> solution. Does anyone see any big risk of this being harder later than it is
> today?
> 
> I prefer to at least start filtering ASAP.

+1
