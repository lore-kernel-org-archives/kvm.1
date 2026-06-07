Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214F3612F8
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819888; cv=none; b=ASOyDdjgOFqXHljMTsFfIy3uDjIl9avNTHcySKP0CkLkIybEXja047D8wcERYQ8+YO+9jzKJZU2teDCyq4QvllYBDFGjOJskrR3+8KObjgrDfVEe5Wb/uald5tJ7yiG6BdyrJtfVw276V8D86kSgDTFrw656WPo/cyXtxw7VFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819888; c=relaxed/simple;
	bh=8fGKQM/8ZqCo43qm9SlIU3NFaWdy1/A+/assJKzlb5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyKHUz9TV4Q78MryxNP2Z7DV5A83irzmjWdLGR/4qMGtPjUK/iz4+dQrBnfjYAggHt+3Lk92WPKVP0dIQQzAfi9mPSWnGs+V3V7pPqk9LOcn0A9gyR47OEkknA/o46YFPJ6DeWwlKsRa3Zm/T/cEa12B04uNUGACESOycF/iYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kd29fMNx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd29fMNx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so3313308a91.3
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780819884; x=1781424684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXyTBTDSB4kJ/NqnyBvVuRSbwI4TemATINDoQruBQBs=;
        b=Kd29fMNxQNgGUdhoqY7aPL5jOAsGnQDTlDlT75BodjRZcK+lDSu9MBuF3gaDu5IJLG
         WP8Jlpdcexptp1/aMYAIbJjbOZDrm5Khup1fn7i8HD+EUODkX7Ga5yy8wPp5YDlkVmjF
         2FP2TMsSN7w0gyhBTTMZLVPs/B7xluCs5KU5L/n1r68z0bbbtlCC4L8oG0oc2EqXmxK3
         ezZ0wHVm7l2xikgpCmvQ35/naYwsAiTRKAkwUeRqWS5K8eb0CqoBko+Mom/uD4MjN9ua
         ifAIvjG78Uk8x97i74HqJmxrvjOVmgnh4TXXob4CVE6sZL/eOhkFYEhQF6seF3m10z96
         bJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780819884; x=1781424684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXyTBTDSB4kJ/NqnyBvVuRSbwI4TemATINDoQruBQBs=;
        b=FAAc2M02SMSJngw2TNllvWGEsmjBpe6Me5X/RmJl6aU5fMh0jcGY9qD3OMlbDMk9rJ
         zfMvRdqJZ2x6rdpFSsCpjNsQXY9/Ov0lzGHyV/w6tZBUbUbvkhfdS1pSfEyQMUy8ryQ3
         YxFKb68f0qWe7yoCz3KsIbE4UTvR/VoWvVdLVdNW8jvmvoW0EFOlbDjAJOOFojX4ZcWG
         qwFPMmLxSK9p7rPeehDATL3/orjxgdRbLacPH9tVml8QgoyVU8BnMZl+1z5tJlPQnurM
         q5AIdJmU2ZMlKwzHm2xuj6H7xdVIybA2vOITMyk2NAZnBsYHiqR782u/WcwPivjupI6n
         kiig==
X-Forwarded-Encrypted: i=1; AFNElJ/z3VMpY1Tg1xFoIHRS5K6JF1L/voQcRMrNItEXD1hwDSg956a0A8ubY6Ru26zlAhnMePk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8fDal2nFj5/7zNWj3klYQZdSnWeesk3ooXLSc9vht9RusnhG
	/hR9P8NkWJfeHso5jvypapJI+ZVPjjfFjtEEAydSdwFpprxY3edD04+7
X-Gm-Gg: Acq92OE4IvrHVBTts3W6dJ+E6Rmu55F6f/avLkAWN4CbjcSVs81DgWzXiRPS2LtHGLq
	xz9rON2AQfR+mPMzWZgEgVLyiDTb711FpITOmWZBdVZ4/G32P7kSXTsXDOfZG3PxsCJcGrMu0zl
	3gn4lGOHBhFOVb7roKaA3IsPa2sQqj0Sru3c9aehGrBoAchK0bPHoPFoBO1/WnupSNQ4RwKoXtc
	q3+w5R1aFIzKLPDfmX8IK5tJLyPg82ptS425NqE3QWvIq0bH9oXqgorljFRc3eYZPdFQDe9+o+x
	fdbIaj1QkqG//89HBLQXp6YP3r42a1FVMfNBP9xVwhbxjIgMnBFLYOa2RhEYYG/dKdhWV/iz1wn
	y+lNjo1wBQGpMoRtORCRVIYD7aDrORgYlLOxceOI/Br7l4EnAUYIjE0YEvpiJL+EcCN3H4JFulY
	j7akktEwkdexUMMLglWX3EQhvHWobgsYhoWA==
X-Received: by 2002:a17:90b:6c3:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-370f0481909mr12811244a91.19.1780819884574;
        Sun, 07 Jun 2026 01:11:24 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821ddsm14362164b3a.35.2026.06.07.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:11:24 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
Date: Sun,  7 Jun 2026 16:10:59 +0800
Message-ID: <20260607081105.993908-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607081105.993908-1-inochiama@gmail.com>
References: <20260607081105.993908-1-inochiama@gmail.com>
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
2.54.0

