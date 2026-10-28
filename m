Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212898;
	b=o5Rruisv77Y4wJeaGvucyT7etBUgF9HCVMLmuM/Q7rNrbnbk1c6/eKPg77+nLVCZZFrE
	 3nDsZ7oatX7G+jk86D2qpuFxdQXpcz/+85ejmeSgg2WrxURNPxqmc41e5r5u8UmVpxGz1
	 vkAdf/K1lC2Fhl4/cVdRi7f6SawOJk/sn0/aI/qv9pkgxf6IPPscmzub8dApfpIHKSZLM
	 iQjs5N3ra9q7m1Lr9dqg/BcKZnxdOjPGrlsZVBUju9YfKUfi6SBMOITfSYiG2z3u89cNl
	 glmr8PgLb+hzHlsjDoN5EJYh6f53Dyn70a1Y0d4ky7oazeyB65Efms4SVJGdmn7rAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LGiAn3+vC7k/dQuHhAIgXgOGgb19a4igxKhn9cpgVGY=;
	b=qMsOM+ewfdRdi2kuCgqmacHoeobfJco7yE7NvPwlWdwzKeBJLeeQMqlQofEE5pIuIpmD
	 tfhuk0KtGbws2ECt4qeg4djXhaNBauH/VEBYWec5jDIyV7Vqpc66NvpwndfCEBstSidve
	 YF+9pRjivP8f0TAUvh+cIyXl/ndNYbI2IeCUoNARNIiyX5fdvxIFJ+qbYVJC/Gzc/wDBo
	 ZedrIeGd5u07n4oUpdmnPWJVKVcDkCytdH6Kkme7opGjCupMnRfQXw53G4erT+sDNtZOo
	 ZtMyG9sW9dNQ+bs5O8853o06jIMGBfmoZ7qrZBc/BGzvlXKbSVeP+1IQz42dUEx1/Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aLW2zmsh;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51773606A31E
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51773606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aLW2zmsh
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso2018397a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793212898; x=1793817698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGiAn3+vC7k/dQuHhAIgXgOGgb19a4igxKhn9cpgVGY=;
        b=aLW2zmsh/ARMyezCN+73svbBgGUvHnwglIs8kXMv9ohPv7KXdhcBBAVZSVzHaNW5gr
         UV+v6W4/NJMOIFu6+V5+Znd4fPmD89E0WDokkTIs4+9G9BaGucnhk/GnRx0hEy1IHmq4
         ccqrd+w5hTzKmFQE9PXfJHoDxVAnHIIq7UkNGh98OzN+OQxmU9cBXUSs4zHEjiXfiI4E
         gujbRbfWXRX2fv4+13XPnx2NI+d/h0EFe0emM/58RxRJJUZ9FJK3vHEH7EIwDznW2h+o
         uhvC0y8E94bxFSo0gJQFWrd3oeNhLMGIXX27OAsSsbCacdVyBUagLvf6Rm0tzoRnX6X3
         NQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212898; x=1793817698;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LGiAn3+vC7k/dQuHhAIgXgOGgb19a4igxKhn9cpgVGY=;
        b=VgkgxPLq1AjJ3kF3gc0YjbQafIcHuKF2vTn5WNH/+kqfsuS+hAwwgD//jApH6TJQIG
         njcig+ncJpwGnSV0D5I4yXgXROnmTmVtdsu4x6NIq+tBmtsOuOKhXmuc+a60xQAUibUz
         +Xev28FiTtrvFcAmxcmv6QSwbWPcNJ7h5E8boCqg3TXRe76w1WUe8KH8JzTaNtqtqVBj
         ova6DvV5ocVKxpAsWWA0dndHbNZVfiZ4ZXDOYyO8HZBw15qcuWpVoeDld7lwlzq89C5m
         +MrxNBkOOBKDBpNYALW3stOIQm7E0VuG235vYiycnxBYfUmMa8tz/d6FKR4edopPBn7X
         BX7w==
X-Gm-Message-State: AFq9FYIbdugOD0zgX2fa74CrgyJZXqZ4JVMqU9+60s45Pd+DqCewOcZ4
	VhSCHBzNB9q6n4+uu7KHn6EG3yIE+FkzI9m6Toaf7FPfe465wbMnmUVhqdAiigK5ZU4e3spxeaK
	fKc5Wiw==
X-Received: from plhy2.prod.google.com ([2002:a17:902:d642:b0:2ea:775e:19b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a90:b0:3ac:9669:846b
 with SMTP id 98e67ed59e1d1-3ae57e47db6mr2484597a91.9.1793212897466; Wed, 28
 Oct 2026 11:41:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 11:41:34 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028184136.1803336-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: x86: Convert all runtime WARNs to ONCE
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that aren't
strictly scoped to module init/exit, or similar, to ONCE() variants for what
should be fairly obvious reasons at this point.

v2: Convert the WARN_ON() in kvm_mmu_uninit_tdp_mmu(). [Sashiko]

v1: https://lore.kernel.org/all/20261022215541.631694-1-seanjc@google.com

Sean Christopherson (2):
  KVM: x86: Convert WARN_ON(preemptible()) to lockdep assertion
  KVM: x86: Convert all runtime WARNs to ONCE variants

 arch/x86/kvm/hyperv.c          |  2 +-
 arch/x86/kvm/i8254.c           |  2 +-
 arch/x86/kvm/irq.c             |  4 ++--
 arch/x86/kvm/lapic.c           | 17 ++++++++++-------
 arch/x86/kvm/mmu/tdp_mmu.c     |  4 ++--
 arch/x86/kvm/msrs.c            |  2 +-
 arch/x86/kvm/svm/avic.c        |  2 +-
 arch/x86/kvm/svm/nested.c      | 12 ++++++------
 arch/x86/kvm/svm/sev.c         |  2 +-
 arch/x86/kvm/svm/svm.c         | 12 ++++++------
 arch/x86/kvm/vmx/nested.c      | 12 ++++++------
 arch/x86/kvm/vmx/posted_intr.c |  2 +-
 arch/x86/kvm/vmx/vmx.c         |  8 ++++----
 arch/x86/kvm/x86.c             | 18 +++++++++---------
 arch/x86/kvm/x86.h             |  2 +-
 15 files changed, 52 insertions(+), 49 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.313.g2479322e68-goog

