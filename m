Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FF351C02;
	Wed, 26 Aug 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730716; cv=none; b=B8tczfEm8y52RVPmuUkF9h45rSpAs7JxwcgDVK0E9c2UUlr3O8ZZsT00YJR3otZRSZ/7oVHN8W7456E09rhq+ejg5lrvNx0lcUjmLk8ZBmvcsEd2LeR5lkR8gXxZPOI14OnHtX3gL3pvrR23sT7MMVyqACZG6oyMsn4Wvw6+EHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730716; c=relaxed/simple;
	bh=d1I9U36Bvnepl1R8nBbZLJbLSZ7f1mGtFFkK/GvOZ5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJDjrtfegcXmjEtO3XXJTwJxsCTgud/yy8zwUddx7aQVrKt5aUynrZQy4Ka8SC6+ZDmu4rjhEnkUUo1fECbluuPVagv+cCzqWBve3+cjKCOzFy+ED5wlr0epV7rvsBaDHfwKneuoCbuC+9oV7z/fB/Uc7dgqsuwtg3pLqKvaeAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TiYMbbu+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TiYMbbu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yc
	9zQrup+PpPpZzZy0ZJfYR/Eum3M2GHmGKdRuSVXHg=; b=TiYMbbu+bwW059ipIn
	zUb7y8sdSdJGiJ/g9FwN57dSTtescns9k4vvx1bhe8/Yl6H9d7LS82P0YztK/83W
	grW7+Ihz0SKcnwSez7X66VmAXFXFoMlQdUBnRSn3MW9pElJMAMWElJ0iuep0mqxM
	Bw1+bu7YZjYU0y96UIPE/bGPs=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHjBGzmo5qahHQPg--.62147S2;
	Wed, 26 Aug 2026 15:50:16 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] KVM: riscv: Fix NACL hfence entry update order
Date: Wed, 26 Aug 2026 15:50:09 +0800
Message-Id: <20260826075009.68952-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHjBGzmo5qahHQPg--.62147S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF48tw1rXr1DAFyrWFyfZwb_yoW8KF4xpF
	WIkrWrKr4rGryag3sxZws7uryrW3Zagay5t39xuayjkrnxXa4rZwn7trZ8ZryrGr40gF1S
	vrWj9FWj9Fn8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjPfdUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC9BgTvmqOmrj41QAA3q

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The SBI v3.0 specification (section 15.1.2) requires a nested HFENCE
entry to be populated as follows:
1) find an unused entry with Config.Pending == 0
2) update the Page_Number and Page_Count words
3) update the Config word with Config.Pending set

__kvm_riscv_nacl_hfence() writes the Config word first, so the SBI
implementation (or NACL hardware) can observe a pending entry with
pnum/pcount values left over from the previous use of that entry,
resulting in incorrect TLB flush ranges.

Write pnum and pcount first and the Config word last. Since the
consumer is an external agent on coherent shared memory, use
WRITE_ONCE() to stop the compiler from reordering the stores and
smp_wmb() to make the parameter words globally visible before the
Pending bit is set.

Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support")
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 arch/riscv/kvm/nacl.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
index 9aff03c4f667..a5cda9a65156 100644
--- a/arch/riscv/kvm/nacl.c
+++ b/arch/riscv/kvm/nacl.c
@@ -42,12 +42,24 @@ void __kvm_riscv_nacl_hfence(void *shmem,
 		}
 	}
 
-	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
-	*entp = cpu_to_lelong(control);
+	/*
+	 * Per SBI v3.0 section 15.1.2, the Page_Number and Page_Count
+	 * words must be updated before the Config word with its Pending
+	 * bit set. WRITE_ONCE() stops the compiler from reordering the
+	 * stores and smp_wmb() makes the parameter words globally
+	 * visible to the SBI implementation (or NACL hardware) before
+	 * the Pending bit is set.
+	 */
 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
-	*entp = cpu_to_lelong(page_num);
+	WRITE_ONCE(*entp, cpu_to_lelong(page_num));
 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
-	*entp = cpu_to_lelong(page_count);
+	WRITE_ONCE(*entp, cpu_to_lelong(page_count));
+
+	/* Ensure the parameter words are visible before the Pending bit */
+	smp_wmb();
+
+	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
+	WRITE_ONCE(*entp, cpu_to_lelong(control));
 }
 
 int kvm_riscv_nacl_enable(void)
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

