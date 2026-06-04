Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03623002DD
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538561; cv=none; b=IRuGqiCUG15HGNx5Uwe3SI6hsnSxZkG0qz2lhdGNf586C3eczaQu5BkhVI5cf3UlxZ2cB7AhZUlfMzlbBbigQeKvZsxmCd6are2P8MMNkCWKycAAYzhgPP3CIWEyP1nm1qdvuBm3cc0HkuERvxxTZTlhVB48I7193XstTqoxlb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538561; c=relaxed/simple;
	bh=357VVeIrXR6dbg7uGxJiw0VSZk3D5cAAKZ5UNFn6RG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IyRCe78seY5WG2OniQpT/qLZi+3O/YosgW9QAF1HydKhhm+RMRuoDCCLKMURkk4uY0rCaJBHeLDMHHz2N+nbeVPaoiIEA8lxzgYUQ9SqZg3v2YyaW0DnMF3W59dJ5r7KoSZK3PsSNah+fmSPy14RlaVoomNhHHj5pgw1NZP3H9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIWLJMmI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIWLJMmI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf55c3f44aso10689875ad.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538559; x=1781143359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VA79vH7fXggfPqq1ZwFhX0JPUzy2i6GiJJnFBzPgRwU=;
        b=nIWLJMmIC5tWUwSZIHIFaVYhlT/07084uDqeFSszWI+tbkr9Rsc0ghNySbZ5Fi0b7s
         F+dXWKJqXJFNVF5piV9FvEYXSi5i6koegBRlIzjyYUb+HO5+0cNNnNo7CseEFmgF90zf
         Yjx6lWgdwUlNI0cSTsITN3q2/mIek/kl5TLCaevFCcIj8xkeS+NdgCqQruMPgdQljv2y
         4/Cclobhd9DpqerrHJXmdXkPRoCorpevT6npPDNPHqYkgeNM5+hvj5A2hlEoPxWh5Jxi
         Y03Nn8ry7ThPe6LcqcWSXKEz8sSnDTzVPKpEjIZB9DIRdSM8Iw0JRXPZMPE/Iw8HzPrU
         Ph7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538559; x=1781143359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA79vH7fXggfPqq1ZwFhX0JPUzy2i6GiJJnFBzPgRwU=;
        b=OPy1PC38XUvhPV6f84lMwKImvHwiZfDuAjQxUuILimiMcHkc+zsvs4UJ9cYLzMJqE4
         wgA1MyAfCkbuhllfuUogXtcQQas7jMvVSr4669TYxqMlrCPPjBd/auKGKvVy0hZ1R24k
         Q70GxqN7Ok9rhvi6tv1Dxnv420//UkhCa5m/9ywnIPWLCqk5cExySZTRWdrFPYiiUQEP
         ICqUFdypkxerrJEH2gm8XZcoTevJMTXwjVxmkeXK5Z0k1Zyexcf7KYxWLS1T1v3gpVvv
         i5xdUJbvqQxKgxXdj9cqgbwxcKf5++7ppSllwUAGXenahHYlLk4BGA/BxFuhQCnlbnk6
         tesA==
X-Gm-Message-State: AOJu0Yx5wB9SIVzIz+alWUHfbnxqo6tY6F01kMbprZucRq2CQj7wI5g+
	iu20edYY0NVE4Yb9PZlVPG6yCgFby/GJJvX9QNTe/KKFfnHgqqQnP0RiI2G7BR9h+MVXBTt6pPS
	Us847Xvju
X-Received: from plbkp13.prod.google.com ([2002:a17:903:280d:b0:2b7:c361:c75c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:820e:b0:2c0:a858:8128
 with SMTP id d9443c01a7336-2c197b1805fmr9970625ad.1.1780538558643; Wed, 03
 Jun 2026 19:02:38 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:31 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-10-jrhilke@google.com>
Subject: [PATCH v5 09/21] KVM: selftests: Add helpers to print proc IRQ
 affinity for IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce utility functions to print IRQ affinity settings (smp_affinity
and effective_affinity) via the proc filesystem.

Specifically, add:
- print_proc_irq_smp_affinity() and print_proc_irq_effective_affinity()
  to print the current affinity states.

These helpers will be used in subsequent patches to print affinity
settings for debugging in the KVM IRQ test when timeouts occur.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/include/proc_util.h |  4 +++
 tools/testing/selftests/kvm/lib/proc_util.c   | 30 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/proc_util.h b/tools/testing/selftests/kvm/include/proc_util.h
index e381c7818275..e0e8f29c570c 100644
--- a/tools/testing/selftests/kvm/include/proc_util.h
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -8,4 +8,8 @@ unsigned int vfio_msix_to_host_irq(const char *vfio_device_bdf, int msix);
 
 FILE *open_proc_irq_smp_affinity_list(unsigned int irq);
 void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int irq_cpu);
+
+void print_proc_irq_smp_affinity(unsigned int irq);
+void print_proc_irq_effective_affinity(unsigned int irq);
+
 #endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
index 938c90d94f4d..24a8de92e229 100644
--- a/tools/testing/selftests/kvm/lib/proc_util.c
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -58,3 +58,33 @@ void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int irq_cpu)
 	TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, irq_cpu);
 	fflush(fp);
 }
+
+static void print_proc_irq_file(unsigned int irq, const char *file)
+{
+	char path[PATH_MAX];
+	char buf[256];
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "/proc/irq/%u/%s", irq, file);
+	fp = fopen(path, "r");
+	if (!fp) {
+		printf("  Failed to open %s\n", path);
+		return;
+	}
+
+	if (fgets(buf, sizeof(buf), fp)) {
+		buf[strcspn(buf, "\n")] = 0;
+		printf("  %s: %s\n", path, buf);
+	}
+	fclose(fp);
+}
+
+void print_proc_irq_smp_affinity(unsigned int irq)
+{
+	print_proc_irq_file(irq, "smp_affinity");
+}
+
+void print_proc_irq_effective_affinity(unsigned int irq)
+{
+	print_proc_irq_file(irq, "effective_affinity");
+}
-- 
2.54.0.1032.g2f8565e1d1-goog

