Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5373A169D
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381823; cv=none; b=UYTvNRkH/se8d76MnjLRvp6IcpUdfH6+GwKms7NAkWBUyrfYHKD0Lk1YkXe3+XEmNcO8gVkZPC1xxTKBTY8iqLZIh4+88eDtBJBA2q6Z9fBQimZsOIDPZ3bJJNsmtxtLQ5KORHEUJW92wesQwR5G7MTnLySv31TCGxID8mIzBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381823; c=relaxed/simple;
	bh=RsjAKRrEYZCTRIS2Y5hyeh5t+5s8fBvhV87/GYsU3E8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VAM2DjzcK7Mkx1/f7EH+Q+TOu2BXpGdKj8DPLvTf2mCLLGmdoqfRAfjikykRaoBNZoZYVskBLU9bDuKxqC0mRys4pIYlKSf1ZAa6jBCUlcO6qC7vA+Z4I6IdRqWGFi7+dYkSBysHJJVBg7QWn0dNI7UGDd0lxHth05Fe4JvyoE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxkKmOGe; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxkKmOGe"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7962325ba0so176169a12.0
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381822; x=1776986622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qd/yhxMU8fzlyLqFZ1FuD00KAmIXoxNzpVPShyy4Zq4=;
        b=YxkKmOGeHBNyxLbBLyg/d1hrntuI/iib6CRg3z0mn828vMybSfm0wdKSpDhW1WGv8J
         IkLE68L3I1eCirsUvp66K9x3rNJ+V93kdXia+D55qMLa/t6nC8yqnFSIp8pTaCdWRqHA
         AO5QMpBCQpssKlWGJ9094GoLIxoQ8/XIoGfxnzz0pcFjd/CJ8bZEp0/GPkEqeKQNMQ5R
         gS+jhDAsux0whdZklGrjVir3qJT8M12Fh34KaT/cSfUzS2vSWoEir3iRpgzxHEgtdH4L
         FbhuGvFkLZtIvOVe8LqvTjf4M1oUdXEPsWTqfj6EUwLOK+n3pLtYIcUOqtjR4sMlZkSX
         6SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381822; x=1776986622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd/yhxMU8fzlyLqFZ1FuD00KAmIXoxNzpVPShyy4Zq4=;
        b=fX64IUu1TKGL/XTA9689o/47PyO0bFJpAt+r/USq+7CRzAnFidNluR4Lhj1aps7sO9
         ktop3yu0U5wZ+RINdrLLyUmbfLC5kwKTtecgmeG6tNxCarBe+6Taon56FC6xcjB/QxqG
         Gf6ikpOI57oCaY9NX/PS9FmTJ5aOtRlnGRAeh8MmCkfbdwRcQzpcTBVv55dOOi4MN5nI
         /g3ee4E4MT0pNBsWE2lKEzGHd0hCPKoofE4zAZajsVe6m7okISDtIJMdvZjrklqui2SQ
         KEFaPMSs+/aQm9bbPdMd4FD043m7WPQNFf2tGLUC0SWeq+LZVTGtRw9yzAYM6abdu+dP
         D6ng==
X-Gm-Message-State: AOJu0YwEfvaXJHDRqNBjyixioz9mf0XBUWzZndWKfPOZfFD20V4WifLL
	W4yytre09eAQAYbIOdQX+opEPGI/wGYDcMmoOdUo0tzXSu+zHohnLeuvYtxlFdIJ4BuVIDFVs5t
	kW3ZvpA==
