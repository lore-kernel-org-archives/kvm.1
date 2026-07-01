Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561036308F
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871705; cv=none; b=SPy6a9ulsD/ZCLS5hEsdHJO+ACjowRRVC1/o9PEnlnBHgl10KKhllTfJUP5Nh2tO7NDbsacax2iYshfF9EE+VtWDneeQ11uT8L+lYE/ed8i0dRFShTODXQJq+69FSP2s9Jzco7UtuFw7iDkLulJ/Q3kmuqahuIxzHMY3wdDOV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871705; c=relaxed/simple;
	bh=BtT0ls6YmM9d9nGGoTkQaPA0Kw5pw1Vw17vs5G6vw7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQHjnbP6Xj1g6iOr+ovbqY2FOacTA6qaTZ36vxtIK24pCl2ki5hVFFStOribg5oOpeDgMrRzdbD2QLxpaUqdJ7KiLaE4JxDRP51gmKjed3Kd6KytEpRlbX2xGKzx295Ptlfk5o+sgAmx+VavJmcbecdM3+wyJltViRVxl1IT3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOxObx1I; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOxObx1I"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so73359a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871703; x=1783476503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=oOxObx1IwmAeo6A640R/DEGWf2M54gAZOxeDNhjR3wYLjq0RfIfKrKG7DotzPo4kEm
         NLx0bnwnGKlugNIR1UIUb/KdpE24rn/iXFFSr0/A7tPkq2KGrWN0eUDeo1FM45Pir7H8
         8Tw9U72WL3sv1IEEG4/Z9LJR5t2MfzaZ5ckmqRpZzPUh0ZJs06A30vh2hcwZAiC2KEYn
         gTgpxeLP/9vqtnbbyqLXl8Hn2azDDQTbz+kt2MAx6UbD6t9SsaLPslksyH3S1I96mCgS
         V8pYZJHZGzfK9D4IjH+FcvR7vX6h0KWFRGHRI3xIXESOmNlHMcNZU4OXDE5bmj5uCiFV
         pPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871703; x=1783476503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=WLbDhAwJ65yIDtAnsjoPU9YmrGyHYG16kQW3OF02zzmcH9WfwtMMr8uHfRX0XnvsIg
         bZ8PWvTziPjt9pu3R0bnFIyKfUI7Or2KAXT/dglskkbIYLZfbLa0lplczh8afwf5YqsL
         ifadviQSSbPl+MOJkqLK4+DmRwdRwSAVyNo92BSAZheTEfcbytlAwNrc7/avhAMccHe1
         wRezl6JwLRefBYUxiSotWdNb8OY65zr2CwwJCLPxd3Am0bM460Hfy+4A9oMHY3oF4iIL
         wqlsP2LxX7N8j+nAhs2Wd9R6DEytAxzHtGGXeaVhFtJc3z60NK54HQubuCzeEnKzB+B0
         wp2A==
X-Forwarded-Encrypted: i=1; AHgh+RotMR0jCMVEFCxCMqNRLmc8CIZ9iooUlg+eDUxlIz3FI/93G9ogAGfjq9TdEXruuZwrOlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCudFdZl09sPMLS7m5blPiH8z5sZxil+2M8Ls5DblHSgl5lZ3
	TZKSxNT5cJmDotcaK95b9ZqV+gnzeAHcDg9OxHG8dvJLr84smqiY9x3j
X-Gm-Gg: AfdE7clY03iyEvwF8msXe4rwKZnOfzfZBlB3S9Xp9lcBY6DiOo89DKwL7W14/NffXBs
	LrgqNxt7PMbQjHYSVJqUeq/mKhzO+5abJXe3kNW8fMQUwx5G83+kjG+gjKNzautGkCuPlQF4DRt
	kIcw+KLznbQWmeQTdKjC26cY8vH2vFX5Ush24VHpfwSHLQ6eMkAdyxLoeRyizLnHLXbgnao4tYJ
	UHLWFKj+0SaD6AXcOKuWidaIfZD/+xOEIF4PEA3j75umkCkpPxWgxJbuR+p5RqZ9acf6gmuNLFd
	MVT0tjM3jiVlmdCtnjYz8w/xcir69GkMC7ia5qpZ3T0vv+JKvNBg7khCmpOhkQI5/FNJghfeGl6
	K7r6+WRnWYa2I/l5QzGbW8oL+niweciuz8sh+QAZyNHmVIjsfDfs60zPcQ76a/LXvr29eyroDKs
	mCfUbDknZ9dXS0AIXcc7n5oA==
X-Received: by 2002:a17:90b:4e8e:b0:37f:9cdf:f03d with SMTP id 98e67ed59e1d1-380527f7932mr4841362a91.32.1782871703409;
        Tue, 30 Jun 2026 19:08:23 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d2a0f0sm865257a91.3.2026.06.30.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:23 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v4 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
Date: Wed,  1 Jul 2026 10:07:40 +0800
Message-ID: <20260701020746.170157-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701020746.170157-1-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension array to allow KVM userspace to
detect and enable Zicfiss/Zicfilp extensions for Guest/VM.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/isa.c              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 7bbea8812d92..a27de850fa4c 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCLSD,
 	KVM_RISCV_ISA_EXT_ZILSD,
 	KVM_RISCV_ISA_EXT_ZALASR,
+	KVM_RISCV_ISA_EXT_ZICFILP,
+	KVM_RISCV_ISA_EXT_ZICFISS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index 1132d909cc25..9852a91fdecc 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICBOP),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICCRSE),
+	KVM_ISA_EXT_ARR(ZICFILP),
+	KVM_ISA_EXT_ARR(ZICFISS),
 	KVM_ISA_EXT_ARR(ZICNTR),
 	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
-- 
2.55.0

