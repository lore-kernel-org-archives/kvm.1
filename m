Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613C3EA979
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291368; cv=none; b=b+LjKmRaucSFJ3UWy1/wGH1yJO0/p2KWUDDT4y5CFm+THiMJMDDqno4Mcc5aWv/vFhAE6cwmaZQkj+bCdagiYLOatDuM5AL8pYspsYMJi5eIp4AnlEY9Hdt6sWRrh6cesJvZ7XzhMwpVJUHglfe4N79+KcVKs3x5fQQmOOlmmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291368; c=relaxed/simple;
	bh=6j1iQcyX5SDaUqf6mIsBn/aFKubk9pQwRFG2RVFNazU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAqKvNj5ZPds67kJteuG2NSQY0kaeJ2yBQ4RSiGSGWj1DSl2/V4hIqDuml1t4bVJTwBuJOTY1sFR7wcV34Susb6g76g6KyFDG7VxWGKKQFmyojMsMd+AworOTFnvgSM4BSS40x5CiExmBs2QJpdE/mt+VmQs4VswawTueYcatKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowAAn_O_e78RqnKEHCg--.14198S2;
	Tue, 06 Oct 2026 20:55:58 +0800 (CST)
Message-ID: <bb3df71ce3c4ae0f3276ba56032e11ee208b92d3.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH 0/7] riscv: ACPI boot and BRS-I SBI tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com, sunilvl@oss.qualcomm.com
Date: Tue, 06 Oct 2026 20:55:57 +0800
In-Reply-To: <syzvrpkpdg5gjo4q6fgeypshwc33vzlzy3r6bvu5pqwm5iogl6@gewf5shwul3k>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
	 <syzvrpkpdg5gjo4q6fgeypshwc33vzlzy3r6bvu5pqwm5iogl6@gewf5shwul3k>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowAAn_O_e78RqnKEHCg--.14198S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWDuw13Kr4fWrWrZFWxCrg_yoWrAF1Dpa
	18GFWYkry3Crn3Jw1ayw10kry3Ar18Gw13Jr4xJF1UAw4UCr42qrsFq3yjgryDXF4rGF12
	9a15Cr1ruF1DJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyf
	-PDUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 13:22 +0200=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
>=20
> Thanks for this series, Xiang. I'm glad to see kvm-unit-tests getting
> used. But please make sure you work with the RVI BRS community to ensure
> your work is aligned with their plans.
>=20
> Thanks,
> drew

Thanks for your review;
I will try to get in touch with the RVI BRS community.=C2=A0
I will make modifications based on your suggestions in the next patch.

Regards,
Xiang W
>=20
> On Thu, Sep 24, 2026 at 11:39:38AM +0800, Xiang W wrote:
> > Hi,
> >=20
> > This series lets RISC-V kvm-unit-tests boot on BRS-I platforms that
> > describe the system with UEFI + ACPI instead of a device tree, and adds
> > a first unit test for the SBI rules in the RISC-V Boot and Runtime
> > Services specification [1].
> >=20
> > The RISC-V port currently assumes a DT for CPU bring-up, timer
> > frequency, ISA-string parsing and console setup. BRS-I firmware
> > typically does not provide a usable DT, and often has no MMIO UART
> > either. Without these changes the existing tests abort in setup before
> > they can exercise SBI.
> >=20
> > Patches 1-4 teach the RISC-V library to initialize from ACPI when a DT
> > is absent:
> >=20
> > =C2=A0 - locate the ACPI 2.0 RSDP via the EFI configuration table
> > =C2=A0 - parse MADT RINTC entries for hart / CPU bring-up
> > =C2=A0 - read the timebase frequency from RHCT
> > =C2=A0 - parse the ISA string from RHCT Hart Info nodes (match by ACPI =
UID)
> >=20
> > The RSDP is left in EFI_ACPI_RECLAIM_MEMORY; the RISC-V allocator does
> > not reuse that region, so the table is not copied aside.
> >=20
> > Patch 5 splits CONFIG_SBI_CONSOLE out of the UART driver. io_init()
> > becomes a no-op and puts() issues SBI DBCN CONSOLE_WRITE directly, so
> > EFI/ACPI guests no longer depend on a described MMIO UART to print.
> >=20
> > Patch 6 drops the EFI runner's EFI_USE_ACPI=3Dy early exit. The runner
> > already omits -machine acpi=3Doff in that case; QEMU virt defaults to
> > ACPI enabled.
> >=20
> > Patch 7 adds riscv/riscv-brs.c for:
> >=20
> > =C2=A0 SBI_010=C2=A0 spec version >=3D 2.0
> > =C2=A0 SBI_020=C2=A0 HSM required
> > =C2=A0 SBI_030=C2=A0 TIME required unless Sstc
> > =C2=A0 SBI_040=C2=A0 IPI required unless Ssaia
> > =C2=A0 SBI_050=C2=A0 RFENCE required unless Ssaia
> > =C2=A0 SBI_060=C2=A0 PMU required unless Smcsrind + Sscsrind + Smcdeleg=
 + Ssccfg
> > =C2=A0 SBI_070=C2=A0 DBCN required when ACPI SPCR Interface Type is 0x1=
5
> >=20
> > The new test is in group "riscv-brs nodefault", so it is not part of
> > the default run_tests.sh pass. DT-only QEMU virt is unchanged.
> >=20
> > Based on kvm-unit-tests master (5a221342).
> >=20
> > [1] https://github.com/riscv-non-isa/riscv-brs
> >=20
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > Build:
> >=20
> > =C2=A0 ./configure --arch=3Driscv64 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 --cross-prefix=3Driscv64-linux-gnu- \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 --console=3Dsbi --enable-efi && make
> >=20
> > EFI + ACPI (BRS-I style):
> >=20
> > =C2=A0 EFI_USE_ACPI=3Dy EFI_UEFI=3D/path/to/RISCV_VIRT_CODE.fd \
> > =C2=A0=C2=A0=C2=A0 ./riscv/efi/run riscv/riscv-brs.efi
> >=20
> > Please review.
> >=20
> > Xiang W (7):
> > =C2=A0 riscv: Initialize the ACPI RSDP from the EFI system table
> > =C2=A0 riscv: Add ACPI support for CPU initialization
> > =C2=A0 riscv: Add ACPI support for timer frequency discovery
> > =C2=A0 riscv: Add ACPI support for ISA string discovery
> > =C2=A0 riscv: Decouple SBI console from UART init
> > =C2=A0 riscv: efi: Allow ACPI boots
> > =C2=A0 riscv: Add BRS SBI requirement tests
> >=20
> > =C2=A0lib/acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 67 ++++++++++++++-
> > =C2=A0lib/riscv/asm/isa.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 5 ++
> > =C2=A0lib/riscv/asm/processor.h |=C2=A0=C2=A0 1 +
> > =C2=A0lib/riscv/asm/sbi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +
> > =C2=A0lib/riscv/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 50 +++++------
> > =C2=A0lib/riscv/isa.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 82 ++++++++++++++++--
> > =C2=A0lib/riscv/setup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 55 ++++++++++++
> > =C2=A0lib/riscv/timer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 37 ++++++---
> > =C2=A0riscv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0riscv/efi/run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 --
> > =C2=A0riscv/riscv-brs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 171 ++++++++++++++++++++++++++++++++++++++
> > =C2=A0riscv/unittests.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +
> > =C2=A012 files changed, 424 insertions(+), 56 deletions(-)
> > =C2=A0create mode 100644 riscv/riscv-brs.c
> >=20
> > --=20
> > 2.47.3
> >=20

