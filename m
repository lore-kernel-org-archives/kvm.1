Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A763347BD7
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055016; cv=none; b=duIKVKp7Wu0CIsNowe/idJybXYTxFZzho5/7Vbg86nkQLN1EapczvVcz9LwvOhnRwovD3/xClsrvg+wHA1EeNwLe016MnCBWepN8LHdUQ0CBh+QAxYAq1mdn4R1kQ/sl/9vQ43fMizWUPbq1jKgBK5H3wsggWLRXVDphWri5hiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055016; c=relaxed/simple;
	bh=uGXwfDYO1jrYIQbonz7msTpOo+ktrOsz3dzPbT8IDdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiyVaoW07E2Tw/gJfcVXPziClv6eTrNwcSu6gZutb3xqYRHFSr++2LsWejCJIpj3FFphaZr1YIjf+kXiFMDk9hPfC63G3xxwH+A5iC9nb4RQkGEV+1Cupf5pFHSVHmT1X1xHbnj4qIOAPOWIKtQyRORiNZoy0CZd0YzOEunan2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoevm/XW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoevm/XW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777055014; x=1808591014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uGXwfDYO1jrYIQbonz7msTpOo+ktrOsz3dzPbT8IDdE=;
  b=aoevm/XW8ViYSBouuyCPuGYRVqC/icOSu/PB+6VUk+l79KbAiUpypcau
   3C3mTPBHyF4+EwAUOS9lc4M+E+bYaokxNJHURtrVr1IpOtX37kgP2EF30
   XMRxyc44lGL7sfE6Xm97y+Pnod8yfPGMUTkJsUzGoCvm//qKZfHu53niX
   LOYOoomm6FCoY+q++aplH+ba/PvsQuW06OItaaYRd3LcRzTpHwu19xJ6h
   CgyuejHVDCSLGLVDCInJB7fyrlej3AqVJZYEljvlu2Lu8/7+qttNT7z6o
   p9nMMJuzRLNYewZ9hRVWqvk7Mp+uTGTsQhNknC9Ry3NhJUSXgCBWbY4XR
   A==;
X-CSE-ConnectionGUID: WM8aEeeuTbicl8jyXDw6ig==
X-CSE-MsgGUID: NM9D2/v5QciewV4n+43uAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="88348926"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="88348926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:23:34 -0700
X-CSE-ConnectionGUID: xSpqcdfASdODhtW3574+kA==
X-CSE-MsgGUID: Ghdv6X/KQPO9aTj3wKiycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="232027376"
Received: from unknown (HELO [10.241.240.162]) ([10.241.240.162])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:23:33 -0700
Message-ID: <0e1eb66a-9c06-4c75-98d0-dc3b9b1296de@intel.com>
Date: Fri, 24 Apr 2026 11:23:33 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-2-zide.chen@intel.com> <aeid0QluufANcH59@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aeid0QluufANcH59@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/2026 3:07 AM, Zhao Liu wrote:
> On Wed, Mar 04, 2026 at 10:07:00AM -0800, Zide Chen wrote:
>> Date: Wed, 4 Mar 2026 10:07:00 -0800
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
>> X-Mailer: git-send-email 2.53.0
>>
>> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
>> (bit 11), is deprecated and has been superseded by LBR and Intel PT.
> 
> I'm not clear from which platform this bit will be set by default?

My apologies, my statement was inaccurate and misleading. Newer PMU
features may cover most of the use cases addressed by BTS, and BTS
appears to see limited use in practice. However, it remains supported in
the latest CPUs.

> 
>> KVM yields control of this bit to userspace since KVM commit
>> 9fc222967a39 ("KVM: x86: Give host userspace full control of
>> MSR_IA32_MISC_ENABLES").
> 
> If KVM won't support it, it's better to only configure for KVM.

But QEMU doesn't support PMU for other hypervisors.

> 
>> However, QEMU does not set this bit, which allows guests to write the
>> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
>> this may lead to unexpected MSR access errors.
> 
> But overall, this way is a bit user-unfriendly. For cases where CPUID
> is unavailable, it would be more proper to check the KVM API to
> determine whether support is available; making this change in userspace
> feels a bit like applying the special patch for a corner case.
> 
> I found there's another patch where Paolo and Sean didn't want to make
> such changes directly earlier on....
> https://lore.kernel.org/qemu-devel/20220718032206.34488-1-zhenzhong.duan@intel.com/

Old KVM (prior to 9fc222967a39): KVM silently set BTS_UNAVAIL to hide
BTS from the guest. It worked fine.

New KVM (since 9fc222967a39): KVM gives userspace full control of
MSR_IA32_MISC_ENABLES and stopped sanitizing it. As shown in the KVM
snippet below, if KVM advertises PEBS, X86_FEATURE_DS could be exposed
and the guest incorrectly concludes BTS is available.

        if (vmx_pebs_supported()) {
                kvm_cpu_cap_check_and_set(X86_FEATURE_DS);
                kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
        }

Paolo pointed out that a QEMU-only fix is insufficient because old QEMU
+ new KVM remains broken. Two KVM-side approaches were proposed:

Option 1 (quirk): adding a KVM quirk to restore the old sanitizing
behavior for MSR_IA32_MISC_ENABLES when running with old userspace.

Option 2 (synthetic feature MSR): KVM exposes a new synthetic MSR for
userspace to explicitly control BTS/PEBS guest visibility, with a safe
default of hidden.

It is debatable whether either fix is worth the effort for such a rarely
used feature.

