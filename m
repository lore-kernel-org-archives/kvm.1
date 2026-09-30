Received: from mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDE4BF944
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767207; cv=none; b=MLZU+0QIaoqvDXU2nMNxuzp2F3DuoX8KAwp9SGETJFt7lRsVn2iVa4Hm9RIp/s13L7N8pHOju2p4gwHSQfe7p/ea+OSEVWMw71JOpWjXiAQFw/LkOYYp4+nC4T+GXr1JJhNCXGl1Z3kvLAWe1+ASxltgU1xqWdPnVllhC9Dtl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767207; c=relaxed/simple;
	bh=35ZbGvR5bUg0UJ7AbmhYmW5JM7nK+htt45Zp7FnjN+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnmzzWpkrX09dvNdU7jWT5nmyNlbnL61urB/BvOmYcyHNeZX1Fpnh6TRAEyKDzQSGO/JhtUsy+0PXgjLn2Vh5L1rK7B7+MbVYRrLetuHARzPY3ELuA3yXHZIXwaoWhNldi/CNeRjRAFTG/f6wHvQFUwioseA4M63zKB52XcV1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOLl8gXj; arc=none smtp.client-ip=95.215.58.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOLl8gXj"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=35ZbGvR5bUg0UJ7AbmhYmW5JM7nK+htt45Zp7FnjN+w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790767201; v=1; x=1791372001;
 b=aOLl8gXjGKB4NCCcPEAaB4REI4P5hWcLyjKpmciBGEIOKsY+eJweYFGUYBhJhwVN9Ns+Mn4+
 kiNSNlytugVJcSTt3POpoKP4tvsrG6/R1lcqf2bCoTs2WfxelxYyZgHR5gBsi1HGflY0b01Uj3E
 BVUS5rl8X+O/aH3/UW08cSV8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 39615a393add85e9;
	Wed, 30 Sep 2026 11:20:01 +0000
