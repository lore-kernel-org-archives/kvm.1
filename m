Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCA2EEE65
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396305; cv=none; b=cJ2ny1qNO9DpOr+Ip6h6ikUIPr24y+iPPRbIfX66n1tx1XJ9FA21XbimCQxV3MXj+OsO6pqi6QjB9Hr+0Y7Lm7384ZH+kwil0Y+AIAkR2yK9tN4UaxTSpA3vfdEoDJNwcbYdKq+8k93NG07JnNBm+U1Y02Quxy1cczGioa3Uoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396305; c=relaxed/simple;
	bh=EKKuPRoihwMe39krmljguelzrt7F+nly/Fx8MUzOfCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfYm5kBauMaI29SCqYPcfzuOAN8FNR7m1AiAlNy2uZBRpiVQkuNTjOUgRpc8eWFXpXwYpS9VdOsK3+N4y7QWXImnAXOkUGIsdZKFOdyK5VsGcsKKZDcZVv9AGEbJGRPv7Eg2oMu1A9ELoL2J7bVnKxXlBQdpFPGQqxrqCJR5sYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=KMz1wIEg; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="KMz1wIEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782396303; x=1813932303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipssmsISmW372mPBRGoLJjZA9QWdfe8yiK5X89jAYT8=;
  b=KMz1wIEg9EZ9jYRyvo4fLtUoFJM3nPLjOoPVDZrb6vntp6BxSXmUSvOm
   1Oml4RWD5DfKTmSfd42lZnP0xPbl95Twbzn/tpmh3E6FdlTgWXSZDCeBf
   Q/U5GPDnNcNsfNp+e2rzP2qXOkGkuzaD39CEpc69Mulr0FfTH6o4LaBTj
   SfSCLee1Y61zrqaILJLfFrpTjUpfmUXY8U2cH9uiWGG0fZ0DQ+A8RqCy3
   KVHg9yk65CL8EgrUCN5wEBt6lDMTGlCXnsIEfE4BPETzYURGu9hoZAgA2
   fSLryqZf6EvsLgqV/0vjeIaBZRy+VsGybeSYFPusAd0mPWK+UgnJMdFNs
   w==;
X-CSE-ConnectionGUID: mZEAGRoJRPCruXxlK7feMA==
X-CSE-MsgGUID: w1bNPk9eTWia+PHt6qrbMw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774310400"; 
   d="scan'208";a="22287023"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 14:05:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18331]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id 2490d521-9798-4507-9a60-6b3fe67c94a8; Thu, 25 Jun 2026 14:05:01 +0000 (UTC)
X-Farcaster-Flow-ID: 2490d521-9798-4507-9a60-6b3fe67c94a8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 14:05:00 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 14:04:59 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: <andrew.jones@linux.dev>, Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 8/8] lib: parse KUT_ENV= from command line into environ
Date: Thu, 25 Jun 2026 14:04:52 +0000
Message-ID: <20260625140452.24159-1-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-9-gmazz@amazon.de>
References: <20260609140901.95727-9-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for passing environment variables via the command line.
If any argv element starts with 'KUT_ENV=', the value after the '='
is parsed as a comma-separated list of KEY=VAL pairs and fed to
setup_env().  The KUT_ENV= argument is then removed from argv so
tests do not see it as a spurious positional argument.

Example: KUT_ENV=PARAM_1=VALUE_1,PARAM_2=VALUE_2

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
Thanks for the review, Drew.

v1 -> v2:
 - Moved setup_args_env() from lib/efi.c to lib/argv.c
 - Use strncmp prefix match instead of strstr
 - Shift argv down instead of swap-with-last to preserve order
 - Drop redundant isspace check and COMMAND_LINE_SIZE cap

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




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

