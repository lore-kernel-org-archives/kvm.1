Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2014ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406126; cv=none; b=BKTtQKGNo1vZ/cfvSsIY1PHWq7Z5UFi/TT5bJJsxx7Kjzy5wkDXwi1zhZd4bYSPfUUtNHHWXq81/SbQYPL961oqeEONULAIEN/2Hz6qvPiGd+I6F4i51JZp3bXctrwP+FLFEtVjNtI8/c2o3W0q5s9vYcjXWCSoSy7cZxWM0n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406126; c=relaxed/simple;
	bh=bBhcr/U7uUCtN+ylyXjjaD9HqnXpHzWg3eLh+Irse+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8WIO1HleNMtLvOQqLIW3kkmbOQCvN3K76YKE06Vh6RrPzhoU/8z5b1D8MsU/kmb4ilEMKJH7hgMc12JYsZdtNCW3xwB4C8GMrgGpfo2/9Zfcgx6KM964HWm3+Ii9o92GM2hO2MnlIsbTqGd0VFShevUpIGTYDAQtLSRHugFfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKEDE6TH; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKEDE6TH"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7528so1430248eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406124; x=1791010924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrGKgFew7a5BWVed114GbJvRtNCR8ABRcbnE53096fw=;
        b=BKEDE6THhlOB5duifyckvGdBnXapk2CLb2dBOnMYen2IcbZIrkcc/KxieSD8IH/LRf
         2nfW2kRr6p724XhHNp/XSEjrbpMXOe+JK6UubU53MvxvEwlmx7diNiygRKnE+QkF/ykX
         1A2Xle82WjmrDciYNgT9B2QcwFBD0zTFHltepz46fq/HaIjNSOsUxkaZDGaHjVAprB63
         CVdSSwQDRod+fs1H6Zx1S6juyvCt7u4KtDIl8bvhjPzCRHQ86A1yWWMpagqruKTXeBZn
         Mfk3ecOUzNoto2n1k3wWQWVXdYyV8InH8pZVN40j3KyLaaTCmmGswnXGBMtDEohCyq0Z
         HfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406124; x=1791010924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrGKgFew7a5BWVed114GbJvRtNCR8ABRcbnE53096fw=;
        b=0fP1btkVLtxXzAZMP00e0JO93AteUAzbgOyH2AI14r++5Y2UKLp8kkC9bDzlI3W3po
         HO+FU9Xdy7W7u/5vantVWBpC0dbdnKA91TI5A/gJ3v6DEyjdD8teqZcXnmLj/5pWh0PS
         /KAeO9XonKd6hlkF40G5qxrZJmJmKJzZIRE++gROQSvg93NE2DNqJS0Kdk7X3PJ1j60Q
         SgvXGrjvpt0MoVHBkQRRV/T+3F1WZFQC/0N815uT/vgSR9UZfrn09hlJ00lk9Ep5l7+V
         V+5dgSyiYdrc0eHt4Kh8SQbIGwAQ92owHnJETTnWV1NMjafm+vBXfPUKc5nElO37b1bP
         UjbA==
X-Forwarded-Encrypted: i=1; AKwUvBwXXlvdwNRBhjqtz8eWSpzpcUIAfASoL5sXEBBiYVAndTX3kzZmaqy7CvIMAybuNK2tHIs=@vger.kernel.org
X-Gm-Message-State: AFuF++lRNWtxF1KnhYLhYk/vSIQ8sB0vKsbIz77yZFc6Hl6P3UZ0yn0f
	qPgLPC7eoNk9APIYonKJvAZEJIDSyXY3/P2C2fAw8cS8DjRHe1CPYubj
X-Gm-Gg: AYBFou3TuJ6B3jc4vFroOMBT9siMAXaePzFF7r9wdZoZnVw3Oie7sDHHKucmeMMtyI5
	ziynYgSDGQufHKMGHUy6TI3VoAmePnJZ9wAgnsqJaYxsPDJHseVuG5Gc1fGHIzc7oLTmOt0+3R3
	5avfAKnGAWuCrfBRvLGXGLtNK+ZvK4GT+LP/mHzq72WieaxrPz+TDU970cO5qJHnMv93MKaVqLA
	3UXztdGzNox5qa6KFKRKE/o965OY/fBCCCxVUakhTRELBtwOY1kKCqoRQPflsywXOs6hz5p4GcN
	4nMJMyivF/3sQDXZ418o1tDoZEVq/BJEY0GVsZzMe8ZibjOSWT27kCsgRgr0OxUYbEZeu/TJIUB
	citswaF6y1ixd9mDBkko20cChSJKaSpGf7Qn25+ctpU0CdPVRwf6FWz4BBtzc2TAc88mg6QXDp0
	Cl9AL8RL8wIl2JbrN70I42lsmTq4eh/xf/C5TMW9iabxC6/XRj41b4erpJukuTFiv1vHccHX9bQ
	afj8aGl1+uWe501fdMO9mPjl3ZKl7CtuLjVjRwhIQ==
X-Received: by 2002:a05:7301:2224:b0:341:2466:2d68 with SMTP id 5a478bee46e88-3427304d4e6mr1888482eec.38.1790406124252;
        Sat, 26 Sep 2026 00:02:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:02 -0700 (PDT)
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
Subject: [PATCH v4 15/55] target/arm: allow -cpu host with Nitro
Date: Sat, 26 Sep 2026 15:00:14 +0800
Message-ID: <20260926070057.1234-16-luoyonggang@gmail.com>
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

Register the AArch64 host CPU when CONFIG_NITRO is set, matching
the existing initfn early-return for nitro_enabled().

- Add CONFIG_NITRO to the aarch64_cpus host type guard
- Treat nitro_enabled() like the other accels in realize
- Mention Nitro in the host-CPU realize error
- Set host_cpu_probe_failed instead of asserting when only Nitro
  is compiled in and it is not selected

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu.c   | 5 +++--
 target/arm/cpu64.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 090470da40a..c138c4c0587 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1835,8 +1835,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
+        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled() &&
+            !nitro_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF, WHPX or Nitro");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1e64eb54cdc..03f3d55f6ba 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -774,7 +774,7 @@ void aarch64_host_initfn(Object *obj)
 #elif defined(CONFIG_WHPX)
     whpx_arm_set_cpu_features_from_host(cpu);
 #else
-    g_assert_not_reached();
+    cpu->host_cpu_probe_failed = true;
 #endif
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
@@ -784,7 +784,8 @@ void aarch64_host_initfn(Object *obj)
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX) || \
+    defined(CONFIG_NITRO)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
-- 
2.52.0.windows.1

