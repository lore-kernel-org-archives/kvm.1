Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233D26980F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730796; cv=none; b=eyg4nitV1t/ounWrGTfUyRB8m0RGpu3n6rC7wrLcoCUQvDl/QsG3PFKpLt7pLrn/McFFeORURT0CvI7hx3dYGxsokpHfxnHeBWFsfpx6SEfq9Yklmp2kia1vgP3xAnSJIfHc5iCXes530N4aGh/SCtKZUGwnr+Tj+xYQn/Kj49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730796; c=relaxed/simple;
	bh=nZVpUvx5AQvbKSH5YPwgjyfYyBgITiSYaMBvl4cj0fc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GY/fdXvUWMNTJYV8ofYQR7U23Be7rtOsCozD+wPsX6KX2RVBAytpzDhDdAhz2MOeSqRGGHuzyTHh0bl6/arocbggpOs7BituFPrs9xYcMNHkx3Wg2vQCrpxAuEY2HWVF8tG1eFekdzLYDNqUH0gPdPbTKTgeU+KD32/ijPZr/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uogR/M3i; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uogR/M3i"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso7448274a12.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730795; x=1791335595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wq1QZOG797G232Vsy9NFaV758QyHdDfDDTQoDwXsKLk=;
        b=uogR/M3ivca3qHW3crbHaIK8+miyKdqnC3KsAjsaMORTL5matp+HhUNWFrSTEXElaQ
         5zBHGVw24IMDpfJVOA3Mx1BOQYFmLDPgsQYcjyuccGkOKOpCI/xBSAoYkvjEMq3SAtFV
         dPv4cFZTZ/ZwVYvIMkztL5inmnmN4Fdnrb91PtZxtMI84I0wldmQiWcZdlX8Q4nKbpf2
         XT1+T5Q1bkSrtvz8ePHlSQFRRuKHoBa9wHMgYpsblWxgvppZsyPOFfPzApJTsTPxug1D
         4HFt4ZJoDdp6GESf0OPoq2lfaFbe9qwpXWm1NtFyUfGsgZVaTg8KIEjJFcEd18OkzOv5
         TnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730795; x=1791335595;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wq1QZOG797G232Vsy9NFaV758QyHdDfDDTQoDwXsKLk=;
        b=rf8HMiSBY8fn7eDFpvVjg+2fjFI/p/DwdV0+z86zjYujiLgZ4VeppLqkW7nTjGVh4I
         RpkmXN/5fi/S8MB8o+qqQqfjPgvB7jeOBMxH36EeEFVlpH9CUt+SisSZT8GlV/wOUPIs
         b2RP35YtqW+mK6irr5CIi1o9H7LuskkvSgl4fAr58inwI4Jj9bQ4ctuBx4xwOwHeBGJw
         HE863DmXMjeCR2Bhtm2WXc31ZQFK0yTEF3VicWHnneS5UDoWZN0dmwq/h2AZ9jenQ+V3
         0ItfFp0RGSPByoYCajHVg505xOxAf6hDI7ciiT5xFGu0NBnVmT/4w/A20xJpssxIyc7z
         GABA==
X-Gm-Message-State: AFuF++lK4A41uKbYjDCbjqbuARaToyDIbF1zjsbZtNqDkMqGtFSiZvZl
	JrYViIySePPkrX5Nh7IsYdkDxH6EsnkTprOBSdXgeFjuCdT0WiS/HBO4RU5S/q3bZW7jbD/6OYw
	4vQ23hA==
X-Received: from pgww7.prod.google.com ([2002:a05:6a02:2c87:b0:cc7:c360:1a42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db95:b0:3de:dff:4276
 with SMTP id adf61e73a8af0-3de953ded71mr748127637.65.1790730794614; Tue, 29
 Sep 2026 18:13:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-1-seanjc@google.com>
Subject: [PATCH v5 00/12] KVM: x86: Bus Lock Detect fixes and SVM support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fix KVM's handling of DR6.BLD, and add support for virtualizing BLD on SVM.
KUT tests: https://lore.kernel.org/all/20260925230003.2362261-1-seanjc@google.com

v5:
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
  KVM: x86: WARN if fixed-1 DR6 bits aren't already set when delivering
    payload
  KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse
  KVM: SVM: Add helper to query if LBR virtualization needs to be
    enabled
  KVM: nSVM: Open code check on LBR virtualization being enabled in
    vmcb12

Shivansh Dhiman (3):
  KVM: nSVM: Disable LBRV in nested control cache when unsupported
  KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
  KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits

 arch/x86/kvm/regs.c       |  8 ++++--
 arch/x86/kvm/regs.h       | 11 ++++----
 arch/x86/kvm/svm/nested.c | 27 ++++++++----------
 arch/x86/kvm/svm/svm.c    | 31 +++++++++++++++-----
 arch/x86/kvm/svm/svm.h    | 12 ++++++--
 arch/x86/kvm/x86.c        | 59 ++++++++++++++++++++++++---------------
 6 files changed, 92 insertions(+), 56 deletions(-)


base-commit: a0bc8e1d7a82bb143b8f8f44ae3a01938f37c2ea
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

