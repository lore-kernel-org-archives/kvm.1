Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524633;
	b=TMTR+Ca3yzTuOZGrgze2gRrkVyGPQveUPXV5PuTqFZnA53hOctppF9ZfviiFDl18rN89
	 kNv6Xuf4yRjb85MCPUf/6MVuJluw6E7rfKa7D+mz5oA2zMsKpUN1toq9PTSKH6OXBKRMn
	 zIiFbWc/EJDK0js8YCESJEW+5Kl5LROBfXBoAjFO3NjwkHeCrms3c1JsjUx1rSldZsc61
	 nUEgoMwxiYiFeKn+kmGGVaqQku6PsgWneZrU8m0BALGLspSO5glBTOEyn1Jbx9X/s1rZa
	 pGk1IBdNhM3x5+JZNsel+Njz9boFo6yHnHWR3cvUmqU3QmYlm+Bya/gzE4/qe+thtHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524633;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=pHddcKh2VnZqCVEfuisxFiF1B6JPNZdaRfI9e/TJdts=;
	b=Lav2QBrrs45Rq1I52VrLEcGZ6GkIN3tXTWMpuH07wkdidfiBdJs7fPOFBGW1ngro2KDL
	 WCzB+RMC0MUOn7UnxtwPKGnqTI6NxzZM79LxLHqngsScQzqNEpqI0XPH353uA0rTEj4Eq
	 U/hrUpW9qFGWCcJwG+Vb1V5aXbXu5kQRGLP0pu3Pl0Q385NO5RT8uD9Ln+aZyrzI+s/2A
	 36dSvcfCsrZDygyfqjLR/y2PMTyKJUkTcH37NopkdfikvbVBMgE0ND8Ih2fLkuhSMV2ba
	 nqS974iCfw0nWMj13zFhp/H3RpSjjg8YAAvfseKenoH6Aiey+pWnU0zFjCx9IThUVyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A2606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.240])
	by APP-05 (Coremail) with SMTP id zQCowACXLrQMiAVr_yjVAQ--.4165S2;
	Tue, 24 Nov 2026 20:50:21 +0800 (CST)
Message-ID: <be563f376884fa46178aa4f78468aeb13272506f.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH v2 8/8] riscv: Add BRS SBI requirement
 tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com
Date: Tue, 24 Nov 2026 20:50:20 +0800
In-Reply-To: <awAxIHVLgbqTIYq5@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
	 <20261105082035.133680-9-wangxiang@iscas.ac.cn> <awAxIHVLgbqTIYq5@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowACXLrQMiAVr_yjVAQ--.4165S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJryUJF48ZrWfAr18KF1DGFg_yoW8Jr47Zo
	W3Kr4Sqa13Wr13CF1q9a4xtr4ay3WUWry0y3yUJwnrX3WktayUCr45K398Xa15WFWfWr4U
	CasrXrWFvFZFvws3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYb7k0a2IF6w4kM7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07boDGrUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-11-20=E4=BA=94=E7=9A=84 15:09 +0100=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Nov 05, 2026 at 04:20:35PM +0800, Xiang W wrote:
> > Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
> > Runtime Services specification:
> >=20
> > =C2=A0 SBI_010=C2=A0 spec version must be v2.0 or later
> > =C2=A0 SBI_020=C2=A0 HSM must be implemented
> > =C2=A0 SBI_030=C2=A0 TIME is required unless Sstc is present
> > =C2=A0 SBI_040=C2=A0 IPI is required unless IMSIC is present
> > =C2=A0 SBI_050=C2=A0 RFENCE is required unless IMSIC is present
> > =C2=A0 SBI_060=C2=A0 PMU is required unless Sscsrind and Ssccfg are all=
 present
