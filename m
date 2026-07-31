Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662037DE8D
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527792; cv=none; b=S3/0X2C7yvCnUeLSdA5FasQcVtEcj7GTeR1dfXWxHsIPdCLZpRcK/7rC9UzLtYiZzZlNv6ewYUkKuaUfqRuZvBeqUDty+XhoH6LFwAHXbe1LijoJLjBRyMZAdddeHHW4QfjLaWvhD724GC8RaMsYx3N2JuFNxOqvtJfcnBkPPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527792; c=relaxed/simple;
	bh=D2cCds+Rmi8+J6lQPkFl0u/IOfzO+nxs2jcefDTat0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3oyYE0J31N1hEJHyrITNL7noR6D2btstMR60H0sgKyWSqf4g85nQ4RdFlEBBXMg07jAtoj6y/FdOzfNtybNmQ/pK7EI+CcQuFIyOo2MTU/yNLE28nHDImYZV+Ir+/MGyUkna9eIUqAAglW02vNk3WHxF5FBmmBdLR8MbeYiKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOO6NDKy; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOO6NDKy"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67b16217so2653082b3a.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527789; x=1786132589; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hu2nzxTULIrNid+T0wW8lXLrPPrctqAZSUyi9Ewmd1M=;
        b=TOO6NDKyp6oWalcayU/MGrBelVcHdGG8tFRh0F9qziCrRmo5S7yyHs6WehoE99e6iw
         UjlMTFFH7bQWAqjsKI4hZAIndMZ4EGIhpmitH88MoJ4jXSLQKAbE3L/NIeORSEqF02n5
         r7cU9aFoYsp0kMfhy/0Isqll8YrndrUtQj0Uy6ruVgFuBUds6B7nYx2lSi5dahrd2cCl
         zuvBy4I5ZQ8eOYq+yb6yAfjfGJx9YkzoOXGLpg7PoXH667eyZfdYhwFuVr/LrCv7JF1o
         yl+oG2uTj13fgUKpMIgmkIALfvtHrcKW1V1/rIsLopmKLa1mj59Yn4NWa5MWcJK5deWY
         3MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527789; x=1786132589;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hu2nzxTULIrNid+T0wW8lXLrPPrctqAZSUyi9Ewmd1M=;
        b=tSsWKp6YxmzmWkJcbbIeOSfOA/oiQ+cVggyYpulET0FzhBnHew6Y9cPISDz0u79RY7
         wFVuUm72ily06pkA6pmhQI5C/okBsliK0OItFNuSW+hkL4MJ9NygUmgKpIha+iumR/ku
         DqbEAtMHWDHz+QJSjHwJz+nslDtCUAdBqjmHsF9dXj5z1eM32eqUj+BSDNu5LOfqLfZp
         NFZYIb3DH580VQzMo/Wt2qEvijxgZwwCFxDlUSr000j13HHIsq8126TCPVnqHl5yzfmM
         9t8tavkha67I17E3GvZqZ6axfxtZ2NsYMDum7t5MSN9uwlEKi3DxFXbDNoJNtQRCr5YU
         5dww==
X-Forwarded-Encrypted: i=1; AHgh+RoVMlz8wp5vqWaY9zxcM/tx0k41Bv/+8UyUnnqhna+dGIL/zw7+qIlsWjIFj5HFyCrVVuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4sv/rQGyRO/ff8+OKeKOoYbCAERhhyftjjqEYoSin1EVDowq
	hkhi6AF1w8u+Wt/DhfJi2sQsQRScap87uCj0DFuNipxbhu6CCsEYoOYOTV5JAXK04NzDDMjG3Pi
	EeM9EKA==
X-Received: from pgii34.prod.google.com ([2002:a63:2222:0:b0:cbb:8eba:c0a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3399:b0:848:7a8a:48c4
 with SMTP id d2e1a72fcca58-84ee4953ae9mr806765b3a.40.1785527788955; Fri, 31
 Jul 2026 12:56:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:11 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-12-seanjc@google.com>
Subject: [PATCH v3 11/12] KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
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

Add and use KVM wrappers for pthread_{g,s}etaffinity_np() so that selftests
don't need to manually assert that the syscalls succeeded, and so that they
don't need to manually pass in sizeof(cpu_set_t) for the size.

Note, the steal time test didn't assert success, but the TEST_ASSERT() one
line later makes it quite clear the test relies on pthread_getaffinity_np()
succeeding.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_syscalls.h | 16 ++++++++++++++++
 tools/testing/selftests/kvm/steal_time.c         |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index c0657e54aee5..dc7461894aef 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -98,6 +98,22 @@ __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
 __KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 __KVM_SYSCALL_DEFINE(sched_setaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
+__KVM_SYSCALL_DEFINE(pthread_getaffinity_np, 3, pthread_t, thread,
+		     size_t, cpusetsize, cpu_set_t *, cpuset);
+__KVM_SYSCALL_DEFINE(pthread_setaffinity_np, 3, pthread_t, thread,
+		     size_t, cpusetsize, const cpu_set_t *, cpuset);
+
+static inline void kvm_pthread_getaffinity(pthread_t thread, cpu_set_t *cpuset)
+{
+	kvm_pthread_getaffinity_np(thread, sizeof(cpu_set_t), cpuset);
+}
+
+static inline void kvm_pthread_setaffinity(pthread_t thread,
+					   const cpu_set_t *cpuset)
+{
+	kvm_pthread_setaffinity_np(thread, sizeof(cpu_set_t), cpuset);
+}
+
 typedef void *(*pthread_fn_t)(void *);
 __KVM_SYSCALL_DEFINE(pthread_create, 4, pthread_t *, thread,
 		     const pthread_attr_t *, attr, pthread_fn_t, fn, void *, arg);
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 6cb1eb4c40c9..bc3c62b72c58 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -549,7 +549,7 @@ int main(int ac, char **av)
 		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
 		run_delay = get_run_delay();
 		kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
-		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
+		kvm_pthread_getaffinity(thread, &cpuset);
 		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
 			    "Worker failed to inherit parent's CPU affinity");
 
-- 
2.55.0.508.g3f0d502094-goog

