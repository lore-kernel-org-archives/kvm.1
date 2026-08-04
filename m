Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883983A9605
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845149; cv=none; b=DIYllLDlJ0PJJKHHXIbX02AXe55lmVYFjG8PgH80C/kVireePRmEYZhxwAJeTKjozfgzfsCDRCpOQQdoU0FZiB5KoQcKSZqL4qJPEXzayiKz0V7Hg181xsQqy/qdQ6DEeVVdzGmZVlLYg85X1tvaLV00tqQoh1G8m2RWtU/rmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845149; c=relaxed/simple;
	bh=qhkR2v3EkAztMd7zn4yTHh4XbDWdyGkn7YKKdVCCJyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYI8JcYRnFhtbENxk80W/Jq65MtAYHGhEk0LcV/TYDz175jewHX/oUfrbl+1IckkLs3buyY8e7YVFr25ck3Uabw9dIYFjNOpvwVfr4bJZiFWrrA/tIqVvyA3NheONeSCIWohEgJaTLVi2J9y8Nd0ijjmDv864CKBAtRGglpcbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inYoLVmF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xw4bPWhW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inYoLVmF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw4bPWhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
	b=inYoLVmF5eIIk26UmXAO9/JNd0Dnbf/yDhvKSt0dVuxyIGhT91Ch704t7AzP82oupGYVCH
	ZKn1A7F6XlN12VCy0Y4NnsCsvh4OCcoUsvY9zh8T7vWxUCbrzgRepJAN6fDD/XLueG6ES6
	pqtybDUPIuOJNWdqGUYBJzmsNwqMmzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-o9hzQ95WM7mgRxTJ6tyfXQ-1; Tue, 04 Aug 2026 08:05:34 -0400
X-MC-Unique: o9hzQ95WM7mgRxTJ6tyfXQ-1
X-Mimecast-MFC-AGG-ID: o9hzQ95WM7mgRxTJ6tyfXQ_1785845133
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49560dddaa4so14975515e9.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845132; x=1786449932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
        b=Xw4bPWhW5YhH4Hbuq1Zzw9eyP1K5934gjy2faqt+1W0dGTLCvjgyVjxj57+XHM1UQg
         +O+fJH+kTZtaqFhjKX5zIotBkFK6hlf3+09VU9QxwRyt5ENJBpQZbV85xglnogJdf7yc
         v2YIN/eqCdG/7TZJOOXar3LmbF4SVVpgnRrn/P+oNjoHpZNbx5pkqxDOztWlVP5prssL
         gIlCczdj32EXl9w9UR03OHonik/Ks/w6kpFBPEWwuQadRz9yFtnh75eOLvjOiFLx5u56
         yitXwrc5nLdli/Pufu/E7MA3uNd8NAx9ThYpLSbjJEizOKOV4c8M9oT3KYZr4azqij74
         xdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845132; x=1786449932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
        b=csrnkqa1esqbdnm+gHFJGx2SwNA8HxN+Ow0DjLrMBIZSaOwJPrtR4zbl26/sFH66MG
         6gtQ4yaK+8A+eKIHXPpus2PdpdjkbE9FykpkBOltXh/8p1ucqjR5KlfdKfd638l3uCby
         W6QrcysNCIn0TjmcKGpVXnE2tRnOr5a8Inc5Y4YrD5srhzYrKscdGizCbbkvUj24puGQ
         QAECYVps5FYTX6liJIPmUSoOLHDKr9fuB4IZ9zGQL6FjWaarqifhpAW7EHQK7303K+I8
         ukI5UQKabwOrpmAYKmKn1g/mCvhy2tYS5HmkQV72vmA6Hjt7hf0F878MhdmEgBFDQjr3
         7AfA==
X-Forwarded-Encrypted: i=1; AHgh+RoWXkw00b24YVnNUy6dBF7GpkkacxyiV8WBigwnfa8O7YGa6jtzFzP+rE8EHwh5c5OyADM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDj7Oa+M7kw6TDsw/e40o5QP/6A6c00TpJNDnYszbMzzOtjLz
	WHGRM6IrZpgUJLlRdrKO+MXLigXD8coJdNNequAtO0VcH7RM+crKi4fHxuEDFAbpAf2tFMVahr2
	wmSv2QVbYioqT5Ts3pmdIRINEHdGVGOHes2T49VLoFp2HxSw5kGUQ+A==
X-Gm-Gg: AR+sD12JhzwUBdkfrplPQa5/Qr8qP8z65nGEUpd1BvM43gqssgEe0ZyoF72PSxQ0Wdq
	8ClyobWGmGKwTvIvneBRkwCqM0sYljX2k8gjp88jyLoVkX484eg7k/5v78qNh2zJnf1XQ6QQQ/J
	7NiJU2K2+hOHPk/g6g7hG4zCNkM/W85+xqZiprsh4x4V73Snyv28fELOQ9hluItTlpl19z0pYe4
	jg2K9wC3+gSxWgqovkNsgAR/tXcj4usfCrB8g08nI9C1+FTtDNI4zrcH2QgKKR/xjPMqW6wqxN5
	p41A3KqFDoRhzbmVtFGHRoU18fNlfgZfgbz/fmow954qBZFLJbryrA+j+60b2VUnNnqVJjxo+YC
	0cUqw+LNmY+9vwLoax+hxtDdO6DrdaRifvrRE5Zrpg3wU8zgQO1ViauaNQ48mNyrRctFLf1d29p
	wtyag=
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4980c673d61mr252270785e9.12.1785845132435;
        Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4980c673d61mr252270015e9.12.1785845132021;
        Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec606sm99039055e9.14.2026.08.04.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] mm, drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
