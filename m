Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1133C9890
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844008; cv=none; b=jq1PF71Rd4yKBp5snYXLCkEk0jpgLh1VIxV80Nfx3aYvNMVmUDMXlpFX8/0W0e0NnoxbEc3jXzqinxgcvyXuj6OBcl6aAQ6WE7cfS69lXG3URiPQzg6rUqRXMNvQl0Nir1ngDxDbUgRqmBbqfbLljZZlepm0+ymZB18Uoi77zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844008; c=relaxed/simple;
	bh=mWFmgOj+WTvAomivzSWOcmGc0um5Ybgs4xG5jdFysWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrRVO/LhUr8bxduSBbb4UesA49L7OXhMdpunlpXzK0kEITE1xoZiGlQwKF7elqKgtTkaU3FDr7+CNDVjzfhjVcYuoPqcoh2xJl9WPpjWWNAzMxjhfHaSfQhqNrlLFLNeaJoIal0JVBk9Jrf3Zwif31x06vI6G2SLgwjARNfNudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2iHGxPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2iHGxPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778844005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGBW2qGY8OvLymEj9PTlVbiPGixeajByZaJUxaixodE=;
	b=H2iHGxPVorv2EoTN7bjNMznl/iU7SyQpfi4eipQ481Rwe/xSb7QPO5KceXyWfuqGm58DRA
	c+LInSBuBSxCY1VQsz2Ck4EMSnDfufiy4C4TPrK7gkICKpPMnpem2VZjyUKy6LnByltfQT
	MFXn3o3+ZzaPaFuerybVVmDVFbkUu+Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-ruZHd-lDMQy-6ZpUlYpb1Q-1; Fri,
 15 May 2026 07:20:02 -0400
X-MC-Unique: ruZHd-lDMQy-6ZpUlYpb1Q-1
X-Mimecast-MFC-AGG-ID: ruZHd-lDMQy-6ZpUlYpb1Q_1778844001
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94481180034E;
	Fri, 15 May 2026 11:20:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43E8D1803A8E;
	Fri, 15 May 2026 11:19:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	babu.moger@amd.com,
	seanjc@google.com
Subject: [kvm-unit-tests PATCH] x86/svm: work around Virtual VMLOAD/VMSAVE bug on Naples and Rome
Date: Fri, 15 May 2026 13:19:57 +0200
Message-ID: <20260515111957.4188366-1-imammedo@redhat.com>
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
in affected range). And since test acts here as L1 it's not possible to fix
issue in kernel (L0) anyway. Hence a quirk here, to prevent tests
failures where we can't do anything about them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CCed: AMD folks for awaraness and in case they would be willing
to look into fixing issue on CPU side.

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

