Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96502377EDD
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213995; cv=none; b=gTD7S1OMXFM4g2MUgsRfifCgQRU+mBSK+22G44c6ie0JwSbwql0bhHxRDYYMf/YZ1RRweiRNnN9ffSgOvlbO+qHQHkIVIen/Eery82MTuZnNCYJb7lbyXeqBC0EemBeHCkUJeCiCh3OprlnEfxLCd2u5P/JpSOjbov+lBMbVR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213995; c=relaxed/simple;
	bh=VUVxFiFOE7rRIxpDFA8gH7oo0cb3pm8q5kQcBajMdNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ffAMEZT120egOIMUz+4LS4saGnrVvr5G1/Jw/S6nkMtBcsDtB1eKRk1ar0rWq/lk2x2rmQi6J2If9I75pfRSd5QmnF0ZaesTgHU84vIdizJZe2eHAtqI8hC1+1wpIutDYgqKaTRX494EP00khOHE3MkG2fSpG/2S48nAWQbuxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGjalTwH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGjalTwH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so306416a91.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781213994; x=1781818794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUg0Ff/Oafdl0wyiqex+4ygk48MToQL6TrpPtb5XsJQ=;
        b=hGjalTwHsYLeztD1MobkS+uvkhyQIu3Ws/rXnUiGcbGJ9KfiFVnPQtG6lbVm28j7o6
         OfB+Yg5QCJj8qxF8OSM2ty9R/zQ76O8ZztnxomBU/ZBmGrSh7sZSyygl3lIoUNd8oyix
         wjQGY8Sc5BgAD5xXHtbAQJEOsp6hnsBdJuUsj/UIKOrskfRu9i/MwgyeCpQaoG8BhLFm
         xdA7JwNBQNZW5jiyUR8OLwD1PMdWCOWCULVHqyiU3SJixLK1VwuJ07XMCiHUtoLd129v
         qKad8qCZ418eOASFEKrrBJ9GNgykcfX1LAw3s6kcTrAnX9aoI2h5Qhwh6wgGpM5Dgj+B
         zsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213994; x=1781818794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUg0Ff/Oafdl0wyiqex+4ygk48MToQL6TrpPtb5XsJQ=;
        b=ReUjGtv4sxVOd/uffDo3nbeqijmWzrDabgY5WWkA6jNZPadZPgAvkJcZ4C/aVWWnxe
         1kP6FdmsuHm/WvGKgw07mYWMSzHgcJPv889swtIGNbUoXVmGFcPE+/0/hygxoE7wUxEG
         nYFmAYppGpfAmUetW8gzPkVFExTlvUmr0sBnq8Aq2KukQ0qsUzuitQ5Ibz6ER1QcWAHn
         TfBnJrbxqpwDvijGGzGoN/lgPyd1P0jA/RVBVuVQithnJ/sSudFRqzzb/edGv3n5PRn2
         J/qvqRH2z+MLhNdaBSh/YNaec3t9Go7Oz23/e/c5e0dqtL5owySBFCADl9LL8bnuMTgD
         93jw==
X-Gm-Message-State: AOJu0Yxq97G26xzw28v6lLAS7XxB7z55zpFo5iFdstk8ZjQthqYZjc3p
	k2VqDzq0Yckybu2ZMW9nDNrryZ+fWCrU+5RZuh3aDflBJ5mosDN58v8MHkmJbuwNF//Q3N6869Z
	GYBuRC9/wLSAqSdUbzB1DjTsORrHCfuaHFpUHGJfwJOBopGWDYkkpDHnQ3R03yxO8C/zNDPHyfp
	oc/ChfiX/kcbBHdkGm4fQUPzfNNFAO8n/b6/IZ+62SEjk=
X-Received: from pjzl23.prod.google.com ([2002:a17:90b:797:b0:36b:9e61:a1dd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54c6:b0:366:132:fda6 with SMTP id 98e67ed59e1d1-37a02812553mr227132a91.11.1781213993767;
 Thu, 11 Jun 2026 14:39:53 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:39:45 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611213945.3714421-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Ensure libvfio output dirs are always created
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Sean Christopherson <seanjc@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add an explicit dependency between the output object files and the
output directories that need to be created to hold those files. This
ensures that the output directories are always created.

Creating the output directories at parse time (current behavior) doesn't
support the scenario where someone does "make clean all". The
directories will be created during parsing, deleted during "clean" and
then not available for the "all" target.

Use an order-only prerequisite for the output directories, rather than a
normal prerequisite, to avoid unnecessary recompilations.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260610010314.DB8861F00893@smtp.kernel.org/
Signed-off-by: David Matlack <dmatlack@google.com>
---
Cc: Sean Christopherson <seanjc@google.com>

 tools/testing/selftests/vfio/lib/libvfio.mk | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index b7857319c3f1..2b8d73b7d329 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -20,11 +20,13 @@ LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
 LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
 
 LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
-$(shell mkdir -p $(LIBVFIO_O_DIRS))
+
+$(LIBVFIO_O_DIRS):
+	mkdir -p $@
 
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include
 
-$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
+$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
 EXTRA_CLEAN += $(LIBVFIO_OUTPUT)

base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
-- 
2.54.0.1136.gdb2ca164c4-goog

