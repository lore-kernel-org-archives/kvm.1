Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64440352026
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469354; cv=none; b=hH+fAJlMyrT2d9RoCLbeux+ug9dnoQB0dLm0rejaOlxeS22Zwf/lxLcw2407oNuNv7q5GcZMHyMHz6Mz7fCVtgITEgyGpmN1608EBsTlXhpVFahchiyC300G7cD/CongAVO17kLq9Go/Fragl52rQ9sKVRnveCAhbamdJg7312s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469354; c=relaxed/simple;
	bh=n+Ek3Ws8wWLqyf1VtzuVpf5o4IGoK6S7xtRI88xbYMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iyj/CK5kXGDIJ983aNKHf3cykSEkuIBPZ9CtmWwgLBm2YVjnUlJnUL0z2YrwlDQtrh05pCVccUbunTAxIhZwDZ2c0clEY8mLQyKC6nweU2Neh5GTBNC0CuXk5Q5dS9s78hRO7QGQ9mSKAVIr7cknHprl3F5kolHEX00wS9G5dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWcEXjZv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWcEXjZv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd1dbcccf6so126631055ad.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779469352; x=1780074152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVQTo/y4OvxKNW+AzFT5BpwwAI18QisLaW74bb9QAcc=;
        b=RWcEXjZvOkqyUhF0gbWeBiTrSp1IzvTgBYGXxEooJEPeZDYeOsJVI7ORzdMh89UGnU
         /m7i5SCqg8/NPQZqliV1+zkMTlkbyXXsKMQPg7CSByeux3lpZvo5WNixySofAezPnb4E
         AAlGwp1WrMwdT11Z8cD3SlzFYLsViVeO/hgNO6CvkxK5W/CdB4hPhXYoOmRbPI1uTImz
         ys6JE7VKRoegi69j4e+SNDuN7XHERKSb35jhqmsFh5Blrr0JUvQzVhmS7TG4HrYfACDk
         rSf944sxRwdtU0NfOC/b+3bYL7cCZfQOOJm2brHajtKjxjTxOHjbpTmWu4vyTx1bjaMA
         2zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779469352; x=1780074152;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVQTo/y4OvxKNW+AzFT5BpwwAI18QisLaW74bb9QAcc=;
        b=bOaFxsfqCv88Bc+3PB0JyTPXVF6UsYPq/Yv6X2QmwIaMKWn7tqNtayXMid+54tQInq
         ztk2E0qt8Raswe7awKDY+7MA9iQ6jU5gAGDZWhBxDjG7Fih+ss2V3bf4oK3P0PmTSkrw
         YgsjhZdkhsWK3f0Gq00qSjDHqWwBJ2A5KUPymcXQsLQJ0QEaQvU4C1FsHftsYootEKnZ
         3FwIisWKc4DYYORkBYJx6DqV9e9Iw6tF9vWodhidV+7f3/Rz67VFTADZ8vvhcQy2+lJ8
         86MEN+l07TGkd4UJG9j4NelPiMCGnW/RLv/hL778ghXbOSp6ovLHMmQzpbdey36jj1QD
         mVeg==
X-Gm-Message-State: AOJu0YyThG+8Vt3Fh6OO1wehHYz6n1oqmpLlD4Quh4B0nWptse41ucV7
	6rNX4GvQ0S9zUREYMQ8AJknjwbVRzh8uG1TnoLauHa2oh9lFV/Q4/vpf2QnGruGpSHmEHuGqH/n
	lTsl9fQ==
X-Received: from pjqh12.prod.google.com ([2002:a17:90a:a88c:b0:365:ee77:7689])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b82:b0:368:1088:bb1d
 with SMTP id 98e67ed59e1d1-36a677c5eb0mr4585071a91.15.1779469352254; Fri, 22
 May 2026 10:02:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:02:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522170230.3518669-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Randomize dirty_log_test's delay before
 reaping the bitmap
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Wu Fei <atwufei@163.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

In the dirty log test, randomize the delay before the initial call to get
the dirty log bitmap for a given iteration, so that the amount of memory
dirtied by the guest varies from iteration to iteration, and so that the
user can effectively control the duration (by increasing the interval).

Always waiting 1ms effectively hides a KVM RISC-V bug as the test reaps the
dirty bitmap before the guest has a chance to trigger the problematic flow
in KVM.

Reported-by: Wu Fei <wu.fei9@sanechips.com.cn>
Closes: https://lore.kernel.org/all/202605111130.64BBUXDN013040@mse-fl2.zte.com.cn
Cc: Wu Fei <atwufei@163.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 26 +++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 12446a4b6e8d..74ca096bf976 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -694,7 +694,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	for (iteration = 1; iteration <= p->iterations; iteration++) {
-		unsigned long i;
+		unsigned long i, reap_i;
+
+		/*
+		 * Select a random point in the time interval to reap the dirty
+		 * bitmap/ring while the guest is running, i.e. randomize how
+		 * long the guest gets to initially run and thus how many pages
+		 * it can dirty, before collecting the dirty bitmap/ring.  See
+		 * the loop below for details.
+		 */
+		reap_i = random() % p->interval;
+		printf("Reaping after a %lu ms delay\n", reap_i);
 
 		sync_global_to_guest(vm, iteration);
 
@@ -729,13 +739,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			 * that's effectively blocked.  Collecting while the
 			 * guest is running also verifies KVM doesn't lose any
 			 * state.
-			 *
+			 */
+			if (i < reap_i)
+				continue;
+
+			/*
 			 * For bitmap modes, KVM overwrites the entire bitmap,
 			 * i.e. collecting the bitmaps is destructive.  Collect
-			 * the bitmap only on the first pass, otherwise this
-			 * test would lose track of dirty pages.
+			 * the bitmap while the guest is running only once,
+			 * otherwise this test would lose track of dirty pages.
 			 */
-			if (i && host_log_mode != LOG_MODE_DIRTY_RING)
+			if (i > reap_i && host_log_mode != LOG_MODE_DIRTY_RING)
 				continue;
 
 			/*
@@ -745,7 +759,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			 * the ring on every pass would make it unlikely the
 			 * vCPU would ever fill the fing).
 			 */
-			if (i && !READ_ONCE(dirty_ring_vcpu_ring_full))
+			if (i > reap_i && !READ_ONCE(dirty_ring_vcpu_ring_full))
 				continue;
 
 			log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,

base-commit: 66939c1603bd5579e63278f9dc72cba5b79da9b5
-- 
2.54.0.794.g4f17f83d09-goog

