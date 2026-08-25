Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54D330647
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695297; cv=none; b=Sr6XiqOPlofDuIOI0Bqsfl1TP/fC9yJvp8262TOAUDMx0HN61wP6PYk+FxQYMhMhNxcMSKOlpZjdBY2rvPmyLCk6Drngo3jjPCxtlQy/D568RUyPCRgb7XOcdTSN7nWZx2G1tUO+965P0ZvJFDsBV+D09D5TQDiKpCETWYiyiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695297; c=relaxed/simple;
	bh=oBpms52GHF9vFpKEEc0AWdiX3twmpLJwnPXQVkGge1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo4rCM09DvZ+Jh9k+0k1TikSMZ3q0jWO0WLJjV+fLwNJjlXtA0qPblGYaaFaboR6B3D/zuAQrpi8/Mz6qelBNHENh7nX9xjscrbOT5CZwjfs0gtqNBJrKdfnKKYqOn3X5aAxIyx4uYTe+tBxRTB/VeImIs/nhNU/z92Lvvkqf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4xkn1US; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4xkn1US"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e041ea211so443903a91.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695295; x=1788300095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s460w70rQILNZkGK5JrrHAiBRDkOoOpVurtRqc/D0Ik=;
        b=B4xkn1USlMgy0VeiGd467Um58y0QiLHf1echIeRtgdUp3PsWbs5LEyiEQ5yoiLTf/8
         y3dfS+ylMU3woIfCn6nZjopKDslR3RGqlVTH7ObYz05EPJhrT/xgobOPvhgtqjnpj29z
         btdCBFMyugMQHCY/ST0Y45GzQjbdnfL6GJFq9+QvFZzAQugLQjEQzqtx5MiQlJGIprmB
         y5hVodqhIe1VNAc9ahLdqhW9dGJyEfflHpS92BcFCkLwvmtCdU4rbL8Vgabpd/m1smKp
         eR7sazXbm+O0b9Iv6efJoZlPRLAeEGV9o2FfD13gzLU5RBrXK4kyyO+YNhpHVq9X8k1B
         Fx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695295; x=1788300095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s460w70rQILNZkGK5JrrHAiBRDkOoOpVurtRqc/D0Ik=;
        b=LZQpjxt94WvqXpFr0o/CktC5mJjPlBAwz7MuilkIH8XTMIVhl6CrXZAeBuR+cZRZzK
         GRoLDGsvWv6bx2W2Twi8iAvYC/x1KP5rDOGdP/eBLuEl8k6c8ac6UGob9g+oGPuB6sRl
         uoC+Bq9afvv3Q0P4PSmTkULKMR4eCZhFrywOuR0OZJrs0cpcF70bPgR8UmQl+BHW5BOK
         WQXqUjOV8zN9TqO29B+eg+nBmnKJlvMtMRtay1otZuZQvNnSWCoZWLY3WN7BuHy+UFuP
         fJmh5ZfoFegG3eJbu+DNwdrD82sxm/9s1Oq8hKj3jYk4xqYAXUWxSSl+jMBtkaWLtLv1
         xjEg==
X-Forwarded-Encrypted: i=1; AHgh+RojN2wVBgFKpUtpePY91TyakNEsfhYeuyOSeYt0wHRszdOFH2GNBXjKtQDnt1iIPPAZ/EQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mWoKnFodff0IN12O7YIl4HZyVdwGxyW9kRR/8+M7YOd1WRVi7q
	+cCzERftPZS7IzOrCejKRBs7vDjCRhD3QbQXvHwD2koDGkWF19mpjlVnlbJAgbNvxvA=
X-Gm-Gg: AR+sD12OCSVu4IiMCB6yIAXQfYrat7Q3kbsOgXEB3xI9TjYg3uUksIW+/gXkUF7o/gJ
	c4LdnNi3yduZEPWW2mUMYSshwHoOxVsOGfenLDKokFmPSjdQBNchoWMJUDaAApC58tP0iusqZbi
	2hW5Bf5/Pzezf2Dm7/CFCeIUydnXrW2Un0FhGy6dcuuTTv+5XqrMZwnVurt5hL+nrWu/ulBVRVw
	R+tee6LgRIr3QMQNpHz8BFxVVcfxU8LF/2Wt+IoFZfatRvg+DpPTJhE6qrsH5u6++tJfwacKzLn
	hsBgXtSKuPvDzrG0ywFGA9vJ3WInDtW3+WQgGaIwSvYSZXn61oINyrHqKrBsWAeTQG3PRmRnlv5
	EgfTGwwKWuUxdiHeXo7RvMRDgCaq0iWX1mzA6tPXWB3yU0C+u0v0Zh3tjIOtnoEcwskSfiRormG
	3qPpdIqXTYip1aufo0qEWymOOjJx0SVLI16BBmv+aX37X3/UhTet/LTdz56rU29ylQySUhbhXY9
	6qYwjYKvWh7q6I=
X-Received: by 2002:a17:90a:d2c6:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-3966d866cc8mr4364517a91.11.1787695294977;
        Tue, 25 Aug 2026 15:01:34 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:34 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 14/24] target/arm/cpu: Don't read Realm registers
Date: Tue, 25 Aug 2026 16:00:51 -0600
Message-ID: <20260825220101.3443954-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a2b..866ed02cf2d2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -926,6 +926,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.43.0

