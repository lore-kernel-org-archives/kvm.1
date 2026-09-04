Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D62472AE
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481475; cv=none; b=BLgW7HvFs6ntoTspXx1MrjhmNOFXhE7qJAEzsEPopGinzf2UCqVGBa7h7F/YRXMz5Dkz+gCCt14bYZnx++1gERaWTiO/jVG4wMR2haVtmY/NQ62d0oVWXslxs++Gc1osyssMNK0wcjzsp6cdx3EBtUr0p6HbtsSg2u94DhemLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481475; c=relaxed/simple;
	bh=Q7qpdWJEFs8lqslQBXctE4tqpv3fzC5rKtHXZQkZOvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BLJc1IjVbdZj/rqKKTPGUzAZ2DQzftoqZv7kET5QT2rvkf4hD50+vc/bo7YRkcmwftaZooCadxqdbprSUA4eTBT430EJ8aCmNeLRpx5RNW8bs4plfKivGTXpxinxCc7e/U1ZbwkQH7aFXN5ffleWcZhEG+1HabmPmpBqg0G0IFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTENJn+L; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTENJn+L"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e024d2129so614557b3a.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481472; x=1789086272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wRWK/v12x99rpq8aWGzvGBtRUnaxTCM6WoKg5BCcAo4=;
        b=CTENJn+LUSpcW2lMtC+wi/5eqSiZr24HUZeKn8ulmXsUdBdh8GovS8IBXqKF2qrGau
         wY/kzWCIantR8mD8sRTGWZibnBC2ZW5ClaMuZahaQhgpMPOEgHkmU1q4OJFudfTqwit6
         vAmu/6nOQFguPTlqXywCtrGnE5ZYYM001BK0jqYZuiS2hf3QiMYEri55aEeRV1ygdx7d
         A8PFws/4c7TDauqaM3Nzhy5fsVQCnwHh0a8vTocdKwIrH0YSLr4ejNcmASbYzNuR8cGM
         rgSbe2W4MdX47Yu8baFiTXZpWVPcgQMGVIqMQzIdKbIA6iuwvpFkbt4rNUBkgsuo9irz
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481472; x=1789086272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wRWK/v12x99rpq8aWGzvGBtRUnaxTCM6WoKg5BCcAo4=;
        b=B9ZjAbMaqZi5fDqgPNOL8drzFiMXSDfzCC4G8f5Gt0lgZH5/5DSrvLqahl78l26UYh
         68jxoY24saMZUAa0XbTRPliZ3vb0fZtC2Yp0Lkb1b9FkWZCxrOOoPqCi7erHPHBDqitI
         Lcahtc0mo1kjP94JWGE0EVmBDPo+xDSwdVSzhpdtL8tBj2npWbdn1UaYtJ/Bu2cCp9zQ
         PqSDwLuEJ4tol/RyrD1h43WueWskaDdF+oL9QmnwcabkZl6BQT4WwWfODEorD26AfbMP
         Qp5TfFlmdtshFbw57rFD2TLwv7wFgfst4RM7Gz+lnT71P3O8MYNM4rGcR3c194tN7/rY
         u0FA==
X-Gm-Message-State: AFuF++lgsLxLWgmwcKcUqXo+lCFC80oY9ULC/snO2yyQlLllakWzzdGZ
	ibp3tbjhyICFkHevy67MfZizw8SN23w0wPXE4jKw1Ru6kG6gzTiFsSBkHNp26cIGwvLigd8EjIx
	i4H26eQ==
X-Received: from pfus9.prod.google.com ([2002:a05:6a00:8c9:b0:847:ac08:fdf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4c:b0:85c:9bb4:a7ea
 with SMTP id d2e1a72fcca58-8616af56c5fmr2991883b3a.11.1788481471741; Thu, 03
 Sep 2026 17:24:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:11 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-6-seanjc@google.com>
Subject: [PATCH v4 05/17] KVM: selftests: Check VMPTRLD with active eVMCS
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
2.55.0.979.g7e5102b832-goog