X-Mizu-Trace-ID: 39615a393add85e9
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 13:19:56 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com, sunilvl@oss.qualcomm.com
Subject: Re: [kvm-unit-tests PATCH 7/7] riscv: Add BRS SBI requirement tests
Message-ID: <atbvvaynwqhdljjus6jnmcsnugh5oniwke7c3k77q2kgqkbun4@cxhqnhj6mvul>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-8-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-8-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:45AM +0800, Xiang W wrote:
> Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
> Runtime Services specification:
> 
>   SBI_010  spec version must be v2.0 or later
>   SBI_020  HSM must be implemented
>   SBI_030  TIME is required unless Sstc is present
>   SBI_040  IPI is required unless Ssaia is present
>   SBI_050  RFENCE is required unless Ssaia is present
>   SBI_060  PMU is required unless Smcsrind, Sscsrind, Smcdeleg
>            and Ssccfg are all present
>   SBI_070  DBCN is required when ACPI SPCR Interface Type is 0x15
> 
> Parse the extra ISA names used as skip conditions, and add the RFNC
> and PMU extension IDs needed to probe those extensions.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/riscv/asm/isa.h |   5 ++
>  lib/riscv/asm/sbi.h |   2 +
>  lib/riscv/isa.c     |  14 +++-
>  riscv/Makefile      |   1 +
>  riscv/riscv-brs.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++
>  riscv/unittests.cfg |   4 ++
>  6 files changed, 195 insertions(+), 2 deletions(-)
>  create mode 100644 riscv/riscv-brs.c
> 
> diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
> index fb3af67d..8a124881 100644
> --- a/lib/riscv/asm/isa.h
> +++ b/lib/riscv/asm/isa.h
> @@ -13,7 +13,12 @@
>   * by name not tracked here with cpu_has_extension_name()
>   */
>  enum {
> +	ISA_SMCDELEG,
> +	ISA_SMCSRIND,

I'm not sure we should expect machine level ISA extensions to be in the
S-mode ISA string.

Indeed the spec says

"""
The Performance Monitoring Extension (PMU) MUST be implemented, if the
counter delegation-related S-Mode ISA extensions (Sscsrind [13] and Ssccfg [14])
are not present.
"""

So I'm not sure why you're looking for the M-mode extensions at all.

> +	ISA_SSAIA,
> +	ISA_SSCCFG,
>  	ISA_SSTC,
> +	ISA_SSCSRIND,
>  	ISA_MAX,
>  };
>  __static_assert(ISA_MAX <= __riscv_xlen, "Need to increase thread_info.isa");
> diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> index 289a6a24..c92a66dc 100644
> --- a/lib/riscv/asm/sbi.h
> +++ b/lib/riscv/asm/sbi.h
> @@ -45,8 +45,10 @@ enum sbi_ext_id {
>  	SBI_EXT_BASE = 0x10,
>  	SBI_EXT_TIME = 0x54494d45,
>  	SBI_EXT_IPI = 0x735049,
> +	SBI_EXT_RFNC = 0x52464E43,
>  	SBI_EXT_HSM = 0x48534d,
>  	SBI_EXT_SRST = 0x53525354,
> +	SBI_EXT_PMU = 0x504D55,
>  	SBI_EXT_DBCN = 0x4442434E,
>  	SBI_EXT_SUSP = 0x53555350,
>  	SBI_EXT_FWFT = 0x46574654,
> diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> index b0257979..f5e2a61b 100644
> --- a/lib/riscv/isa.c
> +++ b/lib/riscv/isa.c
> @@ -39,8 +39,18 @@ static void isa_bit(const char *name, int len, void *data)
>  {
>  	struct thread_info *info = (struct thread_info *)data;
>  
> -	if (isa_match("sstc", name, len))
> -		set_bit(ISA_SSTC, info->isa);
> +#define ISA_MATCH_AND_SET(ext) \
> +	if (isa_match(#ext, name, len)) \
> +		set_bit(ISA_##ext, info->isa)
> +
> +	ISA_MATCH_AND_SET(SMCDELEG);
> +	ISA_MATCH_AND_SET(SMCSRIND);
> +	ISA_MATCH_AND_SET(SSAIA);
> +	ISA_MATCH_AND_SET(SSCCFG);
> +	ISA_MATCH_AND_SET(SSCSRIND);
> +	ISA_MATCH_AND_SET(SSTC);
> +
> +#undef ISA_MATCH_AND_SET
>  }
>  
>  static void isa_parse(const char *isa_string, int len, struct isa_info *info)
> diff --git a/riscv/Makefile b/riscv/Makefile
> index 348a30a7..7da7526f 100644
> --- a/riscv/Makefile
> +++ b/riscv/Makefile
> @@ -15,6 +15,7 @@ tests += $(TEST_DIR)/sbi.$(exe)
>  tests += $(TEST_DIR)/selftest.$(exe)
>  tests += $(TEST_DIR)/sieve.$(exe)
>  tests += $(TEST_DIR)/isa-dbltrp.$(exe)
> +tests += $(TEST_DIR)/riscv-brs.$(exe)
>  
>  all: $(tests)
>  
> diff --git a/riscv/riscv-brs.c b/riscv/riscv-brs.c
> new file mode 100644
> index 00000000..0d4a8f47
> --- /dev/null
> +++ b/riscv/riscv-brs.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  RISC-V BRS SBI requirement tests
> + *
> + * Copyright (C) 2026, Institute of Software, CAS., Xiang W <wangxiang@iscas.ac.cn>
> + */
> +
> +#include <libcflat.h>
> +#include <devicetree.h>
> +#include <asm/sbi.h>
> +#include <asm/isa.h>
> +#include <asm/smp.h>
> +
> +#ifdef CONFIG_EFI
> +#include <acpi.h>
> +#endif
> +
> +static void check_sbi_010(void)
> +{
> +	struct sbiret ret;
> +
> +	report_prefix_push("SBI_010");
> +
> +	ret = sbi_get_spec_version();
> +	if (ret.error) {
> +		report_fail("sbi_get_spec_version failed with %ld", ret.error);
> +		report_prefix_pop();
> +		return;
> +	}
> +
> +	report_info("SBI spec version %lu.%lu",
> +		    (ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
> +		    SBI_SPEC_VERSION_MAJOR_MASK,
> +		    ret.value & SBI_SPEC_VERSION_MINOR_MASK);
> +
> +	report(ret.value >= sbi_mk_version(2, 0),
> +	       "SBI spec version is v2.0 or later");
> +
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_020(void)
> +{
> +	report_prefix_push("SBI_020");
> +	report(sbi_probe(SBI_EXT_HSM), "HSM extension is implemented");
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_030(void)
> +{
> +	report_prefix_push("SBI_030");
> +
> +	if (cpu_has_extension(smp_processor_id(), ISA_SSTC)) {
> +		report_skip("Sstc is present, TIME is not mandated");
> +		report_prefix_pop();
> +		return;
> +	}
> +
> +	report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_040(void)
> +{
> +	report_prefix_push("SBI_040");
> +
> +	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {

I'm not sure this is a sufficient check. IIRC, the IMSIC is an optional
feature of the AIA and the BRS rule states:

"""
The S-Mode IPI Extension (sPI) MUST be implemented, if the Incoming MSI
Controller (IMSIC, [12]) is not available.
"""

I think we should check both ISA_SSAIA and ensure each hart has a nonzero
acpi_madt_rintc.imsic_size. (And, unless, I'm mistaken, the BRS SBI rules
apply to both BRS-I and BRS-B, so we should implement a DT equivalent
IMSIC check too.)


> +		report_skip("Ssaia is present, IPI is not mandated");
> +		report_prefix_pop();
> +		return;
> +	}
> +
> +	report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_050(void)
> +{
> +	report_prefix_push("SBI_050");
> +
> +	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {
> +		report_skip("Ssaia is present, RFENCE is not mandated");
> +		report_prefix_pop();
> +		return;
> +	}
> +
> +	report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_060(void)
> +{
> +	int cpu = smp_processor_id();
> +	bool skip = true;
> +	bool has_ext;
> +
> +	report_prefix_push("SBI_060");
> +
> +	has_ext = cpu_has_extension(cpu, ISA_SMCSRIND);
> +	if (!has_ext)
> +		report_info("Smcsrind is not present");
> +	skip &= has_ext;
> +
> +	has_ext = cpu_has_extension(cpu, ISA_SSCSRIND);
> +	if (!has_ext)
> +		report_info("Sscsrind is not present");
> +	skip &= has_ext;
> +
> +	has_ext = cpu_has_extension(cpu, ISA_SMCDELEG);
> +	if (!has_ext)
> +		report_info("Smcdeleg is not present");
> +	skip &= has_ext;
> +
> +	has_ext = cpu_has_extension(cpu, ISA_SSCCFG);
> +	if (!has_ext)
> +		report_info("Ssccfg is not present");
> +	skip &= has_ext;
> +
> +	if (skip) {
> +		report_skip("Smcsrind, Sscsrind, Smcdeleg and Ssccfg are present, PMU is not mandated");
> +		report_prefix_pop();
> +		return;
> +	}
> +
> +	report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_070(void)
> +{
> +	report_prefix_push("SBI_070");
> +
> +#ifdef CONFIG_EFI
> +	if (!dt_available()) {
> +		struct spcr_descriptor *spcr;
> +
> +		spcr = find_acpi_table_addr(SPCR_SIGNATURE);
> +		if (spcr) {
> +			report_info("SPCR interface type is %#x", spcr->interface_type);
> +			if (spcr->interface_type == 0x15) {
> +				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
> +				report_prefix_pop();
> +				return;
> +			}
> +			report_skip("SPCR interface type is not 0x15, DBCN is not mandated");
> +			report_prefix_pop();
> +			return;
> +		}
> +		report_skip("SPCR is not present, DBCN is not mandated");
> +		report_prefix_pop();
> +		return;

nit: could use a goto to get rid of the repeated

  report_prefix_pop();
  return;

lines.

> +	}
> +#endif
> +	report_skip("ACPI not available, DBCN is not mandated");
> +	report_prefix_pop();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	report_prefix_push("riscv-brs");
> +
> +	check_sbi_010();
> +	check_sbi_020();
> +	check_sbi_030();
> +	check_sbi_040();
> +	check_sbi_050();
> +	check_sbi_060();
> +	check_sbi_070();
> +
> +	return report_summary();
> +}
> diff --git a/riscv/unittests.cfg b/riscv/unittests.cfg
> index 9e9f58d9..990f03db 100644
> --- a/riscv/unittests.cfg
> +++ b/riscv/unittests.cfg
> @@ -22,3 +22,7 @@ groups = sbi
>  [dbltrp]
>  file = isa-dbltrp.flat
>  groups = isa sbi
> +
> +[riscv-brs]
> +file = riscv-brs.flat
> +groups = riscv-brs nodefault
> -- 
> 2.47.3
>

Thanks,
drew
