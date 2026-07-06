Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7937C923
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304493; cv=none; b=nMoF+cRSNman3xzhX9xFb1Rs0mPE96POG85JjQxHyAfwKSyEQ3DFdMrmdV7bObfmf4QSBF2C74nG51xT+zeFN/+aZ9N/S1iwU0VDOnju8DgOJ3WVl/+kWkKYMqJs3VmIDFNoxx2oD2IP+rLaJ9cEznFcqZe5Atm8kZ7NBHLwKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304493; c=relaxed/simple;
	bh=jdqrdxRgXPPiobqccePzQm12KSBszYg3zz082KpcP7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEtiZNgePLVqH7nKePgAnmPlEENatsaPGY8oztAoVRr7kOwyg6N1VJuK+ixvPiI3dvVB6UgI9ggjMpRNMsGGXO19mVglYUmjFoCt93WNVV2ikFQUy5XnuhgsLlgLjLx9G6z/ejXHer4rbrxFvf7TxjxfsEM+nsRlvp1P+7DgH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnMIZk5p; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnMIZk5p"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c88973b6965so2319881a12.1
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304492; x=1783909292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blzW8cj7qixZrZx8HMTc8WTCaoiy272JiHUFbPafbvA=;
        b=UnMIZk5pHHk9716V/7gR2QpKFjuSiKgWR3Fcs/gvOdnEvy1a03TG7c7jC+4HQ9WvJ0
         2iIFSMklHGqIiL565MYiUVRbV4Jadae4UNtTNYlZnXaqHwv6aCzvLeM2M5TBluazX4X5
         SMP5nHPZMhA2LryAma30P2C4AJhMKA+OqnDTqIY3nG/oPpoazjV/T2lcuAdqUG/5D5hl
         hUlGMB+Nnxdy3OjinRBlRPLqmKufePXswtPmfLW6V1oRZb1/yDEBSn07rTA4HFdOHdL3
         3+HfP3oK0RPyFOpzLpE3GfX68uYcWMRRVL6hoSC5LOnpjEhOsG9RUDPGl13Q9ueDc3ti
         lEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304492; x=1783909292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blzW8cj7qixZrZx8HMTc8WTCaoiy272JiHUFbPafbvA=;
        b=DrPfonq7Hnv79AKYLwJ9tTdsywf8y14tJ1YVZgc254o/CQGR5oxNQav3DbtJcXMb2+
         gZPCaSevCqFlPg/bh3W4S4jurjc9VORQr4ZJzu+rm/ExP79UhNXvWlT6rdjcwXufP+38
         rWinx7E98er2OBxvU4IL10gONyqNaSd3WZpwJ+tGg9fYcoMUugJDXYd2k+M9IZevMeCI
         3+uuSVaTIs6f4556jH5E6y6/b9lfHQ9kV9mvohQ1ku23s4LLfLZaxeRA45qmwvkiMvt2
         nHC3wS2V4tKow/3PLeuzcbbu/cMwwnpwDefbIKhO67xOSvsMJGRs0cbSZrVptT7y5J02
         va3A==
X-Forwarded-Encrypted: i=1; AHgh+Ro3bISQ2GK7y05HiIm9KWF4zTJmL0Y4wkRLuFmm+djkyrfh0J/yX9aIrbYTgbXcVn19Jfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2GlxgE17kd4sJL3lGnR/JoAr24NGRVOMovUWHX5s/P2m9oGq
	lEoreQR9wiZ/U/wkwre1GTyJG3Vwnua9L20R3lpQXUFPrX3yqkQmmEtR
X-Gm-Gg: AfdE7clJeWZDRh4zoK/GGN5Epqbo1O9VUIJhlyh3bCkSzFcuL76sBrh7eiP9vke4n96
	chS4CGQ7yoSRdCsWkQ0CZGq8eU6lLHFEPGt6nXHVkxJf4pqrz1MHNDhzseY4olE7P/EwZqpeO58
	AGWGA8UbFZ6P1pvvKro/FvMp+Gk/SD6x/fR38jP0xdYbHPcM6UJmrDj42xb0J/OInt+x9oaccqk
	PakvJv2f+Byjjh+vyjGu61o5iFmy98IQedKlbKKHvHHEIqqwJSfSf6YbVgED+7TPsJlTv09wz7/
	++wpWfOQXI9h/oXsT5kto1MDojXNc1Wxaf00dH26vSSU1S6m3llh+x0qYeYdg9RRmdGr0ul/NcD
	szCFXw5XScuJtSWrMUk/jauYvWTzQ9oQ715s8yaAD9taLPC9R7MJVegOV33aqQLxy
