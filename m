Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44202DCBF3
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074718; cv=none; b=IpoeStWv60h0EXViGxVW9mJtEHpA8OAu5Aqgg1Qza8dP5Aprv2PiRxI6Z32ZhZLJ7Z0ehSwAoxy5MNdtMpB1OSvmFlUkPcsV7KlGpWtNjWVou4xaNHzs00cBnz54UPKIk11Xqqa45cfWJH2KaO1WVrTOAQ41DT0hByV1mVd8ZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074718; c=relaxed/simple;
	bh=ZVlBx3jUF6dxoULLqnV2A29vKxFoZksTGD2x93xyva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAr0ItZKgdS/SuqG7BpNzxpzh1tQFNHzE59t/RJR+0uqv5+v5t+nTiJNAiC0L4snjOefuVndSExwDjQuAyAb6xXG3z1KJ2QKLToD+l5d6Uc2nd7WhzkTZGPjOjOIeF/FGXni6wv1hRfHw1GU1TfomWsdpR3wK3I8eknvsyDDDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9e/4zSQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9e/4zSQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-482f454be5bso14171455e9.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074715; x=1775679515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
        b=m9e/4zSQSGapiVzw7S3PSeVB6mW1w8yidwSsBxVfgDgavivGCKZp8mFigmzPW3XjUS
         Vb+FVB0m3Atv7I43k9pL9u6pvVyWL1zU5A6eU4AWQ3Vtb6yNnfD2G14GKFRVjDtZqRQs
         R50qJSfVNEDXZFCkHl/Zs0Jvk/WXvQ+gyw5r+T5KUH3jUI0K/YNj1PQ5OFm33oEFnlr9
         LbQkC+d1XxcouMnLUl/e0mDEIodAEZ6B2hOkn60mkG3eBw001D1TPGYUWL2w+tZUIUlF
         myqlFp4MCWcP/s2OM6CnWJdsj1EVTM4NhEXW19H/W6FNyLEohjlyGrOY2BwSGvm3IDQn
         pe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074715; x=1775679515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
        b=Mh8qsTOshDQj48RYF3Ij7tVuhu+Nvir1m9SRsDnfwJpq7vln0cgqLkZWweP/EcQELH
         zk4QxdiBIZ6hEOPuNU81i1CyZbtrWsSPBybJuhHx+jy6oCq80joHf8K2jzrca549UqQv
         ISBrLMHnQYFLJ89D1OVJIfxDOJe+prF99t0cRqSEKFmIP7Mp9KZAiqNI1XltdWHSZw/G
         +GdaZavIrK7kOfxj3N0ubOOYnB3l+Ohv3brJ/4Q3FwRUKGKMisHd2+spULJWYtuYofx6
         X2qwf5YGcJcP0wCfJlcHuZuHKSobxD57FIzdMEym1oT4ELyVWnzkLpYqHTV5d2l7UdqX
         GGTg==
X-Forwarded-Encrypted: i=1; AJvYcCVbLM7MkLOk0pTsnPWYvfHqTZmV7T8p2hKztom5KhLAs/BlGX3xfXKyxleM2WOR2bHd50o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAsCctdRMezQUnxFwGij4sBdK+Wy/RWv3Vtamv1f6Vg2sImq9
	UrnXcEPeeLkUOXOxEZjgbqCOKrR2JKdI8ZQb+0rjF9isTfDTE5ZgMJ0KdiJOKFZrf6c=
X-Gm-Gg: ATEYQzyrfq5F7Y4q4NJm4afeW6U3kfoy6yQLVOkCjynIAPGwflUEvTO6IdS/FdRqqOc
	7mN4kdeV4h6lnjWpIK1d/tdyfO+2CAwOWBsdAnEvZdVlldq0CESN6jFGUDk0oHsP0oRy2f7bexo
	eXJxh8hS2s5VHwP8s2wL91pCd5caviBuGF6gOR7QrraXxIoW4p9Bd8vdneWK69ZpzTvsBp2rtXa
	H9L6EYV3arcElRQC1vITFCajNrnokLJuCa1ShrC6Tl9Hxyv4mUcuCilhLGim8echyEDjSvYiOC4
	aht4Z2zVBLD9sJOTJ8g5JdmabsP6JaAuhfq8c34OMaL4ryGtvGmjjBHNcl2b4Rw7bgcT81Ap5H/
	k1UHyVc9ih6GM0dNl616tNMEAPSeRfqzbP7+ZD/gw/Iv78zUWQQdpHf0OGANnvCoFsKdjwE7Lkq
	UK2XQnmz35g6ieckFELvnnqx2ylIMoDLB77IlOovesBV0N93CttjMAm04XJaFlKSqg3+RpmWKM
X-Received: by 2002:a05:600c:8b77:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488835bc362mr82737355e9.13.1775074715204;
        Wed, 01 Apr 2026 13:18:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm1938072f8f.35.2026.04.01.13.18.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:34 -0700 (PDT)
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
Subject: [PATCH-for-11.1 5/8] target/arm: Remove target_ulong use in hvf_handle_psci_call()
Date: Wed,  1 Apr 2026 22:17:49 +0200
Message-ID: <20260401201753.92290-6-philmd@linaro.org>
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

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..678afe5c8e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.53.0

