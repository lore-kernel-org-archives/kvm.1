Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AE3E8C77
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291794; cv=none; b=bMZrZupliUMJqjUXw8CYaTImNcqeXzY/aS2B+A3sUv1ibFyWdJqiOv46RciF8YfWF8fRMmt1O87HC9zuC/mbWGpcGylXMGfyezTBxtQWANxJrB6TOcnlVe0SvJyqj5GtrI2dXvGjElHLJSLL2t7ohjCUeZMayNU44bulbqZwo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291794; c=relaxed/simple;
	bh=81cdW/4qtYUyjoBl7Y8qltlWWRjfQ8jOvEacjiw2lVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2TtZGnd0VGhhrN8++EyLZcSiu0PHqpmKkOHJVPUQHyasWdMYWKg7FCA3fbIdGrNRele+tKXLLUBftgapSJUP0vkb2wn/9MrDfYzwNGq4DXRkv3hZPsS3pdlWmlCqCKnX/INf87uMm4d9TRl1KZVl81NEzFtXr5h6J1qvCUtmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowACnfvKH8cRq5rwHCg--.25418S2;
	Tue, 06 Oct 2026 21:03:04 +0800 (CST)
Message-ID: <99cec8f9d34edcc11b16d12cf47454c49e175dd5.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH 7/7] riscv: Add BRS SBI requirement tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com, sunilvl@oss.qualcomm.com
Date: Tue, 06 Oct 2026 21:03:03 +0800
In-Reply-To: <atbvvaynwqhdljjus6jnmcsnugh5oniwke7c3k77q2kgqkbun4@cxhqnhj6mvul>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
	 <20260924033945.176581-8-wangxiang@iscas.ac.cn>
	 <atbvvaynwqhdljjus6jnmcsnugh5oniwke7c3k77q2kgqkbun4@cxhqnhj6mvul>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowACnfvKH8cRq5rwHCg--.25418S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CF1kuF1rKF45Ar4xtFykAFb_yoWDCrW8pF
	ykGFZ0kF95JFyxAw1SyF4DWF9Fvr1FqrnF9r1UK3W5ta9FkrZ3tryqgr909rW8Xr4rGr1v
	9wn3Wrnxu3Z3G3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02Av
	z4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIb
	4SUUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 13:19 +0200=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 24, 2026 at 11:39:45AM +0800, Xiang W wrote:
> > Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
> > Runtime Services specification:
> >=20
> > =C2=A0 SBI_010=C2=A0 spec version must be v2.0 or later
> > =C2=A0 SBI_020=C2=A0 HSM must be implemented
> > =C2=A0 SBI_030=C2=A0 TIME is required unless Sstc is present
> > =C2=A0 SBI_040=C2=A0 IPI is required unless Ssaia is present
> > =C2=A0 SBI_050=C2=A0 RFENCE is required unless Ssaia is present
> > =C2=A0 SBI_060=C2=A0 PMU is required unless Smcsrind, Sscsrind, Smcdele=
g
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and Ssccfg=
 are all present
