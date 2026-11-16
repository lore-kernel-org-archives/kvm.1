Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817887;
	b=Pni26qwJEYLO6tu1PGW39hc6Jm2f81dOF8KQacMnRe8O3oNn8rfU0/7Czyx2decdg2Af
	 zqk+Q3WNpoIJFJ87pcTM1W0rmAG16veW5ywRrSGfc2rMlV+9+LNL7yt4gD/aFTRrT/8Bo
	 pJN8llc1mAAZ4BhBMzDGVWCwz3194KoNPB7DCJAfOlk+jOx9VLZaZ+ZhK/UFdWG8EvWw5
	 iC+Ly/yYkFtJo/DsFa5HIz/9eT/+DyM6J7NPbfSiFmLvI9mrLK/tj53PxB1NDhJErEsqZ
	 KaRKkzfEj7JMIUcIlZFabXuKrQ8yBsX1pLFplD7LMkdnG8r1eIsKzBrGCRLpS4x2ZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
	b=WbAkgmYWurVTWRjKsMNaZja1fmNEwZ82fnFmVskDDZICRcw2DlbL1QNfFabu3xkgiSGK
	 HiLMEpaPKiruZV4CpDWb5/8loVdFRzMki2Lpj+O1weN4UxfJJbcFSmic+TK+KMcdKXIPF
	 5yyDBCIxplT7X3rJ2QnOIaWAK0xwLV4UfieDbCrzcpJroQw9kSf7UQLRpt6xDFpe86iY9
	 wYPawlFLQviJpnwsIbzfhIic5cwhUC9TLCBCmj3JHw86rT+WM4Cmh5w+d448edHtz7CMh
	 I9/Ws67CTet+CWFnqkzp1BZ/LdwHP9C7Zy1gdLgnEpkIPVbQ1mq0Usv07o8E9JSDqwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkOdX4Tm;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE1606A32C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEDE1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkOdX4Tm
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso3087149b3a.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794817886; x=1795422686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
        b=tkOdX4Tmwyc4qkBlUp5Hpo+tCWxHrHnPoNbkKquiipC7/wiPk0WkUAHnbfasOAJGtM
         ELVRAznM05ZCsx7C48qY2drzYNCmzLTiRiA1K36Gu7MOfGKrT5JzPULb9Y0ptgc9J5QH
         gyVqEos182DP6MveGK7ZARTy317xs39ZqoLb4i+gXwdbaBft15VlzCloyxHfvl8Htyrd
         +KOQHowu+P21jve7oMAgqIMXFEfKqv3boZRVcDpnPKEcHLah6MJZ6Ltky/J9LdezW05C
         CGgjQumcwS8UJeX+jH0HRUoYhWnoMY3uQ4Cr6lOoIkzRzB7ORP5s3AzOBwzRPn8egL8o
         X38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817886; x=1795422686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
        b=YylxdNnUSQL3Mc/dXH4ZhRZOZ8jidWsdTKQxHkfNpVyGvnO/2K5hiIUIgD1/h4kO2i
         b+dBS3fQbxSmpXqcXTqLyy4GSq0vcHkJlHkhRhrsPwJxl2TLdyl1HCCrj2c3DzTW/urZ
         OdQ0AyJsWIoQ0em2n9Prt7W7eqzRVRhpsPj+CtsunnUuNOqI7CDlkgNQlkHc9YLRODhy
         JRYZmJtIyYrJZ0DfEUUjtGiS3BYh6giOWlOaes4bptRJRjRWRbaNNtbN8Pf1cThcQJKT
         qJxQsmN5IBVdh471rsIiZwAGZHfr734ly8xwsH67VxcBrch2vNusgX+gQwzpLYPGlqDj
         nlDQ==
X-Gm-Message-State: APuU4Z8dzmGCd565dG4GV3nOwdlTe+yfac+Vp4F8+aaAh/4QbcuLZlkE
	CdOYpRESg+xSMVbNa7lTSoS0Esx3JUSJ2jxIkenhh5h2cKdsXEGDJ1M8
