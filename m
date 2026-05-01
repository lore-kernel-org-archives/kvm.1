Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2753C8738
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645284; cv=none; b=esEfGXlDFnRi0Zp1dMTmQvsyB8BuGUfdIlcJ12iDya1jiun+XLF+SmPC5vPzI7esjlU+RFsSXD4Xq25kdkad0d4AcWPZI8DzlLtmH8xr+Vz3UqKKeoM2OR2ywkHwzn6ysDxEGbxCGt7+sJ3wtBeUuQ5l60XunqkCPJb4myknD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645284; c=relaxed/simple;
	bh=qAtodJ9TKmiZz4msSUj9WtzN6/ujAzAtgV0rPu56XbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3uQ5/AZ2zvMNeae5VdWgEqdrahxqyIT6ztdqVsLab9F7L1Ghq6jPVAVC3uaVAvSV3K7cMKrM91xp28l0DDfD0FUYMa96EXkFtpK6rdTE8mp6q/zCbkZc4GvUAVHobJDDZvDBjNA1OX7crtxSvfyQHFjp2oVVatDQA/6lXniwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVSDn+PU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVSDn+PU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44b052142e1so244425f8f.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777645281; x=1778250081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBnnGCpYSonyRl/RZZsL4XC/Tyffyj/BGojejPAjpWk=;
        b=yVSDn+PUl+T7PFQkGzUSblXvQaMyEALGpyImP+CkFxyZSUc4lOQqwuhLvSTcPLfkup
         imBExeip97dSMlpG9rZMA4mU7EkG0yZ8Vo9/i3J60T6rJT6Zv7cMvuuW3cfDj28ROVr3
         Xf6zubp8JJSukO26cHmNZvAjQHSUYK4vh5d7cK2qiokae2dXHzN3GSdJvTn1+yVFX2Xn
         3HjqutxuJmfENdjUEADQiwkjfz5gcmaRmMLYEJQul1s7VEcLbhghJ2bMKZs8eE4n76g1
         k5/w4PSCUf5heqEgDqQ4lm1djuBuwevNsnl6HfKeP+wtFN/tI9vOKtOJ5yKgrZxol5sZ
         SofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645281; x=1778250081;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBnnGCpYSonyRl/RZZsL4XC/Tyffyj/BGojejPAjpWk=;
        b=MMKw9/skus4dR+2A1gQ3M0ewzY1okFhAmmjbnBIPMXa5YaK1geSn2kKA30UIlHdgFZ
         oPvaJE9VkD3seCENDHO44X5fxvMrjHh3UmYUyZ/U+a+65x/bfwMFmtt1yfW6ekLISsJG
         vy3IYIGTTAMyeVMNQ9Xzgj7mo8Fy/KuMGWa6xIAagI+y6HBtLqdjusmhn34V1msex4te
         gaZ+qh4NNTRZyO1uBkx9FC0T8k5HdSX7DPaECM3OanhrRmUKWDXEGrfgRJkvt5z61lLO
         0aoAv8ILaXxBPXDXC59Xchy4EA6pJEe5SaZwckPMu9jjgiTtzEHw17Ih05uwZJdhkOAy
         jKdw==
X-Forwarded-Encrypted: i=1; AFNElJ/dHWJlTYlPatKj6KcgnK1tlV9GyGgfcu9h5FvnVzVk34umugDTBpmNkYPv++pHhJ183/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqhf8V30Wr3iU3jCjkMLzYok57eW1Ta9FYOsPumTK+Ir0ih++p
	8BcpDxEKBbeRw10I46+Tr8GcErLXByKhoPQt1NTKEdS6BgwStk/nbzYh68SJgqvD130=
X-Gm-Gg: AeBDieta1FIaWjGnbsp4sOgJCTFA/6vG10I6vu1rb/9eU/IUjAcPxem4/aXdHNVksMV
	IaVa5+fKZxyouTXinGHGSubfrTA3W+posQUxuoQqM2Glovn3t+tQaRb552bNKG5MU6gtZCX3Fra
	qygiX+ixRcxQcgG3oONIel5hJcpIIcvd/Zt93PHYKTDwBBVcGPYrCAv9qBaXezD28xP9u6WEPG0
	eKLa2cgC/H06YDtQqPA7EV+CHqGDMBVlrEnLe8I7XTvdmADjZTE0HFixBNQjalJWNUWGnMSkuVb
	+hf7dEYNIIzjkKsL6R8BjJrKBcuBmuvXA3gttfPFyz4i5Cm1tMA/YDU9RjkOgODymZg4M+Xa4kR
	u5yfoWDxSsCpqjSO/LiGKfadclb8SEJXJbZo5SMc0yBoxLKN8D8qWfHnW1Y/Frk6lMP0UxT6QpW
	F2xEEPlprqiLo1cC8pEgJKvquMelkYZ8oEjA==
