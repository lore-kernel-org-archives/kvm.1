Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39B3E1D09
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451877; cv=none; b=nCx/szgXy292srYyt+yI5EJ+vx518wlLS63Xh4asZ8Iw2pOZhaSeF0JLGtXh1BP3MOuVWQTfM1hnsk2I6EOuPTD0eEc4+3BpWNObE801oXNK62vqe8Wp2FKlXCFLzfhA+T0/GLz4m1zceRww1E9XlpYRWoygrPbsZQ3w2RuSN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451877; c=relaxed/simple;
	bh=Z0gO7huIYzcAtRuPQEK+CYTbgzEX11qmkIj1aEE7kzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV6UU2KtFEgDzoBpKoTbHROKCHeS3m9oLc9veA7Bnee4J3B8GqDfdH2Oa54fT0P6JQJqH/B+BvqLVhklozbKKH9mW+DRlf1qXt0WMZKb4YZGik9yux+65i2ZUSPXov51W97bdIiItHYJFRHrT8rPyCG4wsEMGRd7tQzQavCIp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHO9URzw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHO9URzw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-487035181a7so30409265e9.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451874; x=1775056674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA8bPid9+EKsdhouBQu4lXqcrGO4SDDhjT8ZDU7r9Ac=;
        b=nHO9URzwk07pxSVOrf2Nayo+leso2Wb9GXPKDx6H1GJqJsATw5oNgwh1P2sxTMTe2o
         g1CUHMRTCPQCpcwoImLZQwyeQitn3P/7EjPea/83R504cSbJ/p0z+zftqEZgiz0bUg+d
         v/Azd+8ZvWT8DV4U0MgTGpjy5ZONT8toiVYILpfT0DmLWF9UGPYlOhjJWEBknNmlJrkm
         mPLOsLfmAYQnGT/uCMT/A55W683XXZ830vLeN1NDDWCY7YOMlXdT17VL/FNXdw0Fwr0V
         8F99QEzN+3oRn2DEEXzvvRAXZWebiAJ9GosfrTw+rdCpe8NJvWDCBDtVd2jXOzN/1Tqq
         CZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451874; x=1775056674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XA8bPid9+EKsdhouBQu4lXqcrGO4SDDhjT8ZDU7r9Ac=;
        b=j1LZ7ierpmf70/rWkFAT+C5xYy1fA8fAH3IILvCCSRA8E2qhcYRuuywBuDPH6zy4n9
         pLwKBQ/dc2jQWwjziy6ikR6qlQTfa8itmYx2Nt2Tp7LnuJKrs0bowv78JKw8xtd7zXgS
         fo/JCcwwiKY5zAakjdQO7BNg6JsyAwC9eNVVIav5HVzHH/hFrw/0fOabYxgLHxdp5tae
         LhXUjUYi+W2v/aqfiIglNGcByDZoI0paQAGgHSpaPT/IcoYI0VLCpjv5drR5GAEYh45G
         A/TAJ76cNbwJsT+sbvzZghJPOCeQmoouM3PyMzyzLbCSy0/WCLgNZgeo/JAWu4tjwT68
         fWPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+aGWnvO+m2P4FlLefmoHNztCXRyY+hE/rGTAQn83CkJuZMdN6w9IzXULzyJ6SvEZMU54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLGTXzbaKfZ4yBTYyqKDRi2XqYhSZ/Jkdzbw2tQo9KehZDELh
	J8pFhUdtHD/H1KB2++Hi1Y3NaIH6K7x5oivRqgdqxgO5rpAA/YKcUn7oJsYLIDZgkhw=
X-Gm-Gg: ATEYQzzmXbXqxutAliwhzy5l9m2caYzmH5DeLH4/aFzEjtFQqr7zZL8qckekl/Z4EAz
	RMm5tlSmymRvo3BFmNVUHaNKPuUFD1dnOD6WHzhlasH44OoBQm3487D54GQgE7yQWom5qui+6Eq
	5FX2fjjpeIxekiQZ1GWDLv5/o9K9SQwRi0fa42rZyRfPyl/HkmlQEj0TVPoiruwpPJINvDqhugf
	mFtdvx4AFXmroUxtGJ0ci7nsKZMzOkKCHPNaR9mCqkzJbZ9hgi8XU5d9oKE3RxTBLGUDVD8rpv+
	Ccsci21Kn2tCSzK2GVkCQ7X3i439JTL/3REaOwAP+JgqauQhazcsU7lAChz+2dn0ubpK0JYREUO
	s6ShrOAxTtvZCUR4XZydyZHEA8BKLayVJOwse+Kmq3x8aTMoPSQSW9b3OF74v5LrnEHBKVTV1bv
	mVxBfXh7xSJnLBW90TDU0UGqpC+ZHGd+dGxJ8ACIil5jK06PkP12rw6eiUWWCUO//HijXcCybR
X-Received: by 2002:a05:600c:1f12:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-48716050758mr55535255e9.25.1774451873986;
        Wed, 25 Mar 2026 08:17:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm139322565e9.10.2026.03.25.08.17.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:17:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.0? 3/6] qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
Date: Wed, 25 Mar 2026 16:17:25 +0100
Message-ID: <20260325151728.45378-4-philmd@linaro.org>
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

While GlobalProperty is expected to only be used by QDev board
layer, it is used by the lower QOM API, so define it in the
qom/ namespace. This helps to build binary which use QOM but
don't need the QDev layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h          |  1 +
 include/hw/core/qdev-properties.h |  1 +
 include/hw/core/qdev.h            | 17 ----------------
 include/qom/compat-properties.h   | 32 +++++++++++++++++++++++++++++++
 qom/object.c                      |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 include/qom/compat-properties.h

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b7138f2715e..ec8999c0e14 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -8,6 +8,7 @@
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 #include "hw/core/resettable.h"
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65f..17543957a6c 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 
 /**
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 778617787c7..337d69ea2c3 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -404,23 +404,6 @@ struct BusState {
     ResettableState reset;
 };
 
-/**
- * typedef GlobalProperty - a global property type
- *
- * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
- *
- * An error is fatal for non-hotplugged devices, when the global is applied.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool used;
-    bool optional;
-} GlobalProperty;
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
new file mode 100644
index 00000000000..6e44aabc26b
--- /dev/null
+++ b/include/qom/compat-properties.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_COMPAT_PROPERTIES_H
+#define QEMU_COMPAT_PROPERTIES_H
+
+/**
+ * typedef GlobalProperty - a global property type
+ *
+ * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
+ *
+ * An error is fatal for non-hotplugged devices, when the global is applied.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool used;
+    bool optional;
+} GlobalProperty;
+
+#endif
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a328..838b1d2b225 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
-- 
2.53.0

