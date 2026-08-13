Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C353B637C
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598014; cv=none; b=uebniV9kZPTom1hRf1zzcrR0ymutgF4BVuv1rmU5hh9ljhwGg5Yj7qjd6tb70MeAOX9r5IjRFk8H02f4k+KiWDOEvLqDKub76z1mxz1x3JbDCSOpKsoIxQzfXXXrACE2+N4nxcYQwOs0TzmSxfx0X3hD3cqiluKWN9B6Fwyahk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598014; c=relaxed/simple;
	bh=LiT8uigoMWZFNftXGyY3ZzF76pXMrXintb98icAvOo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1z4PgZIiTehtauXyEmyYjsd62V1/uik0FG10iz9cgDKNZfvDan2LKnSr1fWsidrGScYaIlTDCIQwq3PXltt1xr4jg6cZuABCCGpSbOEet+xc9bc3bOTZbKpW+w5ma689x5sIiR4xFI7aOmik9scXnMZSAHbGH7gYuehcZL6h1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.166705|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.203107-0.00302257-0.79387;FP=5109737411339666614|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.ikx1dIp_1786597971;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ikx1dIp_1786597971 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 13:12:51 +0800
Message-ID: <8fc500dd-5a56-4d7e-b964-73dea89309b8@open-hieco.net>
Date: Thu, 13 Aug 2026 13:12:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <31fd4e46d29c57b004b635d8e6a23020cc9ba0fb.1785411877.git.zhang_wei@open-hieco.net>
 <20260730123008.9C58B1F00A3F@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260730123008.9C58B1F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Synthesized EXITINFO1 is incorrectly populated for SVM_EXIT_CR0_SEL_WRITE intercepts triggered by MOV CR0, violating the AMD APM.
> --
> 
> --- Patch [2]: [PATCH v3 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts ---
> commit 60593c4facd0e8bdc8b0aa501c98449feeced81a
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
> 
> This commit populates the architectural EXITINFO fields when DecodeAssists
> is exposed to L1 and KVM synthesizes a nested VM-Exit for emulated
> instructions. It targets specific intercepts like MOV CR/DR, INTn, and
> INVLPG.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index d68cba12c772b..b63234a2feb8d 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -4822,6 +4822,52 @@ static const struct __x86_intercept {
> [ ... ]
>> +static void svm_prepare_decode_assist_exit_info(struct kvm_vcpu *vcpu,
>> +						const struct x86_instruction_info *info)
>> +{
>> +	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
>> +	u64 exit_info_1;
>> +
>> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
>> +		return;
>> +
>> +	switch (info->intercept) {
>> +	case x86_intercept_cr_read:
>> +	case x86_intercept_cr_write:
>> +		/* MOV CRx: bit 63 set, GPR number in bits 3:0. */
>> +		exit_info_1 = BIT_ULL(63) | (info->modrm_rm & 0xf);
> 
> [Severity: High]
> Will this incorrectly populate exit_info_1 for selective CR0 writes?
> 
> In svm_check_intercept(), the exit code can be dynamically upgraded to
> SVM_EXIT_CR0_SEL_WRITE for MOV CR0 instructions:
> 
> svm_check_intercept() {
>          ...
>          cr0 = vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
>          val = info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
>          if (cr0 ^ val)
>                  icpt_info.exit_code = SVM_EXIT_CR0_SEL_WRITE;
>          ...
> }
> 
> Since svm_prepare_decode_assist_exit_info() is subsequently called and
> only checks the original instruction intercept (x86_intercept_cr_write),
> could this wrongly populate exit_info_1 with decode assist information
> instead of leaving it zero as required by the AMD architecture manual
> for SVM_EXIT_CR0_SEL_WRITE?

SVM_EXIT_CR0_SEL_WRITE does not imply that EXITINFO1 must be zero.
The exit code identifies the selective CR0 intercept, whereas the
DecodeAssist contents describe the instruction that triggered it.

For MOV-to-CR0, the APM specifies that EXITINFO1 provides the GPR
number and identifies the instruction as MOV CRx.  For LMSW and CLTS,
no additional information is provided and bit 63 is clear.

Checking info->intercept is therefore intentional, as it distinguishes
MOV-to-CR0 from LMSW when both can result in SVM_EXIT_CR0_SEL_WRITE.

Thanks,
Tina

> 
>> +		break;
>> +	case x86_intercept_clts:
> [ ... ]
> 

