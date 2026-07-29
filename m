Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB534F46F;
	Wed, 29 Jul 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341736; cv=none; b=F7XzGhHO4RnDp6gHP3Azx8YkZfZaSZoElxnBHU/85ocgSRYr/IMj3mDsKEYo5pD3qfJJnssggJRUJ7YWQFtnK01fsAfMrTQc2izB5sQNLEYkXkA+4WBZV6fIYjlnG6kNVUtRGoUteuXu+elCwqYGD6uenlghn9KPj0POip0Bvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341736; c=relaxed/simple;
	bh=d/RIxWsA0xPEz3qG/9HG/zsfnZD4aHD33bEchmoTmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8ToZ2yKvvweE/JOjZlhqia35+VlKKh2yqn6AEsKbzD9nKfxEZSkJm2JTiLlpQFg24QySsmz03si+CPXOu2KkeehSlrHSlZQySl/T9aCI/+A0poGKQQez4fltVFYga2Vr1Ozv37cRcEd5mETWL9JiBrgfCdM98o13XpCy7EjFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u9vBtPeb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u9vBtPeb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD381684;
	Wed, 29 Jul 2026 09:15:29 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27FE13F66F;
	Wed, 29 Jul 2026 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785341733; bh=d/RIxWsA0xPEz3qG/9HG/zsfnZD4aHD33bEchmoTmMk=;
	h=From:To:Cc:Subject:Date:From;
	b=u9vBtPebjc0ErZjwLSnx/dKLBMERoNmmJfogLjPYXX3tJPTalyi8LaA0/Z65mCoZJ
	 SniPLLuCE6hTOiL7iD3TOF8QQ8v5r2hmmXSjGRZRGJ7S/CJCskB21NDPy+Sd36/M+f
	 hB3CVxvzVT1exjjJeo2L2tSHCa9rECO9GzZyi9GA=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/3] KVM: selftests: Improvements on dirty-ring
Date: Wed, 29 Jul 2026 17:15:15 +0100
Message-ID: <20260729161519.3778839-2-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; i=leo.bras@arm.com; h=from:subject; bh=d/RIxWsA0xPEz3qG/9HG/zsfnZD4aHD33bEchmoTmMk=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLKy1Hmzfp8U3TjR/aj9McP4aztPZGr+V5ixVlo5jfVfR Keh+yrjjlIWBjEuBlkxRRbZR/NX8XyfknHkyo8FMHNYmUCGMHBxCsBEgowZGfobVTt8ln778iBp 49n3P2YFXk+eU3Rq/v5Ley2mzrmds2AtI8PZTa37qnUnrZafsGXfkS//Pjxrfbute9vdUxNfG+w 6eSaFGwA=
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Add support to dirty-ring on dirty_log_perf_test, so we can measure
performance differences when we change / improve the mechanism.

One major conflict I had in this set is that dirty-ring needs to be
enabled after the VM was created, but before any cpu is created, so
for that, I made a few changes on memstress so it can actually take
dirty-ring size as a parameter for VM creation. (Patch #1)
I honestly don't think it's pretty, but I could not think on a
better way of doing this without messing too much in the code.

Also added some checks in dirty-ring enable, so an error message on
ring size is more informative.

Please provide feedback :)

Thanks!
Leo

Changes since RFCv3:
- Using acquire/release barriers to make sure there is no reorder between
  incrementing iteration and summing the time spent on cleaning.
- Improved ring-size checks, although not perfect due to reserved entries
  affecting minimum size.
- Do not allocate bitmaps for dirty-ring tests, as they are unused.
- Improve help text
- Make sure ret==0 before going back to vcpu_run in dirty-ring case
Link: https://lore.kernel.org/all/20260708152232.2568907-1-leo.bras@arm.com/

Changes since RFCv2:
- Added mutex to make sure only a single vcpu is 
  collecting/cleaning at a time. This gets us the ability to
  test return values, and not account for kvm.slot_lock waiting time.
- Stuff reported by Sashiko
  - Return value always positive, so assert was pointless
  - Concurrency inflating the time for dirty-ring cleaning 
Link: https://lore.kernel.org/all/20260629105950.1790259-1-leo.bras@arm.com/

Changes since RFCv1:
- Stuff reported by Sashiko
  - Fixed elements / byte size wrapping issue
  - Removed element count due to concurrency
  - Testing exit_reason instead of ioctl return value
  - Some nits
Link: https://lore.kernel.org/all/20260624171656.1737580-1-leo.bras@arm.com/

Leonardo Bras (3):
  KVM: selftests: memstress: Add option to enable dirty-ring on VM
    creation
  KVM: selftests: Check dirty-ring size before enabling
  KVM: selftests: dirty_log_perf_test: Add dirty-ring support

 .../testing/selftests/kvm/include/memstress.h |   3 +-
 .../selftests/kvm/access_tracking_perf_test.c |   2 +-
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 128 ++++++++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    |  21 ++-
 tools/testing/selftests/kvm/lib/memstress.c   |  34 ++++-
 .../kvm/memslot_modification_stress_test.c    |   2 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |   2 +-
 8 files changed, 167 insertions(+), 27 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0

