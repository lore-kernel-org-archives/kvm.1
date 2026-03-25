Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB253DCD9E
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451862; cv=none; b=ISc/qnON+3DPZfeoqzXg+WhHk4DkfvhJ21kiWy6e6Oj5WRgJGWUee7r6/sRExbpIkVhJUs7GeTiyHHAKNpVJaChkNiEjgkVuN9VV5FGy5jfPiv8oNTD5VwzKBknfrUsbyMJcKFkrDe4t5V+h5yCYbulB/sP2rhRK8EOIM7Qi5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451862; c=relaxed/simple;
	bh=w6RCdZJcm3832z9yIN/mc1zP3afMyUYDzQ4U6/YZonA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEPhLSXlHSi6GgkuJ158TfdqsyWnaGOD26ZwL9VlADFmg3io+gB0YmXsttaC3qwo7c3tr8VjHYGJNu1Ds97YYhbUttwY+BWbq7AKna2MzEe9dHL43JlC0Z72SfL/kCaUck3Vbe8wcGdyY7a39KH9l/2FD0XpTpE5Yl11FEFeyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQIKUqle; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQIKUqle"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb14227cso27717855e9.3
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451859; x=1775056659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy+9vnQWvKgE9rUbjn7FvRJO+e6ousybrt19G3s47M0=;
        b=UQIKUqlerd/3cXIOMmENJKzywPZZ8ybLsEWnAEM/czaJaagXx9TkL4Uob7h4oH4bkl
         1mj1SSFhW7TLSMS81bjnM1KOMzHP0/s5e8Zc/6o5LRCpqUzssvfBeDA35236z87My9Aa
         TrX8owRf31ShUdhRnvj7YW1bE4WPBIh/Lys7pUtHjxTg5TUkWX8sr3Q94hn16jC7dLs+
         tJ8NSUow0wqUkxTFzfJKMsiuK97kGInYs2yi2cUgT2nERL/huwhWZDszkO3c61NgZ4qh
         I7Rxegqm5S0gCOsR6IflMyEJrGvmQ5znRHLiQpmIkdtIWcLM/Xq+IL2X/YhOhy+rz/cj
         8nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451859; x=1775056659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hy+9vnQWvKgE9rUbjn7FvRJO+e6ousybrt19G3s47M0=;
        b=H14+DkSHSRJsb9vVyKmX+qBwZqJqiVf0+oYwvJ8ORk6a6l796+tQ8XZEDYmHlx9fKQ
         4gwUJxco5MBMIk5sqep02avDnmNjLnWP/UmfiGeERU8uyrorSJJw1EosntOV78pCI5Iz
         X6VrbAYHnqRIoZjgvAQVzH5eZF0qyotvTpEz3AOzggjCK0T87Fgkqz8UARTrdzHinY+V
         FTMbFsUh/fmlbzf0Qa7NX+el4FHJcwc+981cuI2PsHTZZD+ppV/gqpj74wzjp9jnUlHg
         e+qy3oDzKG5uPq4kdP5fmS8SS3tdJdZAd8VU9lrHIUpzUGhJ07NbhUISbm7ICkvf82TW
         zRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUG22lXAQ7r3x7/lvDtWh3u81EVoOeJ4QLai9yJ+WH6ikyr12CKqhISHO6KWqj4qC147RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYgypeK20qURW/5hwVoB9snLqIekQpvrU35AspA95A2Hs+7fe
	FFwn6kxc6x1guiqb0lQ4IvolAbVjAapklsHVmnP9pxEFapF6v8w2DhgSBMHfI0Wd9EE=
X-Gm-Gg: ATEYQzyiKOM5AzwawoeBU8isH2zU2RXZoLe0OS/EOZFYPpXPgcCp3a/Ie4fb26zcYkg
	+jgz/djffk9OAu0iunxa4vluy+FyyANijiSaYh89Rp4ypQqqdNZ/qS/vD2ggwbrQK6Uf3/XWjiX
	Q4eIkJ/4PmakfZ39K14dP2uXCQuZB19vIGyWu/SzsNN1cTF/fNtHj8MvY8C9/8AMVvz7aiog6hn
	IDB8rstS+lZUEc9LwOs7sXlA4msjOwM/n2Ft+KV++BDqUmZpkxHt27+YZIIgvzecu/MyoUvOph1
	VmF2vCE25xTSY4bAftGCIBjp3xAhLIONd5ABXXEDfRP2skBGBBoTPmml6ROVqlL5V28vAwpdef+
	wBr8dza8nZ3iCf0TImtgdZus6FS2SL9srlG0PhuQuc3iYM68oZRX8KOg23yzNU1Mv1XOgruhExD
	g6qDLUeY9ethsZgAxzRKgmci7qmbXo4qYyIGu3GGDRwmEYyL+S0CfCG2iT7WSXV2vWfUoPd3Lb
X-Received: by 2002:a05:600c:8b2a:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-48715fc3793mr56408115e9.3.1774451859292;
        Wed, 25 Mar 2026 08:17:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871738c16dsm22045995e9.30.2026.03.25.08.17.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:17:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 1/6] MAINTAINERS: Separate QDev section from QOM one
Date: Wed, 25 Mar 2026 16:17:23 +0100
Message-ID: <20260325151728.45378-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

QDev is about QEMU devices model API, while
QOM is about QEMU object model in plain C.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba144506..64466cf4082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3546,24 +3546,29 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Supported
 F: docs/devel/qom.rst
+F: include/qom/
+F: qapi/qom.json
+F: scripts/coccinelle/qom-parent-type.cocci
+F: scripts/qom-cast-macro-clean-cocci-gen.py
+F: qom/
+F: tests/unit/check-qom-interface.c
+F: tests/unit/check-qom-proplist.c
+F: tests/qtest/qom-test.c
+
+QDev
+M: Paolo Bonzini <pbonzini@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+S: Supported
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
 F: hw/core/bus.c
 F: hw/core/sysbus.c
 F: include/hw/qdev*
 F: include/monitor/qdev.h
-F: include/qom/
-F: qapi/qom.json
 F: qapi/qdev.json
-F: scripts/coccinelle/qom-parent-type.cocci
-F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: system/qdev-monitor.c
 F: stubs/qdev.c
-F: qom/
-F: tests/unit/check-qom-interface.c
-F: tests/unit/check-qom-proplist.c
 F: tests/unit/test-qdev-global-props.c
-F: tests/qtest/qom-test.c
 
 QOM boilerplate conversion script
 S: Orphan
-- 
2.53.0