Date: Tue,  4 Aug 2026 14:05:22 +0200
Message-ID: <20260804120529.1730187-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This "v2" combines three series that I have previously posted separately to gather
reviews and tests:

- kvm: apply VM_READ/VM_WRITE checks to all VMA types
  https://lore.kernel.org/kvm/20260731175834.1121005-1-pbonzini@redhat.com/

- mm: pull writability check to follow_pfnmap_start()
  https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/#u

- mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
  https://lore.kernel.org/kvm/20260731164341.1109827-1-pbonzini@redhat.com/

All three, together, make it possible to write drivers that use .fault()
and .pfn_mkwrite() callbacks for VM_IO|VM_PFNMAP regions, and that also
interact correctly with users of fixup_user_fault().

The problem is that if you define .pfn_mkwrite(), vma_set_page_prot()
clears the writable PTE bit in vma->vm_page_prot, at which point
the .fault() callback has no way to create a writable PTE.  Users of
fixup_user_fault() will then see a read-only PTE and have no clue that
the page needs a *second* fault to reach its final status.

fixup_user_fault() itself does not have a good way to notice this, because
vma->vm_page_prot is an opaque pgprot_t, so the fix needs to be somewhere
else.  Other preexisting functions, namely vmf_insert_page_mkwrite()
as well as vmf_insert_pfn_pmd(), suggest that this has to be the driver.
In fact, of the five vm_ops that use .pfn_mkwrite() together with .fault(),
three are in file systems and are not buggy: all of them ultimately end
up in dax_fault_iter(), which uses vmf_insert_page_mkwrite() to correctly
insert the PTE.

The two problematic implementations instead are both in drm code.  One, in
drm_gem_shmem_helper, was reported as a KVM regression; the other, in
vmwgfx, was found by inspection of .pfn_mkwrite() implementors.
Both of these use pfn-mapped regions, but there is nothing like a
vmf_insert_pfn_mkwrite() function that they could use; the first part of
this series thus adjusts mm.h to provide two new functions for this
usecase---vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite()---and
then teaches drm's two users of .pfn_mkwrite() to call them.

This however leaves another case buggy where fixup_user_fault() is preceded
by follow_pfnmap_start().  Most callers of follow_pfnmap_start(), seeing
it return 0 for a PFN that is mapped read-only, would not attempt to
call fixup_user_fault() on it, and thus the PTE would not be upgraded
to writable.

This is arguably a bug in... almost all the callers of follow_pfnmap_start(),
but fixing it is much better achieved with a small improvement to the API;
if follow_pfnmap_start() is told by the caller that it needs the memory
for a write, most callers are simplified because they were doing such a check
anyway and now just see -EFAULT.  They then proceed to call fixup_user_fault()
and everyone is happy.  This is done in patch 5.

To sum up:

- patches 1-3 introduce the new MM API, and use it in the DRM .fault()
  callbacks to install writable PTEs in response to write faults

- patch 4 is a preparatory fix in KVM, eliminating inconsistencies in the
  handling of !VM_READ and !VM_WRITE VMAs; these would return different
  error codes for a !VM_WRITE VMA depending on whether the PTE happens
  to be mapped (but with wrong permissions).  This needs to be here
  because the next patch would introduce even more inconsistencies.
  
- patch 5 moves the check for writable PTEs from follow_pfnmap_start()'s
  callers to the function itself

- finally, patch 6 is a KVM addendum that will have to wait until
  the next merge window; it removes yet another inconsistency in
  KVM's handling of !VM_WRITE but is technically userspace-visible,
  and therefore it shouldn't be included in stable kernel releases
  unlike the rest.


Thanks,

Paolo


Paolo Bonzini (6):
  mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline
  drm/shmem_helper: use vmf_insert_pfn_mkwrite()
  drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in
    use
  kvm: apply VM_READ/VM_WRITE checks to all VMA types
  mm: pull writability check to follow_pfnmap_start()
  kvm: return -EFAULT for writes to !VM_WRITE IO mappings

 arch/s390/pci/pci_mmio.c                   |   2 +
 drivers/gpu/drm/drm_gem_shmem_helper.c     |  38 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  42 +++---
 drivers/vfio/vfio_iommu_type1.c            |  17 ++-
 drivers/virt/acrn/mm.c                     |  10 +-
 include/linux/mm.h                         |  84 +++++++++++-
 mm/huge_memory.c                           |   2 +-
 mm/memory.c                                | 146 +++++++++++----------
 virt/kvm/kvm_main.c                        |  44 +++----
 10 files changed, 232 insertions(+), 160 deletions(-)

-- 
2.55.0

