Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A446985F
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052570; cv=none; b=koAHbLC3IJnvRXUT9qY4Li38n4pOa4lkm6aBmVr2xXSjp/obda7wiHG9qesbaYtjrLfZtsMpikOiQRCti5ZbIp70Sy8G2OeNN7KmXA5dcRyeh/HSJ+9I0fCkTsVffQd4xl6W78gb3q5x1boGCV7Rz+pZUhH8yqIdKsnfZ2w4EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052570; c=relaxed/simple;
	bh=PQS+rhRuPKHawTipTzrfvIQnxbml1r89m5PT9iaRz8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWP5eIyJdmwR05J+Er+0wSdK2RVnRhsTD7tmZcdezgHhh+Kf5qP1hfipFzP+6YLDVKOkit7cAl9Ddh1DNiY0nVxSVn7xc5vgRHMA401gyzt2PZ/M3p0CHt7ZS5XjOGx0+Ie8xMmMjiXdUSmhea0pE7XNXrKMmM0fLCs1bwIunTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7yP79J7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7yP79J7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4468725a91.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052568; x=1787657368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjeuzllnPcqvxrpejMrz9/eK7KMKWWQACjRt8b0xaWE=;
        b=X7yP79J7tm2lSa3SwFW1Ttfr5xoGUNYF0OYf9LQW4lpbqYvpqw7Pu6ZVe/7u6qOSx3
         THo4EaelIRPsHWS3FKF0MGc6TI9EoIX8URS52KRuuzAE26A6m71Kk66FmzSK8auR/q9h
         rzEErzmeAv51bg1L8rKIBql6XCv8Qg3gRdNqDF7sA7XEhsZGaCbmrRMNs1O7KBipY7TV
         Gb2OMn+g5Vde5KEqg96wyQg64DMJEUAXEs7ZWOyDLj8983M0LP2PTB13QEN639KpjrMt
         QDw9RVOldz11ZyzY8MSc8BlvZXHGaPyKrFbbntRjVMvrJ9pmqotYMmKJTNcXclC24mfx
         YfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052568; x=1787657368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjeuzllnPcqvxrpejMrz9/eK7KMKWWQACjRt8b0xaWE=;
        b=XJsrxn8jzbutXry765f0PKUT6aUQ90FBcQ6joyIhzYJheNcfPTMSgmYNh6OPkdi+ut
         zYQ2wJjRfpryIzbv7olPRe4axzkDTA8g9mg800Eh6PWyQYK0kSylo8aEUxhByFv30HcI
         P0X+aWK7jwKkJQPIKCIK5iHdGCV36kdplQZi9C4s3f6/J7vlk+qvHbhrQYuZuvxr2h9F
         AnZDFDtxGtdHvhbERN9mcSpVAOT5vVR7fWeT/1xSERuJQrhcEvgSL47vtv58CY88oPaK
         OHhLVrTyg7RXGb0h+hcLzoxf3TmkexiszvZARcU/P+dUNz2Bbl3OoCesPSI+kTIPe4tD
         FCvA==
X-Forwarded-Encrypted: i=1; AHgh+RqY2xHqgTBoV9zBgSEDMWsTLxfk+RsZjCcyuWP72/GJxb+khX7pL/YzXimFtoRL4TfS+K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKwe+YJOimGyfNbaBgeZN00IjFTTRq+9kA/RXV7qAHdmTAFuN
	y9IK9AUtVRN17SuYUxgLcHqRWK7sZQB4mFamz8hPYlWs+IyJWAhJGjMWn4IHPIhAmnU=
X-Gm-Gg: AR+sD11uZeWgRayWlz1U2lku6Og8tDMT5xL1r4LtuhFdvWD8+Qky7wqzrmw7J/vCZPd
	EhcV/UtKEKS5rS2P27UweKk8OKzz6rpEx6J5Yzfs6047J6ZLMPfHeTW5Kkh0wJddis3FeMhHc9J
	peHV5xJN6tyLli4lzdbhKOWSC98Vy5Pr3Ptd3ov7yr3WD+QW+0oSuOHLAm33t1sTWZ2fCV/AeB8
	EtU3d2rl+MPmgwXR/mcaxszDvdCX4D2zDFJqQBpcT+H5rv6UM06CFqUuy3/X+Y5+g0+v5dWYpPp
	hkwB64uho1CWKL2KwCwq3Y/jqvycc4SEX9VBqJIW5Vv/HVoqZAWV3Awtr5udnAXk3YPeeRIVrHh
	pBpnCwGvHisg6QJfN/CsoEO8G5MG1WjopQGTSTTbaWiVwku1L4U0lAV0Cied/AGGfUfObpckw/K
	7pMKBw9c2R+BBUNkQqOQLWA1HzxK9uQCv4ymeRRVhquyojxyr2W5RWs8h9EqzFR11Ac7c4/AHbg
	JSUOL79ExzRm0/K
