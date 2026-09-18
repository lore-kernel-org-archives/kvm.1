Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56583BA236
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719368; cv=none; b=VFuqn7fQnjoJBIdOCumxojSbqCW+wLWOsxMJm2AJFzrnXUDKvIy5m/beQ0G0SPSKCP3wVDdo73Beb+nIdqcsl4MoeDkV8PpKNAPLXZ2A4r3x/feZjM/shJrurArc7prFEzCgQQO9ZAu+d9XBiLQxfXtsVLSxmqzPXQDycBHiS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719368; c=relaxed/simple;
	bh=QOO98tAN/8/3LDBC/DGy5oKr+hlvwrBnFKaB/8Inwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVnjAwQ82POkmQtkFtKaE80U2aW07GvyESK5cWc37mFfBHJfvNMDCujGAoXQ/dChGCApZXHNzzZ6J82SoyQ0+GZFF/4IfwLdJb+ffS/U6/VsCxD7XRlYhDRum1qO0lnyM7IZcWUeqBaNXx9YlcZmNMEbWNnzS7Xy1kG0NdDFD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpgA5Tc1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpgA5Tc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKhaNYp4wxpZzu7WulZV4wey1GkqmjaDkMFDmXM/CIA=;
	b=MpgA5Tc1Di9c7IqKFqHSWwROEId1BO4gxCQwvOydYB0rV0T19OAVbTdrJxCDP/5Uh7+Rty
	DPquaJSR+w64gHITwBWXwL4HHjjCIbC/Mk06TUWU5Md7pWcz6GRiikMl3xdZ6lMCZCudXd
	dRd5ODwnvwTDckPkjYnZyzODD+On1RI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-SnqQHGLJO7yb6UKzsQ7MDg-1; Fri,
 18 Sep 2026 04:15:58 -0400
X-MC-Unique: SnqQHGLJO7yb6UKzsQ7MDg-1
X-Mimecast-MFC-AGG-ID: SnqQHGLJO7yb6UKzsQ7MDg_1789719356
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4249195419D;
	Fri, 18 Sep 2026 08:15:56 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3598030001A2;
	Fri, 18 Sep 2026 08:15:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 14/28] KVM: Introduce kvm_fetch_guest_page() and use it for x86
Date: Fri, 18 Sep 2026 04:15:29 -0400
Message-ID: <20260918081543.139871-15-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Introduce a separate function so that the emulator will be able to take
into account execution memory attributes rather than read.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c       | 4 ++--
 include/linux/kvm_host.h | 2 ++
 virt/kvm/kvm_main.c      | 9 +++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 416b2ebf1c70..6c0c95b92b5a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4872,8 +4872,8 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	offset = addr & (PAGE_SIZE-1);
 	if (WARN_ON(offset + bytes > PAGE_SIZE))
 		bytes = (unsigned)PAGE_SIZE - offset;
-	ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
-				       offset, bytes);
+	ret = kvm_vcpu_fetch_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
+					offset, bytes);
 	if (unlikely(ret < 0))
 		return X86EMUL_IO_NEEDED;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01223301f0e5..cddf0b943757 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1444,6 +1444,8 @@ DEFINE_VCPU_MAP_CLASS(_readonly);
 
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
+int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			      int offset, int len);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
 			     int len);
 int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa, void *data,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b1cc570be8df..7cb7ff202fc0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3291,6 +3291,15 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
+int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			      int offset, int len)
+{
+	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
+
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len)
 {
 	gfn_t gfn = gpa >> PAGE_SHIFT;
-- 
2.52.0


