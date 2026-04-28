Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960D3B8BD9
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396568; cv=none; b=jkVPzAXxnzqeF1nHywZEMyWlU7nQqmGfVmbah979Gcg5uGE/KV6UlpodzpQP668ARjVW3xN+eLMcdM3UnQti41N4HHfOrHI1832XG+uPY+kfeVcYm3rsZBG/p1EBDn4lC/xHu9Jr43mSvzg02LWS5m6lisRaoUgWF/uoB3NVVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396568; c=relaxed/simple;
	bh=tuatFHp7oOBKzWjNHU7RdOJ+K1F14Jgpuaxl1Jb8rz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tvf/1vzKrT57FV9t6HTr1ZCK1ryogjxa4GYGIM0dyu6jtCCb3w8zY/qSEtNW8n1Hs4q04zSbZBTFUOdK2PvqWPLhSXRpe8+2UykTLvJRSeB/16ICyG4FXUwA+IjrF+5/wvWdgvuZKpqw+CEMb2DCcXeIuV//awQ8o15nBkPuu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXU8uCEw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXU8uCEw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso6555388b3a.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396562; x=1778001362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KIk0GvLIhklTrdMChVfCugdl1spUwFn4Fa3mOUx7DCE=;
        b=UXU8uCEw703gXTic7+4rwucTarmAkio/aXpWoLpky1Hf1yEG46dcCHwFUbPQzoO12x
         Ik1u6EaR4EphlB0fVLSPHHlRFAaZBLEUqtyHnIzMlOuQKAerM4C3U4EHUi25mDWI509r
         Izh3OKARNKdDJCBJJQjVSsVXpg4k9k4WdgBKwM8ta+scwQJ9fPITL2QlCig5ZBQOJFs9
         vvRyLpVq4tfNBHHWY78+lfvCm0I4Ox+ovE9IrBAqhL9Md4MfuMZl4taKstANY4nGsTXF
         Tv0ogKt2uX1QSx4K+XYLF+pumSVejeFaQaQsvSoW1MvTXKVnXSf2aw+imK3lIL1RmKWC
         VSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396562; x=1778001362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIk0GvLIhklTrdMChVfCugdl1spUwFn4Fa3mOUx7DCE=;
        b=Aee41m+l+FKP6BkpgVtrFMxOaZdyrPTW3WXadU0y8tkZ8g+uCLthjSRxNNArLcFwXc
         14r1e+66zj2gHfGYnsumQOO/lqIg2Wq5heQo+PeqBOChjc6o17fhdhMrxqRQ/HgJri81
         UtkPg+Vy1qnu3OoJnmqpb0FkSm28itnuIoe8ycc2GWkwNi/zYOcoMrTCnga63gXlgbGp
         4JRGtv/L6tK/3YS21vVb3Q18pMYujU33Dz2vEFu759DoLeNPYzEIMkie3jVeFSMR+V7P
         ZwF+7rnpYULzEa9RE8BkFGtahM2QAA6wI42UlzmIOz7Dr1LudNvtE7xdG5Nkt+rW2Nqq
         UldQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dMrSkPAW/EdXVftuT1CPilFMj7dJUlmuS9JYIbqhf+buzgNdx0JQQdSx0vqH4zkSYVsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrvcSqhQiQKr+opib7Cc6aAePCN15BpPtZTIxkZZjz3Qsroa6
	NU+ZHJopp33LtrBhJ7GAAAaBvrmXD3dpWmeH2tFIv7sFEdsWKbMRpE1NhyR6PJ0jIfDmVi892pQ
	Z0zM9+g==
X-Received: from pfbbe4.prod.google.com ([2002:a05:6a00:1f04:b0:82f:5051:f040])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2350:b0:82f:5e65:2e19
 with SMTP id d2e1a72fcca58-834ddb61758mr4444037b3a.22.1777396561476; Tue, 28
 Apr 2026 10:16:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:40 -0700
In-Reply-To: <20260428171541.1342335-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-5-seanjc@google.com>
Subject: [RFC PATCH 4/5] MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Officially "reward" David with guest_memfd responsibilities and authority,
as he's been instrumental in pushing guest_memfd forward, and his ongoing
input and feedback, especially from an mm/ perspective, is and will be
critical to keeping us virtualization folks from going too far off the
rails.

Cc: David Hildenbrand <david@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9eceeb6f699d..8dd5cdbef66f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14399,6 +14399,7 @@ F:	drivers/video/backlight/ktz8866.c
 KVM GUEST_MEMFD
 M:	Sean Christopherson <seanjc@google.com>
 M:	Paolo Bonzini <pbonzini@redhat.com>
+R:	David Hildenbrand <david@kernel.org>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
-- 
2.54.0.545.g6539524ca2-goog

