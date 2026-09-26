Received: from mail-dy2-f37.google.com (mail-dy2-f37.google.com [74.125.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E89345731
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406162; cv=none; b=AKHPhctDkTYiFR6f1M4yJ3HShef92D9qP5RKr82rbTyUWY0iXLBdaiM4gqsNxxLQL3X9R9Tok47eadS91jiAwvTKbnExxeEZlLvJNjHEGOtOHFX9SwHftGVLJuTKQ+YfUxdBCP+w7WCSwFymIgj9kN08Oqer1l1vw6CxeOqktt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406162; c=relaxed/simple;
	bh=F5ZAEUXUuw15xAfPU8BwaUZZEN1ZQo0J6EUlGov3mmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9g41A7tBTEc/vTHrNfZEhJM/ZJol98wi/CGUN/nhcCNhOHG4KMuynRSssRFyXdB9ccRx61WS1KpMM4HI/En8MEkrfjYhhaEYpSYD5QyH5Zek7rdfGapcxxNNp7lS+26g9vSnfgzhVcVe16nK3UcsH3zBr+kzWEKzKwTC5ize8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/uT+WFJ; arc=none smtp.client-ip=74.125.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/uT+WFJ"
Received: by mail-dy2-f37.google.com with SMTP id 5a478bee46e88-328664b752eso1044490eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406160; x=1791010960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxrQ5VcJdTOUL5YWm4kLgy6rCzJqiug70440yB9Q+rE=;
        b=W/uT+WFJ/e5A+oZjMsKZvDQfbW//MLJkOrSC1KC8OeOEq2rHGe6aUnFDKWecDChoN5
         O1pcCLq6COGNd8QRydbEToWui3YLknxWocDyVklq8z/xczWxQ0QJjMyQJKpPkKOepAai
         7oYVjibcpLMkMtbiXNHoqXI4jBpXfs2rjDmJQCW6eAcmhHLB//6z+PxMid/31pCGB2JN
         u9TLet4Qo37NQ9afC3K8oMYz3597AITkCWuEHr7xJNH6gyY0WjshBSDM8VwTk5TfF3Tp
         z48sdNajktJ+OErvhlIjWp0gXFvOLTb9s4Fd5AukNbNM++LY6N90paWWpDaH7F1/kOHR
         Gt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406160; x=1791010960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxrQ5VcJdTOUL5YWm4kLgy6rCzJqiug70440yB9Q+rE=;
        b=j1lJuIVf2qZOF7guxTzrx4fLSOtP8XXpTUPoRtNWQQMmSyGGWtEIfVzO60eHvvSLyw
         tF8nnWoQ9qTWB+8HANe0Ounb0j4HPogR7XZtvH37dxLc1RtGgbXi+pOZWsfFiKogSkI6
         uZqqq0LRh8kg7vfOYNIEPNGTrh7kRe0M/gVPSWU0kVkOIPNQZtsGvrWnQZbltpHAXZ8a
         Ju9Js1i9ZrLqLYLxnibI6T3Zll2F57k9QaSjrhunwoJQlWgENuyByken217GyyIIQkKu
         tRc1rmyOXJfcd2Dya0u3QIB85IFw0LjuKqUCU9Vh7LRj5jqDwZeEiWByDccMYZepwPY+
         Eq7w==
X-Forwarded-Encrypted: i=1; AKwUvBzLFPGJw1AgI4A87RjKZEtWLWRAEl6mmpQQBKaaTwRreCsWLQpIxzgIpLYkGHQupAZjvCM=@vger.kernel.org
X-Gm-Message-State: AFuF++lYLTPfT5bOmrcxncKJpO5LLTJmNBRwldokUEhubm2tkwtFhcFj
	eTTGY+Hjtctq6L/9HrS7xiPVrhjaedoeaBc/TMtTMYkE0jQ77e+PW9sc
X-Gm-Gg: AYBFou3eOIbFASt0jLkJ2cls3pfV5oQCU4mH4Q+2360rqfnGi6T4iA/NbVRXCL5qP1n
	HS9o1F7PdvaRwSc1vfc9TJUAhs0X3s+iASJDcwzDbm5G6yETeg18bWwF3yGhulkTtY9C9W53ykj
	jr1fZkA8HXCShBA+ji4J1VZ5KmF08YABDu266XpLP9Zbg4ZKoQwTIyJ24TOTiodP9aVSxWgPfap
	C1HvRPZ45hbXs5WpEuUp0qG99Z669oCDWtyYdCHpYCuauXkfrUnCD3G6nM94kLiej8ZkyBVYxRR
	+o5DfwoDXIYOtqUY0AHD4cdagMijcocJQm/9Kw4PNn9DTgP/PagzxQcEQvQ+s9IvN9VaMq1q+/w
	oWGUaXLPJFWgGs6Sc+7n+Y0GS1pFQi49oUfQLWbnjXeh+Q83jkxmXYUa21wTyqdL0FSZdNDEoKK
	N9o3HeogTmc6PoT47tuEcsLok3aTwAndwd/mNhdW23mjN6ezTf8mtUzcvUhf3Q3dRyH4M0m5N5M
	x33g0sGZqwBP7qKWItIZHDB0GxQWS8=
X-Received: by 2002:a05:7301:71aa:b0:33b:ef77:a1c1 with SMTP id 5a478bee46e88-34271d8cce7mr1958172eec.22.1790406160457;
        Sat, 26 Sep 2026 00:02:40 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:39 -0700 (PDT)
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
Subject: [PATCH v4 24/55] tcg: dispatch tcg_gen_gvec_dup_tl at runtime
Date: Sat, 26 Sep 2026 15:00:23 +0800
Message-ID: <20260926070057.1234-25-luoyonggang@gmail.com>
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

Replace the TARGET_LONG_BITS alias in tcg-op-gvec.h with a static
inline. The duplicate follows tl_is_64() and casts through
tcg_i64_from_tl and tcg_i32_from_tl.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg-op-gvec.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index d82ba6dfaac..96e73178558 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -9,17 +9,16 @@
 #define TCG_TCG_OP_GVEC_H
 
 #include "tcg/tcg-op-gvec-common.h"
+#include "tcg/tcg-op-mem.h"
 
-#ifndef TARGET_LONG_BITS
-#error must include QEMU headers
-#endif
-
-#if TARGET_LONG_BITS == 64
-#define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
-#elif TARGET_LONG_BITS == 32
-#define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
-#else
-# error
-#endif
+static inline void tcg_gen_gvec_dup_tl(unsigned vece, uint32_t dofs,
+                                       uint32_t s, uint32_t m, TCGv c)
+{
+    if (tl_is_64()) {
+        tcg_gen_gvec_dup_i64(vece, dofs, s, m, tcg_i64_from_tl(c));
+    } else {
+        tcg_gen_gvec_dup_i32(vece, dofs, s, m, tcg_i32_from_tl(c));
+    }
+}
 
 #endif
-- 
2.52.0.windows.1

