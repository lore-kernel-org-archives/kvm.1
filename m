Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FB38422F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813389; cv=none; b=BO4n5UcYNW74bqnhgsQfIa+PQBChqaMQY4tpOBrMxLQf3co10D+S03aBShVpRfwbohVYvC99jUsEkbZFfq78YmgqrA72JDahpmz38U/Lc6Bg+wVXlqrf6lJ5YI2MZ2Le9AN3R5Y3Vqt/1b6M6XjItIE6YXXyPUKXQSQ5CpTEM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813389; c=relaxed/simple;
	bh=pUiysLbhE1QskLSCR/qZKId2KyMa3efWNFiLsI7YQ9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eF24OqoUHq4ch2pgux/zF2RRQo1juDZbXopokNHtDeZP+9hDufU99ixLU5zgsodNWIRtgEGXH1qDnvE/ozQxWcxz//rdY839rU2vKuuWNVIGuOEC5i5DAjEPyxuQ6L6jKMlwMSJVO7vLyXIRQQzGx/s32WCS1tsVD51b/SFy+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNP39wm9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNP39wm9"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so2015756b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813387; x=1777418187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVqjAXYLHT36qpXpxcY4PwaWwws6EH2+exlXg8xPOzI=;
        b=pNP39wm9UU2pHxBqFCkBz4PZp/3aF0j3Jx1z9IgVeWWVlnU+v0AY1DiwE9VXmBLaU8
         uRWKus0yffA7Ja6v37S/f1D0at08cvg34A105LPpKK1CWUGK8jRbzpUyyDuNJvTskY5r
         rOFiOZWwtlQpTAkJ+6/Wedt+3xuIlPbd2kMPKZaH0W38xJNwlh1akFun/vEz2VK7hpZo
         ZEGUrayG2Prgcg7JDQhYOViEa2O1Wmr0iwo8wDdX5jMlgxVB6uMa08dFYh7DEegT4LRB
         9iU8Ltj4Na18BrNRd4BmQjbarN7Bypno5eAxF2RXU6O+AzXqgUFdNPsQm88A515XVC5b
         RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813387; x=1777418187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVqjAXYLHT36qpXpxcY4PwaWwws6EH2+exlXg8xPOzI=;
        b=I9bUt8I7SzN0doFzr9S3/dGXejP1YQKoxk9dPg0eQKuYgHG2LOLeVWAzDY5uKnl8CI
         8cGWtWuP/6WoAf1MvaB9S8wdsUoKYhesYyyypPSlXDy+PPjmo0LMN4eQXqBFxmRmcfBG
         arnYhpeMjhiYNI4GjLmiBZS7Cgt6iUP3nvJitqn/gZkIs+5+BmPE6iWD4IRrdJm4QCVk
         FpYJp9FztidKITukWNSQwu+qzWzJG3Cj+YZ4rZva0qsvnbSYs8+SpjgD/Y2sGAACj+sA
         rqfndvKDB6ptpjFgiTfThtUb31TfWy/qiOwrZciLvXQ/arp6BV9D4LCJDvF3YLCbtHMy
         t9UA==
X-Gm-Message-State: AOJu0YyMdSno4kGekFyNX6/cMcvnk7MozuyvGA2aTmk8HWQMtyBSuvLN
	F3UXZfDXxvZvl3ZKmQTghljjfKYJW3ZHfGlYuJ+cwKr+7jxXM+NcOkc80lTa3aw5iyG0heRmrXw
	qVmrzCrEM
X-Received: from pfbg11.prod.google.com ([2002:a05:6a00:ae0b:b0:82b:928a:17cd])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2311:b0:82c:dd31:b83d
 with SMTP id d2e1a72fcca58-82f8c936e47mr21598996b3a.38.1776813386756; Tue, 21
 Apr 2026 16:16:26 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:45 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-5-jrhilke@google.com>
Subject: [PATCH v3 04/16] KVM: selftests: Rename guest_rng to kvm_rng
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
2.54.0.rc2.533.g4f5dca5207-goog

