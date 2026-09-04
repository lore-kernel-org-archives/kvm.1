Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3A154458
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482626; cv=none; b=SG9ItNfQAGr+PYWuq0AQhDlT+koh3qwz1cYrq0GNGHpxJVJTSaEiA+ZDAYdHYHIiD7h5zzAMS9H1EHW6I9ECbkhZ/KSIG65WFHIKJhIxhk9uJvVaCwd7H3i/AyHbTOeOFnv8UOVdfTqNwGSgEk/FlMQTZQF/Se9/OYsPbO4Z+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482626; c=relaxed/simple;
	bh=8/JEgb3B/TL3V8OewSe/wwSXjq2UPQdOg0TNf20F7gE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yvy0+89nGPZ9AnQYY+AK4Lart+mbfkd2yepEzWkMgQurW1ILsejN9P+ysD8LCuJD8gNKwV6PG54tIgzWuez788E2I531nTeBAAoFHwmjJFFWn7jsFt4EJuZj2YX6kLMs/92kJv9wU1NXhSxoLX0R0PXz10HVnSIYQfw0vicZmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2Os4qMI; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2Os4qMI"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fed0652bso5578825ad.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482624; x=1789087424; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2m662wt8MEAc2qb2QEwRZ+IUuei/mCWqslLJbBYS/6I=;
        b=u2Os4qMIYte/GMae6y9U7BBMDf2qInrrMFsji/Zwuz4ymDp7Jn2hw3A5G6cyiBF/3Q
         5c/Vl0OAr3MdAU84w7oKSQJHwVMbYRBaAsgVTbhHUkX9FBQZGv5Da7W9T2vLIhTw7L4F
         aC0ejEe8LIqhlPKlcSGh8M7EY0RtqmgCFYxk9c9EJOnZqPapXwWI8rtPRJn2s+DW1epa
         8Z+x54CljhMABk5veAIlRjyCi7KI9uG5WRd9InfjSfkGC5OF6blGYa7o1M1QGb8C1J+z
         ZX/rhRLBWuglfg2UKU8ltxeELV/VyLL2Rxiksd6/OIR9YPHS8TBQsRIdGVTu5oAmDurF
         VHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482624; x=1789087424;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2m662wt8MEAc2qb2QEwRZ+IUuei/mCWqslLJbBYS/6I=;
        b=Rh2sgr9TgVN/E9zp0mDZi2s4zanHotkpdrUmqbQdyo47pUKn4ezSP1pOHBK0s4XXnv
         PPUYCbV3qmOpUbmJKrMYXvB7NMMt/qxdkd5PmwfSbTZmhCKiCxqI7w8tOzVyWu3/DNvj
         0vgcCHD6cR6JqBNWCUU5mYYOphNcE2bhrq4NmWnCZ631dFeXSclIOIFNPcJRf9mrFOcL
         ojZTEOIDPjAdOfs9KZ5270JKhOvgjLaB4YUD1qNTfnpGufgLWSAfG11efgtzdbVMRP9e
         2cRj21QlChTqyXWccJuMb94cMYjlFeDZdCNbRSkN1Hb3KA63V99leraKwQgbyOiKU/a1
         9Ruw==
X-Forwarded-Encrypted: i=1; AKwUvBw32kQsyLSyp3T+pV+K+zthAlZXKktC2D29ARYqmpggCw8YBWRHxiPGXM35GRcOGUrcoNM=@vger.kernel.org
X-Gm-Message-State: AFuF++kKsC0tCIwyekN3QRCQQl5Oh1hC/LE2t8UkEVcNjQ9VBb6cqq/W
	dLRMkAtusBJn0NUSSC1O/44F/9XJ3FA5ektXiKfzX91jD/5DsMFH6MmzhHROMxaBh9Pw3iF0wzG
	Y0kOSIA==
X-Received: from pldu17.prod.google.com ([2002:a17:903:1091:b0:2ca:cefb:826e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c8:b0:2d7:5ebe:a588
 with SMTP id d9443c01a7336-2db126d6e31mr36430305ad.13.1788482623926; Thu, 03
 Sep 2026 17:43:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:43:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904004342.3162959-1-seanjc@google.com>
Subject: [PATCH v3 0/4] KVM: guest_memfd: Fix binding bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix guest_memfd bugs related to binding to a memslot:

 - Handle errors when inserting into guest_memfd's binding xarray, e.g. to
   do the right thing on ENOMEM.

 - Bind a memslot only once the memslot is fully prepared (because it becomes
   reachable/visible once its inserted into gmem's bindings arraxy).

Patch 4 is a related cleanup to remove a superflous WRITE_ONCE() (unwinding
the slot update on insertion failure isn't an option if the slot is observable,
i.e. if the WRITE_ONCE() is actually necessary).

v3:
 - Nullify bindings on error before dropping invalidat lock. [Sashiko x3]
 
v2:
 - https://lore.kernel.org/all/20260902182020.2615443-1-seanjc@google.com
 - Fix the binding-too-early bug. [Sashiko]
 - Explicitly zero the bindings entry on failure to ensure there are no
   partial entries. [Sashiko]

v1: https://lore.kernel.org/all/20260826165154.766699-2-seanjc@google.com

Sean Christopherson (4):
  KVM: guest_memfd: Gracefully handle xarray errors when binding a
    memslot
  KVM: Use goto to handle errors during memslot preparation
  KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after*
    memslot is ready
  KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot

 virt/kvm/guest_memfd.c | 17 ++++++++++--
 virt/kvm/kvm_main.c    | 63 +++++++++++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 29 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.979.g7e5102b832-goog

