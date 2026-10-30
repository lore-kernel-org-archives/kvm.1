Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395652;
	b=mLWS1MgFUcsdPdB5MikjzB0xZgFVX0T0Xt8puw9P0tXFrdXRu+bnu76c8EwigfmpCidi
	 wAtUQBWLCBFIOcg/1E2P1mEIQZPpYW9a0VkymwLBGkbr96HRpg8gA3AFnjCmXoqZr8c4v
	 zoUOWjpwAI4/xyZByrTD27DO+jmeXg7dSOTYlH82sZU6A/SQXk0rjOLZdkOzXDXDq8a7J
	 +w36r/53CZXzCU3Dcd1lA+3xm4KCbMX6btdcFtcohBq29Q+6INv4D3DsRyO3kIGDRol4R
	 ml8VPZcaSueTw+/DgWNeS6eka4Dx6yqiGufzmbfjl4D1LLzlZhHDVSgBZCGK1t+7eXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HeDTQ03pI5t02YnngoAj9iApBg9D2x8DKS/xIEI0dis=;
	b=QtIy0sY+QNsyTeZJcbFu+nJ6LEwLPurgHvAOFUmJgoql8lKHlAR+YAEkfIeKlcklA15i
	 NSs/vXmcno90B9/aN/EI4xlpuhQKPoao9vag2cNtukRRuvAj7PQsf1IzTFE/JAt2pfQG4
	 3JtuMVUaL5r23GRCziwJDbeqaGCLFWu6sHjPhAtQ5+A838vXTU+/AwuHOHzoJDkeSbsWb
	 j1aLICJ6Hd6rPpXNEelNhxqfPueCb5eJ1EOh01ju59w59d1txiUH2HpzxbehEa59Sfmoj
	 JaZa9BEToyu21b5ZY2J2+OjOuypxtTelYWm8bapN4gj2ay72hHi2q5CbubjU/JlrPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ie/Eq36f";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68260A3832
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A68260A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ie/Eq36f
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e60770381cso10698615ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395652; x=1794000452; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HeDTQ03pI5t02YnngoAj9iApBg9D2x8DKS/xIEI0dis=;
        b=ie/Eq36frfd0MwfTmclBxyyEe+NmcRvXvhWkictGDGaIt3PktgSfosR4z+/Z7muSua
         awPcKuWT7GvSwGQC9vHk89bKeRLtln4FWadRQrvX5X3IW30vlx3JwqpL5gDCjZKkvzrF
         mr1SCvuhrpSSMiaMF5ExjJgGEOmZ9t40SgiVHajjOwHXXKP2kQ+Pq368O3mqL7aghvz8
         HVtgJ6IbxBtI20Zpg61phXo2Q0DnR/ItueL8q443OQoOt6zFESc/D2maI3XUsc5ekqQY
         6TxaOs/YerUGi3If49Uu+6LW14WzY6WpdaPI0pdupr/cxmAXoDapmG9L+1GV2TFTe773
         72Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395652; x=1794000452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeDTQ03pI5t02YnngoAj9iApBg9D2x8DKS/xIEI0dis=;
        b=vL8LAXKf7o51K51JMOYsRO2Tl0/OmLhXMJ98/WH6ALH7U3vt3d3BAW2R4yNYeI4nmz
         wIiXgkPrukpFlONA0fe6m7BXMJkUZoouoQaC0pDSvPLb6iBQ6/dmoKGnYOUZvyZ3qXNa
         gQMEU9HPveNpJbhf5sOhJbTCuYH/cOnl3POmydvX+Qbqe9Tsct05a+N8z+Q0x8G9UnR5
         MSNe/vcJ1jgR+i2NOIpQ7F53HGWNFv7o6L5FSYYdpm/oN0674iWfy3OBAJxhbCj2X5ye
         gjzKfZkZMd6BzuEGKAa4vCaEjHzeZ5A1Tqa5NC2miWIPkVMLdZQF5YSg/mgZBQu+erQG
         GIZQ==
X-Gm-Message-State: AFq9FYKAzloE8hboSu7HgLv8xh+9/I0GAhmUuFooNNK7w8y47pTD3r6M
	ra8k/voPKhGkRlvqVCHOHjuyLDdlzvum9W383QglOyPuvwQh7GPQav3BTEAQfdbttC+AQlVJiF0
	WSQ4BJg==
X-Received: from plgw5.prod.google.com ([2002:a17:902:e885:b0:2e8:486b:aed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:2e9:5829:9b48
 with SMTP id d9443c01a7336-2eb3649be66mr33001425ad.20.1793395651474; Fri, 30
 Oct 2026 14:27:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:21 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-8-seanjc@google.com>
Subject: [PATCH v3 7/7] KVM: selftests: Expect failure when trying to set EFER
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
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
index fa9cfe8b1242..141ef035a8c4 100644
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
@@ -222,10 +219,6 @@ static void test_sregs_lmsle(void)
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
 
-	/*
-	 * Unlike KVM_SET_MSRS, KVM_SET_SREGS runs the full set of guest CPUID
-	 * checks, i.e. rejects EFER.LMSLE even though it's host-initiated.
-	 */
 	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
 
@@ -275,7 +268,7 @@ int main(int argc, char *argv[])
 		test_sregs_lmsle();
 	} else {
 		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=0\n");
-		ksft_test_result_skip("Host-initiated EFER.LMSLE=1 is allowed\n");
+		ksft_test_result_skip("KVM_SET_MSRS rejects EFER.LMSLE=1 with EFER_LMSLE_MBZ\n");
 		ksft_test_result_skip("KVM_SET_SREGS rejects EFER.LMSLE=1\n");
 	}
 
-- 
2.56.0.385.gac671c819a-goog

