Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5722F8EAC
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654594; cv=none; b=baeAyFjVoIi86GDiDXANjj/v40d5m92O805gVE6OZWEsnDir8NVA+bfjRojxphGRmODPZYRGdc7VlbnyvrHV7LZ1SwLYtM2jqnAKuiahb3aktQZKNZvDS3iv4bSh5fCUEWmUrsVM1SenqawqpsyJcumxsi1euoRvLHNkbhYxsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654594; c=relaxed/simple;
	bh=wfxZIiWhDP3+oFPqhctMkZvaOYbsAemH2FvdQjYIm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycd3YDnVxHGcGhO9DEGm0ZCHZ3FsZMgv+aXcKQVpCfu7YmGyI22qg2nhre4Qq2HlbzkOnohdiQp9PpXhHbRpWBjTTOq53cBPwfA9Ym1zFsqimtxgtrrZtqnwQ957OvOjHGHhyvuAiAleTc/L+vcjUw4UZyIbh1282PUM+AWQuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhItftJA; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhItftJA"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-86a686c0fdaso901129b3a.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654591; x=1791259391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=Ls/gwXyhbPk9gTk6V00S5cS4LlxTy5Ob6l86uvwulaPwx4Cq+7vIxuJW0muHjzwAvm
         i3vFowoCXvhvaz8GxTCzQkOGIVUv7vAUcqaySUU76XgyrDZ2hVyZtNhNBHmqcaP0oPFG
         O36j444ncMlBteSQky0UWbFBy8JMBdolB1BzcEazLksVjYSna/FZD++rzCetEa7bL8qO
         YUFGwDUrz8ue/8pL9LGVIBcOXe4CMXuPYmMST3fiS2IFvK2I0kJ8vCrKdHmO60a/pj1Y
         vnbE59VIdrLLFmYhHuI4tuBJCEO3NqMbwdtJg31B8s4m2MjplWUqbT3QoPgxkbd8uibj
         f4rg==
X-Forwarded-Encrypted: i=1; AKwUvByDLjhQdm+IrPQUdiUfxrBwYyN2NBDHCT0dCpK/RhT6LLlsxqA8SZBLu2gkC1PWKfSxHf0=@vger.kernel.org
X-Gm-Message-State: AFuF++kxlL1RIRN96uQzrbTAqRBfY/osZ/Vzdx/hL7Nw3oeL5DRG+DAA
	JOCVnvMZRPSgUNAlzqiThu5eWK7WI728vEySjXcbdcfUEvUIsmHfR6cqbpuA0zdU8fdA57QN+8O
	p+lqV0IDv5sdaVFWzX8HTFF4nSrBA4QkpEzKPIr9AOWgFVdjo4a9msJUi3AG8bzcNeNyHtOJdgu
	F8z0ug93shlQAD3WQwvIv/MbgBE+d1UfYxWh9+ERV4U4GvoI+GR2qXaFcpvCS05oi03WlmcKzV1
	6Ox
X-Gm-Gg: AYBFou0bvIxbRyfXvtirHz9Mhyp++QLdFE+/e/CBgLw3emWUuXz2eAJZOUGL/iBd0ZP
	GE3VxQD77KehyY+323vg8EwC2O1+Rtj1w8HQ4w3ztagPpLQ6k7RFABsDQBxRZTdjbPsHowKDh64
	eSk+MWugEY1BOpj1xuiPvRDMUN0jnjuoufhG/9ci2XgEfXzGJSDhG10k47B8AVhKHXOmjzDlGtq
	0tcLCO5YVMgqr5x7S4uWvNd1El4Y7XBIC0gFc7bowpDgqVFrr3ZLXu2l7B7Mak4eVHObahCgh/M
	AfC/vbThujx2CMPcesgp6Tu8nvsipvjJtfaNpQJ5zme42wqy1kbDe6F4FPMFu86H1nddEINITsI
	IUMx/bmGo617d8LJV5qpIeu3Ble3NluqTCe16l2OiXjTtdwtDVUEHXNGx5Bovk6NkS6omii8ORy
	nLUaEgYxF5FPl7SuyWAInLl1D1mMKYU55G
X-Received: by 2002:a05:6a00:950f:b0:881:5918:f02b with SMTP id d2e1a72fcca58-8815918f329mr6721285b3a.24.1790654591358;
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-885f0bd8494sm27159b3a.2.2026.09.28.21.03.10
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-342217d8d53so12162277eec.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654590; x=1791259390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=fhItftJAmbd5w4nLldXjYdujimhcBno2xM358LQIK+THcQYYx0bt6TiEyG7gjmcGLR
         tDCMg3L/hdbu05TXXFgxfWQdgxGwCtTmbKr/CGmO/TOVU0FLsjPHPaN7N110tbrJWY8/
         ADsyxvJ6pEHue+JcxGxeRU2wukWIvSLNR2IHg=
X-Forwarded-Encrypted: i=1; AKwUvBxRzpr/GbAWEPVUJBjGuIIpf76xSKju4t4r6x8+/Agsb8/yK0qXbKoKbSFWl1JdzWNJK/4=@vger.kernel.org
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715277eec.14.1790654589534;
        Mon, 28 Sep 2026 21:03:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715216eec.14.1790654588762;
        Mon, 28 Sep 2026 21:03:08 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 1/6] percpu: Page-align decrypted data in UP kernels
Date: Tue, 29 Sep 2026 00:02:50 -0400
Message-ID: <20260929040256.543767-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Without SMP, DEFINE_PER_CPU_DECRYPTED() places variables in
.data..decrypted. Align both ends of that section so that changing a
variable's encryption attribute cannot expose unrelated kernel data.
Keep the section in permanent data, where UP variables are instantiated.

Fixes: 000f8870a47b ("vmlinux.lds.h: Fix placement of '.data..decrypted' section")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..64bc2bfdd2ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,10 +368,19 @@
 /*
  * .data section
  */
+#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#define DATA_DECRYPTED							\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..decrypted)						\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define DATA_DECRYPTED	*(.data..decrypted)
+#endif
+
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
-	*(.data..decrypted)						\
+	DATA_DECRYPTED							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
-- 
2.53.0

