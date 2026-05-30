Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C031F3D56
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100593; cv=none; b=LlEfC3l+gFHwf33AsLB3xu4LjE6BdAFFPfWOVH5yTSaEv7KyZqwaMLJzOXw2nfso4De5P4gKxfqamjggNV49DuowOsY8MerFy4wstwOcKRYL1H6D0wjJ91JwS5rdgXZydtSBDPI3jQUvAQgIkaZ/jRlCdY9uiWKBZce8/AFf09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100593; c=relaxed/simple;
	bh=NUwm4+hig0YVBidWUTEwG8zQL782N1I6qRmGhujqMv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9upDk8t3gSJUdl3RN1WNhfbPWfOCWNBRtAfIakRYdnVBOFMqVfzOpcNwHyVXNQ1WvAFCmdyR0kwWKAxlLicvmCnT0AbJEfSezlDGcnP/te1H2MrVqjStfdRqpO6f7GkWAXvcACAD8za1dq2LMbtBDLp5FTMaD1Au/euqWfLjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbd4dUSn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbd4dUSn"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so298091075ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100588; x=1780705388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjBpmrs5qmlmGxSbD10amIvDODEnkvfGNcjYVL/FcVU=;
        b=kbd4dUSnTCJ8q82qWOs+2AEQRo0ZTVV8WNgOh8+eBdr+tldx0P/ltS3WCw01VDPUru
         +BqUVP1gcmkRU/fECmCYwhMlroVybQupy5mDuN2BBw4/rxBUUq+RcQtxKW33yejAc1db
         kDgEsYXnkMFeI9aC3hfW5KQ6uwU+9wgDPlHgupRpjyZ8NkTVvTsY+E1JPcGDt7L6PqLb
         NUNJflp6vd+w47hlBCUKc9KxaAqXmAtnXqb0ok1jh8fkogXjA8WUvN6z8ruCm+1VW/SV
         wqHJg7280Z5klydKevQn6IEFAwWUwpneGdnGtlAI4ruEt6OEvTQ68ArEN0MGdGmylrop
         /iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100588; x=1780705388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjBpmrs5qmlmGxSbD10amIvDODEnkvfGNcjYVL/FcVU=;
        b=M/UhikQl2hmBD3e69RgaNONcOMUq9rXkAtoxuYBpIgih2PitZXCubrYvcW+ugkHsGX
         sDMCA35jtVXMh3LehhS1uy7h53zBNdSY40pPxQ7QATO0QbulErKJbCuat6i5dAC6/AyB
         ypNGrzSixpLkktLNSLYeMuzoHEvscf2FljlR3hGGz4DamOjavOV/HVCOAhcJMmBPEA00
         LwDKyPthGp1gSedGhnQ1x0+FgnIC1A0vSV1+LpCm+5qfeCK5veAsTCwJJUKBu87EcRhN
         5uDyBlcQcOX3oBvzDiBk5JjkxlE9+HRjmvY7jXmqGNFXR4GlcTrdeYg+k9w/pu0N+ede
         GA6w==
X-Gm-Message-State: AOJu0Yww2NKhYYlif5JJUqJ/wWqKIjKkO3SC+yZheP89xTMhlvp9Db+8
	oL1ypuq+uTbDDcqVsAMZ+JKXRyk0OgO2apVoq5HJtS6On05FJUolLTv8Hr4Utpg8i42UFxn3ieM
	2+n489k88