X-Received: by 2002:a17:90a:d40c:b0:37f:f089:c81b with SMTP id 98e67ed59e1d1-383394cf557mr5675419a91.3.1783304492074;
        Sun, 05 Jul 2026 19:21:32 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38146b8d314sm3764140a91.15.2026.07.05.19.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:31 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 0/8] RISC-V: KVM: Add Svadu/Zicfiss/Zicfilp FWFT support
Date: Mon,  6 Jul 2026 10:20:36 +0800
Message-ID: <20260706022046.214956-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset based on the patchset "RISC-V: KVM: Add Zicfiss/Zicfilp
support".

The patch includes all the function of original patchset from Quan:
adding the Svadu/Zicfiss/Zicfilp FWFT for the RISC-V KVM. And this
patchset already passes the KVM unit test.

Test with the patch applied
https://lore.kernel.org/all/20260618064406.14508-1-cuiyunhui@bytedance.com/

Changed from v4:
patch 1:
1. Use NACL for csr update
2. Check ISA mapping before cleaning the ADUE bit
patch 4:
1. Clear the zicfiss csr during a VCPU reset
2. Add zicfiss csr to num_csr_regs()
patch 6:
1. Cleanup SPELP after redirecting the trap
patch 7:
1. Use interrupt bit instead of number for masking/unmasking
patch 8:
1. Add missing entry for the test
2. Fix the wrong comment.

Changed from v3:
- https://lore.kernel.org/kvm/20260607081105.993908-1-inochiama@gmail.com/
1. rebase to the v7.2-rc1
2. Tested with the updated Svadu patch
3. Remove the dependency as it is already merged.

Changed from v2:
- https://lore.kernel.org/kvm/20260601084336.2601675-1-inochiama@gmail.com/
1. rebase with Yong-Xuan's patch set
2. Add SSP CSR context switch/set/get
3. Move the software-check exception set/unset into FWFT
4. Only delegate software-check exception when Zicfiss/Zicfilp is enabled.
5. Make KVM SBI_FWFT_PTE_AD_HW_UPDATING depends on both Svadu and Svade
   enabled.

Changed from Quan's v1:
- https://lore.kernel.org/kvm/cover.1764509485.git.zhouquan@iscas.ac.cn/
1. rebase to the latest master.
2. Split Svadu change as separate patch
3. Fix all build error from the original series
4. Remove the Svadu check in kvm_riscv_vcpu_config_ran_once() and in
   favor of the FWFT.
5. Remove the LPE/SSE setting bit in kvm_riscv_vcpu_config_ran_once()
   (kvm_riscv_vcpu_setup_config() in original patchset)

Inochi Amaoto (8):
  RISC-V: KVM: Add support for Svadu FWFT features
  KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
  RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
  RISC-V: KVM: Add ssp context save/restore
  RISC-V: KVM: Handle software-check exits for VCPU
  RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is
    enabled.
  RISC-V: KVM: Add support for control-flow integrity FWFT features
  KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list
    test

 arch/riscv/include/asm/csr.h                  |   1 +
 arch/riscv/include/asm/kvm_host.h             |   7 +
 arch/riscv/include/uapi/asm/kvm.h             |  13 ++
 arch/riscv/kvm/isa.c                          |   2 +
 arch/riscv/kvm/vcpu.c                         |   7 +
 arch/riscv/kvm/vcpu_exit.c                    |  11 ++
 arch/riscv/kvm/vcpu_onereg.c                  |  68 ++++++-
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 184 ++++++++++++++++++
 .../selftests/kvm/riscv/get-reg-list.c        |  90 +++++++++
 9 files changed, 381 insertions(+), 2 deletions(-)

--
2.55.0

