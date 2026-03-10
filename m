Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989B31A7E4
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186518; cv=none; b=hde49iQpVW7d6f4RDa5bq7kgWO8/tMUvAS1ETdwV2yQYvGztSrlmBBGZvgIuXItyAO7FzhW+r89Cm+KdN0WwSm47FazoktVm1kMS1xg5K3gHHnFvB+zqhZtbLNIvEchrJbfwyJI97+yOi/1IVAImymSvrDQX7ngCOk2V9GACxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186518; c=relaxed/simple;
	bh=Hxrp8TzxGDVoHzsErS/FYSvlAvs9D0Vx4AmF9OknU+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wkni3cPEHkXOQpLFcuWEVBw1KhE0wigb9dQr2XgPtOlu9wHrmkdkDVYRArk5ABlo+7yBNre8TYcDN3rkt8oDVqcheDW+PZw/ikXTDj5EvV5Q3JEs4Y7Xi3/ewO4E4VTyQFqG+8BZItHxWAwdt1WGLo2J5k7DKwJKioZrIjAYsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNdnyYr0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNdnyYr0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae6961bff0so398913725ad.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186516; x=1773791316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmyMv70eqtNH27YII0Pv9uQYRElVQRLLBwleEaiib/8=;
        b=TNdnyYr0cdm3/FKPBce/Rg5GXbob4SEFH3DMuOO965Gvybq3tYi77oTx6RFFrvjyKY
         sD/7pGKjePmXeCdP62PmjOIUrKpC4unIbjH4Wm2TQeOGKk+jwsY4p7J5GKNKAXAlOmFA
         2Coix498WwI+2Wr3jLp+TAWZfwOGAf6zEc3BfrKAr7qYZiuhkwVRyHzGsIYflF5UmtzO
         fpBf2c+wu+CBYI7Smp/F/hJ2NzCvE3CQy1qxW9UO5lOmRLaOTvrQq4okUK3kYVBJ8jX2
         2sfe/QEoPR876ns1TA68Fyt0XeCc95iqJtv/fhTHGE0n9lVW1tv+a31B+Vn68p/hOQKj
         LXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186516; x=1773791316;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QmyMv70eqtNH27YII0Pv9uQYRElVQRLLBwleEaiib/8=;
        b=UnOMMAnNEFMdXN0eU8y/7NB+PYdlLiIFCA+DF1C07Pqqa6MfJLVq1lHr2N7JS7reQI
         SU6RRd/ZVXtcz/ng6plJ5Lv4DXig9Jul9+0S96TsCGtTUSaJJkQRQMOCW0i7Hm8Qr4tZ
         CxZeTJCHyhssWAW4/EqOWpM1fs3V9ykB3dhd4uMpcJuK27YmzP3OWlLkYJB2dSlRwQHS
         GQsYTnWqnsIdn2+0wppWeqFTPMdpI1pCxceXOnHrI662bLuz15GNvveFio1xmuQ5SfJm
         BdRycvA9qtj6pCcbnCQnb6qzeOP5N7fodZdG7M8pJf1gxYmhPZhAMQiOpD3b2+5mcQ+Z
         2eog==
X-Gm-Message-State: AOJu0Yzpx0sBBQwdMfE4OZWtiFwDsyC5y28XlWuf2yt9v5/5d6LCHWsv
	PEVPj2oWeMnvsJqRY/rjriO5Qu3BmhjRBTUJXKdJ44AKSisBfVdeWxPgF2VH8xI7SWI+tGYy/Go
	M7jkZnQ==
X-Received: from plbv9.prod.google.com ([2002:a17:903:44c9:b0:2ae:44fc:75e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0f:b0:2ae:51bb:9809
 with SMTP id d9443c01a7336-2aeae85a668mr5099875ad.36.1773186515795; Tue, 10
 Mar 2026 16:48:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:08 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-1-seanjc@google.com>
Subject: [PATCH 00/21] Fixes and lock cleanup+hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix several fatal SEV bugs, then clean up the SEV+ APIs to either document
that they are safe to query outside of kvm->lock, or to use lockdep-protect=
ed
version.  The sev_mem_enc_register_region() goof is at least the second bug
we've had related to checking for an SEV guest outside of kvm->lock, and in
general it's nearly impossible to just "eyeball" the safety of KVM's usage.

I included Carlos' guard() cleanups here to avoid annoying conflicts (well,
to solve them now instead of when applying).

Carlos L=C3=B3pez (5):
  KVM: SEV: use mutex guard in snp_launch_update()
  KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
  KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
  KVM: SEV: use mutex guard in snp_handle_guest_req()
  KVM: SVM: Move lock-protected allocation of SEV ASID into a separate
    helper

Sean Christopherson (16):
  KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES
    migrate test
  KVM: SEV: Reject attempts to sync VMSA of an
    already-launched/encrypted vCPU
  KVM: SEV: Protect *all* of sev_mem_enc_register_region() with
    kvm->lock
  KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
  KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finish
  KVM: SEV: Lock all vCPUs for the duration of SEV-ES VMSA
    synchronization
  KVM: SEV: Provide vCPU-scoped accessors for detecting SEV+ guests
  KVM: SEV: Add quad-underscore version of VM-scoped APIs to detect SEV+
    guests
  KVM: SEV: Document the SEV-ES check when querying SMM support as
    "safe"
  KVM: SEV: Move standard VM-scoped helpers to detect SEV+ guests to
    sev.c
  KVM: SEV: Move SEV-specific VM initialization to sev.c
  KVM: SEV: WARN on unhandled VM type when initializing VM
  KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=3Dy
  KVM: SEV: Document that checking for SEV+ guests when reclaiming
    memory is "safe"
  KVM: SEV: Assert that kvm->lock is held when querying SEV+ support
  KVM: SEV: Goto an existing error label if charging misc_cg for an ASID
    fails

 arch/x86/kvm/svm/sev.c                        | 315 +++++++++++-------
 arch/x86/kvm/svm/svm.c                        | 106 +++---
 arch/x86/kvm/svm/svm.h                        |  36 +-
 include/linux/kvm_host.h                      |   7 +
 .../selftests/kvm/x86/sev_migrate_tests.c     |   2 -
 5 files changed, 275 insertions(+), 191 deletions(-)


base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
--=20
2.53.0.473.g4a7958ca14-goog

