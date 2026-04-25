Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B41DE894;
	Sat, 25 Apr 2026 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078782; cv=none; b=FI9Gb2AXc2Xh0i3BM28n+i6tzC37VqzcVjKYvDVSE96oxrR/NXZM2MsPw9qUD1ukfSm5bvaTiQhbDIBI5Ntpf0D4NaJbCqw8fGn0/vBZwf3CLHCZoAwxHeU79JVEVrlwox0iQVHshF8tmpbvGl4Hslg6hp11ZNhj/ODq79deIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078782; c=relaxed/simple;
	bh=yYiQ6GsQndYOT4lGdEa6Y9iOgOugX/DHS0AExKOebl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlHr4nRELN1MhA9qlfR/TS0i1VfmaIsUCwMJdc7PAGmf3rh8JqI3Qvi0lqWWcuFWwMNpYqemlzmlE9IgnELIwUE6VksGO7vhNd63nStH6LcEjJMWUCsZX5G4ai2nHrsFHjvQH4Yu54i09vsa+CU4Vb+YW82X6yIUGBL7UrFAaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvcrsgze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvcrsgze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860CC19425;
	Sat, 25 Apr 2026 00:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078782;
	bh=yYiQ6GsQndYOT4lGdEa6Y9iOgOugX/DHS0AExKOebl0=;
	h=From:To:Cc:Subject:Date:From;
	b=TvcrsgzeeZk3k/3/Oa7tFn1mUl8S+MlTozSYqfRRRkZanl9QqfFUdxab5teGBahIm
	 0y7YVgmhGuSKjTtYDpDT5yha4kL+X54ar34oYgVSEv9YZBvSHaxbJge0K6mrDofOaW
	 KByW8elZLqTjoSuV6cuVU5nFfUOXpTFq04zzmRTeysY6ADUo5tjwZUsKtQJKHXbfu8
	 pQDvon2cg9r+l4trzrAO8pZJ7nNmOMFAVjYJVXdWTWe4M7KIKjKF9xJT00Fkuo7J71
	 64dCTrVfshdOOuLRztT4iLcKZDJ6fMfuy8RRBXxxKyWRzln8vOQaA07QE12DCRgVdX
	 /olUV3Cc1NtKA==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	inochiama@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	me@ziyao.cc,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tglx@kernel.org
Subject: [PATCH V2 0/4] RISC-V: KVM: AIA: Convert HGEI management to fully per-HART
Date: Sat, 25 Apr 2026 00:59:12 +0000
Message-ID: <20260425005916.3321811-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

This short series converts RISC-V KVM AIA's Hypervisor Guest External
Interrupt (HGEI) line management from a global "one-size-fits-all"
model to a fully per-HART (per-CPU) model. It also performs the
corresponding cleanup in the IMSIC irqchip driver.

The motivation is to properly support heterogeneous RISC-V SoCs
(big.LITTLE, multi-vendor core mixes) where different HARTs may
expose different numbers of guest interrupt files / HGEIE bits.
The old global `kvm_riscv_aia_nr_hgei` and
`imsic_global_config::nr_guest_files` assumptions are no longer
tenable and are removed.

After this series, HGEI allocation, freeing, and interrupt delivery
are completely per-HART, the code is simpler and clearer, and there
are no remaining global assumptions about guest interrupt file
counts.

Changelog:
V2:
 - Add per-HART IMSIC guest files to compute final HGEI count.
 - Add min(local->nr_guest_files, nr_guest_files);

V1:
https://lore.kernel.org/kvm-riscv/20260421145451.1597930-1-guoren@kernel.org/

Guo Ren (Alibaba DAMO Academy) (4):
  RISC-V: KVM: AIA: Make HGEI number and management fully per-CPU
  RISC-V: KVM: AIA: Replace global HGEI count with simple enabled bool
  irqchip/riscv-imsic: Move nr_guest_files to per-HART local config
  RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGEI
    count

 arch/riscv/include/asm/kvm_aia.h        |  2 +-
 arch/riscv/kvm/aia.c                    | 66 +++++++++++++++----------
 arch/riscv/kvm/aia_device.c             |  4 +-
 arch/riscv/kvm/main.c                   |  3 +-
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++--
 include/linux/irqchip/riscv-imsic.h     |  6 +--
 6 files changed, 53 insertions(+), 38 deletions(-)

-- 
2.43.0

