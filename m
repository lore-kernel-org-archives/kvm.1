Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DB3A0E86
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358664; cv=none; b=ewCZqMAE+jZJuSLotq/jgVaAzn/zcCeg9hLyUaHcyktbYtMGwYQ1MFgg5qZ9Y+K8hPjDoNRL3zQKsxVH35DNkRo1WcykJDCUonuW+ANzZkcMp3okPb9so5eISQvPDoYQQYxYmMgJvCsIZyZo2XEcE6mpoZ4Q/KF14Uig1dKFtU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358664; c=relaxed/simple;
	bh=Jk4yTyo0+7sk3iwJNwk5iWQX2SLr0+A9Q0DQbBW3An0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8qGo1qWkB6HZFbjtfUfQJzFd7KhUIsrs9dBpDVagUauEI5mI88qU7k+0JkAjCvTiyWUlEj3hROUT5NQx+tfsIkFZAnmSRyR7dxO8wg7Yn6f2Jh2J+PCuQFmxl7qNGaO4li4j5mLN3GhPQqrYjaRLOEfvMCD+MzgAoFKbIHvKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwU2I3Xf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6o8P4aQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwU2I3Xf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6o8P4aQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxV+QXovuyHrJYMgZsrZqaFHBi5vZRdtye1FORL2GBo=;
	b=QwU2I3XfOY4pquK5gSFRw/STXDWtN9CGsNQUGaDwtoWR7n3s8aA5YQIuJedFW6WQxxnZLj
	Z9zekl021vBougJH/MUkUPXOJiT+0rRiWKByTbFnLLxZ5svY+7oaQ2LtdwEfUvieDsmCXK
	bFadI83qSBPv5TNniSdppZ2I2AFl3aU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-3qlM7UDQOe-53qLfcpaA5w-1; Thu, 21 May 2026 06:17:35 -0400
X-MC-Unique: 3qlM7UDQOe-53qLfcpaA5w-1
X-Mimecast-MFC-AGG-ID: 3qlM7UDQOe-53qLfcpaA5w_1779358655
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdbe7ad665aso80711466b.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358654; x=1779963454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxV+QXovuyHrJYMgZsrZqaFHBi5vZRdtye1FORL2GBo=;
        b=R6o8P4aQ/1k3hDCEtoShpTLOmQmpHzO84HCH8IrJegsU5rOjGps5WJ0lLFuC9y2EnG
         KQus0Uvnc+aetf9rQq6SB7bwm4UgbFbNILhNQHykhRpiDgIGAXhVYVuRi6f0Fs8AZp9D
         mUJA2FOD115oenP6f6XmPYUndg3pVIR2qHNSD0NMVt5ISYs4YbnzL81beqtacIHLkOiz
         MiPwOgEuUBzl6JX6Yc5OvBvn0iFkPnFuH43VYk2+/0qnPTNXp3KYw61JMnf3DKQTAwFG
         yz+ToXGevIzgN02CdYK1/T0HCNZTZ6vhPLcVABtMgqcxpAH17Ht6x4JFRLgM1+YipBpf
         JYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358654; x=1779963454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxV+QXovuyHrJYMgZsrZqaFHBi5vZRdtye1FORL2GBo=;
        b=i7RQeHMIGYriUwvRMUqrIUyQxrEpwfto8LeG2OztzPlqtjj7IMDCBFTounIxm2AFAJ
         hj0v/KQDC1m5uo7kCoZzlYhqGksTXUH/RvLbYYVhhBErwwTAeQq/qawhgjQxl1rfvooC
         pCDF57l5QSg4yTfe9JXKN7wL3MeABVZgA2EqWsSvW5B7L9rOdwUl69GoNiQZXjomIcOR
         nGP2C4xJxgEZbgmeXhb3FWDTzDb4odLNi5nxF9LYntm6FGCtIy8hCfZc568bwMD1ZUJb
         cuOaMijgCD6FtKzoc6VCYAQ8wJcPDnevtfJ9oGO2cfOhMm3hPKr3mJLc5G8uBohFqhP2
         rKKA==
X-Gm-Message-State: AOJu0Yy2rdmlG88mkPC/nHOic4lKYheLi+Xq/lN4D32LwqiEa1F8Recg
	oGNn6MJadtK7DNC0/cDlvIRsP85rCxgfZS8c7MiBf9EQidWrNX8rxKKNACGGg1vJfqUtH8xWaxk
	rVcM3S9cxjCDzc2kpv9KtNaT6e8w04JJFnWnJVfsU3KYUpQ/Vd7Hw9qt7fNiASEuBE5izh+1TxG
	XoDgvMu3hkbzivBJLkurn4RcHn+UnrapWED1otKT7D
