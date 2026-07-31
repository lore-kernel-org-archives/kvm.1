Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD21378825
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527785; cv=none; b=aJpH7p9ccpMBDPlseWC32dR3Ca5b2updpO0OxtO1Po01HQ4vxLQc7+mbR1a64E4f692JGhBnJGj/zV5SMzTRFQR9qSAlC9ms7pLsRGE492d5kdPCNejkaffgWBa1RXct2Dg6oBupDP4gYSFpGsjFUQPmQdQbWNZg6ywpLWe9GRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527785; c=relaxed/simple;
	bh=HRd/veKnQQoNlLPIk/S30A+ciXDQdelNm8xjt5JmDww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D48RSr3dLTs6asoCZ8hL7CORra+Y9XEKHNbqonpSQgP2aXp2xWo6jHA44+SxuHI4inKOUAEHn4xmxE67f0xT20Tf7/SvTA4TEPe/aq95xqtG4s6hJdt6Sp9d62p2o/FOy9jD5OFQ4CBlEBi7MeoPk4JyUy7nxprm4fuekfb0+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuwZ9nnC; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuwZ9nnC"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e048a801dso1918447b3a.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527781; x=1786132581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kus6EqucfaH9HPf637yAVY0TPxuMIU/5NctVRnWGiLw=;
        b=kuwZ9nnCBp25sDmsCpXeLCHdLl0kOHxkB9Sal3rgP72LpIhACzVXE2TrfC4JdTJwSf
         9olvjxqSFloYekIwd4w5h7/jC3exV8EHZlEdKELndFNSMJLsvICbVaya8DwIvDgWOphT
         BZ+8tvjNKAQBHVaT8YL5jdl2YugNHHt9qIRM0pXxrQGskmJfwz3PwIew74sQ0/mf6sv3
         rX40MgOZ/IvdSd0zFxgmY2bVyqqiVhq7y/G03mJXUFPqLylb6oYOlYLRKusCszUhXh5R
         LxNd7l+jVmKqs9v2vV3kbNHe6JDgRxo1Nm0kJdTWjZRsED+MVracJKf4+Tv5KoxI5dhX
         OVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527781; x=1786132581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kus6EqucfaH9HPf637yAVY0TPxuMIU/5NctVRnWGiLw=;
        b=X/5Le6FtX+FW5n7sTkpAGszoVAvc6sXYSpYe4QITmMiYra7axmMjrtW2vaFJyC8Zzl
         hXH7hyphoCFfkdSxJMp/AD73INR+BcLrciJPYDNWESmdvEGK2Rd6zS0G7UkI03tJW+Lh
         jcbwddWYGbNDcFGeTvkaPrPs8jbg4/GykfjkazmA2LteWfncZ/94a1NiaAM7dnm7Dtkn
         x7IYrTNoePFJJ2p5e/Q6mH0PtFVJ7tZrb9rrYTyXuKs4hGXPYMZmpSBj6eSVWpVCCQTU
         CiqMAd8qvGvS8kLdmfvllkOcmilSdKQY4sqVTY7toBbL2woYHPlTYTJCEIEqz4PxCjWz
         j6OA==
X-Forwarded-Encrypted: i=1; AHgh+RpMeJVN0WXVw783rl1J+8X09VwfkTWJ4GPCAHNW2zpr97uW42p1Uyuyyp92pVsWELXlnSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOku4wjRBIUcVdPizGgnIj3+nYg4C8NIrFDe3wy53IFwUHQi4
	Lb7YRCKJyb/12XI0xY6iykXB1RE0kwSz1ozkNVO/gksY5giJStwp/XBM53rmOf9ljZe+1SyReGW
	/gOFR4g==
X-Received: from pgiz17.prod.google.com ([2002:a63:c051:0:b0:c9f:dabd:440f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c95:b0:848:63fb:fd91
 with SMTP id d2e1a72fcca58-84ee490ac2fmr778630b3a.41.1785527781042; Fri, 31
 Jul 2026 12:56:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:04 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-5-seanjc@google.com>
Subject: [PATCH v3 04/12] KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
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

When pinning a task to a random CPU, return which CPU the task was pinned
to so that the caller can do things like avoid running other tasks on the
target CPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b39e713c30a4..61d72e1e7601 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1094,7 +1094,7 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
-void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
 
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3794575d2ca0..af2bad0553f9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -668,7 +668,7 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
-void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+int pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
 {
 	int target_idx;
 	int nr_cpus;
@@ -682,11 +682,12 @@ void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		if (CPU_ISSET(cpu, possible_cpus) && target_idx-- == 0) {
 			pin_task_to_cpu(task, cpu);
-			return;
+			return cpu;
 		}
 	}
 
 	TEST_FAIL("Failed to find random CPU in possible_cpus");
+	return -1;
 }
 
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
-- 
2.55.0.508.g3f0d502094-goog

