Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512503630B9
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074733; cv=none; b=agBc2fiTRxIrs6G/fPJJM7MskxbI2Gq+lE1sG+M+mm+ZipThtbfN0AmGzfNmjen+XpNAzxF7OL1ClIhhXbZz6oaS/HLyixXrY2SH67OM6guBl5jQ6G3LOSvkIDYKcNc/4+ZTVIjuNmiuWglddJoXoEUJILM55OqlgwQZJwKuMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074733; c=relaxed/simple;
	bh=9VFy0p7UYgj043fYw5lCybsHPTatFfiX9bf3LPCgpos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b343lbhsd7qj7aHQ3NrQ+KmHKdWmfSST7Fkb3vDcgxB+405NhONqkkbz8BD9Va8BUsvyxeA8wgYZwMImrQ113uT6/Sl6Yuf2sxhz7ahAKlvlXdnCGeEocjKlNZmXdzq9n6EDINGLaeXbWGeSFXl5hVoyQQFJC+rLbsJwGpcljeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKi3aOar; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKi3aOar"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so1038085e9.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074731; x=1775679531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
        b=TKi3aOarh2kO3bHCvm7bXws35RJy1cDZ/19tQ/bj07OfZDLq9BriCoP8TN6U4yyGyw
         NVaWrWhhuCGo2BgatLHd7QTZ8hiuWJeANSbu5CoRcGW3HlaTdCGL6HU0R4LAuG/rJR0e
         gJFzQJUg60Kf18z/oSklkbSRR3O9omz/TT/QZslzdJKt86PAzyQXzaACGWaG4dWyKMOU
         Dk8aJ5RMU61EXZpeXZqtdc6gh3IjNn9LfJzcvvW4Q6XmOVyChyxUOG7CWj93wGRU9wZ3
         lRT8B4ytthQA1EHeKolUOkecekoQdB6+RZnQszxILu9CaKC0bNFZV/RUISluqUtrArIu
         j0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074731; x=1775679531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRPUYAczpQfrNB7NESGbjTZhQXyZHZILb2QpR9Q7LQM=;
        b=Yo4TMSr92focmASNRDTLOJdUpewocnn9FYbT5j4iLFmOHEuSQjQ2FMU4mgvPITozZd
         xTKTBJsc+J68LUTWpGzuAn1Hj5CtR83RfE2MvafOpCfYx2iWvn//VU6zXjUHJ++/w1oR
         1WLgcpsPpHh0DF/pMgsK3xJvIldPw1R9jyOh61DPx7B8ojMMA1zMMVK1WNK7lWB17Wm/
         BUVCFfjqYUNAWMcGgWet80Z5FCwGJlX+i10Un61B7heDTGBdLLMxDMGlJr9zLa5p0ly7
         ho9tmRp8MIHXAO0UPrIfMMm4D14l6vqoWRlzTzaC7+HyBDRep/+29EnMmbI0UdC8PPft
         ngJw==
X-Forwarded-Encrypted: i=1; AJvYcCUoJP8de7X4Ns5vmlHK5e5mya5poGBHU9VVW9OI/NZRG+qlOQSwzpeZU3nI+aPZZfk6ECs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1JUZ993hncKphL0doPHykses6IQ3xRT6dXjHtO/f1aFPIbtz
	WFz8Afr/vReRZHro5xFGrf1R6oc5E6oILogih25EYYbTyPcxELv0gJTUIlnKiyiI/DU=
X-Gm-Gg: ATEYQzxiYg1qGVQMX2v/W8vyE9I5RiiIn2j97wM63Llca9cet/qKZGl7xPg2t2FjZdu
	Sk59Hw4j41dIddUC/p0bdoAlz0JuawVJMYiC2hzu1YW5Lge1XecWuUIyACDsCxD5YmW4Umd6j9w
	KGUNyAVL+cweRB9/rDE5sVqJmJ4kEzYBY7QGUMtDqH8X67yVgkHbzt54Yir4+4KXHfJ21qT8ZNV
	Ss0QsJpDyTeahgIq/ow8/tlItxIIGiBRYZSGqsdF2yvqoqfjTNsTM7LIj0YGL/iAHrgflHV1sCw
	yaALnWq0/OBPPTD0FAXR6ZetNtSpfMTiorZqWGEUDbEVa7VWq8TYrD5hB+Ekxu8q85GT7JWlgJp
	pqWIu2SbNAtIG82AloAf6TW8XBqkemj3WPZk0EmSspzD3hToWRnoty4PtfTu2Zg4n8JBXw0AFs5
	0QZ3T29VZlISq/4nxs6+TnWREcATg0OK/cookGk4+GEhPyK+B1WZ02jX/q8dyzqdejoQQSvokQ
X-Received: by 2002:a05:600c:810a:b0:485:3812:36f6 with SMTP id 5b1f17b1804b1-4888359db64mr87355785e9.21.1775074730644;
        Wed, 01 Apr 2026 13:18:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm49538465e9.0.2026.04.01.13.18.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	qemu-riscv@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Anton Johansson <anjo@rev.ng>,
	Song Gao <gaosong@loongson.cn>,
	Weiwei Li <liwei1518@gmail.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	qemu-arm@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 7/8] target/arm: Remove target_ulong cast in kvm_arm_handle_dabt_nisv()
Date: Wed,  1 Apr 2026 22:17:51 +0200
Message-ID: <20260401201753.92290-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kvm_arm_handle_dabt_nisv() uses a uint64_t type for its @fault_ipa
argument since its introduction in commit 694bcaa81f4 ("target/arm:
kvm: Handle DABT with no valid ISS"). Use the proper format and
remove the pointless cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b88..c09dc4cb3dc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1453,8 +1453,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
         }
     } else {
         error_report("Data abort exception triggered by guest memory access "
-                     "at physical address: 0x"  TARGET_FMT_lx,
-                     (target_ulong)fault_ipa);
+                     "at physical address: 0x%08"  PRIx64, fault_ipa);
         error_printf("KVM unable to emulate faulting instruction.\n");
     }
     return -1;
-- 
2.53.0

