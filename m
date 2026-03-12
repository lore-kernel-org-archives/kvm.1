Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C8401A2E
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345796; cv=none; b=olRZqh9novUTT0Gz3YgujUnu5tSQleZ/lOGtEAwbPrn+5XWSiQgxIXWHyVIBTNIsd/8E7TSEXyM6cMSOvHNGzXcXF1uWSa7YxBXFCrcd0+z/LDAZKfmQQ+lVVI1klVbx8QqRb2m19+I3F8MigCKVIi2kHoCwWGnNAm/ZSWERj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345796; c=relaxed/simple;
	bh=FQ8iNVazckbUMkcl4/LJQBvVBcpKgWPuCZVOJ2XWPzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRr684wb3H+CzG43w7G8OykhhFYtP7+kbQ+3mhL8l+7cl8ji1Gs+ioFrxPJcNMMIWCY75mgxMfN/vf130aMqJ5lmi50+QkuHjMbpYOqVXNHcORRe6qOws08XOVprg2fNKzbJBIw2bZiPcCRFEvSWEUCw8vwRGUDjczfFtBRR1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5bG9mAH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5bG9mAH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0998a441so8273362a91.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345794; x=1773950594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2m/hU+Jt8OkIyilzhr8C/19mPs2+B6ibUdC+cQ1kWRY=;
        b=b5bG9mAHxwukiN6dnas0XLC59zb0F0rpEgCvniwQF73EDOHoOmgea+VYCH0fWKLeXt
         pU+C++mwNlSMLbkUAEprUwkz2fZxSdpM3Lxa7XwQBwvzIoaLFzq4dMxPCZNiCRELIPTd
         PFljVklbtfB0szN7zlU3pvD+fcsIqxZA+lMqTVS8t5qSiuX/UZipkzUhS+7UMREbTSdP
         azhTQbOKBxHLENkk5LkoMqy1wJhrvx+RhBWCHGZCPhW2KgTG7VMBZXJz9HWrBtYF6wHu
         U+jlIpvyqY8GomTw6CEU83itE20yvSuwcjuWcyhbNbojiN5ADWjbBEaMSlD4j8B3dKO4
         SvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773345794; x=1773950594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2m/hU+Jt8OkIyilzhr8C/19mPs2+B6ibUdC+cQ1kWRY=;
        b=gFtiAT3trw4e1E47DcqLF7bKyVv8HilqakOXPLk9S6jnqq0tNqdWYSVbqJIeCd4PHb
         0rIut+DoRkFmgmsUaGUGUT5f/Nuk/ZewiSrpXtHOwX6KEat/rc6bfLwhgMpveSwyJXQu
         pq5+DUYNYTRvomR+K9MtacMPGA1m7WQaXfJKe1od6gctZX/mSsp8MaoHuO63B7OkAf3S
         SeBRYW2Sf+/5Y/fxhjmteSqruHqlGsoBrHvuHmiH3ivSd24pd7PMOED76HvcwgxaT0jw
         3FzKNb82M3vTf2tDK0ZBU92hc5Aq0/aGbqh4nusnUeouscW/Fjsc212MLGBvVboQnpC+
         iMZA==
X-Gm-Message-State: AOJu0YzAF1PCOvMKBWXUzVBeNalIwhXU+qXV53jMyh4kwottj+dzbAf9
	P8aWbBB20mvXVLEoB1mzpqTTth33nLXNHvlnoI9YZPZzgeNeEyNcajnv9hilMGPqLSP92cN+Tux
	IUohU65YkR64kDm58LuL4V0zbZAPR2IxKcCLFxrkITxXdpVb9Zy2//xi5IR97RnXq+Y7ckVJmEZ
	5WswiCIfLky7SJsUZWIg5EWyDVILbuOhfe+7LJYFFvjL8=
X-Received: from pgli38.prod.google.com ([2002:a63:1326:0:b0:c73:cc95:c0ed])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:278d:b0:359:f3ec:c773 with SMTP id 98e67ed59e1d1-35a21e4ee48mr839662a91.3.1773345794356;
 Thu, 12 Mar 2026 13:03:14 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:00 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-3-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 02/10] x86/nSVM: Add test for NPT A/D bits
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Nested page table entries that were touched during nested page table
walks for guest PTEs always have their dirty and accessed bits set.
Write a test that verifies this behavior for guest read and writes. Note
that non-leaf NPT levels encountered during the GPA to HPA translation
for guest PTEs only have their accessed bits set.

