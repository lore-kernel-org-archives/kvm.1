Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11E48C8A5
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630136; cv=none; b=Z6R0R0Amu1RCff3EdwsysN2ZIusKusGE3p42OAFoQP0sH3K/BUW/2Ept88FarLsTdsNH2otdyB/YjXFh6l59UvlqF7w7W1XSNerc2oLBEX9FJCvIERjJSfj6RrHYGwGJBndMySORvRBKxGxX5VpTQWPshoIRZRYBbQtjv1Z/I6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630136; c=relaxed/simple;
	bh=OxYfb7jk2Dogz4QOiPI5sELKpZd0AIp5PymdR23zEmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb1gaDubYN1Q6mT1xfNSh8T758f05ZMkdlHn7TkDK24faUSBkIT1swcpdleQOQkCJi8/V2BfRqCSVxQ8Zc8wm9OrCaY34wstmeXM9g6i3A6YUQc3+OVwGYXO4kZXmErcDvBGYPc+y95XxATr4uCZWalC4NioD5lLQ9zmwxrPk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQynC9oR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQynC9oR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so24198945ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630134; x=1785234934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9WsuCI/ZvF5eobH6CMbMGyiJSEIrD4fxDsp42YDb6o=;
        b=iQynC9oRIf8LNIFnf/+Xbt4YrxgGLhZhbXPu3aTmmJSy8nUE/jJxMToSAIPad9618M
         uSxiJEMY2L/adcJK2mF7uGua4shJoC14TiRZCzKQew9J1Zzrn1dZGaoGgToFGooa8zxg
         waDlqB5VIETfxs3zm+3rqepxMDsKZv6CDy2T6M1Ef3MMsZJB+rffmovKc8A2U1IpbSn1
         W84L0L+TNdTE/3/uhzMK7gN4TQiXjYbfkzWcIqBWxkKEKBLbleChQ/YcdJZElwnfjVbY
         Mx2C57yad5DIcRVX996c9BvAtS0Z/VPTCLDO41rrUwloBg5KpVAeQKd+hw8nvYbiS1dD
         5pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630135; x=1785234935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9WsuCI/ZvF5eobH6CMbMGyiJSEIrD4fxDsp42YDb6o=;
        b=fyfyE4LfZJ6OO/3hSU7y2l32doEZ9TLHwpIqc9HEQGg7BA6FVuT1u7aC6PgoS3R7m/
         rJ9AdKKcAEg8KS+FO85wG4cO2u5TXSG3q4xs/GfVrfkZP5Tg27O1O4v12in1PnpItAGD
         QiLBLlj+ByLtfkuXgialD+kxmD/9yf/R04yc84tpX5d3+8CbxXVDdaW98hGAV0UXQeze
         CtnBQ/qdXN9G1HSfzJDRzK8ul1cpK/UW84nvPzruoroiFWoGbyn1+hm/PpQXEfWySw4j
         NOqTO6d4yCQeEls+aWFgjus5SayUpt48HyYSU6+zKGG3dR/MZ2fmSYiGPMVxVfuSOPOf
         hwMA==
X-Forwarded-Encrypted: i=1; AHgh+Rqq/bdHqE58WGaJkNbaCBivwn6LgaWzgorXwmJSy0M6/PxuJ7z+ENb1VF4YetqvjZArcDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrZkznF9jsap8Cf9CEzCwL8dLToyOjjGFFzwwG56PDVJsFJwQ
	/Jbv8BJxmsyNcylf5RTOqlkLkAnbqAk/a/GCb1mYnzRFBc7c5ejQvMPJpZRYb0++mW0=
X-Gm-Gg: AR+sD12pw6Go+Knq576VYUw6heWG4zAgYF9FmsbIXvX0MwzRglLNDAZ6wkGZTQXm6DE
	wTAldGpYOEkpE0CvnQCIxxwq5trUjHQ6IBKShrwPhtTe7HhoeRlq0G4dAwzQ2DT/pAm5E0WFnMz
	x6+8kviEG6RvMMtgm/fJCUNkXmblFlQL7rGWk4nvLR1DmSdWMm3rarUYK8FrinWFKKHE7og+gXb
	sgTlpx6SyXviGPHbv2IV/8YxO2n2bDI+YJaCF80MUvXCsAaJv0edbqr7e1p9EqhY3ZU8zEVSCCq
	/iPGqlDoMEstn/KKlWgWkx2r+770TP8dP33T6Hhn1dJNECUbD5/MoH/rmkPp9HMh9Kxj5XAs0E3
	mmncSmh8So9EUe8LDCjW6/s91HfGKLLP0Iqi7j1T9YJTTm8/e+r1TaabIVKkTAieTLXUkpo7MhL
	PjtVryWD5LF9uyizMvfBkdoR+pntJIeu8B
X-Received: by 2002:a17:902:dac7:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2cf34803792mr206531455ad.9.1784630134478;
        Tue, 21 Jul 2026 03:35:34 -0700 (PDT)
Received: from localhost.localdomain ([124.194.218.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476ba24sm72240715ad.75.2026.07.21.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:35:34 -0700 (PDT)
From: Jinu Kim <kimjw04271234@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: x86/mmu: fix cross-address-space MMU metadata checks
Date: Tue, 21 Jul 2026 19:35:10 +0900
Message-ID: <20260721103512.2136240-1-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 shadow MMU keeps write-tracking and hugepage metadata per address
space, but shares the shadow-page hash across all address spaces.  With SMM,
checking only the supplied memslot can therefore miss metadata for the same
GFN in the other address space.

For write tracking, this can allow an upper-level shadow page to become
unsync.  Synchronizing the page later can treat a non-leaf SPTE as a leaf and
reach the BUG in pte_list_remove().  The observed nested-VMX failure was:

  WARNING: mmu_try_to_unsync_pages
  WARNING: ept_sync_spte
  kernel BUG at arch/x86/kvm/mmu/mmu.c:1104
  RIP: pte_list_remove.isra.0

Patch 1 makes kvm_gfn_is_write_tracked() check both x86 address spaces so
that all callers honor write tracking regardless of the active address
space.

Patch 2 makes the hugepage fast path in mmu_try_to_unsync_pages() check both
address spaces before skipping the shadow-page lookup.  It is kept separate
because the hugepage optimization was added much more recently than the
write-tracking bug.

The series is based on commit
6bc96b971766fbbbbdd9fb2642cedacaf02da957.

Testing on Intel VMX:

- Patch 1 alone completed the reproducer without a KVM warning or fault;
  vmx_pf_exception_test passed all 75 checks.
- Patch 2 alone built and loaded successfully; vmx_pse_test passed all 92
  checks.
- The full series completed the reproducer without a KVM warning or fault;
  vmx_pse_test passed all 92 checks with EPT enabled and all 92 checks with
  EPT disabled.
- bzImage, kvm.ko, kvm-intel.ko, and irqbypass.ko built successfully with
  CONFIG_KVM_WERROR=y.

Changes from v1:

- Split the write-tracking and hugepage fixes for independent backporting.
- Move the cross-address-space write-tracking check into
  kvm_gfn_is_write_tracked() so that all callers are covered.
- Check the supplied memslot before consulting the other address space.

Jinu Kim (2):
  KVM: x86/mmu: Check write tracking in all address spaces
  KVM: x86/mmu: Check all address spaces before skipping unsync

 arch/x86/kvm/mmu/mmu.c        | 21 ++++++++++++++++++++-
 arch/x86/kvm/mmu/page_track.c | 26 +++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 4 deletions(-)

--
2.43.0
