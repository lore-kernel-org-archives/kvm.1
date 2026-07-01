Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC03A48F4
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899282; cv=none; b=ougx7msRot0sjFMWn5D1XR9qBeHbIsZj2xvNFhbjBe+YLtYM6j+S3Qhn9sJ4mu2Sj8HQ6vn+dxGCLV4LfjajNwLslGFDiq/jBxvNU/ATscrevB7cS6COaRilkgh4gtPJPrRDH9YxFKGe1GsHy7P3cfQt0PTvGkyy7A7sFeZ3bE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899282; c=relaxed/simple;
	bh=ZFFJLms624ZV2SWbpS1kboihVYx6qHVmwhnLBXBq86A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFoqtm8qeScR30DrUleAQQNUVpYj5a5KTI+IUopHyrXUCcNNVyZPKO4WX3GsXyi337FwY6lTAdqJasDS0QEMltmUog69NEUxqSpwGkd8KyixtLDFhM14XvcMMm+MXEtUm6oFXR0qlaA1MiLvF+R+xOP+h8T4dpqdqPsRIEEchnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+5Yaexa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+5Yaexa"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so182911a12.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899280; x=1783504080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nRpp8Aarym9MAbA9S6grsKajHp/qT3ZkQCLbPzfeNPY=;
        b=T+5YaexajEpKbiO8hP8CXu+dsg2eJB/+N5ZeNXmCe1AaYAuI96AVrmJN6x/1DqgcJp
         gXcnV51WF92uRhhAL2QqBiBZqG7KbTWVV82ewLUF0J1r/lERbA6c3hrBWXkWDBaEBYaO
         ViraRebxtdxvWlHbBQpb7+kbVLInFBiMJa7WNlgfsmOVTC7PRzb8Ku1skqDpFbNT5V1/
         SeRm8YeL8dCOF151bDL8fD1K3XhSzOP2PW/S4Cik+8amb500daT8GvEm6k48fVag7ONn
         EDlNY+O9yiY3YDrteynbnNkfhw1CK0gx8zRMF/oq/oquWvaK7OhPjZxEPvi0HQqs1mt4
         zKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899280; x=1783504080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRpp8Aarym9MAbA9S6grsKajHp/qT3ZkQCLbPzfeNPY=;
        b=c+/gXS6f6UbSbSMUPHgGVcO84vYt3shbTFxlxdWcF1OBSlhPyppLvWCfsYtQYVZvnH
         ftR0STEGY+CeZ2Fz7FXuAkKWPjR7FZ9tNXJcuZOqW8badgkzKpN67mzZYlnT2xXwv/KD
         dxLuekBVeZiYshlBXjQ9+WPeYGaA1Um2lZTUYoyf5ru2FGOF+sJ8AeHnToBnAd2v2CSu
         uWptJLKQp1k0+w0OgqGgn2UGZdbt8hu/++CrmlkTJJOkzEwdrgjhQoz09IWfK/bDvoVU
         gNHfn44wu+xOJCFrTbMsjAt5uqvpej0UVH43Ykid4NbFzkPOaa9cy9pOqiiMjoselKOh
         MrLA==
X-Forwarded-Encrypted: i=1; AFNElJ+BE1pkTfzAF3933F36V5wY735JJ0LF8fpVF82PKKqrA7vdt2V40RsggTUbNQv0XXOo35g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNO0Ty/lU/WEAHxgq4f6e/7qwG41L+TNUeh8mD1EIoIRH74O4
	sa9xvSGZoyHGulOMPksO9ic6fKie/bDU1ikLKqFhcCgqKsPC1hYItBsB+DuEXQbE
X-Gm-Gg: AfdE7cm6+oCN1uI01jmZpW0VklksJlRzh2yXgsIhxnJKXBGY1N0MsdF7bJ+AxU4m5Ds
	SKZbW31M5ER7esL6sjINyHLSL1ohG3F6qtcntFUBPRf9hKNgMWN8DuzwuabrYEaIFT2Uqg+JQ7U
	zezg1JuEPCwIQ55auhY6rmEMONbfqAvLw2M09XLZkbmM3f1IftFIbjaYCDWTV+g3qob5Nixae21
	IcFJO0ppDQJcLqRkN3jxubVcyRsThp8sJLZFpikzzXBO1NBeFeCfRBNpY+iy9SJM7hYp0nVUbch
	CviW2JEru4zGjV2+6E87kcABklicV6gy8Qzc1M5ORCHUX82wKrKh3SBQjEGhP8h74ilScoXJ/Cd
	MaC8FipjteWdlpDQ6uLLx+cIJhH8i0GWWhUGfyp385e95jJnxrH8z5x/nXr3W6PoBQUJMyOgO+2
	Gkw0RuvDM6SCA=
X-Received: by 2002:a05:6a21:7d06:b0:3bf:6c08:2b32 with SMTP id adf61e73a8af0-3bff431786dmr33434637.58.1782899280562;
        Wed, 01 Jul 2026 02:48:00 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbc6d9ed9sm2903779a12.7.2026.07.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:48:00 -0700 (PDT)
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
Subject: [PATCH 0/3] RISC-V: KVM: Cleanup SBI extension status when disble
Date: Wed,  1 Jul 2026 17:47:27 +0800
Message-ID: <20260701094731.1022163-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM SBI FWFT extension has multiple internal state can be programmed
by the userspace. However, when the FWFT feature or the FWFT extension
is disabled, the internal state will be kept as it is, which may cause
some side effect for the vCPU, cleanup these state when a SBI extension
or FWFT feature is disabled.

Inochi Amaoto (3):
  RISC-V: KVM: Add SBI extension validate callback
  RISC-V: KVM: Add SBI FWFT validation support
  RISC-V: KVM: Reset the SBI extension when disable it

 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
 arch/riscv/kvm/vcpu_config.c          |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 33 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_fwft.c        | 25 ++++++++++++++++++++
 4 files changed, 64 insertions(+)

--
2.55.0

