Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE754749E8
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057461; cv=none; b=RqRL0xIfvKPJcoU/JcNrq09uF49bKCF7+QW+UK4sof/QvKmrK+yvgyc3qJGzOcjoHkvb2ig7smnx3DSx+OppCVJ3FNilGlS/aqFVpxaiA3Tyx2uCWgySLuzaqUFGcy3UZp7y0gLOswS4EKf4ehyuVS0G5/M3MRLFfDc+DyHPQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057461; c=relaxed/simple;
	bh=yDxDlyqLp5oTixkhjTCkGBUE3dyTpe4DBIToh/U/hNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNbFyMc1im7/v2y9FX/1YXQwzJEn8IwVEH0vlxvwWm5nM9Lmxg2D2NTLLwY2ds49l0zzw2TcLrD4sn8zKms+9QkZZZ0LLPuOvxAlu80CUQuXFAk91DIsfY8AfEFDkissF6/fwxrSH21waSm53Hgtl17qpjmkINWSjO9m6BDV9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8wHlBUK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8wHlBUK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so58482755ad.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787057455; x=1787662255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QydW9EfPsAktXSdxMNlPMiQEqHQr57p4gRR6UU4ns3M=;
        b=j8wHlBUKiJtDpoj/R8/XCZjuUdrvsicpJZfkiv62BeG5Ua49gGDgnRnZo3/7VZU8Kz
         XzS0bVWoofbz6/kzjYMvrAfUSpZ+1ROPUPqXlEL7UKTUCPjYlD7pnc79vcNtvbLV8BXo
         WM4DLvESF8bBCPvMWxDpWcZv97qWHBsrBYdo1lSobWq1dMzcI532OOYzcyDrEtiN5vNt
         /Kv4J9I4URXHYfUhzlLD3C7se0DdRadI1jVWl+FAP4I6YurbP7bAExzXSPOT2y1x9Yxr
         mq2sheY0DKWRbvK0Mcnv9UI7xcwNDyTcXYQOnEcfEy/XMxmLFTXGJhd+hDL923jsTmaZ
         GRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057455; x=1787662255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QydW9EfPsAktXSdxMNlPMiQEqHQr57p4gRR6UU4ns3M=;
        b=pZLb3+a+3rejUiKNCFi3c1SmyjvotQR7jGKauZH5pdpzeU0/haS26IykPTYJ55toGu
         uTAsf819wZHWPcLGBQBjUqCHcN54vqeC2D5aP3DWBH0WR0YJRcG1k8HpoQ9lekmzvz2f
         xWa5NGPgOHcpHkMBC0JqCxzRau5Mg1F3AMFyKoY2oegojd84b//da/g3yhwSZDUWoamG
         8xDD3X9pxVgP0nw11SS6dOfxCcjQKDGz7oi02t7iga8AlQ/AXPXA7oHrntb9Pz0z4xlz
         CX/LLoBPwvE+aBQll5uHezDpOAfNT8NkZNJEqPr9w+0Yz+zT/YSYqyYLA2y0EATVpJ9N
         4y4A==
X-Forwarded-Encrypted: i=1; AHgh+RoN/MrhHRVmpshB5S62VCHPkIQwrouZvj9GoOlUZqEv/u8hXSVzbSBaZXHvmj/UyrMCrUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQbRBmWqKtXLyYLADSvecD/HjLZSlalWcpvoUVo44BW81QqCg
	WzsV6tHjLsd/PQFoJNwycFc+clELuhQdZXZ5bAl40auC16L4c6LmP1kzIo5HOqooRvA=