> > =C2=A0 SBI_070=C2=A0 DBCN is required when ACPI SPCR Interface Type is =
0x15
> >=20
> > Parse the extra ISA names used as skip conditions, and add the RFNC
> > and PMU extension IDs needed to probe those extensions.
> >=20
> > Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> > ---
> > =C2=A0lib/riscv/asm/isa.h |=C2=A0=C2=A0 3 +
> > =C2=A0lib/riscv/asm/sbi.h |=C2=A0=C2=A0 2 +
> > =C2=A0lib/riscv/isa.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> > =C2=A0riscv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0riscv/riscv-brs.c=C2=A0=C2=A0 | 265 +++++++++++++++++++++++++++++=
+++++++++++++++
> > =C2=A0riscv/unittests.cfg |=C2=A0=C2=A0 4 +
> > =C2=A06 files changed, 285 insertions(+), 2 deletions(-)
> > =C2=A0create mode 100644 riscv/riscv-brs.c
> >=20
> > diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
> > index fb3af67d..6516c869 100644
> > --- a/lib/riscv/asm/isa.h
> > +++ b/lib/riscv/asm/isa.h
> > @@ -13,6 +13,9 @@
> > =C2=A0 * by name not tracked here with cpu_has_extension_name()
> > =C2=A0 */
> > =C2=A0enum {
> > +	ISA_SSAIA,
> > +	ISA_SSCCFG,
> > +	ISA_SSCSRIND,
> > =C2=A0	ISA_SSTC,
> > =C2=A0	ISA_MAX,
> > =C2=A0};
> > diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> > index 289a6a24..c92a66dc 100644
> > --- a/lib/riscv/asm/sbi.h
> > +++ b/lib/riscv/asm/sbi.h
> > @@ -45,8 +45,10 @@ enum sbi_ext_id {
> > =C2=A0	SBI_EXT_BASE =3D 0x10,
> > =C2=A0	SBI_EXT_TIME =3D 0x54494d45,
> > =C2=A0	SBI_EXT_IPI =3D 0x735049,
> > +	SBI_EXT_RFNC =3D 0x52464E43,
> > =C2=A0	SBI_EXT_HSM =3D 0x48534d,
> > =C2=A0	SBI_EXT_SRST =3D 0x53525354,
> > +	SBI_EXT_PMU =3D 0x504D55,
>=20
> While adding another three char name line it and all the other three char
> names up so the '=3D' are aligned, i.e. add an extra space before the =3D=
.
>=20
> > =C2=A0	SBI_EXT_DBCN =3D 0x4442434E,
> > =C2=A0	SBI_EXT_SUSP =3D 0x53555350,
> > =C2=A0	SBI_EXT_FWFT =3D 0x46574654,
> > diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> > index 91c7302c..6aa27948 100644
> > --- a/lib/riscv/isa.c
> > +++ b/lib/riscv/isa.c
> > @@ -39,8 +39,16 @@ static void isa_bit(const char *name, int len, void =
*data)
> > =C2=A0{
> > =C2=A0	struct thread_info *info =3D (struct thread_info *)data;
> > =C2=A0
> > -	if (isa_match("sstc", name, len))
> > -		set_bit(ISA_SSTC, info->isa);
> > +#define ISA_MATCH_AND_SET(ext) \
> > +	if (isa_match(#ext, name, len)) \
> > +		set_bit(ISA_##ext, info->isa)
> > +
> > +	ISA_MATCH_AND_SET(SSAIA);
> > +	ISA_MATCH_AND_SET(SSCCFG);
> > +	ISA_MATCH_AND_SET(SSCSRIND);
> > +	ISA_MATCH_AND_SET(SSTC);
> > +
> > +#undef ISA_MATCH_AND_SET
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void isa_parse(const char *isa_string, int len, struct isa=
_info *info)
> > diff --git a/riscv/Makefile b/riscv/Makefile
> > index 348a30a7..7da7526f 100644
> > --- a/riscv/Makefile
> > +++ b/riscv/Makefile
> > @@ -15,6 +15,7 @@ tests +=3D $(TEST_DIR)/sbi.$(exe)
> > =C2=A0tests +=3D $(TEST_DIR)/selftest.$(exe)
> > =C2=A0tests +=3D $(TEST_DIR)/sieve.$(exe)
> > =C2=A0tests +=3D $(TEST_DIR)/isa-dbltrp.$(exe)
> > +tests +=3D $(TEST_DIR)/riscv-brs.$(exe)
> > =C2=A0
> > =C2=A0all: $(tests)
> > =C2=A0
> > diff --git a/riscv/riscv-brs.c b/riscv/riscv-brs.c
> > new file mode 100644
> > index 00000000..2813fa73
> > --- /dev/null
> > +++ b/riscv/riscv-brs.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *=C2=A0 RISC-V BRS SBI requirement tests
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^ extra space
>=20
> > + *
> > + * Copyright (C) 2026, Institute of Software, CAS., Xiang W <wangxiang=
@iscas.ac.cn>
> > + */
> > +
> > +#include <libcflat.h>
> > +#include <devicetree.h>
> > +#include <asm/sbi.h>
> > +#include <asm/isa.h>
> > +#include <asm/smp.h>
> > +
> > +#ifdef CONFIG_EFI
> > +#include <acpi.h>
> > +#endif
>=20
> No need for the CONFIG_EFI guard.
>=20
> > +
> > +static void check_sbi_010(void)
> > +{
> > +	struct sbiret ret;
> > +	unsigned long major, minor;
> > +
> > +	report_prefix_push("SBI_010");
> > +
> > +	ret =3D sbi_get_spec_version();
> > +	if (ret.error)
> > +		report_fail("sbi_get_spec_version failed with %ld", ret.error);
> > +	else {
>=20
> The else has {} so the if needs them too.
>=20
> > +		major =3D ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT;
> > +		major =3D major & SBI_SPEC_VERSION_MAJOR_MASK;
> > +		minor =3D ret.value & SBI_SPEC_VERSION_MINOR_MASK;
> > +
> > +		report(ret.value >=3D sbi_mk_version(2, 0),
>=20
> ret.value & SBI_SPEC_VERSION_MASK
>=20
> > +			"SBI spec version is v2.0 or later (current %lu.%lu)", major, minor=
);
> > +	}
> > +
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_020(void)
> > +{
> > +	report_prefix_push("SBI_020");
> > +	report(sbi_probe(SBI_EXT_HSM), "HSM extension is implemented");
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_030(void)
> > +{
> > +	report_prefix_push("SBI_030");
> > +
> > +	if (cpu_has_extension(smp_processor_id(), ISA_SSTC))
> > +		report_skip("Sstc is present, TIME is not mandated");
> > +	else
> > +		report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
> > +
>=20
> Shouldn't all harts be checked?
>=20
> > +	report_prefix_pop();
> > +}
> > +
> > +#define IMSIC_SLEVEL_IRQ	9
>=20
> We already have IRQ_S_EXT.
>=20
> > +static bool hart_has_imsic[NR_CPUS];
> > +
> > +#ifdef CONFIG_EFI
> > +static int acpi_collect_imsic(struct acpi_subtable_header *header)
> > +{
> > +	struct acpi_madt_rintc *rintc =3D (void *)header;
> > +	int cpu;
> > +
> > +	if (!rintc->imsic_size)
> > +		return 0;
> > +
> > +	cpu =3D hartid_to_cpu(rintc->hart_id);
> > +	if (cpu >=3D 0 && cpu < nr_cpus)
> > +		hart_has_imsic[cpu] =3D true;
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static int dt_intc_phandle_to_cpu(const void *fdt, uint32_t phandle)
> > +{
> > +	int intc_node, cpu_node, cpus_node, ret, i;
> > +	struct dt_reg raw_reg;
> > +	u32 nac, nsc;
> > +	u64 hartid;
> > +
> > +	intc_node =3D fdt_node_offset_by_phandle(fdt, phandle);
> > +	if (intc_node < 0)
> > +		return -1;
> > +
> > +	/* cpu-intc -> cpu node -> /cpus */
> > +	cpu_node =3D fdt_parent_offset(fdt, intc_node);
> > +	if (cpu_node < 0)
> > +		return -1;
> > +
> > +	cpus_node =3D fdt_parent_offset(fdt, cpu_node);
> > +	if (cpus_node < 0)
> > +		return -1;
> > +
> > +	/* #address-cells / #size-cells live on /cpus, not on the cpu node */
> > +	ret =3D dt_get_nr_cells(cpus_node, &nac, &nsc);
> > +	if (ret < 0)
> > +		return -1;
> > +
> > +	dt_reg_init(&raw_reg, nac, nsc);
> > +	ret =3D dt_get_reg(cpu_node, 0, &raw_reg);
> > +	if (ret < 0)
> > +		return -1;
> > +
> > +	hartid =3D raw_reg.address_cells[0];
> > +	if (nac =3D=3D 2)
> > +		hartid =3D (hartid << 32) | raw_reg.address_cells[1];
> > +
> > +	for (i =3D 0; i < nr_cpus; i++) {
> > +		if (cpus[i].hartid =3D=3D hartid)
> > +			return i;
> > +	}
> > +	return -1;
> > +}
> > +
> > +static void dt_collect_imsic(void)
> > +{
> > +	const void *fdt =3D dt_fdt();
> > +	const fdt32_t *prop;
> > +	int node, len, ncells, i, cpu;
> > +	uint32_t phandle, irq;
> > +
> > +	node =3D -1;
> > +	while ((node =3D fdt_node_offset_by_compatible(fdt, node, "riscv,imsi=
cs")) >=3D 0) {
> > +		prop =3D fdt_getprop(fdt, node, "interrupts-extended", &len);
> > +		if (!prop || len < 0)
> > +			continue;
> > +
> > +		/* Each entry is <phandle irq>=C2=A0 (cpu-intc #interrupt-cells =3D =
1) */
> > +		ncells =3D len / (int)sizeof(fdt32_t);
> > +		for (i =3D 0; i + 1 < ncells; i +=3D 2) {
> > +			phandle =3D fdt32_to_cpu(prop[i]);
> > +			irq =3D fdt32_to_cpu(prop[i + 1]);
> > +
> > +			if (irq !=3D IMSIC_SLEVEL_IRQ)
> > +				continue;
> > +
> > +			cpu =3D dt_intc_phandle_to_cpu(fdt, phandle);
> > +			if (cpu >=3D 0 && cpu < nr_cpus)
> > +				hart_has_imsic[cpu] =3D true;
> > +		}
> > +	}
> > +}
>=20
> I've sent https://lore.kernel.org/all/20261120135613.1388647-1-andrew.jon=
es@linux.dev/
> to avoid having to do all this DT parsing in the test code. Your next
> version should add a patch that adds the ACPI support for setting
> thread_info.imsic_addr and then this patch should use it.
>=20
Thanks for writing that helper.

v3 will carry your DT patch and add the ACPI side. The BRS tests then=C2=A0
just read cpus[].imsic_addr.

On ACPI I did not copy RINTC.imsic_addr unconditionally. The spec
says OSPM must ignore that field when the IMSIC structure is not
present in the MADT, so cpu_set_acpi() only takes the address after
ACPI_MADT_TYPE_IMSIC has been found.

I'll send v3 shortly.

Thanks,
Xiang
> > +
> > +static bool all_harts_have_imsic(void)
> > +{
> > +	int cpu;
> > +
> > +	memset(hart_has_imsic, 0, sizeof(hart_has_imsic));
>=20
> I see you call all_harts_have_imsic() twice. So instead of zeroing this
> you should have a way to know that it's already been set once and then
> the second time can just return true/false.
>=20
> > +
> > +	if (dt_available())
> > +		dt_collect_imsic();
> > +#ifdef CONFIG_EFI
> > +	else
> > +		acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_collect_imsic);
> > +#endif
> > +
> > +	for (cpu =3D 0; cpu < nr_cpus; cpu++) {
> > +		if (!cpu_present(cpu))
> > +			continue;
> > +		if (!cpu_has_extension(cpu, ISA_SSAIA)) {
> > +			report_info("CPU %d (hartid %lu) has no Ssaia",
> > +				=C2=A0=C2=A0=C2=A0 cpu, cpus[cpu].hartid);
> > +			return false;
> > +		}
> > +		if (!hart_has_imsic[cpu]) {
> > +			report_info("CPU %d (hartid %lu) has no S-level IMSIC",
> > +				=C2=A0=C2=A0=C2=A0 cpu, cpus[cpu].hartid);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static void check_sbi_040(void)
> > +{
> > +	report_prefix_push("SBI_040");
> > +
> > +	if (all_harts_have_imsic())
> > +		report_skip("IMSIC is present, IPI is not mandated");
> > +	else
> > +		report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
> > +
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_050(void)
> > +{
> > +	report_prefix_push("SBI_050");
> > +
> > +	if (all_harts_have_imsic())
> > +		report_skip("IMSIC is present, RFENCE is not mandated");
> > +	else
> > +		report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
> > +
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_060(void)
> > +{
> > +	int cpu =3D smp_processor_id();
> > +
> > +	report_prefix_push("SBI_060");
> > +
> > +	if (cpu_has_extension(cpu, ISA_SSCSRIND) && cpu_has_extension(cpu, IS=
A_SSCCFG))
>=20
> Shouldn't all harts be checked?
>=20
> > +		/*
> > +		 * TODO: OE_SBI_060_010 also requires Smcsrind and Smcdeleg,
> > +		 * but they are M-mode extensions and not present in the S-mode
> > +		 * ISA string (DT or RHCT). Revisit if BRS clarifies how to detect t=
hem.
> > +		 */
> > +		report_skip("Sscsrind and Ssccfg are present, PMU is not mandated");
>=20
> More than one line (even when they're comments means the if should have
> {}, which means the else too.
>=20
> > +	else
> > +		report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
> > +
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_070(void)
> > +{
> > +	report_prefix_push("SBI_070");
> > +
> > +	if (dt_available())
> > +		report_skip("ACPI not available, DBCN is not mandated");
> > +	else {
>=20
> The else has {} so the if needs them too.
>=20
> > +#ifdef CONFIG_EFI
> > +		struct spcr_descriptor *spcr;
> > +
> > +		spcr =3D find_acpi_table_addr(SPCR_SIGNATURE);
> > +		if (spcr =3D=3D NULL)
> > +			report_skip("SPCR is not present, DBCN is not mandated");
> > +		else {
> > +			if (spcr->interface_type =3D=3D 0x15)
> > +				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
> > +			else
> > +				report_skip(
> > +					"SPCR interface type is %#x (not 0x15), DBCN is not mandated",
>=20
> This line goes past 100 anyway, so put it on the same line as the
> report_skip(
>=20
> > +					spcr->interface_type);
> > +		}
> > +#else
> > +		report_skip("ACPI not available, DBCN is not mandated");
> > +#endif
> > +	}
> > +
> > +	report_prefix_pop();
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	report_prefix_push("riscv-brs");
> > +
> > +	check_sbi_010();
> > +	check_sbi_020();
> > +	check_sbi_030();
> > +	check_sbi_040();
> > +	check_sbi_050();
> > +	check_sbi_060();
> > +	check_sbi_070();
> > +
> > +	return report_summary();
> > +}
> > diff --git a/riscv/unittests.cfg b/riscv/unittests.cfg
> > index 9e9f58d9..990f03db 100644
> > --- a/riscv/unittests.cfg
> > +++ b/riscv/unittests.cfg
> > @@ -22,3 +22,7 @@ groups =3D sbi
> > =C2=A0[dbltrp]
> > =C2=A0file =3D isa-dbltrp.flat
> > =C2=A0groups =3D isa sbi
> > +
> > +[riscv-brs]
> > +file =3D riscv-brs.flat
> > +groups =3D riscv-brs nodefault
> > --=20
> > 2.47.3
> >=20
>=20
> Thanks,
> drew=20

