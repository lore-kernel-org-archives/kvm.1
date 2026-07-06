Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C137BE9C
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303964; cv=none; b=Em7hEIJ8Zb1XTkrC+NtHQ2j0sU9vzqmXuIR7OVTzmKx4J/z/SJwwB9fltDM8ztjju/o7RCO+E/rYRJ8NhZKQV0iUqsLCOVSPdXJme1Kdl/lf88FOSB0PxSNcXkFi7eKifM8Nlaz9V2Pan5k28acu7kA4XvsFksR8zRB7WLHUV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303964; c=relaxed/simple;
	bh=QAHqvy9R7O55EL8/sUBZYy1pp/iDzktOlvYcuERAmmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZKEqup1rSzhvt6MVdbDXwGTcOf2OWBFCiGGM2i1tsLTyr6DyKlqjfK7p46FX+Z7QfK61X5yFiRvFZbLlf92UWZ9/P44nn2b3/36C16B2qlIy0AqB3uKLgIYEuJhQMLkGvOU1ooYhQqSkuJ+MPsuwkUlb2QCh7eSjfj7H+o94Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ5e0vbM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ5e0vbM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845e363246aso2732314b3a.1
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783303960; x=1783908760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVL4Q3g2uFBrFhtqEHVihrv/zmgdiC+pHWdUndlTmlw=;
        b=TZ5e0vbM+lgFoqg7EvAoQGj8BRBwjfWnENkwT7mmHWu/kbdyn49Rx6inG27I/Pd98u
         l5NKva+hQMyKtN450aCTA7L4JOWhw22gAJB5IDAqeMsm6eKdpXfBr+i/+MfPxQYkPIdb
         J7sNmX/m0IA5TC+vZ3ECOqoNqwoz9dvRGv9c5BddthO6GnXYRviyiJElEfmNFRd6FT2k
         +qZTgWqyeSXQNnoZuyTWf8LJy9ZzTpOiQpgHug+4t//7hfWFfVb0gTX45qMBpDbKLA7n
         D1aFryujX/aQcQOuPhEjdzWn3GQhur3tHxkfXJ6hGFLOa1GNMkIp4xUHGh9C/SU1ZgZ2
         lDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783303960; x=1783908760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVL4Q3g2uFBrFhtqEHVihrv/zmgdiC+pHWdUndlTmlw=;
        b=HvkK1PLJZ9djxi3uHncdW7bsGlsshU/jZAqVLEN54Ho8yGwxfNnwuQShored/njhnJ
         WFqwRwnFJolzV3L+v5lHxmWFszjmhGMj4Q49Gx6CBG3wjkfqJc6AMlz0LWdXtHVWcWiP
         aXCO2bRB8RdUqgS0F/y8JENsozGBsm6O2OBJ5arIOskPL9rvVTpRP91yyZIWJDwWi99V
         ko6Tlenw+5E1waJpLswERXkCw2Yyh04tI/sVGkzayXYptza2UdlxCoTMcKLwBqXnYsGB
         Bj5yyGQ4t6V5YuuE2brVlqX64O5gArcgAlXd9E19r/cm2vN9DLSnT3O8wDBs6keMq3RV
         /fPA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2Zl1DCOBiW4qJRxg57MAcTbOMMFlf+irQ9u8BxX69g3Iom5C7Q5OF+Rcn1advOtW438A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQ5vuxN0PTmNas3SO9fcHxk7dd1I5dAvz+ntErIEMO4XpS9RG
	ggpj+nNLnUp5xoIU85ik2yrOfY6viudtIXwJMD0GhKi+worQcAqQ9I8F
X-Gm-Gg: AfdE7cnPNrySa3UTjSYOPskreU/GmbdSZFKYCQL6zxkn//8uw/VgFuF7IriEVEpKIM1
	UAxr4tz0zAyuN9kbWPPv7pzysARRBL9SEHNAxWOkyMWJnyb6ZmX7OCy9pdFXx0spx+gaCcA1lgI
	8bd2S2LWOOnARS2APzZxAPJdxkfMdRiSWJMWHrwhSiHds0eYTowrsUS3hW6Vpzgmvx1jEH+GOUK
	5V4wLz9LJNZjEoDXwCW/ZvTOeEkLIOYoTYLQEt3LpKX5bme3qpomfOm4f21xuxGmKzOuAAXeK5q
	Avv2RyJMStyJCz3V0LNyKgPeZaJrQRaaYGs0Oxhm+RcCQS+0wzFALchEwv0CmWZJzJE59sFaqee
	o8gMt4hDfU6oY+oeYGvcmidk5Ay6kAICjZvobQHZagM0DaQ+GL+Wa1U5zf0cMUZgG
X-Received: by 2002:a05:6a00:2d99:b0:847:871a:94ca with SMTP id d2e1a72fcca58-847f6f3d63cmr7231493b3a.41.1783303960374;
        Sun, 05 Jul 2026 19:12:40 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4dbdesm2835970b3a.31.2026.07.05.19.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:12:40 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 3/3] RISC-V: KVM: Reset the SBI extension when disable it
Date: Mon,  6 Jul 2026 10:11:52 +0800
Message-ID: <20260706021154.210289-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706021154.210289-1-inochiama@gmail.com>
References: <20260706021154.210289-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI extension validation callback can only fix the parameter if
the extension is enabled. However, if the extension is disabled after
modifty some parameters, the state of the extension is still broken.

Reset the extension when the extenion is disabled so it can have
a clear context.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index b737e9a7a12a..3eb7b7c57059 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -221,6 +221,7 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
 	const struct kvm_riscv_sbi_extension_entry *sext;
+	const struct kvm_vcpu_sbi_extension *ext;
 
 	if (reg_val != 1 && reg_val != 0)
 		return -EINVAL;
@@ -229,6 +230,15 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
 	if (!sext || scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE)
 		return -ENOENT;
 
+	ext = sext->ext_ptr;
+
+	if (!reg_val && scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
+		if (ext->reset) {
+			ext->reset(vcpu);
+			vcpu->arch.csr_dirty = true;
+		}
+	}
+
 	scontext->ext_status[sext->ext_idx] = (reg_val) ?
 			KVM_RISCV_SBI_EXT_STATUS_ENABLED :
 			KVM_RISCV_SBI_EXT_STATUS_DISABLED;
-- 
2.55.0