X-Received: from plbmo16.prod.google.com ([2002:a17:903:a90:b0:2b2:5117:a3f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3585:b0:2b9:6458:1a2c
 with SMTP id d9443c01a7336-2bf367c3898mr22796995ad.13.1780100587862; Fri, 29
 May 2026 17:23:07 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:19 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-5-jrhilke@google.com>
Subject: [PATCH v4 04/19] KVM: selftests: Rename guest_rng to kvm_rng
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename functions prefixed with 'guest_random_' to 'kvm_random_' and the
global random state variable 'guest_rng' to 'kvm_rng'. This expands
their usage and reflects that the random number generator can be used by
both the host and the guest.

No functional changes are intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       |  4 ++--
 tools/testing/selftests/kvm/dirty_log_test.c  |  2 +-
 .../testing/selftests/kvm/include/test_util.h | 22 +++++++++----------
 .../selftests/kvm/include/x86/kvm_util_arch.h |  4 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 20 ++++++++---------
 tools/testing/selftests/kvm/lib/memstress.c   |  8 +++----
 tools/testing/selftests/kvm/lib/test_util.c   |  6 ++---
 7 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 0a1ea1d1e2d8..606abd858a12 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -311,7 +311,7 @@ int main(int argc, char *argv[])
 	int opt;
 
 	/* Override the seed to be deterministic by default. */
-	guest_random_seed = 1;
+	kvm_random_seed = 1;
 
 	dirty_log_manual_caps =
 		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
@@ -357,7 +357,7 @@ int main(int argc, char *argv[])
 			p.phys_offset = strtoull(optarg, NULL, 0);
 			break;
 		case 'r':
-			guest_random_seed = atoi_positive("Random seed", optarg);
+			kvm_random_seed = atoi_positive("Random seed", optarg);
 			break;
 		case 's':
 			p.backing_src = parse_backing_src_type(optarg);
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 66c3d9554379..cddf56400e6c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -121,7 +121,7 @@ static void guest_code(void)
 	while (true) {
 		while (!READ_ONCE(vcpu_stop)) {
 			addr = guest_test_virt_mem;
-			addr += (guest_random_u64(&guest_rng) % guest_num_pages)
+			addr += (kvm_random_u64(&kvm_rng) % guest_num_pages)
 				* guest_page_size;
 			addr = align_down(addr, host_page_size);
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4872ba8ed12..ae39c4293b9a 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -106,30 +106,30 @@ struct timespec timespec_sub(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_elapsed(struct timespec start);
 struct timespec timespec_div(struct timespec ts, int divisor);
 
-struct guest_random_state {
+struct kvm_random_state {
 	uint32_t seed;
 };
 
-extern uint32_t guest_random_seed;
-extern struct guest_random_state guest_rng;
+extern uint32_t kvm_random_seed;
+extern struct kvm_random_state kvm_rng;
 
-struct guest_random_state new_guest_random_state(uint32_t seed);
-uint32_t guest_random_u32(struct guest_random_state *state);
+struct kvm_random_state new_kvm_random_state(uint32_t seed);
+uint32_t kvm_random_u32(struct kvm_random_state *state);
 
-static inline bool __guest_random_bool(struct guest_random_state *state,
+static inline bool __kvm_random_bool(struct kvm_random_state *state,
 				       uint8_t percent)
 {
-	return (guest_random_u32(state) % 100) < percent;
+	return (kvm_random_u32(state) % 100) < percent;
 }
 
-static inline bool guest_random_bool(struct guest_random_state *state)
+static inline bool kvm_random_bool(struct kvm_random_state *state)
 {
-	return __guest_random_bool(state, 50);
+	return __kvm_random_bool(state, 50);
 }
 
-static inline uint64_t guest_random_u64(struct guest_random_state *state)
+static inline uint64_t kvm_random_u64(struct kvm_random_state *state)
 {
-	return ((uint64_t)guest_random_u32(state) << 32) | guest_random_u32(state);
+	return ((uint64_t)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
 enum vm_mem_backing_src_type {
diff --git a/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
index be35d26bb320..63a12ef9008e 100644
--- a/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
@@ -55,9 +55,9 @@ static inline bool __vm_arch_has_protected_memory(struct kvm_vm_arch *arch)
 do {											\
 	const typeof(mem) val = (__val);						\
 											\
-	if (!is_forced_emulation_enabled || guest_random_bool(&guest_rng)) {		\
+	if (!is_forced_emulation_enabled || kvm_random_bool(&kvm_rng)) {		\
 		(mem) = val;								\
-	} else if (guest_random_bool(&guest_rng)) {					\
+	} else if (kvm_random_bool(&kvm_rng)) {					\
 		__asm__ __volatile__(KVM_FEP "mov %1, %0"				\
 				     : "+m" (mem)					\
 				     : "r" (val) : "memory");				\
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1959bf556e88..b247b2015b2a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -20,9 +20,9 @@
 
 #define KVM_UTIL_MIN_PFN	2
 
-uint32_t guest_random_seed;
-struct guest_random_state guest_rng;
-static uint32_t last_guest_seed;
+uint32_t kvm_random_seed;
+struct kvm_random_state kvm_rng;
+static uint32_t last_kvm_seed;
 
 static size_t vcpu_mmap_sz(void);
 
@@ -515,12 +515,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	if (guest_random_seed != last_guest_seed) {
-		pr_info("Random seed: 0x%x\n", guest_random_seed);
-		last_guest_seed = guest_random_seed;
+	if (kvm_random_seed != last_kvm_seed) {
+		pr_info("Random seed: 0x%x\n", kvm_random_seed);
+		last_kvm_seed = kvm_random_seed;
 	}
-	guest_rng = new_guest_random_state(guest_random_seed);
-	sync_global_to_guest(vm, guest_rng);
+	kvm_rng = new_kvm_random_state(kvm_random_seed);
+	sync_global_to_guest(vm, kvm_rng);
 
 	kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
 
@@ -2358,8 +2358,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
-	guest_random_seed = last_guest_seed = random();
-	pr_info("Random seed: 0x%x\n", guest_random_seed);
+	kvm_random_seed = last_kvm_seed = random();
+	pr_info("Random seed: 0x%x\n", kvm_random_seed);
 
 	kvm_selftest_arch_init();
 }
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 557c0a0a5658..c5df9c99102a 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -48,14 +48,14 @@ void memstress_guest_code(uint32_t vcpu_idx)
 {
 	struct memstress_args *args = &memstress_args;
 	struct memstress_vcpu_args *vcpu_args = &args->vcpu_args[vcpu_idx];
-	struct guest_random_state rand_state;
+	struct kvm_random_state rand_state;
 	uint64_t gva;
 	uint64_t pages;
 	uint64_t addr;
 	uint64_t page;
 	int i;
 
-	rand_state = new_guest_random_state(guest_random_seed + vcpu_idx);
+	rand_state = new_kvm_random_state(kvm_random_seed + vcpu_idx);
 
 	gva = vcpu_args->gva;
 	pages = vcpu_args->pages;
@@ -69,13 +69,13 @@ void memstress_guest_code(uint32_t vcpu_idx)
 
 		for (i = 0; i < pages; i++) {
 			if (args->random_access)
-				page = guest_random_u32(&rand_state) % pages;
+				page = kvm_random_u32(&rand_state) % pages;
 			else
 				page = i;
 
 			addr = gva + (page * args->guest_page_size);
 
-			if (__guest_random_bool(&rand_state, args->write_percent))
+			if (__kvm_random_bool(&rand_state, args->write_percent))
 				*(uint64_t *)addr = 0x0123456789ABCDEF;
 			else
 				READ_ONCE(*(uint64_t *)addr);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8a1848586a85..e342d9fb4771 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -30,13 +30,13 @@ void __attribute__((used)) expect_sigbus_handler(int signum)
  * Park-Miller LCG using standard constants.
  */
 
-struct guest_random_state new_guest_random_state(uint32_t seed)
+struct kvm_random_state new_kvm_random_state(uint32_t seed)
 {
-	struct guest_random_state s = {.seed = seed};
+	struct kvm_random_state s = {.seed = seed};
 	return s;
 }
 
-uint32_t guest_random_u32(struct guest_random_state *state)
+uint32_t kvm_random_u32(struct kvm_random_state *state)
 {
 	state->seed = (uint64_t)state->seed * 48271 % ((uint32_t)(1 << 31) - 1);
 	return state->seed;
-- 
2.54.0.929.g9b7fa37559-goog

