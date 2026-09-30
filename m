Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79953ED13E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796999; cv=none; b=KlTlr0nTUr7EgC9TJSfgUiasibIndu1cD6x9qqps6mw+Ys+c/9+lL3Dq5fAgvlriUxYDCDP5o3EdAMvEzN3wRKNCzjpJgdlfyeZCg9Rp7ULGTK1+4ZgkNnxTVF1L6li5BnE/V+dYaFx7rujCO54K7vxtcZltgjCF8GHusKnw5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796999; c=relaxed/simple;
	bh=77cOKYDudr1TEdNRDm2bVnQW7qyEYvzfT9gxriNC6+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XfGO7VkkKlws9Q5vmyIKcUd3CT0WO+tUjotdluZ1kpuwkrvryGLKeVCYUixC3bM9/t2PeaRHkXK2aEROuhg5Ea6qX3W+mAXr3D/Thy0wj7KA2+d0zvVAaSo/0CvFjev12TrVVXdXlKRq1JSK5OuEEpSejAuzEF4GSyspXS/uULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afMdwT6h; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afMdwT6h"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7cc8bffedso2029953a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790796997; x=1791401797; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZeAOsvNrl/bW9BvBMAcm5dlJNIrYZoFS8Ka/3aN/x8=;
        b=afMdwT6hP3bl7LAHp58XShc7BcsURj8bMXuvJUGeBguMGTYurgTKVY/cBx1/K5IUGn
         L9hi1B9Vu4DKFmXfC9ItWMRGU5n/wkLW7rBaadZHX+KzH2JFTTQHYVEBJRRmPFEUSeeh
         eiim6OXK7NmGgLBT4LrITMIufuEN5MoD8ewc/m07+TPg8507XBxKImsYJOkc8QO46gJo
         nse96dV8ifoqLBcpZFWqFeWy92qedvRyj4UG/Z+KCqLZ1eyC+zFfZQ9C8VW+3LkfEeKX
         45ge62BZF/+zYu/krNVHLvqEkPwOyvhTuHNTd161oOxA5qMhwHg42S/S1rLSXQlyHfcL
         Xr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796997; x=1791401797;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZZeAOsvNrl/bW9BvBMAcm5dlJNIrYZoFS8Ka/3aN/x8=;
        b=ML1omVV8jaorARxXCvyz+qdn3wAtQdaWFIwtqSih+oED8QBvhKfL4c6TcI0qv4iHT/
         ixg2+o+aomppHOwTkPCXRTR+RX8vC3XSC46XJE6Z1H2LmjT9spHy8xLd9vRgiLFuG1LC
         AyVUMIH1BavD6szXxUhj/0h/dQSvk14IL90etMIx+RVDLsGRYL/KFr4eoeEk0+IdWa5p
         bp8aLEZ1vlcBZ6a2p47PDu50V1frZsIV6Aq9DkLKCm2KqAQl7pwtdf92OmRTOe2v7tgJ
         zpsbP0YhhVqxPXC7d05bt+T/OxRIm2y2PuDHrIfkFvwk5ggCXD2p7+IT7+W/myEh02Uz
         ut8Q==
X-Gm-Message-State: AFuF++kiPX29EhLsetOvtlnnP4P74ikEOS9qGP38EQNL/hApHRRgv1OE
	FfY0cFE4XU6Zz23Hvcre7QhQVAcs+9cgDBgCHd6w+PvyszPJ6/Q73MJU6D5fDsnK9KNz9DZi2MN
	nNrvNzQ==
X-Received: from pgbdv15.prod.google.com ([2002:a05:6a02:446f:b0:cc7:30b4:f06c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7001:b0:3d3:aec2:4dcd
 with SMTP id adf61e73a8af0-3de9e6dc7a9mr2629253637.25.1790796996939; Wed, 30
 Sep 2026 12:36:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:22 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-1-seanjc@google.com>
Subject: [PATCH v6 00/12] KVM: x86: Bus Lock Detect fixes and SVM support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fix KVM's handling of DR6.BLD, and add support for virtualizing BLD on SVM.
KUT tests: https://lore.kernel.org/all/20260925230003.2362261-1-seanjc@google.com

v6:
 - Throw in the towel, at least for now, on WARNing if KVM sees a DR6 without
   all of the fixed-1 bits set. [Sashiko]

v5:
 - https://lore.kernel.org/all/20260930011313.3197688-1-seanjc@google.com
 - Fix the DR6.BLD clobbering bug Sashiko pointed out. [Sashiko]
 - Force-set fixed-1 bits after synchronizing DR6 from the guest (because the
   guest could set bits that are supposed to be fixed-1 due to virtualization
   holes).
 - Open code nested_vmcb12_has_lbrv().
 - Fix the Author for Ravi's patch.
 - Add svm_need_lbr_virtualization() to preserve short-circuit logic.
 - Rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1().
 - Invert svm_get_debugctl_reserved_bits() into svm_get_supported_debugctl()
   to match VMX, and KVM's preferred style.

v4:
 * Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled() (Yosry).
 * Drop the redundant !lbrv check and the extra comment (Yosry).
 * Spell out in the changelog what breaks when DR6_BUS_LOCK is forced to 1
   (Nikunj).
 * Make it a pure NFC macro-to-helper conversion, and move the
   BUS_LOCK_DETECT gating to patch 5 (Nikunj).
 * Fold in the DEBUGCTLMSR_BUS_LOCK_DETECT gating moved from patch 4.
 * Collect Reviewed-by tags.

v3:
 * https://lore.kernel.org/kvm/20260709082953.69434-1-shivansh.dhiman@amd.com
 * Reworked the single v2 patch into a prep series (patches 1-4) plus the
   feature.
 * Rewrite svm_update_lbrv() as 'if' statements so the BLD LBRV
   dependency can be added cleanly (Yosry Ahmed).
 * Sanitize V_LBR in the nested control cache like NP/GMET and drop the
   redundant X86_FEATURE_LBRV checks (Yosry Ahmed).
 * Use kvm_dr6_fixed() for nested DR6 instead of DR6_FIXED_1 | DR6_RTM.
 * Compute DEBUGCTL reserved bits per-vCPU, gating BUS_LOCK_DETECT on
   guest CPUID rather than a static macro.

v2:
 * https://lore.kernel.org/kvm/20260629081018.60618-1-shivansh.dhiman@amd.com
 * Rebased on kvm-x86-next-2026.06.24.
 * Used guest_cpu_cap_has() instead of guest_cpuid_has().

v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com

Ravi Bangoria (1):
  KVM: SVM: Add support for virtualizating Bus Lock Detect

Sean Christopherson (8):
  KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB
    payload
  KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
  KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
  KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
  KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload
  KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse
  KVM: SVM: Add helper to query if LBR virtualization needs to be
    enabled
  KVM: nSVM: Open code check on LBR virtualization being enabled in
    vmcb12

Shivansh Dhiman (3):
  KVM: nSVM: Disable LBRV in nested control cache when unsupported
  KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
  KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits

 arch/x86/kvm/regs.c       |  8 +++---
 arch/x86/kvm/regs.h       | 11 ++++----
 arch/x86/kvm/svm/nested.c | 27 +++++++++-----------
 arch/x86/kvm/svm/svm.c    | 31 +++++++++++++++++------
 arch/x86/kvm/svm/svm.h    | 12 +++++++--
 arch/x86/kvm/x86.c        | 53 +++++++++++++++++++++++----------------
 6 files changed, 87 insertions(+), 55 deletions(-)


base-commit: 7f734412a73e910658dc81ba74f76af789202f58
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