X-Received: from pfbli8.prod.google.com ([2002:a05:6a00:7188:b0:82f:54e9:c13e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc1:b0:82c:2555:b9b2
 with SMTP id d2e1a72fcca58-82f8c7db2b1mr334223b3a.10.1776381821642; Thu, 16
 Apr 2026 16:23:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:23:24 -0700
In-Reply-To: <20260416232329.3408497-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416232329.3408497-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416232329.3408497-3-seanjc@google.com>
Subject: [PATCH v3 2/7] crypto/ccp: export firmware supported vm types
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Tycho Andersen <tycho@kernel.org>

In some configurations, the firmware does not support all VM types. The SEV
firmware has an entry in the TCB_VERSION structure referred to as the
Security Version Number in the SEV-SNP firmware specification and referred
to as the "SPL" in SEV firmware release notes. The SEV firmware release
notes say:

    On every SEV firmware release where a security mitigation has been
    added, the SNP SPL gets increased by 1. This is to let users know that
    it is important to update to this version.

The SEV firmware release that fixed CVE-2025-48514 by disabling SEV-ES
support on vulnerable platforms has this SVN increased to reflect the fix.
The SVN is platform-specific, as is the structure of TCB_VERSION.

Check CURRENT_TCB instead of REPORTED_TCB, since the firmware behaves with
the CURRENT_TCB SVN level and will reject SEV-ES VMs accordingly.

Parse the SVN, and mask off the SEV_ES supported VM type from the list of
supported types if it is above the per-platform threshold for the relevant
platforms.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 70 ++++++++++++++++++++++++++++++++++++
 include/linux/psp-sev.h      | 37 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 64fc402f58df..1e3286c048fe 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2940,3 +2940,73 @@ void sev_pci_exit(void)
 
 	sev_firmware_shutdown(sev);
 }
+
+static int get_v1_svn(struct sev_device *sev)
+{
+	struct sev_snp_tcb_version_genoa_milan *tcb;
+	struct sev_user_data_snp_status status;
+	int ret, error = 0;
+
+	mutex_lock(&sev_cmd_mutex);
+	ret = __sev_do_snp_platform_status(&status, &error);
+	mutex_unlock(&sev_cmd_mutex);
+	if (ret < 0)
+		return ret;
+
+	tcb = (struct sev_snp_tcb_version_genoa_milan *)&status
+		      .current_tcb_version;
+	return tcb->snp;
+}
+
+static int get_v2_svn(struct sev_device *sev)
+{
+	struct sev_user_data_snp_status status;
+	struct sev_snp_tcb_version_turin *tcb;
+	int ret, error = 0;
+
+	mutex_lock(&sev_cmd_mutex);
+	ret = __sev_do_snp_platform_status(&status, &error);
+	mutex_unlock(&sev_cmd_mutex);
+	if (ret < 0)
+		return ret;
+
+	tcb = (struct sev_snp_tcb_version_turin *)&status
+		      .current_tcb_version;
+	return tcb->snp;
+}
+
+static bool sev_firmware_allows_es(struct sev_device *sev)
+{
+	/* Documented in AMD-SB-3023 */
+	if (boot_cpu_has(X86_FEATURE_ZEN4) || boot_cpu_has(X86_FEATURE_ZEN3))
+		return get_v1_svn(sev) < 0x1b;
+	else if (boot_cpu_has(X86_FEATURE_ZEN5))
+		return get_v2_svn(sev) < 0x4;
+	else
+		return true;
+}
+
+int sev_firmware_supported_vm_types(void)
+{
+	int supported_vm_types = 0;
+	struct sev_device *sev;
+
+	if (!psp_master || !psp_master->sev_data)
+		return supported_vm_types;
+	sev = psp_master->sev_data;
+
+	supported_vm_types |= BIT(KVM_X86_SEV_VM);
+	supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
+
+	if (!sev->snp_initialized)
+		return supported_vm_types;
+
+	supported_vm_types |= BIT(KVM_X86_SNP_VM);
+
+	if (!sev_firmware_allows_es(sev))
+		supported_vm_types &= ~BIT(KVM_X86_SEV_ES_VM);
+
+	return supported_vm_types;
+
+}
+EXPORT_SYMBOL_FOR_MODULES(sev_firmware_supported_vm_types, "kvm-amd");
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 69ffa4b4d1fa..383a682e94fd 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -899,6 +899,42 @@ struct snp_feature_info {
 /* Feature bits in EBX */
 #define SNP_SEV_TIO_SUPPORTED			BIT(1)
 
+/**
+ * struct sev_snp_tcb_version_genoa_milan
+ *
+ * @boot_loader: SVN of PSP bootloader
+ * @tee: SVN of PSP operating system
+ * @reserved: reserved
+ * @snp: SVN of SNP firmware
+ * @microcode: Lowest current patch level of all cores
+ */
+struct sev_snp_tcb_version_genoa_milan {
+	u8 boot_loader;
+	u8 tee;
+	u8 reserved[4];
+	u8 snp;
+	u8 microcode;
+};
+
+/**
+ * struct sev_snp_tcb_version_turin
+ *
+ * @fmc: SVN of FMC firmware
+ * @boot_loader: SVN of PSP bootloader
+ * @tee: SVN of PSP operating system
+ * @snp: SVN of SNP firmware
+ * @reserved: reserved
+ * @microcode: Lowest current patch level of all cores
+ */
+struct sev_snp_tcb_version_turin {
+	u8 fmc;
+	u8 boot_loader;
+	u8 tee;
+	u8 snp;
+	u8 reserved[3];
+	u8 microcode;
+};
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
 /**
@@ -1045,6 +1081,7 @@ void snp_free_firmware_page(void *addr);
 void sev_platform_shutdown(void);
 bool sev_is_snp_ciphertext_hiding_supported(void);
 u64 sev_get_snp_policy_bits(void);
+int sev_firmware_supported_vm_types(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

