Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2231EB5E3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904630; cv=none; b=Jf5PAkYTuGD31rtgtZNRC0O4tkxvA9EfktqrbdMMskdaVHEN2aALXd7DP7r6U+/SYvlIGnrfvae0pO6SrOYbldKS9bAac3EyTWlQ3tPyXDPJjDzpeFWsniHOlhidSM/fqKK+NNEX2YIr6sJK4CD7rIaqjrODpdkVNK3rUBj5rNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904630; c=relaxed/simple;
	bh=bJ7YEEZL7al7qXr+SKm6fJqbPnGlXft4aexFS9JYmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH5TlwjxuKBRIaEcbytS3nYhRvEyFlllZIh4Er7reu6jNMoDyvbaJ1bRmp15AZCumI3hrRDehnRhD3sCwJRKYxTeQrDDvxAArOK716w5n07CKhpfdVCiqc2MOt0QbYdXR/yQLL8SMPnyZmWiAlKzZPyvTqExG+8OT2GJxDBIGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZsTfhUM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsTfhUM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848882fdb18so1669964b3a.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904629; x=1784509429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHNlMRDMMMe/DeM+KYptR6x1Xol+X7QDPM1SwrT/UAU=;
        b=SZsTfhUM7uTJZVdaRra3u08hXLCH3agZjmdiz6KAlvtgcp5LjRW9n+1ljwN4E2cddG
         E8h9iEp+/CS2C4WEGh2bxSPnh8MvNbUsNsQhGVkkkDL17yIKHljYy37sNp/nhd/8K95d
         4Aw/95Nh4Flyo9M9DUBSuN3xeSBhyd/xgp6SEaVTpzIAIibggxFy70ikS+I43QyDiXb3
         vHwLZqK2yWU6gmmp3lg+RXg+JqOmtOjeqCWz+oNhTDpbuuEbJI+2EZLYqlo0r3BVKLPd
         4IDNNLRAu9PCGsqSD3Wuslae8YvKesywU/w/8ImimE3v3SqueTM+tSUduNqpw5YY1Ool
         gJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904629; x=1784509429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHNlMRDMMMe/DeM+KYptR6x1Xol+X7QDPM1SwrT/UAU=;
        b=ohT7FAqK/aNbtikS/HFQQimEbdDDj8pdf0b2U94jZHfaSBJo+fRGfn8x97y9Gf+ph2
         kJ5zAvtIQLQFCVFHewpNpkXX9PmezAY4s9ewP70C+j0gv9CYczZfOmtIZeOuDmi3iqYg
         9OFRguLFYa7QONxvKAwTYdbvwCOALMZ11hly9ZtJH/k8cgFEaci8P/49FhZ35kq2Xu6K
         HVLbc5m8EteGNPJnS5h4GbLPA3pm3mpBFTWsmlGwbsWnikonwVT22R1A7vCG5UMXdgQk
         d0rEpctSRLKz7rGqR+PyK7vP2oRVCYP5YdRjv5Sn+/GtcZCvaUgZJJqaEg5uckHixomA
         fhRw==
X-Forwarded-Encrypted: i=1; AHgh+RpBYvQO17mkgmmmain+VivwGpIEthhSmbCjL8lB/lUK1egL5UZWpKDF+VsG4sqDec3MdpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZHkqWIMKIXBaicSQlmS8o8U6td/ygKNRMxAMolUEkrQ2gBws
	LPGfebN9cvGRTzHTK1Dff/y2IQCbxfam/BDjaRnWL96sdVQs39X0aRCk
X-Gm-Gg: AfdE7cmtVL91BiHZS1AxHaU3cjgst8HhE+FGhOFQMuRBEDRcXn8vSSJXlq0bAZWRfkL
	OHkWRJ+0yfU4M2+2w+qdnZH4QMo4mwfohN+kvVi3IwgkaoNXD033t4mgFMowU7hft+Zs3s+n4+v
	qsnwrpFEIGJxhPn9Luk1Oi5uhaOdmKeZG3ntZKwNyz6NcRj9dtQLOEZgNCVHjRo5vyJ/l2S7cfp
	DduWExym15v0YsMOOzvXWu3oXyFDzrQ/0HOhqEaywCEtAvf974Mvg00Ld5EE27U95IqMceNyTbM
	gbriiC6h210KQ8sTO+yRKrYk34g7Be/GGCYSVDlhalVSXQMECBYIv/Ni+uZG8EyfmvdRH+GDV7E
	ghNR+X2g1mlLARer1bEXMancjIWMPqqyJvyiIP/0PJrotm9mUvHjfHwNS0WQdgtzuP9QTUk1LPA
	A=
X-Received: by 2002:a05:6a00:4fc4:b0:847:7f6a:c56d with SMTP id d2e1a72fcca58-8488967b436mr6947225b3a.30.1783904628530;
        Sun, 12 Jul 2026 18:03:48 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84909673e32sm2292135b3a.56.2026.07.12.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:03:48 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v6 0/8] RISC-V: KVM: Add Svadu/Zicfiss/Zicfilp FWFT support
Date: Mon, 13 Jul 2026 09:02:53 +0800
Message-ID: <20260713010302.303278-1-inochiama@gmail.com>
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

Changed from v5:
- https://lore.kernel.org/kvm/20260706022046.214956-1-inochiama@gmail.com/
patch 1, 5:
1. Switch to csr_read()/csr_write() to update csr
patch 8:
1. Fix the macro name.

Changed from v4:
- https://lore.kernel.org/kvm/20260701020746.170157-1-inochiama@gmail.com/
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
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 183 ++++++++++++++++++
 .../selftests/kvm/riscv/get-reg-list.c        |  90 +++++++++
 9 files changed, 380 insertions(+), 2 deletions(-)

--
2.55.0

