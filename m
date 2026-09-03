Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872B233926
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394589; cv=none; b=ZVg443BS240A9uuYHyXGqOY1WHSi/Jo8Fse3p3H0jer73fYjRWcopDDc33mKllzFMQSOVMmGFcsFwBrTE1ig7/OgO1PUUmTnPfYwg3Pg67VIKMgGv1i/nRmF50obwtaQFwrPp2IxdAiJ8xm7C0ZSp9jTVkd0Zsall/d1WGNolZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394589; c=relaxed/simple;
	bh=GwUAO3/qh3jBnPvjL539kUpRgMJEXtQNJH9ROB0FcAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAW94uc1oRpMKY6IdL3EOppZwRCIE3a2Idt8i9hdfRN+1X1lDR57Bb+KcxRab9Wa/me4dreGvTgauHtbjsdVyPVS7n43XlU+8I9Fx0LFPLIcZSa42m4D4gXOjqLrKw2Q/hjLMUTaKhbvc7X5I3dp9ADlJgWfKATEk/pStZZLxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtMb4gRv; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtMb4gRv"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f80c76e6so28352125ad.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394588; x=1788999388; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tjeJ2nAAXDrhJbonGdD2NMDMFjcyQiwI3v/yLE7aS0g=;
        b=GtMb4gRvQ40yFxcDce2xXnerxAVfFgmir3T9O77Vin9FGGsiId/T3jFNVuuqmOMZrT
         q5hhVDoHicNPvGfMQttvgcInngbg1r46HPr+/+mLJkeEF+jJlVoVBku0vOC9lua2xQmh
         mRMBJ9hGhmPB9UaJw0sNuRdxYdIjJnjzhTflFZm6mszx/OEaRa68x+M48NFwZrRSSiCw
         dJsgIqtsY2vb/RbrxwFBT05VuUfIDwT+dTLlxljHJoabK2CUH2WufIDXKRcyns7paZhB
         ZMeHsbPI8PrRK7D9ooiNkvVjeTx9ITUo+NbZCdKYzcSf0hjYuVIfL5dnlfy2WdhAG0zU
         wvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394588; x=1788999388;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tjeJ2nAAXDrhJbonGdD2NMDMFjcyQiwI3v/yLE7aS0g=;
        b=QHaWFPt7VqzcZwL0HWF+NIQdozRalNRbejtwIZFmDKgFKWX1qyy1b16LZDWssfdtUo
         BPPopRwcNkooNPhR5dThxVelWJl7ZqJZ/XX2BYUEAigT4zclVLQYoQybReteqG7w6Dbt
         SbE/iDp5v0DgYJB+4thyYsmqcD2jkCHfJRyXWM4VQAv6COvBXg+MfyJUlDUub7oFPq7+
         KWDPamodvqwPpAnQ1TNnLMR1TVqu5fn2AP1H03z3HZfngfHZj03Cq95PqsPNgtEca2vl
         NwiyfLvz8kfOHGrt8T4/FpXyV2N9r8op/XLVdR8ZslvhLuqHDZZlgPCuuQ6Laxrk9g0c
         uJCA==
X-Gm-Message-State: AFuF++krGXpa0SogIDU6a4FHz2ambhlvZ+VuJ+G1aeUHL8pWxkdFnP7H
	fyTddelmD8mc6usSTlNAGt8iGnsBaYyIZtpULYETr3D0rwYcF8EAsyjJK4pXBJOwxur0Ynut6Nk
	6FU7hQw==
X-Received: from plbmb8.prod.google.com ([2002:a17:903:988:b0:2ca:ddbd:a19c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e749:b0:2d8:de9f:9a44
 with SMTP id d9443c01a7336-2daec732f99mr105045205ad.19.1788394587684; Wed, 02
 Sep 2026 17:16:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:19 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-2-seanjc@google.com>
Subject: [PATCH 1/7] KVM: selftests: Account for kernel's off-by-one bug in
 NUMA node syscalls
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

Add and use MAXNODE_FOR_MASK() to compute the "correct" maxnode value that
is passed to various NUMA-related syscalls, e.g. get_mempolicy(), mbind(),
migrate_pages(), etc.  In quotes, because the kernel has an undocumented,
longstanding off-by-one bug that requires userspace to specify the number
of bits plus one, i.e. the max node plus two.

The kernel bug has been known since 2007[*]:

 : And this is I think the reason why we can't change this now. I assume
 : numactl allocates 1024 bits (0 to 1023) and passes 1025 to make sure all
 : 1024 bits are processed. If we change it now, kernel will process 1025
 : bits (0 to 1024) and overflow the allocated bitmask. If it happens to be
 : at the border of mmaped vma, it's a segfault...

But unfortunately the manpages haven't yet been updated, e.g.

 : The maxnode argument is the maximum node number in the bit mask plus one

Link: https://lore.kernel.org/all/63ccc890-fd57-118b-5997-e0259f507d28@suse.cz[*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c   |  2 +-
 tools/testing/selftests/kvm/include/numaif.h     | 11 +++++++++++
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f..cd5df88bc642 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -80,7 +80,7 @@ static void test_mbind(int fd, size_t total_size)
 {
 	const unsigned long nodemask_0 = 1; /* nid: 0 */
 	unsigned long nodemask = 0;
-	unsigned long maxnode = BITS_PER_TYPE(nodemask);
+	unsigned long maxnode = MAXNODE_FOR_MASK(nodemask);
 	int policy;
 	char *mem;
 	int ret;
diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 29572a6d789c..71f261eafc90 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -6,6 +6,7 @@
 
 #include <dirent.h>
 
+#include <linux/bitops.h>
 #include <linux/mempolicy.h>
 
 #include "kvm_syscalls.h"
@@ -30,6 +31,16 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
 		   const unsigned long *, nodemask, unsigned long, maxnode,
 		   unsigned int, flags);
 
+/*
+ * Calculate the @maxnode param for the above syscalls given the mask that will
+ * be passed to the kernel, to account for a longstanding off-by-one bug in the
+ * kernel that isn't properly documented in the manpages.  The manpages say
+ * that @maxnode is "the maximum node ID plus one", but the kernel's actual
+ * behavior is "the number of bits in the mask plus one", i.e. "the maximum
+ * node ID plus two".
+ */
+#define MAXNODE_FOR_MASK(mask) (BITS_PER_TYPE(mask) + 1)
+
 static inline int get_max_numa_node(void)
 {
 	struct dirent *de;
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 469e3ab16460..1ddcf95d7fe4 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -248,7 +248,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		delay_usecs);
 
 	/* Get set of first 64 numa nodes available */
-	kvm_get_mempolicy(NULL, &nodemask, sizeof(nodemask) * 8,
+	kvm_get_mempolicy(NULL, &nodemask, MAXNODE_FOR_MASK(nodemask),
 			  0, MPOL_F_MEMS_ALLOWED);
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
-- 
2.55.0.970.g62bdec98f9-goog

