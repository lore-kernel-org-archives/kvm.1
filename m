Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469A2E1722
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538557; cv=none; b=ugamGUOI7nksFSlwQyUDpkYINPfUBakjKsT1AO8dC0+lfrt7XqT47cG9KvIou2aIzmu+pUshVaaFyHVBS4sZ6g62yTF4XPR3K4UNzhx1bEX6VoT1WLaBHNFDEC3B6y9uQbeUwBu+HE8nAVw8aWiEqLqqwNYP+/pt/nAINye6odA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538557; c=relaxed/simple;
	bh=XynlGgzvtyslGT34xYN3QY4dTtAI3O/O7Ds3dz2U1yU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOPspb8/2I9gz29U0Fm+3U9hcsBXrCcD7750yZxML4b1VCrDI7wHbSvyKsTsUSoN4i4m4TU7oTxV9SZ9Nh2NkmG5TmbDEqSI+4/HpRVdFexPm5lTF5QtGcO6m6Jd7HThmBEZa3lPx2mTa9Fm96UdSpm5da44M7/16mkMeBqtLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NB1Wkfpe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NB1Wkfpe"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso146191a12.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538554; x=1781143354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSHpiYqQ0cIYiARVnuV9XXk5L30RA1M6/dELqPY2Y/8=;
        b=NB1Wkfpeush8papsDKLWXmAe5uBriuBCFuG23n70BpDnCo8GVYdX9qbcb+Cu8Cyi+9
         Lp/3zmhzKhdPPPJmFYShfLgdaCx2/qkOYyRoxDr2X8PTG+BSO/+YRGilSNvqkYrrmXz9
         1Afh9pa1aEw5zg5GXV6T1AgV/nU2PMOnfa4f5VnSmnGsO2x/LBeM7YSrQF1FawlTrAN2
         HL55lEZYCSoq+DPN1JpYZSu7OLT5GNz3ODasG4cakqVxBK3n1KF90Pv1SrbFKMqdljkO
         qDNp4ghX8blWiC9OUOnU3x4VqtPql/IypIK6LVHFCqQ1oWtf51OCO482aPqfNWGwWy+j
         8z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538554; x=1781143354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSHpiYqQ0cIYiARVnuV9XXk5L30RA1M6/dELqPY2Y/8=;
        b=nv5DNQwXcMMMexznm0DOCS6002q0Okb6fZ1ZruLQp0ZjtFaYLKRmkJhg9RLGB8MgQL
         Da8di8KbjaeWExfY4Wz7HmyUwoPyyTYJlt2Ur1I4n5fZ7KYRqlpqunCQQu3Y9YhIQOWm
         6IYYNvboeHcxGeWtQFR7qeyA3vlDhM9nNdXTJxq6d+Fr1rCpydSUOZwSNQVMFtAgkn1r
         8lQH6m9ob9bFLZYUiBF6z5zADM6USTgfvJ0DUlHTCXfqaRLSlNlxxaBLEowDnWYLVweW
         FxGxFwv35jPR7LsXdHl0l+z5NSel5fxut7bJjWQbHN7d8YQDvLS/JM8LdI4WYnuPP2B0
         U9Nw==
X-Gm-Message-State: AOJu0Yz4kXe5kB/7JnRrXiwh2OgJcCiylHli7n1WaIsIZeRoMj2GEPRv
	i9RdNkYNWyaq6yND1lJgytax/rVW7FRyNdhr4DtbzlB5udCGc2qrFvFHcDYbmLn+aBeSvWxcTtU
	gW1c1B1yr
