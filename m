Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285A2DC79B
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394593; cv=none; b=SIfVq9xuOe2INZAZ/+dXaI5uHnYwQsbqLro7HmWdBQoiy8hqoxpbzm3Kp39G6tAEA8MSmEr/2/PuPYKJQT/GcA3v92vEV2y52tGfn+Orvl8bTT1S4hpNGHqKbTHeiw5OErT6Ki07WsdInDpIh3VjPWgteM56ihBCSBrSXjhPkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394593; c=relaxed/simple;
	bh=iUmp+/UA5hUtnNLM3FihhYzYfvUWjnvesBtph3YUifk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i4TI0E4O61ZScIXx4giDsLWGQF1ViwY1BDnXRFD5gc9CwpvPp0TqgmCUGH4LEIY9xrI5uMU50lFb1ieh9WusnaDDR052lWH+ZPJeyXO3K3MBjuKQX9UGviTeFiAV1x5/nkSc1AlPY7/y6dtMawtraTvRK83/AdP1ltB67boWUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1W42tn3; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1W42tn3"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6fed0652bso20520145ad.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394592; x=1788999392; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3r1gABvmp5s+7YEMEgw6S8SuGm7W8C45xWpPRUFRpOA=;
        b=A1W42tn3qzsA0VnWRxVnEbTzEQK3TDy9/kbn3J08a3Zn2+VQ/lPZqIG9V6rIRw57ga
         vWdn/Ijmo7AEua3TJ7ClOL4SxzquwSLmBqZOzwh4Q/Ak0PRuV+HGYYAFTei6R4smGDkq
         cbA+WY7i6+II5Cr5mBv3Oa3IiblUtJtyZhwte0Ek+xR/evdew/IW1UW7QucuxlNfm/vZ
         1BdhklTzrg8hOdNNL1pVX6yRl4wqU3pspi4fNRKTUMDV55bwyt+hOChSnKyBzxH7YvQb
         fTlJMziSXZC8jK94T4wUZKZEmoQXuK9z1piHvmE7SCoa5d4oeWMNMY0RJbK4qvmth+mi
         ryBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394592; x=1788999392;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3r1gABvmp5s+7YEMEgw6S8SuGm7W8C45xWpPRUFRpOA=;
        b=gv7WVrZEs7+GVTRTmrsXe872tebF+oWX4u4ROjxmwHzdScubDHVihEhTj/SLPY5v7f
         jmd7oe3TcVoFXK/hNYNHhX56xyOXQalDogRhIQD2IkvMTAYerEr8D2aKXYwlIQnL8kg5
         a2nlyTtBY8W4mPsi4b1b2A6ecsfsJDTWhqbh/Gy35H0lSS5gDwRQJ02T6oFdurqdQ4HV
         PgMOvTEUaD+XqWjrPwICaThXTtADwQP3z8Krgp1cuicoQ2fP4v/46109S0vUyTeo/TCA
         QVjkQbKj3MTR86u4H1XPRCFxV+dAJTdMBMbP78VtMMlJNYovgaG0Vw50ows0v4G3iIND
         ghsQ==
X-Gm-Message-State: AFuF++mxX4afvLkEsK+Wbo6ZsSPfz5ocn+CIxxcwKCGP8/xCb0rGKd67
	r74uS9bvfO+G7atXUMvcexRo3wIZO1y5jaWUJSYC3IMMj1a8ak/6KWdFJbk7QcS0JhcUyIdMr7J
	ttG5TeQ==
X-Received: from pjbmv3.prod.google.com ([2002:a17:90b:1983:b0:398:e46e:7003])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cc:b0:396:b98b:a3c2
 with SMTP id 98e67ed59e1d1-39aedf1b1ecmr11504144a91.8.1788394591528; Wed, 02
 Sep 2026 17:16:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:22 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: selftests: Compute node masks on-demand in xAPIC IPI test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

Compute the node masks for the source (from) and destination (to) NUMA
nodes in the xAPIC IPI test instead of pre-filling an array of masks with
node per mask.  Computing the mask on-demand is technically slower, but
doesn't require a large-ish on-stack array, and more importantly allows the
test to use a generic "get next NUMA node" API without having to commit all
of KVM selftests to using a large array of single-bit nodemasks.

