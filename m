Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8947F798
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071997; cv=none; b=JQVBK6RV0TLffkYTpQ38cOKYkzIt1lBBlocyt6GdGlMZezUvX7oX2adFyXeguqKtrG4jp5GpmmRxBh13qOpaEtOn9BmwuZVD5PfX+omvcqh8A8EDP9bIlFRkL/pHxg3HR0b2tihDYCI0ZreJ/f0xq/LIEXaLdkZ9oSTp/t56IhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071997; c=relaxed/simple;
	bh=5KSvQ0lR3nSV3GQnaya6+8BX26FqdLEUSjUQw/DpadY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDx5A15kzg3uEei9LVnUzsLLX76w7F8U9+vkLEDsx7tIDOzA0k20sOo/2BquSnHeofr9OW4+69jSe/KmXSp166xRxH+I2+SQF2ldr1Y95t/ZFDx0Gas2iR8qpF3wCkmpgohRYxKQuk0zoPbiqObOE4wPnaUw3t2fodc9rAY3w38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTs3Gp4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTs3Gp4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787071994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeAlhq82vYxgd3YLN8Csk0DSOJO0EC+fstAN50H0WxM=;
	b=XTs3Gp4jccJ1Wf7MjLvxPqj+6Bz/kmNTIlVbX2KOz5919FPO8d/pk5FPpcN6ZXi4TIJEu1
	mhhUasILTrxTU2U7BFL+MUrVbG+nh6sacMDL5svhSmd7KwmzQgGrWzG9RXsHnVZTn5v4jn
	kEUfTZdGQ4O9tPzTA3kcqUdGGa0rB54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-wKwttiWpOgqbXcMYHsx5Ew-1; Tue,
 18 Aug 2026 12:53:11 -0400
X-MC-Unique: wKwttiWpOgqbXcMYHsx5Ew-1
X-Mimecast-MFC-AGG-ID: wKwttiWpOgqbXcMYHsx5Ew_1787071990
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4642419560B2;
	Tue, 18 Aug 2026 16:53:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D4753000239;
	Tue, 18 Aug 2026 16:53:08 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
Date: Tue, 18 Aug 2026 18:52:58 +0200
Message-ID: <20260818165258.2613603-5-vkuznets@redhat.com>
In-Reply-To: <20260818165258.2613603-1-vkuznets@redhat.com>
References: <20260818165258.2613603-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Check that VMPTRLD when eVMCS is active results in #UD. This matches
genuine Hyper-V's behavior.

Use KVM_ASM_SAFE framework to handle #UD from VMPTRLD. Unfortunately, the
same trick cannot be applied to the existing #UD check on VMLAUNCH as
VMLAUNCH clobbers all registers which KVM_ASM_SAFE depends on. Keep
VMLAUNCH handling separately.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 19 +++++++++++---
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 26 +++++++++++++++----
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 047d02aa9688..e6adde3970d4 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -325,9 +325,6 @@ static inline int vmptrld(u64 vmcs_pa)
 {
 	u8 ret;
 
-	if (enable_evmcs)
-		return -1;
-
 	__asm__ __volatile__ ("vmptrld %[pa]; setna %[ret]"
 		: [ret]"=rm"(ret)
 		: [pa]"m"(vmcs_pa)
@@ -336,6 +333,22 @@ static inline int vmptrld(u64 vmcs_pa)
 	return ret;
 }
 
+static inline int vmptrld_safe(u64 vmcs_pa)
+{
+	u64 error_code;
+	u8 vector;
+	u8 failed;
+
+	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
+		     "\n\tsetna %[failed]"
+		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code),
+		       [failed]"=qm"(failed)
+		     : [pa]"m"(vmcs_pa)
+		     : "cc", "memory", KVM_ASM_SAFE_CLOBBERS);
+
+	return vector ? vector : failed ? -EINVAL : 0;
+}
+
 static inline int vmptrst(u64 *value)
 {
 	u64 tmp;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 88262ddf7fcb..cff27638834b 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -23,7 +23,11 @@ static int ud_count;
 static void guest_ud_handler(struct ex_regs *regs)
 {
 	ud_count++;
-	regs->rip += 3; /* VMLAUNCH */
+	/*
+	 * VMLAUNCH insn can't be easily covered by KVM_ASM_SAFE framework but
+	 * luckily the instruction is always three bytes.
+	 */
+	regs->rip += 3;
 }
 
 static void guest_nmi_handler(struct ex_regs *regs)
@@ -182,7 +186,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
 
-	/* Try enlightened vmptrld with an incorrect GPA */
+	/* VMPTRLD instruction causes #UD after enlightened VMLAUNCH */
+	GUEST_ASSERT(vmptrld_safe(hv_pages->enlightened_vmcs_gpa) == UD_VECTOR);
+
+	/*
+	 * Try enlightened vmptrld with an incorrect GPA. GUEST_SYNC(12) signals
+	 * the host to enable guest_ud_handler() which cannot be enabled beforehand
+	 * to not override the default fixup handler from KVM_ASM_SAFE().
+	 */
+	GUEST_SYNC(12);
 	evmcs_vmptrld(0xdeadbeef, hv_pages->enlightened_vmcs);
 	GUEST_ASSERT(vmlaunch());
 	GUEST_ASSERT(ud_count == 1);
@@ -256,7 +268,6 @@ int main(int argc, char *argv[])
 	vcpu_args_set(vcpu, 3, vmx_pages_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
 
-	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	pr_info("Running L1 which uses EVMCS to run L2\n");
@@ -286,7 +297,7 @@ int main(int argc, char *argv[])
 
 		/* Force immediate L2->L1 exit before resuming */
 		if (stage == 8) {
-			pr_info("Injecting NMI into L1 before L2 had a chance to run after restore\n");
+			pr_debug("Injecting NMI into L1 before L2 had a chance to run after restore\n");
 			inject_nmi(vcpu);
 		}
 
@@ -296,9 +307,14 @@ int main(int argc, char *argv[])
 		 * KVM_STATE_NESTED_EVMCS is not lost.
 		 */
 		if (stage == 9) {
-			pr_info("Trying extra KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE cycle\n");
+			pr_debug("Trying extra KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE cycle\n");
 			vcpu = save_restore_vm(vm, vcpu);
 		}
+
+		if (stage == 12) {
+			pr_debug("Trying enlightened VMLAUNCH with an invalid PTR\n");
+			vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
+		}
 	}
 
 done:
-- 
2.55.0

