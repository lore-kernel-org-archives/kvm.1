Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86313793B0
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527786; cv=none; b=YwCCagsXPy0R192TzXezqRE4Ze2EfRzqDp/7HliYFZ2aVEzq8GErQ4S44fPcePD3ihg8xIqdNOTg2XS1jaKsxOHvNXitUJ7Ws0Z4W+KoWlv1xvmSAV/dhp6O7aJoCGvKc3w8UhayttrzcVH/MC/fAXsohy1ECOcOw6V91g9F0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527786; c=relaxed/simple;
	bh=/TJjnxpVpH8WmXNaVzrS2AeOgP3QdjHKxDY/CbjUI8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XN9hqaT3wOLZ1NTI3wwoJD28qapUBc/U9iX5PIyRibNhvY1vVBWcgOllXR+0YbJJ190QXYUSDwtOkJQYLWantsBrcaRq8ZV0esaCgbFon4QyMlvOcwRF3d0TdKiIsIDeoUqo5cAKTk03d5pq2dJ9lLw2XcY02WLY6ZwA0cz9dyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6RMoV8q; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6RMoV8q"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1720613b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527782; x=1786132582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=T6RMoV8qn0c/W+cns8wL6/JmEkZz8g4PGOvKgBvQPCtLtXCPAQQ0lp0EmyV9gNXjja
         xNziTiLLs0oRmyQsWvrpMWUkyHbswLF4yPvk4EwBahNXyo8fHvX18Kom7+i7bGAz4yvn
         TTUS72naIHfsLxKG7p5+PRIZxCZG0Lms/rvlebP1sVjI/NYUQpLjiGhDb1lXfRCNIK1e
         RusdEF5k/2OAqgjbj5n4Vo2dLAbS20ZjN4BIZh5LXcYd4cmHyRjWKVlXdhIxXf9Lwvj4
         3kxKeJWZpPFe8aersI39m2Zywdt+uAqKEPgVBciT2c7n88o+2sJ3mRsTigKL7u5KDaCB
         TFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527782; x=1786132582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=VqFRwRNKRC54byFdwuF2ydw8JhDEXmesOrF2I1t/p+8z2jlaEfg4pCUXGE2rCkgl9E
         pOgLryTuaTayc4STJ1kAxzHpJi5Bwk+b+wkrmkh1ZR9fXE6MpFOW5VUyMw4z1G/hgvBV
         2XFQbCnby1Qm47e9mmjp8/r5Lw67lu4yvRMMP1ZEzHEiLRejqhEcoIfUlpi7bk0RvYeZ
         gTPVcXZ3gfWQ7i8u+eigpKwCyk0OvWF351OCjqF9kr0+mmtD/4zKsn4uGbrR0enVNIYs
         HPrHAAcml9UiD3VR6UcvePJoenrSKeY4fLgLg7z2rP3rrmkz2wUpmwPHQjUTi3VR3H/X
         QWLA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4yyrBztrgmYq9GTpaIIi5nhcCcz09ZTh3nzbGsfq21962KBgYriXDrdHgH1qB14Aka2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesxACsw+ge2YMeoVgeggyIwBKxHxm8ZA9vczDfI83S/aTzPLK
	D1odfnutVfUw6LaRdOcszfTC1GYH9zpvk+X1ULmd9Vrdf9AwqNQx4PPfsoU7N2IS8h9HtvG+9aQ
	keXZAqw==
X-Received: from pfh33.prod.google.com ([2002:a05:6a00:12e1:b0:848:46c7:cfe2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f04:b0:84e:d46f:4921
 with SMTP id d2e1a72fcca58-84ee4915b80mr752468b3a.66.1785527782134; Fri, 31
 Jul 2026 12:56:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:05 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-6-seanjc@google.com>
Subject: [PATCH v3 05/12] KVM: selftests: Extract picking of random CPU from
 cpu_set_t to separate API
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

Extract kvm_pick_random_cpu() out of pin_task_to_random_cpu() so that tests
can choose a random CPU without having to immediately pin a task to that
CPU.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 11 ++++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c     |  7 ++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 61d72e1e7601..5a7a455b5387 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1084,6 +1084,8 @@ struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
 
 void kvm_set_files_rlimit(u32 nr_vcpus);
 
+int kvm_pick_random_cpu(cpu_set_t *possible_cpus);
+
 int __pin_task_to_cpu(pthread_t task, int cpu);
 
 static inline void pin_task_to_cpu(pthread_t task, int cpu)
@@ -1094,7 +1096,14 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
-int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+static inline int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+{
+	int cpu;
+
+	cpu = kvm_pick_random_cpu(possible_cpus);
+	pin_task_to_cpu(task, cpu);
+	return cpu;
+}
 
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index af2bad0553f9..9ddc047d5c27 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -668,7 +668,7 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
-int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+int kvm_pick_random_cpu(cpu_set_t *possible_cpus)
 {
 	int target_idx;
 	int nr_cpus;
@@ -680,12 +680,9 @@ int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
 	target_idx = kvm_random_u64(&kvm_rng) % nr_cpus;
 
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
-		if (CPU_ISSET(cpu, possible_cpus) && target_idx-- == 0) {
-			pin_task_to_cpu(task, cpu);
+		if (CPU_ISSET(cpu, possible_cpus) && target_idx-- == 0)
 			return cpu;
-		}
 	}
-
 	TEST_FAIL("Failed to find random CPU in possible_cpus");
 	return -1;
 }
-- 
2.55.0.508.g3f0d502094-goog

