Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F834446F4
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225716; cv=none; b=NR+i1lUbBhrFgj1bYpx6+hSH4hDBmUUjZbjgRW5uQ0UHyCcHFWs8V5R0ljXl8VVy0bGjHTuurHCv5pAapxwzmCKjNKmbQ5Ucvo8BsOw2dIpgJeqPFW0N8jzDHl84kKBMcPnZ8v/PuSNt6IzgDB5ouqfrC2CozU5TK4bGVqmLZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225716; c=relaxed/simple;
	bh=2e+U27xduGBRxfBgJ+9hvS/HFbgVzEXO1NYF3Pm2hJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX+lZYVMfq2VOLroINvcrm8bGXVjuymuJKbd4Ryk81NSx2d+iHo4YW/0vREcw3FigLrQkMpBnqIha0dO6zpU+afUz9h+2CGr0ELmo7Wtizs5Ec0jihO3huiWBcGc+qP3VFyLycLF6ahYh/1PzJy7iEf3pkKvSVyKU5z12cUr/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFp5M2TK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFp5M2TK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TY1b9TTussYYzB0mCcw/1CQOTncA91YZzylI01X+vNc=;
	b=GFp5M2TKwJHGaTWl05mfjOUZcLWbE62nXWAN8GlarycxNTHnSG+NWMdz2Uj5pYO4NB/RnD
	3mO0/1MLLh06xH3VXB35NX5TJoae5z3N2pVENF8m3KjQAAh9eLInzuBEnBOzkfKV7Ds6SM
	KufLYAxgnl7HqhLCg4WMqhihXsgSa6k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-XacLad_MPfuT7VG3OegCKg-1; Thu,
 16 Jul 2026 14:15:06 -0400
X-MC-Unique: XacLad_MPfuT7VG3OegCKg-1
X-Mimecast-MFC-AGG-ID: XacLad_MPfuT7VG3OegCKg_1784225705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593691955F7E;
	Thu, 16 Jul 2026 18:15:05 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDB1D1800480;
	Thu, 16 Jul 2026 18:15:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 11/24] KVM: Take memory protections into account in kvm_read/write_guest()
Date: Thu, 16 Jul 2026 14:14:43 -0400
Message-ID: <20260716181456.402786-12-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Take into account memory attributes when accessing guest memory through
the kvm_read/write_guest() family of functions.

All of these pass a struct kvm_memory_slot pointer to the actual
workhorse functions, in order to share code between the VM-wide and
vCPU-specific version of the functions (the latter of which handles the
multi-address-space case).  For this reason they need specific changes
and do not work even though the gfn_to_hva() path has been taught already
about memory protection attributes.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 56016aab0aad..d920ce5b6739 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3249,8 +3249,8 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-				 void *data, int offset, int len)
+static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+				 gfn_t gfn, void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
@@ -3261,6 +3261,10 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return -EFAULT;
+
 	r = __copy_from_user(data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
@@ -3272,7 +3276,7 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3281,7 +3285,7 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3325,8 +3329,9 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
-			           void *data, int offset, unsigned long len)
+static int __kvm_read_guest_atomic(struct kvm *kvm,
+				   struct kvm_memory_slot *slot, gfn_t gfn,
+				   void *data, int offset, unsigned long len)
 {
 	int r;
 	unsigned long addr;
@@ -3334,6 +3339,9 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
 
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
@@ -3352,7 +3360,7 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
@@ -3370,6 +3378,10 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+
+	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+		return -EFAULT;
+
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-- 
2.52.0


