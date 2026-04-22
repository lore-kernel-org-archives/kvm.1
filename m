Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877D3CCFB8
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852664; cv=none; b=H3RYJZbX5i3qU7Fbvf2M4BxHwEOgmwRq3h9HM6LhSXb7ec3WdpQ3EM8ofiLgd6QrbRkBiW/8l0bAGFuZRCw4ChRp4ltNhI8cwsXEUBV8i21flPIfs2qBXvEUFP3Ye7erZg8nDE9JfAoSqMQaVbvhHH20KHCS0pW4nsO/uYOXUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852664; c=relaxed/simple;
	bh=KaJ5i8+FHtkdF4FnBTD8N9r1B5Z8SPxQic/9zMeuoQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfdSSotUk35RZbUYmjrMdsEVXNYXoA/o1JYI3B59UklT76KajtlMW0VpSK5R/tw59S7l03NRA9MhP/0abR+imYWYpDlEdlMH6CJFFyYiV0OvEHvzdZCoSVwpzzVNLXklEpSB15nyUEuqcqIcDf+sqLhD7/j77uvSFUo+3aZtqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUIJOcOm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUIJOcOm"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d70c30767so3601239f8f.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852659; x=1777457459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
        b=MUIJOcOmbkKe2QEBI+MUxpQqKDZENSx0SvKwipl+Kpdf7nYcfuCymkK9dRhjamH14C
         GQ0dfypqbWUAvWhTOwMUWZj8wIVtEtmXS9SEX5ouxB4OwkUyGIAO4u00qx4de+IM1368
         g7R8tVGjlmM2JtJ6k1P2o6XEI/lzPu9KCVqQgkJLguO7tx5pLFuj2eSiYDUSsGcOrDt5
         bn4mrwy6qiDQESNaIB/6AoqPKv43Y/e9cNePmSEZvlazSnUsrd0rZs8c/aT3VK/X5HPj
         KNpJeSUYz5hEwWo+/6xILQn+UdTPYeBC3gwYJnU0vmuO4WHE3T3SOlDTabQtEmDQpV00
         Vzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852659; x=1777457459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
        b=pYYbArdKYxEzbWNYI0L5c7gxZ1roErMC3NomGdNzF8okmQNwKMf/9/vlU8c/LG8thh
         Vg4FVpqfA1n65e0u3OPCyad+KMhX4y9BSHeCtT3rStd1WFO4tZkDb2fSviqEeGFlimEH
         JYqDiHqXS+6zr0UWe61DxvPb9VggapAi/iqUoVoEYYSgDtzXr1nHVt6o3JAktacXnTtz
         nga1Zb/3ix95ww3541aG2S55c0ZOneo7RKQV6d+Ae3tL6xq/GT2MXzWJmo4+ut1q55f/
         0cPWcvGJa4n/zKpqvlputSmCW1YbTuD2uLnsilIPKelt872frhUZiYlSu8HrCbeQdZNW
         srZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ya5Zs4FoRID53g+29UHhgpsYbIf2C3Ml8in2Vd22cqD3uGHqH1+nVteilBdwJEPR6R1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpralFGmfBcLEkwyCYxaV6blQoViYUQC3YB3dwJVdxa78cXs9
	S8wPbneZKseZGsfMFecqbq29tmNalByMIGJZGsC80UW9fjBNJb4RdC+vVvUtJm4Z8tA=
X-Gm-Gg: AeBDietmgd0GvBK8jejHaEaCSmMgzMVmppvjQWW7L4IxA0smhDgSleii8LEGrVjebOA
	neKPi6sNhF7J9ibBpC2TtzP+BXBIftuZVM9RsprjuiAu+l5c5nbwUD7sLLn9YDWJb/ZkPbJiTZH
	molOU7cLvx0Qpg9akRPMLx9Btiud21zsEShC5iv8S7LJP2fZcI4FL4F1niELK9ShFHtT4h4pjhV
	5kAWH5ON+TaBpq95HpyvAT/jY1I0ubnTCdBX+JcdeHrKVyvmtNYf48w0uu/xz7Vo2+/qrf7aH4b
	pL6p/1850LMkO01JevqW4tqS8k/0/td9GfoP/hD0ePRf18NZ6IM15yD0qwW+6hUOt8WzMWnhNF5
	fVYijJo6Snjer39HPSjE7Tb9LcrR6jZcw9l8j6PvOUEVLinMMo/j4nsTcopyzC6pSDbikQhrpsU
	m0XsJSZzegtizQQeYdiIl0sEURVdR7IAq7HA==
X-Received: by 2002:a05:600c:1444:b0:489:1c0d:c9cb with SMTP id 5b1f17b1804b1-4891c0dcaa5mr145715445e9.5.1776852658688;
        Wed, 22 Apr 2026 03:10:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4633bsm44099622f8f.26.2026.04.22.03.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:10:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 1B610614A1;
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
Subject: [PATCH v2 21/31] target/arm: use syndrome helpers to query VNCR bit
Date: Wed, 22 Apr 2026 11:10:32 +0100
Message-ID: <20260422101043.1234229-22-alex.bennee@linaro.org>
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

These are only valid for data abort syndromes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index c74d8e785a6..bbe1e70bc43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (template_syn & ARM_EL_VNCR) {
+    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
         /*
          * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
          * they are always reported as "same EL", even though we are going
@@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * because we masked that out in disas_set_insn_syndrome())
      */
     bool is_vncr = (access_type != MMU_INST_FETCH) &&
-        (env->exception.syndrome & ARM_EL_VNCR);
+        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
 
     if (is_vncr) {
         /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
-- 
2.47.3

