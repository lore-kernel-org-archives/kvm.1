Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BC3C7E1B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862949; cv=none; b=NOUsU153MjhY3zjtd6Sd632fECLFrx9zMaavGZm7flkJys8MteROuD5LK0xigXL1rCW8K3RtKasqPq+cDu4mIuo7OcjJuSQnJTcj19glO4vFNA8bEgj7dFmXeakoFthFqv+LNFgatcETKccPCQhLk2O4Qo1rKLc6mudujDc/QRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862949; c=relaxed/simple;
	bh=KaJ5i8+FHtkdF4FnBTD8N9r1B5Z8SPxQic/9zMeuoQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOcUQdt3uSmcescSFpeZH2ahhmL4Z+0eTFfFTdblFw7B+oP7jvR3XikN0lLyV7CohKzMuA3DXbO440ae9JDR9m9G0+wbZqZhm7F7f903c08mWCJSwM1kjC+fdAEJF/GozJI2wWZErTlrCR5KWZGJMUKjJuiAXKmThblxMX9LXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0YvmDLd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0YvmDLd"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bab8ae52954so62961666b.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862947; x=1777467747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
        b=P0YvmDLdm7p5/Hy+Jw7tQUoRrmnVh2nvfWnjuL3JZioX0nISMX5oTxiS3XkLR5Gwv9
         WfkiRsW4PnL07GESECTDNyGeLS7G6ooeNN1byDFRRwWyMjBh7u74qyDixDQM8TIE6TAh
         figMifwYqxrcEjSkHRfrSZd67InbkBO2D3mIUcNUj3K/5YY6rxx07PQQDlRcilG0CvJG
         BZayxTW7BwhxJSlq5i/n/OhwnU5rhYak6PDZEMXFbN6in+8sFPFb+SlN/M/J1ypWsiEh
         +gnM0aXpLzsiDMJN0h8I/ICnCmwBXInf2yQLAtqxUBX+/NXLQURDdslgYSJxIS3CrBBT
         1XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862947; x=1777467747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
        b=kaN67NspBsvAlCVsUC6eZCCTxXqRG+l+I26IryUTD4BeNyyLfIeK/UOhbMYdNgSuZB
         6igniUpi78IbVcO+yFbdjfGnVuoEGrCea8/aWA6Gb0o4ZeOOZAa3UEMPn+z+jFp9Or3C
         T8CY66t8Yt+2AknS7Y5FAnppvAa6ImgIwXiXxO3ARaRZRjF6JxX/L/IzKP1sLXiqYFSw
         XbZ3fDMbXNAke3l/b5lSMaH4GvDnf8bGIrcC82UKIp+R4Kl9rnwtW5M7+mSDrgbJSJm+
         Xk9b9dIkmGkZjSHOZszvddTIWy2VXZrXKAhF6uzowlwklqRWGaAiHyWnr5UGwVhJNoRK
         CxUA==
X-Forwarded-Encrypted: i=1; AFNElJ8iYL0O1NfQCkOqNgCIGcVSWFE6tvYJAUr0c8mLDcVrDw90nsQS5Nuvw1VtNr4TzIr+I9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW48IYDcORIoRVsmK3cFDJM145Gw+a0smYDvWEHIXEAhG1bD6
	ZJFh2vk7/y9LXssaKs9iGEXJfprTF107eOahNWFEMBWGR4U9z4b1LbLzFjqnU3PkARE=
X-Gm-Gg: AeBDietIFrT+nXJct5zyGPIupgIShViP7CZh524EwqnswAHPFPSyrbBzFC8gLLN5UYt
	R/eWJ7Z8NOeyg8DFcEGF9sTKQLDzVEGA+RajZY5ECrfW2hH9zYtSalAGlBb7rhylxGD4UuZTbcF
	/zSZt0f0ooEHy6Nf26BtSyS4TD0Y6TerKu9/XPu8PA68BU2ge20Lb4zi26IPXD75QeiFW1VMLWj
	gQ1iHvT4Mg0p8ULF0YykDCaB0m1Jtaw8GRrE20zfiQVFJ1U30+qGE++qIWvOr1CwSQh8vdwK3i+
	aaxso1OC+sSIr+AyJrNUzvKNzw3pk432H88F/CFOvdPmbgrZzxMnk9Ai43YV43K/9NtW5+CHaJy
	02p5nC4HmQXw3UfLW7i1i++QJ2bgyVqC8uutroVh8Mf/SRmTyR/EMREQw1OoQFZVvK/GlFOjjD6
	XVStjxQMJjaK36Tc7y4m3kEg9JN1X2xk87HQ==
X-Received: by 2002:a17:907:a60b:b0:b98:40e:f335 with SMTP id a640c23a62f3a-ba41adfb10emr1011985966b.34.1776862946614;
        Wed, 22 Apr 2026 06:02:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm42442835f8f.22.2026.04.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 9E238614A1;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 21/32] target/arm: use syndrome helpers to query VNCR bit
Date: Wed, 22 Apr 2026 13:52:38 +0100
Message-ID: <20260422125250.1303100-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
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

