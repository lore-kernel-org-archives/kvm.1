Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26F4334CD
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677912; cv=none; b=hrt3JQPQ5uWGkiG2O6YudVX8d2e1ZN1IoX3SXjmolW7f4DOXEiQgk+Qtok2hnPLeCXZSq/BX/E8/pT64m7s5Dd3LQ1Wm9TfAnCYSbK812DNzzaOEkH5thZIODvQxDCjmlqnbT9QhJYTu9qO4R5eOizgvWTYNdmRGAb78r/0b0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677912; c=relaxed/simple;
	bh=72Va4xv8Ms2h78XcKuZg9RHaTyup/YG0a/Xfii40hfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V5p6mj0C/eaPpbQqpHNrb3bcSqRsOF+XUjwDwZwqsnohaJIs+D7n3+8gMHq1pBT4r9M1yfU1QTZS/l80gUCzzvnvkH+ZiJK10alXYpPo6nrVR42O1PDumUmoR+9mpWQw0ElzaZnd4cv5iDG7XSAAgfuEAyuV22C769N+j6dwMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwkQfPml; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwkQfPml"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso135883a91.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789677907; x=1790282707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jMNh0+jAAa1Kr4+QO+vi3xyA58GWdIBX9d8ih4uK1uA=;
        b=dwkQfPmlWkd/T7A/vKfGTLqfrem8YCSe9PCv6MjwH1nCQpfG6Te0q5gue5iOtvCWEm
         4LhVuxiFZWYl0hCKTZbEHTjh6eqCLMw9C9ePeob8K1fjbbpwxs4+wRsGe9T6fpEHGDUp
         sZrs/hoXUecziJQp/Kk8NV5T+slzkIq7+Wigx10FBAxIL4ZgYK/iIVeqv53F04OyDVPg
         G/6TSrMMShgyj/jJE1CQqvdU0cENHYmcsbFlR80nCPFWnTwOMV8n1hB3nDqhXOPvaADJ
         69KjYxqcPJAnUI5jwpw1WfqH0ypKIUV26gGKuZOo3dL6VU243FH1V/yGB7qrRZMqp+hL
         Vbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677907; x=1790282707;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMNh0+jAAa1Kr4+QO+vi3xyA58GWdIBX9d8ih4uK1uA=;
        b=BuBD4hL0+MRlu4p4ey6IAL3nmxgIETYY4xEWrw6zPiKh7elqiWwrKDwiExaVC7Rmvo
         l3RKtBE1oegcNGYsJPnl0lre3mcGIDqIby3kxmt04F0IFVUU8atPjAKF2z3zCd1xh9Co
         IFLqooR560BX9rP6UZ8huYG6AiceKndw417bwAkF4UFvB9QYUY3XqQDDOav3Hjl6q2dX
         lGiNwOAuquYhldu9YYlFjCerh78fKZZlqzvWVvxQtLXZf3O7t/eAnyx/tdzZg61HWQXE
         +NPvdOEpdPw2CuRDYykYTuS781qK43C2R8R7dGsJdwfBvy4linMdFpvn3ySS4txl5hPf
         l6Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwcbr7/VmAUxmRIqh7JRkcpBz59agjCSvilLX+2pxwtGpB2nONZnipZPbPb6EBFHgVJjJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++md0Zo5+WMCDQA4ZSqzb7GB/Vx+TCxit+E43ns4YX3Q+eXpyUmB
	aN2LH8CHUzMHGCS6xAYdRAzsluGx1oTWWQVuJo54ybQRywXE5XjdxfzVBXPhy0q0VEinwOABBT6
	05fPkuA==
X-Received: from pje10.prod.google.com ([2002:a17:90b:550a:b0:39b:a3c6:1ea1])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280a:b0:39e:2530:2102
 with SMTP id 98e67ed59e1d1-39e54f4221amr1221121a91.11.1789677907330; Thu, 17
 Sep 2026 13:45:07 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:43:46 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAJRrGoC/4XNQQ6CMBCF4auQrh3TFErBlfcwLqZ0Ck2AmlaJh
 HB3Cy6MK5b/S+abhUUKjiK7ZAsLNLno/JiiPGWs6XBsCZxJzQQXJZdCwUCDDzNYdP0rEAwWDPU
 4kwHr3qCMxMoWWGGlWTIegdK8+7d76s7FZzrf303Ftn7lkosDeSqAA0rdKKMl1lpcW+/bns6NH 9hGT/LHVSI/4mTiTK1QKp5TIfGPW9f1Ax+ywPUaAQAA
X-Change-Id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789677906; l=1740;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=Am2jKIW9EJEt0JmvNafH4y2xjpYHkskddR3CBeqh7Zw=; b=/wh3h4RwP/TLeQrHX1ATtrr76sHTMiPuM2R+SJAOB0ZNs9zkKo19zhJPXOol9dk/vZK8KxzTh
 kMzeBBM0ciYCOfVQNYSBsGFmVAddo2DxqCG+W/jupYzZWJ8KL9ooBKj
X-Mailer: b4 0.14.3
Message-ID: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
Subject: [PATCH v6 0/5] mm: Fix MF_DELAYED handling on memory failure
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

Here's a sixth revision to fix MF_DELAYED handling on memory failure.

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

Changes from v5:
Add comment-style fallthrough in the memory-failure test, as suggested
by Ackerley and David

+ RFC v5: https://lore.kernel.org/all/20260823-memory-failure-mf-delayed-fi=
x-v5-0-d97a5703e45a@google.com/

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
 tools/testing/selftests/mm/memory-failure.c | 114 ++++++++++++++++++++++++=
+++-
 3 files changed, 126 insertions(+), 19 deletions(-)
---
base-commit: 08745c62350126bc31b09548137be87e2866f628
change-id: 20260527-memory-failure-mf-delayed-fix-7d5a8f4a8a8b

Best regards,
--=20
Lisa Wang <wyihan@google.com>

