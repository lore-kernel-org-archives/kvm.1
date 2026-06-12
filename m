Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F6316192
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225286; cv=none; b=dP7Psaod4gsFQsRMYpO2DnAuXwQSlHybR0bB7sxNQiYDOH6mwpS9spRlzp8NAG7EdouafxItddcNafi3ailaiFCLXLgRjOBsUWuh02LzL+LiEy+SWUEUYBxftym+JDwXlOHpjyHOPXfGrSAeCQvSOtjWlaRKBDqvmqZsZ+Arev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225286; c=relaxed/simple;
	bh=t9WtfoJQKnXFOSCCb9UB1ovPDENxf3UugPi0l4QbKYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PRuV284CVIzg9Yli5ITx8Qv/eN7TZk/kzciNCuU9BDYqdYnIiDF/FkP4jRb151cmKl1vrxPu90Jw0CnzDiBXGMG995WJFxhFc9J4nBWNs4oYFZr63uiE8mj8La/orMQGBUXj/F/Gi0jJfDMkj3lEOkEN8bck3HARN/t/49xMjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAEWYaYs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAEWYaYs"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428419982eso421454b3a.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225285; x=1781830085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2SA/ElfhDqQQDGy6ks0/uXYhODYPRYYUQ5MVq8ph6+0=;
        b=FAEWYaYsbpUR15DtLmo5gJOgpnXeq/o5mSAcqIl6lwrLnPovji+ea/iZBJzzS3P85/
         IT26TeUtXYxbCr5llC+bQbPPMnnW9sY5Z1t7VzXiydWDrDBTRL9u6N0ra1rrfPY4M/ln
         cNgvbnsiWMX1+atRzCTcChOi+LV+HoXjCreuOLdqHTipxXGgw2J95JZ5SHE/eSYF0Wma
         bJO0yKv4Nb7ISwZBEOYfDk/qu1zV91/py4ZNLXq6ntAQvejviQHeXcFQC1p5H3Y9vQrp
         +Bp+cRL+u3GTGFlJsQVroVhTw6pHTL2qrUxTix8sBGTMBqEcXawQrYXZFhU1PcGHKx4R
         af4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225285; x=1781830085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SA/ElfhDqQQDGy6ks0/uXYhODYPRYYUQ5MVq8ph6+0=;
        b=M7MBEiqNlmjjY1fc6SAoKW+LGTfyxKlF3saLBeeeYPf8+BvWcVin9CZpAy3YoR2TEr
         6wnPHFwolBGDXAVK8lGDBkISU0KB87gXpIGxMQwBZR8/8KO2K2Z3SNgV/KaMvW9Gh4lG
         hRRC+JmCamtI1N6RJ9f6DcLjt3r9nX57qq9pNVJicO1B7RCA2NiMjU1GZKsGmfJyGQaK
         BIQy4Vu3elH+//G5rII8LSgymxbvvARnoMBiRgZp9grzb0bvyCBYAVkN0xAUBJ+D+jRB
         WQHzYToY+NfHHW8nUdVmPHYERIEzTNlQ0kO8jEU+VH5aiXQg/lGWyULcogehteA3YyDC
         toiw==
X-Gm-Message-State: AOJu0YzwVO/GwI23gVjwDi4P1COiu5Mur5ntkKt355nvEWFoNALHdRZs
	ryLuSJiRJI18ucCSw/6IOHmiwkW71NZuQmHUvW7yp4SL8bdrxNOSd48kZ94gq+rj6183l0CVPOn
	z6rM0lg==
X-Received: from pfkm17.prod.google.com ([2002:a05:6a00:811:b0:842:615a:d791])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd0e:b0:842:5b63:6119
 with SMTP id d2e1a72fcca58-8434cd4b365mr458949b3a.1.1781225284477; Thu, 11
 Jun 2026 17:48:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:49 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A big overhaul of the TDP MMU => S-EPT code in prepartion for Dynamic PAMT
support.  The non-KVM changes have acks from Dave.

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.2

for you to fetch changes up to 69397c92de77525f70aa43cf3a47256cef409382:

  KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on emulated writes (2026-06-08 15:23:09 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 7.2

 - Use the kernel's "enum pg_level" in the TDX APIs instead of the TDX-Module's
   level definitions (which are 0-based).

 - Rework the TDX memory APIs to not require/assume that guest memory is
   backed by "struct page" (in prepartion for guest_memfd hugepage support).

 - Overhaul the TDP MMU => S-EPT code to move as much S-EPT specific logic as
   possible into the TDX code, and to funnel (almost) all S-EPT updates into
   a single chokepoint.  The motivation is largely to prepare for upcoming
   Dynamic PAMT support, but the cleanups are nice to have on their own.

 - Plug a hole in the shadow MMU where KVM fails to recursively zap nested TDP
   shadow when L1 is tearing its TDP page tables from the bottom up, as KVM's
   TDP MMU now does.

----------------------------------------------------------------
Rick Edgecombe (4):
      KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code
      KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX code
      KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN_ON()
      KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external PTEs

Sean Christopherson (17):
      x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based level
      KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE "fails"
      KVM: TDX: Account all non-transient page allocations for per-TD structures
      KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
      x86/tdx: Use PFN directly for mapping guest private memory
      x86/tdx: Use PFN directly for unmapping guest private memory
      KVM: TDX: Drop kvm_x86_ops.link_external_spt()
      KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
      KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
      KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_spte()
      KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's handle_changed_spte()
      KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to external PTEs
      KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
      KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
      KVM: x86: Move error handling inside free_external_spt()
      KVM: TDX: Move external page table freeing to TDX code
      KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on emulated writes

Yan Zhao (3):
      x86/tdx: Drop exported function tdx_quirk_reset_page()
      x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external users
      KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf SPTEs

 arch/x86/include/asm/kvm-x86-ops.h |   4 +-
 arch/x86/include/asm/kvm_host.h    |  13 +-
 arch/x86/include/asm/tdx.h         |  34 ++---
 arch/x86/kvm/mmu/mmu.c             |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 275 ++++++++++++++++---------------------
 arch/x86/kvm/vmx/tdx.c             | 208 +++++++++++++++++-----------
 arch/x86/virt/vmx/tdx/tdx.c        |  64 +++++----
 7 files changed, 302 insertions(+), 298 deletions(-)
