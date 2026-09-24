Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E3421231
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237419; cv=none; b=MdTubEYFxR3BCNJKcaN+k+Md23qhZ4lHMAwD9HjYyhYMt3Whcr5jdMYfPprCoMDo7tdkOe/Wa+rpUZU9w23GV5Yqwxric7H2aOk4kAzW3kTNa1vOWzArSKYKq17Flkl7WKZ3SBJR1+1UoyBLfxaWzXnR7NN7enzJip+CE02hHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237419; c=relaxed/simple;
	bh=EbRsjy+izD4FGJar3RutZAfTClGR/6Al7JWVZmKxHY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=coBR4cwHriz4gGPH02K7cYZrcmu1K/DyiTNtXq2F4u0fTUvOoZoKjc9ZWaWkLSAqrgIFjwVkfeej0C1Vi8Ib1Of2D/6YANrjRgQEZQs9cVJlB7y+mknjkqHFVinVOud6lqHbWcP3XOBfQF/pq9Oo6H/rMxFTrRy9VaVjl0eJpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PpuEfPXR; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PpuEfPXR"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso1145991c88.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790237414; x=1790842214; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qskrl8FoTONerp5XUUFpCXSU5ueWew9f+qB/NK4x0zg=;
        b=PpuEfPXRwHMTUojmCS/YioyB9usD++Z+cpeaYfwxCZsAHHUqWoPSj89EA9FtDqAThc
         lVfV5+tP4nEURQZhxX2PJOQ+1wkPVW+9gWWcxxxEN/S8y82XZaggQW+TbWAqOUmKTyn2
         kCucJkMLHgshvIqaTnQfd9CydoWFoOJR6uNvWFU/PAi46ords6/iT49g19Ug9nKgY7xt
         Yfn7eWoaVXYqIsdKds3nXrr/KRvBl0MvRmyGzoS8B31cS5XxyBqJeO5igdt+m2zxl+oX
         3jhBhE3Mwpt//x7i6VsGY6gocivU3M9GSCqLXQ8BgtH6Q4JZdDF0K0ka4r9YU8Zj6TFY
         cg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790237414; x=1790842214;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qskrl8FoTONerp5XUUFpCXSU5ueWew9f+qB/NK4x0zg=;
        b=iuxly95S+aIkXNWRPjd71XIgVp+Xh7NPyY5H2e3LFNCWON9FkuRu0spNR9W1bKDZjk
         ghRZZEmPL8ud/G5P91QURyrmXpREGdz2C3hB26Y9i9/HQkWFkmBHlVc1P75UIdo/oBH6
         gXm+EiKZ8/Fs0cx6r4LJWDHDW2a90IBbBWht1zLitG1nWbRhiK/eussjEu5dRWkpUr3c
         NTObX14ZeBf8vCQ1el4LITLS1F73ZQHx+iV8RPPHDxavcjhcM0+zfc/LqNOcfPwrZ9Yg
         gy794odO+vxDJQfMJcdSyHqSQJpM0aNBDX0dGtK/aslcMgG0SDUOm28ddSLXFw5nzBpz
         F69A==
X-Forwarded-Encrypted: i=1; AKwUvBylSlKg3QyQIWnPySsR0tLFK4ncUT+oTE4t+3O1iiD4+LhqetMs6+bMAx3cLUDlFbw3+vE=@vger.kernel.org
X-Gm-Message-State: AFuF++mGDrAjU7Ta8IaXELrECRmaP8l0J+ezBcr909tFUy/Pm2dZQ7HH
	vKOBh9R1rnLnvgGJEJn9L4HKUSAFQNaeufwAt41qOiLm1TWxc8M390KGpjk/2eLEv8ssl1HLhCU
	Hgdb8oyr5ss5OYJF7Tifzcd02qjzB5Pjo8riYBDcotUn4HztcUuxT+Q3OPfIdJFw/EH+yOADE82
	HnU/Bp11PDenAdy9/e2VEg+aGQ5UKQaQwGk/7yA05KIlRaOZe/
