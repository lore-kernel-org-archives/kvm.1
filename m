Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE21DE8BF
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100581; cv=none; b=id27P0IFB7I3ugemR0ZCZzxabZs2n+KqYsIv81JuciINa4uizpc+oNmIwj6352ZvzMhnsuPi5dtT/kAVG9fGnC0MYmztgiD9Rgvlvt3DMwpgOkcPS3jEw5ZuMltdq0ouk9zeWghbIWMnmwPcR7HXZjXhFWInG8Rf0mNLlSroT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100581; c=relaxed/simple;
	bh=s2MYJQNj8LYRIAfQocfHgBxQGwQ3ttG+Ot8ZEKdurmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIIgJaDYAASc9jRtdZ2bNA68A2KTN0FXyWUKsXzn923wh4Gs1nUwwIa0K8OkZyZwQqub01eGMcustnVMR7cZ8WPAKelJZTGqRNZ2Ii4dSH17saqzyZQzr7NelQp4FDyIgY48rH/gS43LOr10KUf2kcJ8cfV6aOqxF2Sm2If9xBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZrriQdB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZrriQdB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso1982710a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100580; x=1780705380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v7UfovR9K9VTf6qWxX2XmbiOmSXdhYyM9BXuDZay90=;
        b=fZrriQdBCohJVkOtSWvQ0tNxyERpQhv7pH+SjvscGFzU83hBcxh3Hu71okDjhh22sO
         05p1SJ8VU5OjmIlcGag6QMTKc5PNysczTsXQ049vgKFMj2h/KmC6ZzKj0XnAzi1bqyPt
         bJyFtnqXrOPgeM3Nw5iCFSPUpAPnBtld92w5XZA5dqGpL3NerKKX5CJ3tY4pF+aP9N6x
         9BNCkWbLO2z2rp5Vpxa4qfkXUlFUG5aW/UvsxNHk74Xfb3DLqWJvSzSOadva227IlPGm
         UAXjYouWnozcg/L9Rhj6tnvLIvYDYSNb5Iqt/UAuywnQ6lImh/CIt7OsjX/tNgwzHOkB
         mGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100580; x=1780705380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v7UfovR9K9VTf6qWxX2XmbiOmSXdhYyM9BXuDZay90=;
        b=sbrp3YU7tmjZTzfzPV8x0rRsrkh/T7JnHYB9xxtYMx+e6Uslz1BTtZOWvNv92+vs8u
         tjV+PgSkzElr2k8wNOvgiVO+FMN/QisoTFT9cPVmDckZ/T+5Jpw74DQEm9NER/kKTiuZ
         qZn4ip9y9Zjro4DZmdoLFvnoM/VLK2JvtJJqEbO1GVZdMZ2Xrxxar3Gcs2n61/2gFzVk
         pR2Ehito+gVCJ/vVAGSrtMUq0EQpCh//fGZl1uqGjh3p0ysCVD5oPEGbdX7ia8ZInHbV
         RQ7vniRJ8/1jM7v7aiOQDkaxEBmoj6n0sOv714qK9AZxjr4UJRCSxci3NpC8u2drXK20
         NXKA==
X-Gm-Message-State: AOJu0Yw3SAFcqCfPRDWlMPvdFMkUYYUx5VTlBoprm/DIUh0g8niTdme2
	ReIatj+nAT/N/FBcSEaIIEBB+qWW/47h/1ITgPFyYXbg1iofYCDLIGv9NYkvlJLsWm6tS1+DSG3
	xbZvbtIjD
X-Received: from pjboh6.prod.google.com ([2002:a17:90b:3a46:b0:36a:fcf5:b57f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:574e:b0:369:7421:b376
 with SMTP id 98e67ed59e1d1-36c501dd387mr1274602a91.19.1780100579735; Fri, 29
 May 2026 17:22:59 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:16 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-2-jrhilke@google.com>
Subject: [PATCH v4 01/19] KVM: selftests: Build and link selftests/vfio/lib
 into KVM selftests
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

This lays the groundwork for future changes to utilize VFIO devices to
verify IRQ bypass in KVM selftests.

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
2.54.0.929.g9b7fa37559-goog

