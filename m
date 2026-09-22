Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719D3655C4;
	Tue, 22 Sep 2026 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043553; cv=none; b=rA0gNj4cseUtKP3HTFY3Pqbbacb5MZq7T//ccZHJrgAtwC9FYXT+JY06u9V+8g3ytmRgLkvu6PpziJAyWMPD5roIHcbAmu0XxcXZ1bV70sm+fkIUotSttmEd/csGG6bKKCgDMAdm1oI76bDzgfr//iay23tCH0u5RdcLJp8Oyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043553; c=relaxed/simple;
	bh=gHb3xNQFgzy0L0N89cPTUJAdb26eVCNqf+BBOHwEcQs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2IOLfhBOTGyiF4/Aye9qAix32tJiXNEVb1klEbBmnEoXKZ7aTtp8y82JxxHwtVDiZC1n1Oa0QhlsdU0NNRb/UnDA8h7sdPAIPTWbwbV1bk2kZQvA8+jKTRBdcyj1S7/LJ/ZKqUmHnv0wvbW4S8dvrGHlc/t9/Ihen/3350ES3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zxbjcas.zhaoxin.com (localhost [127.0.0.2] (may be forged))
	by zxbjcas.zhaoxin.com with ESMTP id 68M1ta7x036101;
	Tue, 22 Sep 2026 09:55:36 +0800 (GMT-8)
	(envelope-from ewanhai-oc@zhaoxin.com)
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166])
	by zxbjcas.zhaoxin.com with ESMTP id 68M1stPi035895;
	Tue, 22 Sep 2026 09:54:55 +0800 (GMT-8)
	(envelope-from ewanhai-oc@zhaoxin.com)
Received: from ewan-server (ewan-server [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP5eb06f889ea6906e87c23e5cda0450ee
	Tue, 22 Sep 2026 09:54:53 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Tue, 22 Sep 2026 09:54:51 +0800
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH v2 6/9] KVM: selftests: Skip PERF_CAPABILITIES vCPU
 checks without PDCM
Message-ID: <arHesdC4MieHtZUr@ewan-server>
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
 <20260910115414.3015260-7-ewanhai-oc@zhaoxin.com>
 <aqQqJysVQxS76YIE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQqJysVQxS76YIE@google.com>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:zxbjcas.zhaoxin.com 68M1ta7x036101

On Fri, Sep 11, 2026 at 09:19:51AM -0700, Sean Christopherson wrote:
> On Thu, Sep 10, 2026, Ewan Hai-oc wrote:
> > From: Frank Zhu <frankzhu@zhaoxin.com>
> > 
> > KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES through
> > KVM_GET_MSRS even when PDCM is not exposed in KVM_GET_SUPPORTED_CPUID.
> > However, vCPU accesses to the MSR fail without PDCM.
> 
> Hrm, no, KVM is supposed to allow reads and drop writes of '0' for MSRs that are
> advertised to userspace, but ultimately unsupported.  I'm pretty sure this is a
> KVM bug.  I think MSR_IA32_ARCH_CAPABILITIES is also affected.
> 
> Completely untested, but I think this?
> 
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index dd3bb04878ca..fa77cfdbda7e 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -512,9 +512,15 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  
>  	switch (index) {
>  	case MSR_IA32_ARCH_CAPABILITIES:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_CAPABILITIES))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +
>  		*data = kvm_get_arch_capabilities();
>  		break;
>  	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_PDCM))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +
>  		*data = kvm_caps.supported_perf_cap;
>  		break;
>  	case MSR_PLATFORM_INFO:
>

I saw that you applied eight patches from the series to the kvm-x86
selftests branch and skipped patch 6 as a KVM bug.

We are testing the change you suggested on Zhaoxin systems with and
without PDCM support. We expect to report the results within the next
few weeks.

Thanks for applying the patches and for looking into the patch 6 issue.