X-Received: by 2002:a5d:5d83:0:b0:43f:e413:f6fd with SMTP id ffacd0b85a97d-44a83318609mr5106522f8f.0.1777645281205;
        Fri, 01 May 2026 07:21:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa3a5sm5802041f8f.26.2026.05.01.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:21:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8A2A75F8FC;
	Fri, 01 May 2026 15:21:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: qemu-devel@nongnu.org,  Andrew Jones <andrew.jones@linux.dev>,  Eric
 Auger <eric.auger@redhat.com>,  "open list:ARM" <kvmarm@lists.linux.dev>,
  "open list:Default mailing list" <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH] arm: add wfx test case
In-Reply-To: <afSnVJLe7HrB6ISS@raptor> (Alexandru Elisei's message of "Fri, 1
	May 2026 14:15:14 +0100")
References: <20260427130045.3669851-1-alex.bennee@linaro.org>
	<afSnVJLe7HrB6ISS@raptor>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 01 May 2026 15:21:19 +0100
Message-ID: <87zf2jcisg.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi Alex,
>
> On Mon, Apr 27, 2026 at 02:00:45PM +0100, Alex Benn=C3=A9e wrote:
>> This is based on a similar test case I wrote for QEMU's tcg tests althou=
gh
>> obviously able to take advantage of kvm-unit-tests additional plumbing f=
or
>> dealing with the GIC and IRQs.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  arm/Makefile.arm64        |   1 +
>>  lib/arm64/asm/processor.h |   7 ++
>>  lib/arm64/asm/sysreg.h    |   3 +
>>  arm/wfx.c                 | 137 ++++++++++++++++++++++++++++++++++++++
>>  arm/unittests.cfg         |   5 ++
>>  5 files changed, 153 insertions(+)
>>  create mode 100644 arm/wfx.c
>>=20
>> diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
>> index a40c830d..52b3f35d 100644
>> --- a/arm/Makefile.arm64
>> +++ b/arm/Makefile.arm64
>> @@ -64,6 +64,7 @@ tests +=3D $(TEST_DIR)/cache.$(exe)
>>  tests +=3D $(TEST_DIR)/debug.$(exe)
>>  tests +=3D $(TEST_DIR)/fpu.$(exe)
>>  tests +=3D $(TEST_DIR)/mte.$(exe)
>> +tests +=3D $(TEST_DIR)/wfx.$(exe)
>>=20=20
>>  include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>>=20=20
>> diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
>> index 32ddc1b3..2104036d 100644
>> --- a/lib/arm64/asm/processor.h
>> +++ b/lib/arm64/asm/processor.h
>> @@ -173,5 +173,12 @@ static inline bool system_supports_rndr(void)
>>  	return ((id_aa64isar0_el1 >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf) !=3D =
0;
>>  }
>>=20=20
>> +static inline bool system_supports_wfxt(void)
>> +{
>> +	u64 id_aa64isar2_el1 =3D read_sysreg_s(ID_AA64ISAR2_EL1);
>> +
>> +	return ((id_aa64isar2_el1 >> ID_AA64ISAR2_EL1_WFxT_SHIFT) & 0xf) !=3D =
0;
>> +}
>> +
>>  #endif /* !__ASSEMBLER__ */
>>  #endif /* _ASMARM64_PROCESSOR_H_ */
>> diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
>> index f2d05018..cb96a649 100644
>> --- a/lib/arm64/asm/sysreg.h
>> +++ b/lib/arm64/asm/sysreg.h
>> @@ -77,6 +77,9 @@ asm(
>>  #define ID_AA64ISAR0_EL1_RNDR_SHIFT	60
>>  #define ID_AA64PFR1_EL1_MTE_SHIFT	8
>>=20=20
>> +#define ID_AA64ISAR2_EL1		sys_reg(3, 0, 0, 6, 2)
>> +#define ID_AA64ISAR2_EL1_WFxT_SHIFT	0
>> +
>>  #define ID_AA64MMFR0_EL1_FGT_SHIFT	56
>>  #define ID_AA64MMFR0_EL1_FGT_FGT2	0x2
>>=20=20
>> diff --git a/arm/wfx.c b/arm/wfx.c
>> new file mode 100644
>> index 00000000..912e50e6
>> --- /dev/null
>> +++ b/arm/wfx.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * WFX Instructions Test (WFI, WFE, WFIT, WFET)
>> + *
>> + * Copyright (c) 2026 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <libcflat.h>
>> +#include <asm/processor.h>
>> +#include <asm/gic.h>
>> +#include <asm/timer.h>
>> +#include <asm/io.h>
>> +
>> +#define TIMEOUT 200000
>> +
>> +#define sev() asm volatile("sev" : : : "memory")
>> +#define sevl() asm volatile("sevl" : : : "memory")
>> +#define wfi() asm volatile("wfi" : : : "memory")
>> +#define wfe() asm volatile("wfe" : : : "memory")
>> +
>> +#define wfit(reg) \
>> +	asm volatile(".arch armv8.7-a\n\twfit %0" : : "r" (reg) : "memory")
>> +#define wfet(reg) \
>> +	asm volatile(".arch armv8.7-a\n\twfet %0" : : "r" (reg) : "memory")
>> +
>> +static void timer_handler(struct pt_regs *regs)
>> +{
>> +	/* Disable timer to stop IRQ from re-firing */
>> +	write_sysreg(0, cntv_ctl_el0);
>> +}
>
> It is customary for the interrupt handler to ack the interrupt at the GIC=
 level.
>
>> +
>> +static bool check_elapsed(uint64_t start, uint64_t threshold, const cha=
r *test, bool more)
>> +{
>> +	uint64_t end =3D read_sysreg(cntvct_el0);
>> +	uint64_t elapsed =3D end - start;
>> +	bool pass =3D more ? elapsed >=3D threshold : elapsed <=3D threshold;
>> +
>> +	report(pass, "%s (%ld ticks)", test, elapsed);
>> +
>> +	if (!pass) {
>> +		report_info("%s %s", test, more ? "woke too early" : "slept despite S=
EV");
>> +	}
>> +	return pass;
>> +}
>> +
>> +static void test_wfi(void)
>> +{
>> +	uint64_t start;
>> +
>> +	report_info("Testing WFI...");
>> +
>> +	start =3D read_sysreg(cntvct_el0);
>> +	write_sysreg(TIMEOUT, cntv_tval_el0);
>> +	write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
>> +	isb();
>> +
>> +	local_irq_enable();
>> +	wfi();
>
> Consider this scenario:
>
> 	local_irq_enable();
> 	// CPU takes the interrupt, handles it and returns.
> 	wfi(); <- CPU now waits forever for an interrupt that will never come
>
> The proper way to do it on baremetal would be:
>
> 	local_irq_disable();
> 	// Program timer to fire
> 	wfi();
> 	// Timer fires, GIC asserts the interrupt, WFI completes
> 	local_irq_enable();
> 	// CPU handles the interrupt
> 	check_elapsed(..)
>
> But this is not baremetal. KVM can decide not to trap WFI (look at
> arch/arm64/kvm/arm.c::kvm_arch_vcpu_load() -> kvm_vpcu_should_clear_twi()=
). In
> that case, the WFI might complete due a host interrupt, and check_elapsed=
() will
> fail because the timer hasn't yet fired.
>
>> +	local_irq_disable();
>> +
>> +	check_elapsed(start, TIMEOUT, "WFI", true);
>> +}
>> +
>> +static void test_wfe(void)
>> +{
>> +	uint64_t start;
>> +
>> +	report_info("Testing WFE/SEV...");
>> +	sev();
>> +	start =3D read_sysreg(cntvct_el0);
>> +	wfe();
>> +	check_elapsed(start, TIMEOUT, "WFE/SEV", false);
>> +
>> +	report_info("Testing WFE/SEVL...");
>> +	sevl();
>> +	start =3D read_sysreg(cntvct_el0);
>> +	wfe();
>> +	check_elapsed(start, TIMEOUT, "WFE/SEVL", false);
>> +}
>
> I haven't thought about this too much, but it looks to me like the same
> situation with WFI can happen with WFE
>
> Also, kvm-unit-tests() makes use of WFE and SEV for multithreading, and t=
he fact
> that multithreaded tests work at all might be taken as proof enough that =
the two
> instructions are correctly implemented.

So I'm using kvm-unit-test to exercise QEMU's TCG modelling of the
instructions, see:

  Message-ID: <20260430104434.1482407-1-alex.bennee@linaro.org>
  Date: Thu, 30 Apr 2026 11:44:27 +0100
  Subject: [PATCH v4 0/7] target/arm: fully model WFxT instructions for A-p=
rofile

So while I'm confident the current modelling doesn't cause issues
(because we basically treat it as a NOP) I wanted to check the various
modes behave as they should with the above patches.

I can limit the test to TCG only if it is likely to fail under KVM.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
