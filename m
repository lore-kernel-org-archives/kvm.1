Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141366;
	b=SBvu4TT2N8DjOOtviM60ax9j/6byJ32/8dnTYHmQ2uEAfVvOCM4KkSzzH/T+oPTW+VJL
	 020H44hb15zqYgrYR9Tqipx3D8vS+lnvuW2FpIuZ65+BQWPfJPfC/E/wa+S+7P22HEjQ+
	 9Ikdb3ioOd3G1hxYR5Qdd7bJwRhYib5fTvg9SkqLajPlUMf/31O+TCpqJHW7bK2mcG/Of
	 u1jSB5yv1rinDjA0V54Ls2iUDsindSD61wwMb9htSnqTyL2aKQUTpJOE/+MWWZoBLBDZN
	 nyGr22XgTPF8ZtONM5Nrza//WHvJcV2jtaXs0OMkbMVtPkXT4wd+wFtkGClKvrkLUVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=rOkPtWVSW1j6H8I5rspLbvj2xB0DWyNEyqjlPetgUS4=;
	b=H3VFXPCvU0lpjSXO3zoWMjCpbZbr0/Viys21zvD6bSbr3o4PJDYSj/2QJOe3T/luc8ND
	 TGFxTcW2EtCRSd08SMQQSX3PaGvJhkxiwio6ov6lWfxP9BsJNOnJFt2M3Q6OzcH/xB1Is
	 W2XLliG78Ha+I9Ukp0UkxijrZCfjgp0grmChJ7KWofLTwjhZoxQmzpKEhi/m9P0ukY1VJ
	 jzQkYatTVuujL8epa1cAAmT2qQuwuiXM1KOM7DIxenqC+ol7G7ADvlOs3c64ghYiW94BM
	 DZyULt0e+3gjjWrhAoB2oNPI9R6Jx6IyXpz4eIeRuhvTMkff08MhsAfR1gI5rvUEzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p1KqquZi;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AB60A2606
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271AB60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p1KqquZi
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso480307b3a.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141366; x=1793746166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rOkPtWVSW1j6H8I5rspLbvj2xB0DWyNEyqjlPetgUS4=;
        b=p1KqquZihZlkDPB4VJnSXtKOvwfVSraH7p46UFllwB/rwO7i05uDceMuyWBNP0ULbi
         Y0jf2V/QqjFclYHh5fD14aDBQ3qdvLrRIhIFBovlWHuHS0sL/Cyb/L92cNH/9LWjW0Tv
         jXBRLodYJ07TpjquE5kro3X3JUc1gWOK5wrJjmQ7UD/86HzvgspiR1S19mDqaxuc6G0A
         pOI+IDe0j+3TLwcmAzllO32/Pxz2kI0sIPRfp8FMOQcvVOSx0nf9yQ0LMJ0XT2EE50AF
         s7reFTjU4c5RSJdcS7hYMBC9YPsrr4IdGb6s2EX1iwwfGc9tJ7+XpFhvObdUK5mrw9V7
         oeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141366; x=1793746166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOkPtWVSW1j6H8I5rspLbvj2xB0DWyNEyqjlPetgUS4=;
        b=unaXcu5oSOKI4wH2Q8rJfTRZFNMoaCBRJBMuAfbSmjQL5IPOmlf1QjiZ9YexCHGMqJ
         rb+9VI/NfQ4b4v4UCv8UG9v7vKulDAs5O5Z1I06pKcaCbMNO9n2v6w4bSTogPniisINK
         B0iYUB0xxi8kfH5wr1ViB5s7icdcURg3jUqCDA90gfChuf2k4N+JZ/rAaZ1Kh96nsLxj
         0/htxbD5ev6dXbf5k1VnkSnGS2zTMlK9vYVEMT41cCjOA4sxyWMq8ICob/h6yiZsGPHB
         JKsf5bxJSqXm/E5f2XlroARwnvHF2jyjLANzg4Y7trGoqrsSh+FQtCyV22AmsVcjQ8Xp
         rE1Q==
X-Gm-Message-State: AFq9FYIzG34z0uKIF0OzcDob0cjIYRtSDBC2fxKgi80IccNQ4/ffhIOG
	aRuQTLI0hh758X//mjCNvUDuoqWoKOHt+AL4pQZJoigVdMK4/4Z9a7vw1QEg7pTFGsr2Fp5O5c3
	8lXq+Lg==
