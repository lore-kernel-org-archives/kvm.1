Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEE3BBFCA
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426995; cv=none; b=numGulCfHq0ZGYtDcFF417MkK6YsiaxO28bfxO/K9I+DKI9EF0QeF2PWtVNu23K6k3w3Rjhum8XC3G4x9dJXmVuLh1U0Yg1WNePwo3nANu5EYxu9fprNlA0JhYJ1mNf5ooBAUisF3CS8irH/BeuOBT+QIZdG5i0za4L/uGWzjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426995; c=relaxed/simple;
	bh=MJMJSRlF5r3+tmZ0m1lotCOKLe9s9kaI30CjRDVM5h8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UarA8+S0hgEzjYNLElhKC2U6LGJDKnioM6sMOMAL+tNl3AAkqeBIJ9SI0C9WnJS0ZfDqxz4IFsy6TYVtZ878Yk9p9J526dLIc5vl4KRv34QK3GulLufrt+BGQ175y90nYn2Z8HfvzDEEsgl8hwY1xUGX7xZCOR84SxmO7THSZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPCkLYkh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPCkLYkh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80be91ea3so5225845ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426994; x=1783031794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=saiGWJ+1qIp4vGwoKItcqKkB3ikEVHldv3doWsecfgE=;
        b=qPCkLYkh/yOD88x9oVTAn2Yk7HDix34jG9if8amo7lySdn7v1eZpAF0YN/ZaPtAaJ5
         iN6/nr06ihOsWLRorGzEpPYjcJcPUb4aZbZ15DAssVY6Qaks2rr2qS2/FQ5vMKo5Q5rE
         dxO6IUsNBiv4mFBuIXLyO+rh62a6CQbQF2IkgtOkP2WRYBAdO+cRaHmw1qDKn7MXAUXz
         ymoNIzcmGcvjbBl4fRwL+qNCgqe4sc9CB8eDctHj72uK+gGc675cadxA+PG18V4jmiL5
         Oo7NWlne+KXea4Xi5G/90SaKxN1PRvQ1InB4A7Jy4eyXAIFS4t+l0dO9duy0pOf8Z2vX
         u3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426994; x=1783031794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saiGWJ+1qIp4vGwoKItcqKkB3ikEVHldv3doWsecfgE=;
        b=BY08Ee7S8yxPeD5oEH/RQeQsDq1PIWXGqEpA6WT5pqf98BIbxa/3qgaYZtfttzm5T1
         q71Ptle7xE/qcVlaR4jCv9qTRu2mScHlGWH07hXqCZnFj1nGWS0wjur+c0mgUUJ+tw9M
         7xQSXp1vcEuDJRVjPqjKG34X3Fc2OnMqldPkWvqo55DGmyq6CVqcdOd+DEfv3KRPxm3/
         zUWjSy+c3cZ+ILYRXglb3FKPDFYfEGOoIau0nYt0mBlWsz1Sotchp0W5god+A4H68xvM
         KhCDxfo75SaK20XlUd9RxJq1a0eGf7zVp4HCG0DngSiJOOPGskDBxpDyCP7oGKMwV3vv
         S6/w==
X-Gm-Message-State: AOJu0YyL2fzUmwMzFsmGMTWl4+WSLAx9Grgmrg+vmJ1Bm0sESrRPdDcO
	Z9wjnG6HlZDCgQAvhHwz3+/nNd/O/WFdoGBnloa7qmfswKckTf/v6msSIzH0FV80eBDCjOC3/Aj
	n83QajQ==
X-Received: from plka7.prod.google.com ([2002:a17:903:f87:b0:2c7:ef8a:f87f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c3:b0:2c1:f262:4962
 with SMTP id d9443c01a7336-2c7fc6f45d4mr41405045ad.20.1782426993903; Thu, 25
 Jun 2026 15:36:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:21 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-9-seanjc@google.com>
Subject: [PATCH v3 08/10] KVM: x86: Treat a vCPU as unreachable if its index
 is invalid
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

In the "vCPU locked or unreachable" lockdep assertion, treat a vCPU as
unreachable if its index is invalid, i.e. if the vCPU is in the process of
being created.  Until the vCPU is inserted into the array of vCPUs, the
only way to get at the vCPU is via kvm_vm_ioctl_create_vcpu().  Note, the
actual index is set _before_ adding the vCPU to the array, i.e. there's no
risk of a false negative on the lockdep assertion.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b10814f99a50..0bdfa3699352 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -992,6 +992,7 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
+			    vcpu->vcpu_idx < 0 ||
 			    !refcount_read(&vcpu->kvm->users_count));
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

