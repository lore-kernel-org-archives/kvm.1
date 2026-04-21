Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB63D904C;
	Tue, 21 Apr 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783331; cv=none; b=SINfIQUw2dBEM0h5jc5s1gHXzjY9OpDLo9SFSlym1EYuaI9LgS7xSQ5BcHFY1IN8lxMyOeMFTsvSxUEczVPLZwnyeR5me7XaUSRt9Jruxh4EUIck5CdbcEClt43D0cUyU97rYlxbBeNYlufkbxBX5wc/VQX3akCVY4ktdAbzFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783331; c=relaxed/simple;
	bh=YJ2E3MhSG9OVK7lke/JRpHjm6mu73ya3Y7+/iS3WWDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8GAqdMmDIbTOkcOeqcwpwKtzMRokAFhcW+2jKtz37gUeFfuF9zbMyY8rO0YFXVPJy/Bv1d0Uprist1giZ9vMl649usPFVniZVn2wwD1W2tpFUIqheSMW7VKL9WCuVe2xhQ+GvHbkCHQJ+PbsyvyZR8r41d/EFysoipOfiFyjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ/sEA+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ/sEA+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37742C2BCB0;
	Tue, 21 Apr 2026 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783331;
	bh=YJ2E3MhSG9OVK7lke/JRpHjm6mu73ya3Y7+/iS3WWDM=;
	h=From:To:Cc:Subject:Date:From;
	b=HZ/sEA+K10hNXtWTJvFffYw8Z3Vg0VinNxwMcbVAvO33uI31wLuDQc0g8bj3/aTSX
	 gtOmieO+tBvgy/ufiZkK+9wVDFxD2xxQZBmqIU+zaSiSQNmZN9SYdtSUIfiK2Kyvua
	 wGfRaVQoD4+KjzCQzJzZ7o/Nzq/kR01SCP/9pvc8nFAMlZueDB08So+crDElLkPscZ
	 aEd8WHpEtf1OO7uAap7uHq5quL1CvY3j/0mDbqJnwWoqrSBIohIexYjpuBv+gcCJfP
	 d1Y8KZnhK/4gRINqaO7b4Yr2uLUzKjqe8xLBNRU6Ud/LZOeK6jHvy5kQUbXdM4lj9B
	 7zi6Dho/j6Lxg==
From: guoren@kernel.org
To: fangyu.yu@linux.alibaba.com,
	cp0613@linux.alibaba.com,
	inochiama@gmail.com,
	me@ziyao.cc,
	gaohan@iscas.ac.cn,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	tglx@kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] RISC-V: KVM: AIA: Convert HGEI management to fully per-HART
Date: Tue, 21 Apr 2026 10:54:47 -0400
Message-Id: <20260421145451.1597930-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Guo Ren (Alibaba DAMO Academy) (3):
  RISC-V: KVM: AIA: Make HGEI number and management fully per-CPU
  RISC-V: KVM: AIA: Replace global HGEI count with simple enabled bool
  irqchip/riscv-imsic: Remove global nr_guest_files after KVM AIA
    per-HART conversion

 arch/riscv/include/asm/kvm_aia.h        |  2 +-
 arch/riscv/kvm/aia.c                    | 58 ++++++++++++++-----------
 arch/riscv/kvm/aia_device.c             |  4 +-
 arch/riscv/kvm/main.c                   |  3 +-
 drivers/irqchip/irq-riscv-imsic-state.c | 12 +----
 include/linux/irqchip/riscv-imsic.h     |  3 --
 6 files changed, 37 insertions(+), 45 deletions(-)

-- 
2.40.1

