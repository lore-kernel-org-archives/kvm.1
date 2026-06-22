Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5734EEE3;
	Mon, 22 Jun 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100901; cv=none; b=ZyB4sIxozHstk0OnKyEN8QbvoL9LYsmXNWwLN7vij1LF3am+zcBg41NkcOfPKKDctGO45qzgWpR36SvL6mFZ0tko0Lvu8KkkfXLGYOq+PLHdysCb4JFoLpFRK1JJJK5iuc2zdhXSdJJmXeMY+Bb0gmsCuz1jNqZJme2rC4nv+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100901; c=relaxed/simple;
	bh=2Ue0OQWnzEfJvkx9yKoYjaChcgTBWEXuzcW+rzKXsR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZvUgkLP9sW/sh3suWOBkFrjp3PjjLZegB1W+5m8KYe7zFADmWfVL7XZi5n5vAMSiDve4cYqzIZW4v9KMx+Y5qLMivP9T/USLbso8Kip0CC+3EmWhKIMQfBNrsfW/NaWnZRHfzNjYQOEVRaCWmtZnLHV+9m+mBuMysvSbE/dd1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLA34/lO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLA34/lO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45224C2BCB4;
	Mon, 22 Jun 2026 04:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782100901;
	bh=2Ue0OQWnzEfJvkx9yKoYjaChcgTBWEXuzcW+rzKXsR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SLA34/lORaq2vkbGVFcFXeaClBUdvgLejrAyf6dDarlAcLMHXyRXjwPu8O8cySp6+
	 4VT981sldiiCAU5IDyVhvFBOfTsuscyI8ffF8PdMcMjuty0HmiSgq9iUahleLqKQ6/
	 COlJ/aBt+z4/9daFb3yB90wdNptgAQQxGESdhXMbCCv2Ys7WeGsi5xwD8L+EoAGNkQ
	 hNG4Dvg1bK7OplDRptvAXJHUHG+UWDtAPbDOSPcXK0WB08sxp0E18Qn6ggVEw6VAMU
	 +n/B1+usjS7sGtY/rnU58YfgYnTpbgpHpx/Vu0xaKg5eCjkamz31xZOaHVX2f2z01/
	 ijotvrfwL9Z4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2827FCDB46F;
	Mon, 22 Jun 2026 04:01:41 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Subject: [PATCH v2 00/16] riscv: Generate riscv instruction functions
Date: Sun, 21 Jun 2026 21:01:18 -0700
Message-Id: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQqDMBREryJ/3ZTERNN21XsUkWi++kGTkkhoE
 e/e1C4Ls3kD82aDiIEwwq3YIGCiSN5lKE8F9JNxIzKymaHkZc2FUCxQ7FNLLrp2Nd2MTF7Utcq
 xg5WQZ8+AA70O5aPJPFFcfXgfD0l8259Mcf0vS4JxVqlOaVkbgVrfx8XQfO79As2+7x81PW/7s
 AAAAA==
X-Change-ID: 20260114-riscv_insn_table-38495495dfd3
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782100900; l=5328;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=2Ue0OQWnzEfJvkx9yKoYjaChcgTBWEXuzcW+rzKXsR8=;
 b=ne5wljDoG4zphFx5l9ULUKiRBpeUuwuxY2AbZ2BeN3QgGMMOIAhW6sy1FiM117AEx+Bc6kL8v
 lqEFZx/bszkD8yBFpdr3oY3ukUz9KPteAWALGmMar+HG5pTqTeSTnDX
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/20260605
 with auth_id=810
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

There is a lot of code that is manually manipulating riscv instructions.
Constructing these headers for new instructions is time consuming and
error prone.

The first patch in this series introduces the instruction definition
table along with a script that runs at compile time to create all of the
associated instruction manipulation functions. The remaining patches
migrate all of the manual instruction code to use these generated
functions.

The instruction definition table is generated from the
riscv-unified-db[1], an open source RVI project for instruction
specifications. I got this table generation merged into
riscv-unified-db, that PR can be accessed on github [2].

A lot of the validation for these changes is from running all possible
32-bit or 16-bit integers through these functions to see that any given
instruction will produce to expected result. I give more detail on the
test cases in the notes of the first couple of patches.

For the KVM patches, I also introduce two test cases to ensure that the
instruction manipulation is working as expected.