X-Gm-Gg: Acq92OGqETQzcT9ofaVyHD7jAlBuFUteHvVIe/rxaLtHPfm+oX69dgwEHaubO6YT2RD
	zwnDmSKtuSSbIg0SFLtzWcichzCekJ2lf/lFwB9pKTd4GJIk+lT/eO2c39bsqnF12xMx3qgImF6
	4xdFEdLpwSoI0Putx2F/nQcJC6qhhHhnt+2nXSSGqd2tmihzkm4swk0jLuuCatmMTRndiyg2yQy
	FIjdwaugbagBPKRdblgihF43XDb/RPkrwzFirBbTJyifog4vKcOvJMnCfSYrzbzUgQMFMG7r9wz
	/GQhTvKo6vGlsS43Q47YF31sXdO7ci4ViLLD2Acv0jNKoCUFswoRwROqCvcMPzKt9KegX2birLt
	KdHEMyYXEcWZMtAcBHx0ok2cPNMB5gQPANXu9lp3cR7+6d9ApWQVQxtzFzXg3JzjJMRx3EPNr0U
	abQr86eZb9tt1tRgOwLm5K25T1ng==
X-Received: by 2002:a17:906:846e:b0:bd1:4da0:b0d3 with SMTP id a640c23a62f3a-bdc1456fdc8mr92728766b.9.1779358654541;
        Thu, 21 May 2026 03:17:34 -0700 (PDT)
X-Received: by 2002:a17:906:846e:b0:bd1:4da0:b0d3 with SMTP id a640c23a62f3a-bdc1456fdc8mr92727266b.9.1779358654113;
        Thu, 21 May 2026 03:17:34 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a40e102sm26904366b.40.2026.05.21.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 4/4] svm: add test for 32-bit PAE guest
Date: Thu, 21 May 2026 12:17:23 +0200
Message-ID: <20260521101723.101100-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521101723.101100-1-pbonzini@redhat.com>
References: <20260521101723.101100-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 0afeff48..d721f201 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -803,7 +803,24 @@ static u64 svm_32bit_build_page_tables(void)
 	return virt_to_phys(pd);
 }
 
-static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3)
+static u64 svm_32bit_build_pae_page_tables(void)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_PAGE_SIZE_MASK;
+	u64 *pdpt = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+	int i, j;
+
+	for (i = 0; i < 4; i++) {
+		u64 *pd = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE,
+					       AREA_DMA32);
+		for (j = 0; j < 512; j++)
+			pd[j] = (((u64)i << 30) | ((u64)j << 21)) |
+				leaf_flags;
+		pdpt[i] = virt_to_phys(pd) | PT_PRESENT_MASK;
+	}
+	return virt_to_phys(pdpt);
+}
+
+static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3, bool pae)
 {
 	struct guest_regs *regs = this_cpu_guest_regs();
 	struct vmcb_save_area *save = &vmcb->save;
@@ -820,8 +837,8 @@ static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3)
 
 	save->efer &= ~(EFER_LMA | EFER_LME);
 	save->cr0 |= X86_CR0_PG | X86_CR0_PE;
-	save->cr4 &= ~X86_CR4_PAE;
-	save->cr4 |= X86_CR4_PSE;
+	save->cr4 &= ~(X86_CR4_PAE | X86_CR4_PSE);
+	save->cr4 |= pae ? X86_CR4_PAE : X86_CR4_PSE;
 	save->cr3 = cr3;
 	regs->rax = 0x123457678;
 }
@@ -830,7 +847,14 @@ static void svm_32bit_guest_prepare(struct svm_test *test)
 {
 	u64 cr3 = svm_32bit_build_page_tables();
 
-	svm_32bit_guest_prepare_common(test, cr3);
+	svm_32bit_guest_prepare_common(test, cr3, false);
+}
+
+static void svm_32bit_guest_prepare_pae(struct svm_test *test)
+{
+	u64 cr3 = svm_32bit_build_pae_page_tables();
+
+	svm_32bit_guest_prepare_common(test, cr3, true);
 }
 
 static void svm_32bit_guest_prepare_gif_clear(struct svm_test *test)
@@ -877,8 +901,20 @@ static bool svm_32bit_guest_finished(struct svm_test *test)
 static void svm_32bit_free_page_tables(void)
 {
 	u64 cr3 = vmcb->save.cr3;
+	u64 cr4 = vmcb->save.cr4;
 
-	free_page(phys_to_virt(cr3));
+	if (cr4 & X86_CR4_PAE) {
+		u64 *pdpt = phys_to_virt(cr3);
+		int i;
+
+		for (i = 0; i < 4; i++) {
+			if (pdpt[i] & PT_PRESENT_MASK)
+				free_page(phys_to_virt(pdpt[i] & PT_ADDR_MASK));
+		}
+		free_page(pdpt);
+	} else {
+		free_page(phys_to_virt(cr3));
+	}
 }
 
 static bool svm_32bit_guest_check(struct svm_test *test)
@@ -3813,6 +3849,9 @@ struct svm_test svm_tests[] = {
 	{ "32bit_guest", default_supported, svm_32bit_guest_prepare,
 	  svm_32bit_guest_prepare_gif_clear, svm_32bit_guest_test, svm_32bit_guest_finished,
 	  svm_32bit_guest_check },
+	{ "32bit_pae_guest", default_supported, svm_32bit_guest_prepare_pae,
+	  svm_32bit_guest_prepare_gif_clear, svm_32bit_guest_test, svm_32bit_guest_finished,
+	  svm_32bit_guest_check },
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.54.0

