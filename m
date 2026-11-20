Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184751;
	b=B/hywl1YFMWpBCqMJQUuok8MWOda9fmRioojCrpgs9Ai5PX/QQ48s7Xw2K1OaVq9iUGQ
	 LIUSW1a3G4sUSq822Cds0MJszJVbR+XycAfCTP/Xc1CyBUnQI6wSuMOOF2Pqf9PivLPi8
	 dsN2UAlCZLK+YRSyLGhxwdGEiubs6kmChZtdoNPhjLSNK8LYJpRoZwLr2bXj2kdpDpre/
	 Ch/XNatVJd44oO/P+CpodL+P456ql7HHuKbwZ8R2ji+1e1a3c3erqkawk6CCdL7+T5OBS
	 a0hzu0vqQACXgbZ9fQ4fQrBv9SRQm/DyRsEQHuddFXjLG+kFlN39SF4mqjXOaXHA0fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184751;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K3RC7BY0M3XAHw/tcnuHdAsQT7+nhsimsAAEmWDUQ/A=;
	b=S/+Dm4LDT/iN/gWs230kuhNLKVV6/q2kOilhYmXw/Jf4EQ2YVyyXAAQkJiz0lG9AHwqA
	 XWbg93ZepKmPu2R8Y4uFGG6iauPv7O/Rcpjqca1ndV4/XzJCy9WjdZ5cfcsW2bi53hAGE
	 oBmNxpPuLM4IoOaC7KXTix74v++BooUJ8amgTQcc0xhbJh8owEAZ4F/zqaqr+Tahvt0qF
	 nGHoi0lu9I27xUg2+cZvR7yvNekcgNwrBX0gUXVIpq90LYy5BEgAcE4AvpXuZVOyk8QQ5
	 JyxM3ps5ruuL2CNsvMR3OkKSZ5+RTq/fZzk8xgL9j2SjEn8TgL98T5s2TtDbqZHJvpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cag8wvj3;
	arc=none smtp.remote-ip=95.215.58.116
Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B61606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B61606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cag8wvj3
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q7Ufw1jCvjg966DPgIa870eJgToNjk1qUAVnHeWMfXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795184747; v=1; x=1795789547;
 b=Cag8wvj3BBikXVgjoW1VJdRHrvhgex1jGbL7Posl22m9tvxjslDLFdB7hUiywF9PMolwko7q
 V4ZDu54bqPRimtlcezQ0E1QeocH9R8BccReZdBNkf/+QhOmX/c6cMW+Y8IeRyWrCI477OHRH+fK
 r5fTYjONF+tz2w+abGPyoYZw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ba6f99fb7faf8c1a;
	Fri, 20 Nov 2026 14:25:39 +0000
X-Mizu-Trace-ID: ba6f99fb7faf8c1a
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 15:25:04 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Sainath Grandhi <sainathg@systemssoftware.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH] riscv: Add Zicboz CBO.ZERO tests
Message-ID: <awBVmzOuEuBFSnqX@orel>
References: <20260808055040.2093-1-sainathg@systemssoftware.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808055040.2093-1-sainathg@systemssoftware.dev>

Hi Sainath,

Thank you for submitting a riscv kvm-unit-tests test. The code is clean
and matches the commit message, but I'm not sure I see the motivation for
it. Do you plan to use k-u-t for ISA testing and this is a first? Or was
there a problem with zicboz and you used this to help debug it? Also,
I'm not sure we want to get into the business of testing the DT, so
you should probably have asserts for anywhere you currently have
report_fail's for unexpected DT check results.

Thanks,
drew

