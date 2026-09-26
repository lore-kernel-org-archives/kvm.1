Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8F368D42
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400794; cv=none; b=GsP2fTkIbstvdfVMD7mK8vDokYD87gaH1N3GqODp1IWRso0o7EhdeUPFSz7/WAeJT1ilahdO7yM/xMzCVd5o05P0vT7Dlyqq4d3wFw/NjPrxaKq51tzc7yvubitQMg/ysewptqNrnzIrD+TWZ4/wtdG0yXCdnc6LqubjE3+nXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400794; c=relaxed/simple;
	bh=3/ozAaydHMCKW9eHO9//vUSilqIEBUlDhxDm5zA5+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHh4TDMM+e0G4SJuwm4Wq/6N8NToySkqEcnkns+5lQa4GhV5iTDKIHHYHGkyxMR5s8ghsMgem5pLpdUxqNTWy4ywhguyhG6CrnoptRbQDJe49XdadRigLeqMir5pBfzJLElDIAKh5jiWQz73cPnc7FDrutTnQKq46lq+3Ia7ZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XA4frqqi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA4frqqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/3V0AHKAig/EiNknHo/uGAnQ3n9JR2PxJBXi2ojg48=;
	b=XA4frqqiO/ymQxJO2Zk2oOf+3MUmeshmt0lkO0aQJ/KK8hDuQtzkSMXRfU5+Ob6M9xk8EK
	s6+Geg36dTri3zz1DoHCbtwaDDTfBlHfYqSWqAiB9NLKrc4N4DXgxRHKkGk7w6rZrIxXBq
	Pj72q5DqZD9vc9y+jGBr1LuA/J/7dfo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-giH3pXbLMceKFivwpklpmg-1; Sat,
 26 Sep 2026 01:33:02 -0400
X-MC-Unique: giH3pXbLMceKFivwpklpmg-1
X-Mimecast-MFC-AGG-ID: giH3pXbLMceKFivwpklpmg_1790400781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C4F818001E1;
	Sat, 26 Sep 2026 05:33:01 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08D5B1956086;
	Sat, 26 Sep 2026 05:33:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 09/11] KVM: selftests: Verify that L0's TPR doesn't get clobbered
Date: Sat, 26 Sep 2026 01:32:51 -0400
Message-ID: <20260926053253.195597-10-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260813223610.2043560-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/x86/nested_x2apic_test.c       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index a1072bf499ee..3b59ba3e3342 100644
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -28,6 +28,10 @@ static void l2_guest_code(void)
 {
 	if (inhibit_apicv)
 		wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0));
+
+	x2apic_write_reg(APIC_TASKPRI, 0xf0);
+	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);
+
 	asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
 }
 
@@ -73,10 +77,22 @@ static void l1_guest_code(void *test_data)
 
 	sti_nop();
 
+	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);
+
 	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_VECTOR);
+	GUEST_ASSERT_EQ(nr_irqs, 0);
+
+	x2apic_write_reg(APIC_TASKPRI, 0xff);
+	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xff);
 	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_WAKEUP_VECTOR);
+	GUEST_ASSERT_EQ(nr_irqs, 0);
+
+	x2apic_write_reg(APIC_TASKPRI, 0);
+	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0);
+
 	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_NESTED_VECTOR);
 	GUEST_ASSERT_EQ(nr_irqs, 3);
+
 	GUEST_DONE();
 }
 
-- 
2.52.0


