Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47D3B47F7
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439154; cv=none; b=Fr1JG7FeGbF2i9o2LaXmxUMP28vOpJMSzsdxhKDALM4BtPYCHqK24ept3XWdLXiMnRFQGWoADyfl4eVALdHA/dm9gDGWF5V4VspSr0QAgza1smBqa7qfEktwz7FBQzSeZMzR0rOLT3XYUFeAuV9uoVi29ZAo6XR+P6RLiZat67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439154; c=relaxed/simple;
	bh=HRd/veKnQQoNlLPIk/S30A+ciXDQdelNm8xjt5JmDww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LaWGIX2SEga+73xLFmZCj/gahBjJbMDUe4vOZeBAL97Ar3fTucDDW7FgtgQ+pTXb0Zo5KBHv1Sb7Yc4W2RUa8unJdakoBEI3Q68j0QU72i7yZUaOPzjQMEJRIoQwUzuewGCgCcj4PbdavTg398FBYFL7/BFGxjVW3LFiwM0Ksd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2mK/ahC; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2mK/ahC"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84eccf9d899so271591b3a.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439152; x=1786043952; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kus6EqucfaH9HPf637yAVY0TPxuMIU/5NctVRnWGiLw=;
        b=Y2mK/ahCY1KyhM9T9Jlo1qcvmE1q+53KFDmeyV2wok6k85xcetzpKjSZyfemJ6P+Km
         yUE2v/w4A3N/8jYnDJBsXHAxjhNLS01WGvOTVau4b0iKJ9tnT4kKFvi/sOfRlStKwrm/
         CgdmiNmrd9yGa7BjtXyQp894XmKoOZuDWUEZZIGgU2B5m7qNm+/1+aOGnJClXDO+THH9
         HU0dmWoh9tal0ECfSQdOvo3GtJOFjrbEyYsq6LBm8ogToWJZaUb+ryX4W7Eqmmbz54ww
         B0FwJUStm766gPAUvdd4LVYAdBHjIwsxen0JqeftIyNVX8UAPliN6K7Gj0QVqirhAdTr
         8d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439152; x=1786043952;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kus6EqucfaH9HPf637yAVY0TPxuMIU/5NctVRnWGiLw=;
        b=p4o927nLaSdEZk7K1SuO7xK4RxLPgqlzgkEgs8wT2Cqs6qOu40e0a4cT7F8u7S6ik6
         RbgWpI+xcxYNk+TRJzji9gV44pVOSTgFLf7F7IzPLGMrqTo6m7QQNQG2xWhH5Asawhvw
         VH23dDxCvURMRLL1dq7UcjsXulcJ7hjaKconhgDNSdcQP9bZSRlmLMwqrYEKfBngEZMP
         CJKeQr+A99z46PQwaLm+TYlc9SW7uvc/igbCwSHvDug4MDXaBikvYZBKrWy1fr60wQ5R
         XqA6d2W27AVU6oxhMlXeD6M3HmnbgoQhvZ2LpzxPuDZ2V6WtNOPLQTLf4EYBpxiwuGyq
         lw0w==
X-Forwarded-Encrypted: i=1; AHgh+RpCuBcM+3xDlxJfp1JTJhgJS1CBcPPpidwrlNFJ/yiCSVnlZVR3gt/6BNW3UFLPbpoBTmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21KYvu5UEeAcds6ThxfryQE7kYfb7ZwPDfGMvw7FPXrz1vyFD
	K/1FYZWXDfgTZvIBgomjAPwHyiGw3tjmSHM2PJ7DDxFSLKF0w58q4v0lvdXBukz4aZIPNg0yO3x
	vEdcA+w==
X-Received: from pfjd18.prod.google.com ([2002:a05:6a00:2452:b0:847:7599:7277])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3020:b0:846:8b21:6304
 with SMTP id d2e1a72fcca58-84ebc1fd6bemr3617195b3a.14.1785439151792; Thu, 30
 Jul 2026 12:19:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 12:19:00 -0700
In-Reply-To: <20260730191908.2084803-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730191908.2084803-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
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

