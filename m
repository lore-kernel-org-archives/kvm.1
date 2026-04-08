Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4B3358BE;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623596; cv=none; b=gYXM2bCYJ8ss0BN8waxy+E4p3Oo2uXOdCyqLv0pylNalfeCZkMaOa+a7FUevX12C/3NPk1nZfMQ1na+EjuliK1UrSUHHMbmMqZd1Tck2GwtD44V9Nz8Lfc21gmFJBPgVQUNxzMSJKaBwMMiIGoCQF8xKB7HftvVLGJ0hyC1SvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623596; c=relaxed/simple;
	bh=rAI1CPLDiRKGIxKOZmRu8/zalWKsDkVpDctGcchvfIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BACTLMOwHrV99BMS6wN0V0dmK5A+CoMnhTj2sB8Z2jAWjHn/lKFphZcdPGSP2XA2IPsCI401U+5pvB2Rct0qNSsExkAJYVOYVXQWfxfeHHpZuQmfmuSi6nCQfs5V0T/K+CryRDebH/l3mcvtATcvgZE4kUIDVp5rg2hUq+061KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UroqgO/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UroqgO/4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 127D1C19424;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623596;
	bh=rAI1CPLDiRKGIxKOZmRu8/zalWKsDkVpDctGcchvfIE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UroqgO/4mQ09I7T4jvzkHwNdCpGsZc8rmjHLbjIkjkl495lJt5j6yzjAHJx2pBslp
	 ETm+G8/z0gOneW8dOUjryk/s3FHuMaLbB50jZkp2fODCbqHEjMouYysSKculq7rZ9G
	 7SW/mKWmLwvDO6VvNwlnxiKMdcgo7xymRAQtyFjzsvIwVfn3jWEfjYjlGidqGwpFp0
	 pI1g0PSPjZ5QZJVogOpWqHlezLRfa55VR+b6Tr/0mFST/6rpyJ0V6WX1iiudunkNUj
	 4+7mLonESwNOdLCUQiAFKoqzIYat/kQbnAPn2qi5mYO7Lc8nzIZKnC0zYQYn9g9utJ
	 zg87MlXvkcPkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0770CFD5F73;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Subject: [PATCH 00/16] riscv: Generate riscv instruction functions
Date: Tue, 07 Apr 2026 21:45:48 -0700
Message-Id: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzd1WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3aLM4uSy+My84rz4ksSknFRdYwsTS1MgSklLMVYCaisoSk3LrAA
 bGR1bWwsAp7/tpmIAAAA=
X-Change-ID: 20260114-riscv_insn_table-38495495dfd3
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=4407;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=rAI1CPLDiRKGIxKOZmRu8/zalWKsDkVpDctGcchvfIE=;
 b=7x4PTXIx7EN/ZzSPl1d5lxpRaBvp9CB1dq+sX9CzPHHqqpAtcEoH3dqwO/afl/RvHYNThe8tm
 1JDOesSdpzHC7U26ZY76EtB28pEehaqQG4YrIuubLCvZW2hYfdIYjkF
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
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

The instruction definition table is generated from the riscv-unified-db[1],
an open source RVI project for instruction specifications. I am sending
this series at the same time as I am sending the patch to the
riscv-unified-db for the format of the instruction table. That patch can
be accessed on github [2].

A lot of the validation for these changes is from running all possible
32-bit or 16-bit integers through these functions to see that any given
instruction will produce to expected result. I give more detail on the
test cases in the notes of the first couple of patches.

For the KVM patches, I also introduce two test cases to ensure that the
instruction manipulation is working as expected, along with a bug fix of
the current implemention.

[1] https://github.com/riscv/riscv-unified-db
[2] https://github.com/riscv/riscv-unified-db/pull/1780

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
Charlie Jenkins (16):
      riscv: Introduce instruction table generation
      riscv: alternatives: Use generated instruction headers for patching code
      riscv: kgdb: Use generated instruction headers
      riscv: kprobes: Use generated instruction headers
      riscv: cfi: Use generated instruction headers
      riscv: Use generated instruction headers for misaligned loads/stores
      riscv: kvm: Use generated instruction headers for csr code
      riscv: kvm: Fix MMIO emulation for sign-extended insns
      KVM: device: Add test device
      KVM: riscv: selftests: Add mmio test
      riscv: kvm: Use generated instruction headers for mmio emulation
      riscv: kvm: Add emulated test csr
      KVM: riscv: selftests: Add csr emulation test
      riscv: kvm: Use generated instruction headers for csr emulation
      riscv: kexec: Use generated instruction headers for kexec relocations
      riscv: Remove unused instruction headers

 arch/riscv/Kconfig.debug                      |    1 +
 arch/riscv/Makefile                           |    3 +
 arch/riscv/include/asm/Kbuild                 |    1 +
 arch/riscv/include/asm/insn.h                 |  563 +---------
 arch/riscv/include/asm/kvm_host.h             |   10 +
 arch/riscv/include/asm/kvm_vcpu_insn.h        |    5 +-
 arch/riscv/include/asm/kvm_vcpu_test_csr.h    |   15 +
 arch/riscv/kernel/alternative.c               |   23 +-
 arch/riscv/kernel/cfi.c                       |    6 +-
 arch/riscv/kernel/kgdb.c                      |  102 +-
 arch/riscv/kernel/machine_kexec_file.c        |   55 +-
 arch/riscv/kernel/probes/decode-insn.c        |    7 +-
 arch/riscv/kernel/probes/simulate-insn.c      |  253 ++---
 arch/riscv/kernel/probes/simulate-insn.h      |    7 +-
 arch/riscv/kernel/traps_misaligned.c          |  183 ++--
 arch/riscv/kvm/Kconfig.debug                  |   16 +
 arch/riscv/kvm/Makefile                       |    1 +
 arch/riscv/kvm/vcpu_insn.c                    |  233 ++---
 arch/riscv/kvm/vcpu_test_csr.c                |   21 +
 arch/riscv/tools/Makefile                     |   22 +
 arch/riscv/tools/insn.tbl                     | 1391 +++++++++++++++++++++++++
 arch/riscv/tools/insn_tbl.sh                  |  263 +++++
 include/uapi/linux/kvm.h                      |    2 +
 lib/Kconfig.debug                             |    6 +
 tools/testing/selftests/kvm/Makefile.kvm      |    2 +
 tools/testing/selftests/kvm/riscv/csr_test.c  |  123 +++
 tools/testing/selftests/kvm/riscv/mmio_test.c |  184 ++++
 virt/kvm/Kconfig.debug                        |   16 +
 virt/kvm/Makefile.kvm                         |    1 +
 virt/kvm/kvm_main.c                           |    8 +
 virt/kvm/mmio_test.c                          |   95 ++
 virt/kvm/mmio_test.h                          |   18 +
 32 files changed, 2624 insertions(+), 1012 deletions(-)
---
base-commit: dd9b004b7ff3289fb7bae35130c0a5c0537266af
change-id: ${change-id}

- Charlie


