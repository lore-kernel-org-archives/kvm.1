Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E447728E
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933159; cv=none; b=E37ACrrMORZAr0DwwKipGTy5xpeka6pcmswodyBqbJfS14tZaecfgU5WZOte0T11iEbX87+b89tC1Gwj4/NUwroC1kjfk3e+Vg7fUS1TXAxMfvL36shTpb9Zk+tbenW13LtP3begyZRsXRxdIOcCfFiYXSIv33e2mvqw2AsuOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933159; c=relaxed/simple;
	bh=ecMTvF3y9YX9wt5R/rOdU59+hWMsUmT0QbE/UEYrczY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQc+8/9LgDouDCy69iKViXXMMj2ExRHyvCDnhD5jm471wih834+tdoC9/PBw3/ATkF5ix+fhJCOhc79f30M8aV0+Fq7npAVepI7uqaMKH/4mfDLGt9+BeNW9KN11mm/xiMgAxKM4giUT+Bp94zHtzwH813p/IQU3Fpe1eLyYV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TW8caZte; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TW8caZte"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d440939efso18018217b3.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933157; x=1790537957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=TW8caZte+uentNlNiIUgcIPNJ5uG6Cc6Crp834ckEcz7g7LD9NK7GzNe9yo6YV/SU5
         yDJgHg2Yo3IMX0Y0jnXZjcKL65l8Xaha6fgt79Kb9NBkJH1GaKYd6CFTSrAN5IHXqKYS
         xedgK4h8Mvb3Wl1x4DlT9M7qnFUQ30DXSV4hLAAx+edJW+1ObpcgTYB4OUTRFq3q/ZeS
         8SZ9Y8C4+yARAFWl/0liVXdl7TmyIeo1pRgHd5qi92IbizWSEJ5QFTVgNh5DCRkBcyYQ
         dIvXOzhjRMANr0dxZReK3zhUvwV9GYenAZh+sqLeSRT24/nDM77BNXDQi4ugq0hm5daq
         gBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933157; x=1790537957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=mxSkjjfRHw30mrdzKqwi+F6VYKAj2IwAh0CPndlRHyTwt79TdBAQBM2IMAkQKnqulV
         OOMOu4l3y3G4TarPHYGPgu6A856cKlWXfVWwWXHERWfvg2Aag+LX5qFWSdy5nBs5RaiW
         OG7+/d5rLf9mUX1hmcXlU5xEzq3m0IZ5hjbNitKlQXGVBeiVpodx9TW+Sfc4JBOSg8PV
         uLPVsjxkmbj65pUPvKDjawG16nm9tKUaqGO2ppF9K7mpTtueKLpo/aSLu4DVRyFX2U6C
         HyQRViftCvix7xbPrzBBzGIsGSr8cDmwahPaSoYF9Gj8llEfl41z+Op37mkZV0ttyARv
         tkcA==
X-Forwarded-Encrypted: i=1; AKwUvBzYXBSSdDkxKfaVyBVL6qg2jba2AQStnfKxEN8JFQ/gWSxTMihvYPKb0sX0JNsWVsOBwnE=@vger.kernel.org
X-Gm-Message-State: AFuF++koeu0pd73Zg+wOt9lXVLnrbsG9Z/efFY7MLr2DNTyMeQ3nz1hB
	RpwOVAJaekV4pFrqlWSyF9CSBRF4yxMlE5Oz6q7VwRRp14zQP4h2qRMgh9Ik6v47p9I=
X-Gm-Gg: AYBFou2ImkRVxV7ywqexUScfpDi1h4LuscP66zrTQ1W0oRWCcmcz5HqcITwv33z1bvS
	RtXRaR/+C71AN+LAqS73snjVA3SubGyAidmLC/XJeHnlyl1sEJjahB/dzZ8I5jhXcMgvVr8P6n1
	c09ahDx/THB5EQcILOzg2DKMSMiTyB6IUJnsjkwOmvXWtnPeqKiGW6QTGJAAmkUI7tfipHFlyz9
	B6fOK/wKAe6u1oEM68FPM5+HXrkqPvkIpkOSsY3BOuP+w/FAxFzKvPBs9+E4T+hojQXXKn2r7NZ
	7rDWZS9K2cMyVUWfE2Q7MtdlWLyi9BruVYvoPymUs5vlIiu7l+2N+qWAXehg+rqjeCRK5kUZHC8
	8jb5k+q/dOJFfdbzQGYQMccGdoS5dCKXuxuG+F4AhY4sEpS+1Gv9Zi7DpSwXJbt7mi0CWTb2vCb
	vDUtcGMfJ36My5GmSNdEUShKTe8+mlBEjTrvwK/zs5pa7QQd7j+g0jLz/8qjxbJwqyvYOvoOMZh
	HmE2h5bBwJZeHh8RAJ/sxM0XA9xIYG7Z/6IRfSQWiCUMasIZF3cCP3+ukb2kBKsfhcYjhotK+MY
	G2lTO81x8L3DeRGRXUc=
X-Received: by 2002:a05:690c:e3cf:b0:845:ddf4:a399 with SMTP id 00721157ae682-897308f89e5mr31680887b3.11.1789933156801;
        Sun, 20 Sep 2026 12:39:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4761747asm18686667b3.30.2026.09.20.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:15 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 24/46] MAINTAINERS: Add entry for KVM Caretaker
Date: Sun, 20 Sep 2026 15:36:28 -0400
Message-ID: <20260920193650.3373435-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KERNEL VIRTUAL MACHINE CARETAKER section in MAINTAINERS covering
Caretaker headers, architecture backends, and core execution files.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23f332cfbd16..86806245041e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14296,6 +14296,17 @@ F:	tools/kvm/
 F:	tools/testing/selftests/kvm/
 F:	virt/kvm/*
 
+KERNEL VIRTUAL MACHINE CARETAKER
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	kvm@vger.kernel.org
+L:	kexec@lists.infradead.org
+S:	Maintained
+F:	arch/*/include/asm/kvm_caretaker*
+F:	arch/*/kvm/*caretaker*
+F:	arch/x86/kvm/mmu/kho.c
+F:	include/linux/kvm_caretaker.h
+F:	virt/kvm/caretaker*.c
+
 KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oupton@kernel.org>
-- 
2.55.0.1082.g2b9226bbc0-goog

