Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130743DDB04
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221208; cv=none; b=V3yfV8rFwFZwj3CwWpAZ8h97kYbGXEVSLwZTroVAZKXY6XsH5ggoIHznEZsL494/YJAWREKjVjy5t7Co1hl+kvsNSLSnM1no1d7ICrN3CGSAGxkXgwmWuGWD5cdCQ3YV14u77ilgqKfKtzMxUFM1w7oHxStvLPKyXzWAKl0XfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221208; c=relaxed/simple;
	bh=KE3peNXmwpNk89q/SFifyqAdPH7STLkje8RWX2IaelA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljINLAOzCnOiWKo3Ezf7amHeegXs44IujgUIUc5jPYInWfZxR2a296IeLozO74ugC9uxvEHmKpd2Fs+IN0E4r8D/iO/OwymstCrEVNey2LWDXbWddWeXZt8pFvtjq2EBvGPa37V5TlxQqAsrr9tlZb8DiwMWXYo6oYThfyzvWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowAAH3fCFm7Rq4E7JCA--.41214S2;
	Thu, 24 Sep 2026 11:39:49 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	pbonzini@redhat.com,
	thuth@redhat.com,
	Xiang W <wangxiang@iscas.ac.cn>
Subject: [kvm-unit-tests PATCH 0/7] riscv: ACPI boot and BRS-I SBI tests
Date: Thu, 24 Sep 2026 11:39:38 +0800
Message-ID: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH3fCFm7Rq4E7JCA--.41214S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Kw18KF4DCr1xWrW8Xrb_yoW5Aw17pa
	n0kFWYyr98GF93Jw4fZ3Wvkry3Xr1rua13tr4xJr1UA3y7GrWUXFnrtw4UtF9xXFs3X3W2
	9a1Y9F1rCr1DGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUpBT5UUUUU==
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

The RSDP is left in EFI_ACPI_RECLAIM_MEMORY; the RISC-V allocator does
not reuse that region, so the table is not copied aside.

Patch 5 splits CONFIG_SBI_CONSOLE out of the UART driver. io_init()
becomes a no-op and puts() issues SBI DBCN CONSOLE_WRITE directly, so
EFI/ACPI guests no longer depend on a described MMIO UART to print.

Patch 6 drops the EFI runner's EFI_USE_ACPI=y early exit. The runner
already omits -machine acpi=off in that case; QEMU virt defaults to
ACPI enabled.

Patch 7 adds riscv/riscv-brs.c for:

  SBI_010  spec version >= 2.0
  SBI_020  HSM required
  SBI_030  TIME required unless Sstc
  SBI_040  IPI required unless Ssaia
  SBI_050  RFENCE required unless Ssaia
  SBI_060  PMU required unless Smcsrind + Sscsrind + Smcdeleg + Ssccfg
  SBI_070  DBCN required when ACPI SPCR Interface Type is 0x15

The new test is in group "riscv-brs nodefault", so it is not part of
the default run_tests.sh pass. DT-only QEMU virt is unchanged.

Based on kvm-unit-tests master (5a221342).

[1] https://github.com/riscv-non-isa/riscv-brs

Testing
=======
Build:

  ./configure --arch=riscv64 \
              --cross-prefix=riscv64-linux-gnu- \
              --console=sbi --enable-efi && make

EFI + ACPI (BRS-I style):

  EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
    ./riscv/efi/run riscv/riscv-brs.efi

Please review.

Xiang W (7):
  riscv: Initialize the ACPI RSDP from the EFI system table
  riscv: Add ACPI support for CPU initialization
  riscv: Add ACPI support for timer frequency discovery
  riscv: Add ACPI support for ISA string discovery
  riscv: Decouple SBI console from UART init
  riscv: efi: Allow ACPI boots
  riscv: Add BRS SBI requirement tests

 lib/acpi.h                |  67 ++++++++++++++-
 lib/riscv/asm/isa.h       |   5 ++
 lib/riscv/asm/processor.h |   1 +
 lib/riscv/asm/sbi.h       |   2 +
 lib/riscv/io.c            |  50 +++++------
 lib/riscv/isa.c           |  82 ++++++++++++++++--
 lib/riscv/setup.c         |  55 ++++++++++++
 lib/riscv/timer.c         |  37 ++++++---
 riscv/Makefile            |   1 +
 riscv/efi/run             |   5 --
 riscv/riscv-brs.c         | 171 ++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg       |   4 +
 12 files changed, 424 insertions(+), 56 deletions(-)
 create mode 100644 riscv/riscv-brs.c

-- 
2.47.3

