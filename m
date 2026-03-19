Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849540245A
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963056; cv=none; b=nDH/bdDwvLl9i7dYSm1o71+v7cvXQIEy8fP6uQqyYsRkqmSz1tzXKnUs6+U4S4d4Y07uOrVQSAuZ/vWmzZY8jrSZJVc8nXUCBk52X2VSDKtBca3+GIvoVEhbwhIZcaZ8YDmmJJKJrc07ABLOz2TzbNoEO4OZvLAz/ecXfYG6gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963056; c=relaxed/simple;
	bh=CZuA2q2lMteTu44UK74Tv+Gl9XkYvploUKv+Q7AJ1Us=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ok2uDJKk4XZXewspo8nBZD325WVsut5pZ6PJXf2bOORZ5v2R2kxQRe0nL0HbFlbw0yfHnFzaD8F2yNaSj99Jtm7NPkgSXcidWBiDMZ4BVeoLo5aK7Qpxo3Yi9LQ+SpybEDlRbUHDenBF+VTXgATMnOXrr31Cqh2igB19GPfgOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXoUcC8I; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXoUcC8I"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b9333cbfbso7462769a91.2
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963055; x=1774567855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCIxwFZ47k6gWbx57q3bhruGtmGGBP4Tv/5VwuBdu0A=;
        b=fXoUcC8I/hiFAgr6fSop0cQgjdk7Rey95UBBUww3AiT25mdU38z/k52uDG/LLKJVQ6
         l6hFwDM6Ieyb13cuYlSkRO6hrkvzO4d6EDgta3ANhPAVlid6BUMHkZslQwBt80Xfb0UR
         lf6YNkVTtNlk8Ortasz1eKqZwpgNxAe76BYjwqskyyTSV88M+K8AcQsB2UAdhUv7Uopc
         bxyu1DJcyygIoEojg00JdDhepp4nba8hGoLJBHVKKCd0C+8ilItpRSCiy3CV61PeUhhN
         CvqWAhJUKlv0oiG2TKsUb2K9lK2ktg79oAbFWcENI1152824k/FXR5eCfLf7tlW7yPgP
         +7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963055; x=1774567855;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCIxwFZ47k6gWbx57q3bhruGtmGGBP4Tv/5VwuBdu0A=;
        b=P2E0/kpI3++OwFN3U6+YfbHvT05APMFSsxA6wpl2eZgspLXtPDiGUBA5it2ZK/3i57
         ps6U9cB13THFYrTAe4HzXyUg5HRUzXn2cqz+RhE2reRHzrtCXJMMg6lR4+AVnL/EQq3I
         6N1AigiUwm9JsOXBMl+KX3EO/DxuHpco8chnyA0wkKpvtyvZF5jWeKC7P+0HRtE/QeXD
         h+QjRPmULP1pCjoJDEfTmLGpulYicERiizkl44F/B0CGMOXykwDZp2bcCQidO8P3GT9u
         lIovBoDtrIADjTuAIf+xGbNfV1e/r/ZvlqLn3Dfd8mTKvrhO2QX2xtj7qV1qGJ5ViMv+
         WtJA==
X-Forwarded-Encrypted: i=1; AJvYcCW4bXV9D52PkUCLgXN1aSXNu7dagRmdo3TLHI0ziJ4bcb4Euxcn/HvbHoJR4DtQtOXhJiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacItRvuUqY0xP3zbehXOlDOnPeF8/dFr5JGuIHFHRbkh5xcg0
	ExrWnrFruEVNbMDCzLCpL8RJiZIIPJxWKvajFhuz4VjLB+3V2OANbGsiU/yNGAePhTH7F/CV7XU
	Z7x/3bw==
X-Received: from pgww9-n1.prod.google.com ([2002:a05:6a02:2c89:10b0:c74:42:8993])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d05:b0:398:a6d4:dbf7
 with SMTP id adf61e73a8af0-39bcec2990dmr884293637.55.1773963054511; Thu, 19
 Mar 2026 16:30:54 -0700 (PDT)
Date: Thu, 19 Mar 2026 23:30:27 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABOHvGkC/x2NQQqDMBBFryKz7oBJqaXdCj1At6WLYH50wKhMq
 FTEu3fo8vF5/+1UoIJC92onxSpF5snAnyrqhjD1YInG5Gvf1Gd344w868YpyPhRcE4cMYYNkZN 8WVPHq+cL4FxswtUksqtFYes/86Lno6X3cfwAHAkyQXsAAAA=
X-Change-Id: 20260319-memory-failure-mf-delayed-fix-rfc-v2-5ee11d6a7260
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773963053; l=2186;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=mpcY4kRf+nPP5p5eWgT3Y1evjSbcjRoF+f54tj5v7pY=; b=mWnFvQ5ui3ggdbSI/gbCZaSWpVcU5hlhGvSATXtAyXZwDfjEUhF4BWK5E7B5/5PQNCDI5xSiU
 xIX5xLfd+SSA0zwnDrFuPU+talg1mimDxNRWM7dNEzT6Wnry6w6Sa0M
X-Mailer: b4 0.14.3
Message-ID: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
Subject: [PATCH RFC v2 0/7] mm: Fix MF_DELAYED handling on memory failure
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

Here's a second revision to fix MF_DELAYED handling on memory failure.

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

RFC v2 is a more complete solution that includes parts 1 and 2 above to
address David=E2=80=99s comment [1]. Selftests are included for all the abo=
ve.

+ RFC v1: https://lore.kernel.org/all/cover.1760551864.git.wyihan@google.co=
m/

[1]: https://lore.kernel.org/all/91dbea57-d5b0-49b7-8920-3a2d252c46b0@redha=
t.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Lisa Wang (7):
      mm: memory_failure: Clarify the MF_DELAYED definition
      mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
      mm: shmem: Update shmem handler to the MF_DELAYED definition
      mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED =
cases
      mm: selftests: Add shmem memory failure test
      KVM: selftests: Add memory failure tests in guest_memfd_test
      KVM: selftests: Test guest_memfd behavior with respect to stage 2 pag=
e tables

 mm/memory-failure.c                                |  17 +-
 mm/shmem.c                                         |   2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     | 233 +++++++++++++++++=
++++
 tools/testing/selftests/mm/Makefile                |   3 +
 tools/testing/selftests/mm/run_vmtests.sh          |   1 +
 .../selftests/mm/shmem_memory_failure_test.c       |  98 +++++++++
 6 files changed, 344 insertions(+), 10 deletions(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260319-memory-failure-mf-delayed-fix-rfc-v2-5ee11d6a7260

Best regards,
--=20
Lisa Wang <wyihan@google.com>

