Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA303C1412
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758474; cv=none; b=OvpNTUEgDGyh2TNhblU+1OH38UBUa4pp1kBd8Vuofm7Ih/vQg3v79CvKrWR+xz8QZ7vtpDN72EWekNKNQRSGrLx07Gu1cMK9+NZfmqRdR3rp1axBzeKJdDmusCJizSIwFWfa3rf5h2TCKvYwKAwTf0LOdhJVTnn6eHE7uB9P73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758474; c=relaxed/simple;
	bh=ofCW++KAESexwh4tkjW5bjlpehw4m5zS4NZeez/ElTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GC2gYAnKm2GvuWQvYMg0jubW697qea5rOA7++Y5uBVQM30cZu5o2UE2bWkk1hDPVWZQ8NbwWZNnSBENgpQkFob/nF5Om6N2gY/0juwCF4qzW3zFA8C7OFHbQc6wyUuiLK9skcZf2zgA3yMxkl8Cgo5oi0YU4KZsGnzC7xLW1nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mys6Q3TD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mys6Q3TD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778758471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5Pyrdd5WFDrMrYLVsOZnMoWs8/udWCnIMpQl5TdOP8=;
	b=Mys6Q3TDaOdKnpxa0qqnGTMbl3xt8WMtoO6wAHtL7XOeW+cIb/0/eEXCub0pFdKUtOkoib
	mgSqgOC4hAvzUT8FWqm2RKrdIKUsIVUjs7mCab+v/CpVzvNq3Dm4tz8dLdMHrMxFNqFDdR
	pqJ7t6uni+Ki9m6TAFpQFg+uBSJM8GQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-pNZg7o4pOBSz__KkhVmMOg-1; Thu,
 14 May 2026 07:34:28 -0400
X-MC-Unique: pNZg7o4pOBSz__KkhVmMOg-1
X-Mimecast-MFC-AGG-ID: pNZg7o4pOBSz__KkhVmMOg_1778758467
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C72119560AA;
	Thu, 14 May 2026 11:34:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89E441800576;
	Thu, 14 May 2026 11:34:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	babu.moger@amd.com
Subject: [PATCH] x86/svm: work around Virtual VMLOAD/VMSAVE bug on Naples and Rome
Date: Thu, 14 May 2026 13:34:24 +0200
Message-ID: <20260514113424.4136527-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
address as seen by L1 falls in [0x78000000, 0x80000000) range.
Reserve this range on affected CPUs so the page allocator would never
alocate the VMCB there.

Given that it's relative old CPUs + nested env + only performance
impact, it's not worth fixing on KVM side (which could involve
messing with allocator or reallocating VMCB, until it's not
in affected range). Hence a quirk here, to prevent tests
failures where we can't do anything about them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
there is not official EOL dates on both, but using a newer
generation(s) release dates it appears that both are effectively
discontinued for ~3-5 yeas
---
 x86/svm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/x86/svm.c b/x86/svm.c
index a85da905..706ff2ef 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -334,6 +334,21 @@ static void setup_npt(void)
 	__setup_mmu_range(pml4e, 0, size, X86_MMU_MAP_USER);
 }
 
+#define VLS_BUG_START	0x78000000ULL
+#define VLS_BUG_END	0x80000000ULL
+
+static bool has_vls_bug(void)
+{
+	u32 sig = cpuid(1).a;
+	u32 fam = x86_family(sig);
+	u32 model = x86_model(sig);
+
+	if (fam != 0x17)
+		return false;
+
+	return model <= 0x0f || (model >= 0x30 && model <= 0x3f);
+}
+
 static void setup_svm(void)
 {
 	void *hsave = alloc_page();
@@ -413,6 +428,13 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
 		return report_summary();
 	}
 
+	if (has_vls_bug()) {
+		phys_addr_t addr;
+
+		for (addr = VLS_BUG_START; addr < VLS_BUG_END; addr += PAGE_SIZE)
+			reserve_pages(addr, 1);
+	}
+
 	setup_svm();
 
 	vmcb = alloc_page();
-- 
2.43.0

