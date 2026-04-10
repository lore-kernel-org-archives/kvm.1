Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179A39A7E1
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865537; cv=none; b=eDektoB7r3hWpYUOgRRQ41HTqTH4uEGzWuTgqFlkTH2nrNGHwhu4RZ8O3mB8HGlXWagtJbFHQxvWoIL4khRlg05ow5FOlJbHTkE7Mug0ifIcawv5YdkjfM/zVv594yCdjNLKehSlit9DQUyYrlfdomxRBodzATxVrfcrdUlbAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865537; c=relaxed/simple;
	bh=n53sTQFuaKkPn7LgxmZfFIhgvTw2UGzZsf99/9tK8Ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZsZItCRGJOLUCzWhssspcYWHMieMgWoOc5u9oKUKbp8Ess/k2Peo1UKWldsI/44TgS4KBndmOaP1MBDmX4cMBsVRFPrE+KkLFb9JCvkcm3AO03z5sZbKn7D4e+x7XLxPuVMilbQaXkVyl4BRjz68WnoHm+ipUd7ePdeEiXMphFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiDbVsQ2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiDbVsQ2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2523e0299so64342095ad.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865536; x=1776470336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qts7/CRLTnbH8sAI2gtWB18MaVwGG3b//bnp/wNIqFs=;
        b=QiDbVsQ2iCyYQfI18FmCaU8t9fc27DzCI2p0TxF8UyTBHgmMInshr9E5FQ3VtQd5va
         UDvbFyg2QRjsJ9vbMV6sdYVM2Y/H94iThnRaNvFFJ/FqzlqfpTIh+jeaak8U4xWe0J4W
         ZphMij3JtjE/9NVGdUuvEF8MGkDHrjaP4gYMQG/vK+aDUXvIgG3bQ2rqsOCHcAU0GyT0
         CU5zFAXAVaHmPtFk0uksU72BucxIseWucHcj7/ZLYg4JMRdRY0dlAugARfIdvLZkFnlq
         wyrUY4mMgPrbMYA3VMbDkQWwME6eoojoRy3DmwzCMU730xFjdyX9ZXMfF4qHuPqIvcP9
         8Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865536; x=1776470336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qts7/CRLTnbH8sAI2gtWB18MaVwGG3b//bnp/wNIqFs=;
        b=JFbCeGAIaBJv4tobyn6Yd009W8yIoIOdPgJ29UznsDxT/id7wnoRYmKTTIhgygvRFT
         hAA3exHE6EyAWUPjlP1c8eEtBR3iyQab+m0KAW+ji3X+CkhRZX0k+fkBvBx8ENOsqiF6
         Ajx3L646nJ96rp6yQMzWGF2DO8xE1Ya4FHqcnelwuH3ffX4wFqQx6BoeKcHYP7WgMPxo
         GVteB8e6UiDM3f9L5SI5tpbLjJOVO6NJrVAu5w/zorWOqgtOGDRCGBRl+hgGVmozaQnV
         2OnBxg1ZyI3J9HC8pG4dwU6qQbNrmVewDcPvX3edkF0mi1tQy+SxHjeJIMrYmdHau5UT
         WSrw==
X-Gm-Message-State: AOJu0YyCpIU2d7dqNWb3Pdo5bkbko3XAM+wEHaNcErL2NlZbsmmRE1Z6
	MRiMBT9/XB8gHxJoXwsLNkOXULRXp419j9Te39Rpp8BBuZS0/zEAazlGd2L6hcRm+6eteVW25zu
	1Sfu+CA==
X-Received: from pfbhu21.prod.google.com ([2002:a05:6a00:6995:b0:82a:69ed:da7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:399:196:1430
 with SMTP id adf61e73a8af0-39fe3d82535mr5913893637.20.1775865535473; Fri, 10
 Apr 2026 16:58:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:28 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-10-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 7.1 (short version)
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

This is (obviously) the partial version of the SVM changes.

The highlight is here is the AVIC IRQ window fixes and optimizations.  The OSVW
changes aren't motivated by anything beyond a "someone is wrong on the internet!"
type reaction.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-partial-7.1

for you to fetch changes up to a56444d5e7387effbc61d6b98fe5d68897017fc9:

  KVM: SVM: Skip OSVW MSR reads if current CPU doesn't support the feature (2026-03-03 12:23:26 -0800)

----------------------------------------------------------------
KVM SVM changes for 7.1 (short version)

 - Fix and optimize IRQ window inhibit handling for AVIC (the tracking needs to
   be per-vCPU, e.g. so that KVM doesn't prematurely re-enable AVIC if multiple
   vCPUs have to-be-injected IRQs).

 - Fix an undefined behavior warning where a crafty userspace can read the
   "avic" module param before it's fully initialized.

 - Fix a (likely benign) bug in the "OS-visible workarounds" handling, where
   KVM could clobber state when enabling virtualization on multiple CPUs in
   parallel, and clean up and optimize the code.

----------------------------------------------------------------
Gal Pressman (1):
      KVM: SVM: Fix UBSAN warning when reading avic parameter

Li RongQing (1):
      KVM: SVM: Mark module parameters as __ro_after_init for security and performance

Sean Christopherson (9):
      KVM: SVM: Fix clearing IRQ window inhibit with nested guests
      KVM: SVM: Fix IRQ window inhibit handling across multiple vCPUs
      KVM: SVM: Optimize IRQ window inhibit handling
      KVM: Isolate apicv_update_lock and apicv_nr_irq_window_req in a cacheline
      KVM: SVM: Serialize updates to global OS-Visible Workarounds variables
      KVM: SVM: Skip OSVW MSR reads if KVM is treating all errata as present
      KVM: SVM: Extract OS-visible workarounds setup to helper function
      KVM: SVM: Skip OSVW variable updates if current CPU's errata are a subset
      KVM: SVM: Skip OSVW MSR reads if current CPU doesn't support the feature

 arch/x86/include/asm/kvm_host.h |  29 ++++++-
 arch/x86/kvm/svm/avic.c         |  17 ++++-
 arch/x86/kvm/svm/sev.c          |   8 +-
 arch/x86/kvm/svm/svm.c          | 164 ++++++++++++++++++++++++----------------
 arch/x86/kvm/svm/svm.h          |   1 +
 arch/x86/kvm/x86.c              |  45 ++++++++++-
 6 files changed, 188 insertions(+), 76 deletions(-)
