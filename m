Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231737B018
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406150; cv=none; b=AXyb6aUJuP3r2kyAWgUv7Y8EWgTsfRPlloMUophh97r4nIyJk8eRFLHvnPgz38239SqTYBER9SycQsKxavnVEx2bDX2CwHy/tzGD/PvOuaiWhk21pEnG5t5AMY9EgEmU0gsbje7lB57iaOf05nPGg0Ns1S8YzI7KFTd9WuMt5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406150; c=relaxed/simple;
	bh=gl0VkMXU88WMJ7p9JJUhk0v/bM3nT4KH+i+LhxTj8F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3VId34RXHjHseX493nc8RNohi8NsJzkNFUwM/NVgeVl7NWqgIiR+Xi9Ir7T/OvAJ9bjcZhzEcTYMSYvBGsSjbE0mhtABtF7xkaqGbWOBWYmq/Bfqj5OfKaph7MIT83ZQV6JteJQTv9Pc9szF+8rOIoFBU8SYkT5dJcNBAAAAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwHkL2hm; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwHkL2hm"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342773d94a7so514173eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406148; x=1791010948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqOXJpcEbtCWrtmJAKf798JnZn7rLuJzP3qPIyqX4mA=;
        b=DwHkL2hm0wBWWn70pFnHIAu1dKT+aPIYc+hCWMHfeDG6s9RhweZSs3C1zlNdd1dByQ
         2LZ8dP5gKjDFIAjynhLp5jIdxtpFqeUvEqsI/zL/E9jiEc0qBBbFugLUPIh0dOZbkT7d
         bt8R8DMReD0ihf0T88rkGIm1X/KRuDCHIsF1nnp7ZudrUirLDnDHI15HliHPbp/GsmqG
         Bx3MgRK/IQX4a44YBH8Z4TkeytZZv8LK12bCe+yOf+sVNsWey0JD9nqdRytaGjpHTswO
         v8MOlBHrxWg09K5QKPpIA5KLWuuaRfRLoCOnFbEzhYDJZT3Mwnq1C/RfuXpWEkK2zrWF
         GavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406148; x=1791010948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqOXJpcEbtCWrtmJAKf798JnZn7rLuJzP3qPIyqX4mA=;
        b=Ctjxw1uNLwwvYtFj0S1oSOb+qJEXVAOvrStK4vYl9yT6+JBSkZGHq7UbJUUEJrm3t5
         ZfHcOchhV/u8tXeLj9BzagEhr4/b86sS17DydxdGko2thgd3ONgBM3FO7cY5OeyV8v7z
         DZcOZm5T8DAhaxv4A8zgH20bZS+bN8Sl+uLW7c9wJA6u+3+SyyCdcxdshg81yDc9uO9a
         X6VODFSs/hHR+Honsq7dljEyZwUdKLq8MHA7+NukiI7sww4HWjosQmbiX8BqZ3CUCUxF
         UqUjXshe2rs8xklz4TH+Sc4FSmJ0zPEhd0vFnf/KYN6jw5gRfIVITFdSWgm5dsYEPvM3
         Hxsg==
X-Forwarded-Encrypted: i=1; AKwUvBz0Rhna0z1Z6ICPdMhhZ098osYjvruASS2BpwVW9fVZTHY44Ians4fwzr0n5d80cnwdWQM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFT/x7K5IUceQWr6pRd5iTKSvp/pn23mi2qEa6VF5hF6eG7fiM
	YSOw0zpEA5ilKGrqd2CgKJAqZZpn9elh5Q6q4QUrZmDZqHHWD6npl6jT
