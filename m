Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02B450911
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517591; cv=none; b=T/VTY7CWkdH80bkVx6YTmDbWOZcTaMYWZjKpiZXDx27sI8nrbM92ev7Kq4Tnv6ZCKCoML/OMJBlV0tsHndwizgCTsdFjSsuvWPpEQGV4f0VVGpFhEJ1j3nM4cj2/nSUu0Z0/+4N0ouPaxzIXdNaQZAKSDSrB3jaYfO/xLjEUNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517591; c=relaxed/simple;
	bh=/TJjnxpVpH8WmXNaVzrS2AeOgP3QdjHKxDY/CbjUI8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfFch1iEzG9BhRgc69kfz2PvB2aypnyultNgfX7Ojz8hIwRD20fZkOrgDKEbynOHO2t9Zy9pplnOKFUz7RiRjFzxoOFJApbLjc9tvkU5wCs8Yhrs6jnHsikXrNbGFnxHqVSruUaThe1wsTpTQEmOEEFi16w3Cn1VLpEKqfll+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBpjwgH0; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBpjwgH0"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so1907120a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517589; x=1786122389; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=sBpjwgH0BJQ7t5AMeGgcn+r24SRarQbNJ44LgZWRwtAMWXyiYklgl99llQh5aLpw4/
         7XKZYN9V1Pqg1f60JIjfEPPAqL5flMF5/2FEBA2h6MkYU2gqXulCJUmx28N7C1gqPF0R
         1mLA4LQmfSm/YxvD2gz7dR/OfZ614j95o+KBuP6vKcsBeQIFEF9jZCcU6K1faGBOcpTT
         sPnZ+3jH0U5XHzhYyk/sfVwy4ZKbg5AMU/CWV7SWjG/tOkTUGHx47p5LDaMgLpr3wOy/
         QAXVnzErJKqsd0715jAfqpzQqvdKn3KjpZCUtpbIEGCuxYoFi8XjeooMD9bA3q/U4tXs
         dvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517589; x=1786122389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bs3K8CpV0aK6wpGyTBasGbTbkVQEzOsTzupfjJkDnT8=;
        b=obUIJaFtsp3dLsWwT75JKvm3C/GuNTrK4HYOCfB4lYsbSOm9N8M8VrHFbGTmWwhs/5
         jAX5WWcvXRZF+8ZEzyChoXpXeQJRBgx2JqZKJBmM5JpM8NcQO91ZdwLVJbsksjrf9zch
         Jb7Ya/r/4GzXOgj3TGZo1uvIofweFX4w8+BzfXtdKDzq+n3TA+VcpXRtlstOnHuZ41k9
         wr1J3f560fPXBrpXJ8Wrpi3dsLNXghR4zh4NrGoUXxpBkX5jT7VGIrFwyVT+CSjBhXD6
         kBPBzeUpoXrGKRC0JyXzpw3qqp8x53S95gTo7nUTySFJ6NKI1jnBntnp1srwB3CyRI9F
         R8Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqNFI+iB06a5Olro9aAksk8q+IAdah6gtVW2+agdQFQ45grhjzmZxpP7Ls1/t0Ybud/E1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIO7AHivJiCkx7SJJdCCi9ds0qq3zH2+3tfM02050wu6kdDZh
	la74frNtgpgU9Zd05MfRoh+OaDkhdPdKqghAtDKSZsGnvmDWt7F15cWeYJGKybC6TXicJ3WukdD
	pe/0caA==
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:384:7daf:f48a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5605:b0:37f:9ce3:ca95
 with SMTP id 98e67ed59e1d1-38fbc560e9amr564372a91.30.1785517588641; Fri, 31
 Jul 2026 10:06:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:12 -0700
In-Reply-To: <20260731170619.2620845-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-6-seanjc@google.com>
Subject: [PATCH v2 05/12] KVM: selftests: Extract picking of random CPU from
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

