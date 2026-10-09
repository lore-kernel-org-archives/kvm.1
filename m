Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D22931F7;
	Fri,  9 Oct 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550900; cv=none; b=EGAmE4Rv/fm32t/d0AEnoDztic+9bhknDGg8YXOcWi8sv2qbsmdAsz+Tk2b+ClUEMU7SeAkINLZJvZd/cz4ff82ZzmK3vSR4T7G8AF+8aVVjh3x+eUeglnE4mSMex4NiWo/ywyWSiL0LevIWpteenJYR+bTmiT8i60KZcV3sn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550900; c=relaxed/simple;
	bh=Yr0csg8n11gSHouKR25AWi4XRz98sjteLRNEiNNgFHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXCiY11Z196ZD382ymYLh1qL2ufTBehh+RVB0Kr3DoXbskiEdx8zRa0NfE7CgpmNdbpvGl+mMfZoCw1Vkl15t+DCn+beu0TFcZMdE9qrTvKqLiRFrRdDFX6ZfSXG26HA5axEEEBl0ZaWKamXKvAIROos1sxaslKTY7wIPvBUAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QiaEZSoU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QiaEZSoU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2DBB1D14;
	Fri,  9 Oct 2026 06:01:32 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16E293F66F;
	Fri,  9 Oct 2026 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791550896; bh=Yr0csg8n11gSHouKR25AWi4XRz98sjteLRNEiNNgFHE=;
	h=From:To:Cc:Subject:Date:From;
	b=QiaEZSoUY3bacjAXWE8bvvHJR1nA7UlDRrWbL1smyctutQkasEHvSwcS63RvYiaxm
	 2ktEh2CIGkVHlTOX5NJZnySVUDB3Ty5lORy7x9K3QAp8H5x5f9gc6Ni+mzurGr8D6K
	 /P5q8L3qAQ0G6rfA2jVNoUqGD9BW/grWDcSGbzk4=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Josh Hilke <jrhilke@google.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] KVM: selftests: Add support for dirty-ring on dirty_log_perf_test
Date: Fri,  9 Oct 2026 14:00:45 +0100
Message-ID: <20261009130054.3312154-2-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3485; i=leo.bras@arm.com; h=from:subject; bh=Yr0csg8n11gSHouKR25AWi4XRz98sjteLRNEiNNgFHE=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJOPC28c+XfDqWD71OYOnUk1ne2ley9ob3tvsjxC9O/t 8gV/N/b0FHKwiDGxSArpsgi+2j+Kp7vUzKOXPmxAGYOKxPIEAYuTgGYSPUcRobN3Sbi3Nt3lS2U Pr+k40oZkz/7QftbDiWm51Ze8vX58/IxI8P/xSGinPftNjSy90Qlr5mnNsXkTnHaShH5szueb3N UOM8MAA==
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Add support to dirty-ring on dirty_log_perf_test, so we can measure
performance differences when we change / improve the mechanism.

One big change in this set is that dirty-ring needs to be enabled
after the VM was created, but before any cpu is created, so for that,
I made a few changes on memstress so it can actually take dirty-ring
size as a parameter for VM creation. (Patches #1 & #2)

Also added some checks in dirty-ring enable, so an error message on
ring size is more informative.

Please provide feedback :)

Thanks!
Leo

Changes since v1: 
- Converted memstress to take a memstress_params struct instead of a lot of 
  parameters, so it could be more easily extended in the future (Sean)
- Moved dirty-ring cap detection to a helper, so it could be used instead 
  of open-coded options (Sean)
- Improved the error messages in case the dirty-ring fails to setup, with
  a more specific message on what went wrong (Sean)
Link: https://lore.kernel.org/all/20260929113711.2064390-1-leo.bras@arm.com/

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

Leonardo Bras (5):
  KVM: selftests: memstress: Add struct memstress_params, make
    memstress_create_vm() use it
  KVM: selftests: memstress: Add option to enable dirty-ring on VM
    creation
  KVM: selftests: Introduce kvm_get_dirty_ring_cap()
  KVM: selftests: Check dirty-ring size before enabling
  KVM: selftests: dirty_log_perf_test: Add dirty-ring support

 .../testing/selftests/kvm/include/kvm_util.h  |  11 ++
 .../testing/selftests/kvm/include/memstress.h |  15 +-
 .../selftests/kvm/access_tracking_perf_test.c |  12 +-
 .../selftests/kvm/demand_paging_test.c        |  12 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 140 ++++++++++++++++--
 tools/testing/selftests/kvm/dirty_log_test.c  |   3 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  20 ++-
 tools/testing/selftests/kvm/lib/memstress.c   |  68 +++++----
 .../kvm/memslot_modification_stress_test.c    |  14 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |  12 +-
 10 files changed, 247 insertions(+), 60 deletions(-)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.55.0

