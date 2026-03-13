Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03988296BD1
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378536; cv=none; b=QOdoyMs5AicNtxvQ34WXVNkr5Uxc/N9sxVkHazoYOOzkg7Tl2aqcC67wrKEqht+iCl2tO1aU4XyT+iL83NWb3cEoTaz+YPePi9/eCGnSuuNAyc+THnbu7d7oeo0aA9dZ3qQenZIieeHqWXw2i6ptIHxybqyC6zLzHyg7B6m6iMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378536; c=relaxed/simple;
	bh=XdzEIz3YR0wQAcAs/0znB6uMWn49w7bvpP05ncwtB8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8CmTt+DPs7QsMR1ovoPUvRIomigoBFWYx06XUAdEyIUZcHIX4alu4GRHm8nL5Ccau6T8LoS7TjuPf2zynfSAAoXLXs/czbe2LXIUB/bDfXfMQSjVouFcbAwgUJpJIE4o8vNRCRUbJNrhgC34W0a/rV06KlyuQUwcJqt21sCPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vpxc/VI8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpxc/VI8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c738d327336so1081262a12.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 22:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773378534; x=1773983334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xafO+FHn/tcABOfSsYiI8MAh86pKbUb1BqbY4MczeRI=;
        b=Vpxc/VI8nKt+q+vg/ijNtmNbFMyqM7uw5r8itbCNtCsL4B7kQuwqSGpAlqqCXBUZaq
         85WYm4nXMGxQxiWncXD9su5eKtJEwr5j1Y/rRYah3s42IV0Kj4jhti29qLPZm7ss7Hkp
         ei5vuTWxUaFSCB0OKb8KR3X6+4tdr7gaVXDURNrahrF1XFgI9EYdcxp1ZN68DhjMKKUP
         WIFTuE9u15IdDjmwrgbxcHy1QPIco73vYI7qcp2GyO6NB0GaIv9dkOnqTHfXUyrAYgrr
         WeD1qNP7sibQmE1E0plmOlG27jsAAoP6s3Xy5JX0F3s/Jj5k3DO1tE1Clm3lFbddsr66
         63ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773378534; x=1773983334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xafO+FHn/tcABOfSsYiI8MAh86pKbUb1BqbY4MczeRI=;
        b=iqR0t7rSbNzZqr9sMSEDjj6s3sYt+03uAO6q+s0YYBnNuycZHh4pXodi6zvxigGjMK
         lbgBVpAW9ZIgPGejFkrvaYDSw8R7ksIE45L+oKn3o8lOKMUWrVwIFyk3/qq7ZoN3QSr2
         l1vj4gJFGsUPC+1XhySAkz4wAQ0ZznhNAsucTDMGol0Bn23GWbJzGEhmvZ73+Rl/bHe1
         33wXEYIjIW5ttrt2bkpI2G11jISf5xX5IRI+HAkoEYx5pZBQ+0KNv1V8ocW7ehnDnyVf
         z7J7XvdnRXo0QwpA7FhOXl7g5D+gA18UIASX7rCYCtqGUagAeOijJOiCu9sS77yfir8K
         oDzA==
X-Forwarded-Encrypted: i=1; AJvYcCW1XA3QXpZ09nxujZ5EU99p6J/kmxpK2Dn5ZonItcpLs5herv7XrOGV8NT86Y2t2FOKkJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzna0HJDHwMtDd0UrYmAgInQ++gO25xfRvafDkriX4cuZ/SwvFD
	sethXLxdG/rhEQ24NAhPyy+6QHjnaC2Zbvkh8K/Qf39EmL12/x9/5JnY
X-Gm-Gg: ATEYQzweWFYyMvvszESMNW5/5crKL5amQ5jUdLTWIQTXmh9kBgLtyewm+lpXviUecZq
	sY41YyztyZYXhcAjcB1/BgPqW7rdXUoYE/mZ0+ryYasksk4ZjVWnkg3I+o31IfVkRiVkRBRe1y3
	gzVftGTcQkF+otvHmYpQLDnidoozvNlDOV3PeOrGmu2spoJjmjTS7ygnd9DjiTpOCMCNWy0q1XW
	6pCWXesuWrqGTdqFyLa0VGA5jRMJmGOj8x7Za3fhIUtrgxhWvwZ01Dc3AAu32Gl5D+/baYwMocQ
	iiEg4l9aDbr35EL261Am74KvttcRzFK5Xxz+84ljmZCqP2B3kGCO/u2wl0g9sKsvrSgDezWBE9n
	5Ld9Pwdzn1p9HUQ6Wo8o+5zkg3jImxnKkQwboJVjuYrjQ6I/p79eT9svPcKS5fVqNqOCcRBOixu
	KUk/Ue2cu+vE8gA9yl22wBCjVzRxmszmuWqGN4X8HrZW3KO4xBN6OZev56DpqVMjaCBe8C
