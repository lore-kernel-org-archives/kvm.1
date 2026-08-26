Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF83BE141
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760873; cv=none; b=cMUoxP8A7SZm16pKmdeUnu854hWO+F4/ufeSBCRbge2kb8rkFXEPCZznYiMVPEO/e63u64TAECP5+0wRSuJqRxABFogC74P2Lgl3sXSUV80gtSXLyh+F5vSb1GJ1eyE16wZn1tsB4nso3eScpMD9HYe9sZbZXiCXFM4PXqwtzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760873; c=relaxed/simple;
	bh=OjPQ87o/XYbSSJ8z7vq2Jx8w6lGwVsiHZH0tK9rImKQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lNW9781okFhvjEOJeNJWkVEKUvuPUbrzk70/TwS7jKV+ZCxiqscP/qJzO3yQ6dLrXaiB4bjhN1+1Yfhoh/leCsQ2gjWRt2jFpXqK/yJ7MQ1g1KivRaRU2Zly0kKmJIy3CjZZDrVO7UblwvmmGarpu826Uj47uNfFulFH5r4JhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8GL/XjS; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8GL/XjS"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7151120d6so11296485ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787760872; x=1788365672; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ShZteLuPmn0uTVSi15FkovctN2TksdELrCXWrc7DUg=;
        b=r8GL/XjSpBkCEak8vG6HuMppuFhSJz4/q7TYWlAg//CyjY4JWlJIzhswoW/Ebee7Ev
         tHkWg4rDKQDQ4wt4aOiQAFFxGJDmtVtygICSxsAcGA1hK5pqbwxzgVB49whHyN2uK7pR
         OHkqSEbM+fTdGWb5jpVgA3As39l3Z47ks6yqgQ4K38IIA5UfR4MpdNmHYkOK81l/LSt2
         qKIX77uf8Z4VYmJxpHHjsOCtIzTq2XAwKKzzn0290fixwpFyriQ6mzCB2HQFywiZ1B6i
         8/AVMoaOHxjXQFPrbbJ3+4vQIgTEOBKyD9KbuXiM+rys7OHIk/o5PCWz4TOgQ64/77N4
         +igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760872; x=1788365672;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ShZteLuPmn0uTVSi15FkovctN2TksdELrCXWrc7DUg=;
        b=CqEx4t4+9TGwkTdOvd8ijxSTZgKWb/V6+4nHUqvTDn3vHai9aVgrYrGUutAZciwrZU
         MokOsLU8H6DXcXPXYiZEetYPVfuEKoF2BW1/erP4zvO0KvXw6HccPyBaHiGHbt8fQ4Gz
         6SlLN/Up6Rq/P+jdGHSsWLoXlbqcjMXK6RKaU4zczmvzMXoMni5baPxj+GaiPl8MTpXa
         V9/heK13QTYSBIP6Oc27LzLDovm5CRz0UGiiJ+WBabR9QB9+A4oSfWKMemRmf1eM9xNG
         BYtbAUnmIKCM0n/qkGMRQ2JbXb4ifCeY/4hnGSIFISpyMM4UUKtxGPrLPK5tW6LVk/cD
         6oIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrN3IDtasJV1CrpwbPRuKDAlHNbJkn0xTwSgNvG8BbYH4IA0s3yn5wYxZNjlfjrEPL2Ujk=@vger.kernel.org
X-Gm-Message-State: AFuF++luY1XzfA7GtO59J33ixA4Ast37AIU0ezPnpcxev1qbMmBuDkwu
	PJfpGSBt0YBR/Rvz9pIxpPkQ9f+pLcFelOYIptwcvfkNepDddAtoyRafMR2yUygWj45nc0IhS9E
	Bz4poMA==
X-Received: from plht16.prod.google.com ([2002:a17:903:2f10:b0:2cc:e88e:423c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8f:b0:2d6:fb95:59f0
 with SMTP id d9443c01a7336-2d707a032a0mr130691815ad.3.1787760871467; Wed, 26
 Aug 2026 09:14:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:14:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826161430.714316-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect
 actual glibc
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use __GLIBC__ in the hardware disable test to detect when selftests are
being built/linked against glibc and thus pthread_attr_setaffinity_np() is
(hopefully) available.  As pointed out by Sashiko and Hisam, _GNU_SOURCE is
effectively a "request" macro to enable functionality, whereas __GLIBC__ is
an announcement of support and selftests' idiomatic way of guarding code
that's specific to glibc.

Fixes: 496779b54943 ("KVM: selftests: Pre-set threads affinity in hardware disable test when possible")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260731201140.5AF0C1F00AC4@smtp.kernel.org
Suggested-by: Hisam Mehboob <hisamshar@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 43a36ef3ead8..1c20892d6782 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -37,7 +37,7 @@ static void *run_vcpu(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct kvm_run *run = vcpu->run;
 
-#ifndef _GNU_SOURCE
+#ifndef __GLIBC__
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
 #endif
 
@@ -51,7 +51,7 @@ static void *sleeping_thread(void *arg)
 {
 	int fd;
 
-#ifndef _GNU_SOURCE
+#ifndef __GLIBC__
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
 #endif
 
@@ -71,7 +71,7 @@ static void run_test(u32 run)
 	u32 i, j;
 
 	TEST_ASSERT_EQ(pthread_attr_init(&attr), 0);
-#ifdef _GNU_SOURCE
+#ifdef __GLIBC__
 	TEST_ASSERT_EQ(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &threads_cpu_set), 0);
 #endif
 

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.860.g4b6b3295ed-goog

