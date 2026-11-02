Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641529;
	b=MAXx+yypc6aNsJKKc7cTPqqA5K/3Q5qfGUL/gnxtM7DPgGX7hRXOhAEWyCaHtX1N73Re
	 GngTrtv6KEjXdjr3OLZ/R14l2MsoREscM6+r7xv09N7s97TfTSJLyN9fbLLljni5AlaNW
	 JL3U0UAJ0mWcgFAM0AODVnxZCcOyr9hvuRTudJY4L5pJwsh7Q6IIaHustbs+RQra87q8p
	 x+RpqIeChcPTIKXlBrdmH3L1OWmOlf9JTm+gsCC/B1Pk1yTXCQe9iyiqIHg51L7u39m/g
	 yA9UtDxPFF0kjnm1Y7uic58lz2qfoR0/1Ft0iXucd0AKix6c12QacIti9C3kRe/zFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641529;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=/QofelLOb0S/7bU7IHfP7FQZcT5hHKPvHJSopjIRL14=;
	b=fPXRtTOBvcynIXNhmeyBfSD5vM4Y77wR6L7A+XEZVe4IAVSR8Ia2ApeXXC9eo4vPa4YO
	 3jaUX3ElHf4coRKH0ukYf1ReHi13YLvYr2z2l8kLE2/Mw5jB90OnY8vJUPn+hoETvVI9y
	 Dw9GZ7f5el6+mmLhD4eAPlh615Ri3KYnYYh59gfAJGO13emFypozk9Q0LXVjiBjiAM0wd
	 JLwaqSBIaBjn2hUOMwwRzDGgw7jdi+7snY1kI54d/UEo97FV+XdbzrFb8qqixMuJmA0As
	 YbhlhFK8n/d0KVOPJg/+BhaLnjR8XqjJarmvPZItJvHFJXGQ76Pa9RXHTPTFBI3rsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dLowDXNL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3560A5BE2
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA3560A5BE2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dLowDXNL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QofelLOb0S/7bU7IHfP7FQZcT5hHKPvHJSopjIRL14=;
	b=dLowDXNLpSH3OxWirK6gC/so4ybRCDETcT7OyqnMtJlzWdvNOwbKHGmtbYffijHYURTmRX
	4KhqbnIfueTsaqduj+HhQLoPBQID7CkFddWaT6FBmsls1tfOh9v9fTWSfymzLL0YgE+GS4
	GX9j1ou37BQFq+NUuW4JE6Ex/LyOPZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-bGdp60-NO76RyI9pBemeaA-1; Mon,
 02 Nov 2026 12:45:26 -0500
X-MC-Unique: bGdp60-NO76RyI9pBemeaA-1
X-Mimecast-MFC-AGG-ID: bGdp60-NO76RyI9pBemeaA_1793641525
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08D9919560AD;
	Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 897AE433;
	Mon,  2 Nov 2026 17:45:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 34/45] KVM: x86/mmu: Adjust gva_to_gpa to allow returning an error
Date: Mon,  2 Nov 2026 12:45:01 -0500
Message-ID: <20261102174512.8903-18-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

In order to allow the emulator to check memory attributes and
return -EFAULT to userspace, INVALID_GPA is not sufficient anymore
to distinguish all possible return values of w->gva_to_gpa.  Move the
guest physical address to an out parameter, and use the return
value for errno.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst  |  4 +-
 arch/x86/include/asm/kvm_host.h |  6 +--
 arch/x86/kvm/mmu.h              | 10 ++---
 arch/x86/kvm/mmu/mmu.c          | 11 +++---
 arch/x86/kvm/mmu/paging_tmpl.h  | 15 ++++----
 arch/x86/kvm/svm/nested.c       |  4 +-
 arch/x86/kvm/vmx/nested.c       |  4 +-
 arch/x86/kvm/vmx/sgx.c          |  7 +++-
 arch/x86/kvm/x86.c              | 66 ++++++++++++++++++++++-----------
 9 files changed, 80 insertions(+), 47 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ac8cd51bdada..743a738ff8d3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -521,7 +521,9 @@ data structures.
 :Architectures: x86
 :Type: vcpu ioctl
 :Parameters: struct kvm_translation (in/out)
