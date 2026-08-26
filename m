Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132647A0AB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762571; cv=none; b=CptA6cHhlBSs6WmZov5XhyAqJ4DXOEXmIJUNk5+g2ImvWRfjbbhC8XYf0312Jl0SDueM8x14s6Eb4C8FCoZYZWdKdCRXYMpsZZrl4wM7JbCCP3Fik7afJEnmK4aG/5YtHMVf/QJb7HXymm4TonNly3E02iKBcWicVnSO1RKPO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762571; c=relaxed/simple;
	bh=SUbXpp9dCEW7WnzEf6ifM7tx5RgJp39AuZVGWdWrhN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gFjUIDfGTHm7mpc2MSFuBrezQoaC6dwYVd//ZXvnOS0dxJQSeIuL3dPVoYL7WIZseq4kZt6aFWK6SisWIp3fHi3S2fkxSrDE7Y8vQ5AUkBPlCZx/7BXwsuI+0mKZOx1r39YCdTds0CW+UxqCQWP/VWu6LyY/ckPICVUSgToYPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V62yYS/L; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V62yYS/L"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso2010382b3a.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787762536; x=1788367336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=60ICzOSokLmFbW+aEUbh3rqJ5JJ2ffZEu6ut5rD8ZZQ=;
        b=V62yYS/LfKcnuyEq6nYl0mfBlA/gacdWH58XS9SddKCft2yeWfGf+PA7yRlSne0VAl
         aXpEBEI4N3PZcqaOC4kdqBr4ecLtOyFPYw5ttW84RcWV6QDY2qSOfFam/bao9k/fc2C3
         xgcq/hfzsYQTqmiHlOWxfSdCELgBaqqq26fAypV9apXr48In9yPkvDWdhPVmYSUia/nr
         Z8Nk23Z8gXCqGTBnzz8jBYf8P2DEv69/1moFvS+9a1t1xrH8Pm0CJWxMzsI22PgUuTvt
         GGaammutl2fmCdQN/8MPDiSwU1uh8tVrWlOijapdqSrjnx5FYfYASVvm6EzP5SZ06X55
         1ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787762536; x=1788367336;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=60ICzOSokLmFbW+aEUbh3rqJ5JJ2ffZEu6ut5rD8ZZQ=;
        b=sOTKaGyDA2uYPKwDXYXSf9Zd95KJhesc4hINy3Hny5ail/7b5LBWO3AFO4Vhdu0/4f
         GY9kQajNs7A8zHPZaUw9yL006zU44OI87kfFGjpF4pnu/PVbY2GawPr8SfeyXzFRSmx8
         bShxK+ljOi0Nc+JvvF6YwxOAswdHurFsjs8p5wZzjz+mum0A2J23ZBInuE+3SxBTfO1h
         PneChuFpzZlNtF1QWRBUmYn8R0auxS8pfW5DKBkIHHvwo+cRRKOZGFAFV+kZuGyd+/Li
         gsXbPLVfUZjmObM9KZcyTLo+IwNglpuaZWY/x9J4IfmcU+YCDjoqSrlNIRIzM7kuCQNB
         eb4g==
X-Gm-Message-State: AFuF++mU9W6bcNrJKnczYALh0J0g9Xw0eAV9Et7dVkuIi8UqcWr1OeE1
	PI9tK+5zIBbd2X8SdFnigwG5adqnkQsQ7Ft8K/MIWvPgfgHjddkYl6A3VvdjHAnLO/sfvwx2vV+
	2b9Dv4g==
X-Received: from pfjx5.prod.google.com ([2002:aa7:9a45:0:b0:84b:50b5:d431])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1709:b0:848:6f5c:a327
 with SMTP id d2e1a72fcca58-85376488d15mr13781436b3a.15.1787762536088; Wed, 26
 Aug 2026 09:42:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 09:42:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826164214.756512-1-seanjc@google.com>
Subject: [PATCH v2 0/4] KVM: x86/mmu: Fix pre-fault and map private loops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a bug in the pre-fault path where KVM fails to reload an invalidated
MMU root, which puts the KVM_PRE_FAULT_MEMORY task into an infinite loop
(although it's breakable, so not fatal to the host).  My best guess is that
the test started failing once PREEMPT_LAZY was enabled by default.  Note,
the bug is *really* easy to repro with a to-be-proposed patch to have KVM
do auto-pre-faulting[*], i.e. prefetch surrounding pages on fault.

Then harden the similar "map private PFN" to also guard against unexpected
root invalidations, because Sashiko keeps pointing out that it's theoretically
possible for that code to end up in the same type of infinite loop.

[*] https://lore.kernel.org/all/ao4CufEI_pRCjbMF@google.com

v2:
 - Collect reviews. [Rick, Kai]
 - Tweak the slots_comment in kvm_tdp_mmu_map_private_pfn() to better capture
   the nuances of KVM_REQ_MMU_FREE_OBSOLETE_ROOTS. [Rick]
 - Call out in the changelog for patch 2 that simply warning on
   KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is flawed, but handled in a subsequent
   patch. [Sashiko]
 - Make it more clear that encountering retry in kvm_tdp_mmu_map_private_pfn()
   can only happen if there are KVM bugs. [Rick]
 - Set r to RET_PF_RETRY when a stale page fault is detected. [Sashiko]

v1: https://lore.kernel.org/all/20260806214050.78058-1-seanjc@google.com

Sean Christopherson (4):
  KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
  KVM: x86/mmu: Harden "map private PFN" against unexpected root
    invalidation
  KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
  KVM: x86/mmu: Add sanity check to detect stale page faults in "map
    private PFN"

 arch/x86/kvm/mmu/mmu.c | 48 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.860.g4b6b3295ed-goog

