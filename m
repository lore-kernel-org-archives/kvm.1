Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AF3AEF5A
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514075; cv=none; b=hroiYd0QYWgu8CEN58JGixrMJDm8kUkvEFmsXr1GMQx+gtLLdwduL/vGdZvpbXBGdyCo1QzBXtLaeKtsoyD6sjywS/rAmJiTOVX+5u0zrftV9KUOAVOY0vDj9b2f+w9arnPTph9KtX+H/1EpvoeCEHBY/JMjL+ZrLTfOY/kLPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514075; c=relaxed/simple;
	bh=1Aw0ssJRltic2ix3YdWreO66fmQSxPAs2WbrM3C3g7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jNnmzRRSrqJjb3R4Y3zMlPnhlaHV+iALxgHq9Fjxpzr08yQ8GCvVTPkZZS1IG+434ANI+DiTXIpwnySpXFkb6svyzvY5B5/gTyf6Mt24T/DYk2MhuquG8L20H59TQ6UwXUd76AFZBHPlKutSp74t2bP7Q7aQ+muWVnuKyWevb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIOzs3Gb; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIOzs3Gb"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8486c3411c8so3495046b3a.2
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514073; x=1788118873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1YHDRXuyabVdapSHSXZFO8jE+pTDDymBWhtJlJpEAUs=;
        b=RIOzs3Gb0SgwsWMu8Z/ZTx0uv/T14eX34PAnrVn+KaF4kPx8AQ/0rrXGzYRY2+v7aG
         WhXH6e8x16ssbjUSs+MsXGGQ9YxjItsIlXeSWNI07f7iml322Pz1fdpLXCC1xkGhHz8E
         az7T3IVyB/v4a/84rioWO1a9nYqr9HKBzmHg/Rj/mCx0hd/nNOjONMehWVwZ9cXOzBVc
         4Cq0utoolDjKnM4p7/3QYkcjW+Iujvs69wcvCFMl2GQRWg2N1WCdJ1Mr9xO/cx5jJyo5
         bvflT+LNpvrtoXRW3SvbvyHQEhmeKoyIqe1aUdOY6wpD3Jb8uPwbPv2Aa4s3i+ofo1eu
         rzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514073; x=1788118873;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1YHDRXuyabVdapSHSXZFO8jE+pTDDymBWhtJlJpEAUs=;
        b=j9wEqlDdhOTerKn+LAeBJApzEERknbDFJPBRFZrfvXWBzm8Y+EzYRLjI/my37D+d3g
         KSp3L9E3t8uus81IxYo/ktA4NQJ8FGL3go3WGe3R2aEYW+syuk8B3JA5gc/0+Q4I25GV
         0b+GXujNtQg97LK6mUy8O/TMBWOUaFT238Fz2N/BJPxPDyTNOlrx0tx5RLIpXvlE6JoA
         Q5oMBSz+1vBdkkX25vaVVL9xsoOt9yciX506WZzr+dhtFgvKZRpd/sxEuaBhaQd8dfQR
         RJhkUJvyy6IlXdcI2QSekEosN+b6EA/b9Dq7qlr78Z463dLEmN8wtTQwKgHUo9w7cbb1
         Yqdg==
X-Forwarded-Encrypted: i=1; AHgh+Rq34M5jo0mOtPaSuFEU2p6ESTBxkdWsUoZ8Q3Amn6IR3Sz9PO6jj1zDOJueqFRZYw2jxr8=@vger.kernel.org
X-Gm-Message-State: AFuF++ny2U9PPdWG3Db2QgSIiHnBXNmpvdNPlrXhiX81hMy7wx2lB0F+
	OE/rB0IDl81TeCrG8TgbLPyUuxkBXTrSVVNQQORWWySM9fkDAh8PH28lUloAtQe+CLZl0KS8r/e
	/+pw/8w==
X-Received: from pfcj21.prod.google.com ([2002:a05:6a00:1755:b0:848:3f4b:c4da])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:997:b0:84a:29a7:f650
 with SMTP id d2e1a72fcca58-8520b06403bmr21400701b3a.0.1787514072766; Sun, 23
 Aug 2026 12:41:12 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:53 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMVMi2oC/4WNQQ6CMBBFr0K6dkzTUEBX3sOwmLZTmIRS0yqRE
 O5uxQO4fC/5728iU2LK4lptItHCmeNcQJ8qYUecBwJ2hYWSqpFatRAoxLSCR55eiSB4cDThSg4
 8v6F1GjtfY4edEaXxSFT00b/3hUfOzzI/7pb6a3/lRqo/5aUGCaiNbZ3ReDHqNsQ4THS2MYh+3 /cP6eGeecsAAAA=
X-Change-Id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=1927;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=BmydyRyqabJ0xq1KtEZLfqJqBfIHdz1QSKABi+pLLAI=; b=aQ8VY631+PZ+8I90X2r+jykIUJ42Q/O5yclWaB3EPJYnhT9dbJJbqum/jUJQCww5qrZd1UDmT
 KWwnaZyjzf1Cp4Ox8aHXsiwWhudY/IUqGTsKjYbYdn1AS3GCUvptlH1
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Subject: [PATCH v5 0/5] mm: Fix MF_DELAYED handling on memory failure
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here's a fifth revision to fix MF_DELAYED handling on memory failure.

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

Changes from v4:
+ Add "fallthrough;" in the memory-failure test, as suggested by David
+ Add Fixes tags in the commit message, as suggested by Miaohe
+ Rebase to the branch "mm-stable"
+ Split the KVM selftests to the future series

Thanks for review from Ackerley, Andrew, David and Miaohe!

+ RFC v4: https://lore.kernel.org/all/20260602-memory-failure-mf-delayed-fi=
x-v4-0-a5bc7db5a9b2@google.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Lisa Wang (5):
      mm: memory_failure: Clarify the MF_DELAYED definition
      mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
      mm: shmem: Update shmem handler to the MF_DELAYED definition
      mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED =
cases
      mm: selftests: Add shmem into memory failure test

 mm/memory-failure.c                         |  29 ++++---
 mm/shmem.c                                  |   2 +-
 tools/testing/selftests/mm/memory-failure.c | 118 ++++++++++++++++++++++++=
+++-
 3 files changed, 130 insertions(+), 19 deletions(-)
---
base-commit: 08745c62350126bc31b09548137be87e2866f628
change-id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b

Best regards,
--=20
Lisa Wang <wyihan@google.com>

