Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B430B53F
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779128; cv=none; b=bmTSf7cwlJ17nSos+76PAeKFi1ponm0YtrfBuku9craN+/v5MK0dyBF+a2x5JtCn8UlgNOjWcNZlC56Kbt8vHfTjFeYUBLtTJOTjuAozkVZcghOoRMZO0zQiEzRfdxJrDP0ZAnbqvikeDuVE6JlDManM9CR4fd+jP/SXuXHetwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779128; c=relaxed/simple;
	bh=Yh4sPDW9kk5y3uW53S1YAoXUxoviKmWXeWPpfZ4iwlY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TV68TLoD4DROUhtqSHCNq4O96kIUVfFqWJF2YVxc67CUpo6tJzaw9AhdD7oA+XOyFwiqRbgnCa5qa3lrasLjz3ZEX/lFme4xDDklknvJ8dTYut6LLyREs8qTgAydE8ZPi4T5s7jv2A9umjC6PojQUssW7aqZ+mtwW9zc/Q0Gbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lieirZr0; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lieirZr0"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so29246845ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779126; x=1788383926; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7g4idZin41ZUz3z+kuvFwKs/iT9PIFB0LkzvVo5mWgE=;
        b=lieirZr0eioAR72GZ2aocagcsVwyY5ZXJYy2nop01bfj5yX/1ta4AJyAd0L9ig7Xxh
         XTwnDmt1aV1RNfXlVj4kKHyLRRrZyRSwwxdg/93Q4dbwkdoUqdNUQATyN2/mpWUIAfrR
         Ae7yiWUL9VzDiqgjWTTUlUIXJw87BzjwVwBfrMEx799ZHCtJHLmzw2h1v/kZx2LF7LrX
         /v8ZrkdfL+ePfRV80O3xbp/YqhFDs341ItOrO2Z0jbWTk/nvz8zqqj469UNWQ5OYFHpq
         lffN0HIyb7xdNAsQh+fLCgIktSU0ffWowYrixeWrT10SYsxI7GTMhlPiZ9cE63W1ICqC
         ZSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779126; x=1788383926;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7g4idZin41ZUz3z+kuvFwKs/iT9PIFB0LkzvVo5mWgE=;
        b=oOWVMQCGGhNuo073L9im01rivVUS3mZKsk4dXK+zSFoKy22eNUwC80VoECiDK46Or/
         0C4cLJXdAxmT6dyhgZPnEIMhFuxopAXDg9Jz/udUfrs8yxpOYWM4+8iwnFwNwUbpKR6s
         S7kE6PKx0Zy7efivyBKJ5NsdWHS7HFtzG5Rq8WAO8HB6ospOBvCekrdhLGq2ArqxFEKi
         FIqHfBDAP9PNVZbGwKxu34ZvKfzCyigzK49pkT4FtSW6kivskFpvPdpwtWSqs+CyuiCy
         MRrzgP+Z8nMKkLGfoQlUXhzE99fIpfGqFS6gPzIReuzaPfXwanOdT/NDAY/7CpFdMozQ
         +SxQ==
X-Gm-Message-State: AFuF++mu6OWBaNFyDXH8CMVhoG63CTmr/33Jpygd9Rxo2zoY8vbuN8ti
	BwcrujHDC5VuJPhz+jK2ihmvTonJ6JU1XF+coMlPjZP0X+RRS2cB17heyeZnapDurLYwshhO6nO
	8I4RByA==
X-Received: from plkq13.prod.google.com ([2002:a17:902:edcd:b0:2cb:6ca0:1248])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fda3:b0:2c9:aae1:a61a
 with SMTP id d9443c01a7336-2d707b7262cmr51037285ad.14.1787779126039; Wed, 26
 Aug 2026 14:18:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:18:40 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826211844.884951-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: nSVM: Disallow bad L1 EFER for KVM_SET_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM allows userspace to set an impossible EFER for L1 via
KVM_SET_NESTED_STATE, which ultimately can lead to KVM misconfiguring L2's
MMU (yay, NPT!) and overflowing the guest_walker arrays.  Then, harden the
MMU against similar bugs (hopefully it works this time; nVMX also had a
similar bug, but the "NPT uses L1's EFER/CR4" wrinkle rendered the existing
hardening useless).

Sean Christopherson (4):
  KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 &&
    EFER.LME=0
  KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the
    MMU has
  KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 &&
    CR4.PAE=0
  KVM: x86/mmu: Convert MMU walker's bounds check from BUG_ON() to
    KVM_BUG_ON()

 arch/x86/kvm/mmu/mmu.c         |  3 +++
 arch/x86/kvm/mmu/paging_tmpl.h | 17 ++++++++++-------
 arch/x86/kvm/svm/nested.c      |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

