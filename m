Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F683382F28
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853086; cv=none; b=VuseKutsHI2kXHoy1+3aW8WLYhe3sppPWrZ2+ZiTiFEt+lcb23+lTmEqvr5ig+A558kM79jSTos7Km60sTRYvPJyoYjrXuvAL/vjOU62hOOTO2tN9Plt8W2dOc5WwPo0PUdawtDRC1weUg0DmWZkVhJ7K0+hRvkHUw4fKmL45nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853086; c=relaxed/simple;
	bh=8A5UAeC2GK9jlgr8bYjUnNnxLrIamWi4fT5BHrBbzOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VM9Deo3o+V96C0i1vsGbAhINHxKR4rNpg6ErPBWgyPWUAO/IYAgCDlF+qv7NwvqgNyoOH6+9vgkstrUE+xlX1dVI/usGrYvvMjv6EE7BrfEw810hQs5OwMal0YZLBiu++KrA5Gwq1TR04aCdKzkJ7AdQpTGM6L0xVHrBScaBVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJoGrWn3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJoGrWn3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso11946837b3a.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778853078; x=1779457878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fxCMimmNsvVLuGM+eq9TJTg+IBO/pqIm0gpoVqUw5E=;
        b=gJoGrWn3m7Bla9pG1ldNtD3NrjwkkVkItJF/KiRHWlGkbSoo66L3kyNwMxXo83pJ+G
         3HrwA7FC2q9Iy5FPBVmhLeY6DpCEHh9WsrFVTThamux53D8pN0BQBvrA34Bmqs0+oKtq
         3CsTx16CFH+0IaBkDSuCExZKnkLLgRcRVP/V8iBJOvmDmXSiYucpWaEpNbo8biT15AKP
         FNur4CXGteBfCN2aAWiiHE3i42aE30sjMlmPmRunLgO/n3i0O8HHVCooWvQoa6AFSxX1
         4Iw7CxZ6hmkEeE7vu6wgOsG8xoss2gAki95+/ALteQYHbYVVhdHZj2IjGA1SGun7oroz
         8qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853078; x=1779457878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fxCMimmNsvVLuGM+eq9TJTg+IBO/pqIm0gpoVqUw5E=;
        b=ZVhJv2YZOpaS9qGCSZyeQP09CIxiBCjYqOsa4W17J73HK60nkFflZPtix1XIBRE2yp
         YBJibLGF3oB6tMtM/gQ7OOdsRdm+fO2/snDeM9cLvSz4Uc6gIYebdJK6c8yIdVwowPEu
         KAqbaoZePHcW+a6MZtETfCwkfiCqRKVz24sSKnFHU9RVs6TCX+wI8dzQNu0kbdf18IjH
         cPhnZHzDQWZ0MOYgxJLH8VCKJpCC6eZlHpB23te+hQpfr/RCzrgYA4++zOWCaXW6pqd0
         BSF+YS/GFDqT4Lvy/obWDvRnQZiyas03sqppU0jRyb0q1a5zGcFje5eYarUKWIZBsLCg
         x/nw==
X-Forwarded-Encrypted: i=1; AFNElJ+4v4PCDrRkHSUOd+JlvPoPlkBIx+5mV6PVdT2excQEytZMhLVloGqMt3gB3roA/kkSVZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIk/c5cQlIUO/x82Bg+jAi4FYITaS94Ovhn6jJQM5nWAuM8ItV
	FlPIby/1wPRNteNbFFwSUGsTReeoUXHtZMuVobFvP3MXBFTxpm5FsttbzCUYgWjHpz1oUlVwrFA
	MbtCMxw==
