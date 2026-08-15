Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408E38F646
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789974; cv=none; b=Ehk2At8mY10JJ4fXtThQscFCw+R1yonjihhiXWE7dUbk/e94sDv+zpbpV1CbUoj9R5sypDI/q5DBQXc+VecUtxuUM8Lbcx6r6NllKu6s1nnRcO8602chjRrQiAvwpTHMR6K3+2C3JA/zCvqvrTRkB0XN0lmY64I9tDpW0g11QTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789974; c=relaxed/simple;
	bh=Ibq8FmFzfS79pa12j1e6KYtVVh8objCmcS0oBVDNFx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhrmu4XrFhWn1Ivki+WCmVJEfwGuNusW7ZDK1rkdn5YHtKuqvvWZEFGGkXSSWc259xtTDb7VGoIwvRtv38EhPcW0ALIDm+UVFgEomkrqxlOpIA2+Ti9wvpgxvYRkRP1LadbvZ3/UykrcHzaDTX9zRJXa9iDJBXn6gxv10T1L9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8ivNWyO; arc=none smtp.client-ip=91.218.175.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8ivNWyO"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ibq8FmFzfS79pa12j1e6KYtVVh8objCmcS0oBVDNFx4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786789970; v=1; x=1787394770;
 b=g8ivNWyO3v3Dij2KONxAnpatucSpKfXzw+XfxpIKqN/3zbljg4ePgHMhbnVnUICOELUn8LCR
 7njT5k+rmYDbRwV/jz1nHX3jxONhCApLOrYFPRDjsAev7oGN5GalgKCiyUek38M4JDNEunBsaP/
 2i6foFGgIP8ywmnaHIgtntiQ=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id 970a23246370098d;
	Sat, 15 Aug 2026 10:32:50 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v4 RESEND 2/5] KVM: riscv: Avoid THP adjustment for existing 4K G-stage leaves
Date: Sat, 15 Aug 2026 06:32:45 -0400
Message-ID: <20260815103245.864925-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815102833.864330-1-jinyu.tang@linux.dev>
References: <20260815102833.864330-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dirty logging is disabled after a G-stage PMD mapping has been
split, the fault path may see a 4K G-stage leaf while the backing host
page is still THP-backed. The existing kvm_riscv_gstage_map_page()
comment says that this path should update the small leaf and leave huge
mapping recovery to a later ioctl path.

However, transparent_hugepage_adjust() runs before that G-stage lookup
and rewrites the fault GPA to the PMD base. If the original fault is not
at the PMD base, the lookup can find and update the wrong 4K leaf.

Check the original fault GPA in transparent_hugepage_adjust(). If it
already has a 4K G-stage leaf, skip THP adjustment and keep handling the
fault at PAGE_SIZE granularity.

Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 arch/riscv/kvm/mmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index bfd6168ebe30..2fabcd409991 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -500,10 +500,21 @@ static int get_hva_mapping_size(struct kvm *kvm,
 
 static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 						 struct kvm_memory_slot *memslot,
+						 struct kvm_gstage *gstage,
 						 unsigned long hva,
 						 kvm_pfn_t *hfnp, gpa_t *gpa)
 {
 	kvm_pfn_t hfn = *hfnp;
+	u32 ptep_level;
+	pte_t *ptep;
+
+	/*
+	 * Keep the existing split G-stage leaf and update the original
+	 * faulting 4K page in the vCPU fault path.
+	 */
+	if (kvm_riscv_gstage_get_leaf(gstage, *gpa, &ptep, &ptep_level) &&
+	    !ptep_level)
+		return PAGE_SIZE;
 
 	/*
 	 * Make sure the adjustment is done only for THP pages. Also make
@@ -730,7 +741,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	 * so do not promote them through the THP helper.
 	 */
 	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
-		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
+		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, &gstage,
+							   hva, &hfn, &gpa);
 
 	if (writable) {
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
-- 
2.43.0

