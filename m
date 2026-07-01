Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72943F5BE3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899291; cv=none; b=oa8js2tct16PsQMhpShla/atxtkSOSIurHT0A/USA5PJtWdswL+N636supMXucCmZ+ZiQ1bXl67YbXJAefDWDVxk5GmbBPge3l0cIij8fw/ucq1LPHXOaeVF18G+kllXoUMY0yJlABKwFmhbIWsWVttifQ517szFU/J6sxUWofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899291; c=relaxed/simple;
	bh=QAHqvy9R7O55EL8/sUBZYy1pp/iDzktOlvYcuERAmmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rja+jOC/owiAvKnZfnGt+jPqQ/Z4/WSwWI6lMPQNLTFoREtAwTMWoyq94Itq9B3x2JbIT69XJU0wFbEliPfdYML8sjFI1H2yEmOzoKzjqx9cVEiYAuVHKlslhuhVfE0OElTcJzZwUtXhcm1uJOwJJ3BEAjF56Rotp9mO0HKXCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qais1FDz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qais1FDz"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9254669d0cso244553a12.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899288; x=1783504088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVL4Q3g2uFBrFhtqEHVihrv/zmgdiC+pHWdUndlTmlw=;
        b=Qais1FDz9/lJFaoN61xhCGSlVDfLj3O5QQINNbMQXr1L1wwsNDXAxdFZNT+u3LyAxS
         5BOA0Sybx62KZxi7PUvkhYLGsSyvwADzBelrE8Dc/P4LGuNgAhfnBHo5LFlU6Xy5q+m1
         Jefut49XswC+6hnXr0bP1skem8lMabnn8TL6qoz1Io7gId73wnIqKIxMkeFYQWKMIFvF
         GsDS08d9ayz99Pik9DyZsux9pyoYtwtXv0YTkP6GvgF2y0QSgN/tkOxmQCK+qIejPo75
         GbqgFquJk3lHBGi+FcbT+FIOj08R6DGpTB4MihOM8K/bjC2SJwhetT/dkCm8aLgVpd5X
         Jljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899288; x=1783504088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVL4Q3g2uFBrFhtqEHVihrv/zmgdiC+pHWdUndlTmlw=;
        b=ohJQ1KaTF3DHia7iRdPu7eiEIKS5BhL3VPod0A7ou50g8mf/kbfDeum8UhasQuNc6B
         V71xddFZFZ0iYE5J8veWTeyqbYHhQ9bOSQXO6tNpZ4eaC3gy/8umeAK2cXUudJwZfp1/
         OEpwjlKATSWA/kqEb9QFo+wzEqwW6cGhElCV9Ew17YAZbEiOGrdmB3IJO9YXb8rH2l6Q
         rQAbLNiKSa4F/MYThWOk3dsYjdmQm5yWtL6frsVt/lgtXVvI7AouIava9nyLe0qCeP7t
         w1QeP1ZBt12Yyppeg/ClVTLohpcHoRcKToRv5PdCrL7wn4Jgg1MOXW5ghUqH5pSO0A4P
         aGxg==
X-Forwarded-Encrypted: i=1; AHgh+RpaS8fJoNDXwnYVOEHqrE0BDTCbDFqg3UhD3eIfU+AsLt7aI4ZQNZZ7l3qW9H//BD3UkZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHyHQ0vRzb40ildO4Nb5r8mX9Yim7o2CM28ueDAuZ7PGgdIBE
	m+j6JKHuyeMb2vVQ4cur6N0diVS44GxyiJ++oma8tRbYGdhDnh1E6vjv
X-Gm-Gg: AfdE7cmmsxaPDbRQfM088NHklx5hg+D/R9ryh0yAeuTblpwq+XvwBlQUbKm+JxSwYbo
	+aNBAChHLuAkdYckV8G6n6cwy1CLM41kcoEwdVBjFi/4d1zXM+STaysoVxthfCsg1FxoKcEpCXX
	YI6S7laK0HnaR4iAYBCCArNe6RLbG/2jQz2LVpw6EDTq5MNmh7fZnt/VfzmYsLIg7MtUocBf7vb
	mJP/UhP/6BE9GrgPx+lKSdKS5GfGPkux1OSehIcKgUHi83lSR/fDdNwxiKu1KeL9nf0VOVTF42J
	vYgp93Ml2dMVYR2CqiV+CGr1X5t341PjFqjvUrleg9+EeKH4KL5NAIzZWtd7cPrYpuFtOX3Q1zP
	KgWbK7secOosfg8+vk7j11m8pE3mD6WLepaurAVj4XKzcP6/ND8w7eiOoGop1ZxYB8HwhNIyGoz
	v1DV4ElJiOeow=
X-Received: by 2002:a05:6a00:9aa:b0:847:8250:2b2b with SMTP id d2e1a72fcca58-847c51a497emr24293b3a.52.1782899288038;
        Wed, 01 Jul 2026 02:48:08 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0395a97sm3662539b3a.51.2026.07.01.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:48:07 -0700 (PDT)
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
Subject: [PATCH 3/3] RISC-V: KVM: Reset the SBI extension when disable it
Date: Wed,  1 Jul 2026 17:47:30 +0800
Message-ID: <20260701094731.1022163-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701094731.1022163-1-inochiama@gmail.com>
References: <20260701094731.1022163-1-inochiama@gmail.com>
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

