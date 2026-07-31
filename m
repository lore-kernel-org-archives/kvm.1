Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDA35677B
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527780; cv=none; b=DDImCiuZ8kGUlzR51TTZRI1uvE6TbTE92dvmBLU9j7fEV1z46t2vMxl8Er79VbxqcrNBWzcg6U8ggcxKvlBe5MlX0ozSUFyeQrFkGzhQIs/sYDYYhJC50fiKMQlPUyl+f73w9NxDOe0tqH5rT716yFgL5PcnKhNhXL1XMoKuxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527780; c=relaxed/simple;
	bh=jIqegcMSdQEr3CCSBl7CEcF3KSy6gnzkLIXn/FjtTSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UAKCuyXBrA2KF1OMEpdtDVq5mTd4UsNazQ7jekkFyNfu1T1vPhBRC+3Bx5vh6GiTXogGko71kuqQsi9Zf8F5zMPFmeWvS/+PuRAKR2RQ4hVg7NcK/d071VQJq6d1pvo/eBgzj+7rj6VsGEl+AF2qIan4zo6id4+syVzPf4/yiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2dTgw0p; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2dTgw0p"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487eb67173so2706403b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527777; x=1786132577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I1vB8uido3pB5A8nVpiV1ZvPN5oqRESsQC5EjXRdj5A=;
        b=c2dTgw0p8niztkwbGXye8nUWLzWnMBWSNDf/p0zIhhtm5ztYqObq+BNk3M3vH23ibO
         TdPDd5FtN+x5EpV4k8VNMsNtgi1GmGDN0PeE45YhHbPcmxMlpUpH42cue3VBtu/VE9wr
         qG6G7WQ6nhhiUme3xaz5wQ/ljy92nOUeGbhvC6K+yioOnKw7bnNWYHXXlVxZqVORct1y
         2w/BaWC6eYw8M1gUz6/8f/gnaWPLZWwyrx5MrpNn9g8+IKumM3e0SPAumxsT5s+ofwt8
         MKt7ztF5NWc2D3G3a57xVplVYUkm7nPPUY4qU+SYQ/F77Nf9v0oc1YKYYhGTglm9f7tl
         0AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527777; x=1786132577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I1vB8uido3pB5A8nVpiV1ZvPN5oqRESsQC5EjXRdj5A=;
        b=PJ2L2JWh3LpsNrM4Dia6DXT31Tbi6hVyT508a9UR/H2sNT7OTOCWvyxluOkz5cdDQB
         uDK5gnbmQnmI6oNh6GyxSGSo8Og6Fcmlc/vhIw2srha1Rk6H+1K54YR+Akyn+oo2kWCS
         2dlCu/J0V63dLH3TGS2qMR9ueu5UtZsKpK3ozllcvba4LSGJkN9cHhu80/SyT0Qaj8vO
         Xxh7UkcKTet4E/Tec3oTM0tGJ3vIyCNvO4QA8Yc9kGfKeo7aujMDp38l77Cl46nYzPEm
         91zmRSh7o6uoHF0uwAvf6H8Du3mpGjywpF38Zm25+XV/OiqyPCd4I8BmTCP0iuXn8RDv
         FlDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9UdGMIAezhjNxkU/1nchBgV6DJgI+k5vO6eq6NEryH3VSEPeUBzGAXnsEv30JW9UUSpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUOVr1uCnrPdjgMbHq4wjNDlf/pMLwi4kedIhcqIkGaDuIjp1
	zJuWQQr1ZT5IO+ayM5YfFnOvgzWWjWsZxsKlmCebYbVcykeOF2L8T4X80WK0nfQSNP3FrhOejLG
	nGh9WEQ==
X-Received: from pfbi2-n1.prod.google.com ([2002:a05:6a00:a502:10b0:845:c4b8:9730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9a87:0:b0:848:2f73:8ffd
 with SMTP id d2e1a72fcca58-84ee49339bemr849272b3a.70.1785527777019; Fri, 31
 Jul 2026 12:56:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:01 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-2-seanjc@google.com>
Subject: [PATCH v3 01/12] KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
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

