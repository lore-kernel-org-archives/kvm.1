Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223A4499BC
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517587; cv=none; b=h6w7qU83QPpIcmmOo8p0V8AW8ZtgqZGi0EpC423cZAifUVY9shzHXWOiU7kvBGMTCTac4pmPZzU/i5tMJaaxn+sCkz3etUrrzdvkkAeLNT9yOBRnv+gxYQzU1ArqcGoKvNMUImaZNTEXpuuI+5gNAD8AgeO7W6gyMyjHxAe2gjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517587; c=relaxed/simple;
	bh=jIqegcMSdQEr3CCSBl7CEcF3KSy6gnzkLIXn/FjtTSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+aU7vCF1luVZgHQuwmU/p8ViJG/ui69OlvwsBAY8mnrMflmXUBGkyO9yP16YVNwz4bsUfWuoHnceOtbsNmI4siR72izvoe/QKUi+j58ij9Ry27YVnyCEOajEx+0wk6mYuXxdVT6O5UvZYG0AaFsvRkVTJuTQldngr6IOA7Lp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXxAuc2S; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXxAuc2S"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1160127a91.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517584; x=1786122384; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I1vB8uido3pB5A8nVpiV1ZvPN5oqRESsQC5EjXRdj5A=;
        b=cXxAuc2S/7D69VI6vJIgQnhCdWLjdfikVF5/cx342pGq+U0SXYh/g9gf3wzoCKqrB3
         Kn42vL/XlpEqqbemM27MVpJy8d8qJB/oNgnpb4+hRDqxh0opEX0Efs5IqScjdBVQ0Wtl
         oPziXnmvEKFy66SgVxflCoy4FYAxRCVNutaGKc9pBG0qwMkvXnM+RMQXS/mZKmeB/bcM
         vWa19tkdrFTWbnVDrEv7/V4SHgtIylxZDsPzILyOBJnQSo8tyY0vyKJ+yNks6xiOB3L9
         ZtOtnQ6OUSX2hu/EHeK7wgNJpavk5r1uCiLjm695WMG48pLQXdvCpgd7tp1+xMfvPQGE
         U9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517584; x=1786122384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I1vB8uido3pB5A8nVpiV1ZvPN5oqRESsQC5EjXRdj5A=;
        b=Mb8oOEp4aoJItcfenEMLJ73wvZvYe3/aJwT7hpEaS5KaFB1Vs4s+pDaNR2pYmq7ugR
         QHOZnU4iGaSxO7wzLca0IqhnrG+brOU1NNPCYb3QfPCPBpHh3LyeSHz41oRbkQzEFjfR
         jjpeKe98I1NmXq5hm4KuQoPqbDTv+lyVjBwW62G/WrfzwNNr2shWsEPMJvY3lITzzF9u
         51ht5SCVNrhAaEFZ3s9TVS1wGgXnDRSsbv7vhcMnmA4pjJPlU9Bkt0FeFUrnVuzkoMAR
         aM4bnivE3GHHysD0gisAnTA/1egK4X8f29KayT1mPG8h1hX2g6Fj6epZc7cAj2G6Yoth
         6BJw==
X-Forwarded-Encrypted: i=1; AHgh+RpECy9tFT15I9s+/WwYVPtOvsjbuqWzeTJOk+uwvXGz1yXP5ZGnt/6PzZeIaixwUwd1uXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIcy0YUkbmZI8aACWm62xXqr5KCpAnNCTH4ME0BXwRNacZN9o
	SMpkOmlg0X8IdA2werPrLvOrulC8RwOhgZnepMJ5aKuY63q20N+Bdth7mhwXDs+EaAyVrbByqfR
	uD4lw0g==
X-Received: from pjso10.prod.google.com ([2002:a17:90a:c08a:b0:381:171e:961c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280a:b0:37f:c28a:de61
 with SMTP id 98e67ed59e1d1-38fbc45521dmr583105a91.17.1785517584041; Fri, 31
 Jul 2026 10:06:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:08 -0700
In-Reply-To: <20260731170619.2620845-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-2-seanjc@google.com>
Subject: [PATCH v2 01/12] KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
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

Add and use a KVM wrapper for sched_setaffinity() so that selftests don't
need to manually assert that the syscall succeeded.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_syscalls.h | 1 +
 tools/testing/selftests/kvm/rseq_test.c            | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index 5dae6143ddb0..01dca99009c2 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -95,6 +95,7 @@ __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, l
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
 __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
 __KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
+__KVM_SYSCALL_DEFINE(sched_setaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #define kvm_free_fd(fd)		\
 do {				\
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 557e393c223b..edcaf0fbe20c 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -75,7 +75,7 @@ static void *migration_worker(void *__rseq_tid)
 {
 	pid_t rseq_tid = (pid_t)(unsigned long)__rseq_tid;
 	cpu_set_t allowed_mask;
-	int r, i, cpu;
+	int i, cpu;
 
 	CPU_ZERO(&allowed_mask);
 
@@ -96,9 +96,7 @@ static void *migration_worker(void *__rseq_tid)
 		 * stable, i.e. while changing affinity is in-progress.
 		 */
 		smp_wmb();
-		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
-		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
-			    errno, strerror(errno));
+		kvm_sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
 		smp_wmb();
 		atomic_inc(&seq_cnt);
 
-- 
2.55.0.508.g3f0d502094-goog

