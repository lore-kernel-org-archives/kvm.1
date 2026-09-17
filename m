Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB841D217;
	Thu, 17 Sep 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633388; cv=none; b=ovLVbfAwV0zP0GZTa4RvpSHjARDX0IlRcuQSdkzEvfyZCsoO0RFhTg/83mP+CxqSJSwVt+7BIt7wXuf7H+zpdpnpNmGkhmUbarEN0HcrLBykiIzjXSq1kU5SsIpRY8YvS1OoGLfadpXoO6lt4B+6fbJiAmvhgoO0WLbhkSYVgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633388; c=relaxed/simple;
	bh=6S4t0ZgT2gB/7xqWgjdCX+82wx4t5+lvGMecv1HXUNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSgrFC9ifPMG5SrJfbpLXCvmsh71DfCdq5geXqURdfFuPMDuUQOyVcBfJcgB7BHOelD6HWzteN1PP1Ne27QITdXTGnGyuqz1TiOCvm1h+Ow2WLQ1I8W3GorwlLmqHwlkzObuqpv8a1Lx7u71K0B0MIIP+HDh1LJxElAdIClp7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439085|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.230025-0.00361779-0.766357;FP=10359120858868172667|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jFj6VNe_1789633368;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jFj6VNe_1789633368 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:22:51 +0800
Message-ID: <cd63935b-8239-4caf-8e97-0896ab7743f1@open-hieco.net>
Date: Thu, 17 Sep 2026 16:22:48 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add nested SVM DecodeAssists test
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
 <016ecb3a3187b20fac299f1c2cb15aac01358412.1789281096.git.zhang_wei@open-hieco.net>
 <CALMp9eSnoFAk5PN-JudLc=xB6jzKzERfTVPEeAaRbLTYqtnKKA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eSnoFAk5PN-JudLc=xB6jzKzERfTVPEeAaRbLTYqtnKKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/15/2026 6:33 AM, Jim Mattson wrote:
> On Sat, Sep 12, 2026 at 11:44 PM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> Add a focused nested SVM selftest for DecodeAssists.  Verify that KVM
>> exposes the feature to L1 and synthesizes EXITINFO for representative
>> MOV CR/DR, CLTS, INTn, INVLPG, and INVLPGA intercepts.
>>
>> Exercise instruction bytes for hardware and synthesized #NPF/#PF exits.
>> Cover a synthesized #NPF that follows a hardware #NPF in the same emulated
>> instruction, an unreadable instruction tail that leaves only the cached
>> opcode, and the absence of bytes for an instruction-fetch #PF.  Modify the
>> MOVSB opcode while its MMIO read is pending to verify that the emulator's
>> cached bytes are preserved.
>>
>> Inject a userspace #PF while an MMIO read is pending.  Verify that after
>> MMIO completion, L1 receives instruction bytes from the current RIP,
>> not the previous instruction's emulator cache.
>>
>> The synthesized OUTSB #NPF and userspace-injected #PF cases run by
>> default.  The forced-emulation #PF and instruction-intercept cases
>> require kvm.force_emulation_prefix=1.
>>
>> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
>> ---
>> ...
>> +static const struct instruction_intercept_test instruction_intercept_tests[] = {
>> +       {
>> +               .name = "MOV-from-CR4",
>> +               .code = l2_fep_mov_from_cr4_code,
>> +               .intercept_cr = BIT(INTERCEPT_CR4_READ),
>> +               .exit_code = SVM_EXIT_READ_CR4,
>> +               .exit_info_1 = BIT_ULL(63) | 10,
>> +               .exit_info_1_mask = ~0ULL,
>> +       }, {
>> +               .name = "MOV-to-DR7",
>> +               .code = l2_fep_mov_to_dr7_code,
>> +               .intercept_dr = BIT(INTERCEPT_DR7_WRITE),
>> +               .exit_code = SVM_EXIT_WRITE_DR7,
>> +               .exit_info_1 = 3,
>> +               .exit_info_1_mask = ~0ULL,
>> +       }, {
>> +               .name = "CLTS",
>> +               .code = l2_fep_clts_code,
>> +               .intercept_cr = BIT(INTERCEPT_CR0_WRITE),
>> +               .exit_code = SVM_EXIT_WRITE_CR0,
>> +               .exit_info_1_mask = BIT_ULL(63),
> 
> Should this be:
> 
> .exit_info_1 = BIT_ULL(63),
> .exit_info_1_mask = ~0ULL,

Did you mean .exit_info_1 = 0? For CLTS, bit 63 should be clear.

I tested CLTS without FEP on an EPYC 9754 and captured EXITINFO1 at
the L0 kvm_exit tracepoint, before reflection to L1. It was zero in
all cases, with CR0.TS both clear and set. Each case followed a
MOV-from-CR4 exit that populated EXITINFO1 with 0x800000000000000a.

The current mask checks only that bit 63 is clear. Would you prefer
checking the entire field against zero?

I'm a little unsure how to interpret the APM here: “If the instruction 
is LMSW or CLTS, no additional information is provided and bit 63 is
not set.” Does “no additional information” mean the remaining bits
must be zero, or simply that they contain no valid decode information
and should be ignored?


> 
> 
>> +       }, {
>> +               .name = "INTn",
>> +               .code = l2_fep_int_code,
>> +               .intercept = BIT_ULL(INTERCEPT_INTn),
>> +               .exit_code = SVM_EXIT_SWINT,
>> +               .exit_info_1 = TEST_INT_VECTOR,
>> +               .exit_info_1_mask = ~0ULL,
>> +       }, {
>> +               .name = "INVLPG",
>> +               .code = l2_fep_invlpg_code,
>> +               .intercept = BIT_ULL(INTERCEPT_INVLPG),
>> +               .exit_code = SVM_EXIT_INVLPG,
>> +               .exit_info_1 = (u64)&npf_target,
>> +               .exit_info_1_mask = ~0ULL,
>> +       }, {
>> +               .name = "INVLPGA",
>> +               .code = l2_fep_invlpga_code,
>> +               .intercept = BIT_ULL(INTERCEPT_INVLPGA),
>> +               .exit_code = SVM_EXIT_INVLPGA,
>> +               .exit_info_1_mask = ~0ULL,
>> +               .check_rax = true,
>> +               .rax = (u64)&npf_target,
>> +       },
>> +};
> 
> If you omit the FEP from the assembly in
> instruction_intercept_tests[], KVM will copy VMCS02's EXITINFO1 to
> VMCS12. Assuming L1 itself is not nested, this can be used to validate
> KVM emulator behavior against hardware. (Maybe this can be used to see
> if I'm right about CR0_SEL_WRITE, which is currently untested.)

Good idea. This will let us verify that the L0 emulator reports the same 
DecodeAssist information as the hardware.

> 
>> ...
>> +static void run_intercept_test(struct svm_test_data *svm,
>> +                              const struct instruction_intercept_test *test)
>> +{
>> +       struct vmcb *vmcb = svm->vmcb;
>> +       struct vmcb_control_area *control = &vmcb->control;
>> +       u64 expected_exit_info_1 = test->exit_info_1 & test->exit_info_1_mask;
>> +
>> +       control->intercept |= test->intercept;
>> +       control->intercept_cr |= test->intercept_cr;
>> +       control->intercept_dr |= test->intercept_dr;
>> +
>> +       control->exit_info_1 = ~0ULL;
> 
> Perhaps you should poison insn_len and insn_bytes here as well?

Makes sense.


Thanks,
Tina

