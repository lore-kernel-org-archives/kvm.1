Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9E31619A
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512525; cv=none; b=A9052lqZSyIIvThojkB8sCwuCQerMDHBRJfPvVHWhhHMsAYn272yHCzc8En89Mhk3T2bfaqDaH2AE0T5PeMM5uvqYrTbM2MhFmIl7/Zr+y/mWfaXcJo6kdnOTKZq5uxuNJ9/YyhYDJRNJWr70+aDxuEFiK1NezqrOX1rMTb4zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512525; c=relaxed/simple;
	bh=SQd+VZ4O0rynu6+m7mKKooZvOWskGbg2FcoyS/3PQF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XDhYykbaULd9ocBcQC5etMB/zWDq0Z1ttmfFmX6COt1517OqXwfnIZYSPtxpv3EMAMB5+7h3PFAmNoe19S2cUUC0DGCL0Cr3Fao/FEMlhstZEpFGXZvifMC/TfNjb0JbBycFC8N0M4pzmWNv1l5rUTeDzA+nezto8npgMIYGuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dopI5plG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dopI5plG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so701430c88.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512522; x=1775117322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=dopI5plGcQ8Qp5CnnfOCorbuBwu4UYlMRaGr7zwI2yiBqVEV72CBa56RIBGjwbbVjr
         abw6KGEnbaKAdvA7AxiH3y1rbav0EHZCp1VQ+T7MTaW1HeyeQJxjje/BQ9Np/GmMKOlO
         2tRpgibyyi3I1D0T6IBOu/f0Mil3A0rNziTwEcZVLm9F+ZoFC64C9egBkGt3CfTQWqNy
         MQaZURAEcuA/IhGW6fA4Kw2CK53/JvZ9Ux4Tsepp33XMSJwdcZ+5CyW5JzUiKEKT/9gv
         lVeZDJxWePqgxrHXJAfr8ukWFfq6FLYD1aR6r/dEnriHkfHaUMjsJeX8yxfD+kEla5Dh
         Dwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512522; x=1775117322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=EQO1poUbO9N3f6VP0eKsvPX88zBccA9LiQScuqW4VA+vGIuWeqSC4VM7sZ2Tx9reeO
         4PknhdSWJS8pDqYDFLLkNmAFqaIoIyPw26l2+cZzted952Tw4EXVIQBS4Jr4rPAkjtLN
         nEm16XWmItMkS13aHo/FETQb+2SO1AZs4QYjMiBRMDrv/pvPL3/7RDAF5vHVZHY6sSGf
         72NoMjmo0FMgNt1oYqgkAOCSl3Q5q+irAp5by75HM6XWigF9UzbLihpMXMAOIDMHUp2U
         ictEbhGNVTZdM/d5+3ggxtvdFMxf+zpHGdxUxFC6zFN+dO2FZToUPze/Mv0hKrQhDd8g
         LK9w==
X-Forwarded-Encrypted: i=1; AJvYcCViwYCvUIcdb6ZsotwlSOIu3cPXjwujPyinxT7kzQkmo2wk1cPuXJt6eD3k/s1zRJ+GvI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uwiksESGOOFPlz0sbYeqdgEtGiA890rL9+ZpAHKJrwS5wqZ3
	0FsoC0RJyEj5Dhtll36P8vqIKXQIZwlmrfaLFz+BfyBMAjKktm99vwdaCji+0H8jWF7RTs5S+kS
	iaKXOkA==
X-Received: from dlbuy10.prod.google.com ([2002:a05:7022:1e0a:b0:12a:6d14:dfd9])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac3:b0:11b:b622:cad9
 with SMTP id a92af1059eb24-12a96eceb8emr2826837c88.21.1774512521385; Thu, 26
 Mar 2026 01:08:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-1-surenb@google.com>
Subject: [PATCH v5 0/6] Use killable vma write locking in most places
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Now that we have vma_start_write_killable() we can replace most of the
vma_start_write() calls with it, improving reaction time to the kill
signal.

There are several places which are left untouched by this patchset:

1. free_pgtables() because function should free page tables even if a
fatal signal is pending.

2. userfaultd code, where some paths calling vma_start_write() can
handle EINTR and some can't without a deeper code refactoring.

3. mpol_rebind_mm() which is used by cpusset controller for migrations
and operates on a remote mm. Incomplete operations here would result
in an inconsistent cgroup state.

4. vm_flags_{set|mod|clear} require refactoring that involves moving
vma_start_write() out of these functions and replacing it with
vma_assert_write_locked(), then callers of these functions should
lock the vma themselves using vma_start_write_killable() whenever
possible.

Changes since v4 [1]:
- added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the code
stayed the same)
- split patch 2 into 3 parts, per Lorenzo Stoakes
- converted vma_start_write() in mseal_apply(), per Sashiko
- changed vma_start_write_killable() error handling in
set_mempolicy_home_node(), per Lorenzo Stoakes
- added comment why mm->locked_vm is fine even when we exit early,
per Sashiko
- moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
and Lorenzo Stoakes
- set give_up_on_oom on error in vma_merge_existing_range() to propagate
the error, per Lorenzo Stoakes
- moved validate_mm() out of the error path in expand_upwards(),
per Lorenzo Stoakes
- dropped the patch changing S390 error handling, per Sashiko and
Lorenzo Stoakes
- reworked error handling in clear_refs_write(), per Lorenzo Stoakes
- uninlined process_vma_walk_lock() while changing its return type,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.com/

Suren Baghdasaryan (6):
  mm/vma: cleanup error handling path in vma_expand()
  mm: use vma_start_write_killable() in mm syscalls
  mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
  mm/vma: use vma_start_write_killable() in vma operations
  mm: use vma_start_write_killable() in process_vma_walk_lock()
  KVM: PPC: use vma_start_write_killable() in
    kvmppc_memslot_page_merge()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 fs/proc/task_mmu.c                 |  12 +--
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  12 ++-
 mm/mlock.c                         |  28 ++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   8 +-
 mm/mseal.c                         |   5 +-
 mm/pagewalk.c                      |  22 +++--
 mm/vma.c                           | 146 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 190 insertions(+), 70 deletions(-)


base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
-- 
2.53.0.1018.g2bb0e51243-goog

