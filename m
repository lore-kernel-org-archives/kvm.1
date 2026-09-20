Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4247206D
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933113; cv=none; b=nJSCLdG03rSlPmI/hvwxMK8W5/Ty968mkOjHCl+fbsyQ9jxCVBvd8KjuAvdhDS12J99qavMqP1w2yhWOYYFCYZiLIp2cXtzcIIVn5Wvupl6GG9BPQSOt1ghuYloVUbsu++2Gq3u9oW5NZASTzFDbnQNL+2CFEoxJG3RhLqcikZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933113; c=relaxed/simple;
	bh=PcZIg6mUk+b75x/WMxTq7Jg9adSsEcLtx5KRB8LICEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxmIe3ZjJnTv/7pIwV1bLlHC/iLIDh+VL+Xu0VQ3i25XQjwMhGAkXFzRaCnCN33oOGijjonE27jRBPGeO+SH07NfKpaNJE6P8k/xxwDPCXNkNXleFX8CVJlqaEsdIMN5nxdWgaCSSadzCtCr71IXcGVcN4uvcHwZaz9oqw5Ocpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iuYsaamQ; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iuYsaamQ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-67109935888so2111806d50.3
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933110; x=1790537910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wVg6Gk8z5CmekkaH13r0qzA08Wiru8yJiEs8XX/Voco=;
        b=iuYsaamQFeh8sh2oM51c7GxGMn8WhLvAvEpn7BXxefRmmkKg01fUMgIfOz5t29Qf6L
         zhts+pjZaHMoDW6mWXlF88I56Z7A3xkIj6RAUw5Kj/o2KZ3vWPLeLITY96krBaF21p6t
         DGWoF4PUnhQTR1xdJ92rkoFp39+qgsd0/uTXZhw+2LNphzBe72gT3r7B4kXToN2VmUJs
         HBu8GBk+gQjk3PhKYx8+4L01/PRob8qFBNj1XeTQK/mx14oEk6zRmajq/0ca/ApZDbBs
         F09GiVcZFKUtwA4YVQ5Nk+GimT9T/HeYNigsNJAT3IbDjZbpLwD6/9Ov9ccRYb+AlMn+
         XlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933110; x=1790537910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wVg6Gk8z5CmekkaH13r0qzA08Wiru8yJiEs8XX/Voco=;
        b=pnu9SA3BC+B8+MonrRsFUxzsBLwcauOp12AeXIQoYgPlLMqYTruEjJTpvRYYvtQupp
         n9W6XrCyKI13y0yROJasIs+kuXDkX5oejSstbShyDj2gFuMu+QwF5o31ubKu6/Xn00JH
         VRUZexP//LTd+3ByDg+gT77f5DVYzDpl6MSLiEO/Y7dlchgXg/oHtpC7q5nKRbpWO1gG
         TWKwXYi1UEiIWvfvRF2QUA4/YuiZHcSf6nDchJdD3exxCF5+xTFKOaoy5+14ztAf454/
         EAJwwxj2NxOIfG+Up6yObHp3P42dmqr3auYtzMwBsUrBGTW7kjG0Shh5JJSc1+N1L7Km
         /iGw==
X-Forwarded-Encrypted: i=1; AKwUvBwRWACT/xyqfEnsVMNK93N2FUsIQ9k6mJBAh4XvtmVALg/oy6XFPxSSufktqKE/tOEHmoE=@vger.kernel.org
X-Gm-Message-State: AFuF++kcZAZL1EpnuACS+xTzch4XbXyES7rj2cPIiVmVoPNsi8qfE0rF
	veMIMoVq1wbf0AA1zjHWuPHetGZ2fzuJFB9P8eAkuCnuyEPZxhVIzgQfZfXqWw/hr7s=
X-Gm-Gg: AYBFou3o4w4/87pogAINxyKXivJruKXBOnXQT/TkgSlnvVgvVRIiR+ZUggNijUPK5ns
	HLj/5OZrdumuZB/T0WL7hrSgn9G9Wyg/SxpZZkUBPnreLgE4W/ukZ1Sbb8qSyxIuWltqCR9JNLO
	7zjUIDPO49IRku/Ja1mhqUISZhc95ttKpaUKlOk2CTDgpPNgs3jlgtO4Kxvt4rgZrMidNCKuX2c
	WqhgFDR3N7uTka2f2mgYY9XWXG9yusHWfbN/1eB9rBtaXo6gkPIMtvavZ5hRz2P9fLGfcpg/8pn
	2PktahW3MMAzdta4ceCJtoP/I67aCCDVv3VaHVnfDakXV2o3G1KWUkpE+gBsz9HLCYwxkrILxxE
	YGouG0XDmEPnMm+txue/z5mRNdFHSAogE18laeAYmAgn8fEC/SxdhxIoQ+25widEdsbmVMNw2JJ
	fmBb2ZKxXaps2E2Zv5bCg74ammZzicWXuyevJPXyZyCR8nuDbtROOENaWwSBTxlG3eYsyi8eo+p
	D5QZ9FBzmEi0hyONYDQraI3PJx9p+0AQejPHOc172AD9MIYYeAM1M211xu5LHbABL8jwZE2GLi7
	5a3b1OT5ytW2GRYqVy8=
