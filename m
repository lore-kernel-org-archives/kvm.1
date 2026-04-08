Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED43D75C7
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669171; cv=none; b=XXdi7ZJt6XHFbgR2UtUuWfeI08xArly9vQ9LcaGs0HSCcC5YnPrTIkVM5qEAvlz41MvcKypZ9fKoDlxFLhEUWswPQUAwtGVW/mSkTRUyf9r8lg05IbtrkXjIdkNeVSSdQqMwOGnzXbVAWEyGPqQXFzOkUmGcyDiIQNB1+J7yRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669171; c=relaxed/simple;
	bh=dgH9wexk06pz5m2UJD1w1HZDP8H4FB/yzSUqMy9TCQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DXIeSYOUNxYrkOxdxKJxayfUSSPqc+Zqw/Xq1GYQyyF2XMoI48vreU/7K7iM37//DdPig22BU+TRt2ePnjxcU1tN3/qR6ejNHq7dqjmayoY0YsChTahGgbdurS+SM/sxfXAs5nRw0XVyFWIbu5xsEOBOJbQ/DPOD4CVXP8AKpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJ5Em1Di; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJ5Em1Di"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adef9d486bso677535ad.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669170; x=1776273970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXQyTXYZ9HA4GAttYpd1iImAOXEXFhOnKZhr8KGG2U8=;
        b=rJ5Em1DiBkoyXOaseJ/MCOYNqx1WVUntYGWBAuQFBTR689Z9NbsZgghxuEicL/SyjO
         RxuoLR2kPgCo4eoqjb2ZVMIJtgSSkrCGh80IltvHl8H6YYJyEWQ8nsfUdWcQI92Rz0+7
         GRCEjAiyyPIbuJamRnwoYg9H+Zn+MFuIbs9CXfO1TqMhLC3ug3UgQHS7KK3VN4hCMKs2
         fdAaxl2ic91DeLls6eTlmaEWCZJHW+gDSKEHp5dhab1g8iQ5xdQY9cDnsJnVGtCMRm4o
         iSkT2cqkXtg5XmyluMyv+hDZ+svbTsl6wx7DiKLYVvAbiRBx15EkD8InIlbc/Pe13+KA
         wdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669170; x=1776273970;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXQyTXYZ9HA4GAttYpd1iImAOXEXFhOnKZhr8KGG2U8=;
        b=KTPclFMjCUjZkPzcn3GV/uhmQ953iUPuBdbot2jjNOFKL6cSY1WrEGFZHeuHxyvuno
         yYkqrwRs5mtlL4pq+mx6j4yoC9Ai1iZyzwq9DPJAeasXCL5qEyWeYY0sthqZ/RUCWFhM
         uTBrB6AFIMuduRM7eRlLGdVvjTfDJr784Hb/e/vG7nXjn4lp0ndF4bvAVVUo+jaXmtiT
         BfgLgSuNe17zKJq6df3o1HlZGANpyimOe0KDCBTqydt3ePQq8g+qLYhqaz72HURhhiyY
         JN7BMIMDkpt5aNAdJxNj5k6Z4Hz65c/HmZKw5FAEgpbB8MG+kyY/hI7+j3Thg4tSfZ8V
         Vnsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7y4GHBYIBx/jQl3wNLy4pSEiO5yRFg0QdIcbW/PUFqMTJbulFAvNEe7zKfBnQ6r8WsKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0h6afXsbd3kPAjDm4M9HOaQSk6ODh/kt3tCdLQAfWpPvZ8Ptd
	ZdgjAn3WnQsoj04i9vIriQrA4nhnFXed2YYz/fRam+dDdKfvhaQWtaUh9UcIrtKTOYBtu6AfS0Y
	pt5XdSA==
