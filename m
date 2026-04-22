Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FF3E95B2
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862388; cv=none; b=L25I/25giNykN9V6TreIe0FtIQj+Zzlbkn1MwHXMq433YPHopP9UekLknwzppJd4eFcpQ+86j6ka3x2XnQqQoYXtta/0OpXohLdreSNqiwmW8cbII9LpFhPpSUgCsTePFwrC1UOdC6w7/MEpJSJP92tu8wGS3D4EjOKgF8fS6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862388; c=relaxed/simple;
	bh=bpcuiiR+S/iCF5Z3N0TAugR+CkCiQU5TGYnRkrLJ6L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ8NDiFEWKIhIkKW69iZi3z5e3rMEDqtbZNC10B4x5OfGZbC+76SKH7HiL/6BcAK4W3h2t4yygyYR1P25Po3RDNagYrP8f0DuNzkhO9ZWmHu3iI8IuWKaw8eS7IndP/ISHYeAhGR/HENnJinThfBPu5VSDkZaI6uHP82gW578NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lu4sb5Tj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lu4sb5Tj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso54601715e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862386; x=1777467186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
        b=Lu4sb5Tjm9LeEmk3eS8U5U7qt9eOpZEWMCOT3mhU35DpIsm5hX0qtmAFPdhLJuP3o4
         PNWWdHj0HNa1VqnqLp74vQtJR4eNzWBMd5K8THsm1BgZ/En6ghPL2DFMid3tpcCxN/OK
         ZUiWVHpHRgzx2RMjr+V43L6gj18RBS2rPpgG/L4w7wln1CGgVvhyxv+w+2T/nY4UqNQS
         GE1ASmmYuZ8EjVi6cA8OtiGH2EWLxhdg1ipSWkYzRmYgld2Bf6K/jJ6hrowJhnaKb+r4
         +yu3jsGZ9nqM0WGUzAXyU1r0aJS7Mx+Avx1fhk1Ua78lcqV/HO0hlJfNpRmxvLgXXGpa
         9WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862386; x=1777467186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
        b=g1R8r47SeVP/gvxd3s5ARJ46V8+07TQT9ENl71ZUC4jbe7XSvlsiNFVfbayINybZDu
         2MHzmzdvprMWlK0YJF978a88Hv3EH6sK06q7h9za7XQv34hK1nkPRtJSYiFwOnhHQZyd
         8Dj8mluhN/1lRqcb/gi72zFet/fcULmHrB/PPywUiVdcTPITOc8Ig3k4CPmUSLzAmHc9
         UKFzplILEIqGAokkPNjH6kHgN44R/eDn9QK7iyb6DUNKImtDLrrhNUM1jg0ox9VZc97h
         R0nUWYGAdqNs8kwWbVdzYw2Qd4DwKDdasWMJIvb4YqbQjju/h6n218/rAYgpxvPwaRp6
         95Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/HS60/AUjQ3sYethZCHBx4nlSLekkKdAZeB5EhGpJwKJScq+7JE0945IEbbsh3Iawn2bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOvnbisjvMPkmJ3n3hqVtjw7ktop7kLd1w/ecIwmJzadaP/1m
	Xifja0YTQCi3VoBCoFtNM0Xxi1pNYKwg0s4e8rixwc6zW4pFlS7PjwB3LdUKacS+fII=
X-Gm-Gg: AeBDievvwD/QLR3QbEP6oJ+Pj2IJDJHKro6xk6j4EP5rfExhL/EI/LTQrPJR1BjmhIY
	fT7q8AVUUUbgQihyXV/XliMkdeE6ArMoS5Fu19barpPiGIhZSOfK/N0FfPcYeKvS0T1VXtmfwwi
	kK34E7zJKeMoR2dmUQK8ZlolKLpXh9BOfYK21m0N2kOB8IDqsG5N4LBSjIkER91gzTiCKByqx2J
	dpgDK0IYa1H1ADmKxi9KXissJXM3cs37c4a8qrhiR7WEGMi+3e7DbT+rZ/g0Xj/P277vsMhpDHa
	ngr869pQE0uNOpKKrptgUER88TR30jjEVLEy0Sh4O7Wg1rPGSHNoLRJy5h7ovkaqh2+V/F/20iS
	15T8LsZOyQKvVc2glhI0TNjBmpjfXTJk2i9jGkKItW2Sozi3gy6ixhGnM7HIQUUQE+1XYDu4aIf
	SgZk/kc9LNm09PnRtBMvQxQgU5KeWjcVmrVQ==
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488fb74dffemr247493325e9.9.1776862385550;
        Wed, 22 Apr 2026 05:53:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm137846115e9.18.2026.04.22.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 019D060F3D;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 13/32] target/arm: migrate gcs syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:30 +0100
Message-ID: <20260422125250.1303100-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tweak arg names to make it clear raddr is the data address register
number.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - rename ra->raddr to document things.
---
 target/arm/syndrome.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 65d0de63a83..7ff8c30e2bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,48 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
-static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+static inline uint32_t syn_gcs_gcsstr(int raddr, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    res = FIELD_DP32(res, GCS_ISS, RADDR, raddr);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.47.3