Implement said API as a common KVM NUMA API so that it can be used by other
tests, e.g. in guest_memfd tests.  Deliberately make @from "exclusive" as
the anticipated usage in KVM selftests is to select the next, *different*
node, i.e. so that users don't have to copy+paste code to assert that the
found node is different than the starting node.  The obvious downside is
that implementing the exclusive logic forces callers to pass -1 instead of
0 when the goal is to find the first node in the mask, but that arguably
yields more intuitive code anyways.

From an overall test functionality/coverage perspective, no functional
change intended (the walking pattern of node migration should be unchanged).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/numaif.h  | 21 +++++++++++-
 .../selftests/kvm/x86/xapic_ipi_test.c        | 32 ++++++-------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 71f261eafc90..299dddff2729 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -6,7 +6,7 @@
 
 #include <dirent.h>
 
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/mempolicy.h>
 
 #include "kvm_syscalls.h"
@@ -41,6 +41,25 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
  */
 #define MAXNODE_FOR_MASK(mask) (BITS_PER_TYPE(mask) + 1)
 
+/*
+ * Return the node ID of the next NUMA node in the mask, starting at @from+1.
+ * Guarantees a node is found, and that the found node is not @from.  Pass -1
+ * to find the first node in the mask.
+ */
+static inline int kvm_get_next_numa_node(unsigned long nodemask, int from)
+{
+	const unsigned long nr_bits = BITS_PER_TYPE(nodemask);
+	int to;
+
+	to = find_next_bit(&nodemask, nr_bits, from + 1);
+	if (to == nr_bits)
+		to = find_next_bit(&nodemask, nr_bits, 0);
+
+	TEST_ASSERT(to != nr_bits && to != from,
+		    "Unabled to find second NUMA node (from = %d, to = %d)", from, to);
+	return to;
+}
+
 static inline int get_max_numa_node(void)
 {
 	struct dirent *de;
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 9d1dfad4efa6..7144ad833ae0 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -233,13 +233,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 {
 	long pages_not_moved;
 	unsigned long nodemask = 0;
-	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
 	time_t interval_secs = 1;
-	int i;
 	int from, to;
-	unsigned long bit;
 	u64 hlt_count;
 	u64 wake_count;
 	u64 ipis_sent;
@@ -255,24 +252,15 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		"(each 1-bit indicates node is present): %#lx\n",
 		BITS_PER_TYPE(nodemask), nodemask);
 
-	/* Init array of masks containing a single-bit in each, one for each
-	 * available node. migrate_pages called below requires specifying nodes
-	 * as bit masks.
-	 */
-	for (i = 0, bit = 1; i < BITS_PER_TYPE(nodemask); i++, bit <<= 1) {
-		if (nodemask & bit) {
-			nodemasks[nodes] = nodemask & bit;
-			nodes++;
-		}
-	}
-
+	nodes = __builtin_popcountl(nodemask);
 	TEST_ASSERT(nodes > 1,
 		    "Did not find at least 2 numa nodes. Can't do migration");
 
 	fprintf(stderr, "Migrating amongst %d nodes found\n", nodes);
 
-	from = 0;
-	to = 1;
+	from = kvm_get_next_numa_node(nodemask, -1);
+	to = kvm_get_next_numa_node(nodemask, from);
+
 	start_time = time(NULL);
 	last_update = start_time;
 
@@ -281,6 +269,9 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 	wake_count = data->wake_count;
 
 	while ((int)(time(NULL) - start_time) < run_secs) {
+		unsigned long from_mask = BIT(from);
+		unsigned long to_mask = BIT(to);
+
 		data->migrations_attempted++;
 
 		/*
@@ -291,9 +282,8 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
 		 * test may break or give a false positive signal.
 		 */
-		pages_not_moved = migrate_pages(0, MAXNODE_FOR_MASK(nodemasks[from]),
-						&nodemasks[from],
-						&nodemasks[to]);
+		pages_not_moved = migrate_pages(0, MAXNODE_FOR_MASK(from_mask),
+						&from_mask, &to_mask);
 		if (pages_not_moved < 0)
 			fprintf(stderr,
 				"migrate_pages failed, errno=%d\n", errno);
@@ -305,9 +295,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 			data->migrations_completed++;
 
 		from = to;
-		to++;
-		if (to == nodes)
-			to = 0;
+		to = kvm_get_next_numa_node(nodemask, from);
 
 		now = time(NULL);
 		if (((now - start_time) % interval_secs == 0) &&
-- 
2.55.0.970.g62bdec98f9-goog

