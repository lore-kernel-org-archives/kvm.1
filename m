Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE83C09F3
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787572; cv=none; b=UzQWgT3QJ5GdsSHHgF9QYCu3gDJAg/eni0ZLsw0O25A0wAzv92CCm7ZMD8qupIGPS10TIgwixOD8ux6Kj2AfTBru46I5Dn4KKZfFQO5xHj6e64jSkand7DyS1mz7FnCOLk3fLnZGwGFqVwN382T6STSN1sYtaVUqXAnm4rluPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787572; c=relaxed/simple;
	bh=PaH7v/6ZshYM/7JV06k//ebWoKkZhJSEyltBWJM+apc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrS4Mx15/RK4FcwHq+jBZv2Z4C7UcJDaJlhM9v0eon4EJMFYcJlhaTThkPtmerAkHK2VbzCUAGS8AqdCFZASEdtU+eREqJnniHhkL6a1kv9bRLG+OwoRQ4tPt4P4C2bbF26/OQJVRn8ADDJXThWjLPbKIUwMdLe7vHTLKUo+Xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv7b2hj3; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv7b2hj3"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-855315ccb64so47800b3a.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787567; x=1788392367; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rnnRN8hJfQwgolvTmyTrKWAk5xBd0sRsJp37TMVzJVc=;
        b=Fv7b2hj3WeDf/KiMfk4K8EIXktD2XA6j/UXo4nzaT0R6kbX7ybwdDL/s4v5g+vrJVw
         WO+noAJuO7Zk2pubqQKIyhAVPUiQGA7ih0I88kylAL8REQJAc//Uo6zLqL9vrAA1n098
         RfjDKmlYyb36bc+7ddVu2V1wGBDZLGRxxPfxnLWXB5HvBFYOfAUovHP/qn1SwoB5M6ek
         m9RCb/6j6yLQvETBvJPi0lyjWzdegVDNfJrnMZ/kAvft5jAIo7XyMJmLWEh6g98kbvsH
         b7pKGfB4n/1ysjWc07U90q7srEzdHmHxMGNILUq9e1LOhelGqzx5aycK0PjjJFeCKdCh
         60sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787567; x=1788392367;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnnRN8hJfQwgolvTmyTrKWAk5xBd0sRsJp37TMVzJVc=;
        b=Za7ckjYMk34IlKV0qbSHVHGKhGdMocKhU60dzO0Zx0h48C9AcR9xy2o6kqChhYopqG
         cTUnWqrmzabMOmmFQPQK8bigGbIMPlQDIOJablc4QOHthSPl5XktNoG0s8Uhs8DWb2a+
         oAroGVb44yLQuOeBpSkKzuStDEINrFhJgjdMxefiQMw08zAUZg0EQSNcv4TQZmF92vcK
         byNKtT4cGYBFKtLSn9PESDcNOFBVXD0zfv8Ld7WcPazKAPiJeIJ+7p9CaF2P87UDE0wZ
         pDyVLJW2uJ/xYrMGGeyvY4ljiyhYQeg9VarFnJn6/NnYBq3LHFsQKwa6JRB4gzZecMOL
         OEug==
X-Gm-Message-State: AFuF++n/wYqKqhbduyrYyi3BAgRcuT4S+cI3J3jJyJgJ6+BvisJpETco
	bfNMvSVPNm15PeyAV5HAx2MZoKql42JhQ9cugg/g8m/YDdgawLQb+0TOZlclkA7sfT88AnNRhlE
	g7f8z8g==
X-Received: from pgco21.prod.google.com ([2002:a63:7315:0:b0:cc1:bf49:dfd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a12:b0:854:9b2a:f898
 with SMTP id d2e1a72fcca58-8549b2af9f9mr7835471b3a.8.1787787567089; Wed, 26
 Aug 2026 16:39:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:11 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-6-seanjc@google.com>
Subject: [PATCH v3 05/13] KVM: selftests: Check VMPTRLD with active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Check that VMPTRLD when eVMCS is active results in #UD. This matches
genuine Hyper-V's behavior.

Use KVM_ASM_SAFE framework to handle #UD from VMPTRLD.  Unfortunately, the
same trick cannot be applied to the existing #UD check on VMLAUNCH as
VMLAUNCH clobbers all registers which KVM_ASM_SAFE depends on.  Keep
VMLAUNCH handling separately.  Deliberately use a double-underscores
prefix instead of a "safe" postfix for the helper, to communicate that the
inner/outer helpers handle more than just exceptions, they also handle
VM-Fail conditions.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[sean: use __ instead of _safe]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 19 +++++++++++---
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 26 +++++++++++++++----
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index ac7d48d1387e..a161dbee7e04 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -342,9 +342,6 @@ static inline int vmptrld(u64 vmcs_pa)
 {
 	u8 ret;
 
-	if (enable_evmcs)
-		return -1;
-
 	__asm__ __volatile__ ("vmptrld %[pa]; setna %[ret]"
 		: [ret]"=rm"(ret)
 		: [pa]"m"(vmcs_pa)
@@ -353,6 +350,22 @@ static inline int vmptrld(u64 vmcs_pa)
 	return ret;
 }
 
+static inline int __vmptrld(u64 vmcs_pa)
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
index 6224d859d7bb..f953a9755a76 100644
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
@@ -178,7 +182,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
 
-	/* Try enlightened vmptrld with an incorrect GPA */
+	/* VMPTRLD instruction causes #UD after enlightened VMLAUNCH */
+	GUEST_ASSERT(__vmptrld(hv_pages->enlightened_vmcs_gpa) == UD_VECTOR);
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
@@ -252,7 +264,6 @@ int main(int argc, char *argv[])
 	vcpu_args_set(vcpu, 3, vmx_pages_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
 
-	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	pr_info("Running L1 which uses EVMCS to run L2\n");
@@ -282,7 +293,7 @@ int main(int argc, char *argv[])
 
 		/* Force immediate L2->L1 exit before resuming */
 		if (stage == 8) {
-			pr_info("Injecting NMI into L1 before L2 had a chance to run after restore\n");
+			pr_debug("Injecting NMI into L1 before L2 had a chance to run after restore\n");
 			inject_nmi(vcpu);
 		}
 
@@ -292,9 +303,14 @@ int main(int argc, char *argv[])
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
2.55.0.887.g758fc8c411-goog

