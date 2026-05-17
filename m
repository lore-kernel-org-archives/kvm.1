Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A635CB81;
	Sun, 17 May 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032265; cv=none; b=kJ18h62xc/vrb4ci+t6bK/kl0lUXr+VAfBYjFwyIWCY4g0x08WegXAYSVNscj5tzmfUYJ+ML4J6z4EQXNpD2MZOpv7AgpoxdClkx4eZ7uDzGY0yIuCIGAttUXB6zh8sYbZnubMoezAzOIdvJlvRkOg6yGraOeGhaoScxQIzfIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032265; c=relaxed/simple;
	bh=70tFVHzck9md3U6VRO1tTK/BQneNRwIcHnjlEDyjPJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgsJhdlBgY+Frw/CNDW54aEzg3tfqm404ovG3/9tUiu2Bo0eeJ/5rSqJsk5w8I0gJoYrAVyaabE3dr7ci2YxHy5ZKOYL3QBvECaOXDhDwkX4/REoXUSQEa16GUOa1CaeLQ/cz6S9KY+8vbSrMrsYP26geP1b9NV6KcbLP2Dzmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cNdf7/9a; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cNdf7/9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GS
	RXubJm/GTIB2NyfMCMfFiE+Wj4O/jjRpn2yvJTgg8=; b=cNdf7/9a8wM9X4TBcT
	4zZ2UCoK6d6HCiyJkAvZJ0DCDafJP/gmCKaF7iNnfv6YC308750AVGkVWWHzmoAe
	BWXn9vVnJ9grWVdY4hNGeIj99IcobInW/xhsxmOKfJ8bP7+PzlqhaFqwVf+4lzD8
	IbpvNOsRSiDZixyxGRCZuo/C4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S6;
	Sun, 17 May 2026 23:34:59 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH 4/5] KVM: riscv: Update G-stage PTE permissions atomically
Date: Sun, 17 May 2026 23:34:26 +0800
Message-ID: <20260517153427.94889-5-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517153427.94889-1-tjytimi@163.com>
References: <20260517153427.94889-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xJrykWF45Zr1kKF1DGFg_yoW8Ww43pF
	WDCry3ur4rKwnxCF4Sqw1vyrs8uFs7Kw4rJr9Fv34DAF15trW8Xrn093yYyr98AF97Xa4Y
	vrW0gF1UGr48twUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pifcTLUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8QMdlWoJ4CM3MgAA3f

When a fault hits an existing G-stage leaf with the same PFN, KVM only
needs to update the PTE permissions. This path will be used by read-side
fault handling, so it must not overwrite a concurrent PTE update.

Use the cmpxchg helper when relaxing permissions on an existing leaf,
following the same concurrency model used by x86 for atomic SPTE
permission updates. Retry if another CPU changed the PTE first, and use
cpu_relax() while spinning.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/kvm/gstage.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index d70584b9e..9595169da 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -182,17 +182,22 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 static void kvm_riscv_gstage_update_pte_prot(struct kvm_gstage *gstage, u32 level,
 					     gpa_t addr, pte_t *ptep, pgprot_t prot)
 {
-	pte_t new_pte;
+	pte_t old_pte, new_pte;
 
-	if (pgprot_val(pte_pgprot(ptep_get(ptep))) == pgprot_val(prot))
-		return;
+	for (;;) {
+		old_pte = ptep_get(ptep);
+		if (pgprot_val(pte_pgprot(old_pte)) == pgprot_val(prot))
+			return;
 
-	new_pte = pfn_pte(pte_pfn(ptep_get(ptep)), prot);
-	new_pte = pte_mkdirty(new_pte);
+		new_pte = pfn_pte(pte_pfn(old_pte), prot);
+		new_pte = pte_mkdirty(new_pte);
 
-	set_pte(ptep, new_pte);
+		if (kvm_riscv_gstage_try_update_pte(gstage, level, addr, ptep,
+						    old_pte, new_pte))
+			return;
 
-	gstage_tlb_flush(gstage, level, addr);
+		cpu_relax();
+	}
 }
 
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
-- 
2.43.0

