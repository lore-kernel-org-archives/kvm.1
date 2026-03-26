Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA503A6EF1
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549067; cv=none; b=CFbNMmEMZZYe2NIIvNHi+flmprCl5OEGNCdUPtCMFvwYWzZ86c9s88kHTfObvOcvpz7KtoG7ci0v8mbvR3ELSxAckda2evNZ1l0OjGLjAoas64164/90I6N5JDxON/6e/ygiUvK4+sLPyk10lYbDR/d8IFX58tiz+Vb6HYNiJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549067; c=relaxed/simple;
	bh=iJv4u2gP/0w7Xz+XPS2FaVjCIGqX4eOerJ4APtquhpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5UCtcZ+Kz9sjePAsytGHlzdTCoWSm7g76+f9zsmPgdce7XXsVl9pObXB1kphLJTAUGKOtDEDd8fj4nztOkrXmAmAOpFkjv4Bk+V5U2/5MlVapuIuGFfYdMAz/UcEN9JE2hRm8WtCIJxS9GM36Ubam+ixF1HHvNBIMt9WdUGChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8J0sJ3n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRqR4RJI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8J0sJ3n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRqR4RJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+d/5ZfgFOgdPVxm3QEllNN5baFtrT2ZFLK18Vxtrwg=;
	b=I8J0sJ3nADDCCEnBF/B1dAmXB+M4N17f/g/AnG2yEAFADfeCU83XJDQGXHP2rG0SE7CfPF
	5+ZU4O9HVWFc1AxN6mbFDdFU9z9iN3RkRiDBSeF6GOqla24Ej0REhkPZhEsn+HdaFTM+Mg
	eS6lXCOKTWU47EWkcrqIETEuJMN1lrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-nUaUVgFUP_-MMxZ7Xmpk6w-1; Thu, 26 Mar 2026 14:17:40 -0400
X-MC-Unique: nUaUVgFUP_-MMxZ7Xmpk6w-1
X-Mimecast-MFC-AGG-ID: nUaUVgFUP_-MMxZ7Xmpk6w_1774549059
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-487219e0800so7519585e9.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549059; x=1775153859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+d/5ZfgFOgdPVxm3QEllNN5baFtrT2ZFLK18Vxtrwg=;
        b=ZRqR4RJIcOnbJABWw+8/ppMqDqlzg1I86Az4QquVZXgRDugczEiZW3jSrQDidyfB/o
         ceG+5kd48cElv1DGiKZ4AVW1wAkScyPd+xnGaL5fO+n+fDDWq8EIgP5Abz+D8w6METqZ
         IuPAIBSteOgoICFSlVdOstyjh5yam8ATW2Ia2v4K474DPSQDyZULOjb0gPDFpyXOu8xo
         TlQJf+Xy0kUlDUg6EbfkDzts1aABSuWCXdqrxmjXXWucPVLjli9Ldr9zO9lGUbwcVUCi
         rf3FcMhygwxB8P9FxDtMKigOav9+1TBKPfsAuWNv9wdLrEts5oArYuvaFAwn5wKB6NOQ
         4K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549059; x=1775153859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+d/5ZfgFOgdPVxm3QEllNN5baFtrT2ZFLK18Vxtrwg=;
        b=pMWZwGIN+i6K9Y/EUtb40XDpMaY84pRipaRqaLQNxzXudoarcFx7d20Kp8vmcOQtkB
         t94TvHxZGKaXGDDCs4OiA0xO5cR1GNKONCbTCcTRt/YouAQzj0MuvXP3GWgk8pd3QiH2
         SsAb7f2KfGkyDnM/5ltallM3Seez0tTowmAk1AevgKBtk+0gKyXpZ1ll10UCNjXHBJK9
         bK/4qN1DaSuFsJIWid6yLHFGSSWNLz7NPScAbA+zjMvSNjO3Pts/6VTVi+98JaKIFuC0
         GFfJWFlYgjakNvM4q0RECM6I8e21lJ1cwJzoQDVh0x78hVqvhQDc/Mutf+EgissLJq4h
         QelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDfd7piXpaiCaOWcRccdV5qofirpTshKVv6+/YxethIGMAOmL/w8/sKKxPOpvR0B7r+4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMazv4rm5O9k7G/fIyAKxGV40Cj/PsfoUOs1ek5Yf80SNWTYe0
	TIW3jepqiUz7fFNJzEsO5w8i1msC6bHZYavc7qU88L9ZybmmZ3GGrPqRHOosXAbbcVDzFsC/HHI
	5ipvYxrI6qVyGvtOLF+dZLtqI5v/UWLRogsSAnDibqi5+pRPZ+3yeEg==
X-Gm-Gg: ATEYQzx9oxTopk7H+0Qz6YCp+/j7w73eU6RgKhggL4WiXWDkG205d1997LhQi3LwtEz
	oLaD9U9a5zbk8yZV/61efB0P9QUbz85lrYnpqFSOZ7ZApz+jjJlFzM9L4wkH2WWzLlJPAsiRHqE
	wJ8XvmQK14ufnQREwG9NHj3pg/II2Os2DvkGMVyyrqaNBCHGUFHx4r9/FKyKlo8K2jIisOLaMSP
	MC4+iiQfliSD0NtWkPuajGr9rbFPFYlsZDjizsYQG5wyy1ObEmiQuUONndOUSeFBubeY4immFPv
	6NtUsOp+z5kR+Fe8uSsJ0LowWcCDB7sbDKO81U4MqhuutIBjgJaFjAMKjuGu0pckdQamelGS/5l
	djDdDL+Q8qoVpvwLaBFpxH4ZUdlDZRbrt1p+O83aud2GDK4P6CuHVCTAyHwiICzst0IFE7CU72x
	Y7ldGC73GrgzJc/AiaLfQsA5bQ
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48715fc3994mr129347715e9.5.1774549059097;
        Thu, 26 Mar 2026 11:17:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48715fc3994mr129347175e9.5.1774549058635;
        Thu, 26 Mar 2026 11:17:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b4d0sm45963845e9.3.2026.03.26.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 05/24] KVM: x86/mmu: remove SPTE_EPT_*
Date: Thu, 26 Mar 2026 19:17:03 +0100
Message-ID: <20260326181723.218115-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spte.h is already including vmx.h, use the constants it defines.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 317b9cd1537c..bc02a2e89a31 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -57,10 +57,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define ACC_USER_MASK    PT_USER_MASK
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
 
-/* The mask for the R/X bits in EPT PTEs */
-#define SPTE_EPT_READABLE_MASK			0x1ull
-#define SPTE_EPT_EXECUTABLE_MASK		0x4ull
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
@@ -73,8 +69,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * restored only when a write is attempted to the page.  This mask obviously
  * must not overlap the A/D type mask.
  */
-#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
-					  SPTE_EPT_EXECUTABLE_MASK)
+#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
+					  VMX_EPT_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
-- 
2.53.0

