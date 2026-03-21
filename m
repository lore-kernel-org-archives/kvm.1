Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A781DE8AD
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051780; cv=none; b=QOD6oqZaJ7Zrc8OLgjrOqCel9Cts1SkZ5lqZaL8dNTlgFlcBdxN7WhEWVY1SEvfPWzJELxwpGjqu8p040c2o/wI5KKNvUHQHBSC8SAyOyTEDepv7Ly3Xw81ixUCcvkkuNMNu+Gv47pGVkB3JboIvAw7Mr5SNs/lbvlcykJXZmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051780; c=relaxed/simple;
	bh=iVrZ2BxgO7+Yz+oRumENpezzBlGiuewgi8Qv5JXq4DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=SOtMkjjCOQ1ZjSDNbLLig/QQ6ClEfqyfxCZGHZuRxYVKnfiGA044oyDKtpSFIskqiVZoB/+QJFF5vZL5BxONqu+eKpqA/O9sSrpG0mulapfV5KBY+LJnweJd6i7t2XqvXw0RI7f0tgSlU14uDLj1CERm8sDR7gzKUbHqgeWZSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUSMRd2W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB43EnLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUSMRd2W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB43EnLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nykh4zN2CVVFgRsOIdMTIJN7VG82DP5uVwLMY+Mu7ZU=;
	b=JUSMRd2W8IjatYsTsFkREsEBKr4NDQtyoDiu400MKpGJQjE7B016WUqVrqIRYhLfS5unMD
	/Ro8J7/159JAic6rfaoj9TxTUyYrODphSHI+nOFzo8NllgCDD8bYChyD6mE7QKJfFBtnEI
	yjj/bVYGMhtiCvcBwUHR7RD1BtCGH8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-_O7CVigmPDGQoA7MKtisHw-1; Fri, 20 Mar 2026 20:09:35 -0400
X-MC-Unique: _O7CVigmPDGQoA7MKtisHw-1
X-Mimecast-MFC-AGG-ID: _O7CVigmPDGQoA7MKtisHw_1774051774
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b474594so25794265e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051774; x=1774656574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nykh4zN2CVVFgRsOIdMTIJN7VG82DP5uVwLMY+Mu7ZU=;
        b=UB43EnLOdnib6O7rFwRKCYy9Wj0JUNIY/GFkhN/gV0M3sR7/6Ch/IeEUNmeYpD8DEr
         efMiCxm39J2YcDXoHM/2KSnt4sgLSLvzFBB26eAqtZuN76qctEHJn/Z8qUhSfQKW8j6c
         XwBrkjuDM87UPh0iSvgYeo8ANAdE8o94O0S/UrgLIvPQXGo4BMLpiyMjxSDEwvgDwBIt
         3uj4m2gkf3/8uYFFxnNHCI7tQkQ8Pns0Ky8RLMdDS0GUd0D+7rLBRPi/tIpykZlbCbbl
         xM9Qh637gW7TOl+tEND7SREskTbPSOruQkzAf+jg+W0adEGdLG13S2xeZoIYNlsYQsvP
         mS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051774; x=1774656574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nykh4zN2CVVFgRsOIdMTIJN7VG82DP5uVwLMY+Mu7ZU=;
        b=Rzi2/j5s8sFI5JMtw1wTQuHIgAk4Kjj4oNzSYVElKB+WuQq8yRDYKFHBvhIQwr7w+U
         dOIoD5YVBaLAaCTvEy11q4Sw/EeUFeL74q0Lnqr1gJPp9YP+n1GDodsJ8psE4R2eTf4E
         0yKd1rQEcRwsICvnis+y5fNigFRDQkfGajElk5GUvVAKa/iYNrYecqzSCFYBxuLewTHd
         KGwTqmyiYDAWV4quZxW3PWZrnaY21153jEhxNEnubw7oN2TIJv1tH8vhp4kjVs6P9Ow7
         Mr8rmCcVdxk9QbwzAdwSiEWLNmtym4m8mpx3nON/CdmFG7WwoQVySXkCCRo0Gz6VBF0/
         AzWA==
X-Forwarded-Encrypted: i=1; AJvYcCXMZVYQDktSTKmFPeI6BvsJ8/48AJb2nu1D3CagOZFchnaZgvN3pFINeau32DPKrQ7Qusk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaIEoGQRoVf8p+jU9aWGP8NvL1DPsuxvHKhOKB4KiGhFS8MaQ
	qUcPl8y02qZWmwtqGqMyk4PHNgJZ3+JpvOmXaAgz3H9Qj+MbhjeJJ1EeeqVaDrtPrOBdwD+Cm7/
	B5FQ5jhwTO9DzzVa+/SxyK0WRprOe+Svtmr/TsZWH0RLaVNsh13ag5Q==
X-Gm-Gg: ATEYQzxRDnEoGG74qtP9pLWJlzWQoTtDMmkRZaAzPgVIA5OUqzGsqhyQUgs731QpwZU
	hxbLykJko+MRziufUFBwGCM9GZZyfQxO7Z/GwVcgkNDxwq810kXRpIA6HLCW8XP0cUdsinssiLa
	URWg98C5EB1X5pKIZgruR5rKm8cMlrRAw2oth3VN3ym/tIXKPr6kBjf3AxpLAgJKAnbF047f5FS
	jkojK6roMNAiNAOrblrqil6nd2YmOkK5dqLP+V8+KNmPED5M8Er2354KA1CWfWYSEMrtaubdWD4
	stpOAe5NYKsZnZS0ycED1WzOe7AJSeGS1UU3v0xoPi1pMBpsRIZ9GeiRk5V4J/9xSxAeAwtRJC4
	7Vy5EjveqGAdFUOozODwQBNeaNadfqZWRUCQc9O4Tf5Jqvm6NnPyUDjNGgOIIYI5U6UNHjqIOtc
	5Rc1RaEAUIuR1/JhiGDLJNFQ13
