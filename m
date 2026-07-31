Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F6376BF2
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527783; cv=none; b=C2lU+aCg9jVrcqUTn10+N8Doe0mg8dn4kMkpRyNyoK2P/iAbYiC69vhcENPq0Vqk7tzsodJOeuQDNJWqP35kZVNdBzHbrS55NH12bQKuPo3cfqAEdTck6xm+qrcU7uSowE9iSLs8gOnuGypTo40ArfV6DzIbd9WfqjO/5N0theA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527783; c=relaxed/simple;
	bh=cFWa99Xo2ScAZGQfMvB0ds8Ya6pH9puVFr0S2RC2rBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WruUl6FY/nLr+tWh+dzTqy/e3ayyoxIcNAfgWCtZTaP6r7vPUlRoiU2Kx9N7oqC95n3AukWgag+6zRjhTEUfDqR+uO9OQa4Mzkl20hscy1+F9Uq4quycnvh/Nlwyf3JLqnlHg1eSRtftJwK187XHPUPm6xhEM3LpqM8rFwyjpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uqmhx+xd; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uqmhx+xd"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487eb67173so2706431b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527780; x=1786132580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QWTFo4fs/kSU6lr4ZzfhIdwS/NOVkYn2PmTaiQ/QINI=;
        b=Uqmhx+xde/OQk9o3ODE/bJ8K14+7evpgyTRwVq4pNNe1Ja3Va4Xr5mvEtJeeKLLiNb
         Q5HY382K7kNjMHGs/ozuMEMCIphJKTuN3HsY3i8Z7ouQptTJ7ss3jeuutxP2TLHMpN9w
         V8oRpkL8Amo8pBM69+OI1BvROvbVw/VaqpSvdsBntP/CLOFzonvxD668UTVe37xdtGMw
         LfXKmRJkdoHdExvcf4tCqD9YDzzTnr0fYmwmeZ8hkSOZB7dCKOHVzEtwgdoYU1f9NaAb
         czwJZYpuKRZavKQMNM/9s7JOE/qKtIuyHQk6+o42OxEmJgd89el6wGMqKEYR0LfaGcDW
         SnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527780; x=1786132580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWTFo4fs/kSU6lr4ZzfhIdwS/NOVkYn2PmTaiQ/QINI=;
        b=YssaxkuxcRczBXI/+Akoy/20Ly1a7008n9Da6pRnQE13ZkfoJUBk3Lhx26DGciaqZ3
         dprOHsPIxPcPxCqPrap+n4L1M4OQiIT6NzWYXCzASvnG6k0cbvW22zbA46fPbgskNheW
         aXtuBvL30u4mE0xhToiAtadHw3ffOI9gqPepitXhNi6ZZ3qU1QvRbbXbXftpx4URmCP6
         Ve7C17xYYLtkX1Z7GQc9nlWn6z99B/V6x0f06N73gJ1AR0KtHbS7N/g2vFQZjvyvk8gz
         tn/1fCarhzp71UjyN9eLQQ/sdzDD2HV5g71YJg6CG5ZB4h/jn3gtM60CUMYmTadWOGtU
         RQcw==
X-Forwarded-Encrypted: i=1; AHgh+Rrs6K1dexVg9wizkJTnJoR0R1guMWH+IIQpm2lnsfTgI2gNmWin1wQa4D5kkBHPN6M3Xqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZIB/e7HGNs+8FrRFt6flQ2zES0GAljv8BAjmohHsesvtEme5
	uusWoNUaY8zzXkFx+CD0GEM2v4QY7CF4+eZ3urHrAbTaMW5o6Di+FO0sfcf5SoysgVM1nSs2kDz
	d6x0xBg==
X-Received: from pgnp30.prod.google.com ([2002:a63:7f5e:0:b0:cbb:b782:6be1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13aa:b0:847:1d73:f753
 with SMTP id d2e1a72fcca58-84ee48a4d18mr834507b3a.45.1785527779971; Fri, 31
 Jul 2026 12:56:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:03 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-4-seanjc@google.com>
Subject: [PATCH v3 03/12] KVM: selftests: Pre-set threads affinity in hardware
 disable test when possible
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When building against a libc that provides pthread_attr_setaffinity_np(),
pre-set the grandchildren threads CPU affinity in the hardware disable test
to further reduce the perceived latency of pthread_create().  On large NUMA
systems, this reduces the average runtime from ~10s to ~5s.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/hardware_disable_test.c  | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index f088b4af3ccc..b4edeadfa3f4 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -36,7 +36,9 @@ static void *run_vcpu(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct kvm_run *run = vcpu->run;
 
+#ifndef _GNU_SOURCE
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
+#endif
 
 	vcpu_run(vcpu);
 
@@ -50,7 +52,9 @@ static void *sleeping_thread(void *arg)
 {
 	int fd;
 
+#ifndef _GNU_SOURCE
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
+#endif
 
 	while (true) {
 		fd = open("/dev/null", O_RDWR);
@@ -80,22 +84,28 @@ static inline void check_join(pthread_t thread, void **retval)
 static void run_test(u32 run)
 {
 	struct kvm_vcpu *vcpu;
+	pthread_attr_t attr;
 	struct kvm_vm *vm;
 	pthread_t threads[VCPU_NUM];
 	pthread_t throw_away;
 	void *b;
 	u32 i, j;
 
+	TEST_ASSERT_EQ(pthread_attr_init(&attr), 0);
+#ifdef _GNU_SOURCE
+	TEST_ASSERT_EQ(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &threads_cpu_set), 0);
+#endif
+
 	vm = vm_create(VCPU_NUM);
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
 	for (i = 0; i < VCPU_NUM; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
-		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
+		check_create_thread(&threads[i], &attr, run_vcpu, vcpu);
 
 		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
-			check_create_thread(&throw_away, NULL, sleeping_thread,
+			check_create_thread(&throw_away, &attr, sleeping_thread,
 					    (void *)NULL);
 		}
 	}
-- 
2.55.0.508.g3f0d502094-goog

