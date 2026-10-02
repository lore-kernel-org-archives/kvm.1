Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A36515992
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972453; cv=none; b=SwHr5AL/W044TPFZ5S6eqkOkTCiRbc+uLo61a1R8hHiP5Gck4p1tt44G1O84YwoWJfpscV0K2wCWWZhpde2mMhSpV4f2ncMSbgDSAtaj0tMJQd9GOti2AwluJdcSevg3WPnukMg86DLusEh/WGEqxqFxKD8RNUT8wnPdRMEELN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972453; c=relaxed/simple;
	bh=0VQULRFmMGyBBaiuesiScQ15PkEmeby3dKCDiGs4bTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4KX8ui3cdVhnk7T3Fg5gZMTGgJWD9JaouAyoEKbeUWlZq5kMX+b7X/f1Grw+Ziqefp7TA9LIXf/yzOYv6BdPMGaY7EGecjLYnuHQkl/2oGa23AZuDW9X8eu0koMDqyzglgbyhs2OMsBWaUKZT0Sd7DX+zQUUsX7B7CzhTx0XkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SbQCSNgB; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbQCSNgB"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7901f7971so763a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972451; x=1791577251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wM7DDMRNXZ6kOtLnUpES13DSbro3EyKRePerUlcAXQ4=;
        b=SbQCSNgBVESr1tDRKCMAynlrd5z7pTcIcoeN2pGfqucmAep5OGYTsBIymTBSDqyl4c
         vWPjiv3QPUZtU1evXJJERMbASBhfWFP7vpIhwgVVhvVBZucyKNGN+bnMnqwGUTzPp62S
         ohJXUgIrp3Q2hdOWpQbHeiPzsmnIndGjPoftwY7F2HFkcr9irPyirMJPjI8wUHQldSrY
         qSbF04vvayxC10VW5v08SrKgM0Ht4xfDbeHOmh/U5fXvy+jYRKsBuMhTFzkhph3RxHAA
         CUu9M/quZOHMqgWJEU+0avgJm7vNNLBboH0zJ+eyqRjZeT6UsBIAa1b4YEcwOZQytZhO
         Z1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972451; x=1791577251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wM7DDMRNXZ6kOtLnUpES13DSbro3EyKRePerUlcAXQ4=;
        b=YGe2HHQRrKk4gqz+AOLY7hVPPVZ05eL0B5OQvYuiOXYYh46/MHHD4e6TojHPyBxXZn
         Sphmu7x1TnR3VvJA2Bf9qGaebfXSlhIZETbQaGVWF03LKK0As1wME1np6uCyzP1AhFFI
         hi8IMuMx/dLXY1MX/AfyEkqZ79iu9gOVSRLqZLLNrG9Rqcy1D0NcpAiFsNmpZ3yWjjuK
         t6Ssk9yuVNcx2/HGoRqox2IMFI7hTxzeSr/XoeoNDZ5EUB4CNqSgEjUBYOi8tvM+0ryB
         ck+x0bCslYhSTePo+an292S8vLeGRe5PqfMMxehewrYuCtaA6UUalJ8FnYtmCHLcSx3x
         su3Q==
X-Forwarded-Encrypted: i=1; AKwUvByqWbcZV2IubklN2z0cFh5VkIhqISgZny2iGTsKvqnvPoskjfxzQc9FyW6Hlz7WqvE/xCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaHi1c7xcb9L/TacFZ+fL4QX431Ru7SN9bU3pXpJq/E0kMpKlt
	GYglO5cIwEpkqssw1Z4pVk1+oK6MkD7RSIJZDAEJ+BjoWBDSjqOtf0bthCLuBGQqagY=
X-Gm-Gg: AYBFou2SIL0w9xr0X54wCKfVTXNi6iGMhK/1WSrRfsts72x0lb9sWKhAk9StWHFmvIs
	vKCE5Z5OHioSpSVyzkeTW4zoA/3t/0BpF0r6mr3mPebYiFutWDFRgCRKdGwxIfURfngiFKrlrZY
	5+fa2569jrxx8Y+nb7ooIK8ywygH5aCm307SooH3tdm/LOj1F4thntCE/ePIJAomB5RLvlryrq5
	jTqeCbCWpZRZXV2CDwFBihqQoj7mKLjjTP9nJpVG1RDhwfZBa7wvhDy4c/Kgm5XzrFXgdbOT6Xm
	5AfM+X+Bu4ZfThMr/ita0EING2wvXwwQjlcOoMBwKIHS4pD/OFbEW3Fbw4ViCKaIItMTJD12FgS
	SkI2ke3h7DHg8+lS0z6zKPOgcj99RNs7A7fSwhzfrkG0+DrnTo/5gWsaHgOchJ9Pe6OTsQEoKkJ
	Jn/RScWNRxPjYsY+A8TP93Xz/jlg2yKxfeyj/AayJZd9URSTHyfgNBy94uEovL3w3KpjOWVcbRP
	Lw51E3DM4jcLC3//Goa3Rdi
X-Received: by 2002:a17:902:d2ce:b0:2dd:c100:4b77 with SMTP id d9443c01a7336-2e49b6adb4cmr32416315ad.46.1790972450919;
        Fri, 02 Oct 2026 13:20:50 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:50 -0700 (PDT)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 12/22] target/arm/cpu: Don't read Realm registers
Date: Fri,  2 Oct 2026 14:20:16 -0600
Message-ID: <20261002202026.1204110-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
index 10ac6c983189..73bbebddcdb0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -967,6 +967,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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

