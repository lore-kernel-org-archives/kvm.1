Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571080;
	b=iKU0NHT/j78AdTQIB/nlw+hDUT1kpofiJ3gDt5SK/QOxATZ5UXsyAVU2jOX7QMVr4cbm
	 f6bIIPdFSneca7PW2MFFebwrJS19oq1R08WV/sKvYAqEqVBbf2R8Mn1GykCh70L913iN5
	 1sXJhOUDmZ8IUtZPLGeh2JBKnEiVNy9YrB86Ffh4HuwJTTlSGEy1eJdyEaG0RHkZCOG0x
	 bKH+FUV6i6yGJgS2NrqyUTBIgXZvFjxXhxxYGkON12yS3ENK5/nBJPX4umtuTm8oF8vh6
	 SZ+lOl1+qWDwNJsbPchOUb1JrPsDrU09FkqEfib6eWSd+8w5H1h3UAVXCMeX0r7s5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571080;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pxBQm/dFc4CBZiJZ31NoNTLOKC8VnahQcUsRg90O64E=;
	b=wM7ZMKRZu9MNMCgqK8BHgFahY+sPJroPtzkQLi/CV7GONyKrMqoFFsDzY7vyjIwJuOjX
	 KGi58P/rGI6m2v5MQIuo0FhtU6nlduEZwIfDZDuuaB1Fh3zZNQgnfRWfdmOvNodXI7Qbx
	 5gmARSNPhHx3j0PIh6GMp0PlCXEhc1jLR+NW8BAo+WHBQxC0MV+mGi8+oy/F8DHs7FB9w
	 6k/ltk/IcTVNwRz3BhdfndkG+MP9cwySZfi/hvnZVbfdCjDgRdL2GLd6kGH9aRbjeWusJ
	 JRd3EVQZcVd/tTzSpPKN4KxkhjxUUYdeT/yfv3cIwz9zICDMTLRtq/kVos9vITh9CAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F3606A32A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowACXp5h3PQZrj9m8AQ--.815S2;
	Wed, 25 Nov 2026 09:44:25 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 0/9] riscv: ACPI boot and BRS-I SBI tests
Date: Wed, 25 Nov 2026 09:44:00 +0800
Message-ID: <20261125014409.79852-1-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXp5h3PQZrj9m8AQ--.815S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWUuFWkuw4DCw1rGFWUCFg_yoW7GFy5pF
	ZxWrySkr93GFyxZws3Zw18GryrAr1rua13tr1xXw45u3yxGrWDXrs3Kw4jyFn8GF1rAa12
	9F4F9F4rCrn8G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUfR6wUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Hi,

This series lets RISC-V kvm-unit-tests boot on BRS-I platforms that
describe the system with UEFI + ACPI instead of a device tree, and adds
a first unit test for the SBI rules in the RISC-V Boot and Runtime
Services specification [1].

The RISC-V port currently assumes a DT for CPU bring-up, timer
frequency, ISA-string parsing and console setup. BRS-I firmware
typically does not provide a usable DT, and often has no MMIO UART
either. Without these changes the existing tests abort in setup before
they can exercise SBI.

Patches 1-4 teach the RISC-V library to initialize from ACPI when a DT
is absent:

- locate the ACPI 2.0 RSDP via the EFI configuration table
- parse MADT RINTC entries for hart / CPU bring-up
- read the timebase frequency from RHCT
- parse the ISA string from RHCT Hart Info nodes (match by ACPI UID)

Patch 5 falls back to the SBI DBCN console when UART initialization
fails, so ACPI guests without an MMIO UART can still print. Patch 6
drops the early exit in the EFI runner that previously rejected
EFI_USE_ACPI=y.

Patch 7 moves isa_init() into cpu_set_fdt() and cpu_set_acpi() so
cpu_has_extension() can read every hart's ISA bits from the boot hart,
including secondaries that have not started yet.

Patch 8 captures S-mode IMSIC interrupt file addresses at boot time.
The DT path is Andrew's posted patch [2]; the ACPI path copies
RINTC.imsic_addr only when an IMSIC structure is present in the MADT,
as ACPI requires OSPM to ignore that field otherwise.

