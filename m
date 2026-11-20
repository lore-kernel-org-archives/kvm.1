Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183804;
	b=ST6+L3WvZyeb6DTzBMFa9p6SsL5l+5bat5mXn54vmcr8ANY6ReONHlLUAbDHYNqeE372
	 Fh6Cr2/MPRX2cZBAaKqPDre/1eAASL6AbccTFz31S9ki35fn+hYt1jfdqBypFDWKSDxxi
	 QHv19Qx0URRVOpiNwxQuZIs9HYWIpGx0bkYMURgB1cLT0H9iSypZ+53QEXIQg9f+Fl/C2
	 Qjps0pCtTuj52dJg1I/juLxAU3Z848+6h/nJB9xXW8NpGqWZ1pvN1cjfuTscDfy+P434X
	 2U6/frpc6rQsRoUSy1c+9KFDQ/ip7N7MKfM7+R6GQZ2GBaZaJrw7NWa/mEpnvch/lig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183804;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WSLFCUaXOmQ2L5KbaY0lxtuv1UIE11M/HeC7utkPg/Y=;
	b=bsbIN/WM9ZgtJL7/u1ZM1fzcDTTKZIWyzJmmE2T915EykDZ0MIgAMy6NA1BFOX9HMCHi
	 Srsq6nopwUNPJ6/huiEEX4gdI/QLDsgSG9AJ+7LnVRxaPzo1eVLeBCQuyDlsfGp63apEg
	 W+8QcwmZCzjqXnoyl/KriBnSPtCJkOoZoTr4zR2aKuKp4Wfb/psbLnZAXbIrDy1TwdyGv
	 cGttb9IrAnS/ZVsSCcure6OXqHZTo5+0oLSyEx3oriZavD/xRr+Dj3ASY8Ic0mO1YOmlr
	 gfHVVKVDIyOpdxaPmnOcFEd6bAhdONSuiJdakQ9IQtBwTZ7BufeppGO2wn1vt1xUzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mIkjKQgx;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D4606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977D4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mIkjKQgx
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zv8sYV+wQSZ34E0oJcXuy0MGsMS9uzv8xvcRJ8IeAeM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795183801; v=1; x=1795788601;
 b=mIkjKQgxhorFPsaW2AH0CSzLq49zYMbODlwLw6yTHkkAq/oBFCyz0VayjV9Eal3sTOzreUwA
 GEwhNXQs7hPPJBQW/r+Lt9xQlePK5ahX0j3ll0AFn2MdB4BdUKXWWtbUfBKXNodccW7ThI18Q8j
 2YTcNwiwBXqQD6RYYkIyJGdI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1b24064f1562556c;
	Fri, 20 Nov 2026 14:10:01 +0000
X-Mizu-Trace-ID: 1b24064f1562556c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 15:09:26 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 8/8] riscv: Add BRS SBI requirement
 tests
Message-ID: <awAxIHVLgbqTIYq5@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-9-wangxiang@iscas.ac.cn>
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
In-Reply-To: <20261105082035.133680-9-wangxiang@iscas.ac.cn>

On Thu, Nov 05, 2026 at 04:20:35PM +0800, Xiang W wrote:
> Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
> Runtime Services specification:
> 
>   SBI_010  spec version must be v2.0 or later
>   SBI_020  HSM must be implemented
>   SBI_030  TIME is required unless Sstc is present
>   SBI_040  IPI is required unless IMSIC is present
>   SBI_050  RFENCE is required unless IMSIC is present
>   SBI_060  PMU is required unless Sscsrind and Ssccfg are all present
>   SBI_070  DBCN is required when ACPI SPCR Interface Type is 0x15
> 
> Parse the extra ISA names used as skip conditions, and add the RFNC
> and PMU extension IDs needed to probe those extensions.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/riscv/asm/isa.h |   3 +
>  lib/riscv/asm/sbi.h |   2 +
>  lib/riscv/isa.c     |  12 +-
>  riscv/Makefile      |   1 +
>  riscv/riscv-brs.c   | 265 ++++++++++++++++++++++++++++++++++++++++++++
>  riscv/unittests.cfg |   4 +
>  6 files changed, 285 insertions(+), 2 deletions(-)
>  create mode 100644 riscv/riscv-brs.c
> 
> diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
> index fb3af67d..6516c869 100644
> --- a/lib/riscv/asm/isa.h
> +++ b/lib/riscv/asm/isa.h
> @@ -13,6 +13,9 @@
>   * by name not tracked here with cpu_has_extension_name()
>   */
>  enum {
> +	ISA_SSAIA,
> +	ISA_SSCCFG,
> +	ISA_SSCSRIND,
>  	ISA_SSTC,
>  	ISA_MAX,
>  };
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