X-Gm-Gg: AR+sD13hTMTLgvTogVr2j5ljLC3e8dVxOteDttd4bYodi3+WrP/s+QtIdibf1eR093F
	HNvEEBvEuz6XOEI2+P9fHlnAeM/mtBbJ8dkBclR8uWU8a+GZaF7+x/p2BdO40W54Ie6VwKsscb0
	1WsUuCxAsSCjnJ4/IrRd73z6Nq9IAcJYw/Y4EQrRroQQvrkgXPkdM6w6mkq60L0auWU/8K6vMq7
	1OUajChoCm336wR7AJwyjLkLdW+umE8JZdan9GpBrUT3MS7//usa02/33U81SqYB3nOp9s/bybk
	X/TboRxoKXeUEhGxkELwgeB0a02GsUGO7r9S6AtWcK+FuPaxlKiKC5B7L9CM95pDLjd25YicJ9r
	GL7B6X0of7zjwFVGsvPZuBR31PDXH3olUZLgAylH1SsSoC4p8GOi9ALkg61uTyhe/LkltFDveUP
	WTHkHy6DauNhGtxR1RGVqZYwQ13MQ53XjjzvX3eqazH9wKpH/uYki70YRNXpJiR6EUQWnc6NJpV
	5Pg0GcG86mxjDww2iUIm1/3UW4=
X-Received: by 2002:a17:903:1a08:b0:2d3:7887:7e7f with SMTP id d9443c01a7336-2d3b0c5de30mr412838845ad.11.1787057454413;
        Tue, 18 Aug 2026 05:50:54 -0700 (PDT)
Received: from [10.26.143.42] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ef83d6sm14172995ad.78.2026.08.18.05.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 05:50:54 -0700 (PDT)
Message-ID: <6799252e-d310-442a-87c3-279d0d71ecef@gmail.com>
Date: Tue, 18 Aug 2026 20:50:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: selftests: arm64: Skip sea_to_user when EINJ
 places no poison
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, sashiko-reviews@lists.linux.dev
References: <20260818112920.26252-1-likexu@tencent.com>
 <20260818112920.26252-4-likexu@tencent.com>
 <20260818114103.433F01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <20260818114103.433F01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 7:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The check skips the test unconditionally on any guest assertion failure, masking unrelated or future bugs.
> --
> 
> --- Patch [3]: [PATCH v2 3/3] KVM: selftests: arm64: Skip sea_to_user when EINJ places no poison ---
> commit 3bedaa634d562c6cc85fb3726d30fa40f0ed350d
> Author: Like Xu <like.xu.linux@gmail.com>
> 
> KVM: selftests: arm64: Skip sea_to_user when EINJ places no poison
> 
> This commit modifies the sea_to_user selftest to skip rather than fail
> when the firmware does not leave consumable poison in memory. It detects
> this condition by checking if the exit reason is not KVM_EXIT_ARM_SEA
> and a UCALL_ABORT is received from the guest.
> 
>> diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> index 7cf95da8e594d..d4af6e0eed288 100644
>> --- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> +++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> @@ -215,13 +215,33 @@ static void run_vm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>>   
>>   	ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
>>   		       exit_reason_str(run->exit_reason));
>> +
>> +	/*
>> +	 * The guest's read of the injected location is expected to trap to KVM
>> +	 * as an SEA. If it does not, the injected error was never placed as
>> +	 * consumable poison: some firmware honours EINJ's notrigger request by
>> +	 * arming the poison only as part of the (now skipped) trigger step, so
>> +	 * nothing is left in memory for the guest to consume. The guest then
>> +	 * reads back the sentinel value and reports it via GUEST_FAIL, which
>> +	 * arm64 delivers as a ucall over MMIO (hence a KVM_EXIT_MMIO here).
>> +	 * Treat that as "this platform cannot host the test" and skip, matching
>> +	 * the requirement documented at the top of this file, rather than
>> +	 * failing on a hardware/firmware limitation the test cannot control.
>> +	 */
>> +	if (run->exit_reason != KVM_EXIT_ARM_SEA &&
>> +	    get_ucall(vcpu, &uc) == UCALL_ABORT) {
> 
> [Severity: Medium]
> Does this unconditionally skip the test on any guest assertion failure,
> masking unrelated or future bugs?
> 
> If KVM fails to exit to userspace and instead incorrectly injects a
> Data Abort to the guest with an unexpected syndrome, the guest's SEA
> handler might fail a GUEST_ASSERT_EQ check. This would emit a
> UCALL_ABORT over MMIO.
> 
> The host loop here interprets any UCALL_ABORT during this phase as a
> missing EINJ poison limitation, skipping the test instead of reporting
> the failure.
> 
> Can we check the specific assertion failure reason or uc.buffer string
> instead of catching all UCALL_ABORTs?

For any human to double check:

diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c 
b/tools/testing/selftests/kvm/arm64/sea_to_user.c
index 7cf95da8e594d..f1d156d7645cc 100644
--- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -165,11 +165,16 @@ static void guest_code(void)
  {
  	u64 guest_data;

-	/* Consumes error will cause a SEA. */
+	/* Consuming a real poison faults as an SEA and never returns here. */
  	guest_data = *(u64 *)EINJ_GVA;

-	GUEST_FAIL("Poison not protected by SEA: gva=%#lx, guest_data=%#lx\n",
-		   EINJ_GVA, guest_data);
+	/*
+	 * The read returned, so this platform placed no consumable poison.
+	 * Report the value read as a positive signal that is distinct from a
+	 * GUEST_ASSERT failure, so the host can skip on this limitation without
+	 * masking a genuine SEA-handling failure.
+	 */
+	GUEST_SYNC1(guest_data);
  }

  static void expect_sea_handler(struct ex_regs *regs)
@@ -215,13 +220,46 @@ static void run_vm(struct kvm_vm *vm, struct 
kvm_vcpu *vcpu)

  	ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
  		       exit_reason_str(run->exit_reason));
