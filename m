Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CD3D9DA8
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305599; cv=none; b=lClz+H2A+qEybKM1k5RfubrcZLwBW8qJXRES5wCpJZrl8HuUxemlxTcxzoguPlcLeDLzwlEZTHPniIXHjJzyfJhoBUe+wKxXIJ+h6egfOjji2w5jzvzYL3iGC/wEZRGAjnXqYbGTHe76nVsMjWbqL1xqdEOr9IHdoR4uKwwzoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305599; c=relaxed/simple;
	bh=oBIfhx1eD1oG6TNml3LN88l4z3IF/+8mB6ZvmmLEt/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y30W0F0gOzjuepzvlmUiCeZVUX8fluo73Ey8PIs4viB7p4Wz23hWPER7X1m8Gv3eWdnuElJkhd0Y/27h8uolKc3tLkiO85CEbXeHZ6/ZI7YUdA78V5ojXGtD6Byd7A4Rz6zXBFSGYwOODDuOLRYgoIsypwOsIuxWzIhkF69N/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEzPkN/y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEzPkN/y"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so25303405ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305598; x=1781910398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=haqxDO4AWR8DqhXQ2Hj6K8MAQPjcpaYt9KY7NTbug7A=;
        b=jEzPkN/yFVD7geRgZxWXDnMofwJGw1oBD/lUN9D0iPND2LY+FQEXisgybdUsdXZhQD
         DBJyiArDDFQ2RRSKmWBQEDpuwJ3jKhDI+53RerOIZbVAc2xT4IpTf1nF1CvvqpUVSyMg
         jksc7am8Zza1LZZ4MKUdEZ+ShxkHfdIP5i8s0YjqdaXlJmEYAljnGud3qBeprdcygiyN
         48mIofP/58uSeKZeluJk8Gn7gAhhvzMQw23klJJtSEhPFzJvOCL+Pruhwh/FPd7wqP8F
         nFRabaFaNZmvihqs67qETvcpmiCOGSBODjAkcgURcxR92l3GNUgKftDtvRZe2TCcLsdr
         1r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305598; x=1781910398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haqxDO4AWR8DqhXQ2Hj6K8MAQPjcpaYt9KY7NTbug7A=;
        b=Bv+s3WVhH7iSdWAhkRYhkhGVAtBNMG9fNqg4GgroY/RYcN+c6fIC2SoLPiDmROhGwH
         xP1VA5HGXpkPC66ej/r0JXc2yjFkyZO1OGw1e5QxNJ657A7euSF9jq9HyQEDICNt3CTA
         VOVUYAIsLJp4aD2DjEcJy4fPzNPW9RuafmvcZRSfaje/xZSrrfvWQP9z+mDWve66yDTD
         8nQ2kd2/+Yc4+ihM7zuZLzqduwR24k9ttrYETnxqaBwI2AwECMc1xSHQQAWiXr5ToasK
         3GjcALgI8s4fkHf05Q3xY0VFFFlbvAg31qaDjd+31yyvlkpKD8G00h2z2PM5vcrYlNuR
         Qndg==
X-Gm-Message-State: AOJu0YyIopGxAYLjjGhu+HOh1uYkuwOTW72vbVtqgn4PtTXHrW4Fw6W5
	KNrKvB3c6h/15bJOE+BU/aT7lQTXeBXAH0kuCIgzMxYwOlSke+eaOYGLA8dXmFzNJyZYK/6Qb4A
	Axj21+w==
X-Received: from plhu5.prod.google.com ([2002:a17:903:1245:b0:2ba:2863:4c3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2285:b0:2c0:db23:4a4
 with SMTP id d9443c01a7336-2c412d25493mr54668975ad.36.1781305597771; Fri, 12
 Jun 2026 16:06:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:20 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-7-seanjc@google.com>
Subject: [PATCH v2 6/8] KVM: x86: Treat a vCPU as unreachable if its index is invalid
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
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
index 82696b27b145..017070b81108 100644
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
2.54.0.1136.gdb2ca164c4-goog

