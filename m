Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654118;
	b=J5aGFpy2jI8pbZ8thzTJVq9f8GvhH/yi4ec+zOynSg1pMzk4Ir4ufz1Ilslo2rM8iczm
	 MAWSHzZte6zigFK1OAUBI3kPf5sFP2jBbMe7aF8Ig7bLvMFYKvkZyPDx2oLqpv3IUA6eE
	 pg3cVsiuURDSspnltjqTRp4yMFxKjWzBx4ptj/ZuFBaaktbXQ8snbHpwAzv/cpR7rcSI5
	 zXy+0JJbOA1KCgHskPiOZKVcphFV6TCBK7xq/YX4RdHW+9B6/ortJO1ClWHGeyesmdyh9
	 aEpev8V2iMmHLmXQjIED8VxRMfd50LAO5Nt7EPg5UZ9/jIjnETTzubF40dTFB8+Uejw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qKgFuX3AqqosK6uLUy0wJd8N9pPqVcP7wNNqRkdSZsI=;
	b=J3n1hRDAJa2tT0thKwxZS4yWnUSzxcPDxlSyvcyasTKlWROgCostsOh2MTj2zrDK1rxk
	 pKJ5tgmeXCEsVOW9a0kIitnB2ne6Lu8cx7yYN9BdKJ0G+qJyxCFjyFUdYstWvvWwDL7cq
	 7RCiNU65c8T8gQRgggXA5hSd874DqwgTMcVhKpUjSxDoXRKWKAQGatGeHR8w/C3znLYMC
	 AHEOWLcjdYRvqVTrqKvs+YWigZ5T8pcY7+pomwZGrltJhbLYuh/f5GEXyg5VK4o+CCcPC
	 6hQscUBCaGWHbgzBimGAFkh47+SG1rkElLX1XnBgWdQKeRFFQBYIeBhOyDGI6iCdQlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaGHRqeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB0606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaGHRqeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923AA1F000D0;
	Thu, 26 Nov 2026 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654117;
	bh=qKgFuX3AqqosK6uLUy0wJd8N9pPqVcP7wNNqRkdSZsI=;
	h=From:To:Cc:Subject:Date;
	b=KaGHRqeWAz9arHt+nLA+QjtrocvdiUYq+xPpzPhI7iYfDqwZ4GhIHvhu/cbGGJOkU
	 598f0c9RpHKAzzBZdQzh6u/g8bOISPmgGq46E3qmzr6jK1LzZInQtjU6SDYX2Onog3
	 SdMIWhR/vNOmGgKaEJrfyjoQ+tgjSFLwR0hsKFYvVPI6Cc2EBBVFRodJ1csvF2LoFy
	 0fD/EsN0RarZwK0LYV2BWAY5kGvVOTSPWG8UeTVNpUm+t0XHTWi8Pl8Ei0FiIkZ6mU
	 d+JC+Ax4d1eVkWzhf3sz2+Sxb5uqL5o9uU8pupJKjMs60zfIGUoChQus8hsZw5nXTI
	 VS9b0iF59we7w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 0/3] x86/pmu: Restore emulated instruction test coverage on AMD
Date: Thu, 26 Nov 2026 00:48:28 +0000
Message-ID: <20261126004831.2712453-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7999ff1d28b0 ("x86/pmu: Treat all AMD CPUs as having
instruction/branch overcount errata"), check_emulated_instr() only
checks that the instructions and branches counts are at least the
expected counts on AMD. That always passes, because AMD counts each
VMRUN as a retired instruction and branch in guest mode, and the 10
synchronous VM-Exits in the measured window alone are enough to reach
the expected counts (and overflow the counters), even if KVM doesn't
account for any of the emulated instructions.

Patch 1 fixes a false pass in the ">=" checks when a counter doesn't
wrap, which predates the errata change but now affects all AMD CPUs.

Patch 2 accounts for the synchronous VMRUNs in the expected counts and
presets on AMD, so that the checks fail if KVM undercounts emulated
instructions.

Patch 3 adds a check that the difference between the instructions and
branches counts is exact on AMD. Every VMRUN adds one to both counts,
so the difference is precise regardless of asynchronous VM-Exits, which
catches KVM over- or undercounting instructions vs. branches unevenly.

Tested on AMD Turin with KVM's mediated and perf-based vPMUs, and on
Intel Granite Rapids, with and without injected (simulated) KVM
miscounting to verify that the new checks catch it. With the perf-based
vPMU on AMD, "emulated instruction: branch counter overflow" fails with
and without this series, due to a KVM/perf issue with periods of 1:
https://lore.kernel.org/all/20231107183605.409588-1-seanjc@google.com/

Yosry Ahmed (3):
  x86/pmu: Mask emulated instruction count deltas to the counter width
  x86/pmu: Account for VMRUNs in emulated instruction checks on AMD
  x86/pmu: Check emulated instruction/branch count difference on AMD

 x86/pmu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

-- 
2.56.1.911.g883d8bcb20-goog

