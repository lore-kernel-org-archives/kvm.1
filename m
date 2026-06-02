Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF13A6B6F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437366; cv=none; b=pgt+ueYLhgYRI2UsZC+9QsQYRv5RsEvREmHk/rguMFptEJmt3K0u5CDBGF1lqNLaDjE6QLHMsQtpXD27R+3qGOlf2GCSJ41jIKwLZpjjd3p/yVCKP6LLd29Kqku1I37x14GOxdesu4AeBfEu6OLjlxHGmqPHUUwAW54YGNfDn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437366; c=relaxed/simple;
	bh=hNGRPXZPv9VsFGCFlzGsilsBaOfx9YAE5+5vnJAC+ps=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FcSGlH5MPvqsaMbPYCu7z2AcvaYsZUTp9mOK20+vV2+Fit0TYd7ZqyMKiiOVs5wLWiisxyMM19IMSMxbSaToh75iawlP7BSGTreUV+OIlnhPe92xaHyTsEw+p1eTYwNOSM6877wcK9lu2Sz43vKTBTD0ojfYhelCRxDXGj9vSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7X6SGo2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7X6SGo2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c32faa62so53873685ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437364; x=1781042164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7tMKLqZLoUguahKVkzXwJunwH2CC8Y+lNvapE/6WPM=;
        b=s7X6SGo2eyAveVu+TUdTSMp8gBuV+ImpQGVebhJRxmab11A4TNO6Nndo3540M4AtwZ
         UbnZ0AVnF5gL2K3nPb+moFKsNIbptYBsfbZ4GGiVtmcY4qnOJgHHujeKXX17V4YKTu0U
         fZBsg6ZBhTpIjv8PowTdFBDvnI3nbREtKDTWqksFiCVH6YtModnKW3aeGhF1oyW+cYPS
         iT9YDCULFyoxVaXGW2z26pURPRIHuTT76hu3nDSz5PTCHc9qjYcYNejdVUkwge/rXZMV
         q/TdwEAB2QNZUTLSEuDiu6SmQGMgTq0R2OneZAwR1Rt00eoEnvEGo7gKgHxBDV4GgEsM
         w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437364; x=1781042164;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7tMKLqZLoUguahKVkzXwJunwH2CC8Y+lNvapE/6WPM=;
        b=J5F8366xIY9Lf/vgWh65aJvC+h0BKnhLcr0m5w1SXxn94/vENxuYTDZSUW8n6HALjG
         dTaE8RidQPsuYWeO0R97Un7dXmzTgmzOMilK+TwdfRMBDdsKledL214W1Be8jD/cAKaz
         KQE8raVHnIc5+mf/HkZHdEMfqZs4ZWifZUnxjuqvqa83c8V0h+LE1Tw/hQV2MxW1VfA0
         XTHBPXBxtN9gZV5xizmdft5OLYTkKbAQnF7BD2R94TLC8lvH86LzGrYDFZGZ7uP+/K5G
         HLLl0jcbZPrCjUEGgi4AcfOVLz2GbJ8a9oRuZrSyOUsxJ2iwNVucbnWBQzXhvD5nCqLX
         s6+w==
X-Forwarded-Encrypted: i=1; AFNElJ+GOLrCV7sd5w/+3SUT3vlLYhFC5YjztEI+TDYDLzByTddBS4yq78l6n+MyqGUR9/k6GrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFLhdLSN8YpCs2sXmQpGHQhwwLEy4MzJTFFWWh7RjdY+fKoCW
	1VT72+zv5hGe/hwcGVi2taBGE7IR3p6YzZg6dItjC6KK0D+aQayqsGx67vVl7i7pOEZenyUrKFR
	gAE2/Hw==
X-Received: from plbbh1.prod.google.com ([2002:a17:902:a981:b0:2bd:bfca:529b])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c948:b0:2b2:4d36:7aa
 with SMTP id d9443c01a7336-2c1644cab59mr5323895ad.35.1780437364217; Tue, 02
 Jun 2026 14:56:04 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:40 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFxRH2oC/x3MQQqDMBBG4avIrDsgQWvwKuJiav60A0ZlQqUi3
 t3Q5fcW76QMU2Tqq5MMu2Zdl4LmUdH0keUN1lBMrnbPunUdJ6TVDo6i89fAKXLALAcCR/1xF1r xsREv/kXlsRlK/v+H8bpu5AUH/28AAAA=
X-Change-Id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=2245;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=fRnbbxlBDk4YfThNS9s3/pmtvrbRvFIdtObDaBTv/hU=; b=D5bk2bmUWWudEj1T7hfEsakTn+vs93FjxKXokW9ffFkWPkCyo4/U4PI0D+/WRcNzSfFoIDCq0
 DrI7ZczMCBoD8NfOhTuMdcBZJb+mUexkYE+ixEiHfOjRm1AvyTZ5eaw
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 0/7] mm: Fix MF_DELAYED handling on memory failure
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

Here's a fourth revision to fix MF_DELAYED handling on memory failure.

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

Changes from v3:
+ Split an independent guest_memfd_memory_failure_test, as suggested by
  Ackerley and Sean
+ Align error logging style in truncate_error_folio, as suggested by
  Miaohe and David
+ Verify a clean shmem page can be read successfully after soft-offline
  memory failure, as suggested by Miaohe
Thanks!

+ RFC v3: https://lore.kernel.org/all/20260408-memory-failure-mf-delayed-fi=
x-rfc-v3-v3-0-718f45eb7c75@google.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Lisa Wang (7):
      mm: memory_failure: Clarify the MF_DELAYED definition
      mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
      mm: shmem: Update shmem handler to the MF_DELAYED definition
      mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED =
cases
      mm: selftests: Add shmem into memory failure test
      KVM: selftests: Add the guest_memfd memory failure test
      KVM: selftests: Test guest_memfd behavior with respect to stage 2 pag=
e tables

 mm/memory-failure.c                                |  29 +-
 mm/shmem.c                                         |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../kvm/guest_memfd_memory_failure_test.c          | 402 +++++++++++++++++=
++++
 tools/testing/selftests/mm/memory-failure.c        | 111 +++++-
 5 files changed, 527 insertions(+), 19 deletions(-)
---
base-commit: 38741a8e3bc1b809d64f8c8885ab15c3e40700ff
change-id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b

Best regards,
--=20
Lisa Wang <wyihan@google.com>