X-Gm-Gg: AYBFou1jeLU6rqMbgKhd6SARli0QlTgVH8sqvZpjF14hFB7DeC1zN21xe2X6gXSOpTd
	Wm7tCFW9EzYsqp/shcZkmugr+c+eCGFo8ntnmU3MmmXFCw1jpFwDFMHHNFAVXPdgGEof0j5L8IA
	7IMCq7vAYISGFshptlbH632bd1gGzFbDtf+P66dgVqO/KGwFmpycov6vlXwyW9AWqL+FGeCXkMa
	iWwbC+zEvBPaeTRlh2RanR8O7C/H+g2ue5Q1yIMvu0f0+7/c5yMePxwd9JYZ4Ov9oLaRnvZzPXt
	lBWmKVgGLfAH7Jp34HMS/yX8RRMxLzBAJclJRFrghLEiQknnUhQNte6UrOBuNzxSzZxsauKe5Ry
	XyTXvoYvtESnu0dUDCkUO7accuWdwT+V4D4JBZ9W+uxcjSIUzk9IAELXpe6/y7UUgXnjsbE4yB6
	fM7/ffDXNPMjTjXXcN0KlOn0PPkgwZmLslHmVeVX/jipyVVf8jInvKXbcG57D/zzEUF7h4uccjo
	s0wAYdWK4ObmRbzzCADoggQn5GoHpd/f9pAJ80dweWdJZlQXVillFH9mS447azG5OO13eq6DE9n
	en+5uaS5DGcTO+q346uw0S5innGTWUrmQ7A2PEPK9r7gxsXm2JaANfEbItl+lNBPdAZDqCL0
X-Received: by 2002:a05:6a20:6f8f:b0:3eb:9e7e:1ebe with SMTP id adf61e73a8af0-3f7a6baa880mr9797631637.21.1794817886131;
        Mon, 16 Nov 2026 00:31:26 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2055031sm3572830b3a.39.2026.11.16.00.31.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:31:25 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 3/4] KVM: Add a module param to disable the per-VM debugfs directories
Date: Mon, 16 Nov 2026 16:31:15 +0800
Message-ID: <20261116083116.5893-4-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116083116.5893-1-flyingpeng@tencent.com>
References: <20261116083116.5893-1-flyingpeng@tencent.com>
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

Every VM gets a debugfs directory with one file per stat, plus a directory
and a few files per vCPU, i.e. ~95 entries for an 8-vCPU VM on x86.  Each
entry costs a dentry and an inode, and the stats files duplicate the
binary stats.

Add kvm.per_vm_debugfs (default on) so that these directories can be
skipped.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 virt/kvm/kvm_main.c                             | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42ff19defe16..c1e0f6bf4c24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3211,6 +3211,13 @@ Kernel parameters
 			If the value is 0 (the default), KVM will pick a period based
 			on the ratio, such that a page is zapped after 1 hour on average.
 
+	kvm.per_vm_debugfs=
+			[KVM] Create a debugfs directory for each VM and vCPU,
+			containing per-VM stats and architecture specific
+			debug files.  Global stats in debugfs and binary stats
+			are not affected.
+			Default is Y (on).
+
 	kvm-{amd,intel}.enable_mediated_pmu=[KVM,AMD,INTEL]
 			If enabled, KVM will provide a mediated virtual PMU,
 			instead of the default perf-based virtual PMU (if
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fff19e9239d2..54a2924f9b92 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,6 +104,14 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+/*
+ * Create a debugfs directory for every VM and vCPU.  The per-VM stats files
+ * duplicate the binary stats, and each file costs a dentry and an inode, which
+ * adds up when running many VMs.
+ */
+static bool __ro_after_init per_vm_debugfs = true;
+module_param(per_vm_debugfs, bool, 0444);
+
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 bool __ro_after_init gmem_in_place_conversion = false;
 module_param(gmem_in_place_conversion, bool, 0444);
@@ -1024,7 +1032,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	int kvm_debugfs_num_entries = kvm_vm_stats_header.num_desc +
 				      kvm_vcpu_stats_header.num_desc;
 
-	if (!debugfs_initialized())
+	if (!debugfs_initialized() || !per_vm_debugfs)
 		return 0;
 
 	snprintf(dir_name, sizeof(dir_name), "%d-%s", task_pid_nr(current), fdname);
@@ -4235,7 +4243,7 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	struct dentry *debugfs_dentry;
 	char dir_name[ITOA_MAX_LEN * 2];
 
-	if (!debugfs_initialized())
+	if (!debugfs_initialized() || !per_vm_debugfs)
 		return;
 
 	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
-- 
2.43.7

