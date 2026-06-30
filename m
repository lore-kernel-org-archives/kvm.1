Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134131DED5C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855436; cv=none; b=QsChBUM2q+H3JnAc7FxQ7VS+YH608l4P49OYuDfyFO9HisqsnwLBlfWS1RK1/rpWj9SmLR5MjGkLs/CX2mrrMxTFyQNKZj6SkRiTAxzrjciajFgmXnmv6NDJmcXABz3b8qWYTZlReRq1kjbyPzuCgmi2fbviAGwJ2dTJvzsHdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855436; c=relaxed/simple;
	bh=nIZGKje8UwhYBZ9kwvCNQ5q2oYFunQ9OO5lUc8brH/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a8jiZMxIPyhcFAtf5/Y0FaEhRMNmpCUy3/plsr949HXAqc1slRkOiqIyJcYUlCuW+fLoX5BDxk6wa6UcieJrHHO1OEDGGMugEEiVIQYj73W4KFAcowBshDlGExuLT7BQoA3UV8J2Ko78dy2dRKWzbo6bEdmEpNcm58uM3STfm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMV3KarD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMV3KarD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c9127e316so12660a91.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782855433; x=1783460233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJUsAy2mnvXDwvwqEHFWU0D1eamvTWzS2kE4hxz8/r0=;
        b=XMV3KarDoCP5yCN41NoQuMrTbsA6nmwynIBEjXBrLdOZ7PFfG0MXw/CUFPH4fZN/um
         KP5VAyIktkRrnsZI4aEToXdY93fd8Tcol9SP23+i9dR7jahr58CI1H5S+7LUhTecyOS2
         dhWemlW901Mm4vJtkUw0jv25Y2QDHDD0d0RqwOw7zOfrwpQUidueb6vWQ+eRmVrNm+3W
         0kI8jJ6lVVhwfNTU4/pFzcQJCIeW2tGJ715TabyMTEEJsdrl+0cHS81g9bu9UFjxPi1/
         2sA3hKhLf4Ry9pNx2Q+dzEDJ415jMy4QwBIMbwO1rRrhMuIilSRil+C+AMfHXKBCyacU
         0NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855433; x=1783460233;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJUsAy2mnvXDwvwqEHFWU0D1eamvTWzS2kE4hxz8/r0=;
        b=XOOa/D3/0GruFclKXgLrVfrUbwF+wQGMsEGavIQ5v10RyAfU3sB5QHbWKV362QbrHT
         kPDQzLnq11G0cissXlTtd2gxjKrWUBj6QUKKiKt6ROSDraHnEqW1Pi1duqnNH++qJbpm
         uYZaorFQ/a7yiPsOq9wk4e4enCFQchEn3oGEkeMOxnpXawoKU48CJPC1gHKBVoVpp8Z4
         SFtJMTvVavoOj0PuDZ8G36qx1PYKSbc60lvNMqMfbENlpuiEXivqjguW+0VU5nWRA9XP
         IsNMNDkBHVYGwg3/7LEMssKkmyFBJYH7J5tL+/Ioc1BZP19cDlCpdF5TXL+dPDlY3kr3
         ddwg==
X-Forwarded-Encrypted: i=1; AHgh+RocYX6SYvm6GhT8ibWYX7b9yzC/wuMKRNklMe3dXbojzpmS3KtgGM9OYKR38qkuVwe5/fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUygsfwTdsMhZIkGNG1zIbv1ouYg/HJavM+DsiXl6rZUDPBI/F
	7PrMd1SUswzLebnEpew2ph9d3Pf4XZUQ9nt2f6fEeyzXgpluhtJyLl0qIpt+7TbZfRIuhAWDwtc
	2E0/24w==
X-Received: from pjvc8.prod.google.com ([2002:a17:90a:d908:b0:380:64e0:790e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:36d:ae6a:22fe
 with SMTP id 98e67ed59e1d1-3808bfce9f7mr1673537a91.16.1782855433058; Tue, 30
 Jun 2026 14:37:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:37:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630213711.479692-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: x86: gmem populate fix and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a user-triggerable WARN due to KVM not pre-checking that userspace
provided a source page for non-ZERO pages for SNP_LAUNCH_UPDATE, and then
clean up the equivalent TDX code to also explicitly check the incoming
source page *before* calling into guest_memfd, and to return -EINVAL, not
-EOPNOTSUPP.

v2:
 - Rewrite the SNP patch changelog.
 - Tweak the code to avoid checking KVM_SEV_SNP_PAGE_TYPE_ZERO twice.
 - Drop what is now effectively a sanity check in sev_gmem_post_populate(),
   so that we don't have to duplicate the logic when in-place conversion comes
   along.
 - Tack on the TDX change.

v1: https://lore.kernel.org/all/20260623091556.1500930-2-joro@8bytes.org

Joerg Roedel (1):
  KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDATE

Sean Christopherson (1):
  KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION
    source

 arch/x86/kvm/svm/sev.c | 11 +++++------
 arch/x86/kvm/vmx/tdx.c |  7 ++-----
 2 files changed, 7 insertions(+), 11 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

