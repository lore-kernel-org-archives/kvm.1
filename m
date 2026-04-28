Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECD441031
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396565; cv=none; b=aHD29rmnl5D4KrInYCTMjqZz9IRv53rHhdJr+8Pp03L3aLQkaR4AYODi46quq6ViUXWqUmxbdLnndyj9gGHi6cNJE2f1q0ZZky+upNwe10YDYNP6NRSIgfZ7qWUC3Lu2WR3qHfTh4BBZ+VhtIrpU8NGDzM6wvTyAvVd4VK2YRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396565; c=relaxed/simple;
	bh=AMec4uaDzSoh5VQ7f+CtBz4RlBhnGCQEhAhynFJEEgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kWaxVOpNSa0kHcg4YrpCvbx8HIHygttPIitflmXTb2ArZOZvz9eZZT90Vej5HrSBQSsmmeF+JNuOYF9J7Z3zJ4LmcZEZTOVLwASDYkL3cjbNEqrePFATSd3KuhcF/ggYqUZFhHVJCvV+PaeZbjcah/Mg4iOgnYU1Kr/A5tB3Lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhQ/aTw7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhQ/aTw7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f504f6b75so6589844b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396560; x=1778001360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/MeWY2RJ1yS9Np3QIXNL1dxnrc37rvHOUpbNdZX+kyA=;
        b=rhQ/aTw7J3i2AsZ3zBHIK1xRcSfmOZl0gQR2L6kL8ZOXFGs4K/Sz8gdGjDfAJg6V+B
         PlarBgAEBNSvKSIVItMIEFTz4sr0V6eB5b1/9ZGWjai7ufz1iZPb1iAIoWmdMxChOZnD
         JRomRqsMq8/3i1HOSCpJhEyc0sE2mJoAQBgdEwt1OqiEEt67i5qXJj78b/Q1OTLuf7Xm
         HZiueQ3ZFEMvbaTJTcqsKtCcl74K8IbajwYheTdwm9U7lHYoM+R0VQwlX+OogEk67w1T
         u3uj/SqMKEHMU55P9I4GO2hGs/HRdLmy2F8PyR0y5BVdne+ddpi6+apTixgkv9vdFUwT
         9XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396560; x=1778001360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MeWY2RJ1yS9Np3QIXNL1dxnrc37rvHOUpbNdZX+kyA=;
        b=mPHUZEJM3Z3frA/4/a6ibHOhW69eg/bWdhcY0djkib1axi4KNsDGIxkktOVWSMFtA1
         i+bYaejtNlDI5w1nbzZPzMM7S/cEuJL/6chobQutonZP5lyubppi+cDP/PDzsIlTFhgI
         N0MzoM4ickZ4ugI+TG7j8L1L/AwFL34dMu4hH9h4FCbWerfu8IEAkOsIvhrOxd6scX6a
         LTGizQtfygTjof7a3S3sXekaOMlMm6ybNKJ6pjXwjZIjkcjZgBI0jHsrRj0I72j9Jr8X
         0BNwM6aBUKq7pYomo9+pm+a9YqVbrgtxLZd9Kict96GRdYfBIVvVXylHrtd9HYQK3Hqs
         ewIw==
X-Forwarded-Encrypted: i=1; AFNElJ814+qT9fmJ9aGl4fkEFiNNnkH0Dj5ZkRS2+nPqEdJzqjVueIZhbz6z2nETwM1qtTObQWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqNta3OL/w0sDfWDR8305jQd5t1lamJTkWejKacstJTC8Kp6A
	rgRu3G+b1iPTaNKc4RVB7dj04tXSvldmwyTs2EB+BQ+FU8ubcb8h37pPhcIG+obvJpp6TEppshv
	MMF98Xg==
X-Received: from pfbmt5.prod.google.com ([2002:a05:6a00:6e65:b0:82f:915e:291f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d26:b0:82a:6d3d:9ba1
 with SMTP id d2e1a72fcca58-834ea66fd13mr127204b3a.24.1777396559401; Tue, 28
 Apr 2026 10:15:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:39 -0700
In-Reply-To: <20260428171541.1342335-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-4-seanjc@google.com>
Subject: [RFC PATCH 3/5] MAINTAINERS: Add an entry for KVM's guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

To better reflect how guest_memfd has been maintained for the last few
years, and to prepare for significant upcoming growth and expansion, add a
dedicated MAINTAINERS entry for KVM's guest_memfd, with Paolo and myself
(Sean) as co-maintainers.

List both the KVM and KVM x86 git trees as authoritative repositories, as
any given guest_memfd change has a equal odds of hitting KVM x86 or not.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89b470db22de..9eceeb6f699d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14396,6 +14396,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 F:	drivers/video/backlight/ktz8866.c
 
+KVM GUEST_MEMFD
+M:	Sean Christopherson <seanjc@google.com>
+M:	Paolo Bonzini <pbonzini@redhat.com>
+L:	kvm@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
+F:	virt/kvm/guest_memfd.*
+
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
-- 
2.54.0.545.g6539524ca2-goog

