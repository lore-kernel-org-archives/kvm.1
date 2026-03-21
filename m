Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A52D3225
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051814; cv=none; b=IiqXDpqv/ybcAfabapDawsyP11B6rkWE+9Kyq4HWuCZV14X1Uno/gZsxlaxf9dqKN5vOdfdA1Idotl6XULYH8t1mnDMOAPLRxMcEkwGGfJZX310g3o7nftBV7PiUv1IPcKZy3CZO2ebIxBxgzH/nOoo1MwENwcBjax1JHKTyvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051814; c=relaxed/simple;
	bh=ANppQFqf+X4t4pHOfjYdzVVFwAF97XHTPN/zZhag3Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2JwRkd3o2FgIZULzDp8FwyQKjxGN+VwlCsWFt0dNa03IvEDymYv1wKWuUr24ZG/iSicbA36LdYYL32njonFl4pVthiBZbweDnJSRGLILgMxBDz6dUDWaV/N+KFrIcVKM70p9PkQxP4VzgB1Z9kd/TrMD51jcHhx3tGIRQ8Yoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1zcHBT6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnpumlhD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1zcHBT6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnpumlhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdVmercWnCZLP8zFvHBbqxOZlu/sYmRu38PlBYz1DLw=;
	b=Q1zcHBT63CY0SKkzugZUkaQFWB/Kc7GGq0OnYujQqS4A0jbQdJE9eqjTJI0fBLVzhsMhlt
	rru+40IPWxXM3S28gGuQLb0aTzjLSj17nZi/qGgeQYRr8ruL7f3B1slsZSsFqtSm1ITZ0U
	hmY3zIKsb3oVkCc1CH2P19vw0ELf26I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-uuN3q230O56hLnVJzruknQ-1; Fri, 20 Mar 2026 20:10:10 -0400
X-MC-Unique: uuN3q230O56hLnVJzruknQ-1
X-Mimecast-MFC-AGG-ID: uuN3q230O56hLnVJzruknQ_1774051809
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso21983665e9.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051807; x=1774656607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdVmercWnCZLP8zFvHBbqxOZlu/sYmRu38PlBYz1DLw=;
        b=OnpumlhD4bB93COB0i+aQ9dSXMxvANr0bncrOFxU3MT5CljNInJ1plrTDDyFC7MV6e
         5qP4CUF4Jxsh/chZTZKETUzaUZkh4N5sJXoL6jPzB2Xq/PiEUgzNfTRXnOlPn7uO7Jd1
         P8VIUGcA/NzJtq+YwKVgguTlx/oW9rlsdxhzMj+Us3hUonNc4H9mjKsIXOJwhm4INxUo
         a3vVirOBQM0TRRkT4fYVca1ev0hLhxO99NIDoktpsLw7n3dCMpQUsbGNpnfmmdbunLZH
         GL3RZ8EdlOv/m8evroidKiTEQWMAwbl/B3WQudkgjfHUKwxjh4LB7T6U34t1Cy3JoF8b
         NRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051807; x=1774656607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdVmercWnCZLP8zFvHBbqxOZlu/sYmRu38PlBYz1DLw=;
        b=g4D95uHD+B5N4w/pP43MG7WyV1XediYMIwCE/4e5zFoja/E1WJuJI7OxiltEWsIEbU
         +CLHHMZlbTTTaL88e97Rwmvi+4PRfo0fTiA7fwa7xRK7PuKldnvau96CdAJXSg9W5qdv
         r9AqkwmcFPzxtUpG64vzyWFpWr77whmlzROUhNw1GXuamh+bNRe2s9Gkt/oynsboijhk
         pkx6aChjinoLewX3SDqVhksaPjdxWwNWSMY4uqDKBA1kYJ2RtWU565APYqGkBseL109s
         myfT8Dr2nh8N2GexdMGfoV2Tf+Q5n/NQdc/lYyqjAKBM5WYXYdIo2A6xXTN93EBxj3/B
         +AkA==
X-Forwarded-Encrypted: i=1; AJvYcCWY9fdmTuLOFEtC6oJgFX2z3oDMbCSWEkY2RlTFa6MM7ry5fiveY35lts20dbmpQeZxpn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2U7+gCOU1YrQ3a5bqyn/JR8SJMKWMxfbBXK/4z7uQCPDIoT+e
	GFdQdsKK0NBkZxUYxrtDI9ettVGTiI4CSmQZ6meLAk2Ghi/yW4YtuSjMUOfeYTas914mVVCplod
	QOaJBoAC4enxlsYQaOQc0SpC1GRvmGMkmvCNyN+OhttFgaa1kcDVz/qAdLmqMBg==
