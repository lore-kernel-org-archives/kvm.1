Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DF360EF8
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470514; cv=none; b=nAeWiMugFiSKXmKzkTS4Fv1OMHTePwfwdoCZyT4cSk13wxD8B7iuyeWhLHba+FH0yyv1iXr/DILO67Sf81qGg7zg++iTrESXytpBqG0UVrsGisJQu6VxuRfu8DSi0c8v+g/aYucG+PFvtLygMm/j+3HnmH8D/6dm0clYzw3vEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470514; c=relaxed/simple;
	bh=nbM6CKBEq8mnqDVydCu94646WNYZnpPRKzWAFfsq49c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YEJJBqpx0VPg8uZbbgfagDRt1H8KrFe94NDjaYz9KU9SWy9quOVg31yBfoRyRmEAdAiYggb0Hd5XHx90ZB7R4TNN+FUUIwOpSMpH7x8pZTlILsKA83fFh4X/wSXhtwvWB5HTTmh1ThAfQim1jM13YAbGVyLtPu3ZVZXMNngvbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/fLCODp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/fLCODp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f7e7f7457so4414601b3a.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470513; x=1780075313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e6249WJI2MWSmRABK+hoCbw3HSBwCqH8h0PO+qNvxs=;
        b=O/fLCODpZ4iyoyKmY9yAryi/NnQ1puvJ/HhNBUCyGN15k7OP2mgMIlEU3swNfbAsKO
         U3MF7WxR/Rjr4WraP1aceIeC+sNU322bFw8Appn47u4ve087SFB3Ht0ogkh/Nz0Jftr2
         3gx3DMb9pn9x7/keLZYmfRfde90gWUgr8zbimHH1QDH+clJjWjScAAKnTazLtjl3Q4c8
         5H+cz2lVC7pg2tWmSD+6Z23pfQ/EwtLMHYLOaDob3FlacdTP3OGJMbO+gfX2xsho4VMe
         0HH5Fct3MpBQ75gqnfu56S4mMsYrgJsshxvqxeNUi+mTJ+xnLNO6xVT+wUsYdP/zLWXc
         9Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470513; x=1780075313;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e6249WJI2MWSmRABK+hoCbw3HSBwCqH8h0PO+qNvxs=;
        b=TZKdCq8UVWV0m6Wpu6UF3ZHpjEDh1kZGDnHsErXgTvSc7Tuwes7mm6FPSV0/uq9sQ4
         iVJ5mb6VMt6AEycTGQLCC2LwrYj2lYl41qpr+/UmuLdVv0Qsmz3iqQGGWVA3r2rYTb7F
         6wYZoyHYqBYSE0yApw/4gF28/dWwu8+wjkCb8VlF4SwuZjItsL4DtCRdyAWEyg/+4snq
         0SYO6xqty7brI3el4GLxOsjKYfv+iWQua0TgwnfgCSqhL3UD4CzosLgmDqBMkltmRtF1
         SikRxf9ZCK/A1VHAw2h5rthQNC/YJ/CGBcKvWAYxJQ9tCUC2/D/rPtJvor8mm+MdfdRf
         xYGg==
X-Gm-Message-State: AOJu0Ywk+V1R7We2Owo/sDhFQmt4SoWjZtpfh8PlHPATmieINOKZT6ki
	Mo/4oKewG/lOl8sKXgmnVzkoNYAhe1+aQYKy20cCKfa39vVDEpBrjqVfV46zf2RGCJHa06nsDUg
	Mu/5ZjQ==
X-Received: from pfmu16.prod.google.com ([2002:aa7:8390:0:b0:82f:5d4f:734f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2388:b0:82f:9a88:9092
 with SMTP id d2e1a72fcca58-8414b5d1e03mr6517651b3a.33.1779470512322; Fri, 22
 May 2026 10:21:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:21:48 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522172151.3530267-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: Fix guest_memfd binding overlap errno and selftest
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a goof where KVM rejects guest_memfd bindings that overlap an existing
binding with EINVAL instead of the intended EEXIST, and then add that specific
scenario to testcase that's supposed to verify overlap checks.

v2:
 - Collect Ackerley's reviews.
 - Keep the GPA overlap testcases (because why not). [Sean]
 - Add a patch to remove superfluous %s formatting. [Ackerley]

v1: https://lore.kernel.org/all/20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com

Sean Christopherson (1):
  KVM: selftests: Remove unnecessary "%s" formatting of a constant
    string

Zongyao Chen (2):
  KVM: guest_memfd: Return -EEXIST for overlapping bindings
  KVM: selftests: Test guest_memfd binding overlap without GPA overlap

 .../selftests/kvm/set_memory_region_test.c    | 31 ++++++++++++++++---
 virt/kvm/guest_memfd.c                        |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)


base-commit: b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887
-- 
2.54.0.794.g4f17f83d09-goog