X-Received: by 2002:a17:90b:5685:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-3955a799fcdmr11206957a91.11.1787052567884;
        Tue, 18 Aug 2026 04:29:27 -0700 (PDT)
Received: from LIKEXU-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31a9dsm8423420a91.4.2026.08.18.04.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 04:29:27 -0700 (PDT)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: jiaqiyan@google.com,
	kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] KVM: selftests: arm64: Fix EINJ handling in sea_to_user
Date: Tue, 18 Aug 2026 19:29:18 +0800
Message-ID: <20260818112920.26252-2-likexu@tencent.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818112920.26252-1-likexu@tencent.com>
References: <20260818112920.26252-1-likexu@tencent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sea_to_user drives EINJ injection through popen("echo ... > file"). A
failed write is hidden behind the shell pipeline, so a botched injection
is silently ignored and the test proceeds as if a poison were placed.
Drive the debugfs interface directly so a write failure is reported
rather than swallowed.

The EINJ support probe is also unreliable. It checks the ACPI EINJ table
with access(R_OK), but reading that table needs CAP_SYS_ADMIN, so the
check gives a false negative for unprivileged runs and skips a test that
could otherwise report a real problem. Probe by opening the debugfs
injection interface instead and classify errno: absence means EINJ is
not built or firmware lacks support, EACCES/EPERM means the test is not
running as root -- both are skips -- while anything else is a genuine
failure.

The injection path is only reachable through debugfs; the kernel EINJ
driver exposes no other interface, so the test must depend on it.

Link: https://lore.kernel.org/kvm/86y0le9cvz.wl-maz@kernel.org/
Signed-off-by: Like Xu <likexu@tencent.com>
---
 .../testing/selftests/kvm/arm64/sea_to_user.c | 45 ++++++++++++++-----
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
index e96d8982c28b8..1c2a743ca8e23 100644
--- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -81,25 +81,46 @@ static u64 translate_hva_to_hpa(unsigned long hva)
 
 static void write_einj_entry(const char *einj_path, u64 val)
 {
-	char cmd[256] = {0};
-	FILE *cmdfile = NULL;
+	char buf[32];
+	int fd, len, ret;
 
-	sprintf(cmd, "echo %#lx > %s", val, einj_path);
-	cmdfile = popen(cmd, "r");
+	fd = open(einj_path, O_WRONLY);
+	if (fd < 0)
+		ksft_exit_fail_perror(einj_path);
 
-	if (pclose(cmdfile) == 0)
-		ksft_print_msg("echo %#lx > %s - done\n", val, einj_path);
-	else
-		ksft_exit_fail_perror("Failed to write EINJ entry");
+	len = snprintf(buf, sizeof(buf), "%#lx\n", val);
+	ret = write(fd, buf, len);
+	if (ret != len)
+		ksft_exit_fail_perror(einj_path);
+
+	close(fd);
+	ksft_print_msg("%#lx > %s - done\n", val, einj_path);
 }
 
 static void inject_uer(u64 hpa)
 {
-	if (access("/sys/firmware/acpi/tables/EINJ", R_OK) == -1)
-		ksft_test_result_skip("EINJ table no available in firmware");
+	int fd;
 
-	if (access(EINJ_ETYPE, R_OK | W_OK) == -1)
-		ksft_test_result_skip("EINJ module probably not loaded?");
+	/*
+	 * EINJ is exposed only through debugfs, and opening it tells us why it
+	 * is unusable far more reliably than access()-ing the ACPI EINJ table:
+	 * reading that table needs CAP_SYS_ADMIN, so access() gives a false
+	 * negative for unprivileged runs. Open the injection interface and let
+	 * errno say whether the test cannot run (skip) or genuinely failed.
+	 */
+	fd = open(EINJ_ETYPE, O_WRONLY);
+	if (fd < 0) {
+		switch (errno) {
+		case ENOENT:
+			ksft_exit_skip("need CONFIG_ACPI_APEI_EINJ and firmware EINJ support\n");
+		case EACCES:
+		case EPERM:
+			ksft_exit_skip("EINJ requires running as root\n");
+		default:
+			ksft_exit_fail_perror(EINJ_ETYPE);
+		}
+	}
+	close(fd);
 
 	write_einj_entry(EINJ_ETYPE, ERROR_TYPE_MEMORY_UER);
 	write_einj_entry(EINJ_FLAGS, MASK_MEMORY_UER);
-- 
2.50.1 (Apple Git-155)

