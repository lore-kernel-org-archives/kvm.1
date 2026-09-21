Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB64E2F25
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024781; cv=none; b=QDuseImNUu3AVWeT6SNrjHDlsOKRF2FOgb5OR5uit72dy2D60p7etd84hoqsKhWcQu90Bf1tOcYWa5ACP03Q1CqjJaSktvFWTZc2oa9mbwwcOm4+jpoIrZ8BjA8HqfqxrZxRHwKIPNi3UHDlzH5svRCnPtDQiKindKM/yxvr8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024781; c=relaxed/simple;
	bh=EsP/vKlSxJA0fJFCSs6j+lGsFsd6oJ5jn9r6xdttnwI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k5N0sbOK6w716/eSpxLmWTG182OSsH1JzGu/IQ/j2qMa7TYJOnQ5L1jg/oBtBd7f5Tia2hubjVW42Tin0NeMlY+QpSr9rIE35gSZj25y50R/g8FhVIcTTZwkdkEMIDkO475uJaiJ+lTMCXByEDSApM3LO3okxDMTTvquPVq9fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fo7AjzpB; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fo7AjzpB"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8696b921ac0so5260405b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790024779; x=1790629579; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfJqSQNg8bmCVfzuPOvk2+p5qJGaADimVhWmTWvwWUI=;
        b=fo7AjzpBT2Pl/yR3L/E/AKmTtTFnIk67VGFd8J77RgFfKstq03xjxlLB7IL5yXlCPV
         K47o8gl0sOKm15STPcbqJb0j+WHrEtEkozW5N9s94XHrRCMIfD8lwzS1qE+TkAv7FzA3
         kYFTb4tjO0DPxs54ckk94SzFzrdQ4lPHo4lzw75hqCH4DpcPravI41cKZFN6HV9V3fDv
         FSsHl/emQkQd6V1txtDcUmEr4UtXsDcsiqepny2xKINqikGi/GTbcLgNNnJrPrq0VeCT
         N2EDAAscNPr8BiWVAw2dkntsf1dIYzWJchgwKfadx6Cr+d5zX96X90fLObMIMWjQhdCL
         rzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024779; x=1790629579;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lfJqSQNg8bmCVfzuPOvk2+p5qJGaADimVhWmTWvwWUI=;
        b=s88VmJu8eIPQeaQEBedrko7UgThLcVwwQ9YF3JZLzFhqx1l33sihXn0wFpaZWrKVUZ
         qtxj3Zy887MW9GSOjZcwJsgvLOCv/iUk6IzXrRq1emYr4vijGser55oeptHCtCQ+Z+D5
         QhN6WUhVP0MojFRbGhANp6d+GxClt0FBMBgFyFiIt0hZ2qmo1mreVoywWuY4nBInHmMP
         1GXshptahanubRvaLt9BRgIuWr2Aj8RuryKpRSSsUyTKTFnXa+0Ncjd4uf4FJCox13QM
         Dt37YVtjdFY3uEatvr1Bn+RgyK4cMzFqhi86txceqlpNdTRQ89/tkXVR4/zWjAt9HmFN
         Fq9g==
X-Forwarded-Encrypted: i=1; AKwUvBzQzxAs4wMZniXUSa82eHw0j0KFrXkTQrIEbzB4qa7kXQ/AfIzLNAvI9vVpqDGdRqXyfgY=@vger.kernel.org
X-Gm-Message-State: AFuF++krJzO+HH/hkmYBtimEUGPs+cbdUsjrpf2qFCGC901wLRiPcZAX
	NuJEFf1sG6tSpgWfKkZdxVdHO7Qnsw0hyIWIvDNwjv1iCf50hC41CMWxdJsI79fLbLABtdx81zG
	bpPhxlg==
X-Received: from pfcy13.prod.google.com ([2002:a05:6a00:93cd:b0:87b:bcd7:4df9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1496:b0:879:ffd9:1278
 with SMTP id d2e1a72fcca58-87bffba3391mr175404b3a.9.1790024779078; Mon, 21
 Sep 2026 14:06:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:06:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921210616.1024168-1-seanjc@google.com>
Subject: [PATCH v4 0/5] KVM: guest_memfd: Fix binding bugs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix guest_memfd bugs related to binding to a memslot:

 - Handle errors when inserting into guest_memfd's binding xarray, e.g. to
   do the right thing on ENOMEM.

 - Bind a memslot only once the memslot is fully prepared (because it becomes
   reachable/visible once its inserted into gmem's bindings arraxy).

Patch 5 is a related cleanup to remove a superflous WRITE_ONCE() (unwinding
the slot update on insertion failure isn't an option if the slot is observable,
i.e. if the WRITE_ONCE() is actually necessary).

v4:
 - Drop intermediate xar variable. [David, Ackerley]
 - Collect reviews. [David, Ackerley]
 - Restrict kvm_gmem_bind() to CREATE as calling kvm_arch_free_memslot() on
   FLAGS_ONLY changes is unsafe, and doing the right thing for dirty bitmaps
   is tricky for similar reasons.  As a bonus, this eliminates the ugly
   almost-duplicate code that David pointed out.
 - Explain why KVM must deal with the unwind during bind(). [Ackerley]

v3:
 - https://lore.kernel.org/all/20260904004342.3162959-1-seanjc@google.com
 - Nullify bindings on error before dropping invalidat lock. [Sashiko x3]
 
v2:
 - https://lore.kernel.org/all/20260902182020.2615443-1-seanjc@google.com
 - Fix the binding-too-early bug. [Sashiko]
 - Explicitly zero the bindings entry on failure to ensure there are no
   partial entries. [Sashiko]

v1: https://lore.kernel.org/all/20260826165154.766699-2-seanjc@google.com

Sean Christopherson (5):
  KVM: guest_memfd: Gracefully handle xarray errors when binding a
    memslot
  KVM: Use goto to handle errors during memslot preparation
  KVM: Only bind memslot to guest_memfd instance for CREATE operations
  KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after*
    memslot is ready
  KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot

 virt/kvm/guest_memfd.c | 14 ++++++++--
 virt/kvm/kvm_main.c    | 62 ++++++++++++++++++++++--------------------
 2 files changed, 44 insertions(+), 32 deletions(-)


base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.55.0.1082.g2b9226bbc0-goog

