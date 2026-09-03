Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE850AC0D
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464216; cv=none; b=IFAAqNt0CJWpeVBE6ngZPnI7UD1D1LrZv0qDl8DWY/c6v3go4HEw6jYvF72r1dmx0V1fIrPY/7JBZdU//zEO/jMpeOhBBoAxhAyQ8nCaoVB7Y8kTTeCh+mOqk77PvxXn0siboTa4f+hvei9xyjxawCBfB4EX/+27CGKUsX4VHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464216; c=relaxed/simple;
	bh=p9qTqknieRM0dfAFaX4sXDErKo7oeNaAQmGjJUA9Gag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGg2yrmk00s3z00woEfxaKZyZrab7+4rnL923zgttF2w8Wz44/IhxWYkmujKqjO/2aVp6aJ7kj0REoQfqucGxA4ng7oqGgub5ZqQlCKV7j3VoCStlYJMvSpgB243oVKoMOuDZTEUzlT7ig/fG/XG48UPIgK/ScdebFvULKtYA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ih6PGH8+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ih6PGH8+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so231631a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464199; x=1789068999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiMoKtfrtM+3TWwYQneleIhe2dU3Jpv/t9kAYcs0lKo=;
        b=Ih6PGH8+J+3B2LP5+CjfaSzW03B+OoJAtBZkpWMYrhdV9gmK2gFVaeybvxys9StNhp
         9UUarCfUTl3n6Uy5xl9we1uO6ks64qSkWuRSWj7w7ouPbOb/yy5/OIXjjmOl4XBBy7Vx
         JkavdVPHRgh2bQ8qrDB0FLV8ER096wsWCe6ERJgvAAoQe1YegYQyWFyrbDseoLrEoTdA
         Ifyb/Mvr4XCuU5oNnC/uR0/Jfh9AWuZyGrZEwQuyZEfBus5Rfr8njibHqZjzCHALDTNQ
         1i+NUHicsgXHD/1zIg+g7jQ0AuNOJwiTAdJ9S72wuNuHISHGCGSR0gVY5LKEMoRNP+hm
         /pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464199; x=1789068999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiMoKtfrtM+3TWwYQneleIhe2dU3Jpv/t9kAYcs0lKo=;
        b=WEAYzSU96YKOj3UjnksRuHQNPZefWre2t7cE4c9wFHgq3oCrPJ0mQ9nFE6Ve+mgauy
         MEyStpCdC9n0EwRK4is43L5wfsnzBvRCxP635ScK05OPWQAQMx1hoUh+9Adje856MpUF
         lNDupngZvZ6mvjxkhU1K44puEy/eB9fVJIUTlHdbcyNiJJ7u5OZFz6s85OFRidKxcsnk
         vQ7hQqcNHrh0+kILGfjoke40GDLiHZXpbLAzwT08htNAdhlLANB/F9Rcso+r/y9UwOfa
         a/P7ZNssIQg2VjaRJQTOozpoX5KXwVtYd4mVi8G10IJ7LFMdwRi/E/lYZITVmDWQcZwj
         fHFw==
X-Forwarded-Encrypted: i=1; AKwUvBwDSkLlzkNx30+o1OXHIMGI7LnmUbk8Gkkh+SYAatv1wiTZ1g5uBTPK6y7YkhAGM8v33us=@vger.kernel.org
X-Gm-Message-State: AFuF++khFa0cotoDuKZUK8PpE9AuBPCQeGZfsCYPUoaqxwH3+c0W9STW
	yA5VVU8fZeNgCbWHUuEfNtVTCKCHH2eDPmor0vWHu5QRn7sC8i1psgzIxs2sWlPnjio=
X-Gm-Gg: AYBFou1C5NzYCqSJUmROUhIAT634XO0juwbSFrZz/l39wpC7+OgSWqOrSBfspaJq4wg
	malut44+hOTPkd1VNavqgitxVk3/VQb+Yjon+aER9dGxAxhIjObbLQel06z4DH9Vrjd25BLkJI2
	L4b0UpjU8Kj/nI/zdraGKyBM1wHR0lmMnplQyjdmJKptVuLX1NuHq7G/9WrPieQPkAlUaFBR0FJ
	Hpux3P/eV0XM5i5Jwi0ndCmjaHjo5a3EpemDXpjfAdMKIZ7BxCB/O8BBQcQzrHUni0HpWvxBHVe
	UHv9PVjWpzQK1wRg7frNxO5YoVzAMniq2gYbGC4FXPScOj9Hgp63T/TpKaT94cjBFzlZEmnlfvT
	T8lAEuu5BR8eIuATN4m+c1ju4lrk0tXBSoNzofMWKkeUjzivyzNUUTxASDgX9fXyCHEPh6/ehG8
	Z+wvE9rN6rSQ461Fot4TDgen3mAdNDr8XtqlbyPhmmDkTRlZwQDPbQbdTnGddSu4klAZ/sXbdri
	mTs7rRmD9JOcEs=
X-Received: by 2002:a17:90b:28ce:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-39b26100cbfmr1254551a91.10.1788464198938;
        Thu, 03 Sep 2026 12:36:38 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:38 -0700 (PDT)
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
Subject: [RFC v4 14/24] target/arm/cpu: Don't read Realm registers
Date: Thu,  3 Sep 2026 13:36:01 -0600
Message-ID: <20260903193611.1058589-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index 77aa78f00e2f..51c2527d840d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -965,6 +965,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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