> > =C2=A0 SBI_070=C2=A0 DBCN is required when ACPI SPCR Interface Type is =
0x15
> >=20
> > Parse the extra ISA names used as skip conditions, and add the RFNC
> > and PMU extension IDs needed to probe those extensions.
> >=20
> > Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> > ---
> > =C2=A0lib/riscv/asm/isa.h |=C2=A0=C2=A0 5 ++
> > =C2=A0lib/riscv/asm/sbi.h |=C2=A0=C2=A0 2 +
> > =C2=A0lib/riscv/isa.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +++-
> > =C2=A0riscv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0riscv/riscv-brs.c=C2=A0=C2=A0 | 171 +++++++++++++++++++++++++++++=
+++++++++++++++
> > =C2=A0riscv/unittests.cfg |=C2=A0=C2=A0 4 ++
> > =C2=A06 files changed, 195 insertions(+), 2 deletions(-)
> > =C2=A0create mode 100644 riscv/riscv-brs.c
> >=20
> > diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
> > index fb3af67d..8a124881 100644
> > --- a/lib/riscv/asm/isa.h
> > +++ b/lib/riscv/asm/isa.h
> > @@ -13,7 +13,12 @@
> > =C2=A0 * by name not tracked here with cpu_has_extension_name()
> > =C2=A0 */
> > =C2=A0enum {
> > +	ISA_SMCDELEG,
> > +	ISA_SMCSRIND,
>=20
> I'm not sure we should expect machine level ISA extensions to be in the
> S-mode ISA string.
>=20
> Indeed the spec says
>=20
> """
> The Performance Monitoring Extension (PMU) MUST be implemented, if the
> counter delegation-related S-Mode ISA extensions (Sscsrind [13] and Ssccf=
g [14])
> are not present.
> """
>=20
> So I'm not sure why you're looking for the M-mode extensions at all.
https://github.com/riscv-non-isa/riscv-brs/blob/main/brs_tests.adoc
OE_SBI_060_010:
  . If Smcsrind,Sscsrind,Smcdeleg,Ssccfg extensions were present(See ME_HR_=
010_010). ..
  Report Smcsrind,Sscsrind,Smcdeleg,Ssccfg was present and Skip the test. .=
 Else ..
  Probe the presence of PMU extension by sbi_probe_extension(). ..
  Verify that the result is true.
>=20
> > +	ISA_SSAIA,
> > +	ISA_SSCCFG,
> > =C2=A0	ISA_SSTC,
> > +	ISA_SSCSRIND,
> > =C2=A0	ISA_MAX,
> > =C2=A0};
> > =C2=A0__static_assert(ISA_MAX <=3D __riscv_xlen, "Need to increase thre=
ad_info.isa");
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
> > =C2=A0	SBI_EXT_DBCN =3D 0x4442434E,
> > =C2=A0	SBI_EXT_SUSP =3D 0x53555350,
> > =C2=A0	SBI_EXT_FWFT =3D 0x46574654,
> > diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> > index b0257979..f5e2a61b 100644
> > --- a/lib/riscv/isa.c
> > +++ b/lib/riscv/isa.c
> > @@ -39,8 +39,18 @@ static void isa_bit(const char *name, int len, void =
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
> > +	ISA_MATCH_AND_SET(SMCDELEG);
> > +	ISA_MATCH_AND_SET(SMCSRIND);
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
> > index 00000000..0d4a8f47
> > --- /dev/null
> > +++ b/riscv/riscv-brs.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *=C2=A0 RISC-V BRS SBI requirement tests
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
> > +
> > +static void check_sbi_010(void)
> > +{
> > +	struct sbiret ret;
> > +
> > +	report_prefix_push("SBI_010");
> > +
> > +	ret =3D sbi_get_spec_version();
> > +	if (ret.error) {
> > +		report_fail("sbi_get_spec_version failed with %ld", ret.error);
> > +		report_prefix_pop();
> > +		return;
> > +	}
> > +
> > +	report_info("SBI spec version %lu.%lu",
> > +		=C2=A0=C2=A0=C2=A0 (ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
> > +		=C2=A0=C2=A0=C2=A0 SBI_SPEC_VERSION_MAJOR_MASK,
> > +		=C2=A0=C2=A0=C2=A0 ret.value & SBI_SPEC_VERSION_MINOR_MASK);
> > +
> > +	report(ret.value >=3D sbi_mk_version(2, 0),
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "SBI spec version is v2.0 or lat=
er");
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
> > +	if (cpu_has_extension(smp_processor_id(), ISA_SSTC)) {
> > +		report_skip("Sstc is present, TIME is not mandated");
> > +		report_prefix_pop();
> > +		return;
> > +	}
> > +
> > +	report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_040(void)
> > +{
> > +	report_prefix_push("SBI_040");
> > +
> > +	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {
>=20
> I'm not sure this is a sufficient check. IIRC, the IMSIC is an optional
> feature of the AIA and the BRS rule states:
>=20
> """
> The S-Mode IPI Extension (sPI) MUST be implemented, if the Incoming MSI
> Controller (IMSIC, [12]) is not available.
> """
>=20
> I think we should check both ISA_SSAIA and ensure each hart has a nonzero
> acpi_madt_rintc.imsic_size. (And, unless, I'm mistaken, the BRS SBI rules
> apply to both BRS-I and BRS-B, so we should implement a DT equivalent
> IMSIC check too.)
>=20
https://github.com/riscv-non-isa/riscv-brs/blob/main/brs_tests.adoc
OE_SBI_040_010:
  . If Ssaia extension was present(See ME_HR_010_010) .. Report Ssaia was=
=20
  present and Skip the test. . Else .. Probe the presence of sPI extension=
=20
  by sbi_probe_extension(). .. Verify that the result is true.
>=20
> > +		report_skip("Ssaia is present, IPI is not mandated");
> > +		report_prefix_pop();
> > +		return;
> > +	}
> > +
> > +	report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_050(void)
> > +{
> > +	report_prefix_push("SBI_050");
> > +
> > +	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {
> > +		report_skip("Ssaia is present, RFENCE is not mandated");
> > +		report_prefix_pop();
> > +		return;
> > +	}
> > +
> > +	report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_060(void)
> > +{
> > +	int cpu =3D smp_processor_id();
> > +	bool skip =3D true;
> > +	bool has_ext;
> > +
> > +	report_prefix_push("SBI_060");
> > +
> > +	has_ext =3D cpu_has_extension(cpu, ISA_SMCSRIND);
> > +	if (!has_ext)
> > +		report_info("Smcsrind is not present");
> > +	skip &=3D has_ext;
> > +
> > +	has_ext =3D cpu_has_extension(cpu, ISA_SSCSRIND);
> > +	if (!has_ext)
> > +		report_info("Sscsrind is not present");
> > +	skip &=3D has_ext;
> > +
> > +	has_ext =3D cpu_has_extension(cpu, ISA_SMCDELEG);
> > +	if (!has_ext)
> > +		report_info("Smcdeleg is not present");
> > +	skip &=3D has_ext;
> > +
> > +	has_ext =3D cpu_has_extension(cpu, ISA_SSCCFG);
> > +	if (!has_ext)
> > +		report_info("Ssccfg is not present");
> > +	skip &=3D has_ext;
> > +
> > +	if (skip) {
> > +		report_skip("Smcsrind, Sscsrind, Smcdeleg and Ssccfg are present, PM=
U is not mandated");
> > +		report_prefix_pop();
> > +		return;
> > +	}
> > +
> > +	report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
> > +	report_prefix_pop();
> > +}
> > +
> > +static void check_sbi_070(void)
> > +{
> > +	report_prefix_push("SBI_070");
> > +
> > +#ifdef CONFIG_EFI
> > +	if (!dt_available()) {
> > +		struct spcr_descriptor *spcr;
> > +
> > +		spcr =3D find_acpi_table_addr(SPCR_SIGNATURE);
> > +		if (spcr) {
> > +			report_info("SPCR interface type is %#x", spcr->interface_type);
> > +			if (spcr->interface_type =3D=3D 0x15) {
> > +				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
> > +				report_prefix_pop();
> > +				return;
> > +			}
> > +			report_skip("SPCR interface type is not 0x15, DBCN is not mandated"=
);
> > +			report_prefix_pop();
> > +			return;
> > +		}
> > +		report_skip("SPCR is not present, DBCN is not mandated");
> > +		report_prefix_pop();
> > +		return;
>=20
> nit: could use a goto to get rid of the repeated
>=20
> =C2=A0 report_prefix_pop();
> =C2=A0 return;
>=20
> lines.
>=20
> > +	}
> > +#endif
> > +	report_skip("ACPI not available, DBCN is not mandated");
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
> drew
drew
  Sorry, my previous reply went only to you. Resending to the list.

