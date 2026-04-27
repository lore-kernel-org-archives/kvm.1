Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA631F9A6;
	Mon, 27 Apr 2026 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322619; cv=none; b=Ik5XyhVz753o8RFI39450GQc8htgnhNNdHOAurdiyZs1xNLOBqXeY6kNK1mZnXvfny0PSgbZqayNB6FCjIvgLC8mRBD4HMJdI1+kfZOlyL9wLv2EqdxnuXYJJH1qWlJbBo4IqjgF4KFaM4gkFd2lBenA0AGouH/5MwhQgyJdJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322619; c=relaxed/simple;
	bh=uAYuWVMvTI2qkbN+G7mgqlJBgiymuT7WQamPjqIkuMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNl8gwIkZatN5cYTcXBO3lR0s19GeJlEgKe6bPuEaOp+dR+eQ8H0ZI+cXpjOBFA9zYOfjF81BnQVoS7a68GJ1TuC4C+CAf2gJeSnKnZMrnVEsr8gMJd6AV26/13QXG2MQfn3DCyB7T4bexRWlI5oKYk7q9hMlZXNQZsXwzqinYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSFf1fR9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSFf1fR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777322617; x=1808858617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uAYuWVMvTI2qkbN+G7mgqlJBgiymuT7WQamPjqIkuMc=;
  b=lSFf1fR9nwqgubAh1XUpLTT6nXp3Brji8KpKSkgAvuv8awxT4nVHjgX2
   aA6h6kmXRuoHxDZdsIzDLFSHp0+x4DwUwyxzdSxuXJ8X73N2Gy0tQVswq
   K1kbXoexK4ZATnUTVXJnQ3+Am/dxD3HlqTxdB8uAERMp0xTBsb5FgSta/
   dU/tZIzjNH0DyBUWD8Y2POo8lKsKsmL+MycqPgHXmpRfAsQedoapCGMwk
   Fo6DprJAlhJuXU/AWNoiJ1nY4I9YpYEHBc9x1AKTGHnmBInjqzJwKsQFR
   sDH6ALK/Sm59WAbzRlEd7bOQRlJD8SAvM6BeXbg3sLJk0aOA8Xu7hTmFT
   g==;
X-CSE-ConnectionGUID: FrCFBRZ8S2Sxjy+Mhprtow==
X-CSE-MsgGUID: /FuwqIcHTM2g+Ads9CvIrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95788055"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="95788055"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:43:28 -0700
X-CSE-ConnectionGUID: N+3U9oToQBuynuovvKqc8w==
X-CSE-MsgGUID: 7iFbhy/GT9mSJGpRIbhl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="264142966"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:43:27 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: pbonzini@redhat.com,
	ackerleytng@google.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com
Subject: [PATCH] KVM: selftests: Include linux version of mman.h
Date: Mon, 27 Apr 2026 13:43:13 -0700
Message-ID: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a selftest build error by switching a mman.h header include from the
"sys" version to the "linux" one.

Recently a reference to MADV_COLLAPSE was added to guest_memfd_test.c.
This works fine if the system libc has this definition, but against older
libcs, it leads to build errors like:
  In file included from include/kvm_util.h:8,
                   from guest_memfd_test.c:21:
  guest_memfd_test.c: In function ‘test_collapse’:
  guest_memfd_test.c:219:47: error: ‘MADV_COLLAPSE’ undeclared (first use in this function); did you mean ‘MADV_COLD’?
      219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE), -1);
          |                                               ^~~~~~~~~~~~~
    include/test_util.h:62:16: note: in definition of macro ‘TEST_ASSERT_EQ’
       62 |         typeof(a) __a = (a);                                            \
          |                ^
    guest_memfd_test.c:219:47: note: each undeclared identifier is reported only once for each function it appears in
      219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE), -1);
          |                                               ^~~~~~~~~~~~~
    include/test_util.h:62:16: note: in definition of macro ‘TEST_ASSERT_EQ’
       62 |         typeof(a) __a = (a);                                            \
          |                ^

The problem is the test is pulling in the libc version of mman.h instead of
the Linux one. Switch it to the Linux one so MADV_COLLAPSE will be
guaranteed to be present (if the user installs the headers).

Fixes: 9830209b4ae8 ("KVM: selftests: Test MADV_COLLAPSE on guest_memfd")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Hi,

I'm not sure if there is standard official version of the header to include
for the selftests, but the KVM selftests no longer build for me. This fixes
it.

 tools/testing/selftests/kvm/guest_memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ec7644aae999..7c113b8c4f75 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -14,7 +14,7 @@
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <linux/sizes.h>
-#include <sys/mman.h>
+#include <linux/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
-- 
2.54.0

