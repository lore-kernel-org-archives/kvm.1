Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC793EFD35;
	Wed, 20 May 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290651; cv=none; b=l5Sz9PlPL0kqVMTcI5pONzIZ9siykvgDpVzePIOorncoE67EyRWvGtrK7GbTxcG5jE+XV/cJF07eyVBHnZFvrzLGChp0Gvsn2UCS9zrDg77BJZdyl1paNqGbs8lF5XjrglBIWv/M1W5fD/ToelEloZd2aNknHPdprz0bDlLwKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290651; c=relaxed/simple;
	bh=i0xwSy6wqDixF09ggrrZwC4KNEJCAWOf7kq+PdQyccc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWHymN3Svvb4SaIbezE1AOXkI9TMoVcnMr2zbHrIOlWJtjpQEztrr4DXJHrEBgjniEaMz86fJGKlp5rxwR33Earbt0Dh04ilWvTL0G5xXIoMfGs4tv6Wm0bGPnxpGuWRpweHq/MA+fEHTNBakIWJ/F4yqRgMU6GJQaAESc5CVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UR+/10Ct; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UR+/10Ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rz
	Etfaoq3iNg6WDH8LoFIArzXVhWsn/xtEQAKiEIad4=; b=UR+/10CtKYy8se4CIT
	ANqE9Xc3xwKDE5WpgPg0gtxVROEYpZOrtUxlVhYewkXlEkMRMZmWqQnROmfUNSBf
	Fgbv51SUVJrfZNAgEiwHJCIB9uTDRkkzmOeU/sq2I9PorgA4kZGBmMSEzvqcE5av
	x5suk2OLRM+/NKurqiVDWtPqs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnt1md0Q1qGHMGCg--.33359S2;
	Wed, 20 May 2026 23:22:06 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm <kvm@vger.kernel.org>,
	kvm-riscv <kvm-riscv@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH 0/3] KVM: riscv: Fix hugetlb G-stage block mapping eligibility
Date: Wed, 20 May 2026 23:21:45 +0800
Message-ID: <20260520152148.131272-1-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnt1md0Q1qGHMGCg--.33359S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48CF4UZw1DAry3Zry8AFb_yoWfKrX_CF
	yrKr93Jw48uFyqkFWDtw48KrZ8G3y0yr9rZF4DZwnrWryj9F4DuFnYvFyI9r18Way3uwnx
	Cr17Ga409w1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKUDGUUUUUU==
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8R558WoN0Z4MrAAA3v

RISC-V KVM checks memslot alignment and head/tail coverage before
installing THP-backed PMD G-stage block mappings, but the hugetlb path
has used the hugetlb VMA size directly. That can be wrong for memslots
whose HVA and GPA have different offsets within the target block, or for
partial head/tail blocks.

Generalize the existing block eligibility helper so it can check a
caller-provided target size, use it to select hugetlb mappings with a
PUD -> PMD -> PAGE_SIZE fallback, and add a selftest mode that creates a
hugetlb memslot with a deliberate HVA/GPA offset mismatch.

Jinyu Tang (3):
  KVM: riscv: Pass the target size to huge G-stage checks
  KVM: riscv: Check hugetlb block mappings against memslot bounds
  KVM: selftests: Add a hugetlb memslot alignment test mode

 arch/riscv/kvm/mmu.c                          | 53 +++++++++++++++----
 .../selftests/kvm/kvm_page_table_test.c       | 28 +++++++---
 2 files changed, 65 insertions(+), 16 deletions(-)

-- 
2.43.0