-:Returns: 0 on success, -1 on error
+:Returns: 0 on success, -1 on error.  errno is EFAULT if
+          the parameter is invalid but also if guest memory
+          could not be accessed
 
 Translates a virtual address according to the vcpu's current address
 translation mode.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6a35fd384a74..99f9c9269f2f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -490,9 +490,9 @@ struct kvm_pagewalk {
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault,
 				  bool from_hardware);
-	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-			    gpa_t gva_or_gpa, u64 access,
-			    struct x86_exception *exception);
+	int (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			  gpa_t gva_or_gpa, u64 access, gpa_t *gpa,
+			  struct x86_exception *exception);
 
 	union kvm_cpu_role cpu_role;
 	struct kvm_page_format fmt;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..224f4c1a957e 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -185,12 +185,12 @@ static inline bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu,
 void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
 			ulong roots_to_free);
 void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu);
-gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
+int kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
+			    struct x86_exception *exception);
+int kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
+			     struct x86_exception *exception);
+int kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
 			      struct x86_exception *exception);
-gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
-			       struct x86_exception *exception);
-gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
-				struct x86_exception *exception);
 
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 787bc31acda3..c827f2e1f3d1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2993,7 +2993,7 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		goto out;
 
 	if (!vcpu->arch.mmu->root_role.direct) {
-		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
+		kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, &gpa, NULL);
 		if (gpa == INVALID_GPA)
 			goto out;
 	}
@@ -4462,9 +4462,9 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_roots(vcpu->kvm, vcpu->arch.mmu, roots_to_free);
 }
 
-static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-				  gpa_t vaddr, u64 access,
-				  struct x86_exception *exception)
+static int nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+				gpa_t vaddr, u64 access, gpa_t *gpa,
+				struct x86_exception *exception)
 {
 	if (exception)
 		exception->error_code = 0;
@@ -4474,8 +4474,9 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
 	 * the last argument to kvm_translate_gpa (which NPT does not use).
 	 */
-	return kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
+	*gpa = kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
 				 exception, ACC_ALL);
+	return 0;
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a1212104882c..7775ba789258 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -901,14 +901,15 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 }
 
 /* Note, @addr is a GPA when gva_to_gpa() translates an L2 GPA to an L1 GPA. */
-static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-			       gpa_t addr, u64 access,
-			       struct x86_exception *exception)
+static int FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			     gpa_t addr, u64 access, gpa_t *gpa,
+			     struct x86_exception *exception)
 {
 	struct guest_walker walker;
-	gpa_t gpa = INVALID_GPA;
 	int r;
 
+	*gpa = INVALID_GPA;
+
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
 	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.gva_walk);
@@ -917,12 +918,12 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
 
 	if (r) {
-		gpa = gfn_to_gpa(walker.gfn);
-		gpa |= addr & ~PAGE_MASK;
+		*gpa = gfn_to_gpa(walker.gfn);
+		*gpa |= addr & ~PAGE_MASK;
 	} else if (exception)
 		*exception = walker.fault;
 
-	return gpa;
+	return 0;
 }
 
 /*
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index fedddcd1cc96..5d0a2f658365 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2155,6 +2155,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
+	gpa_t result;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
@@ -2163,7 +2164,8 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
 		access |= PFERR_USER_MASK;
 
-	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
+	w->gva_to_gpa(vcpu, w, gpa, access, &result, exception);
+	return result;
 }
 
 struct kvm_x86_nested_ops svm_nested_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b133e53fde39..a666c2908889 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7483,6 +7483,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 pte_access)
 {
 	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
+	gpa_t result;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
@@ -7495,7 +7496,8 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
 		access |= PFERR_USER_MASK;
 
-	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
+	w->gva_to_gpa(vcpu, w, gpa, access, &result, exception);
+	return result;
 }
 
 struct kvm_x86_nested_ops vmx_nested_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index df18adbdd829..2336aa9f68c5 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -76,11 +76,14 @@ static int sgx_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t gva, bool write,
 			  gpa_t *gpa)
 {
 	struct x86_exception ex;
+	int r;
 
 	if (write)
-		*gpa = kvm_mmu_gva_to_gpa_write(vcpu, gva, &ex);
+		r = kvm_mmu_gva_to_gpa_write(vcpu, gva, gpa, &ex);
 	else
-		*gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, &ex);
+		r = kvm_mmu_gva_to_gpa_read(vcpu, gva, gpa, &ex);
+	if (r)
+		return r;
 
 	if (*gpa == INVALID_GPA) {
 		kvm_inject_emulated_page_fault(vcpu, &ex);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bb36ca1106e5..53400fda9f44 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4829,34 +4829,34 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 	return handled;
 }
 
-gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
-			      struct x86_exception *exception)
+int kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
+			    struct x86_exception *exception)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
-	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, gpa, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 
-gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
-			       struct x86_exception *exception)
+int kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
+			     struct x86_exception *exception)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
-	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, gpa, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 
 /* uses this to access any guest's mapped memory without checking CPL */
-gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
-				struct x86_exception *exception)
+int kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva, gpa_t *gpa,
+			      struct x86_exception *exception)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
-	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, 0, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, 0, gpa, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -4867,11 +4867,14 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 	void *data = val;
 
 	while (bytes) {
-		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
+		gpa_t gpa;
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
 
+		ret = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, &gpa, exception);
+		if (ret == -EFAULT)
+			return X86EMUL_MEMORY_FAULT;
 		if (gpa == INVALID_GPA)
 			return X86EMUL_PROPAGATE_FAULT;
 		ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, data,
@@ -4901,8 +4904,12 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	int ret;
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
-	gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access|PFERR_FETCH_MASK,
-					  exception);
+	gpa_t gpa;
+
+	ret = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access | PFERR_FETCH_MASK,
+				   &gpa, exception);
+	if (unlikely(ret == -EFAULT))
+		return X86EMUL_MEMORY_FAULT;
 	if (unlikely(gpa == INVALID_GPA))
 		return X86EMUL_PROPAGATE_FAULT;
 
@@ -4966,11 +4973,14 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 	void *data = val;
 
 	while (bytes) {
-		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
+		gpa_t gpa;
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
 
+		ret = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, &gpa, exception);
+		if (ret == -EFAULT)
+			return X86EMUL_MEMORY_FAULT;
 		if (gpa == INVALID_GPA)
 			return X86EMUL_PROPAGATE_FAULT;
 		ret = kvm_vcpu_write_guest(vcpu, gpa, data, towrite);
@@ -5085,7 +5095,8 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
+	if (gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, gpa, exception))
+		return -EFAULT;
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -5332,7 +5343,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	if (bytes > 8 || (bytes & (bytes - 1)))
 		goto emul_write;
 
-	gpa = kvm_mmu_gva_to_gpa_write(vcpu, addr, NULL);
+	r = kvm_mmu_gva_to_gpa_write(vcpu, addr, &gpa, NULL);
+	if (r == -EFAULT)
+		return X86EMUL_MEMORY_FAULT;
 
 	if (gpa == INVALID_GPA ||
 	    (gpa & PAGE_MASK) == APIC_DEFAULT_PHYS_BASE)
@@ -9341,19 +9354,24 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	unsigned long vaddr = tr->linear_address;
 	gpa_t gpa;
-	int idx;
+	int idx, r;
 
 	vcpu_load(vcpu);
-
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
+	r = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, &gpa, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	vcpu_put(vcpu);
+
+	if (r) {
+		if (r != -EFAULT)
+			return r;
+		gpa = INVALID_GPA;
+	}
+
 	tr->physical_address = gpa;
 	tr->valid = gpa != INVALID_GPA;
 	tr->writeable = 1;
 	tr->usermode = 0;
-
-	vcpu_put(vcpu);
 	return 0;
 }
 
@@ -10815,11 +10833,15 @@ int kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_co
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	struct x86_exception fault;
+	gpa_t gpa;
+	int r;
 	u64 access = error_code &
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
-	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, &fault) != INVALID_GPA) {
+	r = gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, &gpa, &fault);
+	if (r)
+		return r;
+	if (!(error_code & PFERR_PRESENT_MASK) || gpa != INVALID_GPA) {
 		/*
 		 * If gva_walk->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
-- 
2.52.0


