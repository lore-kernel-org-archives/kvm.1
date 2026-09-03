Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C192550D5
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394596; cv=none; b=RmTAVVPdvoVbG5jvpiJ/5VVQBZgmy0WFG5C/W9szZV15yyHZvfmEyzaCD3zCLhGgPONseQWwAcQD3w/amcOw+Ncyk0Vy5l6qjUFVKMRt+I5dWCTri9i56tDA3F3rT688g0zea11K0IJiVFJw4X+aD2F4yD5Wt2Mc0rhe3yxn+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394596; c=relaxed/simple;
	bh=ssdScvJwn5AX7Y88QustQ3OVZF+afaC11Oyf90jlOBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CPoJe7zfWzr4n02TTLiBoZMchg3OflHQGLzgNpAe5Gy3TSFt9V24393fUEbJuTvCPsWDRL7CAraKL9h4xno01MTR2Jwm99PJGofsnMacvIiwEb4FdkPcAT2wYpPm9C9EKrHw2NsEaLkkF4yJxC0iwfXtDvIixA1osWhw1wYs1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDbmsilK; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDbmsilK"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso2097243a91.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394594; x=1788999394; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WnK/zCAKpIyvcdimwe1n+ftd6xW82ILk7//FjCqRzyg=;
        b=BDbmsilKR4P94Sl047Kvc0nQitmLNywJ/XkW3h6SYoDx2vw2lLE5GkyCjVl9MB+zSj
         ZNPsI9Nf4oM9XME9lDEyrSebjdvDzl8wUA4nwa3ZPdF8sh1qSbm/puRYvHEHyp8gb6cu
         fs6ppPLpbTtNZbHZTz2MyPFWjzIvdjnG8n7J1WTIM21TDrbtvIlDz7AZsEspmYJIk46Y
         RzDdEVIFburvdk1q/bNkFj9EoIr0reYPMXz8iLGfHQMhltjFRa7u67hqQ6Jql0SRmkKu
         gjSo2wUUmROI5HRMoWz4jDPMgV25Dn9dj7++LszE1IlcXkAyUNPO7GmSuEvZXUNo8Ik9
         g5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394594; x=1788999394;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WnK/zCAKpIyvcdimwe1n+ftd6xW82ILk7//FjCqRzyg=;
        b=WF887IBVaPh1ToHkcdmhqcfAieq1Kxuz/2uZcrP+j8z7BK1krUwl9tJN/esOpEk+Ru
         Frp7mbKUpwiqo7eZb5830mXtlF8Z1oPXalnCaQWMQY8ZPcfOSmItRA/gM6YT2MVSnqDO
         YqH3DFT+t5+3vfab3bpqdEYXt7kcQB2miQWp+ujf2ajmeIsx112Tyox3JclV291kgfmJ
         1kXDuaH6zQWSqFZJxMnNQFGLCEx4K+0/lRRhrfGthekSexBSZv1WQJOEj8aWtWK69rh/
         nc5Uw2G4ivtsP5AK0qhii3zw/IOpqjdAS5FiC6wUoyIwPeUcKIfp9U2H7+RDeTmfRjYY
         wLfQ==
X-Gm-Message-State: AFuF++nKSWKshulTtsjHiFAgaIGiG8eTm6mtYRyQtfxrQi++DAymxUcE
	3ZbusGyf6caVJBg3GpIvkqOouznrSs3ySAfjAtLUhl+Kj+YvWiUUpurlZGSGwzlCyYSUxeaZHLa
	gB5eZ4g==
X-Received: from pjll16.prod.google.com ([2002:a17:90a:710:b0:398:e613:7ab3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5606:b0:398:9be6:f996
 with SMTP id 98e67ed59e1d1-39aee1115e0mr13498197a91.21.1788394593790; Wed, 02
 Sep 2026 17:16:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:23 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-6-seanjc@google.com>
Subject: [PATCH 5/7] KVM: selftests: Add common helper to get mask+number of
 usable memory NUMA nodes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

Extract and slightly adopt the xAPIC IPI test's logic for getting the mask
and number of usable memory NUMA nodes into a common helper.  To allow for
friendlier behavior when the underlying kernel doesn't support NUMA, or the
test was run without sufficient permissions, zero out the mask and return
"zero nodes" if get_mempolicy() fails with ENOSYS or EPERM respectively.
I.e. allow tests to skip (sub)tests instead of throwing an assert.

Suggested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/numaif.h     | 13 +++++++++++++
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c |  5 +----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 299dddff2729..0945500c6322 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -41,6 +41,19 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
  */
 #define MAXNODE_FOR_MASK(mask) (BITS_PER_TYPE(mask) + 1)
 
+static inline int kvm_get_numa_memory_nodes(unsigned long *nodemask)
+{
+	int r;
+
+	*nodemask = 0;
+
+	r = get_mempolicy(NULL, nodemask, MAXNODE_FOR_MASK(*nodemask), 0,
+			  MPOL_F_MEMS_ALLOWED);
+	TEST_ASSERT(!r || errno == ENOSYS || errno == EPERM,
+		    "Unexpected get_mempolicy() failure");
+	return __builtin_popcountl(*nodemask);
+}
+
 /*
  * Return the node ID of the next NUMA node in the mask, starting at @from+1.
  * Guarantees a node is found, and that the found node is not @from.  Pass -1
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 7144ad833ae0..42c601617f5a 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -244,15 +244,12 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 	fprintf(stderr, "Calling migrate_pages every %d microseconds\n",
 		delay_usecs);
 
-	/* Get set of first 64 numa nodes available */
-	kvm_get_mempolicy(NULL, &nodemask, MAXNODE_FOR_MASK(nodemask),
-			  0, MPOL_F_MEMS_ALLOWED);
+	nodes = kvm_get_numa_memory_nodes(&nodemask);
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
 		"(each 1-bit indicates node is present): %#lx\n",
 		BITS_PER_TYPE(nodemask), nodemask);
 
-	nodes = __builtin_popcountl(nodemask);
 	TEST_ASSERT(nodes > 1,
 		    "Did not find at least 2 numa nodes. Can't do migration");
 
-- 
2.55.0.970.g62bdec98f9-goog

