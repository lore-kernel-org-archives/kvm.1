Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510100;
	b=FMJayjPD7SfU0GI5JFAd/8aGCr+DHKxtNME2Pv1VDkJBWw7+3k6XQuXBq8sA3JZs4pdp
	 0/uKZZm82mc2fDDLbWzunkmRmp+gBQvaVg04zE1/VfooYYUAMIm/IcF6PO+qdZd411jKB
	 cq9yuj+TSr813mu3tuKZ5Npu+VhiwXIVJRzdNO6mMSZFkkK3cZd8E4wGIU2dt5rWsyA2O
	 ejMhnU2coiRKONTumt52zhxCW0364M26/GFtoxH2w0f0QVoOrqEKwqQ+xSZo5fnCGLFT+
	 g9222QuHsat4wtyOLxdEbwDhWg7UFnOeT9hiThnEn1MTPCVGWhshR7oeTWp1ke6yvMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510100;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0GmKknmvugDiaRQXp7Nr17BfuXxMnIvsveA032Bq2vQ=;
	b=MejKTmgqLqYm2S6PxO6FMeRHj1hRphXtsGjXW4aU3CTKH+O0NFdnjOUa0QFiuAODkx98
	 hKVOb2hrrANB9ICeOB+eD2STqQnROAeg4UOLUv9Y1RnSo5wHzlQ0xJzp3fOv2CBrHxS42
	 H8f03DTwHAxNEUPBNGdeXw27Xn4WVSBon9HwolASviwx/OK4QAMq8O4JdFQ/tVVPZF7Qu
	 g92ooTu4UkMBDmw49/UKyUwyIVnFUCc3GOzqwN71kJeygU8wHBC9dZRqhTFtRFuq4mWe/
	 yDT1qmZnUZVfWD82ocpqSbh4VwU+ObilNe40y1WyLNA2YnJM1fpurpnnziGlKjQEO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=cNfePreM;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6111606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6111606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=cNfePreM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510099; x=1824046099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GmKknmvugDiaRQXp7Nr17BfuXxMnIvsveA032Bq2vQ=;
  b=cNfePreM09zN4KlLIDio/hDmxUiITb/w8FhyxdnV6zO+2uQCltYWNg6o
   x8EgeYgJpOjwI+gdBjBBRUJSl9OTdh861yqSvRG2dJCaZI04Mgfx5pV5D
   3Q5JDptaNXSgirRwUtdy0vLWXtebyRd3pDxpWXlbK58KyinZC3IX7tSc4
   H9hAR4etfL9yX4KOagUcF7hFPr0y2zTd/HIQmK+Yj1Q9//RDm2DR9SHD2
   jiWQoVQU6UrVjHdSOJHSDdiKKCcWog6uPjaZFXirqVoi6PO5SZTzet/0A
   KumUV+DEKO4LrVRYJTs3HZ+/jfU1n9OLkls1xkS/3cj16SkhcAcV8eByU
   w==;
X-CSE-ConnectionGUID: gxfuUnslRCC5iqNG/+dRKA==
X-CSE-MsgGUID: ZfaxN8cyTgiXcFav+rQi6Q==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31547495"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:28:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:28298]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525] with esmtp (Farcaster)
 id 0090aeb0-f22e-45f3-9219-fae400e9f532; Tue, 20 Oct 2026 15:28:17 +0000 (UTC)
X-Farcaster-Flow-ID: 0090aeb0-f22e-45f3-9219-fae400e9f532
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:28:16 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:28:15 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>, Andrew Jones <andrew.jones@linux.dev>
Subject: [kvm-unit-tests PATCH v2 8/8] lib: parse KUT_ENV= from command line into environ
Date: Tue, 20 Oct 2026 15:25:25 +0000
Message-ID: <20261020152525.57694-9-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020152525.57694-1-gmazz@amazon.de>
References: <20261020152525.57694-1-gmazz@amazon.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add support for passing environment variables via the command line.
If any argv element starts with 'KUT_ENV=', the value after the '='
is parsed as a comma-separated list of KEY=VAL pairs and fed to
setup_env().  The KUT_ENV= argument is then removed from argv so
tests do not see it as a spurious positional argument.

Example: KUT_ENV=PARAM_1=VALUE_1,PARAM_2=VALUE_2

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
---
 lib/argv.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/argv.c b/lib/argv.c
index fa5ff9ae..6a2b791c 100644
--- a/lib/argv.c
+++ b/lib/argv.c
@@ -27,6 +27,36 @@ static const char *skip_blanks(const char *p)
 	return p;
 }
 
+static void setup_args_env(void)
+{
+	static const char prefix[] = "KUT_ENV=";
+	char *env, *p;
+	int i, j;
+
+	for (i = 0; i < __argc; i++) {
+		if (strncmp(__argv[i], prefix, sizeof(prefix) - 1) == 0)
+			break;
+	}
+
+	if (i == __argc)
+		return;
+
+	env = __argv[i] + sizeof(prefix) - 1;
+
+	/* Shift remaining args down to preserve order. */
+	for (j = i; j < __argc - 1; j++)
+		__argv[j] = __argv[j + 1];
+	__argv[--__argc] = NULL;
+
+	/* Convert comma separators to newlines for setup_env(). */
+	for (p = env; *p; p++) {
+		if (*p == ',')
+			*p = '\n';
+	}
+
+	setup_env(env, p - env);
+}
+
 void __setup_args(void)
 {
 	const char *args = __args;
@@ -39,6 +69,8 @@ void __setup_args(void)
 		*copy_ptr++ = '\0';
 	}
 	__argc = argv - __argv;
+
+	setup_args_env();
 }
 
 void setup_args(const char *args)
@@ -130,6 +162,9 @@ void setup_env(char *env, int size)
 	bool newline = false;
 	int i = 0;
 
+	while (__environ[i])
+		i++;
+
 	while (*p)
 		++p;
 	if (p == eof)
-- 
2.47.3