X-Received: by 2002:a05:600c:8b84:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-486fe8e3facmr74699345e9.9.1774051774331;
        Fri, 20 Mar 2026 17:09:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b84:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-486fe8e3facmr74698985e9.9.1774051773902;
        Fri, 20 Mar 2026 17:09:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1b0848sm26250565e9.23.2026.03.20.17.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 00/22] KVM: combined patchset for MBEC/GMET support
Date: Sat, 21 Mar 2026 01:09:09 +0100
Message-ID: <20260321000931.1947084-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

This series introduces support for two related features that Hyper-V uses
in its implementation of Virtual Secure Mode; these are Intel Mode-Based
Execute Control and AMD Guest Mode Execution Trap.  Both of them allow
more granular control over execute permissions, with different levels of
separation between supervisor and user mode.

MBEC provides support for separate supervisor and user-mode bits in the
PTEs; GMET instead lacks supervisor-mode only execution (with NX=0,
"both" is represented by U=0 and user-mode only by U=1).  GMET was
clearly inspired by SMEP though with some differences and annoyances.

The series was developed starting from Jon Kohler's earlier version
https://lore.kernel.org/kvm/20251223054806.1611168-1-jon@nutanix.com/.
The differences lies almost entirely in the MMU parts, where I took
the occasion to do two things:

- clean up the implementation of nVMX exec-only, by properly adding
  read permissions to the ACC_* constant and to the permission bitmask
  machinery

- allow KVM to run with MBEC/GMET enabled even in non-nested mode.
  This simplifies testing of page table manipulation, covering almost
  all that is needed (on the MMU side at least) for shadow EPT/NPT.

These core MMU changes actually make the implementation of the features
pretty simple.  In fact the number of new lines overall is a little smaller
than in Jon's patches, despite supporting twice the instruction sets. :)

On the Intel side, the main idea of the implementation is to split
shadow_x_mask in two and to repurpose ACC_USER_MASK (which is not used
by EPT) to ACC_USER_EXEC_MASK.  When MBEC is active, ACC_EXEC_MASK is
for kernel-mode execution just like the X bit of PTEs morphs into XS.
update_permission_bitmask() then precomputes all the necessary conditions.
While the MMU code is all new, most of the Intel-specific code here is
from Jon---so thanks for the early posting, which undoubtedly saved time.

On the AMD side, the U bit maps to ACC_USER_MASK but nNPT adjusts the
permission bitmask to ignore it for reads and writes when GMET is active.
Here there was a bit more work to do than I expected, because the page
tables have to be created with U=0.  For now I chose to have it in all
levels of the page tables; I'll probably change the code soon to
clear the U bit only in leaf SPTEs, but I'm leaving it this way because
it makes patch 16 easier to understand (it's a fix for a latent bug of
sorts and I'd like to include it anyway).

In both cases the former "smep_andnot_wp" bit of cpu_role.base,
now named "cr4_smep", is repurposed to indicate that the feature
is on.  The minor pessimization for shadow page tables (CR4.SMEP
now always forces a rebuild of a new version of the shadow page tables,
even though that's only necessary if CR4.WP=0) is not really
worth fretting about; in practice, guests are not going to flip
CR4.SMEP in a way that would prevent efficient reuse of shadow
page tables.

Patches 1-9 are general cleanups, mostly for MMU code.

Patches 10-15 are for Intel MBEC, with the first three covering
non-nested use.

Patches 16-22 are for AMD GMET, with 16/17/18/20 covering non-nested
use and the others covering nested virtualization.

Jon Kohler tested the nVMX parts on Windows, whereas I tested nSVM GMET
with new additions to kvm-unit-tests that I'll send out next week.

Paolo


Jon Kohler (5):
  KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
  KVM: x86/mmu: remove SPTE_PERM_MASK
  KVM: x86/mmu: adjust MMIO generation bit allocation and allowed mask
  KVM: nVMX: advertise MBEC to nested guests
  KVM: nVMX: allow MBEC with EVMCS

Paolo Bonzini (17):
  KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
  KVM: x86/mmu: remove SPTE_EPT_*
  KVM: x86/mmu: merge make_spte_{non,}executable
  KVM: x86/mmu: rename and clarify BYTE_MASK
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
  KVM: x86/mmu: split XS/XU bits for MBEC
  KVM: x86/mmu: move cr4_smep to base role
  KVM: VMX: enable use of MBEC
  KVM: x86/mmu: add support for nested MBEC
  KVM: x86/tdp_mmu: propagate access mask from kvm_mmu_page to PTE
  KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
  KVM: SVM: add GMET bit definitions
  KVM: x86/mmu: add support for NPT GMET
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  44 ++++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |   9 +-
 arch/x86/kvm/mmu.h                 |  12 ++-
 arch/x86/kvm/mmu/mmu.c             | 153 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |   9 +-
 arch/x86/kvm/mmu/paging_tmpl.h     |  48 +++++----
 arch/x86/kvm/mmu/spte.c            |  76 +++++++-------
 arch/x86/kvm/mmu/spte.h            |  58 ++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c         |   4 +-
 arch/x86/kvm/svm/nested.c          |   8 +-
 arch/x86/kvm/svm/svm.c             |  30 ++++++
 arch/x86/kvm/vmx/capabilities.h    |  11 ++-
 arch/x86/kvm/vmx/common.h          |  21 ++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |  11 ++-
 arch/x86/kvm/vmx/nested.c          |  10 ++
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  17 +++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 24 files changed, 373 insertions(+), 166 deletions(-)

-- 
2.52.0

