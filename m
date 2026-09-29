Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D8E5158B6;
	Tue, 29 Sep 2026 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681883; cv=none; b=Z0r38Yue/FUWauZDtZ3e0/5ujIi5wFmX8n9MKQKypW4/FeVGCtQa98+0qk8Q57K6msElv68jTUvUNt8pfocp22VGB4xMRw1Y5jIY4NDFgbLjGbYrNPHXXcE3ROO2Xb4ENvf4/WAX7PzT6w3geOqqNr2np56mwjmhPQJoVzPAzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681883; c=relaxed/simple;
	bh=tqjmlp+/lUnMUWbQnrX31y/+aHqlRJRtl0e4XiSbrZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0ugvnN1OV3r1GQzXXTd9ecfGW9XyjjC5BXyKXZVZSyDmnjJ9vHbmPDDzDw1g4hGkdbEH4KDrchDVglcqZ8NJMKRl8ahvR4TickgOatWDoII0rF8h17XGrTDsnSVLNGiyy32FwLzjq7q33yAhTbJRdDCWYe/cmI1ETXEl7cWq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d0jXuIL/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d0jXuIL/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B629C1476;
	Tue, 29 Sep 2026 04:37:56 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F40D33F85F;
	Tue, 29 Sep 2026 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790681880; bh=tqjmlp+/lUnMUWbQnrX31y/+aHqlRJRtl0e4XiSbrZM=;
	h=From:To:Cc:Subject:Date:From;
	b=d0jXuIL/6Emp4J/TGs+f2eNtHj6eC2hd23MA10VhpzQ3oX5codkrdBvd36sYXREKb
	 wHYjOdCMGCYCRWksplqCqoSYQsrLey51qyF2LE0dbXjQNTmdPNX1v/AIb9N210rlcn
	 If/6UsSAoT/YifI0XMo6LFEJ8PZGxXtnEcR2pmqw=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Josh Hilke <jrhilke@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] KVM: selftests: Add support for dirty-ring on dirty_log_perf_test
Date: Tue, 29 Sep 2026 12:37:05 +0100
Message-ID: <20260929113711.2064390-1-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=leo.bras@arm.com; h=from:subject; bh=tqjmlp+/lUnMUWbQnrX31y/+aHqlRJRtl0e4XiSbrZM=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJ2L5r+tcx4B/ODecnZDSUiZYXz+VLmZS2yP2O6QG+PX Mwpm5mLO0pZGMS4GGTFFFlkH81fxfN9SsaRKz8WwMxhZQIZwsDFKQATcf/DyPDdUOeawynG6om+ Utf2xdW85QvoL/7oMvNpq6dV5vYAJXWGP9ysr65NYnjHkxNU9/7jApHWin21KySMb6SldUw5rfN QgwUA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Add support to dirty-ring on dirty_log_perf_test, so we can measure
performance differences when we change / improve the mechanism.

One big change in this set is that dirty-ring needs to be enabled 
after the VM was created, but before any cpu is created, so for that,
I made a few changes on memstress so it can actually take dirty-ring
size as a parameter for VM creation. (Patch #1)
I honestly don't think it's pretty, but I could not think on a
better way of doing this without messing too much in the code.

Also added some checks in dirty-ring enable, so an error message on
ring size is more informative.

Please provide feedback :)

Thanks!
Leo

Changes since RFCv4:
- Series title 
- Rebase on v7.3-rc5
Link: https://lore.kernel.org/all/20260729161519.3778839-2-leo.bras@arm.com/

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


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

