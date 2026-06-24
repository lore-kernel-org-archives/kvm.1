Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24B3630B7;
	Wed, 24 Jun 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321447; cv=none; b=k8fid4yTJxHCy+ZRFMNfa1aeaqHQj9aVO2vTUnSQBfvdOZmRehhbLq8S2TUr0f6TuyJDMaQgqDxC/p7yL/TN/Nc673zI+BghNHiCSas5/e77BDLo9fFH+xyXL9hv7oR/ePz48BCEE+TJU7wtsYOqxl09d8VoMGZISBTcorXm5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321447; c=relaxed/simple;
	bh=32/0HEYv1mzY/swRe7WIiMRfh4Gms8oNhET+0hf5Ptg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2xNGgI67NKhkCcvjo9FSys9WS5mowu97O3xcOtXR2vV0HH5aAU4mggqUhF+CO0kqwjNr3xn9zYn0RjVMnK/KtAFw5CYIup3IMuJ+WlvQhCaqrLAAxDboGf4v2M02kmIkP81g/dqfhoc8ou2QfXO4niTCDEXbFf01XHNBLCCYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SIYZfYjp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SIYZfYjp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D721713;
	Wed, 24 Jun 2026 10:17:19 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F4B3F905;
	Wed, 24 Jun 2026 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782321443; bh=32/0HEYv1mzY/swRe7WIiMRfh4Gms8oNhET+0hf5Ptg=;
	h=From:To:Cc:Subject:Date:From;
	b=SIYZfYjpHli+ifYQUJSv3FTpiZDKR2MlK9jF5GrtyuoQR4hmz4isDcqFBV32sshGq
	 Ec4VjxguEwxW7H6gX+OnIZSZ2JlbPKPi1dokRadj4QuMqz+WlX4+zhq34gRRKQdPdr
	 Fh03VemCCJtbHKCC5NaBNyvLPai1M4xBBOYUNxGM=
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
Subject: [RFC PATCH 0/3] KVM: selftests: Improvements on dirty-ring
Date: Wed, 24 Jun 2026 18:16:46 +0100
Message-ID: <20260624171656.1737580-1-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=leo.bras@arm.com; h=from:subject; bh=32/0HEYv1mzY/swRe7WIiMRfh4Gms8oNhET+0hf5Ptg=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJsBG6y8xtHbUuMC/tl/WzDCtdVF56q9hqGhB4LmXDVK XuLzxHLjlIWBjEuBlkxRRbZR/NX8XyfknHkyo8FMHNYmUCGMHBxCsBEmHUYGfZ5ica3S/Lpb25p dz96l2NF6KaHX1uabBfeVJqw4IJ9dzzD/5L0TX8lbqwoCGXSyMtf/e6T32UZmQXp28Se3+r337p wDgMA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Add support to dirty-ring on dirty_log_perf_test, so we can measure
performance differences when we change / improve the mechanism.

One major question I had in this set is that dirty-ring needs to be 
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



Leonardo Bras (3):
  KVM: selftests: memstress: Add option to enable dirty-ring on VM
    creation
  KVM: selftests: Check dirty-ring size before enabling
  KVM: selftests: dirty_log_perf_test: Add dirty-ring support

 .../testing/selftests/kvm/include/memstress.h |   3 +-
 .../selftests/kvm/access_tracking_perf_test.c |   2 +-
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 .../selftests/kvm/dirty_log_perf_test.c       | 100 ++++++++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    |  18 +++-
 tools/testing/selftests/kvm/lib/memstress.c   |  34 +++++-
 .../kvm/memslot_modification_stress_test.c    |   2 +-
 .../kvm/x86/dirty_log_page_splitting_test.c   |   2 +-
 8 files changed, 140 insertions(+), 23 deletions(-)


base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
-- 
2.54.0