X-Received: from pgbcp3.prod.google.com ([2002:a05:6a02:4003:b0:c70:e4b6:a27b])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3286:b0:398:b499:44e0
 with SMTP id adf61e73a8af0-39fc832f20dmr634781637.41.1775669169633; Wed, 08
 Apr 2026 10:26:09 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:41 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFmP1mkC/x2NwQqDMBAFf0X23IWQ1Cq9FvoBvRYPqXlpF4zKh
 ooi/ntDj8PAzE4ZKsh0rXZSLJJlGgu4U0X9x49vsITCZI29mLNxnJAm3Th6Gb4KTpEDBr8hcJS VNfa8ODa2bdrQINavmkpqVhT73zzpcb9Rdxw/yad0vHsAAAA=
X-Change-Id: 20260403-memory-failure-mf-delayed-fix-rfc-v3-02878d7ef5b5
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=2920;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=+gY9M7pK6g1wVjdUn1IEgoo+d0875SrS/mpl3kkU7n0=; b=pZPKd+rhK4e+NAPviiUHM2w6HcUVC5JRoewg3GzHhgWj5s8+YLuzvk/OygZLAk2t9HwTzPnwm
 zL5GLng99vcD3WUNtHTJ/15DbjUedlvIDsEAcNeVyyvO2Xr7qjvDPia
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 0/7] mm: Fix MF_DELAYED handling on memory failure
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here's a third revision to fix MF_DELAYED handling on memory failure.

This patch series addresses an issue in the memory failure handling path
where MF_DELAYED is incorrectly treated as an error. This issue was
discovered while testing memory failure handling for guest_memfd.

The proposed solution involves -
1. Clarifying the definition of MF_DELAYED to mean that memory failure
   handling is only partially completed, and that the metadata for the
   memory that failed (as in struct page/folio) is still referenced.
2. Updating shmem=E2=80=99s handling to align with the clarified definition=
.
3. Updating how the result of .error_remove_folio() is interpreted.

Changes from v2:
+ Address the comment about fixing the typos and clarifying the
  'unmapped' status from Jiaqi
+ Address the comment about merging shmem memory failure selftest into
  memory failure selftest from Baolin
+ Align the consistent style in truncate_error_folio suggested by Miaohe
+ Fix some bugs found out by Sashiko. e.g. set vcpu register when VM is
  running.
Thanks!

Would like to request reviews from Miaohe and Baolin regarding the
selftests:
+ Is adding more TEST_F()s suitable?
+ Are you expecting refactoring to reduce code duplication in
  selftests?

Would like to get feedback on the direction of selftests before looking
into adding selftests for hugetlb.

Also, hope to get some feedback about the guest memfd test in this
version. At a high level, should I move the memory-failure specific
guest_memfd tests into a new file? guest_memfd_test is starting to get
really large. Also, I'd like to use the kselftest_harness to handle
teardown/cleanup (unpoisoning memory poisoned for testing) on test
failure.

+ RFC v2: https://lore.kernel.org/r/20260319-memory-failure-mf-delayed-fix-=
rfc-v2-v2-0-92c596402a7a@google.com

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Lisa Wang (7):
      mm: memory_failure: Clarify the MF_DELAYED definition
      mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
      mm: shmem: Update shmem handler to the MF_DELAYED definition
      mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED =
cases
      mm: selftests: Add shmem into memory failure test
      KVM: selftests: Add memory failure tests in guest_memfd_test
      KVM: selftests: Test guest_memfd behavior with respect to stage 2 pag=
e tables

 mm/memory-failure.c                            |  27 ++-
 mm/shmem.c                                     |   2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c | 238 +++++++++++++++++++++=
+++-
 tools/testing/selftests/mm/memory-failure.c    | 109 ++++++++++-
 4 files changed, 357 insertions(+), 19 deletions(-)
---
base-commit: 513de28cb70afe6d3e24fe5b432c13363f9cfda6
change-id: 20260403-memory-failure-mf-delayed-fix-rfc-v3-02878d7ef5b5

Best regards,
--=20
Lisa Wang <wyihan@google.com>

