Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037F283C9D
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310049; cv=none; b=sN47ZCgu3fALfHOJwy96+uH3xtOfndhZy7YmkVkc21DfynPgtRccb3GM/ozbg6iai8A0QuttKfitr/DaVjzKJ6xZ5yZ9ECPMtmnGp2s9dEq3rWTYMfSUK6zLW5N6uXVKW+BZDRETywW+Ujo7mG3ha32yyMbRqM28bWdQ0hcJt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310049; c=relaxed/simple;
	bh=/fkbGKcR+7Oi0MNRIDMSgWen89S/kkyrbYx8GFItGdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPf2E5E2VYcmAgk84WUfnIjM5j0tZ1ztiPhybdLYihuOyEQdD6HjdRFs7IsnCe1JP6/qucmaXeHcUDbSWRy4ovD9/lmubNn3EHekIUCdqC0CpmEbhYNTk8vedk8K8z+ywhySw4KbK2Ks3b3Z8sY4FSCEVc7pg1od/0OKIa1Ygw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIlcviuS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIlcviuS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8599ebec31so1478427a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310048; x=1781914848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TrhMXXAaZNAJ6oA/gSoBLS4pvmJFJO85iDVA23KYXYk=;
        b=AIlcviuS5u9SYu4Mb3+LYQBV1ulzzMq6iFiGprDt9Se4U6DPN1hUH1+egb97EY5qWG
         wD3dXn8yqOdXU6+mre6MFaLApnA4wLRxCktTJIvOEuNBBImwab0G9qwv3LymW9r4OKC0
         REFbdGNrzM6jp+DEiD7su/VwnCeIOF/S+lU/Yr1NiSej1zJE+vK4PeC2taN3gY07PqTF
         6DiO9pfGokrDZ88unAmUFkqR3jtsZLkTBv3Kl70XOAWWEY+ntBMjH/lpXRJQdXvEUIz3
         i2Vypk8kdt2nfkM7mjlV/RxNL4Y8vuDoAv4cvvOSCDkAhqeRqnLr0tV7g7AoE4X8GdUy
         poHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310048; x=1781914848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrhMXXAaZNAJ6oA/gSoBLS4pvmJFJO85iDVA23KYXYk=;
        b=l4W3xxrS2Jk5WQcaKyKp+7EcKTWg/fiblJXiMXviPtOneey2alREvva2mskr6rAJ6i
         Kr4W9X8n5ULbpbI1Wktq55TwhWeyYecnmKlj/ML+2h7xAUS1Azny/KnU1dWDGMJuRPOz
         ZPIEdu93o3s7uBPUCFzbtcPmomjV7UUmlY0H5YlOHkDU5BIiVYEWbwgxNsouNDgptWPb
         N+utJZJMbbv0TqG5GYBqFFJ4S8/DfG2UsaVO19mTBns3/X195T+G9i4tFdVaz5d/BoAP
         bSaai3/oJx9WMcC5KSstjnOUyQW9UwkuiRlAKd0+GIXjqhGoMLbuDFfu8jTCV86CLbNr
         Ubrg==
X-Forwarded-Encrypted: i=1; AFNElJ8FcjcKVSuuAQrVeIQyvrbgHI+DyyIXN20IjovluTpS62lif/osVScyWyHQKLExbyyRta0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxj1aiPoVc+lJZ2a5/QmOE+42y2F23pO8FdzKzuMo7n0NL0KZy
	SzRALEbpxFUn5Kv6IEllHXhSbQRZMXzYSqYq05rGXP6crGmsuwqy0S1MprJISdIQqg4rQPWmMPi
	jnA4GvQ==
X-Received: from pgbda9.prod.google.com ([2002:a05:6a02:2389:b0:c85:6307:e80c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11c:b0:398:77ae:8d8b
 with SMTP id adf61e73a8af0-3b783b7e9bbmr6211375637.10.1781310047646; Fri, 12
 Jun 2026 17:20:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:21 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-11-seanjc@google.com>
Subject: [PATCH v7 10/20] KVM: selftests: Add a helper to set proc IRQ
 affinity for IRQ test
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

Add a utility, proc_irq_set_smp_affinity(), to set the CPU affinity of a
Linux host IRQ via the proc filesystem.  Use smp_affinity_list instead of
smp_affinity to avoid having to convert the single CPU to a bitmask.

The helper will be used by the eventfd IRQ test to verify delivery of IRQs
when the affinity is randomized/modified.

Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: make the utility self-contained, drop "list", massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/proc_util.h |  2 ++
 tools/testing/selftests/kvm/lib/proc_util.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/proc_util.h b/tools/testing/selftests/kvm/include/proc_util.h
index 704839b6d7af..d1ddc967d11d 100644
--- a/tools/testing/selftests/kvm/include/proc_util.h
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -6,4 +6,6 @@
 
 unsigned int vfio_msix_to_host_irq(const char *vfio_device_bdf, int msix);
 
+void proc_irq_set_smp_affinity(unsigned int irq, int cpu);
+
 #endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
index 84d30f055a0a..3960b3841d63 100644
--- a/tools/testing/selftests/kvm/lib/proc_util.c
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -38,3 +38,17 @@ unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
 	return (unsigned int)irq;
 }
 
+void proc_irq_set_smp_affinity(unsigned int irq, int cpu)
+{
+	char path[PATH_MAX];
+	int r, fd;
+
+	snprintf(path, sizeof(path), "/proc/irq/%u/smp_affinity_list", irq);
+	fd = open(path, O_RDWR);
+	TEST_ASSERT(fd >= 0, "Failed to open %s", path);
+
+	r = dprintf(fd, "%d\n", cpu);
+	TEST_ASSERT(r > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, cpu);
+
+	kvm_close(fd);
+}
-- 
2.54.0.1136.gdb2ca164c4-goog

