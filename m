Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8844C65B
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517588; cv=none; b=ZKt6EKxdCz4O7Q9e+FUKmqUn8gwNw0G500+IppOS/5iZCljGoPu48AHbN9oFi4UJAd/eK9cWsQtMH8kYAB2AuCOZiPuTBinTtD4JoX8W+Hm8fxE1h0hLsFmOq5ZZMOhxVO5F8ZMXXtI5O7Ouyui44BUcMT2oPpOnSRb1r12C620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517588; c=relaxed/simple;
	bh=O/HA18lT4V9uEUyS4D559RXemgyAqdlbEZKAn/jF9Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsIJ/uAxbM+v22OK0X6i/JEegj0MYOO/HNoVFimD6EnM+25t2cmmxTvYUPUsYff7YxhksjjrF5eU1uSDsmsQnRpjwIqNppXZ4vxiZlMqO+LbOSUq5rRYK9l8Wgzf8EaJ36ooB9QwCS9HY+otL98hWXMiKm88/rBL+xJsc73b/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kr95OI8i; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kr95OI8i"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso1525285b3a.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517587; x=1786122387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i3VSeeQ+TY0YcGO9FGsFVyU5sUODRimnbCxeJHurnMk=;
        b=Kr95OI8i6I+oJAzJ/+qc4GOrxGjRir/mM8Yb7bWXfpNXmvFQ1YHSX3oYkTVY1PGScV
         +U1+SMmdSZ0z94gnP+e1kHpY/TSW8RUmhmThxaSo1u28VH6BfVvuyAUuoj+Kkf5E1fUz
         Jk9F2nSuUvaAJFyyS3qJ4f8ShaGGQyIwb2Anvtow5b/3of00/AQRIHkRpcyvD27LLxJm
         cnTrWCO7Urnx1oBroYJspVzNJvMU235QluAaIL9FqRroSIk5b1m49nqGPnn+eFdM8rTt
         3hrhpWljxmIfBGgNNeGPRbBYlLmT7L7hiLPtYpnx+GArn3Zic2JAh7314nReBBgcBDxL
         ntMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517587; x=1786122387;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i3VSeeQ+TY0YcGO9FGsFVyU5sUODRimnbCxeJHurnMk=;
        b=sFaEltvzruVL/h1CsGk+n+QaGUiknwwbZzLTyVaYKbAzyjIujQrzZsBN8styx/mRXu
         abYsf8GLSoPOcz0ll3Mw5JarWSUMOswoZZQ8pU6ZtyvvkNpaxXHI6hk+itjXHJudoAQm
         KfLBIO9M7OZwFhzSXt0F2dnDlVPVVtFkFWK4CXMvZx6Z5mAJGKbLG/McZokxHjKTtMvh
         XnFe9G2cvv9dIxUy1araxXX4iYwDMmqLkSVpQzf9YiE1v2XuyWXpsspH3gM6puR+mpPw
         MxAGa2d8ZI8cDubcuDjDRJL7GyE+0DIkx/m6aClKNcS6PTyO67HiznsGA+NoB92qZb5m
         sotw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4PM/tuSaT9o3w7MrDG607p+XE3PoGuFP7UiArS1rQBL/Vdu1gOS3rJ7xSBMHDymh9XfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoux1uVJb5zUbZgqgveGBQqtpl5YA9tgxKgPk5SQv7VZxxBID
	C7gv1qf4ISxf8TQCSKKqreJoKWGvpiy4PPhS29CorKU71dmMRA5gfN8gNh+IRqb38+VcptEeHHI
	duYIxxg==
X-Received: from pfoc6.prod.google.com ([2002:aa7:8806:0:b0:847:9199:e06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac07:b0:84e:d46f:492a
 with SMTP id d2e1a72fcca58-84ee496c951mr366009b3a.70.1785517586327; Fri, 31
 Jul 2026 10:06:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:10 -0700
In-Reply-To: <20260731170619.2620845-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-4-seanjc@google.com>
Subject: [PATCH v2 03/12] KVM: selftests: Pre-set threads affinity in hardware
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
systems, this reduces the average runtime from ~10s to ~3.5s.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/hardware_disable_test.c  | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index f088b4af3ccc..d8288147b0a6 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -36,7 +36,9 @@ static void *run_vcpu(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct kvm_run *run = vcpu->run;
 
+#ifndef __USE_GNU
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
+#endif
 
 	vcpu_run(vcpu);
 
@@ -50,7 +52,9 @@ static void *sleeping_thread(void *arg)
 {
 	int fd;
 
+#ifndef __USE_GNU
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
 
+	pthread_attr_init(&attr);
+#ifdef __USE_GNU
+	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &threads_cpu_set);
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

