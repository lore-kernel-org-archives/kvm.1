Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31303D75BC
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630193; cv=none; b=tVO25yR7y5JaIGtymEj+guNvXt6eNt8VlCrPK5Ckxo7exJh2QmwTA0JPLQwQhO1Jn/8a8/JOcn5ht5DLnW5RpVXmuYKMnsonhaOd1KMDXTDfl2lisyMARoM+LxSXTxj7daV0UCYgXtLVyC8jWt/CqU2mYYr1dpRFtzlS+E4UCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630193; c=relaxed/simple;
	bh=Zqt6H8yGgFDwBji6ZVSvW6+WQd2HIMqYD3EuR/vbTZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GAU4VWLRB78MDSPzStYFbNEc/f0+y1ssWOIpvKuomO8QVcCX/3CJMlz+BCx1E4F+zlYh0kq23XiisAF6IVBRpcbo3WcQphDVcv4NJZbybL3hoLzstb/DpGOXWjbUkUaxNYMzcvevoBDYX7KxhPhQ0btJphdQq/WRPSRGagOI/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utLh+ryy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utLh+ryy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc6dd43737so3580765ad.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630191; x=1784234991; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeWVhMvaNtLQctXkDLCy5U04y6dWcdGwG0IHyzafuXo=;
        b=utLh+ryyLl93iKaJ27ZIi1cYlAkInvZ9TVbOsLsO/DL60Bf3EBlZL39KDvphfpxri0
         n4Qc3+hdz45EvWoGOftg1Qum2nIs/05bnpVB31K8RUTG/Swz5uSCSBHtEQWgSpJRKBk6
         bbyuJ6YjmWa2DUJHwxHVZCoUkLlsfVF9B1IqAUsrwHzuwZEPvL5aPNlAvPd5UpLspsdk
         OPZ4OuGFuI2QCxc44/ptB7VyBZ299nRjd035pZ7Fv/VA8ZGatsOgRafDpdIZVf8Ilw6x
         yfMmEuoxRJ7AN1GQgSixsVqm7rqIgqUtNvVn0wkMg0n4iSthIvLRcdzMvEj3DhqhTMG7
         51qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630191; x=1784234991;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeWVhMvaNtLQctXkDLCy5U04y6dWcdGwG0IHyzafuXo=;
        b=Oqz9WeGv2ZPax+8N4PVbyBhK4tfvUotsMRMdeSB+HmZAjM25fg/WXBRCct8KjIXnaZ
         cLI069XNeunkLsaTp6n0y5G02/ZZNgVUopR4Iml/JtgBt3uSUgRu3gT5DHeozz4D7a7x
         Zyg2LkUevQPqmu+lwPJM/1uaWvWxqA+AKExLFCcJQFIsWmyP+PRxS52OrGP8ggQrTr8N
         x/dDw+CWrRAijNCo3H773l5caZEb9huSKpzMNOH6Se9yo6yJFeULRSLHqKmhcECHk5ib
         1HspZOjAPiAiWnI3PCDnt0u3GmwjOKEMiy/8dImN5B4Gm3qr0m6JJkmGo0l8jVOBreSz
         FEOg==
X-Gm-Message-State: AOJu0Yweha5jFDbUmRpnxCNs+ORfoJ5dt3BK7pHI9MBEus2PN6MTXcvy
	4vZRpqx86zkWPPMMrt54gu8Ea/UCoWjzVxdAxe38f0ydZl39fL5ZXBgw92LjNJ4rI7QdqaDTKY2
	u+Nk0dQ==
X-Received: from plbld7.prod.google.com ([2002:a17:902:fac7:b0:2cb:b9f2:8e8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3803:b0:2c6:d710:3e58
 with SMTP id d9443c01a7336-2ccea45bb14mr85648365ad.36.1783630190856; Thu, 09
 Jul 2026 13:49:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-1-seanjc@google.com>
Subject: [PATCH v4 00/18] KVM: SEV: Fix RMP #PF due to freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
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

On the backend of the series, rework prepare()+invalidate() into a single
convert() hook, to eliminate the misleading use of the term "invalidate", to
(obviously) drop yet another callback, and to prepare for in-place conversion,
e.g. so that KVM ends up with something like:

	if (!to_private)
		kvm_gmem_make_shared(inode, start, end);

instead of a funky:

	if (!to_private)
		kvm_gmem_invalidate(inode, start, end);

v4:
 - Collect reviews. [Mike, Ackerley]
 - Rework prepare()+invalidate() into a common convert() instead of simply
   renaming invalidate() to reclaim_memory(). [Ackerley]
 - Fix several (mostly benign) issues in the "prepare" flow.

v3:
 - https://lore.kernel.org/all/20260630222607.497895-1-seanjc@google.com
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

Sean Christopherson (18):
  KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP
    guests
  KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
  KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
  KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if
    CONFIG_KVM_AMD_SEV=y
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
  KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid
  KVM: x86: Guard .gmem_prepare() declarations with
    HAVE_KVM_GMEM_PREPARE=y
  KVM: guest_memfd: Pass GPA, not GFN, to prepare() hook
  KVM: guest_memfd: Drop the redundant printk on arch gmem_prepare()
    failure
  KVM: guest_memfd: Fold __kvm_gmem_prepare_folio() into its sole caller
  KVM: guest_memfd: Explicitly pass number of pages to
    kvm_arch_gmem_prepare()
  KVM: guest_memfd: Align the gfn as well as the pfn when "preparing" a
    folio
  KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate() into
    .gmem_convert()

 arch/x86/include/asm/kvm-x86-ops.h |   9 +-
 arch/x86/include/asm/kvm_host.h    |  12 +-
 arch/x86/kvm/Kconfig               |   2 +-
 arch/x86/kvm/mmu/mmu.c             |  74 +++++++-----
 arch/x86/kvm/svm/sev.c             | 186 ++++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.c             |   9 +-
 arch/x86/kvm/svm/svm.h             |  19 +--
 arch/x86/kvm/x86.c                 |  21 ++--
 arch/x86/kvm/x86.h                 |   2 +-
 include/linux/kvm_host.h           |   7 +-
 virt/kvm/Kconfig                   |   2 +-
 virt/kvm/guest_memfd.c             |  53 ++++----
 12 files changed, 256 insertions(+), 140 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.795.g602f6c329a-goog

