Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708259;
	b=HPNX3OAmQqu7qE8Z7VFF1Fs2tH6TPI4+j9O2UUBe7fP7Aas6saj153Ct7jyM7UNZHJhL
	 LiBbKN1O8D+Zu2edyY0QpI4+TAQRIhkf8tvrIsTbPZ75h7a2eyuy2Ddq5etcTnUTlRGLj
	 8Has9eC8t2aV/gSqlUWtMCAij9sEzkP7xck58OA7gwTeQvhKXSQykMtyE1i7edawJVBRz
	 su8fb60U0M4B26QAH+tUAjtrqoL1UbTz7TrBTLaqFRyCGkIh8WJOIlIqYGbmtKYBEbKTn
	 gJXIqWpjrrEEcSC2tLGP6EfheFYdX2djuCytSBtT3brk4+q48Nw8mA5Iio06PY/nrUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V5Z5GxAUSxf95HmfpK3F+lfXYV/+28XPGEi30XXC9Mw=;
	b=y9iLJgPd5cm9JvJmSEOU4ZJ9BM9khonYDmhki3K2AixV56zzeuEc4PFoleYC86cLqZiC
	 2OJFfuMBIRFi1LemEKW+7h1J0nemWcL/KrZu6l0ZaF87FS55wG6xkvNxYAdsOcKDB0Y4N
	 CuCBFXiLP3TfUKgGK1hLGX11hW+45Ki/jydoeifQkWZPNtrXpNGy99dzmSHYCnTtD/qGO
	 8Q85fnBIHbRLJrCZN0KagTndY8WI9iJtCgfN6t7trFuNjtRpOrKJ+e1/BtbK3XHJmOu8J
	 R6qQ/yGvnhcfn2ZMYZoZ59x6ekfMmbCuTYXxTB8Q7R5juv6s4c4tHX59baTiU2SelIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fbGvWp+e;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E460A2605
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474E460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fbGvWp+e
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so228206a91.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792708259; x=1793313059; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V5Z5GxAUSxf95HmfpK3F+lfXYV/+28XPGEi30XXC9Mw=;
        b=fbGvWp+e87THwE5KAq/nPprRW5bgWFjkiUJCeyGn78VM/REnztIrWsLlbWcjVn8SYa
         jXJahVUOmFtXIPM+J7yXemsew6L38nwLXVb68V1F2J/iG56MAoIo2QawftjGojZ5O4al
         FGd/+M4qdPi+99jh3d72wprBigd/qIWy6hcAmL9MbRfC4gNbyELuYyEYYbl301E9PRiL
         uthbOWcETfFueGDiUx461gyF4Z8w5FbIxmgP6cg1zsvh2HuzZWRm0B1oDtwekmRiQ4nk
         TwvJRNkQ2HEEf+1sL7oAC9UaBdwr5Rny009nBhsInwjF57q0SPNcgay6Zs30iyCNnx6g
         rUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708259; x=1793313059;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V5Z5GxAUSxf95HmfpK3F+lfXYV/+28XPGEi30XXC9Mw=;
        b=yyWuEy0B1qBXZsC6DdfeIKGIdN+dVg/3oN/fsPyOZjU7hilOAhm2cZWRIPpLB3PZ3m
         gmVNPHHTZoGxSovVg6+pFXIeDWLgDfjCyUqSkSBOPL4jzsIWCTxPaOaY4hyPH1IDSOOX
         ws1U5BHSt13NvkrkHqc5aQQzs8xPGDaqEbHbd/zmm21C3DEgl52mSaVP7M9rrOVYVm0z
         GH2D5WlvdO2B5ASDu3bn2ct0ePem/4nPDUcBhudGUb9TvRqao6AlZHt6EiMsxQbK7BwD
         Ae/3FrIJjawe41sd/qyJd1PJWObI9ODOY9pD+KuvKGKyENu4SASpMIvEJAFF7HO6juIp
         tFQw==
X-Gm-Message-State: AFq9FYL/ms79HjcdN2/8qRHziircPJRe4VbQwr+UCBq6ixeFBjNtiy3H
	8FuALiM8HvswDn8GFvtnP9ue6n3k2Cw2AEMbgEcjTLh7CuWeczUawlU/cmVGs8woPWRYPWo9dss
	5jLvl0A==
X-Received: from pjor7.prod.google.com ([2002:a17:90a:9407:b0:3ad:8673:d3c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224a:b0:3ab:9f89:e1b3
 with SMTP id 98e67ed59e1d1-3adce08500dmr242140a91.40.1792708258533; Thu, 22
 Oct 2026 15:30:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 15:30:52 -0700
In-Reply-To: <20261022223052.646891-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022223052.646891-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: selftests: Update nSVM EFER test to expect #GP when
 clearing SVME in L2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adjust the nSVM EFER test to expect a #GP on WRMSR if L2 attempts to clear
EFER.SVME to match KVM's new behavior (synthesizing #GP is safer for KVM as
it doesn't require yanking the vCPU out of L2, and is fully synchronous).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 65 +++++++++++--------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
index fa0d76a9c390..f612146d23ac 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
@@ -15,13 +15,18 @@ static bool l2_ran;
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
+		       "Expected #GP when clearing EFER.LME in L2, got %s",
+		       ex_str(vector));
+
+	l2_ran = true;
+	vmmcall();
 }
 
 static void l1_clear_efer_svme(struct svm_test_data *svm)
@@ -29,8 +34,7 @@ static void l1_clear_efer_svme(struct svm_test_data *svm)
 	generic_svm_setup(svm, l2_clear_efer_svme);
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 
-	/* Unreachable, L1 should be shutdown */
-	GUEST_ASSERT(0);
+	GUEST_DONE();
 }
 
 static void l2_lmsle(void)
@@ -130,31 +134,10 @@ static void test_enumeration(void)
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
 
@@ -166,6 +149,32 @@ static void test_lmsle(bool lmsle_mbz)
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
@@ -248,7 +257,7 @@ int main(int argc, char *argv[])
 		test_clear_efer_svme();
 		test_lmsle(true);
 	} else {
-		ksft_test_result_skip("L2 clearing EFER.SVME shuts down L1\n");
+		ksft_test_result_skip("L2 clearing EFER.SVME gets #GP\n");
 		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=1\n");
 	}
 
-- 
2.56.0.257.gf7497c7d27-goog

