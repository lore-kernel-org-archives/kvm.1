Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDF305679;
	Thu,  4 Jun 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614314; cv=none; b=kc04hGtfbRUVlPRQpmITZi5P77soRCSaoym8NKxMbKph1BJkhrGP6BwJLrvsoseut21+8alAxU2u43yM99GkLzbMJXz/sxCsvbXzTbh0+u7Bkv/GO4+E0E7JjWW8Pw3/M+jnr5kgDN9TstQ6YzXKcCfhYunSuHRovnHWLtrwVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614314; c=relaxed/simple;
	bh=WMr4Mq3PKiG3lAfmy9SXcPUY/ewDHR9wLzBGIl4ABiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMgF5gP8Co0iV+VfCFAZZ30BeaWDbr/9DTywFSQAtPQIwJSTN46UEd9+DiUkKda75Lz1YeAwZWFsmUtgAmz2Cqb6VWRLdsG5rwvBCiKAdjssvRPQ4GHMVQs0mCRhUX33WO/ep0fQHcnz3ZP4KEW9/YtvBtovYQbiO3LHR7CqkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NZzRJ8hB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NZzRJ8hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hp
	TAP1nL3qYWFA5TtGpFod5MmlFUh4wPDF/QkCHoWUc=; b=NZzRJ8hBgx1Ee/7eDq
	EEqgbdBUD3+vOM0UApoX2xdWpSOtiTFsq+hQczw+r8w+VhbVRMOSpxvZLKW193bQ
	PsBFRlp3jXkHZ0Gj6sobNR+YZjyu/+sNRufkXxQrS+RYM4cnmOE6V7czWDTiPpxc
	Q+LAbbHYMBrsxzF97BNiC1r4o=
Received: from wufei (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3H9tJBCJqsfP6BQ--.26783S4;
	Fri, 05 Jun 2026 07:03:52 +0800 (CST)
From: atwufei@163.com
To: seanjc@google.com,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Wu Fei <wu.fei9@sanechips.com.cn>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range
Date: Fri,  5 Jun 2026 07:03:15 +0800
Message-ID: <20260604230317.30501-3-atwufei@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260604230317.30501-1-atwufei@163.com>
References: <20260604230317.30501-1-atwufei@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3H9tJBCJqsfP6BQ--.26783S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4xKw1kXFWrGrW7JFykuFg_yoW8GF1Upr
	sxCas3Cr1rtwsxZF13tFWkuwsxGrs3KF43try7Za4v9Fn8Xw48Arn7Xr929rW3XF97XayD
	uFWDGFyrur4IqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsYFAUUUUU=
X-CM-SenderInfo: pdwz3wlhl6il2tof0z/xtbCzRg622oiBFjtWwAA3W

From: Wu Fei <wu.fei9@sanechips.com.cn>

Same as kvm_riscv_gstage_wp_range, the possible valid pages should not
be skipped if !found_leaf. Different from wp case, which can
write-protect more than asked, unmap can't do that, no splitting is
added right now but a warning is logged instead.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 arch/riscv/kvm/gstage.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 2b141a78ecac..d78f5aeb8b40 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -395,15 +395,19 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 		if (ret)
 			break;
 
-		if (!found_leaf)
-			goto next;
-
-		if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
-			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
-						ptep_level, GSTAGE_OP_CLEAR);
+		if (!found_leaf) {
+			addr = ALIGN(addr + 1, page_size);
+		} else {
+			if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
+				kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+							ptep_level, GSTAGE_OP_CLEAR);
+			else {
+				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %#lx\n",
+						addr, end, page_size);
+			}
 
-next:
-		addr += page_size;
+			addr += page_size;
+		}
 
 		/*
 		 * If the range is too large, release the kvm->mmu_lock
-- 
2.51.0

