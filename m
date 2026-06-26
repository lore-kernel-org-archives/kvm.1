Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E23C3C16
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509763; cv=none; b=ENzRZ20zJ6j0HwktMZwyKVgxp9vH9gIJIUbuJOqBSz3IwR60Ez8chnq0VGsITOIZ41ZTKM637JM//Avrc+10vZjqnDwxh8sY5ZryDqTUDuSZ2JBdAjPeQRKTyZl6hc/G4tO8rEeaUhPBJXNBs3d+uURmEV62Z/wp+4JaQnmPSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509763; c=relaxed/simple;
	bh=quYP307cCmyP2CKKWA+CHAZMV/Jy7UY2hC7jDhiWYJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a9d+WNECz99It+I/j/hnAyFT4hkdI6VGsFTj8UrHCYrn2G9Qu7ym9AH3fvxpHcDP0izPgMSnfajofb5aiZhr1esYGgaPJOtNHchmcPv4AFukgznJjT1XGlM1zj5+bQdyol5vllAQX+i0LSxD+QhF9UEvly03qRVMRmnrZ+DKIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NR1jdhk2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR1jdhk2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845bae98cdcso1117458b3a.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509757; x=1783114557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rZu3Cjc6CZtki/JQXUzTgacdlapy8vtMh25cja8rCSM=;
        b=NR1jdhk2enjuw2zo653WmHWkZd9/OiVLYnhzEfQiNlTXJoxApYwhYGO7Sdh1+QoT4n
         j1RJNr990yA2lGmaE/bt2Q+PW6ICglibOMbXEYyE552N8kPJRfvovJnY3HZ1UtN5zvZf
         zU0hvIDQWCrx7seBVeFWpxdx3aeB+uDG8AZulgW0OX3WrfZHOm4R2BM5GdMaMaBMWpjY
         S3BWgutVam9wRoJrvhS46C/kkJeXOHPxjCAdMx/Wgik007Zc+VKQeDxDTCc84BoiMVHM
         7yDZwsWA6I/bTw6hl9tSW7WYJmJmPwgbFOsSehh8dM+On5GZvUf/m+yYEZyBzfYNfNl4
         roTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509757; x=1783114557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZu3Cjc6CZtki/JQXUzTgacdlapy8vtMh25cja8rCSM=;
        b=IqO66gHR/pXSTG0UXg7DYrkrkMTXEfdiEPzraV4ZtsSgYY1xkNX05nBcwPTfD4b5XI
         Nw5pRFvLePRLjruy7bfbnk+deeIwSF+ppFxI1LOaSKEXqvWBKlcwOaHJqie+WAq/2Hjd
         t7wJcqyys0b2NtybtLaroL1Lce0Loer1ZNfuqQb4+HPRIXzI0y57w61wPn+YTgX8M9sk
         9AqYhfWbl0gGmcGadFdyIjouOZ7xRkfyvs2NOAJvIJEIgjtUfdtFbaABnQPBLOystUjz
         g8EQdUK3+YgO9fhwxtbmCQTCvAV1tt+KwkEe9bIsQs5/XdyPkzBaZ91LrkibYpgw8eai
         UdRg==
X-Forwarded-Encrypted: i=1; AHgh+RpsENRZU6Rw4wVR0wZiULVqP8tPKPi37JS/DGsQNm5WBRM3qsOTVAa+X9MMv+I/PQ7ab+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4DQBwS7dRU1hy4045YQlIiv0ihhFHDcKC1y1Y8SblPYTDGL7
	h5XmYZ/TYdlBHYCVKrRZjEtSasd7bojc0f5h2GSgZXif+Gunlc4I2eXoZR6qe3jWl/bhne4BdyG
	jPTXo+Q==
X-Received: from pfbgi11.prod.google.com ([2002:a05:6a00:63cb:b0:845:ba3d:923a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2987:b0:845:d274:bf90
 with SMTP id d2e1a72fcca58-845d274e56dmr1605456b3a.57.1782509756871; Fri, 26
 Jun 2026 14:35:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:30 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-18-seanjc@google.com>
Subject: [PATCH v8 17/20] KVM: selftests: Add a utility to pin a task to a
 random CPU, given a CPU set
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Add a helper function, pin_task_to_random_cpu(), to pin a task to a random
CPU from a given cpu_set_t.

This helper will be used eventfd IRQ test to migrate vCPUs to random pCPUs,
to stress host-side interrupt routing and delivery.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c1f588154398..b39e713c30a4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1094,6 +1094,8 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
 	int cpu = sched_getcpu();
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6a0ee033fdef..3794575d2ca0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -668,6 +668,27 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+{
+	int target_idx;
+	int nr_cpus;
+	int cpu;
+
+	nr_cpus = CPU_COUNT(possible_cpus);
+	TEST_ASSERT(nr_cpus > 0, "No CPUs available in possible_cpus");
+
+	target_idx = kvm_random_u64(&kvm_rng) % nr_cpus;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, possible_cpus) && target_idx-- == 0) {
+			pin_task_to_cpu(task, cpu);
+			return;
+		}
+	}
+
+	TEST_FAIL("Failed to find random CPU in possible_cpus");
+}
+
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 			    int nr_vcpus)
 {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