X-Received: by 2002:a05:690e:144f:b0:671:70d2:527e with SMTP id 956f58d0204a3-6717fd6bc1bmr2723101d50.65.1789933110380;
        Sun, 20 Sep 2026 12:38:30 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299104e3bsm2626871d50.15.2026.09.20.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:29 -0700 (PDT)
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
Subject: [RFC PATCH 16/46] liveupdate: cpu_preserve: Add sysfs interface
Date: Sun, 20 Sep 2026 15:36:20 -0400
Message-ID: <20260920193650.3373435-17-pasha.tatashin@soleen.com>
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

Expose /sys/devices/system/cpu/preserved (global cpumask of preserved
cores) and /sys/devices/system/cpu/cpuX/preserve (per-CPU preservation
attribute and file descriptor target for LUO sessions), and document
both attributes in Documentation/ABI/testing/sysfs-devices-system-cpu.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 20 ++++++++
 kernel/liveupdate/cpu_preserve.c              | 49 +++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..88ab03efd433 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -806,3 +806,23 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/preserved
+Date:		March 2026
+Contact:	Pasha Tatashin <pasha.tatashin@soleen.com>
+Description:
+		(RO) cpumask list of physical CPUs currently isolated and
+		preserved across a host kernel live update. Note the naming
+		distinction from the per-CPU /sys/devices/system/cpu/cpuX/preserve
+		attribute.
+
+What:		/sys/devices/system/cpu/cpuX/preserve
+Date:		March 2026
+Contact:	Pasha Tatashin <pasha.tatashin@soleen.com>
+Description:
+		(RO) returns 1 if cpuX is currently preserved across a host
+		kernel live update, 0 otherwise. Although read-only, this sysfs
+		node exists to be opened and passed by file descriptor to a Live
+		Update Orchestrator (LUO) session via LIVEUPDATE_SESSION_PRESERVE_FD
+		to request preservation of cpuX across kexec.
+
diff --git a/kernel/liveupdate/cpu_preserve.c b/kernel/liveupdate/cpu_preserve.c
index c5fd3a07ccb5..cc27d1624d29 100644
--- a/kernel/liveupdate/cpu_preserve.c
+++ b/kernel/liveupdate/cpu_preserve.c
@@ -606,3 +606,52 @@ static int __init cpu_preserve_early_init(void)
 	return 0;
 }
 early_initcall(cpu_preserve_early_init);
+static ssize_t preserved_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n",
+			  cpumask_pr_args(cpu_get_preserved_mask()));
+}
+static DEVICE_ATTR_RO(preserved);
+
+static ssize_t preserve_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", cpu_is_preserved(dev->id));
+}
+static DEVICE_ATTR_RO(preserve);
+
+static int __init cpu_preserve_sysfs_init(void)
+{
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+	int cpu, ret;
+
+	if (dev_root) {
+		ret = sysfs_create_file(&dev_root->kobj, &dev_attr_preserved.attr);
+		put_device(dev_root);
+		if (ret)
+			pr_warn("Failed to create cpu preserved sysfs attribute: %d\n", ret);
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+
+		if (!dev && cpu_is_preserved(cpu)) {
+			set_cpu_present(cpu, true);
+			arch_register_cpu(cpu);
+			dev = get_cpu_device(cpu);
+		}
+
+		if (dev) {
+			ret = sysfs_create_file(&dev->kobj, &dev_attr_preserve.attr);
+			if (ret)
+				pr_warn("Failed to create cpu%d preserve sysfs attribute: %d\n",
+					cpu, ret);
+		}
+
+		if (cpu_is_preserved(cpu))
+			set_cpu_present(cpu, false);
+	}
+	return 0;
+}
+late_initcall(cpu_preserve_sysfs_init);
-- 
2.55.0.1082.g2b9226bbc0-goog

