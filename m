Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E5417BF0
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052186; cv=none; b=UQRpWqnZ+O8cCBQVHn02zOySnn4AFzTOp+ZrU9WP0cCOQmbuIiaiIEEY6+DFZHn/CawU+D71X0FruuC6QjFdsOQqpflhoO9zvixsVzsQ8XSss5B2QA+j2A5Nx7IriTvma1hTYyPjW145oWsBRUTEEf0dGG4PO8rCPgbeC3dpzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052186; c=relaxed/simple;
	bh=K8YP5ejsNxr8poc77f9jqVqgi6nf+poxRdNpq36Lms0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ez2qaB77waKN9d1svVqnaYLutw4eycY5PyrPrIuEEU4X/azCA0cgu6PMzc0bCCHctMQ0yB99d51DMxUJ/vgPQge1FsjhvOvQbokKgowkg0pDziWrVIycCQ9ha2DhgOeONHwm5SCJrl+lhwd1OzVtCjqw67NgiGD58wLYclTb7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8B55fwE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8B55fwE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1352623a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784052184; x=1784656984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rsk6VLM9KqvehMksWAVrD1FVxDYQHnyoO93TvlPjXMM=;
        b=V8B55fwEjAdkv5eaEiO5bltz/a7DNApGqEYaiRHqWBC0UqIujOL1CUlFXIC/qN5MLi
         2cPpehgs04qA86zLVf/q2PoGNKdAuySuQ167sVQ+2qiO8yaObq3jTQ1ggF+t8Jm1TkZJ
         E/Suwuvnb1yCMR4n6u/4G0fbx+zaw/4NJE61hNPAgIC6UEBicCz435aJyqnCySS6ng9n
         IwDxJNZyeoUiXrvMaSgzfvt8HmC6ayUXtXjtPTfQUJsJpDcVwMuezVN6/jJtkHnf9nrr
         /qBu2KY03GHqQRkg0IX5hA1UZp2Lb3EIyaAq5WE7EgsH7+9MHWSLuiDFbxL715FdV8Hd
         bSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052184; x=1784656984;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rsk6VLM9KqvehMksWAVrD1FVxDYQHnyoO93TvlPjXMM=;
        b=HDHxFvOo9jwxWLS7aTPfQiPBUBdReOYW7Hlx+Rudto58S4qS+XpZ/p4NwTUnfNjP+l
         Y+yWynzYCXxMLELyusaxwcugN+PPLY/PVD8f9t2Q/fRUUZ1hzT5Etp7edwcvFBntNM7V
         3icRTfhtG8q1A/IE1WkBdEY8NysUcGImf4pCe2p8bCEQcY5Hjc+4JBFh9dVTlaAZear3
         5zg+EqdYbzkPCf1f8oLVHSVOF4Pd3KCkvREVuQ7xjE2gKG2fcPVfyPlT+GnA6yA1RldL
         h4Xe6Evb1ycHhBIE+cVd3ovo0fwV2b3TQYW2T6tOoIt0sItCV/1tx1R4a9sFf6h9XYJZ
         mNpw==
X-Gm-Message-State: AOJu0YwWLIUhthOnhcLvhgLsuAnrZejOC2IpQVr47da8I17DmJirJS5n
	u5FHgTfNu1UPhC76NkhIXcbJBMAbPpUe9vL29eOfssKVRF31qnRrp4idKrzpIe+uRVTYDzZ3gSc
	6ligbsw==
X-Received: from pgc20.prod.google.com ([2002:a05:6a02:2f94:b0:c96:6f3e:49c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9216:b0:3bf:c28f:8afc
 with SMTP id adf61e73a8af0-3c10fd6bdd0mr17193925637.0.1784052183886; Tue, 14
 Jul 2026 11:03:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 11:03:02 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714180302.3105706-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fixes for 7.2-rcN
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull x86 fixes for 7.2.  Nothing in here is super urgent, but all of
these are fixes for high-impact bugs (though the ept=n bugs are agruably not
impactful in practice).

Note, the tag is based on v7.2-rc2.

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.2-rc4

for you to fetch changes up to 9c66085e6dcfb44b70970aa4e323003fc7f2b738:

  KVM: x86: Fix null pointer deref due to dummy array in trace_kvm_inj_exception() (2026-07-13 06:24:36 -0700)

----------------------------------------------------------------
KVM x86 fixes for 7.2-rcN

 - Fix a bug where KVM will trigger a UAF if updating IOMMU IRTEs fails when
   registering an IRQ-bypass producer.

 - Ignore pending PV EOI instead of BUG()ing the host if the feature was
   disabled by the guest.

 - Fix nVMX bugs where KVM would run L1 with an L1-controlled CR3 after a
   failed "late" consistency check when KVM is NOT using EPT.

 - Disallow intra-host migration/mirroring of SNP VMs as KVM doesn't yet
   support moving/mirroring SNP state.

 - Fix a TOCTOU bug in KVM's handling of the "trusted" CPUID for TDX guests.

 - Fix a NULL pointer deref in trace_kvm_inj_exception() where a change to the
   core infrastructure missed KVM's unique (ab)use of __print_symbolic().

----------------------------------------------------------------
Atish Patra (2):
      KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      KVM: selftests: Verify SNP VMs are rejected from migration and mirroring

Binbin Wu (1):
      KVM: TDX: Reject concurrent change to CPUID entry count

Daniel Paziyski (1):
      KVM: x86: Fix null pointer deref due to dummy array in trace_kvm_inj_exception()

Sean Christopherson (3):
      KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs
      KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal" checks
      KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is disabled

leixiang (1):
      KVM: x86: Nullify irqfd->producer if updating IRTE for bypass fails

 arch/x86/kvm/irq.c                                  |  4 +++-
 arch/x86/kvm/lapic.c                                |  8 ++++++--
 arch/x86/kvm/svm/sev.c                              |  6 ++++--
 arch/x86/kvm/trace.h                                |  2 +-
 arch/x86/kvm/vmx/nested.c                           | 87 +++++++++++++++++++++++++++++++++++++--------------------------------------------------
 arch/x86/kvm/vmx/tdx.c                              |  6 +++++-
 arch/x86/kvm/vmx/vmx.h                              |  7 +++++++
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 110 insertions(+), 57 deletions(-)
