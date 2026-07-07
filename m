Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE71480DF2
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464223; cv=none; b=UaPPkUvJgza8liafRFPN5P3ZT50lRnQzGTsT6ppGy0S4K592ksmBFKk8PoDLF8HSJD+6SuKDxqnPZmEo28xbK/lbW4JeKIOvvagxRudENSxhYqUawVOt/Gv/iPPTvPqmue7KyZF9FVhFX6h4Im0eqlNz6tkCJ3+u5+elKhhOcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464223; c=relaxed/simple;
	bh=LjX1I0YLEr43vh+TGVhtKjxFltyDKtMIhxDySVzUK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj0wWeigNKDxT0SDgJ9DllqvgNvfQij3jEUG26cKYWkKeOiFWqBva/bTMHPDpgXepvwmdglP0JJhQlWfCBrZuQj3whYW8G+fljGureUpnbV2R2i8RibZmxfdIzv+yZT6GR9Nb7FFbaJjDgsomehHSNs/ZzJDQrO1DETQA0GBcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9kB8lPu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9kB8lPu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc8e87f29bso663205ad.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464221; x=1784069021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
        b=Q9kB8lPus//QxxlnPlTQEGC2ymCDyzLy6J3PmCmFkxM83iJ+q9P+AQ/cM//19/+8Rk
         YAxaVsFZSA14pvnJ6ejm7w67au8dpO1JrxC0SK02GK6jGqnd7h7SWp29Q63T1qWISaMs
         mePo2hviGscfnRDNKRoNxUT5onSlfKf6+2EbZYtoNJk8GvvmdR1V2sEiCCqfxFV8pBdG
         DfZnrsfz5USqK4tYeMLpwA2ynaV3kJBZSk1DikUIXPHPlMLpJoWTmrOjSZYEyznXeXE2
         tqWko/AVGG+ziGVr8YjCx0ZpKBaPOGCAa3SPGSafuJqARslSGrPuU4NR9ZxYgQ81IXnT
         ZNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464221; x=1784069021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
        b=UdAZwjMBSp7+BxT3XECi08k5WOdW5SkNK/GdvxSJjoalmRpr9JjMKhJAig6uZtFtnt
         0vqhAmfg6fCT6wmcFOLglzghidfA0fGkLuc+8qhe+MN94txRY9/SCRA1vyNz0Oo4h7wG
         vNlLhRdTlTryCBr6TTt6FwsXpctMdSABpqJToyT7yTqi1Wj77pMI3JC5SVYfoX+Mu4D+
         OQUmee1BNa/aSQ4PpGyBySSMYZyKINNDYT6ZccJwaIhcVW7nXW0OqgC5WtG/dvPmRg7Q
         QjLcwzQzMPeFldeJHp2shxVH+DytYwDf+6BqoGcfoFCbCzZ9fNOPBoFl+VOL3z8V9Gtj
         4jMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5M04klYhf8imeVcxwAxWeBeZVvZOm1+X1KhM68lt84sW+kcq234fgA8SgSc2vNYNao8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKF9RC3TPLAxOxa4hwHJD21MZ+fxp/fyC4SQB78FiHiFISjG4k
	gw/DyfTc/WoqdaIXMCaaTKo1hK2PZzb5FRH8qc13BIw2d9PBRFTyli8a5ed0WgD1lqM=
X-Gm-Gg: AfdE7cl9l39quh+FxuyHOrrvooyggKhDhvQbcV6d+14yT3WL8tW13DdJ6gqBFEwRDep
	z6+7Ft9lUdzrD2vLbS6v2DzUDVEgXKdUUhgmjqvphsu9Vaj57E3jH8PkJ9UNNglKkzg33gUWPe/
	IAIcBHHllY1BG6RysafaxK86nfedhW6MwZuehnm3BH936QvE0+C/ZBlwqTBBqPVt+cONjJmHNx4
	mKcwth1DIxlhdNlSdM/ZHX+2C07ycO8S0Clr3V+o9e+2ifvEDFchd/zmSNmQPSDr1DcSCBA9EpU
	sfY0qKIXXzAcUcWxp4Obf1vzcoCmO0QbD2tK3EUe4FDNrgo+0gXte7E0WGaa3H5zY8oz1r4IbNv
	yU8yBg7DP8UKKJuHYiM4Y6PO/btP79fij9J3/UnygfOAyzO1Rbzz3VAAOpgVDMhIhalSpitYwLr
	234nPBhu0d7+oQQ+9ORt8Wj4fDi7PL0LdmZnTnRZT3wjEYFSPqIw==
X-Received: by 2002:a17:902:d486:b0:2cc:7759:ffac with SMTP id d9443c01a7336-2ccbee248d5mr67274915ad.30.1783464221115;
        Tue, 07 Jul 2026 15:43:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:40 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 15/25] target/arm/cpu: Don't read Realm registers
Date: Tue,  7 Jul 2026 16:42:56 -0600
Message-ID: <20260707224306.1202330-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
index 787e4dc7ab23..7679b8758262 100644
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

