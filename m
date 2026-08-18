Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1A32B9A1;
	Tue, 18 Aug 2026 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039275; cv=none; b=TCw3+Pa025BQKNVz2UNR1RfW3LJKP/TeqgRSJzuInZ2Tableiq2brQR5Dx6DpGYZFKzb3OmBOZmAckbiIQhXI4dcvPcwOuqdm5HTJa0VInINGw1sIfFty0I5j0Uzsjdy6VhIkmcFoWHFQhYruNYRszNiJBgws+UOtHeqLuAXMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039275; c=relaxed/simple;
	bh=SP3aTHO3gdc4XYZoR10qTa3rIZp0gv6pOveceMckfHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lF8wuZ12Yw+10Sg5y7J6eFHa1aYDNcX1HoFeQ6LlmK8n9RDdf5QsOLuxY0xeeDV5sfq2huLfXAYYaKcmZ1vbD9yo8+cjFYAkBRitVJTFXRwvNduWKYPtH26OVR6aifiayTIgnFsy/PWAyk1AbFYDy/ev/cFz+UPeQDnRodb5HXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEWpsAKu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEWpsAKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787039273; x=1818575273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SP3aTHO3gdc4XYZoR10qTa3rIZp0gv6pOveceMckfHM=;
  b=YEWpsAKuoASY+qIyDoW3BVkWgqb6PjL9mi5a0ytKhN0iWxE2I8fAfnGb
   E6LxPYmEbj2R/vy6bvOVIPa4Rea9lJ23Fu+F7ROqB78UPpX2HBGXGJDpB
   QLyHz+tawnknch6YsXz9J4ehVgC+iMfEnPtXEVmCxszhD70klQ/qaY7Bn
   ykp/8Pklso4sGopMeBGFA4e5cXuqfRNxVHwB6KATSgx/fwgtHUZ73tB4v
   07//lEfjCnMdYiMhUbmf2c2eGTclTTCCy3vDDeO+W8U+V3+tOUEuvfPT7
   i6BzPEInBT8AtyxXbqBoD9vM1Q/5reS8kHARCDyLnjlUeEMwazwZlmPVr
   w==;
X-CSE-ConnectionGUID: BYVB9Y95RpKa25PacrLTPg==
X-CSE-MsgGUID: XXj59o2YQcaOj/gPHTJVXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98886718"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98886718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:47:52 -0700
X-CSE-ConnectionGUID: cBCj8741RAKZPl3PHu7JDA==
X-CSE-MsgGUID: Vh3RwgwdRFOG3y/EPZSxuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265181040"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:47:49 -0700
Message-ID: <94990aef-8b17-4bc6-a5d5-e7da5107d001@intel.com>
Date: Tue, 18 Aug 2026 15:47:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com>
 <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com>
 <an3YFiDbjRs3PUwn@google.com>
 <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com>
 <an84cenJjf7EqhVM@google.com>
 <1dcbf1b2-dc89-4624-b98e-d34f40558cfb@intel.com>
 <aoNNiAbZUbkWoZ6t@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aoNNiAbZUbkWoZ6t@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/2026 2:06 AM, Sean Christopherson wrote:
> On Sat, Aug 15, 2026, Xiaoyao Li wrote:
>> On 8/14/2026 11:46 PM, Sean Christopherson wrote:
>>> On Fri, Aug 14, 2026, Xiaoyao Li wrote:
>>>> On 8/13/2026 10:43 PM, Sean Christopherson wrote:
>>>>> On Thu, Aug 13, 2026, Xiaoyao Li wrote:
>>>>>> On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:
>>>
>>> ...
>>>
>>>>> The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
>>>>> With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
>>>>> captures the logic instead of subtly rerouting KVM away from meaningful handling.
>>>>
>>>> tdx_is_exit_reason_valid() doesn't work unless we update the vp_enter_ret to
>>>> one that isn't one of the status code with valid Exit Reason. See below.
>>>
>>> Correct.
>>>
>>>> About the idea, isn't the purpose of setting the Exit Reason to a synthesized
>>>> one is to avoid the undefined Exit Reason causing false-positives when it
>>>> happens to match one of the existing ones?
>>>
>>> Yes.  The nuance is that I'm against clobbering the *full* exit reason.  I am
>>> not against setting exit_reason.basic to something like EXIT_REASON_INVALID_STATE.
>>
>> I'm not sure why you are not OK with setting the bit[31:16] to 0 ...
> 
> I'm all for that.  I'm against setting them to 1, which is what using -1u does.
> 
> Ah, I'm guessing my use of "clobbering" is confusing.  I was mentally viewing
> setting them to '1' as clobbering, versus setting them to '0' as "doing the right
> thing.
> 
> E.g. the VM-Exit (that didn't happen) wasn't due to a failed guest consistency
> check; it certainly wasn't an SMI from VMX Root, nor was an MTF pending at the
> time of the SMI that didn't happen; the guest wasn't in enclave mode; there was
> no concident bus lock; all other bits are reserved to zero.
> 
> Sorry, I should have clarified that writing the full exit reason is ok, but setting
> arbitrary bits in a way that isn't consistent with reality is not.

I will add a separate patch in the next version to set

   vt->exit_reasons.full = TDX_INVALID_EXIT_REASON;

where TDX_INVALID_EXIT_REASON is U16_MAX, i.e. 0x0000FFFF.


For change of below, will be in another series

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 0626e835e9eb..6cace57e45fd 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -8374,7 +8374,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
         if (vcpu->arch.xfd_no_write_intercept)
                 fpu_sync_guest_vmexit_xfd_state();

-       kvm_x86_call(handle_exit_irqoff)(vcpu);
+       if (exit_fastpath != EXIT_FASTPATH_EXIT_HANDLED)
+               kvm_x86_call(handle_exit_irqoff)(vcpu);

         if (vcpu->arch.guest_fpu.xfd_err)
                 wrmsrq(MSR_IA32_XFD_ERR, 0);
