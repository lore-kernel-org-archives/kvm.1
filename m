Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866857;
	b=TDSYgEGRa3qTzne46bZMo2jypl5hgkn0eThy7ZlolsKjY9PLyGsNoyDU0re8eGlh3Nzh
	 Ri+meYn09FSigjFGHjM6lWsSCCEAER3BCuGVwe0aF+p0/UBkkEzARVJJktPBR7ZJ4P/uH
	 QAPH+PN04wiNyZR570YiXTC85Nsx9YsDGtnJ00fqSIQEPWR9q4enUYXqUJVEt6iHUKp25
	 c3pRtPEr+I11G53SqlZRLX3EtyRh174902crOdnMZRa1t3CxL+muOPVyWWa/tPW8EgSum
	 ksUxOboOz4JHh/bqTezP5PWL58S4xQETxRz4N2NBKsBzqZQXpdQg6ojOM+QukxJPNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866857;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=O5/6r82tJu/ZJpQm08kZaEJWWmkuUpEkkAGhfbDp4CU=;
	b=irRBTVY3m37/UfvuEW0d75fnzlwnKZT+NhQ6sDH/lpPtpLv5ml8DPK+s+OiVVrnihrwQ
	 v/hmqiVSgRLgkSXZh+RRRhmYuajsh3LrJaVqizyOkSrIWNu0EMP31sRL4A6pWXPs4IddY
	 Q6I/YiHLvt7tHpcFNssa964LNotyO53M5JV+R1ShGCFB2+KQQbzoqBHBWw8M6oWOotuex
	 8Jm5M+qb1b2Ef18nEU9uccxgnefiiS5LGOxZniXtQanhNt63VMQpK7Vly9IjO/Dl0t7DW
	 WnxNPf1aVu2hQZjuZKvBO4Wx4kBNi0PZZlqnMz39H97VPP50J1jJGU4UUXR7c60RlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957D606A331
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5957D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAD3I_5WPOxqlCdRAA--.3645S2;
	Thu, 05 Nov 2026 16:20:39 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 0/8] riscv: ACPI boot and BRS-I SBI tests
Date: Thu,  5 Nov 2026 16:20:27 +0800
Message-ID: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAD3I_5WPOxqlCdRAA--.3645S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Kw18Kw15WF43Zr4rGrg_yoW5Ww4UpF
	43WFn0kF93GFyfCw1fZw18GryfZ3Wruw13tr1xJr17J3yxCrWUXrnxKw4qyF9xJF4rX3W2
	9a1F9F1rur4DJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

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

Patch 5 prefers the SBI DBCN console when available and falls back to
the UART path otherwise, so ACPI guests without an MMIO UART can still
print. Patch 6 drops the early exit in the EFI runner that previously
rejected EFI_USE_ACPI=y.

Patch 7 moves isa_init() into cpu_init() so that every hart's ISA
extensions are parsed once the CPU list is known, rather than only for
the hart that first reaches thread_info_init().

Patch 8 adds riscv-brs, a unit test that checks the SBI requirements
from the BRS specification (version, HSM, TIME/Sstc, IPI/IMSIC,
RFENCE/IMSIC, PMU/Sscsrind+Ssccfg, and DBCN when SPCR type is 0x15).

v2 changes:
- Address review comments from Andrew Jones
- Prefer SBI DBCN with UART fallback instead of making SBI console
  exclusive (patch 5)
- Initialize ISA extensions for all harts in cpu_init (new patch 7)
- Check Ssaia + S-level IMSIC presence for the IPI/RFENCE skip
  conditions, and note the M-mode extension limitation for PMU

Tested with QEMU virt:

  EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
    ./riscv/efi/run riscv/riscv-brs.efi

[1] https://github.com/riscv-non-isa/riscv-brs

Xiang W (8):
  riscv: Initialize the ACPI RSDP from the EFI system table
  riscv: Add ACPI support for CPU initialization
  riscv: Add ACPI support for timer frequency discovery
  riscv: Add ACPI support for ISA string discovery
  riscv: Prefer SBI DBCN console with UART fallback
  riscv: efi: Allow ACPI boots
  riscv: initialize ISA extensions for all harts in cpu_init
  riscv: Add BRS SBI requirement tests

 lib/acpi.h                |  64 ++++++++-
 lib/riscv/asm/isa.h       |   3 +
 lib/riscv/asm/processor.h |   1 +
 lib/riscv/asm/sbi.h       |   2 +
 lib/riscv/io.c            |  41 +++---
 lib/riscv/isa.c           |  93 +++++++++++--
 lib/riscv/processor.c     |   1 -
 lib/riscv/setup.c         |  59 +++++++++
 lib/riscv/timer.c         |  38 ++++--
 riscv/Makefile            |   1 +
 riscv/efi/run             |   5 -
 riscv/riscv-brs.c         | 265 ++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg       |   4 +
 13 files changed, 532 insertions(+), 45 deletions(-)
 create mode 100644 riscv/riscv-brs.c

-- 
2.47.3