+
+	/*
+	 * The guest's read of the injected location must trap to KVM as an
+	 * SEA. If the exit is something else, decode what the guest did before
+	 * deciding whether to skip or fail:
+	 *
+	 *  - UCALL_SYNC: the read returned instead of faulting, so no
+	 *    consumable poison was placed. Some firmware only arms EINJ poison
+	 *    as part of the trigger step that notrigger=1 skips, leaving
+	 *    nothing for the guest to consume; arm64 delivers the ucall as an
+	 *    MMIO write (hence KVM_EXIT_MMIO). This platform cannot host the
+	 *    test, so skip, matching the requirement documented at the top.
+	 *  - UCALL_ABORT: the guest took an abort but its SEA handler failed an
+	 *    assertion. That is a genuine problem, so report it rather than
+	 *    masking it as the limitation above.
+	 *  - anything else: fall through to the exit-reason assertion.
+	 */
+	if (run->exit_reason != KVM_EXIT_ARM_SEA) {
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			ksft_print_msg("Guest read back %#lx without an SEA\n",
+				       uc.args[0]);
+			ksft_exit_skip("EINJ notrigger placed no consumable poison on this 
platform\n");
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			break;
+		}
+	}
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
+
+	/* arm_sea holds valid data only for a KVM_EXIT_ARM_SEA exit. */
  	ksft_print_msg("kvm_run.arm_sea: esr=%#llx, flags=%#llx\n",
  		       run->arm_sea.esr, run->arm_sea.flags);
  	ksft_print_msg("kvm_run.arm_sea: gva=%#llx, gpa=%#llx\n",
  		       run->arm_sea.gva, run->arm_sea.gpa);

-	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
-
  	esr = run->arm_sea.esr;
  	TEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_LOW);
  	TEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);

> 
>> +		ksft_print_msg("Guest consumed no SEA: %s", uc.buffer);
>> +		ksft_exit_skip("EINJ notrigger placed no consumable poison on this platform\n");
>> +	}
>> +
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
>> +
>> +	/* arm_sea holds valid data only for a KVM_EXIT_ARM_SEA exit. */
>>   	ksft_print_msg("kvm_run.arm_sea: esr=%#llx, flags=%#llx\n",
>>   		       run->arm_sea.esr, run->arm_sea.flags);
>>   	ksft_print_msg("kvm_run.arm_sea: gva=%#llx, gpa=%#llx\n",
> 

