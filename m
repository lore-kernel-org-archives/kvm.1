Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628F5733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406236; cv=none; b=BlZJkl+1tuPRJhkvNa5LNBF9gvPr7dh2LwxkdJVNzbgZE9ZBLYpr64+NUzsjGIcTeEt9pLIuNjBMq0MM1P9sPpxtCA4qvvGqiW8ADcFv7O69oV+y6tDwCUDpz0cqPtzD0fr6QXOI8FPv/TuFSQaLc9616M5GSaVyYk+9v1sdxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406236; c=relaxed/simple;
	bh=pqwQIg2XUbF+bLVII+9pOz9Y2UEeUX/rVKbAHD2ou48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/JXs4ZUMSYuwWe0efIs69w54c4U0AZAbE3zanZOYgnl2zgJ6+gAwVye9R4TWawVzKPld/CSdO3FvOToIWW4pMmvvQkINkMn4P261XSGDU+8PGpXs8ilsXJUHDknvkBuwkGCVGwRkA+llRSCIn4RiBv8zkeyqT1F/6BHa1mcF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ketLA5UZ; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ketLA5UZ"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3437a48f386so62874eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406234; x=1791011034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2M0WhvqFMAcnKU8D314BNttBtcbqrejLVZUCvsEr2Q=;
        b=ketLA5UZ9WiHmVIidANmtpQYFAOBld9C/p/6keSnzeAuoW8LUJ8huTrzWcvtfP8eYo
         j96+wfoZPouXD1AKHIbq1p5KXPQ6tS2pLSgtZlnSgRVGRQA15dFLLXMNEuN/y16L26WA
         y2nztDxPaV7DB/VekRLBLhrQ/0rxQMAS1yvqaT4qGL+MoZpSEkugBpSSMUGL8+PDU2LL
         59inFFNyTEfumJGSl2P0BD9Sd0EI0CyoJTBDaE4LZeOZW+vnu6+6efNPWNxn/C0hDnqo
         IAwp4SpsY0C8SZJ+ezOGiO+A0rcdZnNtGTWrLpv42/3z0GvboWvXmc0z5yaSMvym641+
         N+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406234; x=1791011034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D2M0WhvqFMAcnKU8D314BNttBtcbqrejLVZUCvsEr2Q=;
        b=mYSKjoLjrsYLgYAd+7yqOA81wzYhlE2rMOEDxul7mv7EfGiWKR8HWzKmNc5KlipgTj
         TWniMCxvh2HmOGXDjTNT8ONyxwyzTd1/CvDbmQdnFRIoG+fdnVufS4bTgm1fV1PzJuc2
         HfRVSTDKpCF97ESI6wRcIy511ube/sd0XL2/wqFkIlcGMfxv0MJOoWV69W6APtHW58VG
         oZh7QFK7LQUIm+iZfXS5L16I7a94grptuGYF/FgnMQAMZqU8zWIFUfxCY+Q0utZB639r
         djLgSLf8k/++mN2nh7oSIYbdXHFkxJIqs6jSfQZQN1qP8mHwzoiAtIRiWtajCAiDUS1c
         wNow==
X-Forwarded-Encrypted: i=1; AKwUvBza16WKU1YzghZkQCox/Qz5MyMLoGE0XSLSXY5rHgPExQ6KkVA7rXkLtGlrE+bd60y5y1c=@vger.kernel.org
X-Gm-Message-State: AFuF++nI4YINnRmhZVmATBHviAcGULfKXtQlofHFMQxiFwggcHxDuw7W
	JSc65WWnxZOe5I/5oiKdojG9QgbsTX+wYgBRkBT33M2vULlC8JSG2zdE
X-Gm-Gg: AYBFou3nw7YaVX7AYxsdl99HibCM6YfC9fvzHT+JN3ITFnRUJrIXH1Hh9ibUg/uSzac
	H91kgKjE6CwduR/ohEn+izkg8bTLyZPQjJ3Nnjrdi9eyrx3laWcWLMMBmPMUMkSy7+FMoAqKfba
	LzdnUdA49CpZ++EDYFS40by9IK4gnPuBhHjMAkont3B9rmloCuVbXH8X1xfeUnvUSogLqWfyoAF
	e12MABWyhwIJ3v/x4lme1kEExpcb2NrtFybNt/xquEA8JHV027YsseNYRTe7sQ5eJ6TeWYEPWLA
	wnWcDerxNC0OipsYGcipNqkFKEP5X5mN0Ar7mw4LC7jQTHIxTbbil6EzkCLiOnm54lEUR9aKbcj
	ftp4YsTS1LavK2D7XiFZPzMK+MnCPCaYuyPH4ZfLiV+K7AQR8h46zfptTyxaDovCEz1faEbVF9w
	2GYc38jyDJk66WoE5eis1bioIlJRB2+hezHhWGQ1mzAJkxIVqrLvkrgDeFuX3D+/Dz20NfHh7HL
	Cf2yOaDlZxpMtR4M7elh3y8IExiVQ0=
X-Received: by 2002:a05:7300:4f1c:b0:342:19b0:1c92 with SMTP id 5a478bee46e88-34273549d27mr2573139eec.35.1790406234000;
        Sat, 26 Sep 2026 00:03:54 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:53 -0700 (PDT)
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
Subject: [PATCH v4 43/55] accel/tcg: tolerate NULL target_cpu_type for -M none
Date: Sat, 26 Sep 2026 15:00:42 +0800
Message-ID: <20260926070057.1234-44-luoyonggang@gmail.com>
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

Combined qemu-system -M none keeps SYS_EMU_TARGET_NONE, so
target_cpu_type() is NULL. Skip the CPUClass lookup and leave
MTTCG off instead of crashing in tcg_init_machine().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/tcg-all.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 767e8805552..e44856f8304 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -107,8 +107,13 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
-    bool mttcg_supported = cc->tcg_ops->mttcg_supported;
+    /*
+     * Combined qemu-system -M none keeps SYS_EMU_TARGET_NONE, so
+     * target_cpu_type() is NULL. MTTCG defaults off.
+     */
+    ObjectClass *oc = object_class_by_name(target_cpu_type());
+    CPUClass *cc = oc ? CPU_CLASS(oc) : NULL;
+    bool mttcg_supported = cc && cc->tcg_ops && cc->tcg_ops->mttcg_supported;
 
     switch (s->mttcg_enabled) {
     case ON_OFF_AUTO_AUTO:
-- 
2.52.0.windows.1

