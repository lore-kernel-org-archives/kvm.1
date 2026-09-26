Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35114ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406145; cv=none; b=pXSofGyCYdbRbHG0cyTJrTs6GtaW88zpqVNK68ryJvQTYh7PScwpnF9d1hO/FQjroxLBEQ0nRReieaCQDXSnPfT8zZiH5h8acP5gm+Q6+rD4XhYXeInhc5T8Wt+0cmgOkUQrmzoCM7DDq/j9tN3CKBhOGcpi1ft1CUWRWmVByrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406145; c=relaxed/simple;
	bh=5ScYDHbnEGnHvhzCACzGjA2ywRd+eFuC3xaTmxQhFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC0Xdaff92a+ELRogbQEOSbNrhqAqPY+TLDnz1lh+XrI08jUYfHuzrRZapgRsynXxdlWImPcI9cgTjh1jesF0m8xK6et87gFVTdR/dVlw5DxB0qBxZS4Nk22V/rwgLZSHk1Mcau70FORWzrG8xvGqWfbW+hHGP0QczDKUvSO1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZd2zj+R; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZd2zj+R"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1977240eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406143; x=1791010943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJ9xRfE2HEWLds73Pc52p76fnBhp2O12QLdWppftCGU=;
        b=GZd2zj+Ro1C+cfspjAOmpjSIEZp4Ox2Z35aRvSFNShu0hG3dE8aoYwSBmOnRf2tOCW
         wANFVKJINtNKqNezRjwNNoDQBqjI0EaJk88MRhtUA4u/0Ml2DNh59SvB9xnAFw7F/cZP
         zEmZUL7dlN78sWxtMoBoOymT2FlyEwCoMVGzyc4n0kWNuWPEOrC00iGP4fHUH+pJtG3g
         2KY1XD3PoMn1DjBA+A34q56Vz5VTkUluD+27qVraCCWEpvEa6hDG/1LncPzikJBNehBF
         +Jd1yUPbgZvE2yueXCV5lX7Xrr7BrJO86r+fhdvIebhNRrmKVfwXL4ccZx2/XvI1aVYq
         D1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406143; x=1791010943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJ9xRfE2HEWLds73Pc52p76fnBhp2O12QLdWppftCGU=;
        b=woe+kdMrp2XHa2YDBo/WpBDvVJ68nuetKArs+sJUsLycVMjt/yt9CjvW31/9fl63iD
         uq/g+ThBqbNEUkuTEqJ7fQysTQkvrV3v9QMGPzHET8bNOUD6rHhQlrXYLlvp9ig5bWq/
         XA55VQ3OU0q81qE99Lu3jED5dAfsvhytH8yU1TTW+Vgsp/VxVNF8+r6UvApOBjH/uIvq
         bxa+f5YQAdjNV4Mkm7Ailp8aJVsWob2srbw2iK6Z0gYmXhVrrBaAh/tVN7N6dv366+2F
         p6HT7yMZbhOrUTg3fLhqpcb6eNuIgWhjN4dtrBHj/SKfAKFEEEmlHKhooTKf1zL3YJ76
         mMeg==
X-Forwarded-Encrypted: i=1; AKwUvBzKn/ush+a2U1NAT77WFJycHCy5Z8ep1cpDGSU8if6Itf9YwP5E6H2PYNIMfT/h5Q1JBHs=@vger.kernel.org
X-Gm-Message-State: AFuF++l0FHd1slfkEblb/9fUWzS0Do8vRw9/C8EoETSEaI+Bk/hLuJiA
	cR1j4fom80pkESVQIk1Z5YL/DMTBeazsMj5pXAZVixD/Jr+ySo/Aih1/
X-Gm-Gg: AYBFou1RtCzlNCHRg9FnvcddkBUcqQFvCBxaIl+twGCxj9NRtGFdiwfnvKlZczgcFat
	oQeLeN8mjhAyq57HWqIu1j0qoyLOj2p07HY7lVcHXSHRRhQ6F/XlCiLdEEPp8FQmywTwpx28tfp
	9NjEJ2MTImPFxlBOfBsdhQ1RJtypi49tV9eJswhlAe5EIEdqtwt7LG2a4YHACyFfmdTueiqyNWv
	gFRAEzEmjHgvvyaEEIGuNcnzLzoMnyFXvknycCoyP3JUbK+hlcj/CTtAElFpH1HgYuYBaX75sUF
	XhkKg8aFxbT7AcefANv2rEIEFumn2vgY0grJCqRx6g6KWnOR/xsHmhlGhYD9RUItdHPmWzhrwci
	hw9UEG+HmETWOrqLq8bRW2RAcjZfCu/TQmWMo7309erRNoFmb4hvmXWPjFsow1peTOD8Xl235gt
	q9V4TQaXyCNv1WM0CC61A0eW+B8RtWST3G88jU40+CE7sud1O2JWFLHWLc5wNOFMuyhAw/x2TZ9
	Omac3EI0CLTauU7IzqOhr639CGpxdU=
X-Received: by 2002:a05:7300:fb10:b0:32c:5754:97e8 with SMTP id 5a478bee46e88-34270ac3a45mr2183384eec.13.1790406143522;
        Sat, 26 Sep 2026 00:02:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:22 -0700 (PDT)
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
Subject: [PATCH v4 20/55] target-info: add tl_is_64() and target_is_tl32/64 helpers
Date: Sat, 26 Sep 2026 15:00:19 +0800
Message-ID: <20260926070057.1234-21-luoyonggang@gmail.com>
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

- Add tl_is_64() using TARGET_LONG_BITS per-target and
  target_long_bits() in common builds.
- Add target_is_tl32() and target_is_tl64() for a TargetInfo.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 28 ++++++++++++++++++++++++++++
 target-info.c              | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 3bbe1d9b607..a5dcf60dd9e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -34,6 +34,34 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
+#ifdef COMPILING_PER_TARGET
+static inline bool tl_is_64(void)
+{
+    return TARGET_LONG_BITS == 64;
+}
+#else
+static inline bool tl_is_64(void)
+{
+    return target_long_bits() == 64;
+}
+#endif
+
+/**
+ * target_is_tl32:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti uses a 32-bit target long.
+ */
+bool target_is_tl32(const TargetInfo *ti);
+
+/**
+ * target_is_tl64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti uses a 64-bit target long.
+ */
+bool target_is_tl64(const TargetInfo *ti);
+
 /**
  * target_cpu_type:
  *
diff --git a/target-info.c b/target-info.c
index ad93a4b125e..1bdf3869605 100644
--- a/target-info.c
+++ b/target-info.c
@@ -76,6 +76,16 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+bool target_is_tl32(const TargetInfo *ti)
+{
+    return ti->long_bits == 32;
+}
+
+bool target_is_tl64(const TargetInfo *ti)
+{
+    return ti->long_bits == 64;
+}
+
 SysEmuTarget target_arch(void)
 {
     return target_info()->target_arch;
-- 
2.52.0.windows.1