X-Received: by 2002:a05:6a21:6190:b0:398:8766:4d0a with SMTP id adf61e73a8af0-398eca9db12mr1654088637.19.1773378534287;
        Thu, 12 Mar 2026 22:08:54 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network. [103.95.112.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97a1d7sm676221a12.6.2026.03.12.22.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:08:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	opensbi@lists.infradead.org
Subject: [kvm-unit-tests PATCH 2/2] riscv: dbtr: Add initial API corner case / error handling tests
Date: Fri, 13 Mar 2026 15:08:31 +1000
Message-ID: <20260313050831.4016944-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313050831.4016944-1-npiggin@gmail.com>
References: <20260313050831.4016944-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI DBTR specification has quite detailed API requirements
that are easy to get wrong. This implements the beginning of
testing some corner cases, not with trigger behaviour but with
API behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
These tests expose a bunch of major and minor errors in OpenSBI
handling, for which I will post patches to the opensbi list. As
well as possibly a bug in the SBI spec, reported here.

https://github.com/riscv-non-isa/riscv-sbi-doc/issues/257

Thanks,
Nick
---
---
 riscv/sbi-dbtr.c | 314 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 314 insertions(+)

diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
index 489242b0..156b743b 100644
--- a/riscv/sbi-dbtr.c
+++ b/riscv/sbi-dbtr.c
@@ -423,6 +423,318 @@ static enum McontrolType dbtr_test_type(unsigned long *num_trig)
 	return SBI_DBTR_TDATA1_TYPE_NONE;
 }
 
