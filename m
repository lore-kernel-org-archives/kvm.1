Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7A33B6CC
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813379; cv=none; b=TzZFIJsR1JMNEzB8dFouHZPIWNV00eljA8RibWrZJPsh9ujxTzM3pkl+GX6vuAzz0Rlv6IYu9VdF0PfGn6n+iuMAE0n68JrgwiviIt17lMfbt+l6XzAiMtGXT2/1ZjdfemQVHCTtfKTKkZFCPHV3rlPahsSOmQqGxhg2AXd8Lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813379; c=relaxed/simple;
	bh=ebk5ilefbIDTZI9sFE22OCVz4B0wFhUHMvdtjnuf530=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9Em8QXml31gdAsfrIMdFUwJped/E3QQfCLDCf2m0byOcNXacCH5eRkPscdk29imKnH9mFUDgpmST6MPgmXf+8YDX9sf2GZ68b4/dmyTU7anLd7Drh3f/n196lrNOs6JBZohXiul7TC4TLeHrr6yH1w0tNhS1TFRus/v8ZHnwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=At3/Nklz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At3/Nklz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ead99f5dso61580015ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813377; x=1777418177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTdoZnVnH7POlnBUq53tWb2qcF6s7WDxtHhm+48XUXE=;
        b=At3/NklzDiidGNjBbp0QTGJJPHkbNMYExtQNAPehfZTJVNQlgoZCAbsCntfI9YO0aD
         VyZ0TjIxJZrd1Gkg0jfj++cP2/EblZBWLnCJk8hHqb8TX9XQbM2ikMkV0Z5vG/UcBYbQ
         9XlxHIEN6yxBJjuDwKZFqXdTWBL1WZ6WR9rNvwR4cDvxrShbiGPEfUVTYxRGjjeHygwn
         YauliJJOkyfbcT7fW2Os1WDNUQmgPj/1oViq/e/SQVEaKIToi5t3KTkF6JSGswNOUaFY
         LOfOXV6TglQLoYUroCbWJOHMJrcw833UdQ4B7hYBc5ZLBGbf0RHiiB6S3EyoQx4OO14i
         kigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813377; x=1777418177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTdoZnVnH7POlnBUq53tWb2qcF6s7WDxtHhm+48XUXE=;
        b=G9NTrWMWtQdX507e+EeGjcDw6CXzAUoq0jUIhtEPSrIkq9c9iyDwnGBC9RtT7vEE2d
         iLd3CzVQ9qM6XigPY9qWYFbKITdoakPVuA/uuclboI3iSJZ16TXpUOowmSKH0u5o1D1J
         p6M3KqhaRPt4DYwxhPm2T7kkNQzk5y97XObok6BKe7Ztsb77i8QFNmEB8opPL25pN3YV
         3gFujWKUzWsBD+71sHq0MsU/VtZEFsNyeh/dyI4VNO+VVm3kLVobiEQOrYa0bTDWDE9Q
         W2QlOx1w+PNhdBeMVI4MdTv+MGWKWEkuLcIkw+uk9+/RBcV5sHbAhQunJG/uInk5Z8Nq
         6sUA==
X-Gm-Message-State: AOJu0YwxKX+mxBrERO/St7kBysP7IG0A2MrlZROS7nv2ZO7vk96B2Cgl
	lE4Tivl0b1Y9G97SMcvjHLn7oeWPCvLVSrqom293Z+6BNIxRBaOxzLtaYb0+MNTZTkzp7iG4xHc
	hF5MChL/P
X-Received: from pgal185.prod.google.com ([2002:a63:3ec2:0:b0:c79:8016:5127])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e081:b0:3a2:ecb8:56f0
 with SMTP id adf61e73a8af0-3a2ecb85faemr5276984637.33.1776813377212; Tue, 21
 Apr 2026 16:16:17 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:42 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-2-jrhilke@google.com>
Subject: [PATCH v3 01/16] KVM: selftests: Build and link sefltests/vfio/lib
 into KVM selftests
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

Note that KVM selftests build their own copy of sefltests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
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
2.54.0.rc2.533.g4f5dca5207-goog

