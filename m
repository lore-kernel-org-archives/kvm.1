Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B333DEF2
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725720; cv=none; b=BebfwsWZBhQUonvlGJ84BpLpo1Z/ANkKFqxuwYgdFF2QIyJOW2cRLLbzxu57eqeOGYOpBenLk+WBKU4H2D+YaZj180xezye/uFTfMzXBpM4of/4Vtsz0kAo9zmBf+GyDL4uz99Wy4od6nNx+zeVO/owS5aZ528QL30st5WLJ3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725720; c=relaxed/simple;
	bh=qL1w7N4RktuU9IJF16NjAmubV1t14JvjYacjyT6EkBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Onz6KtTz16n9tlVBESGwCl5TVX63pB9Y16yx1ZfGwH2TXonBfXVVQRNl2yBANEHOXUD79btXOekP5ShTCbcltt50aW/tDBrvQWsaB+6ixudOnQGXpsYS5EhyQeqB78SCto7+ZAhfh53pQ1HPUajN9ZZyAK9x8ZMJ7ixw9kdAwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09736873|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0312854-0.002808-0.965907;FP=497998581993670323|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.iSA1Prm_1784725387;
Received: from 192.168.124.3(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iSA1Prm_1784725387 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 22 Jul 2026 21:03:07 +0800
Message-ID: <c30591dd-845a-4b8d-961e-73e3e2e5ab2d@open-hieco.net>
Date: Wed, 22 Jul 2026 21:03:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <f794550ecf8a78ce7095d699a7508bc8cc955679.1783999988.git.zhang_wei@open-hieco.net>
 <20260714053140.5813C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260714053140.5813C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/14/2026 1:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditionally setting bit 63 in EXITINFO1 for CR read intercepts.
> --
> 
> --- Patch [2]: [PATCH v2 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts ---
> commit 12fdeb07951db9a20a07afc60e302f9b9e4fcaca
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
> 
> This commit populates the architectural EXITINFO fields when DecodeAssists is
> exposed to L1 and an emulated intercept occurs. It generates EXITINFO1
> depending on the intercept type, such as CR/DR accesses and INTn.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e02a38da5296e..cc35afb59623f 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -4754,6 +4754,52 @@ static const struct __x86_intercept {
>>   #undef POST_EX
>>   #undef POST_MEM
>>   
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
>                  ^^^^^^^^^^^
> [Severity: High]
> Does this code incorrectly set bit 63 of EXITINFO1 for CR reads?
> 
> According to the AMD Architecture Programmer's Manual (APM), bit 63 of
> EXITINFO1 for a CR intercept indicates the operation type, where 1 means a
> write to the CR and 0 means a read from the CR. By unconditionally setting
> BIT_ULL(63) for both x86_intercept_cr_read and x86_intercept_cr_write,
> wouldn't KVM report CR reads as CR writes to the L1 hypervisor?
> 
> If an L2 guest executes a MOV from CR instruction, this could cause the L1
> hypervisor to corrupt its shadow CPU state or misbehave, because it will
> be provided a malformed EXITINFO1 and handle the event as a write operation
> rather than a read.
Thanks for the report, but bit 63 is not the CR access direction.

According to the APM, EXITINFO1[63] indicates that the intercepted
instruction was a MOV CRx instruction, and EXITINFO1[3:0] contains the
GPR number.  The MOV-from-CR0 special case also explicitly states that
bit 63 is set for MOV-from-CR.

The read/write direction is encoded in EXITCODE, i.e.
SVM_EXIT_READ_CRx versus SVM_EXIT_WRITE_CRx.  KVM's existing CR
intercept handler likewise treats bit 63 as CR_VALID and derives the
access direction from EXITCODE.

Therefore, setting bit 63 for both x86_intercept_cr_read and
x86_intercept_cr_write is intentional.

Thanks,
Tina

> 
>> +		break;
> 

