Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55233A9DA;
	Thu,  5 Mar 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742625; cv=none; b=eLqAhlPiCwYYo2pfGqDOkm7uIADvCTghfTfofuVpwoU0VURecfp+IBGXEw0Gn2s0Ua9e+QPNOqWc9M/1odxfi/B+D0pcGmydy2jkc+gynTigyoJE/A224G46Z6Js1H61cT6AXiG7sbnJ4XBwgAsOLeoTDNbyObKKGa/90zmWuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742625; c=relaxed/simple;
	bh=7V2AL0ZPto6MM+QjVkRasFLILnR+/GavNDnwdDmHzdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5nCoz2D7j4Cp4YI6nGUc63lVa+zjEOhzxfa/O/bj+Sk+Y3gXMLUQ9ZVBFZWQK88WXoZwwta5VU/qC8brh1cqFw/SVtyDggQCEFhoLHUKi+qDwKvTGSZXeYztE+T4WJVZbqVxWjM+ZbgaIZjMDZ9V28+U8r33mzMFJ8CVyvATAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Bwp+RG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Bwp+RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802F3C116C6;
	Thu,  5 Mar 2026 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742624;
	bh=7V2AL0ZPto6MM+QjVkRasFLILnR+/GavNDnwdDmHzdE=;
	h=From:To:Cc:Subject:Date:From;
	b=g/Bwp+RGfAS3AmaIonVSRF6UTSYZ+PIfaTObzRiYLBvq2DdD/duwW/YhPEUrFRD/j
	 w7h/khP8395T2f76vhzy1Gh6hrtYMgN1efSlkT6ubqGF8dH3htFTY7OC+8S8kDwRWP
	 DDxtgpKEhEbZvq8vn1918rVUrTMyY5W7O+dOHf8l/ShoHG/PMYuunHEONqOq1qc967
	 1sI+q3e4NjVgqBc2p+nS3C+LvVwR/m3ijjmn5vl9Tdc5hRJ7rVI0UMx6tl9uPwHApT
	 eJBknrXq1TNSai6ztl6zdPfA6w7hf7jNUlNdnh47vxyW1/MmxdEF8WsOdu6Ire10/7
	 mOzKeXrX61uEw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/2] KVM: nSVM: Minor post-war fixups
Date: Thu,  5 Mar 2026 20:30:03 +0000
Message-ID: <20260305203005.1021335-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixups in the aftermath of all nSVM patches, the first one
is just a cleanup suggested offlist by Sean, and the second is a fix for
the test to make sure it's checking #GP on VMRUN not VMLOAD.

In all honestly, I am not sure *why* the test was passing and a #GP was
generated on VMLOAD with a very large but valid GPA. vls=1, so KVM
should not be intercepting VMLOAD (in which case it would inject the
#GP). A #NPF is generated on the VMLOAD, and through tracing I found out
that kvm_mmu_page_fault() returns 1 (RETRY) to npf_interception(). There
shouldn't be a corresponding memslot, so I am not sure if KVM stuffed an
invalid mapping in the NPTs, or if KVM did nothing and the CPU #GP due
to an infinite #NPF loop (although npf_interception() was only called
once). Anyway, figuring that out is irrelevant to the fixup, which makes
sure we're actually getting #GP on VMRUN.

Yosry Ahmed (2):
  KVM: nSVM: Simplify error handling of
    nested_svm_copy_vmcb12_to_cache()
  KVM: selftests: Actually check #GP on VMRUN with invalid vmcb12

 arch/x86/kvm/svm/nested.c                     | 23 +++++++-------
 .../kvm/x86/svm_nested_invalid_vmcb12_gpa.c   | 31 +++++++++----------
 2 files changed, 26 insertions(+), 28 deletions(-)


base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

