Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF56381B0B
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850824; cv=none; b=Sj9nSan0qvnGTC9AvX0CjwVJ1t9XPl/QmCAHrH/LBd0vYHzveVmb4UWzr64j1MI/1eZVGthKGUz7iiGKpNwpaklpiZ+VB7yqSenBx4ugRPWNUxx62dRhGiBB6C9GkpQw6dqRDULkJ0r9Sf8oVPFk+P6iDWqFto6vNHhhTZcczWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850824; c=relaxed/simple;
	bh=fSqzapVbhi50RsvgnEl+9iGQqJaRj/nkPpMfn3GFdzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwwYP5iImgM7SoCpycQmhtxJZfH8c3sY9KAPqFm1WuTjgg6CZe7bKDlT4K/f3eJhl3bjKCbhtGBL+CrdoWhVUOVYslCd+/HGZXHKk/4B28qbPskoI1ptmoYATy1fwSz/9UGzBxqCHRH2Oq3tW4mBREbmsRVveaH+ZLTj5AdHtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGhBxiS/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGhBxiS/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso35608995e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850820; x=1776455620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2WKZF4iKqMlnmispjyJNMuthrudidPMtbX4QHH6Sz4=;
        b=DGhBxiS/0qh/L46c/gR6JKQHtFEgeeoWc5nn1F3TJFEUy8WGHxoBXeOFC/rdMy9Je3
         FhxeoEuS5OdfrQHYV3ar8JN+nq/Me6OfEwhCMhq0A8VMZGSPDyfbHMxtXYT0kVbXyevt
         tkOEAJhudSao+RojH3sV54qQ1M0szZLlwtJUekj/yJBfrn9c0K9TF7dV6go6GdWeDmuX
         qsJe2enegbRQ+SVRhMk/1LtYViWmOlT9BblersNHHkJKIixKqYKvK33Z3UAPAgoPEN9p
         /wgPXBKb5VyABlypoiNBByCDN+Ypu2uXfFBNA35ukjGh+Fm/62zsK+d9kUxneo4uKrBr
         WhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850820; x=1776455620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2WKZF4iKqMlnmispjyJNMuthrudidPMtbX4QHH6Sz4=;
        b=hieWx2h3TQQywkhtaRsJylem4wDeqz72Y31M1UXM3oxeUqc6flmZc1HKg3IS64odl3
         GrBSRM4oCXIrtSUFBQKcsm8YVgNgW70I/lLYmx1Mwf4lsNWHUtqGJI3mcx6Q4lggg1Ni
         8sF7zQzbGptQkw5tqnMO/cSsvngN3fyQSRCbaVSQE+4xTXllYA84xgEZz+vtSjPr8OJ8
         tB8GUQKVXsePJjlhy9/6w1m2OyjSIUEdRO0jPH0dCQxgjgQrTveoVmddJU9B62t9gDsq
         WkROzPFz1pgepNMISdzkbLp6Wp+yLWIkB64qdUsNSUDt8KW/r2bxdlGnGROjlqLI1+kt
         13NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8gb/PbxQ0cMx4YpghRMHDF6AzgDl1jlEcNjDSV3i9i1gJEng7nt7qW5uDLRPgKmTl3JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeAfQpFFXvMNIBHdf1e0tb+7HgNxXKjXglzGuLoBi/9+oABxr
	QJh9SG3Sw3bLBvZCcCdhVQKu0BKs8e1eXgtnCbxR7z9IiVRknFNUm6HkWRndJ5q6V14=
X-Gm-Gg: AeBDieuhcEUJLW6dRepRNNJ3VNJN3s3cB7AEPXB6XZcMhumvRvk098F8enqSWTJ2kas
	1EWgFbHocAfhb31y/4OezD0+T809wTJR6Opv7ZNn2oGE6AjuHFOLAY/uNnhbYmpmianqeCQGSth
	bXVcH4zApxNZTq5DlzARbTNOAAPf6wXek1cxD09cHTmLtILkQl3cFdBf6ltXgKIJOWMdGHp8yHr
	DHK3o8iMpKsH4JvK87j75tFIBPrfNMx+FeBhLK0PxXIouFE7tkyhjhkzgVW1awkpYhAn1yCrcmk
	wWuTR7bagLWHi+nMz7JIzu0TGTaKM+ZWnLt96g2W0/AkM02lhkRQpy9SHPtv8fNfUcXhhzHTSbc
	TfQUyuON7ewN+6eHw+opYJSef7NZ/zVv3tTin4lAah3HlZGkKJrAiUUAdJl/dPU55LjosJJT2Cw
	A2xuM+btzBLpF5IkPzEPDgeVaSUrJNw9qH22ypOfEJOFXeoPOUKoxjnfwaUDyLx/6ljT106OeL
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488d68865f6mr46720645e9.28.1775850819896;
        Fri, 10 Apr 2026 12:53:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm129524635e9.3.2026.04.10.12.53.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/27] monitor: Remove target_long use in get_monitor_def()
Date: Fri, 10 Apr 2026 21:52:56 +0200
Message-ID: <20260410195323.17937-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Truncate manually, removing the need of target-specific
code in get_monitor_def().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 812714ada01..b9b79e8e927 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -93,7 +93,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_long) tmp;
+        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
 
     return ret;
-- 
2.53.0