X-Gm-Gg: AYBFou2t4BCQ+UbH9mMirLP3I4FsfgAsbFVfHYvyhAHcYvtx/S2PsVmJ1LUOEFbcJtM
	crLBEgYw+Mjy5EmROLWZoTWStbWfKR6dymTpe0j3HpDxTjytjFMDYBVFE11nse69LF5otwAwvku
	VTOAxomgqGS/Ikx4RAgVPf7oc9zqjq7MNl92aq6VNvItXPtiN+sZ1tZe0Dwb5HOvNPwso1q7AOR
	cA3MTIhu5MXehh6imEabSqpRheBU8JzfiWejetOCf/Is7pR5LVffd85s8G1UciAlJNSNixMU42/
	YL9rMB5dX/kehFZBkYTIwnOvmIvTlTxwRf2E2GnJ4FCaDGtoQeoSiCpzw67Ffp8SxVAdNL5ocPn
	W+2AmgpD50x7x8TaeGK0yWLpB86nkEwgFQgx3mTKDYpB2szrm1auoy8or3amotpd0fiVUHOsR1n
	HaTz5+muryaAkpFR/NIYP2RMgySCX3l430GYm76yH4NB3gYxeHsVQuXmKT4/G5mqY9pzScbWOvJ
	Hx2nlJh5bAR65VAnGo=
X-Received: by 2002:a05:701b:42c5:20b0:143:298f:33b6 with SMTP id a92af1059eb24-14503fe4a39mr1479373c88.46.1790237413336;
        Thu, 24 Sep 2026 01:10:13 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9390183sm10838473c88.0.2026.09.24.01.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:10:12 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 24 Sep 2026 01:10:10 -0700
Subject: [PATCH] RISC-V: KVM: fix the Zicbo[m|z|p] block sizes in
 GET_ONE_REG
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-kvm_fix_cbosize-v1-1-e57eec1b19cb@sifive.com>
X-B4-Tracking: v=1; b=H4sIAOLatGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMT3eyy3Pi0zIr45KT84syqVF3DpDSj5JQUIwuj5CQloK6ColSgNNj
 E6FgIv7g0KSs1uQRkjFJtLQCMNJxCcwAAAA==
X-Change-ID: 20260924-kvm_fix_cbosize-1bf2cdd282cb
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 Anup Patel <anup.patel@oss.qualcomm.com>, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790237412; l=1573;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=EbRsjy+izD4FGJar3RutZAfTClGR/6Al7JWVZmKxHY4=;
 b=ktuwHwkl+sNKmTBsvPQ0ePdlIJCd1cN4B/8rlGZcLD78YaixmZ3+Sr9zf3M4Ve+OkLZfg1JZ5
 NDnGj8FH/u6AD44JXwxKm5xyMK8rr/ydh0aXz4LawdWbz5iOAe6oTgj
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

The kvm_riscv_vcpu_get_reg_config() should return the block size when
the host supports the corresponding extensions.

Fixes: 298276da73ca ("RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/vcpu_onereg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 877ba823fc74..f2b125569449 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -50,13 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
 		reg_val = vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
-		reg_val = (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : riscv_cbom_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOM)) ? riscv_cbom_block_size : 0;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
-		reg_val = (kvm_riscv_isa_check_host(ZICBOZ)) ? 0 : riscv_cboz_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOZ)) ? riscv_cboz_block_size : 0;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
-		reg_val = (kvm_riscv_isa_check_host(ZICBOP)) ? 0 : riscv_cbop_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOP)) ? riscv_cbop_block_size : 0;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
 		reg_val = vcpu->arch.mvendorid;

---
base-commit: b5060a4aa33d7d78a8c1837ab08ef0c81ea96650
change-id: 20260924-kvm_fix_cbosize-1bf2cdd282cb

