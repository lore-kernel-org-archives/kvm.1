Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D289284883
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430729; cv=none; b=luaC2I4ZpgTrHfcKBYGejZXP/3M9VzoIwLEKZ9Epeu6piEzZSjWUo4s8Z5/WIiazCgWNMjuI4D5F/Y/8A/KgltHtQTaz0m7RPbciOWBZVmaFEwFVfAX6roqeOSG1dspleb+CXwgMWNgH61lc0d4aOCtOjYlZTIWX8IpECrzKo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430729; c=relaxed/simple;
	bh=FBwButG4zER5Omly4b6UXJvD7OL9dFXyC/SgSJsQkus=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TVNtOTAZY2isH7wiDK1pwwHpOSwfAds2aTn8vxHezah1Rl5Ef1RWVpVW4BSG49EVcr78k1IYvZwBBqNznZIRI1iBEJiGjLAp3WFcJcNxkyA1t9TMJ2IFPdi3r4D56mQD7R10UQblei+LSJh70LNXKgD4oL5tPn/vcgbkEBXtkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxGp8t4L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxGp8t4L"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80907fdc6so3457045ad.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430728; x=1783035528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdt8i5mXUzEOzlelq2WRqgFGgHHaakb0XyCzUJ8vO+o=;
        b=nxGp8t4LXXDImQiUlXqrIxGh5O59A5z9EuttBT5JjifIMvUGwA9KqidfApif6zNxic
         QIkk1lfMwAMtmngevFp9FqIrdhKLoL0q2S5B2m/+1+B0if7EDk8dj/GyBAhaRfku5Czf
         hAxfI57pZTzvAeTWFek1aQdPAlltsROABuyoqYisUleaAdW6RdI73Zw9X+xBo9V5nPMw
         Imb+ozGzdXqUEdxAr3D7JPyW1BWM0QIDidFILtI/cum/mQl2nd4/1/KDN2WcCVns4ULP
         +FY5lluyqGCTiLkxumIsUuMIfUOuE+QdIESYEWaB2DHaB+jABN6P5X7WlAp61crDZOw5
         nYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430728; x=1783035528;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mdt8i5mXUzEOzlelq2WRqgFGgHHaakb0XyCzUJ8vO+o=;
        b=JmCMCI64BdO9XQszFrTqXfim5Xvlp1M64GlU5mWgGo3tr9+HTTC9pPJjQVvzHxnA6H
         NWjphc51pWECEng61ltBQaxF4QU5JjNe78IIVSRl2lBfPfb7zPr83TDeivoXjO+GGsm7
         KjQjF48eax9Nn56Un/8lpKz8+LA8TCosQrJFop6tlseXU+q0h87TkahkW9Af+Qu8pRE4
         IiUWwPFlb+yQaWry2lkSaxWcoIOJjH3QpS2EwXdTg4b+TcpFJglfi7LszxQjniUb2q4c
         P+bL0XN4/ILrv2z/b9KI004+Cja61IAizInE2wfDAksk1pGg4Z+gRvkSaoLBUdMtfRZT
         ncWw==
X-Gm-Message-State: AOJu0YyahgEi5abqfny5d/b39Et23gDUsBdFEX9f6b4OaTXMPETq/CbS
	OUTwnyHydoa+v/VO5ISDV2UGZ9Laeg/R6yI6LevBBMHARPbco60jiT9Z/sbzB8oKI5EDtdH48u9
	gLnwalg==
X-Received: from plup8.prod.google.com ([2002:a17:903:4b28:b0:2c6:bc5c:533a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e884:b0:2c0:b19b:ef0d
 with SMTP id d9443c01a7336-2c7fc70a313mr55645905ad.19.1782430727710; Thu, 25
 Jun 2026 16:38:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 16:38:43 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625233846.3407303-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Convert nested ops to static calls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert nested_ops to use static calls, mainly because the nested ops are
bizarrely different than the x86 and PMU ops, and the kvm_x86_ops.nested_ops->
code is an eyesore (IMO).  I haven't bothered to do any performance testing.

Sean Christopherson (3):
  KVM: x86: Reject nested CAP enablement if nested virtualization is
    disabled
  KVM: x86: Add static calls for nested virtualization ops
  KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops

 arch/x86/include/asm/kvm-x86-nested-ops.h | 36 +++++++++++++
 arch/x86/include/asm/kvm_host.h           | 14 ++++-
 arch/x86/kvm/hyperv.c                     |  6 +--
 arch/x86/kvm/mmu.h                        |  5 +-
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/svm/nested.c                 |  2 +-
 arch/x86/kvm/svm/svm.c                    |  4 +-
 arch/x86/kvm/vmx/main.c                   |  3 +-
 arch/x86/kvm/vmx/nested.c                 |  2 +-
 arch/x86/kvm/vmx/vmx.c                    |  1 +
 arch/x86/kvm/x86.c                        | 66 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 12 files changed, 104 insertions(+), 39 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

