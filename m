Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED973FE649
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536648; cv=none; b=fJg95KdPlPjTZXBdCeuWUa8rPCYUNZ/LRurSf/zHHyVl8VXnHAAx1zanS1PPP2itV6KNkls/JMJcuuOSo2lK660jSLDhtTjsVWTOZGUMCjBxtiYzg5t7wARuCoD947wfpV5NZ6lQgFHbMcWpxRAvxyj+eBHOqSxtBPnAdG5kMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536648; c=relaxed/simple;
	bh=Vm3cFhbmwSZ1ZwEL541IRqgj5+YsZiUFjHbInts862s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luI2XgtDrg00yk08lz9OgoZtAmL3BvIhrdM/A5VMuQQgb1KPDjQEgT/pOQcpvedV03ZrIpHaqfBnHm/6UQ8ylp8LD2QL5GC30kf+ybzyrjSZfCMo3WN2VvQcxxhl1jjTI3JdEuBRo3yWqrUa6M/KQKTeV5MJfQbbm54JOFIsjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1g32O92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1g32O92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqTa+oYxu3SofEi48B11IDGz5IMCGvHdoDESO6x686w=;
	b=h1g32O9292ZNU1VXDfALL4fETdOVelB313JXuOj50PpKfOJY/m9rVP2RW+OM/NobebB7PH
	cClkDYcGSYc+MZOkKQa3lPIC/qkyroSI+26AFuNFMPDKWq3zVKXhW9MCXE/POHghWVe+wZ
	xwUB2cM2fg9PimRWJOKPgFQYXgMYv+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-VnAsFEs_MbCpjhiL3omuoQ-1; Thu,
 26 Mar 2026 10:50:42 -0400
X-MC-Unique: VnAsFEs_MbCpjhiL3omuoQ-1
X-Mimecast-MFC-AGG-ID: VnAsFEs_MbCpjhiL3omuoQ_1774536641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E29BA1944F05;
	Thu, 26 Mar 2026 14:50:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C771180036E;
	Thu, 26 Mar 2026 14:50:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 4/9] x86/vmx: update EPT installation to use EPT_PRESENT flag
Date: Thu, 26 Mar 2026 10:50:30 -0400
Message-ID: <20260326145035.119519-5-pbonzini@redhat.com>
In-Reply-To: <20260326145035.119519-1-pbonzini@redhat.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jon Kohler <jon@nutanix.com>

Prepare for MBEC EPT access test cases by refactoring the EPT
installation logic in vmx_tests.c and vmx.c to replace the use of
EPT_RA | EPT_WA | EPT_EA flags with the EPT_PRESENT flag; this
will allow adding the XU bit to all upper-level page tables
easily when MBEC is active.

Note that EPT_PRESENT is not used testing the RWX combination
specifically.

No functional change intended.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/vmx.c       |  3 +--
 x86/vmx.h       | 13 +++++++------
 x86/vmx_tests.c | 24 ++++++++++++------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index c803eaa6..eb2965d8 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -875,8 +875,7 @@ void install_ept_entry(unsigned long *pml4,
 			else
 				pt_page = 0;
 			memset(new_pt, 0, PAGE_SIZE);
-			pt[offset] = virt_to_phys(new_pt)
-					| EPT_RA | EPT_WA | EPT_EA;
+			pt[offset] = virt_to_phys(new_pt) | EPT_PRESENT;
 		} else if (pt[offset] & EPT_LARGE_PAGE)
 			split_large_ept_entry(&pt[offset], level);
 		pt = phys_to_virt(pt[offset] & EPT_ADDR_MASK);
