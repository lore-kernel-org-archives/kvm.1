Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1F3438A2
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519534; cv=none; b=SdmOKVAFsTflC2Y4mpjW1ijGbrE/1Dz4qTPEnd0anE/7QBx+cJQ+UBNLhfUoLBep0HbHxivuDOOyToJ8DeUwHWUY79hh20WtGlaTVEdzRqp+g/ylDOGEms0+ZVw5var/q2KekiLZEL7RbI9TqIv+iMnuEFKqoKqRdka8lwRuu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519534; c=relaxed/simple;
	bh=/EEXduCbbJW7RsBSjzki2NtQI5CR6bVt940+ugp+/tQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roIF5aq0pKP8ElktYSwr872fII5/SnlkzUxanI3gEJahExi4/sCF2pjI6kpz+EzvImY4/wsV6XFMTQ8PacM1JP/s4kjeCxNgbTRbUnGMui0hPhd/B1Y/D6qcgaS++5c8MUF8EWYIMnHc1PtnOUB+8Psfoq124VLYJWLCGLIYOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHkalhvY; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHkalhvY"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1841281a12.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519531; x=1786124331; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+VSfyNtMip4APtZ088guBfkT6xHvZaUvjwNSK+dWASI=;
        b=lHkalhvYLY78mlq47Vbd3M41jeNm7a3Giis7WC5jtqelvYvdB77Vx8JQ2HQ166Knli
         eMlmDWje2lMI5cogwdHjFi0fTNi1PHAW4Qwsdn8AOGwco2pY+eSQxFMoqHZ2JSTp7305
         1IokEahc7CIkXa0bS7L5EsXhsZflY6DnZCCN2s5XzeOTuohVmVu3PxabGxXoo1xRuzAc
         NBFH0rnFEFFC1BZONZZoN205pJY2Go9y+XS/rbg0wMAhhHoUvFIu5ACV09UFZZn6MD2U
         xC3tpsETWI1Fh3VY0nVjvc5inkS0KY393zk5aPukUUlN65KEc7YC19z9adFpXU0pjje7
         jbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519531; x=1786124331;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+VSfyNtMip4APtZ088guBfkT6xHvZaUvjwNSK+dWASI=;
        b=CKTXzG5ZX7R4T4bgthsDnjZ62Q+uHx3n/hTStflNVDVJ9iARYGO572I72aW+6h46OX
         vFvAyNdstHOrv30sMxZTYqSKMI4uvRErpeWg0VpR9veQWa5SowhAAwnbj7EomTqXfSCe
         ZzvmVQnKZK3F7n9PJH+YTX42OIAqJ4Q56y9IHTFOfkAwf0r1g8vukA1jP2DxFxXSHGOG
         Gv82O/Q8p8nEN+jp+ET6WdFMkm4XsN49b3LWT1Ch+30k+Nojjwv5hMWUn0/O9mGi/9vX
         EOeDmWGcj9LRfDDwpcZKNthSrCRcMkWfpb2UFQDtx0eP4EvUOLJ61Q/KXzvOOIBUcfga
         iMNA==
X-Forwarded-Encrypted: i=1; AHgh+RpIpO4wdl3i6mH3fbYLF3zZPxyceaSgb/mWL7Wek96zF8Z5J30j7MBp/sw6yl7X+JzaJfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kcwvD4SUpr8pNXfgXnoixR/rdhf3hLHUASbwOJKA0U51y7Ms
	RQblOiT1e+i7jYKteWehnjePblNVD+KbNH1dEvBCAvMGk4dXH9nZpeFXaFKRY4zrMcjMbPWghT/
	eJ9DzMA==
X-Received: from pghu22.prod.google.com ([2002:a63:ef16:0:b0:c85:8035:8b21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7007:b0:3c4:2fe1:fa42
 with SMTP id adf61e73a8af0-3c92a8f5941mr657605637.52.1785519530805; Fri, 31
 Jul 2026 10:38:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:41 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-5-seanjc@google.com>
Subject: [PATCH v2 4/5] MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Officially "reward" David with guest_memfd responsibilities and authority,
as he's been instrumental in pushing guest_memfd forward, and his ongoing
input and feedback, especially from an mm/ perspective, is and will be
critical to keeping us virtualization folks from going too far off the
rails.

Cc: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e2f441314a1..6c79bb25522f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14415,6 +14415,7 @@ F:	drivers/video/backlight/ktz8866.c
 KVM GUEST_MEMFD
 M:	Sean Christopherson <seanjc@google.com>
 M:	Paolo Bonzini <pbonzini@redhat.com>
+R:	David Hildenbrand <david@kernel.org>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
-- 
2.55.0.508.g3f0d502094-goog