X-Received: from pfbem15.prod.google.com ([2002:a05:6a00:374f:b0:83d:3c25:eb8b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8088:b0:839:44c5:c321
 with SMTP id d2e1a72fcca58-83f33f29b57mr4275573b3a.44.1778853078151; Fri, 15
 May 2026 06:51:18 -0700 (PDT)
Date: Fri, 15 May 2026 06:51:17 -0700
In-Reply-To: <f64029bf-1f4c-40a7-860a-eb04fbe5317b@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
 <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn> <agO_0ejKd0x38_-E@google.com>
 <f64029bf-1f4c-40a7-860a-eb04fbe5317b@163.com>
Message-ID: <agck1WqW-TyEqkqd@google.com>
Subject: Re: [PATCH 1/3] KVM: selftests: Add unit to dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Wu Fei <atwufei@163.com>
Cc: wu.fei9@sanechips.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, anup@brainfault.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 13, 2026, Wu Fei wrote:
> On 5/13/26 08:03, Sean Christopherson wrote:
> > On Mon, May 11, 2026, wu.fei9@sanechips.com.cn wrote:
> > > Currently dirty_log_test hardcodes usleep 1ms in each interval, which
> > > could be too short for guest to write and fault in enough pages, then
> > > there is less chance to test the write protection mechanism, especially
> > > in the case of (log_mode != LOG_MODE_DIRTY_RING).
> > 
> > But when log_mode != LOG_MODE_DIRTY_RING, the individual sleep time is largely
> > meaningless, because the test won't reap the bitmaps for iterations > 0.
> > 
> > 			if (i && host_log_mode != LOG_MODE_DIRTY_RING)
> > 				continue;
> > 
> The first usleep  matters in the case of KVM_DIRTY_LOG_INITIALLY_SET. The
> dirty bitmap is not precise in the first get_dirty_log, all pages are marked
> as dirty but most of them are not populated in page table, this creates the
> situation I mentioned in the cover letter.

I suspect something is messed up in your workflow, because the actual patches
aren't properly threaded with respect to the cover letter.  E.g. patch 1 has

  In-Reply-To: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>

but the cover letter has:

  Message-Id: <202605111108.64BB8RFR010522@mse-db.zte.com.cn>

Copy+pasting the entirety of the cover letter for reference:

 : The current gstage range walker unconditionally advances by 'page_size'
 : when a leaf PTE is not found, e.g. when the range to wp is
 : [0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
 : returns false and page_size is 2MB, it skips the whole range, but it's
 : possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
 : only [0xfffff01fc000, 0xfffff0200000) can be skipped safely. Both
 : wp/unamp have the same pattern.
 : 
 : dirty_log_test intentionally sets up the unaligned guest physical
 : address, after riscv kvm enabling KVM_DIRTY_LOG_INITIALLY_SET, it's easy
 : to trigger this bug if there is a larger window for guest to write more
 : pages before first collect_dirty_pages.

> "when the range to wp is
> [0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
> returns false and page_size is 2MB, it skips the whole range, but it's
> possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
> only [0xfffff01fc000, 0xfffff0200000) can be skipped safely."
> 
> > > 
> > > Unit is introduced to replace the default 1ms if specified in command
> > > line. The following test can't trigger failure on my riscv vm:
> > 
> > Failure of what?  And does the failure really not reproduce with a higher interval?
> 
> On riscv, it fails to write protect some pages with valid page table entry
> then loses track of dirty pages. Higher interval doesn't help because only
> the first usleep matters, after the first collect_dirty_pages, all dirty
> pages are tracked precisely then there is no such problem.

Ah, gotcha.  Rather than let (and force) the user to provide a larger sleep time,
what if we instead randomize the delay before the initial reaping of the dirty
bitmap/ring?  That should provide a good balance between coverage, complexity and
user-friendliness.

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 12446a4b6e8d..74ca096bf976 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -694,7 +694,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
        pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
        for (iteration = 1; iteration <= p->iterations; iteration++) {
-               unsigned long i;
+               unsigned long i, reap_i;
+
+               /*
+                * Select a random point in the time interval to reap the dirty
+                * bitmap/ring while the guest is running, i.e. randomize how
+                * long the guest gets to initially run and thus how many pages
+                * it can dirty, before collecting the dirty bitmap/ring.  See
+                * the loop below for details.
+                */
+               reap_i = random() % p->interval;
+               printf("Reaping after a %lu ms delay\n", reap_i);
 
                sync_global_to_guest(vm, iteration);
 
@@ -729,13 +739,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
                         * that's effectively blocked.  Collecting while the
                         * guest is running also verifies KVM doesn't lose any
                         * state.
-                        *
+                        */
+                       if (i < reap_i)
+                               continue;
+
+                       /*
                         * For bitmap modes, KVM overwrites the entire bitmap,
                         * i.e. collecting the bitmaps is destructive.  Collect
-                        * the bitmap only on the first pass, otherwise this
-                        * test would lose track of dirty pages.
+                        * the bitmap while the guest is running only once,
+                        * otherwise this test would lose track of dirty pages.
                         */
-                       if (i && host_log_mode != LOG_MODE_DIRTY_RING)
+                       if (i > reap_i && host_log_mode != LOG_MODE_DIRTY_RING)
                                continue;
 
                        /*
@@ -745,7 +759,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
                         * the ring on every pass would make it unlikely the
                         * vCPU would ever fill the fing).
                         */
-                       if (i && !READ_ONCE(dirty_ring_vcpu_ring_full))
+                       if (i > reap_i && !READ_ONCE(dirty_ring_vcpu_ring_full))
                                continue;
 
                        log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
