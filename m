Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A829DB6E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538561; cv=none; b=frJelGLMuptincZX/Iyd+LNDCSX08xWye+rm50Yv18he1S76iNJavSVj3b9Vx1qgZZPkaCIrzDZPc3iW5ywy0IUMH/LlCwdgiuJsm4UgFLUSAn2F9WDlMzYjDpwSHITttup+IoSVoNQGIjsd7h+jcZIpBe5FJwctC8xECj7JE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538561; c=relaxed/simple;
	bh=Akg7uDy8uCv9ylirquc/PbBEBGK/tcTZW1e4HinXOvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uwEl18ctS9QWxOAzghyd0cNHHIbol7QHseRexkZa+gg4AgxIH7N1DLdn6PN9QSKSqP2fgjNIZsn/XvJBsVTfYU/NgODFhNiD1JaFhrcxSKvnfDHnzCysihtFMqh5LvkTnTE86cIpzn7y768JZppK1fLeXFKejdcIRC99vq849OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vdzp4pCK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vdzp4pCK"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so127886b3a.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538558; x=1781143358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuauJPm4nQ0ZwfBb9tD3L8vaie4FQapEWd+GJSZqVZo=;
        b=Vdzp4pCKrDmGD/4sCNVxBWaerDYv5Ds94hJ09oFIKS4wfgTm/jvq0q2r2T4s9U74Mo
         fyZJFxKbkz1KHPpSrMiWsRP9YNS9H/1Kgj6kW+wUvbd+/yV9xhmQjxjoT7ELV7ZNMkIF
         lm9PV4E7no2zKUeR6cNekms8YDxlWkrAzzRh0GsHavvKhqqAiH0rnfBIklHf3miA5lpc
         8BXSSoBM1zNEXWZc6IBbFRVwhDaqYUcMGKwnZePA/6D8JGrpyIVDwiBQ4zE2QtOmKd84
         Xsp+sxsGVM/ZSFrFa2fL4KM7qvyFFK3EfftILM2qB5SnHk6Gtvp/IU7tW7hZiGUd7tYU
         vFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538558; x=1781143358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuauJPm4nQ0ZwfBb9tD3L8vaie4FQapEWd+GJSZqVZo=;
        b=PP8xCfaoz6G+wGf7oCcQ+EVz7TsjnUwPM9EMlFRZ9VVc0GHts1o6jM4UfpuBFutQoo
         oL2NlrrbGtlirGbtXitci0J2wS3RnvRbKbk5bw4uezWqOj0W+ya+IRVxpZb1QiUAsN5R
         gEsDZMB03YXFgXvvuuIxugnfWNKjU0n9iuCVf40NYZ9Ur5LFFqiYQsMzp8xO10DO0Cw1
         nuZNk2lY8Ns4wcXCajS0BSfswUoc5YFuFBlq5dQDdo3b+KQsKu4JjOMmahL7Ho0OljnL
         0deFaFMSGYsFlMypCpDrdVelyikZd1Q8NLw7ueM/F9Vf/MecZY01ViXhwrEAjQaTqCWJ
         785Q==
X-Gm-Message-State: AOJu0YwzwfS5UNsvHtOz5DEbIlJYI/IkdLLa0YD5Rj6zHHuLwXf6mFc6
	N3/zKPLyXdr3EkfjhJePjk5M/+rj2UXVbWNcFSWJOdrR5QicpUWjAl62Lf/e2fcl8BSxL0bsCQD
	Q1EpwKvH4
X-Received: from pfbcz12.prod.google.com ([2002:aa7:930c:0:b0:82f:c134:e67c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d0:b0:842:5b63:610f
 with SMTP id d2e1a72fcca58-84284db9952mr5753760b3a.4.1780538557745; Wed, 03
 Jun 2026 19:02:37 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:30 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-9-jrhilke@google.com>
Subject: [PATCH v5 08/21] KVM: selftests: Add helpers to write proc IRQ
 affinity for IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce utility functions to open and write IRQ affinity settings
via the proc filesystem.

Specifically, add:
- open_proc_irq_smp_affinity_list() to open
  /proc/irq/<irq>/smp_affinity_list for writing.
- write_proc_irq_smp_affinity_list() to write a target CPU to the list.

These will be used a subsequent patch to set IRQ affinity in the KVM IRQ
test.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/include/proc_util.h |  2 ++
 tools/testing/selftests/kvm/lib/proc_util.c   | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/proc_util.h b/tools/testing/selftests/kvm/include/proc_util.h
index 704839b6d7af..e381c7818275 100644
--- a/tools/testing/selftests/kvm/include/proc_util.h
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -6,4 +6,6 @@
 
 unsigned int vfio_msix_to_host_irq(const char *vfio_device_bdf, int msix);
 
+FILE *open_proc_irq_smp_affinity_list(unsigned int irq);
+void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int irq_cpu);
 #endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
index 84d30f055a0a..938c90d94f4d 100644
--- a/tools/testing/selftests/kvm/lib/proc_util.c
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -38,3 +38,23 @@ unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
 	return (unsigned int)irq;
 }
 
+FILE *open_proc_irq_smp_affinity_list(unsigned int irq)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "/proc/irq/%u/smp_affinity_list", irq);
+	fp = fopen(path, "w");
+	TEST_ASSERT(fp, "fopen(%s) failed", path);
+
+	return fp;
+}
+
+void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int irq_cpu)
+{
+	int ret;
+
+	ret = fprintf(fp, "%d\n", irq_cpu);
+	TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, irq_cpu);
+	fflush(fp);
+}
-- 
2.54.0.1032.g2f8565e1d1-goog

