Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141367;
	b=GYlkKL3z9212bDLLcyO/EG7j/caW8WIzLBiWTP7i6HWSwurwuycXsRpPIWtehUmygh8+
	 /Ei4gA1aFmi0FMJX4UR0QthSuNVQVQVeqtilt7rm/9Ffu623SCBNFUvHXiWiFEcNMSi9+
	 MLG1sM2KGhetootDBwrth/82Pk/AXRZwMy0QZRZ1hh/GxEqPginzo/iktXzRkGbQW7CQm
	 UU/rMVhJmXI8+ixmINS3wdS3jjtoWWlJXUbuIqV/fQXjBEE+YJYoyE/MOzu/5qecESzyA
	 Mcx2HLdpLNZoVgYghSxN5/NIOwyXBIJ6WtcwFA5n4p5YfKPd832Bp6jXy9oIoTkE8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=MDAiMek2MBhrFqFzjIIabNRz2rV6IIbw6asreozihSA=;
	b=zNSi+SgoVWOlCAxxwxk6gFpfQPry2Wdgz1aRpJwqphar57LKspOhI1Uwx7oIyZW0zhUT
	 uH5MhyhuGQGzYPXO2iKltMZEZAjZoQ+duptbYRnJKB6qXmNPAL1V4jkPkrOW3MsM16B1g
	 w5HvhEeeZHMp6JH8a0Y+RyVAKgM9XBU91++/INtLGUoTgI9WakzmAE+G0rhp6tYNILXRH
	 iIusgkkHj3hvhi6O2BwY7pZb37GfR7XAOuTRJjYJ04lT4cl9IpnI+nxv2yQJKUTFJ1Ei3
	 GSYcEWX+ZBiCXyyEIIlnmS8munC42vxhgRZXRpXPTXqaDD8gGdHEzvQ8XKd3asQS5oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ixrOyOOH;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DB606A336
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773DB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ixrOyOOH
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so301614b3a.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141367; x=1793746167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MDAiMek2MBhrFqFzjIIabNRz2rV6IIbw6asreozihSA=;
        b=ixrOyOOHCdDEujl6kGi28CiFUnBzHCN280AGhBM34NnrNdWWDh0+Q0xM7jYx459pdF
         na/5cyvS1XpqxJUbnmGrjbgIE6De8xPRSO3pyeql502TNrk+m1jSIslCmOUPRMObuwoi
         oPm90OuRznGo2Du/PnI/wCm7A8igEfhr9e04Vm+RZ1V9tMZy/Y5Ah6pBWf5V7zI08pu4
         Ck+X4pMdcwugDgY6cnSlh8Dvr1IKEfNcc6RHEewE+obzjQZlZjmwmaOhmQotyaXyNAHi
         Zscf5ERUhzV4jWMhPh+qGNjmXo1QAHHrJBJUmQ4DMNSSdQSbUH169kU4SfN3wLm0be3h
         d3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141367; x=1793746167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDAiMek2MBhrFqFzjIIabNRz2rV6IIbw6asreozihSA=;
        b=VcO3FzcTqWhFcRqdjuKsmAk2owDt0MiUmK+J6KuW3MZpgaGpadQIXV5LDu5a+ZhVE9
         5f/dG+p/d2XLVEqpbF/as7ooC7tlDf0MnH7OLBS1+QXusOyELJNyz1Vmpimm4NgLUZEF
         60JGkIYbiEYH2epz73QFRcPW7E7c6BFGaScTuSeu7mF71RpouSqHq+ZOq/fuHjp553A8
         IEd3yFTcPH3S30vYm3CQ8pBtioQVtPIzPL3+QCcd++mQO8HzRlVdyyFUZ5LM2sU8QZO6
         +PdjWeRF2B5UOFnSejgvOfLrHXIbfRhsfqpFntVwD0htP9ZuWbH5RBV9XDObgQJsfykI
         7pVA==
X-Gm-Message-State: AFq9FYLJs1/w9n9I4sqqXMR7MeretsoCg3ff8nm3pvH0Yh7k5mWsHUiq
	OkDBhjGgRK3KlaEuq5X7+sVHaUbAk81Ovfowttae4m1M3hwJxjC9u2apHUcQ+Mtfi5m05kG9gOp
	kBDLtZQ==
X-Received: from pfop4.prod.google.com ([2002:a05:6a00:b44:b0:890:3943:6267])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6bdc:b0:3e1:e757:205e
 with SMTP id adf61e73a8af0-3e90234d14amr401818637.42.1793141366625; Tue, 27
 Oct 2026 15:49:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:14 -0700
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
Message-ID: <20261027224914.1574319-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: selftests: Expect failure when trying to set EFER
 that violates vCPU model
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Adjust the EFER.LMSLE testcases to expect failure, not success, when
attempting to stuff EFER.LMSLE=1 even when the guest CPUID model is
configured with EFER_LMSLE_MBZ enabled, i.e. when it should be impossible
to set EFER.LMSLE=1.  KVM's ABI is that userspace *must* set CPUID and
feature MSRs before restoring (or stuffing) vCPU state, i.e. before writing
normal MSRs.  The previous KVM behavior of allowing usersepace to stuff
garbage was a KVM bug (that has since been fixed).

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-182135@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
index fa9cfe8b1242..bdec7cdb3714 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
@@ -193,23 +193,20 @@ static void test_host_initiated_lmsle(void)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	u64 efer;
+	int r;
 
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
 
-	/*
-	 * EFER_LMSLE_MBZ is a guest CPUID consistency check, not a host
-	 * capability, i.e. must not be enforced against host-initiated writes,
-	 * so that userspace can set MSRs before it sets guest CPUID.
-	 */
 	efer = vcpu_get_msr(vcpu, MSR_EFER);
 	TEST_ASSERT(!(efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
 
-	vcpu_set_msr(vcpu, MSR_EFER, efer | EFER_LMSLE);
-	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_EFER), efer | EFER_LMSLE);
+	r = _vcpu_set_msr(vcpu, MSR_EFER, efer | EFER_LMSLE);
+	TEST_ASSERT_EQ(r, 0);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_EFER), efer);
 
 	kvm_vm_free(vm);
-	ksft_test_result_pass("Host-initiated EFER.LMSLE=1 is allowed\n");
+	ksft_test_result_pass("KVM_SET_MSRS rejects EFER.LMSLE=1 with EFER_LMSLE_MBZ\n");
 }
 
 static void test_sregs_lmsle(void)
@@ -222,11 +219,6 @@ static void test_sregs_lmsle(void)
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
 
-	/*
-	 * Unlike KVM_SET_MSRS, KVM_SET_SREGS runs the full set of guest CPUID
-	 * checks, i.e. rejects EFER.LMSLE even though it's host-initiated.
-	 */
-	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
 
 	sregs.efer |= EFER_LMSLE;
@@ -275,7 +267,7 @@ int main(int argc, char *argv[])
 		test_sregs_lmsle();
 	} else {
 		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=0\n");
-		ksft_test_result_skip("Host-initiated EFER.LMSLE=1 is allowed\n");
+		ksft_test_result_skip("KVM_SET_MSRS rejects EFER.LMSLE=1 with EFER_LMSLE_MBZ\n");
 		ksft_test_result_skip("KVM_SET_SREGS rejects EFER.LMSLE=1\n");
 	}
 
-- 
2.56.0.307.g5fe7bd680c-goog