The nVMX tests already have coverage for TDP A/D bits. Add a
similar test for nSVM to improve test parity between nSVM and nVMX.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_npt.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/x86/svm_npt.c b/x86/svm_npt.c
index bd5e8f351e34..7b8f57a8c3f0 100644
--- a/x86/svm_npt.c
+++ b/x86/svm_npt.c
@@ -380,6 +380,183 @@ skip_pte_test:
 	vmcb->save.cr4 = sg_cr4;
 }
 
+
+static void clear_npt_ad_pte(unsigned long *pml4e, void *gpa)
+{
+	unsigned long *pte;
+	int l;
+
+	for (l = PAGE_LEVEL; l > 0; --l) {
+		pte = get_pte_level(pml4e, gpa, l);
+		*pte &= ~(PT_AD_MASK);
+		if (*pte & PT_PAGE_SIZE_MASK)
+			break;
+	}
+}
+
+/*
+ * clear_npt_ad : Clear NPT A/D bits for the page table walk and the final
+ * GPA of a guest address.
+ */
+static void clear_npt_ad(u64 *pml4e, unsigned long *guest_cr3,
+			 void *gva)
+{
+	unsigned long *pte = guest_cr3, gpa;
+	u64 offset_in_page;
+	int l;
+
+	for (l = PAGE_LEVEL; l > 0; --l) {
+		pte = get_pte_level(guest_cr3, gva, l);
+
+		clear_npt_ad_pte(pml4e, (void *)pte);
+
+		assert(*pte & PT_PRESENT_MASK);
+		if (*pte & PT_PAGE_SIZE_MASK)
+			break;
+	}
+
+	pte = get_pte_level(guest_cr3, gva, l);
+	offset_in_page = (u64)gva &  ((1 << PGDIR_BITS(l)) - 1);
+	gpa = (*pte & PT_ADDR_MASK) | ((u64)gva & offset_in_page);
+	clear_npt_ad_pte(pml4e, (void *)gpa);
+}
+
+/*
+ * found_bad_npt_ad : Check the NPT A/D bits at each level for GPA being
+ * translated. Note that non-leaf NPT levels encountered during translation
+ * only have the access bit set.
+ *
+ * Returns true if incorrect NPT A/D bits are found. Returns false otherwise.
+ */
+static bool found_bad_npt_ad(u64 *pml4e, void *gpa, int guest_level,
+			     int expected_ad)
+{
+	int l, expected_ad_level;
+	unsigned long *pte;
+	bool leaf;
+
+	for (l = PAGE_LEVEL; l > 0; --l) {
+		pte = get_pte_level(pml4e, gpa, l);
+		leaf = (l == 1) || (*pte & PT_PAGE_SIZE_MASK);
+		expected_ad_level = expected_ad;
+
+		/* The dirty bit is only set on leaf PTEs */
+		if (!leaf)
+			expected_ad_level = expected_ad & ~PT_DIRTY_MASK;
+
+		if ((*pte & PT_AD_MASK) != expected_ad_level) {
+			report_fail("NPT - guest level %d npt level %d page table received: A=%d/D=%d, expected A=%d/D=%d",
+				    guest_level,
+				    l,
+				    !!(*pte & PT_ACCESSED_MASK),
+				    !!(*pte & PT_DIRTY_MASK),
+				    !!(expected_ad & PT_ACCESSED_MASK),
+				    !!(expected_ad & PT_DIRTY_MASK));
+			return true;
+		}
+
+		if (leaf)
+			break;
+	}
+
+	return false;
+}
+
+/*
+ * check_npt_ad : Check the content of NPT A/D bits for the page table walk
+ * and the final GPA of a guest address.
+ */
+static void check_npt_ad(u64 *pml4e, unsigned long *guest_cr3,
+			 void *gva, int expected_gpa_ad)
+{
+	unsigned long *pte = guest_cr3, gpa;
+	u64 *npt_pte, offset_in_page;
+	bool bad_pt_ad = false;
+	int l;
+
+	for (l = PAGE_LEVEL; l > 0; --l) {
+		pte = get_pte_level(guest_cr3, gva, l);
+		npt_pte = npt_get_pte((u64) pte);
+
+		if (!npt_pte) {
+			report_fail("NPT - guest level %d page table is not mapped.\n", l);
+			return;
+		}
+
+		if (!bad_pt_ad)
+			bad_pt_ad |= found_bad_npt_ad(pml4e, (void *)pte, l, PT_AD_MASK);
+
+		assert(*pte & PT_PRESENT_MASK);
+		if (*pte & PT_PAGE_SIZE_MASK)
+			break;
+	}
+
+	pte = get_pte_level(guest_cr3, gva, l);
+	offset_in_page = (u64)gva &  ((1 << PGDIR_BITS(l)) - 1);
+	gpa = (*pte & PT_ADDR_MASK) | ((u64)gva & offset_in_page);
+
+	npt_pte = npt_get_pte(gpa);
+
+	if (!npt_pte) {
+		report_fail("NPT - guest physical address is not mapped");
+		return;
+	}
+
+	found_bad_npt_ad(pml4e, (void *)gpa, l, expected_gpa_ad);
+	report((*npt_pte & PT_AD_MASK) == expected_gpa_ad,
+	       "NPT - guest physical address received: A=%d/D=%d, expected A=%d/D=%d",
+	       !!(*npt_pte & PT_ACCESSED_MASK),
+	       !!(*npt_pte & PT_DIRTY_MASK),
+	       !!(expected_gpa_ad & PT_ACCESSED_MASK),
+	       !!(expected_gpa_ad & PT_DIRTY_MASK));
+}
+
+static void npt_ad_read_guest(struct svm_test *test)
+{
+	(void)*(volatile u64 *)scratch_page;
+}
+
+static void npt_ad_write_guest(struct svm_test *test)
+{
+	*((u64 *)scratch_page) = 42;
+}
+
+static void npt_ad_test(void)
+{
+	unsigned long *guest_cr3 = (unsigned long *) vmcb->save.cr3;
+
+	if (!npt_supported()) {
+		report_skip("NPT not supported");
+		return;
+	}
+
+	scratch_page = alloc_page();
+
+	clear_npt_ad(npt_get_pml4e(), guest_cr3, scratch_page);
+
+	test_set_guest(npt_ad_read_guest);
+	svm_vmrun();
+
+	/*
+	 * NPT walks for guest page tables are write accesses by default unless
+	 * read-only guest page tables are used. As a result, we expect the
+	 * dirty bit to be set on NPT mappings of guest page tables. Since the
+	 * access itself is a read, we expect the final translation to not have
+	 * the dirty bit set.
+	 */
+	check_npt_ad(npt_get_pml4e(), guest_cr3, scratch_page, PT_ACCESSED_MASK);
+
+	test_set_guest(npt_ad_write_guest);
+	svm_vmrun();
+
+	check_npt_ad(npt_get_pml4e(), guest_cr3, scratch_page, PT_AD_MASK);
+
+	report(*((u64 *)scratch_page) == 42, "Expected: 42, received: %ld",
+	       *((u64 *)scratch_page));
+
+	clear_npt_ad(npt_get_pml4e(), guest_cr3, scratch_page);
+}
+
 #define NPT_V1_TEST(name, prepare, guest_code, check)				\
 	{ #name, npt_supported, prepare, default_prepare_gif_clear, guest_code,	\
 	  default_finished, check }
@@ -395,6 +572,7 @@ static struct svm_test npt_tests[] = {
 	NPT_V1_TEST(npt_l1mmio, npt_l1mmio_prepare, npt_l1mmio_test, npt_l1mmio_check),
 	NPT_V1_TEST(npt_rw_l1mmio, npt_rw_l1mmio_prepare, npt_rw_l1mmio_test, npt_rw_l1mmio_check),
 	NPT_V2_TEST(svm_npt_rsvd_bits_test),
+	NPT_V2_TEST(npt_ad_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
 
-- 
2.53.0.851.ga537e3e6e9-goog

