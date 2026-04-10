Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB97395DB9
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865528; cv=none; b=g6mpxuFEfgh/Q6HQ1dTubaQTN5WvT4fV39LLXf+DtI5FblWZgxQKLMnJ5XtMd9OkHlpyJlPrFxgqDY9/zcIGr2wyRuoJHIPd/LfmUMQnG0ZuoNtusKWshbfbdwv9iO5mjohZnlZ2lyifSzlslM8M8tU6gBj9lFPzD74kEP8Q/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865528; c=relaxed/simple;
	bh=u/TVYi6dy6Qj+6oPulgEK6LMoy1OGHMGmyuhm/aNfUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DvlXrABLMkv11IvadLQ8ZAP3e6IwUUctmreJcKUj00GrU7WUPCB3ZdVezP1Edm3AUooIUqAhi3iyWKnZdz8q5W7aKpC6Ha1y/gDrnyKEyLCacCPmpMjL6AXRmVYnHsZVxN3y2gErz0LzNU5S1xI4PWW4LVDvnq8pEy1e5WD8TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoNC1k2R; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoNC1k2R"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35e30bb289bso4015435a91.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865526; x=1776470326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QicLK2txfxlG/AiHSR14AxMdXX8uIvRmjrzql31A1jY=;
        b=eoNC1k2RzGFNf6ozVhufV9W8Z2uo3Vf9KQKpSjw07fp7eibbybbvpViz6Me8n92Csz
         oo/+f5hb/PeUtavICrZjWV2Ge5pwoijCINdF/vtF2Roa/3UYL2gHgZ/zdtYqorp/AIJn
         y2WzrJ5tbueln9z3L3f4D2D+OGKyVrL1qMuxM1eNtxk0w1Iu8ay1XMauu+MWmEXHy+ep
         KE52LlHaYaVBx8k/I2bb9i/5ia/B05WrcmLhWKqQK8obDi4Z9I1sbhKJ6RXj/M1cmCRZ
         puzEPEvCAkJBvyYSdCIg3Rq/wuVQuW1oL9PSkOCBvg1AKeIjZr9d0/TN1C4uBh8AsrH1
         YPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865526; x=1776470326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QicLK2txfxlG/AiHSR14AxMdXX8uIvRmjrzql31A1jY=;
        b=rpQJTv5PE8C/HSxe2MUamPWrRxe+sAlsAjsQfSamLlA6YtBtGpiL3trDBy28h7CoOv
         oOrZeLyPdsZFCip/D/p0Z09WmpjlU2UvkenryKSRs+hsULt4Xrj5GWu87pKg1Ij0A0u1
         Z479JvGlcS04VsmF3jBgMdejF7usKow5+s7YuMjOUrVGra+QdnGFGjVqqodrgXFzoQyr
         vg32zSGeJjRcu2ZY2ApMi8+V42RpqjnGebECDV1tTYbDbkwzCOujb0eu9SbSjqDenzsM
         cSTJRvYpBAzPnOvh4IfB8jIRQ9Y4LDgPBVrfcGI4SkOMDO+ZPqiHrxdN5hzefIeIJkLj
         vbJw==
X-Gm-Message-State: AOJu0Yyzj2jGhaVOcLHhhRalIemclhN0p/Hir5rvB3d4hx4I0hTAIjqM
	arfzfHKsw/u3S9NaO+tNIt4HCwhxvFNWc9qrh5HNugOEengLnqwH+GbnEndP9w9lsjcRPAC74WJ
	5cJt7pA==
X-Received: from pjzm12.prod.google.com ([2002:a17:90b:68c:b0:35c:2c27:e619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dcb:b0:35d:997c:8ec0
 with SMTP id 98e67ed59e1d1-35e4282bdb6mr5277022a91.18.1775865526459; Fri, 10
 Apr 2026 16:58:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:24 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-6-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix an amusing UBSAN warning where nx_huge_pages can be read before KVM is
fully loaded, optimize the unsync flow, and micro-optimize hugepage splitting
in the TDP MMU.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.1

for you to fetch changes up to b3ae3ceb556945724d0c046ddb4ea0cf492a0ce6:

  KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed (2026-03-12 10:36:01 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 7.1

 - Fix an undefined behavior warning where a crafty userspace can read kvm.ko's
   nx_huge_pages before it's fully initialized.

 - Don't zero-allocate page tables that are used for splitting hugepages in the
   TDP MMU, as KVM is guaranteed to set all SPTEs in the page table and thus
   write all bytes.

 - Bail early when trying to unsync 4KiB mappings if the target gfn can be
   mapped with a 2MiB hugepage, to avoid the gfn hash lookup.

----------------------------------------------------------------
Gal Pressman (1):
      KVM: x86/mmu: Fix UBSAN warning when reading nx_huge_pages parameter

Lai Jiangshan (1):
      KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed

Sean Christopherson (1):
      KVM: x86/mmu: Don't zero-allocate page table used for splitting a hugepage

 arch/x86/kvm/mmu/mmu.c     | 14 ++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)
