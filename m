Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF73E92BD
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016523; cv=none; b=QcMkOrhOJaTY0MqDg+5YiksiiXYsQR6Ky6CUx2d8EUqnPpvEC0A6PCn/4GgGeKpRqH3TnloBUWM4Gqhpbt2YRDRzJzt0srkGjLfWWN6uIyLBbQXqW50lzQCGYTINqjh97sn4xTSfRRxmMh4b1AFvpRTYtCsw2ErRTbrB0vtUDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016523; c=relaxed/simple;
	bh=mNkQDudgu3sz5Rigm/44n6X6+QGkPsR7h3tJUvaVOpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IH5aZeB3sfDE2GMDfLUvwVrZyqb9PP+ztZr918NBFPgeSSlTdRdgkZs0UCpS+dm1udKjpBbv1xm7Q679g7oeuYAWK3NfutpNEjYyuNaxoaI09SdfEnKC74kQNhP3zHQlICDM4xxxgVn0EKPj/+oUS68x/Lm/a8wVo/zUC8TvfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpID15rl; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpID15rl"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6961bdde2a1so12826038eaf.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016521; x=1778621321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tkEMgBMEnFdcG4d9cOlR5kG+qYJi3E0o1F61AgqdJM=;
        b=rpID15rleOl5W7FzsUUbKTLVLePYwTqC0nev/DhM6XOORK15IakMswawq/CkgnhmsX
         7OLIVO/GyL5HNGZPwgdPTcz/+Gilw9vKkyhBxkYFBq+dDJ/i2p2/fbcjPMIAgHaNh2Xc
         5PNo4OaJppnGlRIIindrkBr3sdmz998Hu6NrjZSYq8YnLGy2u5ybW4wLUV2zkGe4Ue4G
         t9C0va7dIwequGW4koXQ82TfeMoZbbBWcmdmN+/44aP5nJatbjk/zVisrOE8xvhNycPT
         NCnSAieHPUCLb1AOwPvPsUzO9VyfdCskNUvAvM6iCyD6ZbxzgwDH3aC2f7jORU3SDr7+
         PzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016521; x=1778621321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tkEMgBMEnFdcG4d9cOlR5kG+qYJi3E0o1F61AgqdJM=;
        b=OW5lQMliY+5zNRM/U7cQt5lU3U9WIY0YGqmdW+zl9LLbONGyrUc0GY67vss7paeAzm
         K8yMck9ZOUkklcf0lxdnDC6iC6wGoWh3daZg83DSYHFPbZ6wmj3Hm7pezn+bwccWjRBc
         RJt0SzLLov13rcAS1YXTWAPf6rNx1IsicrC8xvLIOlsK6voMHeRpfcCczJJ5dyp0WlqD
         BrsDGnl5Tcc1BtFBi5x5V7RVs/G1UzR0rK8SPWxcXLdEw/8CYvs8+vOPgJJ9WfSfubKD
         WgxooMWWo9cx8NxC3muf9IgzGDGZWsSh4VHWDNQ8rjnAjHf+mj7kKnI8wm7/pfU12otw
         dWHg==
X-Forwarded-Encrypted: i=1; AFNElJ9jide1rvtX0gZSad1GrJXwV8eDa7KojbulvAd7hiq2LuObly6j7ShlyZB34GpeSrtmbNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZh5sAUqEMuqBdAsR+5PvdiwZ/tmZeEBU1HNUUtjzXUzH8pTRn
	+uuMqUMbi925dEIASK0Pzzrvrk5iViskCEp/cNxXXMWa+V1arlz+fpAyS1aCWZNHjIDc01h+Wgj
	kMbtSPk1rUQ==
X-Received: from ilbed17.prod.google.com ([2002:a05:6e02:4811:b0:4fa:aa1:e611])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:ee19:0:b0:696:637e:4837
 with SMTP id 006d021491bc7-69998cd5138mr375629eaf.27.1778016521453; Tue, 05
 May 2026 14:28:41 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:31 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-2-rananta@google.com>
Subject: [PATCH v8 1/8] vfio: selftests: Add -Wall and -Werror to the Makefile
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the compiler flags, -Wall and -Werror, to catch all the build
warnings and flag them as a build error, respectively. This is to
ensure that no obvious programmer errors are introduced. We can
add -Wno-* flags in the future to ignore specific warnings as necesasry.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bfc..e26917ee169c5 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -23,6 +23,7 @@ include lib/libvfio.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
+CFLAGS += -Wall -Werror
 CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
-- 
2.54.0.545.g6539524ca2-goog

