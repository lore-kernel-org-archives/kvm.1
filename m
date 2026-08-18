Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7736A350
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044561; cv=none; b=Mxe45vULems6XGYP4MtJriMLzgeT9O/elUAhIDMncdHbPsYdWbS5RbwxZEELa/oxYvhOrzhBXRCvAkLpMvDaOUdPj73SV83C6JToyR9Qq1zGJTjbe1VlR3nelPkZml7ZQiL6VbiYIgBshMMA1zum1ldlRJb9sokV4NYELQZt7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044561; c=relaxed/simple;
	bh=8nfCX0wyujmL4llDuS/jfPqo2MBhNNnF8dgEODLCyh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LXj724eDOTlJnFWysBoZglRgE/ksmnJsmnbub5JIZtka4fCbKF7GvDo3NFHwx2QLQB8LZODTKnkt19RU+GpXTHjaWFkM/sXx6jy2BgBkck9k0O/bFcvJejByZgP8l718hkReNeVsvemaSYbUB8EUbGV67XBOcMS34ppQ3rOqIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDeznzL8; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDeznzL8"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc5faecf01so91071295ad.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787044558; x=1787649358; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnJSHEm0cKOLTTd/rL/PNENkG51D5ISDuMgN/1Gh3wY=;
        b=UDeznzL8oZgu75SNB086YGOpW9vokEr4iqaEdlK1WCtUYagHyKs/PJYs7ksaxZKj3t
         kE7YJZgUHoqNN6WZYIl7jF5m+OpEMh0CCYe+oQmoDpEecLAm60z1/vMTSjE7xzjx/sK0
         ixcmbpsqew5L36Sf4e53je4Z1U+TiOBOs6AsaExL1+lUr+vkN5NPYRBd2QtouNvn56mV
         MRjAKk7LQrjX/eLDJtl+kDz3UZKopsikWu6PBboiiBJ8zqPU1hNArhR1OcZwqBRxfQFh
         /iWjt8VYTciEA2EXvPAyVS7uBZCOQ4AxyyeDUo4utOAxiWjitLQaenFCv8/FcnJ3YkoF
         56OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044558; x=1787649358;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnJSHEm0cKOLTTd/rL/PNENkG51D5ISDuMgN/1Gh3wY=;
        b=EHnzm/z0FqH/ZN9/2UuDzJmegDFFaulKXUBUHvLF9L1vVTKs2Ddp+TGijvN0XC+mSA
         /R0Aapb7kMJJnD/DAdJ4InVwl9L9DBnk2nummSqYJC80cmart0ufaWzWddsXzBHs1hoC
         u13AS63/zAfYLds7sG0yTy+NRf/6itzuoeWzIGwRlckj8IPOLslvOfaEyX/Qop4E2e9n
         lNEUaQRiPkMZ8PrRy1gfSOnJKOIA2eU3J01Yuf/xevXfZlmy4u5jT02NxY4QZEuZJwP8
         p5/Ct0kZJ2LPy7SZjcZnf5xgil1E72OciENcbf51OSTJqKrJJdI3eYscI0TBES5SognI
         Z6nw==
X-Gm-Message-State: AOJu0YwOHWjwtizyi9GjZ2TQezl2psvy1RW/4Ts3WTrloOfOaSq4K7e7
	w60pWgaQOQ2QncfWYoW1D+K7jUG5AjfdxKkXw4P1RhlW1zrV/gz+0h4r1HHohJfAhtGnzRSIYli
	kx9FgSd+FU7N7WkmfBwZsEnPUiA==
X-Received: from pllw5.prod.google.com ([2002:a17:902:7b85:b0:2ca:c162:e758])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f543:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d5c5381b3fmr73832365ad.14.1787044558177;
 Tue, 18 Aug 2026 02:15:58 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:15:51 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMcihGoC/32NQQ7CIBREr9L8td8ANi248h6miwofSmKhgUo0T
 e8u9gAu32TmzQaZkqcM12aDRMVnH0MFcWpAT2NwhN5UBsFExySX6GaaMURMtL5SwGWslY63SvS
 jUFb1UJdLIuvfh/U+VJ58XmP6HCeF/9L/vsKRYWulURdF1jz0zcXonnTWcYZh3/cvW5zXrLcAA AA=
X-Change-Id: 20260818-gmem-no-return-page-614927a29f97
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787044557; l=2663;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=8nfCX0wyujmL4llDuS/jfPqo2MBhNNnF8dgEODLCyh8=; b=SsJhnqW1UiCBC+kmoHXVvN7F9aUBGeKnwkUA52xWV7vWY6dfHFFLbL1X18fpaR+ijJHPWumDH
 S+ZTR8oXWHKC7FRxgrDLER+Jz8CIfVDEUeIbzEi5i6liEXv5AXMF2zy
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
Subject: [PATCH v2 0/4] Stop returning struct page from guest_memfd PFN lookup
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

KVM currently expects kvm_gmem_get_pfn() to return a refcounted struct
page. Callers (such as x86 TDP MMU, arm64 Stage-2 fault handler, and SEV-SNP
VMSA / RMP handlers) hold this refcount across page fault handling.

Holding a page refcount across fault handling is problematic for guest_memfd.
In-place memory conversions between confidential computing shared and private
states inspect folio refcounts to ensure exclusive ownership by guest_memfd.  A
concurrent guest page fault taking a reference on the folio causes conversions
to fail due to an elevated refcount.

guest_memfd already notifies KVM of page invalidations, so users of guest_memfd
within KVM only need to respect the MMU invalidation protocol to safely rely on
guest_memfd to ensure page presence.

This series first prepares the SEV-SNP handlers by treating unassigned RMP
entries as benign races on PSMASH failure (which can occur on concurrent
truncation) and dropping page references early in the RMP fault and VMSA reload
paths. It then updates kvm_gmem_get_pfn() to drop the folio reference internally
and stop returning a struct page pointer across x86 and arm64.

Removing struct page from kvm_gmem_get_pfn() also moves KVM closer toward
supporting memory backends that are not backed by struct page.

I really want in-place conversions to merge in time for 7.4 and so I went
ahead to try this, building off Sean's sample code [1].

[1] https://lore.kernel.org/all/an5RJYTwlYeym--O@google.com/

I also split the patch up so it's easier to review :)

Changes from v1:

+ sev_handle_rmp_fault() does need to adopt the MMU invalidation protocol,
  please see reason in patch description.

v1: https://patch.msgid.link/20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (2):
      KVM: SEV: Treat unassigned RMP entry as benign race on PSMASH failure
      KVM: SEV: Drop page refcount early in VMSA reload

Sean Christopherson (2):
      KVM: SEV: Drop page refcount early during RMP fault handling
      KVM: guest_memfd: Stop returning struct page from PFN lookup

 arch/arm64/kvm/mmu.c     |  4 ++--
 arch/arm64/kvm/nested.c  |  4 ++--
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 arch/x86/kvm/svm/sev.c   | 45 +++++++++++++++++++++++++--------------------
 include/linux/kvm_host.h |  6 ++----
 virt/kvm/guest_memfd.c   |  9 ++-------
 6 files changed, 34 insertions(+), 36 deletions(-)
---
base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
change-id: 20260818-gmem-no-return-page-614927a29f97

Best regards,
--  
Ackerley Tng <ackerleytng@google.com>

