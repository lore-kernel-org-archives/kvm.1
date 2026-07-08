Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193934D3B9;
	Wed,  8 Jul 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524161; cv=none; b=G8tqGeb8bT40lKkM6o8jAUKUXtjhNyoS00ZPDbCVOLw1Gr9waf3gWH6pilJxRkWZqS/aR1qa/fYFPOgIyvCQN9/XbN+E4GqdhRyiBKQxD8kB7nRSf9ZTJ0IOgoTa0z0vbFgtDEPWL6KpG0nUnHQaY/MfyzUSVim5U0zogDBu43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524161; c=relaxed/simple;
	bh=u245jXYey2rTAk0+WocpyZlRSYJxu7YNViwXRa+QNXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPr7mvLbQngTtVpu1R3tlMOaqRbeadUTOsQ2NOca5EI/gROIiGJgj108FtDaqyryu19QVscLJ4UXXPqtu8Ep3hUyYfvfRPS1YSRbz0TAK4AivfAKa1IWtsTXT55w5Zm2SVc+2PkNSbRm5eAPS1sMNDcgA8wPwRficJwhAdlK+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bnDACntY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bnDACntY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0250A1CDD;
	Wed,  8 Jul 2026 08:22:35 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F075D3F66F;
	Wed,  8 Jul 2026 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783524159; bh=u245jXYey2rTAk0+WocpyZlRSYJxu7YNViwXRa+QNXI=;
	h=From:To:Cc:Subject:Date:From;
	b=bnDACntYEHNna9JYbfUextk87wxSBYAjGdeIhh6iT5hcuJTzH/hhKl9V0bWbvQqTI
	 xDvtRWa3GFtCepKQ8BZ1Cg80A/dg8wDkTOByhQ+bCiNkveP8O1gp/0NVORJ1Gs3NsT
	 IC9Wup22H5i4K2Bro1wR9iR4YIBw+LzmIwIQZTl4=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/3] KVM: selftests: Improvements on dirty-ring
Date: Wed,  8 Jul 2026 16:22:25 +0100
Message-ID: <20260708152232.2568907-1-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=leo.bras@arm.com; h=from:subject; bh=u245jXYey2rTAk0+WocpyZlRSYJxu7YNViwXRa+QNXI=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLL8spUYJGdd7ngt52Xotles4MpjG63ZQfo5Bprqni+Uu LkvHRTpKGVhEONikBVTZJF9NH8Vz/cpGUeu/FgAM4eVCWwIF6cATMSPm+F/4bZHj1fcW1pT8/aP +bc7ZeeclggwV/BH7D1if/jnE8a/UYwMszeInal14ZG4y3Lk7+LlyTuObdg8/67w31M33u06Oeu nOx8A
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
 .../selftests/kvm/dirty_log_perf_test.c       | 107 ++++++++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    |  19 +++-
 tools/testing/selftests/kvm/lib/memstress.c   |  34 +++++-
 .../kvm/memslot_modification_stress_test.c    |   2 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |   2 +-
 8 files changed, 149 insertions(+), 22 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0