On Sat, Aug 08, 2026 at 05:50:40AM +0000, Sainath Grandhi wrote:
> Add a test for CBO.ZERO when Zicboz is advertised. Read the cache-block
> size from riscv,cboz-block-size and allocate three aligned blocks.
> Execute CBO.ZERO at multiple offsets in the middle block and verify that
> the containing block is zeroed while the adjacent blocks remain
> unchanged.
> 
> Skip the test when Zicboz is unavailable.
> 
> Signed-off-by: Sainath Grandhi <sainathg@systemssoftware.dev>
> ---
>  riscv/Makefile      |   1 +
>  riscv/isa-zicboz.c  | 168 ++++++++++++++++++++++++++++++++++++++++++++
>  riscv/unittests.cfg |   4 ++
>  3 files changed, 173 insertions(+)
>  create mode 100644 riscv/isa-zicboz.c
> 
> diff --git a/riscv/Makefile b/riscv/Makefile
> index 348a30a7..f4a97575 100644
> --- a/riscv/Makefile
> +++ b/riscv/Makefile
> @@ -15,6 +15,7 @@ tests += $(TEST_DIR)/sbi.$(exe)
>  tests += $(TEST_DIR)/selftest.$(exe)
>  tests += $(TEST_DIR)/sieve.$(exe)
>  tests += $(TEST_DIR)/isa-dbltrp.$(exe)
> +tests += $(TEST_DIR)/isa-zicboz.$(exe)
>  
>  all: $(tests)
>  
> diff --git a/riscv/isa-zicboz.c b/riscv/isa-zicboz.c
> new file mode 100644
> index 00000000..76a2d209
> --- /dev/null
> +++ b/riscv/isa-zicboz.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Zicboz cache-block-zero instruction tests
> + *
> + * Copyright (C) 2026, Sainath Grandhi <sainathg@systemssoftware.dev>
> + */
> +#include <alloc.h>
> +#include <devicetree.h>
> +#include <libcflat.h>
> +#include <string.h>
> +
> +#include <asm/isa.h>
> +#include <asm/processor.h>
> +
> +#define GUARD_BEFORE_PATTERN	0xa5
> +#define TARGET_PATTERN		0x5a
> +#define GUARD_AFTER_PATTERN	0x3c
> +
> +struct zicboz_info {
> +	u64 hartid;
> +	u32 block_size;
> +	int property_len;
> +	bool found;
> +};
> +
> +static void find_zicboz_block_size(int cpu_node, u64 hartid, void *data)
> +{
> +	struct zicboz_info *info = data;
> +	const fdt32_t *property;
> +	int len;
> +
> +	if (hartid != info->hartid)
> +		return;
> +
> +	property = fdt_getprop(dt_fdt(), cpu_node,
> +			       "riscv,cboz-block-size", &len);

Please use all 100 allowed chars for line length. And same comment throughout.

> +	if (!property)
> +		return;
> +
> +	info->found = true;
> +	info->property_len = len;
> +	if (len == sizeof(*property))
> +		info->block_size = fdt32_to_cpu(*property);
> +}
> +
> +static bool get_zicboz_block_size(size_t *block_size)
> +{
> +	struct zicboz_info info = {
> +		.hartid = current_thread_info()->hartid,
> +	};
> +	int ret;
> +
> +	ret = dt_for_each_cpu_node(find_zicboz_block_size, &info);
> +	if (ret) {
> +		report_fail("failed to walk CPU nodes: %s", fdt_strerror(ret));
> +		return false;
> +	}
> +
> +	if (!info.found) {
> +		report_fail("riscv,cboz-block-size is missing");
> +		return false;
> +	}
> +
> +	if (info.property_len != sizeof(fdt32_t)) {
> +		report_fail("riscv,cboz-block-size has invalid length %d",
> +			    info.property_len);
> +		return false;
> +	}
> +
> +	if (!is_power_of_2(info.block_size)) {
> +		report_fail("invalid CBO.ZERO block size %u", info.block_size);
> +		return false;
> +	}
> +
> +	*block_size = info.block_size;
> +	return true;
> +}
> +
> +static inline void cbo_zero(void *address)
> +{
> +	asm volatile(".option push\n"
> +		".option arch, +zicboz\n"
> +		"cbo.zero 0(%0)\n"
> +		".option pop\n"
> +		:
> +		: "r" (address)
> +		: "memory");
> +}
> +
> +static bool block_has_value(const u8 *block, size_t block_size, u8 value)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < block_size; i++) {
> +		if (block[i] != value)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void test_cbo_zero_at_offset(u8 *area, size_t block_size,
> +				    size_t offset, const char *name)
> +{
> +	u8 *guard_before = area;
> +	u8 *target = guard_before + block_size;
> +	u8 *guard_after = target + block_size;
> +
> +	report_prefix_push(name);
> +
> +	memset(guard_before, GUARD_BEFORE_PATTERN, block_size);
> +	memset(target, TARGET_PATTERN, block_size);
> +	memset(guard_after, GUARD_AFTER_PATTERN, block_size);
> +
> +	cbo_zero(target + offset);
> +	asm volatile("fence rw, rw" ::: "memory");

smp_mb()

> +
> +	report(block_has_value(target, block_size, 0),
> +	       "target block was zeroed");
> +	report(block_has_value(guard_before, block_size,
> +			       GUARD_BEFORE_PATTERN),
> +	       "preceding block was preserved");
> +	report(block_has_value(guard_after, block_size,
> +			       GUARD_AFTER_PATTERN),
> +	       "following block was preserved");
> +
> +	report_prefix_pop();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	size_t block_size;
> +	u8 *area;
> +
> +	report_prefix_push("zicboz");
> +
> +	if (!dt_available()) {
> +		report_skip("device tree is not available");
> +		goto out;
> +	}
> +
> +	if (!has_ext("zicboz")) {
> +		report_skip("Zicboz is not available");
> +		goto out;
> +	}
> +
> +	if (!get_zicboz_block_size(&block_size))
> +		goto out;
> +
> +	report_info("CBO.ZERO block size is %lu bytes",
> +		    (unsigned long)block_size);
> +
> +	area = memalign(block_size, 3 * block_size);
> +
> +	/* Every address within a block must select the same containing block. */
> +	test_cbo_zero_at_offset(area, block_size, 0, "block-start");
> +	test_cbo_zero_at_offset(area, block_size, 1, "second-byte");
> +	test_cbo_zero_at_offset(area, block_size, block_size / 2,
> +				"block-middle");
> +	test_cbo_zero_at_offset(area, block_size, block_size - 1,
> +				"block-end");
> +
> +	free(area);
> +
> +out:
> +	report_prefix_pop();
> +	return report_summary();
> +}
> diff --git a/riscv/unittests.cfg b/riscv/unittests.cfg
> index 9e9f58d9..30594fe5 100644
> --- a/riscv/unittests.cfg
> +++ b/riscv/unittests.cfg
> @@ -22,3 +22,7 @@ groups = sbi
>  [dbltrp]
>  file = isa-dbltrp.flat
>  groups = isa sbi
> +
> +[zicboz]
> +file = isa-zicboz.flat
> +groups = isa
> -- 
> 2.53.0
> 
