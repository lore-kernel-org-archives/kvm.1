Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE15282F18
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538554; cv=none; b=n4L0BQawZB/UnIXUgO4wtKyh8vRDNkvJgufyPlMyMS6ex4iciZC4sAEkJ0vxndyLmqa/e1TZt1dEFLl1tfOjleLfJ4tmvS2J009YSkt0ym7Xaei43pGTIirVgn5VzP/JVIuLTVZ2mw+HDPnEQ4HNqSQndjNiiYBosciC2DUUkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538554; c=relaxed/simple;
	bh=0z+V+TeY8jKea8mg/kC84ZrjyVx0UFR/LyvnavfpXZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBFiTB3xDaky07vXMXNQ3C5yNAx+TDbvmXKTMHsoa0HV63t8+N8R8oWWLk7ec3zeIvLD3iN1ipM7qKYjgapb9MPYD3CSxQeBTdvfuppYPI9Ao+58zjLHoYHGAyGlR9+7dRFs8BAZz5ZS94whmBR/pUtJqaDvI38FVpcQZZaBx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJohtCKo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJohtCKo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so4064655ad.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538552; x=1781143352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=64OTf44ce74lsi56sZk7djG5JIWSOY+do5GiODE7GcA=;
        b=EJohtCKo/LTLvJZevneAbOC3NwnaOkQOLv0rxJsHwWlG0QQmMNPXjAgt3+andnlFpR
         vI+nQ29e1viw2keLHCu9hjpjVNmQw9R946VbiXWDuH4nOyLwdUJGsj4Ek95+5D0JGJPD
         nmP06Ds+0fKRccHHby1e4gsfgombsBgb8TqvDObMyeHy39GK1iomRDL911pzu/AhztZg
         R132ux6/bqvhxuKs+LLgq9ajZr9+/8XNMsXZR6WFlxZw2/QhTAqmQS7IwW78NgSCze16
         /dpjw8EGn10dZCHys6LAWbZag4YwisBsInVD/2ElAruxnlEMJVj4DHLIwnsktwATzHj8
         QHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538552; x=1781143352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64OTf44ce74lsi56sZk7djG5JIWSOY+do5GiODE7GcA=;
        b=RC6Xkc9QcJbBTaGrPVQ2UdaXELROeTYCi3OM+OBbNQ3X542e86A0kc4jJNUWtpEmsJ
         sjYeyA5R+7iNkK294coKRtPvWN8tnciLbwved+bmQggmMV8mCGGHECkcWIeq76t2uWZs
         Imu34TaA68l3Uyvv4Ij53RFiHn+Vb6BSjMJf1Zz2sADGvdNZ7pZRdzgoqb7vkBzW45pG
         7om2wHMkf2cCVcCwc2sf2vCSeoz3zoobsjetZkfcked9Veb+P0PNakfrpNUERRZgDv6V
         NJuEnzlos1/Rr9C2PA5lnNbbEjczEVDXdFaUmoyIeY3GuR5zDWOSB1FVhUrpjzbaw4EM
         mOng==
X-Gm-Message-State: AOJu0YweqWhZvKRn1DmXs6ieYzldwhLSYLUhwfCISyMz6y6lZ/b/DcZv
	foh73pbnF4xf6IDncEYo/x/DxPZtjej22xGurhWfQ1sgkmtCf3GLRBl6knpsGg9UDhmK0ocro2q
	cRtCNKG+s
X-Received: from plha8.prod.google.com ([2002:a17:902:ecc8:b0:2bd:7c8c:4ef4])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cf:b0:2c0:ca93:1303
 with SMTP id d9443c01a7336-2c1639ee9e7mr61572755ad.6.1780538551741; Wed, 03
 Jun 2026 19:02:31 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:23 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-2-jrhilke@google.com>
Subject: [PATCH v5 01/21] KVM: selftests: Build and link selftests/vfio/lib
 into KVM selftests
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

This lays the groundwork for future changes to utilize VFIO devices to
verify IRQ bypass in KVM selftests.

Note that KVM selftests build their own copy of selftests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..2da11e1f3d9a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -254,6 +254,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../vfio/lib/libvfio.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -308,7 +309,9 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
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
2.54.0.1032.g2f8565e1d1-goog

