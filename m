Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BE33B6EF
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860199; cv=none; b=YWW793Ls3jTH0IuQ9VWsUxhf4tg8viw22jfx0F2D7eIucGjis3WqSeV5Oej3s+MqXZmuwvaIr351YeMb3/ZlZx9hGECiczpH+/pFXqC4r1KG6jCR/7dyv/3C2DbPCVyua6CIT3WE04krdvzFQa/F1RTsasxrWeHJOpReAeVOpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860199; c=relaxed/simple;
	bh=cGmdI0Ry7MijynxLEoZHU+s7rPFrk9cMqJ0UyT6ooOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aVAKxHAGK/vpEOjxkTNzCRs3EgrO/56bI1e84RkAZSYJrlcpz/NrSS9BOR2dHkhQmkICbxSkFxkc0Fp0mVCLVRM4vLqWY7fyhqhTX53vwoovw3gxDBHGCfzjcUEj07mxwx+UJtSAlAi1MycR2T1iC9HTVctLvpvT1y7BGMEhVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpY3MOJO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpY3MOJO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca3b314193so426045ad.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860188; x=1783464988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vDZKgfpZox/TXdgZB7vK7ca8r3LAHTrT1sguPknYXn8=;
        b=dpY3MOJOG5OFi/ixlwEDaoEHE05v6iMMAtYlMHRK/TqNr0t8IlEIz+oCR8lf2ZgVYh
         pzSNDhhCOkO7ct+9Hd63aZXp1A6dxSq2xqxLyNDnLD+lxm1HGjxe1AurlMvod8+prBG+
         HLwRUAHJCbz7AdZ2Y8jlE9K8nDGJg5EuQ8QBt1wybM2MZR4/piMaueG4CDDWOquUC6V8
         ofaZmB4LQCfpIp18vKqbXwCRuICGmq6dpNxa1VJu90mt65QirEJ8TUqX/hXUYOKQv3et
         4G9pEBmgFDlixqQkKBbv/wkqyK7iewU73l/C0xt+l12RC69vLEBIXns82zPZG2mR4wtw
         e0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860188; x=1783464988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDZKgfpZox/TXdgZB7vK7ca8r3LAHTrT1sguPknYXn8=;
        b=fvLUQlaE46gZIK84iI+PRukYZNGVsZc7jHH0DDqknEi1eppQOMTFrijPcmC06vqzQq
         pLLr2QnaiMpO3IkQs9yM9BEtu1zCcihCr+ybvywNRmZxowryXPqhfS8lu3hDbcUxBVPI
         dSl7xhakGfL819N846Z6gk+vH71xQLDgZeePZIO0mIffuOldGduPUnSM0hrCqQUEB3rO
         6gkQpTKn4pILCdagpWnSQTsNEQM9+7NjDyhHraPQshqKfo1/lkHQJXWriT/q9tLO2KnV
         8s31G7mDJA+xnMMvhD8EoJOfWlloYZDPcFq46ol5GpLqi765iNTA7GW/ox8jMYqGtCSn
         /7XQ==
X-Gm-Message-State: AOJu0Yw52+WxFTTg1rfiEI1POnCcT3Fn9K6NYUPCM5BEG1YNUByvKIbI
	4ksDGqswvwccePTky56Fu6TKW8W2iXP56/XygrK21SvKVJG5lyhOuT4xcfwrcrqGiuuhZtvlWVf
	G3SW6iw==
X-Received: from plgm11.prod.google.com ([2002:a17:902:f64b:b0:2ae:c829:83a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc4:b0:2c9:cb6f:9015
 with SMTP id d9443c01a7336-2ca2e714b2fmr43352335ad.23.1782860188279; Tue, 30
 Jun 2026 15:56:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:14 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-8-seanjc@google.com>
Subject: [PATCH v4 07/11] KVM: Initialize a vCPU's index to '-1' while it's
 being created
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Invalidate a vCPU's index immediately after allocating storage for the vCPU
so that KVM doesn't incorrectly treat a vCPU that is the process of being
created as being vCPU0.  This will also allow detecting that a vCPU is in
the process of being created and thus otherwise unreachable, which is
useful for avoiding false positives in lockdep assertions on vcpu->mutex.

Unwind the index back to -1 if inserting the vCPU into the array or adding
the vCPU to the fd table fails, so that kvm_arch_vcpu_destroy() sees the
vCPU as unreachable, i.e. so that teardown logic doesn't hit false positive
lockdep assertions.  Opportunistically add a comment to call out that the
"real" index needs to be set before making the vCPU visible to other tasks.

Note, kvm_wait_for_vcpu_online() naturally does the right thing thanks to
vcpu->vcpu_idx and kvm->online_vcpus being signed values.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..05275d318bfb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4188,6 +4188,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto vcpu_decrement;
 	}
 
+	vcpu->vcpu_idx = -1;
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page) {
@@ -4216,6 +4218,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto unlock_vcpu_destroy;
 	}
 
+	/*
+	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
+	 * Unwind the index back to -1 on failure so that KVM can use the index
+	 * to detect that the vCPU is unreachable, e.g. for lockdep asserts.
+	 */
 	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
 	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
 	WARN_ON_ONCE(r == -EBUSY);
@@ -4254,6 +4261,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	kvm_put_kvm_no_destroy(kvm);
 	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
+	vcpu->vcpu_idx = -1;
 	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 arch_vcpu_destroy:
-- 
2.55.0.rc0.799.gd6f94ed593-goog