X-Gm-Gg: ATEYQzwmz7sJTmEh+72KZYpV9va7wilyJX8TPvZm/2K2BtcnHpbltQAZ1lbKF/elHcz
	Z7eLnaumBnEgObQ3SCzALB5gZePORortJIdhAOtfepQ44xHb/mAmN7DzrwirLmhiQy13P4YcQGD
	PTtMIUo3mKiefX9xGGnZ0FB7WcbC8AAMlnI415WNsuSMkdmD1GB8jF/HfhiBLp/C165HxPIFk7x
	aIBfKamV318sXnOLkAQG47woJ8Gb1uvp9SJg2DgzgT8Jh/WGzzj1FZuVkxWxQ2eAFNTbYhNyY2z
	0TYf5/jn19jswGfjnesBdWXzAzBf/8il4ksuyYlVRlsPRWU+xVN6cHjAp+z6UbjkWiDGALh5+1r
	FHQ9NEIUKNOUHYUBtrhwQL5qaF7bKXSPjslgijK0jMxtBhNy5VBXi97/zWAE6RghugmZ+SOOXOZ
	DcoUPARhhmjZIoKJnkFhdnOg8i
X-Received: by 2002:a05:600c:530f:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-486febb455dmr74703375e9.4.1774051807363;
        Fri, 20 Mar 2026 17:10:07 -0700 (PDT)
X-Received: by 2002:a05:600c:530f:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-486febb455dmr74703105e9.4.1774051806935;
        Fri, 20 Mar 2026 17:10:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm289668275e9.9.2026.03.20.17.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 13/22] KVM: x86/mmu: add support for nested MBEC
Date: Sat, 21 Mar 2026 01:09:22 +0100
Message-ID: <20260321000931.1947084-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c657ea90bb33..d50085308506 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -124,12 +124,17 @@ static inline void FNAME(protect_clean_gpte)(struct kvm_mmu *mmu, unsigned *acce
 	*access &= mask;
 }
 
-static inline int FNAME(is_present_gpte)(unsigned long pte)
+static inline int FNAME(is_present_gpte)(struct kvm_mmu *mmu,
+					 unsigned long pte)
 {
 #if PTTYPE != PTTYPE_EPT
 	return pte & PT_PRESENT_MASK;
 #else
-	return pte & 7;
+	/*
+	 * For EPT, an entry is present if any of bits 2:0 are set.
+	 * With mode-based execute control, bit 10 also indicates presence.
+	 */
+	return pte & (7 | (mmu_has_mbec(mmu) ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
 #endif
 }
 
@@ -152,7 +157,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
 {
-	if (!FNAME(is_present_gpte)(gpte))
+	if (!FNAME(is_present_gpte)(vcpu->arch.mmu, gpte))
 		goto no_present;
 
 	/* Prefetch only accessed entries (unless A/D bits are disabled). */
@@ -173,14 +178,17 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 static inline unsigned FNAME(gpte_access)(u64 gpte)
 {
 	unsigned access;
-#if PTTYPE == PTTYPE_EPT
 	/*
-	 * For now nested MBEC is not supported and permission_fault() ignores
-	 * ACC_USER_EXEC_MASK.
+	 * Set bits in ACC_*_MASK even if they might not be used in the
+	 * actual checks.  For example, if EFER.NX is clear permission_fault()
+	 * will ignore ACC_EXEC_MASK, and if MBEC is disabled it will
+	 * ignore ACC_USER_EXEC_MASK.
 	 */
+#if PTTYPE == PTTYPE_EPT
 	access = ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
 		((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
-		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
+		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0) |
+		((gpte & VMX_EPT_USER_EXECUTABLE_MASK) ? ACC_USER_EXEC_MASK : 0);
 #else
 	/*
 	 * P is set here, so the page is always readable and W/U/!NX represent
@@ -335,7 +343,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	if (walker->level == PT32E_ROOT_LEVEL) {
 		pte = mmu->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
-		if (!FNAME(is_present_gpte)(pte))
+		if (!FNAME(is_present_gpte)(mmu, pte))
 			goto error;
 		--walker->level;
 	}
@@ -417,7 +425,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		pte_access = pt_access & (pte ^ walk_nx_mask);
 
-		if (unlikely(!FNAME(is_present_gpte)(pte)))
+		if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
 			goto error;
 
 		if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
@@ -514,6 +522,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * ACC_*_MASK flags!
 		 */
 		walker->fault.exit_qualification |= EPT_VIOLATION_RWX_TO_PROT(pte_access);
+		if (mmu_has_mbec(mmu))
+			walker->fault.exit_qualification |=
+				EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
 	}
 #endif
 	walker->fault.address = addr;
-- 
2.52.0

