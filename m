Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0A37B3EF
	for <kvm@vger.kernel.org>; Fri, 27 Feb 2026 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235574; cv=none; b=I7MI676CtpKrZm+ykd1j8qH8aDwE9fqrp/7oBztFccPn6YJwKF30ZKRj9pclBXi0d7QayxWtAT547JsQePxix7XimjkIxjduzCbV5bjH8eFK/DpYoRLf9ge525iYPE5Od7gYy4AnQYEZhK9nmzdtLX4mzVWus071fSzxsOir3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235574; c=relaxed/simple;
	bh=jjqO7YZCeRuBMZ1mewA6ckPXJHycFjyo86Cvx8Zot6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FLN4Ebv7cKSpjC8YSoqnrtiEU1KxFHEYV74sw6EETFLI5hhtgXKlS31WcmwyeS2HohVezUW+n0aZ4voh6eQc4wamKqqVI5lcYIn1N7oYpnUoLZYT5hdlGM+KQBpO6q6pVZxYgqh4MYTUw279FltMX+2qEZQmmR9Ui1+nHFaauY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VuNNkBj; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VuNNkBj"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-679c6ef1538so54071984eaf.3
        for <kvm@vger.kernel.org>; Fri, 27 Feb 2026 15:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772235571; x=1772840371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bd3WQNQbvy17FPuSWSlePhR5MFAZI/OI9QfmsSTSzes=;
        b=0VuNNkBj09zdby/954I7lO+QBsuhnMbzG2eEtro0YF4qPmhf485W6xIrbZo7qZ5yiY
         fgw8qcyZiLU1XXCZivlFLj6K3TsUBPkINX4TCDRdTqKGz9A41l+CEol3eforkeZI0mdS
         +d2NkoAURhF9vC7djtmssEjKFsMSOSVT3xbCmLucAUkSjOWagExj8TtYHeMeU/eHDDOT
         Ey8ZeKNY5e897qGNHCtFoIzkGKUfiSQGDQBR2wDLVxVAQR6w3JaJlxbqkM7tUICarQ+3
         pkdQI4ZeYDcKSreqHn+iFbh0WejpBgv9PI7LVuxcpUqJqI0YSWfWGnaxUIMwpK2PdHEN
         9i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235571; x=1772840371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd3WQNQbvy17FPuSWSlePhR5MFAZI/OI9QfmsSTSzes=;
        b=IM1jcgA29Kqh3GsX0w0y5GEVBnCaafdgXcMxw6T5ww5+xEq7vpWMQY+S9SQNYiXkhy
         NnF9o6RmM30pSwN8yWOEFwYiwD+VKoL7QrLulNQg2Ly0MMyOMFlT6W3rijgSBEJz4Imf
         br2WrQBnvNu9e1x1QscbC3K5paRd2Nzd9axB57+EFQSFORGoU57EMIksDSuN/MTUMnUt
         jAMSaRyPzqpLO+seKJ0FN2mPkVKH52s3BY5/WxTvglZywlhnYX5kC0WBJegjL2CKdX3o
         azVmhppmrr6tA04lAiEhvYjvUn15TgHu9cioM1mzKRGLV/4xxYefck5RrmTYP/DwW86e
         ZYFw==
X-Forwarded-Encrypted: i=1; AJvYcCV47Fs+XWDskuujIDHISF9k622DGqu2q0JibpxnmZnnUSy1v2qXJ++LvTmHke4wH2vWQV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCB/2ZNWAbdb/X0NLmge+hx2Aaykfv5WqPvVmmH4MMJfNCVJv
	RAMTLlvGyctFetMR1IquqQ5YmIEnNvDQh6HnKaoGEWw/NPNQyHHPh3MeVljnWrtLvzemBjjMCwf
	UfOmGathseA==
X-Received: from iobjn8.prod.google.com ([2002:a05:6602:1f88:b0:960:752d:ebb8])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1055:b0:67a:422:d34
 with SMTP id 006d021491bc7-67a04221227mr208291eaf.74.1772235571231; Fri, 27
 Feb 2026 15:39:31 -0800 (PST)
Date: Fri, 27 Feb 2026 23:39:21 +0000
In-Reply-To: <20260227233928.84530-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227233928.84530-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227233928.84530-2-rananta@google.com>
Subject: [PATCH v5 1/8] vfio: selftests: Add -Wall and -Werror to the Makefile
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
index 8e90e409e91d8..6a9ac6dd32cb6 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -23,6 +23,7 @@ include lib/libvfio.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
+CFLAGS += -Wall -Werror
 CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
-- 
2.53.0.473.g4a7958ca14-goog

