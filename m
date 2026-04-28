Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F348463
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388206; cv=none; b=YwPHaignvGG0j2EPTC4iYalneFWwn69EF5UsV7ccTLTCCYvGuIx6cxXC9BLZPOQBC5d5p7svW8EzszExTX7EiyI2kOS0Ub/ntGZ5VElW15GNFwYv/qU154isVciGae8mDv4OGev9MswoyeJ4WTmwpoCKGS9don6P4cko8mbEH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388206; c=relaxed/simple;
	bh=X8gMWnnX4yynVYZQkh4AeYMeZ1urDtDjbPH/o72X4bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nfn3M6D0eLNw1l2sxoUZEz7nJSEk8xHxyqqa9MGSD/f/xyXn1NVUfn4yq4y5Wq2oEnkof1YpETBg+XFUZFaUgBmKPvL/p9eYsheBNKzFpZflh8aGZqZF3PDfFyh9ceOeTGwyO9Msi1v03sNU1fN4xb43TGu2GRO82Z5jTILS2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHV1X9oE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHV1X9oE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so99218805e9.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777388195; x=1777992995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZI5euwIVJ9QjGGXPpUqegNn9IsxNW5sxSo5xHMvQY0=;
        b=xHV1X9oEKPUz6R3yOUcDZ94VSG9irc9ovaC0ISuvgWp2so9ILmN/qTGY2gKnbUBLfM
         y5o1gOpysn11BkHGE3DchaEk5RcSbdmuG1d05N1s9Gz3UFGmcDpH507hZT9eIm3FLeZx
         jJt9CS1rKPV5so2ziFIVTwVZR47wFu8IwSnACamIamgZxLmsM9aIAeknarEzekZMZ4Ai
         97bePtU0btL3yc7NjI+BCcSoE5pUrx4y4oUnkhrysyjKoz0kiNMxdjYOKDN7eOCXh4w9
         PgFdQrQU1RcrOG5GMOpytDwAn7N1Mpy1/yXBMUmrcgzsQmQD15KhvvTlrrLA8+bC3SQL
         37wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388195; x=1777992995;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZI5euwIVJ9QjGGXPpUqegNn9IsxNW5sxSo5xHMvQY0=;
        b=okGMrX1aXOM6cjzYUT19J6Hu23UvPg1ixcc6FnTC5MxEkQcrNY5HW6X69Ru/Jq6E3P
         dmI1EfSCEotMTv+a4wlQ7V/7SrBAARGV7o+vmxByH6NHKtnf8JC3Cz3DJOacRhzqRIYE
         rjwZxDvn5S9jNir1iQgfUQoUvVj3whC/KxeIthvmqNMs7Hl9Js0+Rc8jSxtEvGfuorTK
         aIveRHTnENgCmvl8vN6KS65rbfw3UZnVjMbfIvTOpdsnbMBL56X74C7Oh8iHEzWRh49y
         O/1EDT7op7W2CGgdCpzfSBMurWZPu0lse7/r1/N/BdOmJrnFpt8iihatWoSAKCoM+jwP
         jxbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JpCSZWNK6W37x4FLZL/D70dR7DsatnRujdvON/FME9T/qmq+XHz+vKz1geHYjodKQ6Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrpWSWfZoXR1zZzyjXbHU50N1CMI887QAsK0azFoas3qKxKiq
	DAvZuOzbUhmEV1x7I5eRyQPS+gAYMGtBNDgAZMb8TXw29s6M50gfrxadBz03gG8tb2E=
X-Gm-Gg: AeBDiethFN8VP/WMRZGpZBcjiJqIcBZuOFWo+NiBTmxez2WgKrUDiWdnVjBrLVY8uG+
	7GgtJ+h0yXS4q0a1nlUWbfXltBeOMxnyQP2ZzyPcvBFIqIlJYWd7Gs2WIJf7eflWItU9Gpaq0z0
	XY8V2uMOgOJS5ixgNe1NQiu7PO84gLQ/Px7jEcplRFeDaQHoZs0m6JKJslmZr0G2LYe8/jV901c
	xtPgWWdZElG/QZsMBTRh6YLzMfheMj3XllVtewJvjYQlyyymun7ovwUoQZDs5nMIY0yHwfJdTzY
	Dy/dx3FW+Eh/5R86p67c6LqA4UKymx5jOYpj4z53U3b8zkJvkSEXjxCQQtyQDEfM7CqUxRIeS0b
	sETd+xuFR2/qqECbAco2MHFcGUR01J8XIG3WLmud/U7AlPNzAYO0FS9V+riRgziZewETlnML8h2
	UOF+i6+HWJ/r6MMeYni6z2NzpRKRYupLpuvw==
