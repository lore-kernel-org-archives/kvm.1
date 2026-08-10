Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CD3C7696
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363343; cv=none; b=k5hgTPwVPILLrOzRvs7xypturuIO82v40VrJLIsmQz4WVzMGK4ES0BAVDl2nydMfApz1enI9SmNxBPXSRdRXZGKu06epVXu+1sYDtPb+d3ptG5fnacPLyjNaAh95cKeBz/pD2NyW7VDuUp9kj5yEoUa0lcPLBya9fBCaK81iseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363343; c=relaxed/simple;
	bh=mKz8e88GOzp0utTT237r6gxr8S3UIq1nd+3H6rcTBcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNjphO2Z4YF/OPnmyW6PmXkNl1kkWPvbmo8JHdkDbHOPTXrzoWAd3PUCWbgATejeTGKdIuLTAg0LH9lGMwZp6NfTTygsWF5C6FXho4wHJNmLb5Z6PTlUNF/m9UOcYgge8jf/8kuyGADBUbZuSgO6RyhyNU9MiyTI2b9qpgTYwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RA8ndXko; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RA8ndXko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786363342; x=1817899342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mKz8e88GOzp0utTT237r6gxr8S3UIq1nd+3H6rcTBcw=;
  b=RA8ndXkocz4/wTghQQGAntdsozcsMdD1DTczYtKZCgxPSj4eE+59rrJx
   JY02KttE79FX1kNXEmSv+wIamtiE1T13rtc0iY5JVyKfqitPxv823ohyb
   sBdZ/Vq9tHzrHllVDy91FDhFdOOfXmaOoSzI3RFXZ33d7wk99h2UotfxF
   DHw6PpzGJlYb80Lr/yt0jVCuONgQ1nhrqVz0NDaCvYwLJWhOO4OTscsYo
   Je/Md+VgKks6xcXTnbOBvP/zLc+15QJIwQtCWlV5v5p8TcttJJxlfO0uD
   vUH58h+LflcEthlfUlEtDgdJ9C4eXehPLhPS2+nH5XDcvMQlmSc/vupou
   g==;
X-CSE-ConnectionGUID: +LI/061BSzub6PG34eil3A==
X-CSE-MsgGUID: kN/KlFQJSt2doy2itYv/Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86951582"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86951582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:02:21 -0700
X-CSE-ConnectionGUID: 9sXxEko5Qvi30nsZUAPtcg==
X-CSE-MsgGUID: skYrVRKBSK2p9TWDb2ysjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="265005481"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:02:19 -0700
Message-ID: <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
Date: Mon, 10 Aug 2026 20:02:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <20260810113924.4ACBE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260810113924.4ACBE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
>> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>>   	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>   
>>   	*reason = tdx->vt.exit_reason.full;
>> -	if (*reason != -1u) {
>> +	if (tdx->vt.exit_reason.basic != -1) {
> [Severity: Medium]
> Will this check always evaluate to true due to C integer promotion rules?
> 
> The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
> comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
> integer. If the value was set to -1 (65535), the comparison evaluates as
> 65535 != -1, which is always true.
> 

Well, how about something below on top of this patch?

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a89885d550c9..e3c8c92f6f71 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -59,6 +59,8 @@ module_param_named(tdx, enable_tdx, bool, 0444);
  #define TDX_SHARED_BIT_PWL_5 gpa_to_gfn(BIT_ULL(51))
  #define TDX_SHARED_BIT_PWL_4 gpa_to_gfn(BIT_ULL(47))

+#define TDX_INVALID_EXIT_REASON                U16_MAX
+
  static const struct tdx_sys_info *tdx_sysinfo;

  void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, 
u64 err)
@@ -940,7 +942,7 @@ static __always_inline union vmx_exit_reason 
tdx_to_vmx_exit_reason(struct kvm_v
                  * undefined, but this is NOT a failed VM-Enter.
                  */
                 return (union vmx_exit_reason) {
-                       .basic = -1,
+                       .basic = TDX_INVALID_EXIT_REASON,
                 };
         }

@@ -959,7 +961,7 @@ static __always_inline union vmx_exit_reason 
tdx_to_vmx_exit_reason(struct kvm_v
                  * non-instrumentable code with interrupts disabled.
                  */
                 return (union vmx_exit_reason) {
-                       .basic = -1,
+                       .basic = TDX_INVALID_EXIT_REASON,
                 };
         default:
                 break;
@@ -2153,7 +2155,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 
*reason,
         struct vcpu_tdx *tdx = to_tdx(vcpu);

         *reason = tdx->vt.exit_reason.full;
-       if (tdx->vt.exit_reason.basic != -1) {
+       if (tdx->vt.exit_reason.basic != TDX_INVALID_EXIT_REASON) {
                 *info1 = vmx_get_exit_qual(vcpu);
                 *info2 = tdx->ext_exit_qualification;
                 *intr_info = vmx_get_intr_info(vcpu);