[1] https://github.com/riscv/riscv-unified-db
[2] https://github.com/riscv/riscv-unified-db/pull/1780

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
Changes in v2:
- rebased on v7.1
- I dropped the patch fixing the mmio bug in kvm because in the
  meantime that bug has been fixed in a different patch
- Calls to panic() for instructions not support on current hardware have
  been changed into BUG_ON()
- Fixed incorrect handling of branches in simulate_*()
- Added CONFIG_RISCV_KPROBES_SIMULATE_KUNIT for more detailed
  simulate_*() testing
- Updated insn.tbl based on new merged in changes to riscv-unified-db
- Link to v1: https://lore.kernel.org/r/20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com

---
Charlie Jenkins (16):
      riscv: Introduce instruction table generation
      riscv: alternatives: Use generated instruction headers for patching code
      riscv: kgdb: Use generated instruction headers
      riscv: Add kprobes instruction simulation KUnit
      riscv: kprobes: Use generated instruction headers
      riscv: cfi: Use generated instruction headers
      riscv: Use generated instruction headers for misaligned loads/stores
      riscv: kvm: Use generated instruction headers for csr code
      KVM: device: Add test device
      KVM: riscv: selftests: Add mmio test
      riscv: kvm: Use generated instruction headers for mmio emulation
      riscv: kvm: Add emulated test csr
      KVM: riscv: selftests: Add csr emulation test
      riscv: kvm: Use generated instruction headers for csr emulation
      riscv: kexec: Use generated instruction headers for kexec relocations
      riscv: Remove unused instruction headers

 arch/riscv/Kconfig.debug                           |    1 +
 arch/riscv/Makefile                                |    3 +
 arch/riscv/include/asm/Kbuild                      |    1 +
 arch/riscv/include/asm/insn.h                      |  563 +-------
 arch/riscv/include/asm/kvm_host.h                  |   10 +
 arch/riscv/include/asm/kvm_vcpu_insn.h             |    5 +-
 arch/riscv/include/asm/kvm_vcpu_test_csr.h         |   15 +
 arch/riscv/kernel/alternative.c                    |   23 +-
 arch/riscv/kernel/cfi.c                            |    6 +-
 arch/riscv/kernel/kgdb.c                           |  102 +-
 arch/riscv/kernel/machine_kexec_file.c             |   55 +-
 arch/riscv/kernel/probes/decode-insn.c             |    7 +-
 arch/riscv/kernel/probes/simulate-insn.c           |  253 ++--
 arch/riscv/kernel/probes/simulate-insn.h           |    7 +-
 arch/riscv/kernel/tests/Kconfig.debug              |   13 +
 arch/riscv/kernel/tests/kprobes/Makefile           |    2 +
 .../kernel/tests/kprobes/test-kprobes-simulate.c   |  250 ++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |    6 +
 arch/riscv/kernel/traps_misaligned.c               |  183 ++-
 arch/riscv/kvm/Kconfig.debug                       |   16 +
 arch/riscv/kvm/Makefile                            |    1 +
 arch/riscv/kvm/vcpu_insn.c                         |  232 ++--
 arch/riscv/kvm/vcpu_test_csr.c                     |   21 +
 arch/riscv/tools/Makefile                          |   22 +
 arch/riscv/tools/insn.tbl                          | 1392 ++++++++++++++++++++
 arch/riscv/tools/insn_tbl.sh                       |  256 ++++
 include/uapi/linux/kvm.h                           |    2 +
 lib/Kconfig.debug                                  |    6 +
 tools/testing/selftests/kvm/Makefile.kvm           |    2 +
 tools/testing/selftests/kvm/riscv/csr_test.c       |  126 ++
 tools/testing/selftests/kvm/riscv/mmio_test.c      |  184 +++
 virt/kvm/Kconfig.debug                             |   16 +
 virt/kvm/Makefile.kvm                              |    1 +
 virt/kvm/kvm_main.c                                |    8 +
 virt/kvm/mmio_test.c                               |   95 ++
 virt/kvm/mmio_test.h                               |   18 +
 36 files changed, 2897 insertions(+), 1006 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260114-riscv_insn_table-38495495dfd3

Best regards,
--  
Charlie Jenkins <thecharlesjenkins@gmail.com>