X-Gm-Gg: AYBFou0F8DyZ2OFX+j8BjwmqbpViOR9/FvVojHGhvzWqs8OSNVT4fe9ilA3z9wkQDcy
	j7f+FsPd1ubtOm7/0eyaqg/9Q9HbuFcz7Ir8QCZZ+pgdHktbq/O5HMvbcOPHdX8tISgoPF1EW4Q
	ddfuazSh0ddCPeUeJ+RetXEFKUbXzj8WSxcciJDcDjAds6lItwukxzNXkYx6fZpFNd8hMwIr9Kr
	4MLySyhrFQjQ1RAVe6JB1O40Jk2f8QOiKyHp8hRiXnp+I6XTnD/04S4nlE56WxXMJUYoxTYNlJr
	YJlVumdy+AQyumgEoQ9ttsE0MefmX5gUX/ykzpI5K2nEqZHqUuwv8jsVpmbb+qE9TuHUbLjzMfw
	yY0O4R+9MlHGP8Y92OUqoxIT7YSPoo2QCIZbxmg0PkyLZeABPnp7F8AvEZD1EopgPNi8pz1EMbF
	vcsfZPDu6xLswc7hEKhbTGn5pSIW08fz1l/ZIvHmuIZedUUF/wBSjSxq0KaEr2ySU+LzX7i5k6h
	jejs6TQ0O2wYonddTB2L2s/QRFFzXg=
X-Received: by 2002:a05:693c:26c9:b0:328:3944:ee53 with SMTP id 5a478bee46e88-3426f9bf753mr2045145eec.2.1790406147406;
        Sat, 26 Sep 2026 00:02:27 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 21/55] tcg: declare TCGv in tcg.h
Date: Sat, 26 Sep 2026 15:00:20 +0800
Message-ID: <20260926070057.1234-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the TCGv typedef into tcg.h. Per-target builds keep it as an
alias of TCGv_i32 or TCGv_i64. Common-system builds use an opaque
TCGv, with TCGv_tl and tcg_imm_tl beside it. The tcg_gen_*_tl macros
stay in tcg-op.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg-op.h |  2 --
 include/tcg/tcg.h    | 22 ++++++++++++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 37211642365..6835ad97901 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -32,14 +32,12 @@
 #endif
 
 #if TARGET_LONG_BITS == 32
-typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
 #elif TARGET_LONG_BITS == 64
-typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcgv_tl_temp tcgv_i64_temp
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7669dc1c2db..7790228eeef 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -179,8 +179,11 @@ typedef tcg_target_ulong TCGArg;
     * TCGv_vaddr: an integer type wide enough to hold a target pointer type
     * TCGv_vec  : a host vector type; the exact size is not exposed
                   to the CPU front-end code.
-    * TCGv      : an integer type the same size as target_ulong
-                  (an alias for either TCGv_i32 or TCGv_i64)
+    * TCGv      : an integer type the same size as target_ulong.
+                  Per-target compiles alias TCGv_i32 or TCGv_i64.
+                  Common-system compiles use a distinct opaque TCGv;
+                  use tcg_gen_*_tl.
+    * TCGv_tl   : alias of TCGv for helper-head glue(TCGv_, tl)
    The compiler's type checking will complain if you mix them
    up and pass the wrong sized TCGv to a function.
 
@@ -203,6 +206,21 @@ typedef struct TCGv_i64_d *TCGv_i64;
 typedef struct TCGv_i128_d *TCGv_i128;
 typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
+#ifdef COMPILING_PER_TARGET
+# include "exec/target_long.h"
+# if TARGET_LONG_BITS == 32
+typedef TCGv_i32 TCGv;
+# elif TARGET_LONG_BITS == 64
+typedef TCGv_i64 TCGv;
+# else
+#  error Unhandled TARGET_LONG_BITS value
+# endif
+typedef target_long tcg_imm_tl;
+#else
+typedef struct TCGv_d *TCGv;
+typedef int64_t tcg_imm_tl;
+#endif
+typedef TCGv TCGv_tl;
 typedef TCGv_ptr TCGv_env;
 
 #if __SIZEOF_POINTER__ == 4
-- 
2.52.0.windows.1

