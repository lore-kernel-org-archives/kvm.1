Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437C1CEAB1
	for <kvm@vger.kernel.org>; Wed, 23 Oct 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702436; cv=none; b=LHpAQbHFVbs637yf1+zZ06UrMPIgKg7xGdsB/I9cmNjCLHgstWbqjsPsx36/dHqE5fqBufMVJLtaeaG37vOOvguQNVFD4pCFXLwCYfS1mTMJMWDiioDMbgjr64UHB/wNfcoTF7cqtM/T2hwa5RLoAfDeji5bBYzY7tWWWZHnVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702436; c=relaxed/simple;
	bh=IMpoj34+Vcu1yqoNRz8CfPnxKOMB0EbaLa7iaHTOuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozFZuSJYT4WAd35kug3zwIF3dJ40C7W33MWbyVbBt0ofO8O8J2d9aFHjYES+h079OQ/YTzf9FACAQJWx1N3JPYtl09hNFLq2w52opMEj4yzLnMmIIZeh5V/EkuuEIKYTlt7o5EclmRy/ekwnoIN/t2hoQJtEF1U/jfKS8SJW9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IbMYZxBh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IbMYZxBh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729702431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/IF9SiEEAYAkqizFMSgjGFAXz0S3XN8NxjjqJy4brgY=;
	b=IbMYZxBh7mwgifzw4b12Vcu2Bbx8rG2+CNzZrZY2Xp3s/nUOWTcJhQ8izAVeZLAQ1Edl7o
	U3476w/xWEpRtGnDsG7LFrDn1Kdm3a6GmoYmVakdXRK9jJAlyYb+8szs1dYA8A6HtcaJ8Q
	3JotoEog5wKFSb5naZtZA5Hpq7Ry/FA=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	npiggin@gmail.com
Subject: [RFC kvm-unit-tests PATCH] lib/report: Return pass/fail result from report
Date: Wed, 23 Oct 2024 18:53:48 +0200
Message-ID: <20241023165347.174745-2-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A nice pattern to use in order to try and maintain parsable reports,
but also output unexpected values, is

    if (!report(value == expected_value, "my test")) {
        report_info("failure due to unexpected value (received %d, expected %d)",
                    value, expected_value);
    }

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 lib/libcflat.h |  6 +++---
 lib/report.c   | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index eec34c3f2710..b4110b9ec91b 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -97,11 +97,11 @@ void report_prefix_pushf(const char *prefix_fmt, ...)
 extern void report_prefix_push(const char *prefix);
 extern void report_prefix_pop(void);
 extern void report_prefix_popn(int n);
-extern void report(bool pass, const char *msg_fmt, ...)
+extern bool report(bool pass, const char *msg_fmt, ...)
 		__attribute__((format(printf, 2, 3), nonnull(2)));
-extern void report_xfail(bool xfail, bool pass, const char *msg_fmt, ...)
+extern bool report_xfail(bool xfail, bool pass, const char *msg_fmt, ...)
 		__attribute__((format(printf, 3, 4), nonnull(3)));
-extern void report_kfail(bool kfail, bool pass, const char *msg_fmt, ...)
+extern bool report_kfail(bool kfail, bool pass, const char *msg_fmt, ...)
 		__attribute__((format(printf, 3, 4), nonnull(3)));
 extern void report_abort(const char *msg_fmt, ...)
 					__attribute__((format(printf, 1, 2)))
diff --git a/lib/report.c b/lib/report.c
index 0756e64e6f10..43c0102c1b0e 100644
--- a/lib/report.c
+++ b/lib/report.c
@@ -89,7 +89,7 @@ void report_prefix_popn(int n)
 	spin_unlock(&lock);
 }
 
-static void va_report(const char *msg_fmt,
+static bool va_report(const char *msg_fmt,
 		bool pass, bool xfail, bool kfail, bool skip, va_list va)
 {
 	const char *prefix = skip ? "SKIP"
@@ -114,14 +114,20 @@ static void va_report(const char *msg_fmt,
 		failures++;
 
 	spin_unlock(&lock);
+
+	return pass || xfail;
 }
 
-void report(bool pass, const char *msg_fmt, ...)
+bool report(bool pass, const char *msg_fmt, ...)
 {
 	va_list va;
+	bool ret;
+
 	va_start(va, msg_fmt);
-	va_report(msg_fmt, pass, false, false, false, va);
+	ret = va_report(msg_fmt, pass, false, false, false, va);
 	va_end(va);
+
+	return ret;
 }
 
 void report_pass(const char *msg_fmt, ...)
@@ -142,24 +148,32 @@ void report_fail(const char *msg_fmt, ...)
 	va_end(va);
 }
 
-void report_xfail(bool xfail, bool pass, const char *msg_fmt, ...)
+bool report_xfail(bool xfail, bool pass, const char *msg_fmt, ...)
 {
+	bool ret;
+
 	va_list va;
 	va_start(va, msg_fmt);
-	va_report(msg_fmt, pass, xfail, false, false, va);
+	ret = va_report(msg_fmt, pass, xfail, false, false, va);
 	va_end(va);
+
+	return ret;
 }
 
 /*
  * kfail is known failure. If kfail is true then test will succeed
  * regardless of pass.
  */
-void report_kfail(bool kfail, bool pass, const char *msg_fmt, ...)
+bool report_kfail(bool kfail, bool pass, const char *msg_fmt, ...)
 {
+	bool ret;
+
 	va_list va;
 	va_start(va, msg_fmt);
-	va_report(msg_fmt, pass, false, kfail, false, va);
+	ret = va_report(msg_fmt, pass, false, kfail, false, va);
 	va_end(va);
+
+	return ret;
 }
 
 void report_skip(const char *msg_fmt, ...)
-- 
2.47.0

