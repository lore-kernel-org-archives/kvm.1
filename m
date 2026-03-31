Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2433A872A
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986085; cv=none; b=hXM/Zs/kO0ffAcGWhVtSaS8NwneMHU/zy13SzaM2R+mS2QVPEJx5FBc5tPEVmpT/FwIV9DZgSq+aTEjSPfWIgKfZCTwwuOCzpc4fsvMj1IdrI5wwyKNNMIfpgdZYXIJ9aIRzxcse/lhV/ClPOQ0wBej6APd9xkeH+WkUfrD6cSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986085; c=relaxed/simple;
	bh=OPCxYiXWpi/G8/kLxHXwcpd3APXL3D6teMBPNHwuh7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YrriERJOjcVJwRiZlkHkTLQdz2ch6lpRBr42fWZvk+nAcoMSA3/a2V7o5ojDqjXppzPZYzEFwD1EDerl/9S0n4UDxt/8FAcF5be79fpFehmRAVi38PdtCMNBKv6VxarD3UK1cVCfpRL4Rdq6MGCm7TLI8Bcfdclg1c2UY3n2uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hukfRuG5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hukfRuG5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso13132907b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986083; x=1775590883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnnFoT2RTqeBQtm+ROr59Gb3lWGpRf6+CEDAGEMNiYk=;
        b=hukfRuG5aqGoTKIV8/nK9E2vrfckVaaiicrQ7EAEEMlx+MmWaj7BhOpK6n2iDp1b4k
         BAolEtrZKSlIwWTvGXGGl9UOBSHA06DR4kmxMaBIRr/+O0AlJoKEPaBNqivQ6FAk5DB6
         feeyUc62t/0YQRBDNTUNv9tBIkeZeVzWVOCJmv3/VSdtJc3bNK5MUKmutXK/GPGvwI97
         IPHCoU6DAf2yyN6y/T12nkZIbg0hoBCBLgLMvFRT80MXqylCYOLEhk+l9eV/EQ+gDn3g
         DbPsUN8Fo1uYDewKZIdiMltuho2H226z7chfyylOk+srilMcSP/UTmpNslpcLjmK9yZN
         gHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986083; x=1775590883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnnFoT2RTqeBQtm+ROr59Gb3lWGpRf6+CEDAGEMNiYk=;
        b=irw33WX16+UZqb1gVksIKaWjbqJ6AJ38n8Y74bMLICrXTLw5ajrUqancivyBvhP66p
         /OVezu8WUVIA4hNXIdA87DvqficAxFr68PIz+CUBulF20osYWYevTXYgTOXjA+8agMma
         kR+Q9IabtlusA+uod2N1PA2F26IaUCzubFfmTU69lkDCb7eaJdo+Z2d6oTG9o9rm9+D4
         P3luMovkIaJodX/nCXP7duAx/yqVXzkbriG/1ypqT3b5PSdjk/ujxGl54n8Wto35dLtE
         YQdvsTXaJdSNycgzAdfBR0D7kivsoJpsaLd/9Zk9n5lkwaE/h9ZASvPzj8LQMVq5tv8q
         fhRw==
X-Gm-Message-State: AOJu0YwH47iAnoKQN0mys2E9FScsu6BI+rcimhGXgpMdUUTgSHb+CKb2
	sJusy0/PAuFjMvciltKl6HjSJJgt5nk+VSo1Uw/xhvLPu78+lTvUahxRWLM4Tlb2I4PRMgixV7l
	sz0F9rC17
X-Received: from pfib1.prod.google.com ([2002:aa7:8101:0:b0:829:72ec:561c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94c9:b0:81e:12f1:d8a
 with SMTP id d2e1a72fcca58-82ce89930a0mr865967b3a.34.1774986083298; Tue, 31
 Mar 2026 12:41:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:20 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-2-jrhilke@google.com>
Subject: [PATCH v2 01/14] KVM: selftests: Build and link sefltests/vfio/lib
 into KVM selftests
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

Note that KVM selftests build their own copy of sefltests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Change-Id: Ib76374497945025fff60f77e6c72308e900b33f0
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6471fa214a9f..b3e223f45575 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -252,6 +252,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../vfio/lib/libvfio.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -306,7 +307,9 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+LIBKVM_OBJS += $(LIBCGROUP_O)
+LIBKVM_OBJS += $(LIBVFIO_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.53.0.1118.gaef5881109-goog