X-Received: from pfff18.prod.google.com ([2002:a05:6a00:bd12:b0:8a2:1bc3:8884])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4085:b0:89f:c71e:aba5
 with SMTP id d2e1a72fcca58-8a6e74d735dmr516308b3a.37.1793141365470; Tue, 27
 Oct 2026 15:49:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:13 -0700
In-Reply-To: <20261027224914.1574319-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027224914.1574319-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: selftests: Update nSVM EFER test to expect #GP
 when clearing SVME in L2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Adjust the nSVM EFER test to expect a #GP on WRMSR if L2 attempts to clear
EFER.SVME to match KVM's new behavior (synthesizing #GP is safer for KVM as
it doesn't require yanking the vCPU out of L2, and is fully synchronous).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 75 ++++++++++++-------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
index fa0d76a9c390..fa9cfe8b1242 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
@@ -15,22 +15,34 @@ static bool l2_ran;
 static void l2_clear_efer_svme(void)
 {
 	u64 efer = rdmsr(MSR_EFER);
+	u8 vector;
 
 	/* generic_svm_setup() initializes EFER_SVME set for L2 */
 	GUEST_ASSERT(efer & EFER_SVME);
-	wrmsr(MSR_EFER, efer & ~EFER_SVME);
 
-	/* Unreachable, L1 should be shutdown */
-	GUEST_ASSERT(0);
+	vector = wrmsr_safe(MSR_EFER, efer & ~EFER_SVME);
+	__GUEST_ASSERT(vector == GP_VECTOR,
+		       "Expected #GP when clearing EFER.SVME in L2, got %s",
+		       ex_str(vector));
+
+	efer = rdmsr(MSR_EFER);
+	GUEST_ASSERT(efer & EFER_SVME);
+
+	l2_ran = true;
+	vmmcall();
 }
 
 static void l1_clear_efer_svme(struct svm_test_data *svm)
 {
+	struct vmcb *vmcb = svm->vmcb;
+
 	generic_svm_setup(svm, l2_clear_efer_svme);
-	run_guest(svm->vmcb, svm->vmcb_gpa);
+	run_guest(vmcb, svm->vmcb_gpa);
 
-	/* Unreachable, L1 should be shutdown */
-	GUEST_ASSERT(0);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(l2_ran);
+	GUEST_ASSERT(vmcb->save.efer & EFER_SVME);
+	GUEST_DONE();
 }
 
 static void l2_lmsle(void)
@@ -130,31 +142,10 @@ static void test_enumeration(void)
 	ksft_test_result_pass("KVM enumerates EFER_LMSLE_MBZ=%d\n", lmsle_mbz);
 }
 
-static void test_clear_efer_svme(void)
+static void test_efer_in_guest(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vcpu = create_l1_vcpu(&vm, l1_clear_efer_svme);
-
-	vcpu_run(vcpu);
-	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
-
-	kvm_vm_free(vm);
-	ksft_test_result_pass("L2 clearing EFER.SVME shuts down L1\n");
-}
-
-static void test_lmsle(bool lmsle_mbz)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vcpu = create_l1_vcpu(&vm, l1_lmsle);
-
-	vcpu_set_or_clear_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ,
-					lmsle_mbz);
-
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
@@ -166,6 +157,32 @@ static void test_lmsle(bool lmsle_mbz)
 	default:
 		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
 	}
+}
+
+static void test_clear_efer_svme(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vcpu = create_l1_vcpu(&vm, l1_clear_efer_svme);
+
+	test_efer_in_guest(vcpu);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("L2 clearing EFER.SVME gets #GP\n");
+}
+
+static void test_lmsle(bool lmsle_mbz)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vcpu = create_l1_vcpu(&vm, l1_lmsle);
+
+	vcpu_set_or_clear_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ,
+					lmsle_mbz);
+
+	test_efer_in_guest(vcpu);
 
 	kvm_vm_free(vm);
 	ksft_test_result_pass("Guest EFER_LMSLE_MBZ=%d\n", lmsle_mbz);
@@ -248,7 +265,7 @@ int main(int argc, char *argv[])
 		test_clear_efer_svme();
 		test_lmsle(true);
 	} else {
-		ksft_test_result_skip("L2 clearing EFER.SVME shuts down L1\n");
+		ksft_test_result_skip("L2 clearing EFER.SVME gets #GP\n");
 		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=1\n");
 	}
 
-- 
2.56.0.307.g5fe7bd680c-goog

