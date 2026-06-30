Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D22FE057
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853321; cv=none; b=Wj0HmCxmcWQeZFqtbGWrrn0e4WZWhQxbEU9zJ56zp064tbnCcIKKJrJ1CyXCbeRBU25ZcJSGAZuO7bEaj77Kv8jpKyY3JBpNfoQH9laZDqZx+pOMFM7PDwH0Hqdq8jMxC3BxZVK92VL1BLxh8Zbabtx0empBx+Xhx9f7dMgNhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853321; c=relaxed/simple;
	bh=GDHJHk9xJFc4s572XwGqyqIUo9AWSEBZuzsu25ai5mY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bDk0eelWmn1oSrolNct1HkpGgWtxvvlkNO0HONBF19PVRxDjYDMeBPIU51Bsau3rwCXDKrMFnsraxBP4kvEFw7KoPLi/iN7h7Lt1ls66LHxbi6GlUokIVRlu+DFV41U0tdSSPYUbYN2p2OBuuZE7hGiKCqQ+xifMczyFYMzGgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRDM4Dd9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRDM4Dd9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6a20348ceso47101055ad.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782853319; x=1783458119; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeBuQg54UmkKv5OMu/rjdAfTILnkydvlbj+5lFo+p9o=;
        b=GRDM4Dd9PBzSzQFG/lYEFoiLC3SHcKhgqgOQQdaX0JIbJodwbQMofF3aVPjCh7pgWH
         b+nxnMJTowXBxXm0/+ex4Q/ZVjFczxWlDl9YSIJ6/3PcJYs+YB3DIZppgbn265DeDjvr
         AUA37Xqw9C7O5iETZKs/WKSYe28EvGatdw6kTLVq1yJc8KrYX+4i36KIy5vNTP9nOzcp
         tv1K/HQrRomLjp+vHZhXvSfz8vJKNb9ZNZsiQkS+pRa/o+VkOofcfrvTQVanIGmtJXBY
         pXv9VIkXGHuaInkbKjEz+CRKrSPykgJ0ScncabEAARZdzH7Awa93PVaeYRciHmJY/zRD
         S/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853319; x=1783458119;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HeBuQg54UmkKv5OMu/rjdAfTILnkydvlbj+5lFo+p9o=;
        b=fexSasnFTvVrOYAJWaOZlutw+pTAW6Us3YZoguglc2iMbKw8M496gRZo3iKLEtG96X
         5f0W/1aAXpPMCrGhEAh3jfvzmpSyETIF49hnw3c0WXAP6hKV0DPQQ9n1z+WQnqPLJ9os
         jTsrw7g8jKfDPOW1MYfFwA4UTdu7VWW3mCxiw8l7qRRuz+v/P6EY0+BUD0ioUuDQpzZ6
         MvMvNZzAU7hl8TbpMpTDQxgs0FEe1vnzO6mhLZN/4bimmeCb3Jp6mvl1ra/LJywamQnK
         lBWmi+Z41uB3dGf3sOq8q7qq8tFgJfD755DL80Tu+HSscV6CSFA6W9fVWv6AaG6iW+Bw
         +Y5g==
X-Gm-Message-State: AOJu0YwMSk7JCdVFNYUebaxkXS7xs95ZcXRFjAexgT9u/UxXaoffAXaa
	Xjw1ROpF0zhwDvR2c2DaE1GOFwVYQ2fr5BRsIIVcF3sy0T0JZ7+oo4nm21DFv7mARBOKRZwlHZn
	OTTevNQ==
X-Received: from plge7.prod.google.com ([2002:a17:902:cf47:b0:2bf:10b7:41d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:283:b0:2c9:b09c:5a3
 with SMTP id d9443c01a7336-2ca2d543260mr44084455ad.4.1782853319366; Tue, 30
 Jun 2026 14:01:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:01:53 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630210156.457151-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: SVM: Fix a (very) unlikely UAF for GA Log IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Xiao Wu <xiaowu.417@qq.com>
Content-Type: text/plain; charset="UTF-8"

Fix a potential UAF due to freeing vCPUs while they're still reachable through
the global hashed list used to handle GA Log notifications.

v2:
 - Defer adding the VM to the GA Log list until a vCPU is created (KVM only
   needs GA Lot notifications to wake blocking vCPUs), so that removing the
   VM from the list can be done during pre-destroy without having to handle
   the scenario where VM creation fails at a later stage. [Sashiko, Xiao]
 - Drop the stable@ tag, as it's not clear to me that the bug can actually
   occur in the wild, whereas the changes themselves are somewhat risky.

v1: https://lore.kernel.org/all/20260625220933.3357733-1-seanjc@google.com

Sean Christopherson (3):
  KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully AVIC specific
  KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation
    phase
  KVM: SVM: Remove VM from the GA Log notifier list before VM
    destruction

 arch/x86/kvm/svm/avic.c | 96 +++++++++++++++++++++++++++--------------
 arch/x86/kvm/svm/svm.c  | 16 ++-----
 arch/x86/kvm/svm/svm.h  |  3 +-
 3 files changed, 69 insertions(+), 46 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