X-Received: by 2002:a05:600c:3f14:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-48a7b535a0dmr61415e9.18.1777388195308;
        Tue, 28 Apr 2026 07:56:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a774c3ddfsm47637275e9.2.2026.04.28.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:56:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8317F5F7BC;
	Tue, 28 Apr 2026 15:56:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: qemu-devel@nongnu.org,  Andrew Jones <andrew.jones@linux.dev>,
  Alexandru Elisei <alexandru.elisei@arm.com>,  Eric Auger
 <eric.auger@redhat.com>,  "open list:ARM" <kvmarm@lists.linux.dev>,  "open
 list:Default mailing list" <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH] arm: add wfx test case
In-Reply-To: <20260428132657.GA591628@e124191.cambridge.arm.com> (Joey Gouly's
	message of "Tue, 28 Apr 2026 14:26:57 +0100")
References: <20260427130045.3669851-1-alex.bennee@linaro.org>
	<20260428132657.GA591628@e124191.cambridge.arm.com>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Tue, 28 Apr 2026 15:56:33 +0100
Message-ID: <87h5ovdtge.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Joey Gouly <joey.gouly@arm.com> writes:

> Hi,
>
> Few small comments.
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
>
> Instead of a hardcoded TIMEOUT, what about something similar to arm/timer=
.c:
>
> 	u64 time_10ms =3D read_sysreg(cntfrq_el0) / 100;

ok

>
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
>> +	local_irq_disable();
>> +
>> +	check_elapsed(start, TIMEOUT, "WFI", true);
>> +}
>> +
>> +static void test_wfe(void)
>> +{
>> +	uint64_t start;
>> +
>
> I think a comment here would be good, just to say it's testing that a wfe
> doesn't sleep for a 'long' period with no pending events, or something li=
ke
> that?

ok

>
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
>> +
>> +static void test_wfit(void)
>> +{
>> +	uint64_t start, timeout;
>> +
>> +	report_info("Testing WFIT...");
>> +	start =3D read_sysreg(cntvct_el0);
>> +	timeout =3D start + TIMEOUT;
>> +	wfit(timeout);
>> +	check_elapsed(start, TIMEOUT, "WFIT", true);
>> +}
>> +
>> +static void test_wfet(void)
>> +{
>> +	uint64_t start, timeout;
>> +
>> +	report_info("Testing WFET...");
>> +	/* Ensure no pending events */
>> +	sev();
>
> Could this just be sevl here? Not that it really matters.

it could be - ideally I would extend the test case to work with -smp so
we can properly exercise that code path as well.

>
>> +	wfe();
>> +
>> +	start =3D read_sysreg(cntvct_el0);
>> +	timeout =3D start + TIMEOUT;
>> +	wfet(timeout);
>> +	check_elapsed(start, TIMEOUT, "WFET", true);
>> +}
>> +
>> +int main(void)
>> +{
>> +
>> +	if (gic_init() < 0) {
>> +		report_abort("GIC init failed");
>> +		return 1;
>> +	}
>> +
>> +	/* Install timer handler for WFI wake-up */
>> +	install_irq_handler(EL1H_IRQ, timer_handler);
>> +	gic_enable_defaults();
>> +
>> +	/* Enable Virtual Timer PPI */
>> +	gic_irq_set_clr_enable(27, true);
>
> Instead of hardcoding 27 here, you can use:
>
> 	u32 irq =3D current_level() =3D=3D CurrentEL_EL1 ? TIMER_VTIMER_IRQ : TI=
MER_HVTIMER_IRQ;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 	gic_irq_set_clr_enable(irq, true);
>
> Which also allows the test to run at EL2.

sounds good.

>
>> +
>> +	report_prefix_push("WFx");
>> +	test_wfi();
>> +	test_wfe();
>> +	report_prefix_pop();
>> +
>> +	if (system_supports_wfxt()) {
>> +		report_prefix_push("WFxT");
>> +		test_wfit();
>> +		test_wfet();
>> +	} else {
>> +		report_skip("WFxT instructions not supported");
>> +	}
>> +
>> +	return report_summary();
>> +}
>> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
>> index 12fc4468..7adf96f2 100644
>> --- a/arm/unittests.cfg
>> +++ b/arm/unittests.cfg
>> @@ -339,3 +339,8 @@ groups =3D mte
>>  test_args =3D asymm
>>  qemu_params =3D -machine mte=3Don
>>  arch =3D arm64
>> +
>> +[wfx]
>> +file =3D wfx.flat
>> +groups =3D wfx
>> +arch =3D arm64
>
> Thanks,
> Joey

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
