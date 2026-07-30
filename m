Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44A37C923
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439155; cv=none; b=dyxiATuTDBzz/A8e6OD/iyXVrwcP5XXfLUvAdd3gYbmEYX0XV0peDhNHlOupYeypuGDJquMIqhtvLpHdhvUKUEwWNvN86ZMPiqe8ZzCVfgF/3Yc2/bHp7M2kDnw5CY/0ZUjER/xs1Yq4vI3qlFO6iSaYLJP5ykOFbFTc9eaRVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439155; c=relaxed/simple;
	bh=/TJjnxpVpH8WmXNaVzrS2AeOgP3QdjHKxDY/CbjUI8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCXzMFroBfDJrhNU/gej99VhBnLvZcJgKksbD1cxo7srAtYZNia8/9TpP5VgKtNh2JtaVgcjslm+/tH6/OSx/gCg1/zLfUElPAJrvktiIw6eo1QbfP4z2qkPUiFDvrVi4Pwgeqlj2ZwIxJf6slcvdLFXyO21Y6KiJyxHCJYTytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guIjLlJI; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guIjLlJI"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so1285975ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439153; x=1786043953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=guIjLlJIg4kBP4bs845ZzzOaMxF10IkWENyYM1y7twphVDuUi5QsduM0R2SDv4ybYq
         Ur4jhtW/utyq+z6VImDEdD+8/f0cFDojylhGx8B7aeeIVsRQyPKBnVGJbVx6g/jKLAGx
         l4nfnz+h+tF8s+ZvNCl0fSsusGsj7n6eGdJxNzBzA08ezmkIpXDXzk7eIbhO7VJx9290
         mGkUaKkiDKDAAVgjILcC4FWe1Y+KPvwpsoaZhaQR45Fz+hRgMw7tiV/gj2ul04HdLvbY
         ByXrQGNDUMAJwIzFNHovsqm7X6LgdYlWeA+c6t4WamUZvgJ0cACACFN22I7L5YLNxDLA
         tRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439153; x=1786043953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=dfisNr/4WjRdgpSql9kTqUeabYipbGQOVBxh9otu5sOCXyVo1Wri2r0fdbq3sJsqlD
         JhAMDQ/ymlEcJf5HfluKNFPsLP8Jl7CZgHA/XvxzdOVWPm2O/UY1EKjyinZxJe+dNZq7
         aJ6VVpVx3vm3JPeqSyIpVS+xeNX+F1yO9fOB7uUtENqqyf5rQ/IVu42x9ESmIMiHGDy7
         L9TrMzxkuY0E2vGQHCiNB0JXZ5c7bS/UCfFVW74/b7qHUxNISKGu4O4RBx6TfZf1FFdN
         HiaHnpxBXTf+Ywqh1roR6EifI27WshNdYi4JL3NMRUrCWVmjQ+IvBDgjZpwY8+VFX4sy
         mrzA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5FLaRXbBP7wqOY1VURqfvClBv7qoJPN0v5yDdkWKTmGyttrjKAGKmFk28d6tYSJJ9FuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbofiNvmih9em5zeWUzxOd6IMa6kFBXdaUlQUbDnVCI41dT5ws
	8BIebXmOAyvrbYjvoSM+x8v9zfIIgyT2+HAnK1H9/LfeOtXf6Sr4lP/i9IGLCT4iG+NfaPQAg/R
	HXh8p8w==
X-Received: from pgbq26.prod.google.com ([2002:a63:5c1a:0:b0:c9a:8872:2a15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a09:b0:3c3:6cfb:4ed7
 with SMTP id adf61e73a8af0-3c90072ec64mr3396981637.30.1785439152961; Thu, 30
 Jul 2026 12:19:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 12:19:01 -0700
In-Reply-To: <20260730191908.2084803-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730191908.2084803-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: selftests: Extract picking of random CPU from
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