diff --git a/x86/vmx.h b/x86/vmx.h
index 33373bd1..d9f493d3 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -664,18 +664,19 @@ enum vm_entry_failure_code {
 #define EPT_MEM_TYPE_WP		5ul
 #define EPT_MEM_TYPE_WB		6ul
 
-#define EPT_RA			1ul
-#define EPT_WA			2ul
-#define EPT_EA			4ul
-#define EPT_PRESENT		(EPT_RA | EPT_WA | EPT_EA)
+#define EPT_RA			(1ul << 0)
+#define EPT_WA			(1ul << 1)
+#define EPT_EA			(1ul << 2)
+#define EPT_IGNORE_PAT		(1ul << 6)
+#define EPT_LARGE_PAGE		(1ul << 7)
 #define EPT_ACCESS_FLAG		(1ul << 8)
 #define EPT_DIRTY_FLAG		(1ul << 9)
-#define EPT_LARGE_PAGE		(1ul << 7)
 #define EPT_MEM_TYPE_SHIFT	3ul
 #define EPT_MEM_TYPE_MASK	0x7ul
-#define EPT_IGNORE_PAT		(1ul << 6)
 #define EPT_SUPPRESS_VE		(1ull << 63)
 
+#define EPT_PRESENT		(EPT_RA | EPT_WA | EPT_EA)
+
 #define EPT_CAP_EXEC_ONLY	(1ull << 0)
 #define EPT_CAP_PWL4		(1ull << 6)
 #define EPT_CAP_PWL5		(1ull << 7)
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 5ffb80a3..707e8ca4 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -1100,7 +1100,7 @@ static int setup_ept(bool enable_ad)
 	 */
 	setup_ept_range(pml4, 0, end_of_memory, 0,
 			!enable_ad && ept_2m_supported(),
-			EPT_WA | EPT_RA | EPT_EA);
+			EPT_PRESENT);
 	return 0;
 }
 
@@ -1179,7 +1179,7 @@ static int ept_init_common(bool have_ad)
 	*((u32 *)data_page1) = MAGIC_VAL_1;
 	*((u32 *)data_page2) = MAGIC_VAL_2;
 	install_ept(pml4, (unsigned long)data_page1, (unsigned long)data_page2,
-			EPT_RA | EPT_WA | EPT_EA);
+		    EPT_PRESENT);
 
 	apic_version = apic_read(APIC_LVR);
 
@@ -1359,8 +1359,8 @@ static int ept_exit_handler_common(union exit_reason exit_reason, bool have_ad)
 					*((u32 *)data_page2) == MAGIC_VAL_2) {
 				vmx_inc_test_stage();
 				install_ept(pml4, (unsigned long)data_page2,
-						(unsigned long)data_page2,
-						EPT_RA | EPT_WA | EPT_EA);
+					    (unsigned long)data_page2,
+					    EPT_PRESENT);
 			} else
 				report_fail("EPT basic framework - write");
 			break;
@@ -1371,9 +1371,9 @@ static int ept_exit_handler_common(union exit_reason exit_reason, bool have_ad)
 			break;
 		case 2:
 			install_ept(pml4, (unsigned long)data_page1,
- 				(unsigned long)data_page1,
- 				EPT_RA | EPT_WA | EPT_EA |
- 				(2 << EPT_MEM_TYPE_SHIFT));
+				    (unsigned long)data_page1,
+				    EPT_PRESENT |
+				    (2 << EPT_MEM_TYPE_SHIFT));
 			invept(INVEPT_SINGLE, eptp);
 			break;
 		case 3:
@@ -1417,8 +1417,8 @@ static int ept_exit_handler_common(union exit_reason exit_reason, bool have_ad)
 		case 2:
 			vmx_inc_test_stage();
 			install_ept(pml4, (unsigned long)data_page1,
- 				(unsigned long)data_page1,
- 				EPT_RA | EPT_WA | EPT_EA);
+				    (unsigned long)data_page1,
+				    EPT_PRESENT);
 			invept(INVEPT_SINGLE, eptp);
 			break;
 		// Should not reach here
@@ -3020,9 +3020,9 @@ static void ept_access_test_paddr_read_write_execute(void)
 {
 	ept_access_test_setup();
 	/* RWX access to paging structure. */
-	ept_access_allowed_paddr(EPT_PRESENT, 0, OP_READ);
-	ept_access_allowed_paddr(EPT_PRESENT, 0, OP_WRITE);
-	ept_access_allowed_paddr(EPT_PRESENT, 0, OP_EXEC);
+	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_READ);
+	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_WRITE);
+	ept_access_allowed_paddr(EPT_RA | EPT_WA | EPT_EA, 0, OP_EXEC);
 }
 
 static void ept_access_test_paddr_read_execute_ad_disabled(void)
-- 
2.52.0


