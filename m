Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4D41DDEC
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040779; cv=none; b=bFfosc7hCne0FusXWGLgAxmywj9PX9+ktTdLguIp7orD/6STotJYAbuTtjzeUrUXHaOlvYEoseJB9GRmTaUU7ymWNotjIkWyjV4J8z/rEQA/dm7rx/pc4+1ZN9jc7rVn3gxOM8TM2OTZW/co0gjFDxSleCxpQ59AR2ldLmdSdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040779; c=relaxed/simple;
	bh=KUoipSs9DV2GhPl9YTTVY+WfBDpInNarT6aPDX8hhug=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YwvUd1CFcStNCPvRDBXCkmjitAuxKz7v33GpbyLMTgcyftz2yi0Kxw/XbvDgxGlCmacXszpFmnyJ5o1P7bE5oyGSySZqLuzQieb8FNfnVkewsPvTpLTFZu5twhOOzSmqEOYc+HjIPmMUfUn/+F6oVGjFB4nW4P54g+gNQ+ONfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1qKwxF/; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1qKwxF/"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so50057165ad.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787040775; x=1787645575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMKkYkkk95GIb9XsCQRRxhKodLzIwxWFmxxwcGqUN7k=;
        b=h1qKwxF/VvbjPCOZwjd2MH9FzWgkraBNHTvIJbHLYjhWXT2Ze+CscKwMRo99EbaeSD
         Occ7mwbDTggEkCkbXnSN5UhQxEXBkhj8dYYIYKOvzDWIz57hvJ3THse6wn3STLmZ/OlK
         9s95G1yZkfBG2IaaHzI2dlhhUFTOK5LHICQAfxk0AhWAlEeT9I+PIbnu5mydPFVxBzCe
         vWBWKEuGQm/quXFJiyqxIgEuY9A4Ovjm/LwjK+bhU7nMIpJmSJXnhqcrbxjDh+kOY1mB
         tpY3UBA2Nhw6JJy6bJKly6P8pPsx/1Pi+EuTv1LE+rBpXDPylAco16AYIOJNnc3g8Nhz
         a/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040775; x=1787645575;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMKkYkkk95GIb9XsCQRRxhKodLzIwxWFmxxwcGqUN7k=;
        b=VkDSQI4RQXTtf23shpSEzsGW/CXfMvhW6tfVkslQtNQ2clFwJiCC3WyXcW27qlzK5j
         iSdK3gb6EjGvppLwGnicESJZjNZYo5Ag8/lPev1TB3+rnYqK4OFTyhDmUvOqbvnwIGBQ
         1iRDeIfBbvxWqDCfbnvCT5O/cCZJXvAean/wXuWnkdFi8roC8i/2UrQ2GzfAPI9OLqG+
         aLymCDAcUBVe6xpv7X5J5fbBOnjvooCrBvl+AfhUVRWSEZ7p1mzEwR1oCHlcQhGdbqH7
         nNhD6kLPdNKOVry+eGMHv+SlvKBcVkwCSvIuuSG5Q7k8++ptY1W2AMki3ajsmiTG3K2U
         AqEw==
X-Gm-Message-State: AOJu0YwtnXz2QWfXb8puGnT6LIC1VULLWChLmzx5dPr7G4/CuRpBJQyf
	G9nSGeGXB59WrhZ2qoAdKwLaBgxfTjUGMEDcJ9dlU6U7LpgX8AjPPmJdP/XQPlaoDQYO/qQG//H
	4DFzgLQu/gdKk5EVWijbLpVT+vg==
X-Received: from pjbei20.prod.google.com ([2002:a17:90a:e554:b0:393:13be:cfa8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5606:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3933b78b698mr33144681a91.6.1787040774461;
 Tue, 18 Aug 2026 01:12:54 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:12:34 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPIThGoC/x2MQQqAIBAAvxJ7biElMvtKdJDabA9qrBVB9Pek4
 8DMPJBJmDIM1QNCF2dOsYCqK5g3Fz0hL4VBN7pretWjDxQwJhQ6Tom4u6J0qrXaOG1Xa6CUu9D K938dp/f9AI9JCcplAAAA
X-Change-Id: 20260818-gmem-no-return-page-614927a29f97
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787040773; l=2686;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=KUoipSs9DV2GhPl9YTTVY+WfBDpInNarT6aPDX8hhug=; b=EgeFYXGdnee+DqtAZAuFl7wPqeYsRZalvhJWB/S8hZkwyGM7a68a6iJ22FyMAzillodZx4SYz
 nbxSWklOZHEDh9KJySZJXlhyxArVikRqndiYwykZKzHFaFyg+9DTUs0
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
Subject: [PATCH 0/4] Stop returning struct page from guest_memfd PFN lookup
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

The main difference from [1] is that I think sev_handle_rmp_fault()
currently doesn't correctly handle the case where a racing truncation
removed the page from the RMP table. With that fixed, I think
sev_handle_rmp_fault() doesn't need to adopt the MMU invalidation protocol.

I also split the patch up so it's easier to review :)

[1] https://lore.kernel.org/all/an5RJYTwlYeym--O@google.com/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (3):
      KVM: SEV: Treat unassigned RMP entry as benign race on PSMASH failure
      KVM: SEV: Drop page refcount early during RMP fault handling
      KVM: SEV: Drop page refcount early in VMSA reload

Sean Christopherson (1):
      KVM: guest_memfd: Stop returning struct page from PFN lookup

 arch/arm64/kvm/mmu.c     |  4 ++--
 arch/arm64/kvm/nested.c  |  4 ++--
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 arch/x86/kvm/svm/sev.c   | 17 ++++++-----------
 include/linux/kvm_host.h |  6 ++----
 virt/kvm/guest_memfd.c   |  9 ++-------
 6 files changed, 15 insertions(+), 27 deletions(-)
---
base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
change-id: 20260818-gmem-no-return-page-614927a29f97

Best regards,
--  
Ackerley Tng <ackerleytng@google.com>

