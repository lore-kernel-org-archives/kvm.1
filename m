Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1222F3C18
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593632; cv=none; b=H+B9ITKn1/zneSUCJ4ttxAWrgthRMUVF1mEM0XDTTpNXn9MHAy7YKu4nkCdcbGZDcqq8oypwKruYEeGZn7GhTJW4wJGkz7Sr5TBPu0Qk12OOd4ogbg6TAEPlCUJt2/kkrqy0wmBJBIjYtDxVS6BeK2dnYBl5d31ZasWB7eNn02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593632; c=relaxed/simple;
	bh=48n+PIx5SYWw7YnTqfji9aLdKgIsVTBFMaBGAKvUAx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHh2eJfXpicOzuSebq1uXHxKfmX04FG2k45w8/gROlvfM0VzQG0T8PYpkG3/IymgaGk18ZVa5c29GVRXNZtpbkXFZvGNViNmlb6lVzvx/AIEXvjG5nbPY52MaL6nK3wXXNzQoot/+oX7im+S3C+IYTOMuREM7QgqbPFp+nyMiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0909289|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0200195-0.000325931-0.979655;FP=7811912649937782567|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.ikx0Cbo_1786593302;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ikx0Cbo_1786593302 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 11:55:02 +0800
Message-ID: <3ba91bb9-312a-4b55-9cb5-ae53bfb8dacf@open-hieco.net>
Date: Thu, 13 Aug 2026 11:55:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] KVM: x86: Add helper to provide intercept linear
 addresses
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <233ea37ecf646692c2d2aa6d335643c3dbb1fe09.1785411877.git.zhang_wei@open-hieco.net>
 <20260730123830.A3EF01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260730123830.A3EF01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch computes `intercept_linear_addr` and adds it to `x86_instruction_info`, but fails to actually use it in the architecture-specific intercept handlers (`svm_check_intercept` and `vmx_check_intercept`), leaving a severe preexisting bug unfixed.
> --
> 
> --- Patch [1]: [PATCH v3 1/9] KVM: x86: Add helper to provide intercept linear addresses ---
> commit e0c208c3018cdb4b9689064eac5e998c1b4d07df
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: x86: Add helper to provide intercept linear addresses
> 
> This commit adds get_intercept_linear_addr() to compute the linear address
> for INVLPG intercepts. It passes this address through x86_instruction_info
> so intercept handlers can use it directly without duplicating the calculation.
> 
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
> [ ... ]
>> @@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>>   		.src_type   = ctxt->src.type,
>>   		.dst_type   = ctxt->dst.type,
>>   		.ad_bytes   = ctxt->ad_bytes,
>> +		.intercept_linear_addr = get_intercept_linear_addr(ctxt, intercept),
>>   		.rip	    = ctxt->eip,
>>   		.next_rip   = ctxt->_eip,
>>   	};
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it looks like the architecture
> backends might still need to be updated to consume this new field.
> 
> If an L2 guest executes an INVLPG instruction that KVM intercepts and emulates,
> and L1 is also intercepting INVLPG, the KVM emulator populates
> intercept_linear_addr here.
> 
> However, if the handlers in arch/x86/kvm/svm/svm.c:svm_check_intercept() and
> arch/x86/kvm/vmx/vmx.c:vmx_check_intercept() don't use this new field, does
> KVM synthesize nested VM-exits for INVLPG incorrectly?
> 
> For SVM, if it falls through to the default case and leaves
> vmcb->control.exit_info_1 unmodified, could this leak previous host or
> VM-exit data to the L1 hypervisor?
> 
> For VMX, does lacking a case for x86_intercept_invlpg entirely cause it to
> return X86EMUL_UNHANDLEABLE and fail emulation?
> 
> Should the hardware intercept handlers be updated in this series to prevent
> stale data leakage and L2 DoS?

The SVM consumer is added in patch 2/9.
svm_prepare_decode_assist_exit_info() uses
info->intercept_linear_addr for x86_intercept_invlpg and writes it to
EXITINFO1 before constructing the nested VM-Exit.

The absence of x86_intercept_invlpg handling in vmx_check_intercept()
predates this series.  VMX does not implement SVM DecodeAssists or VMCB
EXITINFO semantics, and patch 1 does not change the existing VMX
behavior.  Supporting emulated nested VMX INVLPG would be a separate
change.

Thanks,
Tina

> 

