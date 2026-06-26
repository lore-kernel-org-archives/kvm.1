Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAA3F1AD9
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473201; cv=none; b=DYzJqpN88I2ggaiAQcVrWScXVQq491cGRBhXIrs1Y2Cu5HswDLVQuCVLZc/hSk5HD3wf82ogZhgFGTb6zoSJhS9HcVBQE512IHci8cPpD/PGMj2TpRv052AIJ1iCzeMcI3uUkbVKG72RsiUxWfwrKVaIvcMbow/uk9xFtpRjUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473201; c=relaxed/simple;
	bh=qzFqL40tuVr5uJc4Z/ZoRpVEOvYkfO7gT1pHry4dH8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eSSFlyPQiuDnZry/CfBLVNrhMOpUCVxWaVi9CNGWvKceWTZGU4BeGRstYDwMVITAcY85wWXjdq+b4LEvQFMyzSCgSkfs0cCEBYU0zvEbm8DCPeUXior4BamY3hxt1u/xYGIVQdiu2zDqMlZ1xBAI5lGgLgBds/dAMTENMGHOK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha23pi5p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ6SCMkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha23pi5p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ6SCMkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
	b=ha23pi5p97xRjlJkp+IsQ1phb21O+DW8LxDxqDohPjZb63saqXogXzBW56kbDwM224AQzj
	DpddYcEKlCod7fOAr4ekJU7KpOS//9r7fB11BVlQCks9gp/GT6+YvIf3Ovr/o5UtfrRcFz
	3RWYyonA0iwJRESOJCfbF1UpsHd7VYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-6U9pLbU1MzCMFCrYh07e-g-1; Fri, 26 Jun 2026 07:26:37 -0400
X-MC-Unique: 6U9pLbU1MzCMFCrYh07e-g-1
X-Mimecast-MFC-AGG-ID: 6U9pLbU1MzCMFCrYh07e-g_1782473197
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso7069195e9.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473196; x=1783077996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
        b=NJ6SCMkJy+MtVou3k1vMC0vLtkkErV8pa3s6fVdEfeMfBG0IAWd3FsSoYwbbH1v3HY
         OkuITdN6Id20RK5ZLFCgAosaYTkp2CTjkeWNSgw1jnOvT7b2/+R/hEL58x7DRcX45g3l
         zM05UWDLEAYHve+WmYW6ooWpmmuaw7XP0luiCm8PPWHFoZddtP15eOfsG2xpQErCjh4A
         tLks2KFImKtASxBKNVTeeanisuPrpxKLozL/jNjmsSz4cuYTRjFlboJzA+YrDTL4oM6d
         bm2oUkhXYfQ12B3EcZPC/f7TTuNOhSCIxeMzNwSVf275dC4EX7nwA3BpWzkABaGzXDYH
         Bn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473196; x=1783077996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
        b=ahugSftuiKkUmA5YFgitHWZzxkPjsRbg7p4KzzWerK98OdWh+BvWiK1kfwLRJk0vEZ
         DOZimAcWY0D2KNgDmRxiCHZpGMfD0fktUm2RDBL8eKP1z/PN/Jn/YCJCKNTULZf7mlHh
         ph4oHXdAisjSpDbmrJsVzFA60/6JVnZLbYhKk/8xPmLBfyrmua+561RgMpeUhVVvhaVs
         UFp1FB4P0wk4MF0lHxQQqbNDdAEe0ps4fW10MccWgq9w85gYmPIh/mlhAWkFRzeDXCtn
         bCB+BXF9r9w+twge+/BDTJ2E4U0xIecMhENI5yc03FWrxKcZn41KCRWKjbxQhEiVM/b+
         kdRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vbIhtiVfI3Nkta5FGzEOBylBChkD3NRZBPrW/0wHaRF2MBWWarIOR+MGnXGBrA8OJCNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwx38QNShgtnvJ02MfTywqizGqaoc0tACMy3POx5O0lQms49bz
	Mt2waYvkNXRW/I3zBGHPtarIJPfPS6Frqu2DFjWFqedEJHa+CcPd4NMhHbFxosDhOXgQXJPvREY
	IYu6jeMo2m8jZYfuLrvpDqV9/dqkTNI4/LyS4IdxVP8HxuMavzNSnNw==
X-Gm-Gg: AfdE7cliI0zdrdNZJ9qCbxyMy4VGRDrR1+eLTlmrnzh1dT1Y9sKDZBDhfTjmVfIYeQI
	q3jyR061kTZa+jXK6lXZcVClm57u7QTiuozjEc2tK4JRFFm4F8gCdm3S1SxSYg4pVpEGgYiN9rx
	f9w3Ok2EIYhtWMEgQgGk2IdQ2/envKMn+rr11Q73SFjyKLWqEmE5SMWiLB/CZFQIpnmmAwHayKG
	dEKE5Kd0+Q9yPjjQ+OwzoYE0etHP2R9V2PPe479Eja0fUS4Q5tePI4FkGABZZ2enZ4RCNv6/EtL
	W90PCccv/Hp2YasyLTVtJFY31n8WX0TP2RRMheTqIsb5leA/xSnz1ua9A2yAJY9VyCOglCsZAUY
	VJP2qO8F30M8L/pCjGUp7So/O1UmUreHlAYUUIptVNqJKL7s/8diMaYULnjkdd6ZfWTiUwr7BoS
	A0AJU+xIaWV0baP76b
X-Received: by 2002:a05:600c:c4a5:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4926684a6b7mr94795485e9.4.1782473196520;
        Fri, 26 Jun 2026 04:26:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a5:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4926684a6b7mr94795045e9.4.1782473196050;
        Fri, 26 Jun 2026 04:26:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm22611955f8f.28.2026.06.26.04.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.10.y 00/17] KVM: fixes for CVE-2026-46113 and related issues
Date: Fri, 26 Jun 2026 13:26:17 +0200
Message-ID: <20260626112634.1778506-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sasha, Greg,

this is the backport to 5.10 for the above CVE.  Similar to 5.15, the
fix was relatively simple upstream but only due to years of refactoring
and cleaning up of the code; fixing from scratch is not really feasible
so start by applying the patches that are needed.

Paolo

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Lai Jiangshan (2):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it

Paolo Bonzini (5):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (9):
  KVM: x86/mmu: Capture 'mmu' in a local variable when allocating roots
  KVM: x86/mmu: Allocate the lm_root before allocating PAE roots
  KVM: x86/mmu: Allocate pae_root and lm_root pages in dedicated helper
  KVM: x86/mmu: Ensure MMU pages are available when allocating roots
  KVM: x86/mmu: Refactor shadow walk in __direct_map() to reduce
    indentation
  KVM: x86/mmu: Check PDPTRs before allocating PAE roots
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
  KVM: x86/mmu: Pass the memslot to the rmap callbacks
  KVM: x86/mmu: Ensure hugepage is in by slot before checking max
    mapping level

 arch/x86/kvm/mmu/mmu.c         | 431 ++++++++++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h |  72 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 arch/x86/kvm/mmu/tdp_mmu.c     |  23 +-
 arch/x86/kvm/vmx/vmx_ops.h     |   3 +-
 include/linux/kvm_host.h       |   5 +
 6 files changed, 308 insertions(+), 231 deletions(-)

-- 
2.54.0

