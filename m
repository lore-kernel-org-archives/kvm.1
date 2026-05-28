Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E872F8E8E
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934285; cv=none; b=jEzq0U03LTEdvigF4ABCXkd7mHA7jb5pN6zfy1v8hk+nYpaJTtaxt7hTXyRa51cna0qIJICqeiN9qxKhnA510PsQ+dW3eyZz9kOyXSma2AKpJu4S7MXzQlDkuqQkWOMZcTN2iLSiairt8nIi/NcS+plvffAxm/TLCv6115f0Dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934285; c=relaxed/simple;
	bh=/GCiy/tm/G4ZkgCJka9bR/R4dNIgVXEFKdxC7V9ENoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k+6DRPFeTtEtc5Df3EuP7vXAgRzgKtpsMXL8xsuC9QPhkKKW5JchhyQspUYuGFemFo/m5qLsKKOaCT+mNj++i4Hhp2A/mOaIPkMtPQ/SId3lykW+Jt9k82qATpi7xuspiHhJEjbc9sPqsU9UdUccugOHm/U6THeL/ehQfvJcC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGgLJfK/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGgLJfK/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso314326a91.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779934283; x=1780539083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ESmq56Dk7+y1RBHyu7MRGF2Md3GxO/5V3RO0BbZs0wM=;
        b=pGgLJfK/P/uv1/pdjQdwQUcEEYbqakVIP4IontBSlsSxgA4wuHUk2YOpuDPAF6I0XR
         aPuIMWZEoTKnisSNjqIDa2vBWrxWlnFmieSvkoqq7Y8kQzw76ZdPEsi1tO1bgYL70rcI
         2BHJJTNXXhXXO3YaN45Zqek8HTvE8hKsyG5aod8vfdqEMZzm7Ithtoz+dpo/cP+h4qBw
         KvWx9RzsX/qS+AkX+2Ge0KgSJzNn7rXhms6GDN528h2upCRObVcIMAZBJ3eE5bA7PFuj
         XUkOkEIb7JVEl6DnY3iVpxCYzRweNuCsqoJkcO7d2B+btU/8B5h/8Od5k5yZSQGJdmTI
         5PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779934283; x=1780539083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESmq56Dk7+y1RBHyu7MRGF2Md3GxO/5V3RO0BbZs0wM=;
        b=H61pKr4gkmvwilNd3AAYvBvepsGAggQ7dEvDEvJ0031sRPmT8Z4IKDx/1LUAIAamjC
         tizt0rWF0Sy7GLxNqwNLuS0Zkvkm4QTcZoE5woh9C3NB+njquIXuQELQx2BRz5L87AZO
         LDyHkcr6/fJlmFOdXVGMX0ULg2qEzlbO0GS51/JWznh+gCKyz0ChfOftWc6ZCPNesGW2
         a6zbmbKY9nVNEqKMnNXu8OKOWBOXHHVQHYPFkQ7sGRdNbXXMyM0fKFoTwVGJrnjxa7B5
         TpOmCZZ84bZJF/8cFvQxRzqsWpYnYZKLiHsHKm/kCLQxsdDm+lavPBo3BpmPQCuGR3D/
         D4Wg==
X-Gm-Message-State: AOJu0YwMr/XxsrHHBv/c14WHcYGpw2P6hERpppaKma1keaR00gTxywXM
	tQrl7tzY+c0tTMIvbF+q1FEQ9ZRRQzUHgKkzTNaTzhTRSb/kMEToPxo1siTfEL+i/8JDjYfaGRF
	z6ix2qQ==
X-Received: from pjbiq3.prod.google.com ([2002:a17:90a:fb43:b0:369:1c01:7065])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3747:b0:36a:d419:9940
 with SMTP id 98e67ed59e1d1-36ad419e5f9mr9826485a91.27.1779934283194; Wed, 27
 May 2026 19:11:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 19:11:17 -0700
In-Reply-To: <20260528021117.107984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528021117.107984-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528021117.107984-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: selftests: Add guest_memfd regression test signed
 offset+size bug
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a regression (and proof-of-bug) testcase to ensure KVM rejects an
offset+size that would result in a negative value when computed as a signed
64-bit value.  KVM had a flaw where it would allow binding a memslot to a
guest_memfd instance even with a wildly out-of-range offset, if the offset
and size were both positive values, but the combined offset+size was
negative.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 246bb408ecc0..95a6ddfd8023 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -345,6 +345,16 @@ static void test_invalid_punch_hole(int fd, size_t total_size)
 	}
 }
 
+static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
+{
+	int r;
+
+	r = __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, size, 0,
+					 fd, 0x7ffffffffffff000ull);
+	TEST_ASSERT(r && errno == EINVAL,
+		    "Memslot with out-of-range offset+size should fail");
+}
+
 static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 						  u64 guest_memfd_flags)
 {
@@ -456,6 +466,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 	gmem_test(file_size, vm, flags);
 	gmem_test(fallocate, vm, flags);
 	gmem_test(invalid_punch_hole, vm, flags);
+	gmem_test_vm(invalid_binding, vm, flags);
 }
 
 static void test_guest_memfd(unsigned long vm_type)
-- 
2.54.0.794.g4f17f83d09-goog

