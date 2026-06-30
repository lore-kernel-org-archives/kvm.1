Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70A29C327
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858371; cv=none; b=HIpSDgCOHaPM7XKgKP4ohZL2tg6sfNmfMgTMIvxhnB8sBzlMEIvaTJHKCh3rnT02SbZV+LpdAO3TWE76pG0/ifc3tTd9VcnDcshK50b+SypOpV5Vrl8XkOX81bl7sckd1yWJ2g0IWj+ENoeVf6y2hayQCrG1Jr7aFj3OX54DWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858371; c=relaxed/simple;
	bh=uiCrtv3aDzulPW42QCJuUCaXWdmlvRWjXln/YO3nl6A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WARFp5MPtJIrH9YW0cmMN2Ep8lDckj/Mxta02W2BygbwOayUx4KKk2iXxsu1LNt2U1pkl8lk0MfNdIzSgqF09XHEHeo39cUIPOQgBcpa4TfG7KHQJFzzt7s3OkutfPhmXcrBGYnRufg34lEj6CUqi/2c4VHQ3/VF94CUICHXXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/TX+QGY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/TX+QGY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a90cc5e2so62618b3a.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858369; x=1783463169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGViHahQdgswaxP3CojmrrY7hBCH/xgTjZd+P0YB0TA=;
        b=s/TX+QGY9zM1nU3l4V/qnf0REC2zaviOQ6aqZaJtTfkIWMysYogxoTd7OX9yfc5dr3
         gBXCDcSKor/J8FGEh5uWSpL1pOId2ifLnxhE6ggov+m4qG34TGw5KcPG6ggWIztdQ9IR
         G9crdX+WTL2pYS4t+pWKUXnHWa3RZLFrbOIEZLuMN4+ni8A2VjyHdW0QPL6lg9P120Jr
         brjyUJ2yFEl/904td/GGiq57BZwTr/El5o3fCJQ/7dIct7VT/58qQLf5DVrBinjZCWWB
         n0XygZiUEnrQx3L7OrEtbNWjEd/g6OAOZmTRWeNTb61IhRGWwzjlYY0byneqCoFmQf0W
         o5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858369; x=1783463169;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGViHahQdgswaxP3CojmrrY7hBCH/xgTjZd+P0YB0TA=;
        b=U8SLBNXuGHq0yyoPJaLyTZd/4vVqKnZAtsfGosDEyBS7A47aKBMQPvFD8GKBrGyfAx
         5jjTGCHxrw8l3REKePh5AMJKgip6LO52HMvLWnGDJ/jxFHLBnlLxqr7NS1yalkPcAeI3
         B5TBi6vqxNHabTG5JpWX7Oe9Yt2ZXWOjOzcD839tWCeayxg8yuhosigexpWKfriCID3f
         FPS45sU0EE1zArUqLoPsLNduK/h3xo3wSUfsITvqcjXIr0YRNAhwFFrCnw8jZh8qKuqS
         G4bNiwilN46oluJqWQhIvDXRqi/dRbdGvza8GEdL0hnkcOedbvPccRuyh3JygLuriq8F
         LhIw==
X-Gm-Message-State: AOJu0YxEnKWWIn0ge72+BloiKxw4VLMeDWk08zyw6lsbNmcBMARXJryL
	qF0EhoAMTyZTGsKcThEG//7izYoiQrsbl0+SUZPAvsgJdZE+p6qPB3rWcSOiSfPft2WJT/XI/ZU
	NEh+NyQ==
X-Received: from pgct17.prod.google.com ([2002:a05:6a02:5291:b0:c9a:7d72:c316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c6:b0:842:672e:7b5d
 with SMTP id d2e1a72fcca58-847add9a0bcmr2445990b3a.17.1782858368833; Tue, 30
 Jun 2026 15:26:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:25:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-1-seanjc@google.com>
Subject: [PATCH v3 00/12] KVM: SEV: Fix RMP #PF due to freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
to forcefully reclaim VMSA pages when the pages are being freed from their
backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
scenario, marking the page SHARED in the RMP will fail due to the page being
IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
the memory back to the kernel while it's still assigned to a VM.

Note, the implementation nearly identical to that used by KVM for VMX's APIC
access page (which isn't guest controlled, but is migratable and whose PA is
shoved directly into a vCPU control structure).

v3:
 - Ensure disabling quirks while the VM is live won't result in KVM skipping
   the back-half of "zap all fast". [Sashiko]
 - s/gmem_free_folio/gmem_reclaim_memory. [Ackerley]
 - Use {READ,WRITE}_ONCE() when accessing the guest's VMSA GPA outside of the
   per-vCPU mutex, and comment. [Sashiko]

v2:
 - https://lore.kernel.org/all/20260626231416.3943216-1-seanjc@google.com
 - Invalidate VMSAs if the memslot is DELETED or MOVED. [Sashiko]
 - Limit stable@ patches without a Fixes to 6.12+.

v1: https://lore.kernel.org/all/20260625222229.3367197-2-seanjc@google.com

Sean Christopherson (12):
  KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP
    guests
  KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
  KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
  KVM: Rename .gmem_invalidate() to .gmem_reclaim_memory()
  KVM: x86: Serialize writes to disabled_quirks using kvm->lock
  KVM: x86: Ensure runtime reads of disabled_quirks are resolved once
  KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into
    kvm_arch_flush_shadow_memslot()
  KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back"
    halves
  KVM: x86/mmu: Use split "zap all fast" helpers when invalidating
    memslot
  KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is
    zapped
  KVM: x86: Guard .gmem_prepare() declarations with
    HAVE_KVM_GMEM_PREPARE=y
  KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid

 arch/x86/include/asm/kvm-x86-ops.h |   8 +-
 arch/x86/include/asm/kvm_host.h    |  10 +-
 arch/x86/kvm/mmu/mmu.c             |  74 +++++++------
 arch/x86/kvm/svm/sev.c             | 163 +++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c             |   6 +-
 arch/x86/kvm/svm/svm.h             |   8 +-
 arch/x86/kvm/x86.c                 |  15 ++-
 arch/x86/kvm/x86.h                 |   2 +-
 include/linux/kvm_host.h           |   3 +-
 virt/kvm/guest_memfd.c             |   6 +-
 10 files changed, 210 insertions(+), 85 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