While adding another three char name line it and all the other three char
names up so the '=' are aligned, i.e. add an extra space before the =.

>  	SBI_EXT_DBCN = 0x4442434E,
>  	SBI_EXT_SUSP = 0x53555350,
>  	SBI_EXT_FWFT = 0x46574654,
> diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> index 91c7302c..6aa27948 100644
> --- a/lib/riscv/isa.c
> +++ b/lib/riscv/isa.c
> @@ -39,8 +39,16 @@ static void isa_bit(const char *name, int len, void *data)
>  {
>  	struct thread_info *info = (struct thread_info *)data;
>  
> -	if (isa_match("sstc", name, len))
> -		set_bit(ISA_SSTC, info->isa);
> +#define ISA_MATCH_AND_SET(ext) \
> +	if (isa_match(#ext, name, len)) \
> +		set_bit(ISA_##ext, info->isa)
> +
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
> index 00000000..2813fa73
> --- /dev/null
> +++ b/riscv/riscv-brs.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  RISC-V BRS SBI requirement tests
      ^
      ^ extra space

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

No need for the CONFIG_EFI guard.

> +
> +static void check_sbi_010(void)
> +{
> +	struct sbiret ret;
> +	unsigned long major, minor;
> +
> +	report_prefix_push("SBI_010");
> +
> +	ret = sbi_get_spec_version();
> +	if (ret.error)
> +		report_fail("sbi_get_spec_version failed with %ld", ret.error);
> +	else {

The else has {} so the if needs them too.

> +		major = ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT;
> +		major = major & SBI_SPEC_VERSION_MAJOR_MASK;
> +		minor = ret.value & SBI_SPEC_VERSION_MINOR_MASK;
> +
> +		report(ret.value >= sbi_mk_version(2, 0),

ret.value & SBI_SPEC_VERSION_MASK

> +			"SBI spec version is v2.0 or later (current %lu.%lu)", major, minor);
> +	}
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
> +	if (cpu_has_extension(smp_processor_id(), ISA_SSTC))
> +		report_skip("Sstc is present, TIME is not mandated");
> +	else
> +		report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
> +

Shouldn't all harts be checked?

> +	report_prefix_pop();
> +}
> +
> +#define IMSIC_SLEVEL_IRQ	9

We already have IRQ_S_EXT.

> +static bool hart_has_imsic[NR_CPUS];
> +
> +#ifdef CONFIG_EFI
> +static int acpi_collect_imsic(struct acpi_subtable_header *header)
> +{
> +	struct acpi_madt_rintc *rintc = (void *)header;
> +	int cpu;
> +
> +	if (!rintc->imsic_size)
> +		return 0;
> +
> +	cpu = hartid_to_cpu(rintc->hart_id);
> +	if (cpu >= 0 && cpu < nr_cpus)
> +		hart_has_imsic[cpu] = true;
> +
> +	return 0;
> +}
> +#endif
> +
> +static int dt_intc_phandle_to_cpu(const void *fdt, uint32_t phandle)
> +{
> +	int intc_node, cpu_node, cpus_node, ret, i;
> +	struct dt_reg raw_reg;
> +	u32 nac, nsc;
> +	u64 hartid;
> +
> +	intc_node = fdt_node_offset_by_phandle(fdt, phandle);
> +	if (intc_node < 0)
> +		return -1;
> +
> +	/* cpu-intc -> cpu node -> /cpus */
> +	cpu_node = fdt_parent_offset(fdt, intc_node);
> +	if (cpu_node < 0)
> +		return -1;
> +
> +	cpus_node = fdt_parent_offset(fdt, cpu_node);
> +	if (cpus_node < 0)
> +		return -1;
> +
> +	/* #address-cells / #size-cells live on /cpus, not on the cpu node */
> +	ret = dt_get_nr_cells(cpus_node, &nac, &nsc);
> +	if (ret < 0)
> +		return -1;
> +
> +	dt_reg_init(&raw_reg, nac, nsc);
> +	ret = dt_get_reg(cpu_node, 0, &raw_reg);
> +	if (ret < 0)
> +		return -1;
> +
> +	hartid = raw_reg.address_cells[0];
> +	if (nac == 2)
> +		hartid = (hartid << 32) | raw_reg.address_cells[1];
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (cpus[i].hartid == hartid)
> +			return i;
> +	}
> +	return -1;
> +}
> +
> +static void dt_collect_imsic(void)
> +{
> +	const void *fdt = dt_fdt();
> +	const fdt32_t *prop;
> +	int node, len, ncells, i, cpu;
> +	uint32_t phandle, irq;
> +
> +	node = -1;
> +	while ((node = fdt_node_offset_by_compatible(fdt, node, "riscv,imsics")) >= 0) {
> +		prop = fdt_getprop(fdt, node, "interrupts-extended", &len);
> +		if (!prop || len < 0)
> +			continue;
> +
> +		/* Each entry is <phandle irq>  (cpu-intc #interrupt-cells = 1) */
> +		ncells = len / (int)sizeof(fdt32_t);
> +		for (i = 0; i + 1 < ncells; i += 2) {
> +			phandle = fdt32_to_cpu(prop[i]);
> +			irq = fdt32_to_cpu(prop[i + 1]);
> +
> +			if (irq != IMSIC_SLEVEL_IRQ)
> +				continue;
> +
> +			cpu = dt_intc_phandle_to_cpu(fdt, phandle);
> +			if (cpu >= 0 && cpu < nr_cpus)
> +				hart_has_imsic[cpu] = true;
> +		}
> +	}
> +}

I've sent https://lore.kernel.org/all/20261120135613.1388647-1-andrew.jones@linux.dev/
to avoid having to do all this DT parsing in the test code. Your next
version should add a patch that adds the ACPI support for setting
thread_info.imsic_addr and then this patch should use it.

> +
> +static bool all_harts_have_imsic(void)
> +{
> +	int cpu;
> +
> +	memset(hart_has_imsic, 0, sizeof(hart_has_imsic));

I see you call all_harts_have_imsic() twice. So instead of zeroing this
you should have a way to know that it's already been set once and then
the second time can just return true/false.

> +
> +	if (dt_available())
> +		dt_collect_imsic();
> +#ifdef CONFIG_EFI
> +	else
> +		acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_collect_imsic);
> +#endif
> +
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		if (!cpu_present(cpu))
> +			continue;
> +		if (!cpu_has_extension(cpu, ISA_SSAIA)) {
> +			report_info("CPU %d (hartid %lu) has no Ssaia",
> +				    cpu, cpus[cpu].hartid);
> +			return false;
> +		}
> +		if (!hart_has_imsic[cpu]) {
> +			report_info("CPU %d (hartid %lu) has no S-level IMSIC",
> +				    cpu, cpus[cpu].hartid);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static void check_sbi_040(void)
> +{
> +	report_prefix_push("SBI_040");
> +
> +	if (all_harts_have_imsic())
> +		report_skip("IMSIC is present, IPI is not mandated");
> +	else
> +		report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
> +
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_050(void)
> +{
> +	report_prefix_push("SBI_050");
> +
> +	if (all_harts_have_imsic())
> +		report_skip("IMSIC is present, RFENCE is not mandated");
> +	else
> +		report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
> +
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_060(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	report_prefix_push("SBI_060");
> +
> +	if (cpu_has_extension(cpu, ISA_SSCSRIND) && cpu_has_extension(cpu, ISA_SSCCFG))

Shouldn't all harts be checked?

> +		/*
> +		 * TODO: OE_SBI_060_010 also requires Smcsrind and Smcdeleg,
> +		 * but they are M-mode extensions and not present in the S-mode
> +		 * ISA string (DT or RHCT). Revisit if BRS clarifies how to detect them.
> +		 */
> +		report_skip("Sscsrind and Ssccfg are present, PMU is not mandated");

More than one line (even when they're comments means the if should have
{}, which means the else too.

> +	else
> +		report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
> +
> +	report_prefix_pop();
> +}
> +
> +static void check_sbi_070(void)
> +{
> +	report_prefix_push("SBI_070");
> +
> +	if (dt_available())
> +		report_skip("ACPI not available, DBCN is not mandated");
> +	else {

The else has {} so the if needs them too.

> +#ifdef CONFIG_EFI
> +		struct spcr_descriptor *spcr;
> +
> +		spcr = find_acpi_table_addr(SPCR_SIGNATURE);
> +		if (spcr == NULL)
> +			report_skip("SPCR is not present, DBCN is not mandated");
> +		else {
> +			if (spcr->interface_type == 0x15)
> +				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
> +			else
> +				report_skip(
> +					"SPCR interface type is %#x (not 0x15), DBCN is not mandated",

This line goes past 100 anyway, so put it on the same line as the
report_skip(

> +					spcr->interface_type);
> +		}
> +#else
> +		report_skip("ACPI not available, DBCN is not mandated");
> +#endif
> +	}
> +
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