X-Received: from pfbdi4.prod.google.com ([2002:a05:6a00:4804:b0:842:3a6c:99f5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:300b:b0:838:127d:a167
 with SMTP id d2e1a72fcca58-84284e31e34mr5214998b3a.16.1780538553361; Wed, 03
 Jun 2026 19:02:33 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:25 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-4-jrhilke@google.com>
Subject: [PATCH v5 03/21] KVM: selftests: Rename guest_rng to kvm_rng
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index ef779fa91827..7c5abe1ae9e0 100644
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
index 561b80064230..95d5f27a4093 100644
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
index a56271c237ae..44c0104d60ac 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -108,30 +108,30 @@ struct timespec timespec_sub(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_elapsed(struct timespec start);
 struct timespec timespec_div(struct timespec ts, int divisor);
 
-struct guest_random_state {
+struct kvm_random_state {
 	u32 seed;
 };
 
-extern u32 guest_random_seed;
-extern struct guest_random_state guest_rng;
+extern u32 kvm_random_seed;
+extern struct kvm_random_state kvm_rng;
 
-struct guest_random_state new_guest_random_state(u32 seed);
-u32 guest_random_u32(struct guest_random_state *state);
+struct kvm_random_state new_kvm_random_state(u32 seed);
+u32 kvm_random_u32(struct kvm_random_state *state);
 
-static inline bool __guest_random_bool(struct guest_random_state *state,
+static inline bool __kvm_random_bool(struct kvm_random_state *state,
 				       u8 percent)
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
 
-static inline u64 guest_random_u64(struct guest_random_state *state)
+static inline u64 kvm_random_u64(struct kvm_random_state *state)
 {
-	return ((u64)guest_random_u32(state) << 32) | guest_random_u32(state);
+	return ((u64)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
 enum vm_mem_backing_src_type {
diff --git a/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
index c33ab6e04171..6904dbda79f9 100644
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
index e08967ef7b7b..2d24d8db86b1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -20,9 +20,9 @@
 
 #define KVM_UTIL_MIN_PFN	2
 
-u32 guest_random_seed;
-struct guest_random_state guest_rng;
-static u32 last_guest_seed;
+u32 kvm_random_seed;
+struct kvm_random_state kvm_rng;
+static u32 last_kvm_seed;
 
 static size_t vcpu_mmap_sz(void);
 
@@ -515,12 +515,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
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
 
@@ -2280,8 +2280,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
-	guest_random_seed = last_guest_seed = random();
-	pr_info("Random seed: 0x%x\n", guest_random_seed);
+	kvm_random_seed = last_kvm_seed = random();
+	pr_info("Random seed: 0x%x\n", kvm_random_seed);
 
 	kvm_selftest_arch_init();
 }
diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
index 6dcd15910a06..3599b75d97c9 100644
--- a/tools/testing/selftests/kvm/lib/memstress.c
+++ b/tools/testing/selftests/kvm/lib/memstress.c
@@ -48,14 +48,14 @@ void memstress_guest_code(u32 vcpu_idx)
 {
 	struct memstress_args *args = &memstress_args;
 	struct memstress_vcpu_args *vcpu_args = &args->vcpu_args[vcpu_idx];
-	struct guest_random_state rand_state;
+	struct kvm_random_state rand_state;
 	gva_t gva;
 	u64 pages;
 	u64 addr;
 	u64 page;
 	int i;
 
-	rand_state = new_guest_random_state(guest_random_seed + vcpu_idx);
+	rand_state = new_kvm_random_state(kvm_random_seed + vcpu_idx);
 
 	gva = vcpu_args->gva;
 	pages = vcpu_args->pages;
@@ -69,13 +69,13 @@ void memstress_guest_code(u32 vcpu_idx)
 
 		for (i = 0; i < pages; i++) {
 			if (args->random_access)
-				page = guest_random_u32(&rand_state) % pages;
+				page = kvm_random_u32(&rand_state) % pages;
 			else
 				page = i;
 
 			addr = gva + (page * args->guest_page_size);
 
-			if (__guest_random_bool(&rand_state, args->write_percent))
+			if (__kvm_random_bool(&rand_state, args->write_percent))
 				*(u64 *)addr = 0x0123456789ABCDEF;
 			else
 				READ_ONCE(*(u64 *)addr);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index bab1bd2b775b..e98ca7ef439c 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -30,13 +30,13 @@ void __attribute__((used)) expect_sigbus_handler(int signum)
  * Park-Miller LCG using standard constants.
  */
 
-struct guest_random_state new_guest_random_state(u32 seed)
+struct kvm_random_state new_kvm_random_state(u32 seed)
 {
-	struct guest_random_state s = {.seed = seed};
+	struct kvm_random_state s = {.seed = seed};
 	return s;
 }
 
-u32 guest_random_u32(struct guest_random_state *state)
+u32 kvm_random_u32(struct kvm_random_state *state)
 {
 	state->seed = (u64)state->seed * 48271 % ((u32)(1 << 31) - 1);
 	return state->seed;
-- 
2.54.0.1032.g2f8565e1d1-goog

