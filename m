Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE0397E96
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865533; cv=none; b=ZbgoNECgE1fJa1e98jMXug7hGBYj6EkmMr0mXitcWuod2k+AOkC7HRb+I6508WOcfHcDvj6G1UcHTbXCQggT2p1izNgbEICcTXC4ognAVNNDmKIWObGpC0CFu90Wim+9ABC2vNN48/wv2z6tl/44KF7ignjMdd37HarTvpZrnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865533; c=relaxed/simple;
	bh=BYP2BlZAB86SjrMb8YfWCEihHn6gUtP7ONBc/rYyLJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGeVSdZuWt4W1tVGPrYnhYZgIZuYk/FkiclnzaAo2KSClVOVGcLguxgmxFXFu+2EG22MuU5TOK8DcQmdDHcrTm+sI0RymEhvrV6ywsBfFJOUUGHCjRorChHTygslbgd4sGRrYeOSFGqToyStX8NMDzoYz0U5RtyB8CGy3shu+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k62N3udE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k62N3udE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c8768a704so1283374b3a.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865530; x=1776470330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Ec2FkmEeV6GaLyY32HLaVrPq9V1fSplSGwGg3Xi9U=;
        b=k62N3udEun7hRX0aN0vErrKn7n4Nvn3YW6q4dq9EohPP3xna5wwFw9gFSdKzWB0xPq
         MZMnQ7uXcMCW/8/1mba0G4XE6DPZXoFlowH3qhLtWEaQx8FBaI+Ij9fW7Emb5vjXacNB
         mQidJUPA8WgwDwKHoxEQIg3xVKclKPw/npBysvItpcxLrwbgaeb+uqoVf2URKXL4vCS7
         usaVRJmHdKuS3/tqqnwcy87v9JU4dwVHoN7Sfo9W0JB9Aqeq88uTIubtJfhIcxnmYPVQ
         1VJ4pWi0JGFAXN9D+LqoI+vg1uXRRIvYQiJeLDRK47pbmgqGy3vykge2Vkq15tTUHOHe
         hHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865530; x=1776470330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8Ec2FkmEeV6GaLyY32HLaVrPq9V1fSplSGwGg3Xi9U=;
        b=dhynt7TTWOIBVMdySwE99qcvHv4ZqO+StrSex5rRBhT3pYsJVTDlEbiJ07VRM+ypST
         /uzkqMXY+HMQpFJdU5aIeYGsdqhyI72iDyio/s8W55xsD6MwsTsZUEynSvByJqXvZVy+
         A3lDqlF6xKXCLQ1l9R/9ZK/7Of+/WjvakTPxoZWRKdEOJJyL9VJXaPeRg0WxqtjSg+mU
         lY5gYv5A6n1kW/5CWUe5rV53nVdCRm8dsLcDcHUulImnhRnT+SstYPKcFydcCmrEiiLy
         94xm9YQt3F3FFWdPYeelC+dloFt27dTPSEqiSCWZ6CEAJWaxV7TR0dOmcXrMJh5bK9zV
         t6nA==
X-Gm-Message-State: AOJu0Yzxl2cHXiOSx1nyT7QDc5WfeyabUKbKeqGaT3HTbfOqu0u5yX8t
	X+Iu3wMw8RSEtUQ3AzH2HuwMLk3DLRw+XibEjSwSbNC+9mQlMCiE3dlifM/tcJymDtRrxYU3vrZ
	Be1vrow==
X-Received: from pfff14.prod.google.com ([2002:a05:6a00:bd0e:b0:829:7f86:623])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12cc:b0:829:8041:83f
 with SMTP id d2e1a72fcca58-82f0c25e4e9mr4968920b3a.7.1775865530067; Fri, 10
 Apr 2026 16:58:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:26 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-8-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add Hygon support, fix a related bug in the MSR test, and add MADV_COLLAPSE
regression test for guest_memfd.

I'm also going to post patches and send a pull request to convert selftests to
kernel-style u{8,16,32,64} types after you merge all initial arch pulls.
Please yell at me if you don't see anything on that front by ~Wednesday.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.1

for you to fetch changes up to 9830209b4ae8c8eecae7e6af271cebf1e1285142:

  KVM: selftests: Test MADV_COLLAPSE on guest_memfd (2026-03-04 14:57:27 -0800)

----------------------------------------------------------------
KVM selftests changes for 7.1

 - Add support for Hygon CPUs in KVM selftests.

 - Fix a bug in the MSR test where it would get false failures on AMD/Hygon
   CPUs with exactly one of RDPID or RDTSCP.

 - Add an MADV_COLLAPSE testcase for guest_memfd as a regression test for a
   bug where the kernel would attempt to collapse guest_memfd folios against
   KVM's will.

----------------------------------------------------------------
Ackerley Tng (2):
      KVM: selftests: Wrap madvise() to assert success
      KVM: selftests: Test MADV_COLLAPSE on guest_memfd

Sean Christopherson (1):
      KVM: selftests: Fix reserved value WRMSR testcase for multi-feature MSRs

Zhiquan Li (3):
      KVM: selftests: Add CPU vendor detection for Hygon
      KVM: selftests: Add a flag to identify AMD compatible test cases
      KVM: selftests: Allow the PMU event filter test for Hygon

 tools/testing/selftests/kvm/guest_memfd_test.c     | 70 +++++++++++++++++++++-
 tools/testing/selftests/kvm/include/kvm_syscalls.h |  1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  7 +++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 15 +++--
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |  2 +-
 tools/testing/selftests/kvm/x86/msrs_test.c        |  4 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c      |  3 +-
 tools/testing/selftests/kvm/x86/xapic_state_test.c |  2 +-
 8 files changed, 92 insertions(+), 12 deletions(-)
