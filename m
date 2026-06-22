Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7803368AB
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146477; cv=none; b=tNPW0KpuSotZLaQTbDVvr4PVxJSUB85kt37DQqy3xKTEHBtEQftvtGv1ZftI0sPWjRTp14oyNuUROtsrwoFq8zgbtYM0IgmOc6qKTLrWF7kdWNouOhd7dSmBM/Ko4KPLoIdbzF9KrYXH1hkRMIsQBIO/hS0LTKT6VJwKl8ZBN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146477; c=relaxed/simple;
	bh=YIwRaZobmSO5Ij2EElLGkVQbqzOnFPr549GTUn7jyyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THeJEf8Eau86L37wuIQXYDcDTDAdY7I336zuli+ZpSYxbXjv8u/MuGBmqE1fyDR/3awQ7dYMySHVQx6SeypzRf41Ej1seaN1S4USjl8G7m1kARZOGcLyWWoEp+yXp5wCEgT4+fS+83J2gNro+AVOzVvSCkcB2feB9imO2cDiCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+E+Trzv; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+E+Trzv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782146473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j3tsej/J8ub0vO9QVMYHBgGXQkMEwQZE63kWE8Xy0PE=;
	b=a+E+TrzvkaxJeZyUPkpEyAtpDyvvfnO7VQyDHuZKvBIhwXJCHENy3TnalYMWi4uipVOtux
	L4+MP/VHaKmI9GxX4ElWWHwHpA/mqcPhbnM6lIeLhBlX3cQhwgSco5sKWI+aKOtw4NPbSz
	H1EsqeIjzmxBgcWX2/5MMqEs/6jDLG4=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by tag
Date: Mon, 22 Jun 2026 11:41:08 -0500
Message-ID: <20260622164109.26350-1-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Import Linux commit d1db4118489f ("checkpatch: add support for
Assisted-by tag").

(I should have used AI for this, since it'd be fun to include that
tag on this tag-enabling patch, but sometimes I still do my own
homework!)

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e858261c95a8..653bec1f6ea5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -626,6 +626,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Assisted-by:|
 	To:|
 	Cc:
 )};
@@ -3073,6 +3074,15 @@ sub process {
 				}
 			}
 
+			# Assisted-by uses AGENT_NAME:MODEL_VERSION format, not email
+			if ($sign_off =~ /^Assisted-by:/i) {
+				if ($email !~ /^\S+:\S+/) {
+					WARN("BAD_SIGN_OFF",
+					     "Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format\n" . $herecurr);
+				}
+				next;
+			}
+
 			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
 			if ($suggested_email eq "") {
-- 
2.43.0

