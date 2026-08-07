Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91987395240
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096855; cv=none; b=i3ByOuMkMn2+isgCbnLrOXy+EosOcu1lzYqKBmG+zwyTbI8bQiPHDZ4hX5PcMI9LcKwdRyLecqQ1mM54QYk9GMskhOdsegSIYNbSjJwaG+HoKL+D+CDP8rTYyaEQ6klffVQzeqO3Gq05A5qXx0mkblL2Y4biB9KduYcBAESw20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096855; c=relaxed/simple;
	bh=MCXM2XKBVlX/EwXo9DZCvLtvoatevzZ4S5wRf3peb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeVCjsgyAPK43+7yPwfge35vMsj8PsmcwNK9e/MBBr6KQerzj7C9CxCddZIM9+EPsgPO5l+qSBsNTTc06mLtTWQEv39yZribRKzryUX/imf08plajn03/ILEhyJo/Q5uIJSuDGi5XAI5gmM+XChHvrT/ttEyP/Tu8GqTapkoXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+rNtPy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+rNtPy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso21364465ad.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096853; x=1786701653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=bG+rNtPyUBAtJ+cL2Lq+M5Zt0zbQ55t7q+ccSZlAhyytJZjsNcJ+WuafaI7kcLTd/K
         ZtBUpIVy/cJq18W/WSuhGRJSSfZtUWAKIn6dZEp8D7wAfAfKnvV6tZ6aU/Ia2YdG+3yQ
         0cC+7mnhptf6ulnAeZ/FtHjgKUkQRQyPOAF/Fa4cdQSseYE9lZA5mJsgrBpu1JOyQHBV
         UNni/TagtlBMIuJ8FYcbiMRhw5nhPjTff2HwkbP4SBJ8sTf0r533rJ651S01heP7cOEp
         /xqvI/14JGC+TS+2ow4MV7lRN0VJpajYb8mIHiiAHVyj5f7PRH3bIzzHVyx3XQr29V3I
         b3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096853; x=1786701653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=EQCl2gjnJbOsFVL7W3TmOZyhUq6maoTsowgOfcmsnErhzD39BZJqU0gw6DzPc9Gal6
         PUBBZg4t48FmQNUVf+FzQ74TtSTHQwNG9GZGqRF8GGeRN24NbgmGINhJYnsLu08thqaQ
         yrMaA0ejiqK8sL1gdDpeP4L1awzzUnuJcMH0HBRJpjmUJFw7r7EZBmGYjldUAD2MCrlU
         sjOvPAvv+xE2lgOSLNB8dehSVn8qcDPOBak+6ec+NJ75sU/4pFi8PFFxFqjKBB5OCkQc
         a4jBS4Jhr0Unm5/E4lccP5w/lD8kRjUAfm3J52VJx7jbv861FeBJ8QnJh+sHWdpgwwxZ
         H9RQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiCddyV2Ufg3Z4MUDZU9vCGoAiiuGRgLCXAw7noRArAW5CCUSb7VAPmhGSZjs/4pycdzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsW5/a2+MoyuTJYsxWCsL5bpm0vgbYTho6c2kJlvaqVHg7MOR
	gZiYawr/pqbRMBvgDTZek8Vr3M/cE7WlX6PNzox/rHg3zVDhinuhg09AQ1ThsrI8
X-Gm-Gg: AR+sD10kD6H9lERdwIOFWxeILw7pSFYYoWAs6FxG7UR7GkbK5hBN4+L+zGIf5Ybc05O
	35jyz+Vad7YlrW2bHsptSiXI2IUt6OZlzKidQGAfQnSBMUFgCcSW77WORUxWYkysN3dOPIwKJ2e
	zmv/ne9nsSbAr6+4yFJDl+YoqCF0x0z/i55IEfECejMopYwfSAe+zU5c8AfnSNYG7S7MHHtCR2r
	CrzK3Dv9bCbd2BfwDFr4SlGY6hNvudN7dG4ZSRcMrGALyYEMc8+huuIYRD4CeErksv9bLX1zEQn
	rPj2tVlwhszXG+pO7aDM+rOplr/1Eoqx/AvU2939ZdtvtlWJZQ5dF6j3ush85VFYqcSJylfdrf5
	vSWxF1/K7oosh7GSC6qMvKlhXmde5fjP1fdd0yd3YkBDlzTVvTIkLoA4W8dIuGT0A4825scrwN/
	F6GusRu795L/RA1zOwoNhp5z230rxX9TDIPoZVhu57uk6ICOSWiVgIvjqjWjUXwcn44A/p+EFww
	qNkpTBdxXMredlSqqH7YuDl9ye7XR5y8nhuMYAD7SItz+pkAR28AhY=
X-Received: by 2002:a17:902:ce0c:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d0f704ca37mr63534455ad.1.1786096852750;
        Fri, 07 Aug 2026 03:00:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 1/2] vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
Date: Fri,  7 Aug 2026 20:00:24 +1000
Message-ID: <20260807100025.19750-2-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807100025.19750-1-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_set_config_call() swaps the eventfd_ctx_fdget() return value
into v->config_ctx before checking it, so on failure the field briefly
holds an ERR_PTR:

	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
	swap(ctx, v->config_ctx);

	if (!IS_ERR_OR_NULL(ctx))
		eventfd_ctx_put(ctx);

	if (IS_ERR(v->config_ctx)) {
		long ret = PTR_ERR(v->config_ctx);

		v->config_ctx = NULL;
		return ret;
	}

Commit 0bde59c1723a ("vhost-vdpa: set v->config_ctx to NULL if
eventfd_ctx_fdget() fails") added that clearing, and spelled out the
invariant the rest of the file relies on: "we consider 'v->config_ctx'
valid if it is not NULL".  The window between the swap and the clearing
still breaks it.  vhost_vdpa_config_cb() only tests for NULL, so a config
interrupt delivered inside the window hands the ERR_PTR to
eventfd_signal().

Check the fd before installing it instead.  That closes the window and
matches how vhost_vring_ioctl() handles the same failure for the vq call
fd.

It also stops a rejected fd from tearing down a config interrupt that was
working: until now the swap replaced the live context and put it, so
after an EBADF the device silently stopped delivering config interrupts
until userspace installed a new fd.

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275..e5e47f6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -529,18 +529,14 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 		return  -EFAULT;
 
 	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
 	swap(ctx, v->config_ctx);
 
-	if (!IS_ERR_OR_NULL(ctx))
+	if (ctx)
 		eventfd_ctx_put(ctx);
 
-	if (IS_ERR(v->config_ctx)) {
-		long ret = PTR_ERR(v->config_ctx);
-
-		v->config_ctx = NULL;
-		return ret;
-	}
-
 	v->vdpa->config->set_config_cb(v->vdpa, &cb);
 
 	return 0;
-- 
2.43.0

