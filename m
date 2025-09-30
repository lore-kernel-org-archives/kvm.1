Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0621A95D;
	Tue, 30 Sep 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223838; cv=none; b=Ia3aojd03jtw8rW3KT8NhshijFl/xrtlzpPSx9VWsAwcYnlFo5ngNec8ROV0sQzheLB6N6EyuxyI9HBWPTqI3YRP8O0QhFOgwHxoeJX0c3KcTtT1oLLWpN9NqRX1G4X6FTzpQ/vL9bS01YhKfAPp+JDmGxmlfDqEoOlCv63S6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223838; c=relaxed/simple;
	bh=N3I5fQT3OYYWs5DlsM2N1pk8lbKd7VQ7zGofh6Ww0uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCPLEq5o+wUXUOpt3p05bhTmWCtVyml/QEz8L4oF5jpBEiZFYpiNYru1AL8ksBIr3hNdl3t6qNS0zYrKhSVvavS45rEf5elTz7TcZgkPYv26+hGCjBznZLljUeQ50AFS8mSXHy5GSrOpB0noTMF6vmCA/zTtQdMa5dVz5GBBA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx3tISoNto+oYQAA--.34699S3;
	Tue, 30 Sep 2025 17:17:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxVOQOoNto4g7AAA--.18527S2;
	Tue, 30 Sep 2025 17:17:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Set page with write privilege if dirty track disabled
Date: Tue, 30 Sep 2025 17:17:02 +0800
Message-Id: <20250930091702.2610357-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxVOQOoNto4g7AAA--.18527S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With secondary MMU page table, if there is read page fault, page write
privilege will not set even if it is writable from master MMU page
table. This logic only works if dirty tracking is enabled, page table
can be set as page_write if dirty tracking is disabled.

It reduces extra page fault on secondary MMU page table if VM finishes
migration, where master MMU page table is ready and secondary MMU page
is fresh.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 7c8143e79c12..a7fa458e3360 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -857,7 +857,7 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
 
 	if (writeable) {
 		prot_bits = kvm_pte_mkwriteable(prot_bits);
-		if (write)
+		if (write || !kvm_slot_dirty_track_enabled(memslot))
 			prot_bits = kvm_pte_mkdirty(prot_bits);
 	}
 

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.39.3

