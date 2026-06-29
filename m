Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD53655E0;
	Mon, 29 Jun 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730809; cv=none; b=nUzLzV7NfDSngqNQnaIKOh5KHR8IBJhgLyqqxwJEKzYHEnF7owQ5kWHJ/fKhgkffYHrqwcddcBoZ+VI3xcUXaLbEbmc3NCGpxjjNwjLRe9bNM9UrnAD1A+78S2eF6dDZ0xmuRVop5cgWHcZPuLe1FQAr0oNfx+mKh8pfMbDT3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730809; c=relaxed/simple;
	bh=U1JouyQnbPUWiYynEm/aHcmLf1+6erd1V094jOPzs+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDwHdp8cC3w1eyuyBgHwMkzm72mE2XnekldnNFtGxwL6Zk2Mpl56JaKsV9ma7/uF+M8qsILpAXJwKu4my2XrL3VZr2bS2KYf6mnqVyviMJ3dJk1CjL+IU9UaGAfOlb1B+eqd5Ndz0OSGRlJy4sTdL+9UUI30e/KPu+UfI4bU1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aH2VZUnz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aH2VZUnz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2546176C;
	Mon, 29 Jun 2026 04:00:02 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 797F33F836;
	Mon, 29 Jun 2026 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782730807; bh=U1JouyQnbPUWiYynEm/aHcmLf1+6erd1V094jOPzs+8=;
	h=From:To:Cc:Subject:Date:From;
	b=aH2VZUnzXrHW/IeeK/So9HQ+sq0afum1qWhpKz3+YSULZXQnaFUsdEnJfQ5yQjMSY
	 N4jVWGvNa327LUbuiQ9YnpKFGxgUSvSZ+GNmlHTtHqdm51ypdbXcXizyXLbhPkvFPG
	 gPWXm05rt0f2luxncJkYy2dshD8tWhXiqQDL7/yk=
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
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] KVM: selftests: Improvements on dirty-ring
Date: Mon, 29 Jun 2026 11:59:39 +0100
Message-ID: <20260629105950.1790259-1-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=leo.bras@arm.com; h=from:subject; bh=qqq665baXvDDIsH8lZ+UjbhohviFd7wON9BIgl9LhXk=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLKc/CvY3x6yDs4SlbXWn586c/X+rDaFLyteTXF4cjn/O 9/rzc+rO0pZGMS4GGTFFFlkH81fxfN9SsaRKz8WwMxhZQIZwsDFKQAT6ZjJ8FcuouzyAyE+ZfUE hadcRXN1L5nxKT838lnwtXuf7Ler2x8x/LO72nEp5RTLxbzMV+oT+Zd3nd/6opybeYF6zkPv7/e YkvkA
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

 .../testing/selftests/kvm/include/memstress.h |  3 +-
 .../selftests/kvm/access_tracking_perf_test.c |  2 +-
 .../selftests/kvm/demand_paging_test.c        |  2 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 95 +++++++++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +++-
 tools/testing/selftests/kvm/lib/memstress.c   | 34 ++++++-
 .../kvm/memslot_modification_stress_test.c    |  2 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |  2 +-
 8 files changed, 137 insertions(+), 22 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