Patch 9 adds riscv-brs, a unit test that checks the SBI requirements
from the BRS specification (version, HSM, TIME/Sstc, IPI/IMSIC,
RFENCE/IMSIC, PMU/Sscsrind+Ssccfg, and DBCN when SPCR type is 0x15).

v3 changes
==========
Address review comments from Andrew Jones on v2, except the three
points in the next section.

- call isa_init() from cpu_set_fdt() / cpu_set_acpi() rather than
  looping in cpu_init()
- RHCT parsing: (void *)node, reverse fir tree, assert_msg, treat a
  bad offset as an assert
- drop unnecessary CONFIG_EFI guards around <acpi.h>
- check Sstc and Sscsrind+Ssccfg on all present harts
- use thread_info.imsic_addr instead of parsing IMSIC in the test
- ACPI IMSIC: ignore RINTC.imsic_addr unless an IMSIC MADT structure
  is present
- coding-style nits (braces, SBI enum alignment, report_skip wrapping,
  "Initialize" capitalization)

Differences from the v2 review
==============================
1. Console policy (patch 5)

   The suggested diff prefers SBI DBCN whenever CONFIG_SBI_CONSOLE is
   set and DBCN probes successfully, with UART as a fallback.

   This version keeps UART when initialization succeeds and uses DBCN
   only if there is no usable UART. Each DBCN write is an SBI ecall,
   which is slower than an MMIO UART store, so the fast path should
   stay on UART when one is present. Guests without an MMIO UART still
   print via DBCN.

2. SBI_010 version comparison (patch 9)

   The review asked to compare (ret.value & SBI_SPEC_VERSION_MASK)
   against sbi_mk_version(2, 0). The test already decodes major and
   minor for the report string, so it compares
   sbi_mk_version(major, minor) instead. That drops the reserved bit
   the same way and avoids encoding the version a second time.

3. SBI_040 / SBI_050 IMSIC check (patch 9)

   v2 parsed DT/ACPI on every call, and the review asked to cache
   all_harts_have_imsic(). After patch 8 the check is a walk of
   cpus[].isa and cpus[].imsic_pa, so the two tests keep their own
   loops rather than sharing a cached helper.

Tested with QEMU virt:

  ./configure --arch=riscv64 \
              --cross-prefix=riscv64-linux-gnu- \
              --console=sbi --enable-efi && make

  EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
    ./riscv/efi/run riscv/riscv-brs.efi

[1] https://github.com/riscv-non-isa/riscv-brs
[2] https://lore.kernel.org/all/20261120135613.1388647-1-andrew.jones@linux.dev/


Xiang W (9):
  riscv: Initialize the ACPI RSDP from the EFI system table
  riscv: Add ACPI support for CPU initialization
  riscv: Add ACPI support for timer frequency discovery
  riscv: Add ACPI support for ISA string discovery
  riscv: Fall back to SBI DBCN when no UART is available
  riscv: efi: Allow ACPI boots
  riscv: Initialize ISA extensions for all harts at CPU setup
  riscv: Capture IMSIC addresses at boot time
  riscv: Add BRS SBI requirement tests

 lib/acpi.h                |  64 ++++++++++++-
 lib/riscv/asm/imsic.h     |   8 ++
 lib/riscv/asm/isa.h       |   3 +
 lib/riscv/asm/processor.h |   2 +
 lib/riscv/asm/sbi.h       |   8 +-
 lib/riscv/imsic.c         |  86 +++++++++++++++++
 lib/riscv/io.c            |  52 +++++++----
 lib/riscv/isa.c           |  96 ++++++++++++++++---
 lib/riscv/processor.c     |   1 -
 lib/riscv/setup.c         |  71 ++++++++++++++
 lib/riscv/timer.c         |  35 ++++---
 riscv/Makefile            |   2 +
 riscv/efi/run             |   5 -
 riscv/riscv-brs.c         | 192 ++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg       |   4 +
 15 files changed, 577 insertions(+), 52 deletions(-)
 create mode 100644 lib/riscv/asm/imsic.h
 create mode 100644 lib/riscv/imsic.c
 create mode 100644 riscv/riscv-brs.c

-- 
2.47.3

