Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC053A3E8C;
	Fri,  2 Oct 2026 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919723; cv=none; b=P8Y0r8s2kR2Dq8gSsyWQmbXBKvRrcN97bT9OIrgr3R+PjbMCRiiWTbwQO7jo1BCRTAXBKcc5WjTFC8wKwwscUqOYnZ0h5Yav04f4D3/LKb+/hnj1MPhlxKatKAH5Nw1rhv6AOq2wu3RQwbUi9nkdKYUJExUsQ1D/F6ccRj/yhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919723; c=relaxed/simple;
	bh=sHUORkIfR48Scor0nLZFqnVzOjJkiUQE6y18t4IgjPc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hFPBna4DxZNDuFa7Q0WtMqky62RARmSO8Z/xm3NqCfKMPFxfg6KxRh1RrcCLdudOV9VA9hWutRhmerDMEZkgrB+W91B69RMbzChMs3nPmgqk0j6JO0UPQLbAUQaoBD2vyaH07LIjhE3ek4LlR6VPYWguyptmtT9UGUJolwiCT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com; spf=pass smtp.mailfrom=ryzome.com; dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b=uUPjtvG6; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryzome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryzome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryzome.com header.i=@ryzome.com header.b="uUPjtvG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryzome.com;
	s=protonmail; t=1790919709; x=1791178909;
	bh=uMx3gQlE0SJ31VYEnFQJwKbaHwDcbSeINK3U5I+P3HI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uUPjtvG6IYLbQdUXA1z1gMHdBTRd7aF4d58R/OC07/5GgSs8BryEEHCX1vxmY17/k
	 y8N2sHZYUJB91+aZ1EyUGQnzjJrD4G19rAB1SDb2MU4nM6HcKLKnK/lKZKKcq54CFK
	 pCx+I5W7sjvnSSm5UqKoqgsk0P2pOY7XFy6fgFcpdzdXpEU+aL06YrLi0H5pbjSy84
	 +TiPlzV9ssONpYrnSZDIrRNMF7VUy2ilI1H6R5uzG5k68bzu6gawrLTntfRJT7un6B
	 nmrfGAfEoZ1klr0PDjBcANXJUFjlcuKswGTLLCjOCRKNYUMVpfQ6f+We/rAW6WN+VO
	 1SCB30XfMMRUQ==
Date: Fri, 02 Oct 2026 05:41:43 +0000
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
From: Loc Nguyen <loc@ryzome.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: Fix lost nested APF VM-Exits
Message-ID: <20261002053723.3275202-1-loc@ryzome.com>
Feedback-ID: 78153448:user:proton
X-Pm-Message-ID: ff29ea530413ec5dd2dd0459befe1ab0607544d7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A nested asynchronous page fault delivered to L1 as a synthetic #PF=20
VM-Exit can be lost after KVM queues the exception.  Most callers of
kvm_queue_exception_vmexit() arrive through kvm_multiple_exception(),
which requests event processing, but the nested APF path calls the=20
helper directly.

Without KVM_REQ_EVENT, vcpu_enter_guest() can skip
kvm_check_and_inject_events() and re-enter L2.  A later VM-Exit can then
clear the pending exception while reconstructing vectoring state.  The=20
APF reason remains PAGE_NOT_PRESENT, allowing a later regular #PF to
consume the stale reason.

Patch 1 requests event processing in kvm_queue_exception_vmexit() so
that all queued exception VM-Exits are processed before re-entering the=20
guest.

Patch 2 adds a regression test that holds an L2 backing page missing
with userfaultfd.  The test verifies that L1 receives the synthetic #PF=20
VM-Exit with the expected APF token and PAGE_NOT_PRESENT reason.

Testing was performed in a nested VMX environment:

  - x86_64 kernel build with KVM_WERROR=3Dy
  - nested_apf_event_test fails on the base kernel with a lost nested
    APF event and passes with the fix=20
  - full KVM selftest suite passes
  - kvm-unit-tests VMX suite passes with TIMEOUT=3D900

Loc Nguyen (2):
  KVM: x86: Request event processing for exception VM-Exits
  KVM: selftests: Add a test for lost nested APF VM-Exits

 arch/x86/kvm/x86.c                            |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nested_apf_event_test.c | 306 ++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_apf_event_test.c


base-commit: b378201ccd5280d0fff89bbe55e1eb00620ec0d5
--=20
2.43.0


