Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A647CA75
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326862; cv=none; b=Lo73cny05mWmMdpehPbklt3TXj2/lepp1/L82C7bNO2WHfJEQKA7gcfIf3WXpM4QC3aN+MrBF3z93uZvb6kDzGdXlizsy3xKUkv5DB3kIjhJOos0aoT7Sj9h22qOT4AU5uzG3hm8dc/pK62W68gko4wG4brUYOd22MLNPDWcZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326862; c=relaxed/simple;
	bh=iUKsISx97Eyt6gD0CUDPFNVPi3iaca7Phiogt4QFNmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgLe+ayEcKThgh+TTKqbnFNjJIRFKAGwUbdF7RkLZGK56yUaMsetOGt/KCws3ig5Je0qPTrWwvaqOLEayiAulcryluVQ9rbCoxUdnqtesq1q9/AxNxXYiKkKiZ9JJexm3IVBmpOF03kSE3y51blEqJt76WiXJwOhhzvonftKVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMOM4E4H; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMOM4E4H"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so388571a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326860; x=1785931660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLMnpNtLpsL2XHYkd+z33mKUcr79GQx5LDeNnSKUE6Y=;
        b=NMOM4E4H/Es5UZqsV9fPFVl0rVJEPPG+A/3VXI5E+ZjCgQUp+XE4wgRo/koFtjBs4j
         KWuuQ2ZyVK9sC98XdVaFqiCbpyw0YyDlUa28uzlmcUkocpUMEyInSH5dLdWfLcnhSGs/
         Y+rmyFOCWxwLRORacSUXNffta963yjVqvEAp21kMiKs0ATknKcDLnkEF6adQ62do3+kF
         sKuu6al9k/lbrowXY/FELO3SjYxZmQXFgdqjcZ2U3Bq0sX95YyHsq/SZholOzwOnlTSK
         uydapEO/B04YyLKlvGdg30jXX4wWfzC3lqqcYfbhm/ng+ephKzKI58hUrKB2FsOGidF4
         wkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326860; x=1785931660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLMnpNtLpsL2XHYkd+z33mKUcr79GQx5LDeNnSKUE6Y=;
        b=nDalUCwAPxnyZXbJ3t7UnW6GfvKQbPZJsL3zrPMLITjzwHeFdQ6nl7LiIc2IKLquf9
         C9ydqB9iyoVAYZD+YwfiYDt/m8nGC1s23+wEVlaUmHUiC0cBpUBfn275N2LJwc3MjVIA
         hF0RSD9UXyNR85Fcy9QGMsMzisJxOFlQWaPGOYPW/+JQcZK+jmDfdttR5AMa/cCeqjkn
         iWiMJ7uRU5wqvrwjIfSO5QlKTcpYjSCJJE63fGIyel1vUoxQhAtPFgBzD/+ZPjubep8g
         WQ92TLG2egEvvMC6rcIzNhNCqOwNN1c2ePHR8ZJ9flWXVCE1OOs5h2z+kIaE/0h3yGsL
         kZDA==
X-Forwarded-Encrypted: i=1; AHgh+RrNa/hSOjkbobegMltwcPlS9ag1HDZ8mDwEV0U8g4KUcBXBfxBsrwDmfbOrP1uxjJnLrww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2cWNWBIoC2fGIyKmDsXE15KQPja/FouyUI8jiUhZxnhL0cmp
	BKQt4fUisaqwauBZE82BlsmfoUaMMDFa+Xe6kqgTsaLM9CpMvIiOcFRDQV7kFJ9NnCUlbg==
X-Gm-Gg: AR+sD10uTPU92OHX9oyT8y0YvK+NvL+MCxKPWztj1AmgnZ4nx6lgBA39ZDoqJqCSMiV
	DwaWnJZfCEqs6q9a3uWJVsNvMeJLipS6ujlbCQ2FsIdPwdFpwe2kJSU0vzCtVlNHEPHWXEGp+J/
	gOyX+Ub1uCeU2NRMFx/d38GA/JIOfl3E9Y1SyK3CNyLooVxUzfcRRKW1eNQrTtlnOvOKzYBCIwS
	PQv+FQoGpTndCeTdly2aNDvyXRGiuxVlJTpeIvvpyFDN5CQ0vxM1yicfCj1U1cTmFpctOfTcrk1
	BLFmaSq1T3Pw7kLDkXN5fWFapviESnKBAK5BWEXjLJNJsHyFkmSNeCBAqI23JcQvhSzKj5AVi06
	opnG/VK7N+9vdjK5+6n2WANradRZ7ifaSjGO/IqYChoSJjMLoCSAwxvtm9JvQAPA4t79V+6bTN8
	wXf8ShkVIWvF6nla1p1MWp51uOt0Bxd7gq/Lz5xyczRlmQ5sk5+aPui+XrkulV6KfURR8p6kJco
	7vCIq4k9PIsqYA=
X-Received: by 2002:a05:6a00:ab8b:b0:84e:165:da58 with SMTP id d2e1a72fcca58-84e933cefd6mr6852509b3a.52.1785326859904;
        Wed, 29 Jul 2026 05:07:39 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:39 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] RISC-V: KVM: G-stage fault path fix and cleanup
Date: Wed, 29 Jul 2026 20:07:30 +0800
Message-ID: <20260729120733.829457-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729075230.743030-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three small changes to the RISC-V G-stage page fault path, sent as
separate patches per review feedback.

  1/3: Treat -EEXIST from kvm_riscv_gstage_map_page() as a quiet
       success, aligning RISC-V with x86 and arm64.  Real bug fix;
       Fixes: 9d05c1fee837, Cc: stable.

  2/3: vma_pageshift: short -> unsigned int.  No-functional-change
       type cleanup in preparation for sharing a common
       struct kvm_page_fault across architectures.

  3/3: Widen the G-stage fault address to gpa_t end to end -- the
       local in gstage_page_fault(), the (gpa_t) cast before the <<2
       shift, and the fault_addr parameters of kvm_riscv_vcpu_mmio_load/
       store().  This completes the RV32 34-bit GPA fix that v2 only
       half-addressed: v2 widened the local and cast the shift, but the
       address was still narrowed to 32 bits at the MMIO handler call
       (unsigned long parameter), aliasing accesses above 4 GB into the
       low 4 GB.  The handlers' internal uses (run->mmio.phys_addr is
       __u64, kvm_io_bus_read/write() take gpa_t) are already 64-bit.
       Also in preparation for sharing a common struct kvm_page_fault.
       No functional change on RV64.  Not Cc'd to stable: RV32 KVM is
       unsupported and this is untested at runtime.

Changes since v2 [1]:
  - Split into separate patches per feedback.
  - Completed the fault_addr widening v2 left half-done: widened the
    kvm_riscv_vcpu_mmio_load/store() fault_addr parameters to gpa_t so
    the 34-bit address is not truncated at the MMIO handler call.

The KVM_MEM_USERFAULT port that motivated this cleanup will follow as a
separate RFC.

[1] https://lore.kernel.org/kvm/20260729075230.743030-1-shanbeeyoo@gmail.com/

Bingyu.Xian (3):
  RISC-V: KVM: Treat -EEXIST from G-stage map as success
  RISC-V: KVM: Use unsigned int for vma_pageshift
  RISC-V: KVM: Widen G-stage fault address to gpa_t

 arch/riscv/include/asm/kvm_vcpu_insn.h | 4 ++--
 arch/riscv/kvm/mmu.c                   | 8 +++++---
 arch/riscv/kvm/vcpu_exit.c             | 5 +++--
 arch/riscv/kvm/vcpu_insn.c             | 4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.54.0

