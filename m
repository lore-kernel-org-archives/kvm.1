Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEB473C7B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266825; cv=none; b=pEJ5qIJhs5ObKxoCLx0l1QS4BsWR9GgJ0gj0wYq6EclvaLlgQAYLj3tukThXTmvo5xzS4bf3OiGG9cEDRCZtJkKavU0spdzOXbc2zUs5/VdoT1iZ5Zp4R1pjxw4195+VQi9UBRyhMLGHHLYI6grXNsui5q+EAuDGxSAVTN1DDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266825; c=relaxed/simple;
	bh=LjX1I0YLEr43vh+TGVhtKjxFltyDKtMIhxDySVzUK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyjFDTtwT1RXx62HR0KvJwUHEQiDgkwRhozuQI1hTs4T6f0M8cdat5lMnMrgYcSGRI7cDMgRERwKIHBbr9oXSFczToUq6OtBfpAN47u4C9GJkAVz1QqP6BGoc1SpsMcRuSJfD0/GNeHg6E5WA1N3wB0sbYMi6Z5uuddBMvn4jJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrzOxg0p; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrzOxg0p"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383cb94f742so241070a91.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266824; x=1785871624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
        b=VrzOxg0pQmjoRok6tQY3IqS64EdQpavnJTWWlPng7j2ErBskuhaHT2slUvZT9lFgRp
         mA8+1o/7pfHI8Adrd5rHjw1m3jvouZ7ovA8TJ+kumibkBAysP2jlpm8WV4qzjGq8GLAj
         HL0K5yGWdtXWP6iZy5zrWNRjZKZmulRfQmDkV3Yt6AAli+D5+tc6T+lp9ulynK20P205
         BytYdQh1ec4Y5RHJu8aV6BS3Pm9PRefqSCcHuW+lG3YyfSmDbrA1mzDlT1o73gubAX31
         f/ZeJKwQs3Tmtuk2Nm8nSnwivNRcbzE9nm3weBYQwCIydjJC1ehUi2jPI3I1oAKrN9Bu
         Cx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266824; x=1785871624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
        b=NPLaUpWcEbnANw7GNH169cZJe7dqsC8fFQJ9HKrGAreNhDAwujsLpJZE5zjFWpGSCx
         qXz6v5fvaumtrqVReYi7M8u1wkBi94J0yqgbIlVT/9p3m2XHXibcoYpV8SfgM8f6qyx1
         9CJ+RrPWWcA+ENxWDrQzotmMAnqSItBROP22A7SxdP8mk7ecgBy7Pgd6FRR3J8uXq7a9
         +LdDxTlIZRx1WG5vDUiaf0hA2q/+WEMNAOLtTC1oC5U92P1V1AGTHzaVUbXibo3Txb95
         ep6YxOcCA+gp2iMXts5QFVyIxIu2stkf1Okc5fKhQXGXykrWG/fprJXeRYgJqyiHpjTs
         KQ2A==
X-Forwarded-Encrypted: i=1; AHgh+RpsPoVVlq4ChmS7N8dXPAIzeuWKBsOR5JQd+10uF+8ijkJOggHq8vsBNwm0bwdHC0guF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ntVNk26YGYPrnDn7klAwcGppGvQKjsFfUJAotsFVqpFDMzZR
	0CsGJFYsl1qf13ImCle2A2KOzDqqVez0+yW9pLh1DmpuLdWvBqvNhw8yyYZSXsEQIys=
X-Gm-Gg: AR+sD10AST003mBKP2MSfF9dJKQNvH+kMFlgV6iACTrErt1j1tY2rhKncPViMsBUvgM
	TEmOzDpmJUfhljN3cUt8iDUKJx0w1U5Rw56HR7cxZr9ORPS9LnThALWFIHZ0vyogx6Zd/X4/sFb
	LBupI27uD6jjkPjN3K05Yf1ukSb7ud7EuFMaVpu59Aj7XTTm1Z3E1YLchVs2dUuBqagZ4AhB2hc
	0T/I4lc2fqP/0nD60KYX80UVwkQDMxnWBduKXauO78E62lHJUgsVBhrJK9Q1Og8apxQOPborVIH
	Ff7OrIY25rDBmBQD1jxSYnFI8b2EQmEcyWOqL1TO+QCe+7f8l0GyH0UBgFFB+7WMvLHgHUKoa2F
	v2Sjy4nEWsvCcKrRoW6kBCLuB/dp0mv464NVhbdSKnILi4T3KCJdWWRr9omCvGilOrk9h0rs0Ox
	DUsKz16bS/R2kWcpyT9qdQHdAsl0kw
X-Received: by 2002:a17:90b:1645:b0:38e:6aa7:686f with SMTP id 98e67ed59e1d1-38f6a465625mr3705387a91.36.1785266823878;
        Tue, 28 Jul 2026 12:27:03 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:03 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 14/24] target/arm/cpu: Don't read Realm registers
Date: Tue, 28 Jul 2026 13:26:20 -0600
Message-ID: <20260728192630.240375-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