+static struct sbiret dbtr_test_api(unsigned long trig_max)
+{
+	/* + 1 so overflow can be tested */
+	static struct sbi_dbtr_shmem_entry shmem[RV_MAX_TRIGGERS + 1] = {};
+	static unsigned long test[RV_MAX_TRIGGERS + 1];
+	unsigned long tdata1;
+	unsigned long trig_type;
+	struct sbiret ret;
+	int i;
+
+	/*
+	 * This set of tests is to test API response, not hardware/trigger
+	 * behaviour, which is left to later tests.
+	 *
+	 * Notably absent from these API tests at the moment are:
+	 * - Enable/disable tests.
+	 * - trig_state verification.
+	 * - Testing more valid and invalid tdata1/2/3 values.
+	 */
+
+	trig_type = dbtr_test_type(&trig_max);
+	tdata1 = gen_tdata1(trig_type, VALUE_LOAD | VALUE_STORE, MODE_S);
+
+	/* + 1, so overflow can be tested */
+	memset(shmem, 0, sizeof(shmem));
+	for (i = 0; i < RV_MAX_TRIGGERS + 1; i++) {
+		shmem[i].data.tdata1 = tdata1;
+		shmem[i].data.tdata2 = (unsigned long)&test[i];
+	}
+
+	report_prefix_push("api");
+
+	report_prefix_push("no_shmem");
+	ret = sbi_debug_read_triggers(0, 0);
+	sbiret_report_error(&ret, SBI_ERR_NO_SHMEM, "sbi_debug_read_triggers");
+	report(ret.value == 0, "read return value");
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_NO_SHMEM, "sbi_debug_install_triggers");
+	report(ret.value == 0, "install return value");
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_NO_SHMEM, "sbi_debug_update_triggers");
+	report(ret.value == 0, "update return value");
+	report_prefix_pop();
+
+	report_prefix_push("shmem");
+	ret = sbi_debug_set_shmem_raw(1, 0, 0);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_set_shmem unaligned");
+	ret = sbi_debug_set_shmem_raw(0, -1, 0);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_ADDRESS, "sbi_debug_set_shmem bad address");
+	ret = sbi_debug_set_shmem(shmem);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem");
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers");
+	ret = sbi_debug_set_shmem_raw(-1, -1, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem unset");
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_ERR_NO_SHMEM, "sbi_debug_read_triggers");
+	report_prefix_pop();
+
+	ret = sbi_debug_set_shmem(shmem);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem");
+
+	report_prefix_push("read triggers");
+	ret = sbi_debug_read_triggers(0, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers 0, 0");
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers 0, 1");
+	ret = sbi_debug_read_triggers(trig_max - 1, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers trig_max - 1, 0");
+	ret = sbi_debug_read_triggers(trig_max - 1, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers trig_max - 1, 1");
+	ret = sbi_debug_read_triggers(trig_max, 0);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_read_triggers trig_max, 0");
+	ret = sbi_debug_read_triggers(trig_max, 1);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_read_triggers trig_max, 1");
+	ret = sbi_debug_read_triggers(0, trig_max);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers 0, trig_max");
+	ret = sbi_debug_read_triggers(1, trig_max);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_read_triggers 1, trig_max");
+	ret = sbi_debug_read_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers 1");
+	ret = sbi_debug_read_triggers(0, trig_max);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_read_triggers trig_max");
+	report_prefix_pop();
+
+	report_prefix_push("install triggers");
+	ret = sbi_debug_install_triggers(0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 0");
+	ret = sbi_debug_install_triggers(trig_max + 1);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_install_triggers 0");
+
+	shmem[0].data.tdata1 = gen_tdata1(trig_type, VALUE_LOAD, MODE_M);
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_install_triggers 1 invalid");
+	report(ret.value == 0, "error index 0");
+	shmem[0].data.tdata1 = tdata1;
+
+	if (trig_max > 1) {
+		shmem[1].data.tdata1 = gen_tdata1(trig_type, VALUE_LOAD, MODE_M);
+		ret = sbi_debug_install_triggers(2);
+		sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_install_triggers 2 invalid");
+		report(ret.value == 1, "error index 1");
+		shmem[1].data.tdata1 = tdata1;
+	}
+
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+	report(shmem[0].data.tstate == 0, "install index 0");
+	ret = sbi_debug_install_triggers(trig_max);
+	sbiret_report_error(&ret, SBI_ERR_FAILURE, "sbi_debug_install_triggers trig_max");
+	report(ret.value == trig_max - 1, "error index trig_max - 1");
+	if (trig_max > 1) {
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[0].data.tstate == 1, "install index 1");
+
+		ret = sbi_debug_uninstall_triggers(0, 1);
+		if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1")) {
+			report_prefix_pop();
+			goto out;
+		}
+
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[0].data.tstate == 0, "install index 0");
+
+		ret = sbi_debug_uninstall_triggers(1, 1);
+		if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 1 1")) {
+			report_prefix_pop();
+			goto out;
+		}
+	}
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1")) {
+		report_prefix_pop();
+		goto out;
+	}
+
+	ret = sbi_debug_install_triggers(trig_max);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers trig_max");
+	ret = sbi_debug_uninstall_triggers(0, (1UL << trig_max) - 1);
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 (1ULL << trig_max) - 1")) {
+		report_prefix_pop();
+		goto out;
+	}
+
+	/* Try to detect overrun by looking at the return value */
+	report_prefix_push("overrun");
+	shmem[trig_max].data.tdata1 = gen_tdata1(trig_type, VALUE_LOAD | VALUE_STORE, MODE_M);
+	ret = sbi_debug_install_triggers(trig_max + 1);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_install_triggers trig_max");
+	report(ret.value == 0, "value overrun check");
+	shmem[trig_max].data.tdata1 = tdata1; /* restore valid */
+	report_prefix_pop();
+
+	report_prefix_pop();
+
+	report_prefix_push("update triggers");
+	ret = sbi_debug_update_triggers(0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers 0");
+	ret = sbi_debug_update_triggers(trig_max + 1);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_update_triggers 0");
+
+	shmem[0].data.tstate = 0;
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_FAILURE, "sbi_debug_update_triggers 1 not mapped");
+	report(ret.value == 0, "error index 0");
+
+	shmem[0].data.tstate = trig_max;
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_update_triggers 1 idx == trig_max");
+	report(ret.value == 0, "error index 0");
+
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+
+	shmem[0].data.tstate = 0;
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers 1");
+
+	/* Update 2 both with same index */
+	shmem[1].data.tstate = 0;
+	ret = sbi_debug_update_triggers(2);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers 2");
+
+	shmem[0].data.tstate = 1;
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_FAILURE, "sbi_debug_update_triggers 1 not mapped");
+	report(ret.value == 0, "error index 0");
+
+	shmem[0].data.tstate = 0;
+	shmem[1].data.tstate = 1;
+	ret = sbi_debug_update_triggers(2);
+	sbiret_report_error(&ret, SBI_ERR_FAILURE, "sbi_debug_update_triggers 2 not mapped");
+	report(ret.value == 1, "error index 1");
+
+	shmem[0].data.tstate = 0;
+	shmem[0].data.tdata1 = gen_tdata1(trig_type, VALUE_LOAD, MODE_M);
+	ret = sbi_debug_update_triggers(1);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_update_triggers 1 invalid");
+	report(ret.value == 0, "error index 0");
+	shmem[0].data.tdata1 = tdata1;
+	if (trig_max > 1) {
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[0].data.tstate == 1, "install index 1");
+
+		shmem[0].data.tstate = 1;
+		ret = sbi_debug_update_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers 1");
+
+		shmem[0].data.tstate = 0;
+		shmem[1].data.tstate = 1;
+		ret = sbi_debug_update_triggers(2);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_update_triggers 2");
+
+		ret = sbi_debug_uninstall_triggers(1, 1);
+		if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 1 1")) {
+			report_prefix_pop();
+			goto out;
+		}
+	}
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1")) {
+		report_prefix_pop();
+		goto out;
+	}
+
+	/* Try to detect overrun by looking at the return value */
+	report_prefix_push("overrun");
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers trig_max");
+
+	for (i = 0; i <= trig_max; i++)
+		shmem[trig_max].data.tstate = 0;
+	shmem[trig_max].data.tdata1 = gen_tdata1(trig_type, VALUE_LOAD | VALUE_STORE, MODE_M);
+	ret = sbi_debug_update_triggers(trig_max + 1);
+	sbiret_report_error(&ret, SBI_ERR_BAD_RANGE, "sbi_debug_install_triggers trig_max");
+	report(ret.value == 0, "value overrun check");
+	shmem[trig_max].data.tdata1 = tdata1; /* restore valid */
+
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	if (!sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1")) {
+		report_prefix_pop();
+		goto out;
+	}
+	report_prefix_pop();
+
+	report_prefix_pop();
+
+	report_prefix_push("uninstall triggers");
+	ret = sbi_debug_uninstall_triggers(0, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 0");
+	ret = sbi_debug_uninstall_triggers(trig_max, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers trig_max 0");
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_uninstall_triggers 0 1");
+	ret = sbi_debug_uninstall_triggers(trig_max, 1);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_uninstall_triggers trig_max 1");
+	ret = sbi_debug_install_triggers(1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+	report(shmem[0].data.tstate == 0, "install index 0");
+	ret = sbi_debug_uninstall_triggers(0, 2);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_uninstall_triggers 0 2");
+	ret = sbi_debug_uninstall_triggers(0, 3);
+	sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_uninstall_triggers 0 3");
+	ret = sbi_debug_uninstall_triggers(0, 1);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1");
+	if (trig_max > 1) {
+		ret = sbi_debug_install_triggers(2);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 2");
+		report(shmem[0].data.tstate == 0, "install index 0");
+		report(shmem[1].data.tstate == 1, "install index 1");
+		ret = sbi_debug_uninstall_triggers(0, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1");
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[0].data.tstate == 0, "install index 0");
+		ret = sbi_debug_uninstall_triggers(1, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 1 1");
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[1].data.tstate == 1, "install index 1");
+		ret = sbi_debug_uninstall_triggers(0, 2);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 2");
+		ret = sbi_debug_install_triggers(1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 1");
+		report(shmem[1].data.tstate == 1, "install index 1");
+		ret = sbi_debug_uninstall_triggers(0, 3);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 3");
+		ret = sbi_debug_install_triggers(2);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_install_triggers 2");
+		report(shmem[0].data.tstate == 0, "install index 0");
+		report(shmem[1].data.tstate == 1, "install index 1");
+		ret = sbi_debug_uninstall_triggers(1, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 1 1");
+		ret = sbi_debug_uninstall_triggers(0, 3);
+		sbiret_report_error(&ret, SBI_ERR_INVALID_PARAM, "sbi_debug_uninstall_triggers 0 3");
+		ret = sbi_debug_uninstall_triggers(0, 1);
+		sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers 0 1");
+	}
+	report_prefix_pop();
+
+out:
+	ret = sbi_debug_set_shmem_raw(-1, -1, 0);
+	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_set_shmem unset");
+
+	report_prefix_pop();
+
+	return ret;
+}
+
 static struct sbiret dbtr_test_store_install_uninstall(struct sbi_dbtr_shmem_entry *shmem,
 						      enum McontrolType type)
 {
@@ -838,6 +1150,8 @@ void check_dbtr(void)
 	if (!num_trigs)
 		goto exit_test;
 
+	dbtr_test_api(num_trigs);
+
 	trig_type = dbtr_test_type(&num_trigs);
 	if (trig_type == SBI_DBTR_TDATA1_TYPE_NONE)
 		goto exit_test;
-- 
2.51.0

