Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3883DEADC
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177521; cv=none; b=IFZDpQM1QDweL6HXAwj3f4rj1cTVmCiHLtwFL5Ciea9HEGAb3zl9s0lc0Kq0SCg6adgNl4V2tWo+GEGGl3nTnZXq3vQ4pT9BQ5JP0zsVqRqKSVsmGXyLj/kpEYDyL1EaPmASIRiS3e2p45e+4kiMCfdOuMW780qBL733gzk6I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177521; c=relaxed/simple;
	bh=LY8f3exewuVVgW7srhsqrF9FNBytGdppVjn1vhLwqjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNEywjH0nht7Ed2kwX97DcJ8BjR5iXi/VdhpJFqCaqvlc/9Q/cg2N38Nn8oeMMTUgHH2s1cgwJP9/7MZjVl+JjcT8lmuniT862SHmUtkh4uuTbNQyqYH3vFQuDpk//qa/XwWJcGNA7JRaHzoTyjDU0o1Ile1lW4WvO96Jzj0hXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkK6Aybr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkK6Aybr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779177518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vA5AptWgFLuAf0f3uD0OIL4+IifC0E/7wRKlJanNrms=;
	b=PkK6AybrlEhzZPQdMXXFQ22ggV6YMmBmCKSgAZ5IOS2hUIU7hzV5kjcqDRPiiTO6tYcxLk
	GKXT3SkL5A3Y7x6FgO7IoF/AvStvW081ePepGRK1IyyWilcz/xAQSstyvoF88/k0CbinOD
	CHBmpy/SLLMx+XcpA4i2WF1WpKKa4PY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-WaiGw_p_Pb6ZBwO8LxMzLQ-1; Tue,
 19 May 2026 03:58:36 -0400
X-MC-Unique: WaiGw_p_Pb6ZBwO8LxMzLQ-1
X-Mimecast-MFC-AGG-ID: WaiGw_p_Pb6ZBwO8LxMzLQ_1779177515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAEA719560A1;
	Tue, 19 May 2026 07:58:34 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 163F819560A2;
	Tue, 19 May 2026 07:58:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	babu.moger@amd.com,
	seanjc@google.com,
	thomas.lendacky@amd.com,
	michael.roth@amd.com,
	naveen@kernel.org
Subject: [kvm-unit-tests v2] x86/svm: work around Virtual VMLOAD/VMSAVE bug on Naples and Rome
Date: Tue, 19 May 2026 09:58:30 +0200
Message-ID: <20260519075830.68943-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
address as seen by L1 falls in [0x78000000, 0x80000000) range.
Reserve this range on affected CPUs so the page allocator would never
allocate the VMCB there.

Given that it's relatively old CPUs + nested env + only performance
impact, it's not worth fixing on KVM side (which could involve
messing with allocator or reallocating VMCB, until it's not
in affected range). Hence a quirk here, to prevent tests
failures where we can't do anything about them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
there is not official EOL dates on both, but using a newer
generation(s) release dates it appears that both are effectively
discontinued for ~3-5 years

v2:
  * Sean Christopherson <seanjc@google.com>
      - s/has_vls_bug/has_vls_spurious_vmexit_bug/
---
 x86/svm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/x86/svm.c b/x86/svm.c
index a85da905..3f2c7390 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -334,6 +334,25 @@ static void setup_npt(void)
 	__setup_mmu_range(pml4e, 0, size, X86_MMU_MAP_USER);
 }
 
+#define VLS_SPURIOUS_VMEXIT_START	0x78000000ULL
+#define VLS_SPURIOUS_VMEXIT_END	0x80000000ULL
+
+/*
+ * Naples (Fam17h/00-0f) and Rome (Fam17h/30-3f) cause spurious VMEXITs
+ * on VMLOAD/VMSAVE when the VMCB address falls in [0x78000000, 0x80000000).
+ */
+static bool has_vls_spurious_vmexit_bug(void)
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
@@ -413,6 +432,13 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
 		return report_summary();
 	}
 
+	if (has_vls_spurious_vmexit_bug()) {
+		phys_addr_t addr;
+
+		for (addr = VLS_SPURIOUS_VMEXIT_START; addr < VLS_SPURIOUS_VMEXIT_END; addr += PAGE_SIZE)
+			reserve_pages(addr, 1);
+	}
+
 	setup_svm();
 
 	vmcb = alloc_page();
-- 
2.43.0

