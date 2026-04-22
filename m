Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254836C5BF
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853048; cv=none; b=JUf3C3chwp550naJiLBQ5Du2DYpwrtij+fc8rX84kSA7BYgsSTTE35J/rtDFPcbWcRi/0S1MyA+ZpoQHlUB8XMFxybv+aTcXZJ0qvcgpoiKV+CxiuEB8qJT92smLGm2P/HHiVvmGgqvOSHVClBYJ5hflBUJr+6/HF7SKHn+gUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853048; c=relaxed/simple;
	bh=MSNZByR47NedQHBJSJA1SNopobGCivI5HjPYp5UzzVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXYakA2kMAB8ApKuwcO/Vsgmh6J13ZCdTC0IX9NovouUuDzqzDeVl9uybKvinWOoqsQ3BJapvD696DszEMjVmW6EBzUCrg7HYQe6mRA3VTmkOu5hwDZmMVbsZsUu8fsK80zsoZlj0IAlJ07OTcMPpgGbpUJTkCYIEHRamt2RJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WwCTfhau; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwCTfhau"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so19902695e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853046; x=1777457846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
        b=WwCTfhauXMsz2uTcJgP+hf6lGWJ1vJRf65X9HGvGeYjBkVqMWdtaOQYB8vVfGhp5/i
         otvJItA9rrUdIA6EgL5zdgwy6KayCdH9e1oyVC921wVWJuuM3icbQ1oQPXXGTWFi2j2k
         DS2G+YI49X0M9OYNSRGNYzTZf872kLkh9KVqTuKJ5nn8/08gc7bhUAApKMo5JVlSXCXp
         LJjehu95z+0RdRx0mbjG8OX2O0QOUIhwMH0Q0Q8Ubvv1TG/36MtGmXQFBdQvYNjGJnmB
         plUxSj6YKF5iEdUyzavKDS5t4OElSMZEOlCvjYbCWOKrt5aVn3RY6SG2UMUC33txwAY5
         VTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853046; x=1777457846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
        b=oJXGsvSPA75XFhD691fwxzUjDnF4LCVGeIrX4gEXROMrp1ZKtzruugm0h3JtN7pb4/
         UqGSHIKgrZMsEgjAvqSuszTmegfMjh7QAAToD+Kwcr3OrjO2kTxdNI5rqAqim3xIRhZA
         XrMP4/4S+C6pAQk639M2Wgx2e0duzI3em7g94hqYXGyhvAb2fRvM/ESVs1iQk5rXiloy
         +9Rru//CeDi5q7A3w4TMuB2Vkv+TQx2Lk156/FrFE5RT7FMNpfeYMP+zIW2+yDqi9mw5
         8xuWvGLD0TrlVX4+0joJavdNIv1R0Rlc7FwpmqZSFwqo/0EVQeGxRooREFOPxmz+fRmn
         1D8w==
X-Forwarded-Encrypted: i=1; AFNElJ8UCqwSmLgqD/TafiGqGmrZPrurRVFj7Zju/1HFh+t7EUB0l7J+42zhht+kjyufXWEQVYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgmwTVHnCTp57PHH85FR+nEsHbvxuesX47HYCKSYlMtHswbk1
	2jVB5ycEy3gZEpFTqbDFHKbOiSoRWbIDhB77Hq0FIIIVGnkXnsD3PTaJ+Ie/Ts7xWFM=
X-Gm-Gg: AeBDieub1RjAqOUw/xsen06w+WKU+WujKDUeHZ4pSJk6AWXP/H9NvWra2BuMTRKHCV1
	EMecutNfir9H3Py/SndOlUXR8O3NwDtthdGOGdFuTQjCVFxn6Vxfg5GkuwiJDTa8htYFKHh9d0N
	L5HdU+OXq3iD05OC7t9iKC04ZrILDJWTj4zi+uqQ6WuxlisGP0SFp9kKzYd08QI/SxqWxKUJac5
	s/llhas/bI3soA4/RmQqvOP7EzXzjaK491Pt/E4FyhxrgKVXM1CcxpWGxgPWpXNz2nXa03DP1WF
	1wHJ2ph776tH6i96kq3vWXQU+STPiPFI5ZblP9zPIGUC97CwZ8FGIpEWuEQ5c7sowhyT067QTRp
	Qq1hGavSi6jBBBOd1bKgYMCLxJXaETtWhT1cOVSy5pqjNX51TeckZ9/kMcavYcgLWrO+COXpcUW
	sUVrf6cWEY+SrdakJqEpbeomTsiSZYw6wM2Q==
X-Received: by 2002:a05:600c:570f:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-488fb882f13mr231449795e9.4.1776853045759;
        Wed, 22 Apr 2026 03:17:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm46560662f8f.27.2026.04.22.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 08B4E612AD;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 20/31] target/arm: use syndrome helpers in merge_syn_data_abort
Date: Wed, 22 Apr 2026 11:10:31 +0100
Message-ID: <20260422101043.1234229-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

One more step to removing the old defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f9..c74d8e785a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.47.3

