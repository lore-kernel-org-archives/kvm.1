Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400B3A5E7D
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406174; cv=none; b=tG8i43blrEoJtq2E+N9ygidoXJhoSCYrexqqIMXrNm+pnDzOVXOeBTW6UAlc12RrgcE9mcBjC4vKmbgXPcy1qIr3R8tAtNB2HDJAVVVUyUs3GBFpyLuQoqN1lcKkOWNbcPUjw6vFQdE6OAU6pybxlSSeJWKbunsQ1Y49vN3Bw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406174; c=relaxed/simple;
	bh=YMb5hL4PchXbH/2by5TBxOrDftK42ioPfEdo12yvQAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc1i5CY0TFWqT6jJdV3glCvvmpcyR8jBOl16umX6D3CezKP5ZKCUD8sVPoNB7ROM+SUV0w0FLi9Gv2YBs3walbIh7QGGvD9r4+BV2WwXshYaEXdfOpt2+7BiScye5DcVzhwQ0p11qx610YfG9ZfDsSQuafFH71t60H8S2/YObW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsTSoOSS; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsTSoOSS"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso1880481eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406172; x=1791010972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xi435pN97DW3z7AycQOykLlzIzDdtWj05eM4KODr8Q4=;
        b=ZsTSoOSSfQ1TpbvtJvZr0BNUGMh87Pxp3pDYyPUbX3YgtpvnjjoGuEeLpBm6GTq2eI
         ne60ECnW/9KF46ARTgc8LDutj0ip79McFk4Dw28ZppER7c0T7o+bHAfJUquZpVkwbX0Z
         BWpGr6dplLq0K8jtJNeOshYLvQVWYVqm5MX/eLfoU9qcsYMzRMWZ8XVW91jx5yi6V6IB
         vdVbxGrtVk8XbowNdjcT7csTjgTzEjXA9Bfh7lAoAis903uU98txXuZY5YgGU5jIpri5
         aGavG5SNWYIHWGxN4SMaTs+aNsUl9daDOIn+EK8lsD+HTReJmVydAWPtNn5ylQeb5Zm0
         R5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406172; x=1791010972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xi435pN97DW3z7AycQOykLlzIzDdtWj05eM4KODr8Q4=;
        b=qAbJ9KKzo45/zIgI5Pfv5n/wQ1LrgZ7LWFWVO5euEySFuz3HOKTae25T6S0EPsJa76
         CUUwPS1kXbAWCJ9UnLBcA8pLnSnBR2GObBeHsdz4t18J5WdJ4O6cd/y/yPDIzlfO0Nc7
         BbS/NQmnmdZhsyuxC1Yj0T0GvNoFIpOpgghJVcvkSNPIGXAQMlQV0lClcIIOKVjGSGd5
         pLffuvj1mBujRKcWN0dzHbX3h5aDeNdwuOa0fbO7h5Edd6h+sWaIUeHSxc6lzTXOum4G
         qovkvR5P0U8WuXVwep3rGzX96Bk9GF3zThfDzjAleYhViOEvyRcVugH1BmpFCq4O9Oml
         vQPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4hbuWPuzVaQ5xCFhLxQ9FtOMdgyJbFEurQbHByrM7gNvRMvZBRmNfDEUpzEjfX4YXUvU=@vger.kernel.org
X-Gm-Message-State: AFuF++ki2KH6MMIgrGWULjvyz+TQU5k4bjkq5/8o2NqnTZt7TAFwI08q
	2FAGI/t1VXc0Qs48kQ1TctsejeptFKbTgFlJb+tx/OJrE41npmw5uZSA
X-Gm-Gg: AYBFou0s4X/8nyjx8JRexdF6VC1X6sWBFUCcifQRUtBjPfnEQnb/UH9f1/MLsADxobD
	5EqbrXOcLAQQ9wkze4ShTHwMTBNLBEjMQjh+iBUiOr9H35oh8HxfIsW3RQ0jQm5BNtnx9l3dO93
	OzJEmfAOnErLpqyafvOEkbe5epNNvkzxACKDQ0tno3I77KtCrbJ1Y8S4P/0RwCvoHNsG2imZLPv
	roInxD9nhRDC4K5juqmM52Lsps9ZzL3X0rIWFHn4AhbbINC/jlB+4Gym++L6zFoQhXtTzmq8Fr6
	bgmQ+EdPcxMVibKaoP8AEdcOgOmYe0iQvbuw09aJhi559AcuLOk9yssip5gAV2ReHkjv3KfJy9q
	0kps0t9ONfyt3sNyRmfYZYcXRDmW8XWlwPuZFugic4ZzQM/72qcq8ozOkyG5tyC8HJkS3nAh8PZ
	WnMtxSy01W6VwP9fNFTQA3kP0aNnpou8EGrCpZekzVPWSyfjZP1iEYRzaCnK6D2WAl2zGknEUwR
	F+QlzdejqSOgUnvrCwQ/3QrwtLLJNM=
X-Received: by 2002:a05:7301:1f06:b0:33b:fa13:61ca with SMTP id 5a478bee46e88-3427246bffbmr2590874eec.33.1790406171918;
        Sat, 26 Sep 2026 00:02:51 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:51 -0700 (PDT)
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
Subject: [PATCH v4 27/55] tcg: move dup_const into tcg.c
Date: Sat, 26 Sep 2026 15:00:26 +0800
Message-ID: <20260926070057.1234-28-luoyonggang@gmail.com>
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

dup_const replicates a constant by element size. Define it next to
tcg_constant_vec in tcg.c and drop the copy in tcg-op-gvec.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tcg/tcg-op-gvec.c | 17 -----------------
 tcg/tcg.c         | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0d649cc13b2..c30b9d5d6fc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -417,23 +417,6 @@ static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
 
 static void expand_clr(TCGv_ptr dbase, uint32_t dofs, uint32_t maxsz);
 
-/* Duplicate C as per VECE.  */
-uint64_t (dup_const)(unsigned vece, uint64_t c)
-{
-    switch (vece) {
-    case MO_8:
-        return 0x0101010101010101ull * (uint8_t)c;
-    case MO_16:
-        return 0x0001000100010001ull * (uint16_t)c;
-    case MO_32:
-        return 0x0000000100000001ull * (uint32_t)c;
-    case MO_64:
-        return c;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Duplicate IN into OUT as per VECE.  */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ba2a1127f92..6362eef36bd 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2287,6 +2287,23 @@ TCGv_ptr tcg_constant_ptr_int(intptr_t val)
     return temp_tcgv_ptr(tcg_constant_internal(TCG_TYPE_PTR, val));
 }
 
+/* Duplicate C as per VECE.  */
+uint64_t (dup_const)(unsigned vece, uint64_t c)
+{
+    switch (vece) {
+    case MO_8:
+        return 0x0101010101010101ull * (uint8_t)c;
+    case MO_16:
+        return 0x0001000100010001ull * (uint16_t)c;
+    case MO_32:
+        return 0x0000000100000001ull * (uint32_t)c;
+    case MO_64:
+        return c;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val)
 {
     val = dup_const(vece, val);
-- 
2.52.0.windows.1

