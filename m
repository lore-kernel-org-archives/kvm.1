Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1913E9F96
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863347; cv=none; b=Hi3iNwrW6XHVo3j8GMwRr6d8NEDNwZkw0QfWW9RQq04HjSGjrMDBcvS8T7vNTSUPRcp/BH32mngH6ph/u/J7Jho/3dn627bR3pbSQ0buCOu61nMEFxwKTA4XUErz+8aC2KG1J8HWrLgwRx3uDXgJNkMn2rz1/eKMebFBphRh1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863347; c=relaxed/simple;
	bh=njaaxVkDTZ7V3g2mtdEiQS9uYW4hol4xRhNOHh6yxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2NuKEAHz6pYPGwEI28UpMzT841iY70qRTLKzhOc2kH4xS7sGEKjivR6BcgYpP8Mq5Y304vGo6/KMTknL0G4jw09YD/jkJMOp8zvcX0vIjwPntAnh0ny8dU57pSs6n+fkQv0mCdwTLgSjaAx/D1yQx2a3zhe4Iy6PRCp2xIwFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmExCRrW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmExCRrW"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba61a0a2d26so597206766b.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776863344; x=1777468144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
        b=GmExCRrW+iocjhGJFLrl/So89zhQ8CO3FWjD/+2Y2PwFNP122uia8KtKPL18ti22gZ
         vuo7IxFBwEjbjJojUoz7JDCMR3Nx93+13DvJ9IwxPW3rmjpgNtlt6t8Nr9co5fJWcz8d
         zmLOpngaFkFsdywzKRTmrgnEN+KvzJbwP2UYfn8qzbdGaXW6kX7tZsnTKnlxsY9k7dr7
         PqdeyBh+tHCV/UfdgEE8wEa5tcfYg6BjgLN1peUsuhDpFEoUQ0fHzhDyclWwGVeQwIZE
         /1+OEdJq5Ij/5VoTYJ3D0ZEVXDKUKVGo5yPuOpmIVzUO7RCMuEAMhuVs336BNX/wIuXB
         4TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863344; x=1777468144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
        b=fwdAWRXVl/HqukX75mg/dkpQ8Q7lyYdZVSTRXBbQa80b4Cy14aDxcfTo5PSdP/9NKO
         n8YyN4nnB8AOuGTUsNxi+7ccpXX2DqEIvgvV643wQX44QKQmYenUymHm+Q5iArKeHM12
         zHQM+BysZBSAHDuwEzEx3j7Y5BIretpvEK5uhOZ7CxZhsxcQMW94PdQcQtYF6AqISNAu
         ldnbzOAdpIskIo20DPctYYk3eASIj6afUwRuH4Sv1JrMNtB6lVBwPviPddnr3Zabyzx2
         /KjYywF6pRRplbXGWUeRcR2Webh5dcjdIZvV6GkVGMFfCE7f2DuGPX1T+XT3J8B9hmdd
         hZCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/177tpKivrXkFGbvwq1VRUT8TJm1zCB3VgcPNQGSUkbY98t0oA0JJEbdgT6KU6Fk1mgvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUlk/NW7+yylYyAHL4h1S/eNmur9bUyP2nL454VEKfZ8mDTVL
	4EYFlK0J69zcembnzu/1dBGGT+uqKWLgpUwJmR4K4m+eK5hYPu9I4pUeDM1b1T9RlGY=
X-Gm-Gg: AeBDiesGG6RophPu6cmQGh8AqglvckOiU4cuDl6TlNzE2IRi8VyeHVRNxJwp7nqYuOg
	0MRNCEuQ7UQilSbKGuWMUd4V1dKliXf/waDOhjLyLZTWptrK/FwjfOWpJImIkDNppKEAzD8QCR+
	eqjgt3K/WpUIlEY8YfY8QybXNzBNosIKbTiRoyI13Ph3gsN2Pp7A1R4qj9KrHMuMfFRLo9k3CrO
	lATAjmWshPxlAoSNZtPcN2U57g1CRIetEVpWUHE/pyjBNjrifkBXIqFB15MG0RMQr0pv+WRH+Is
	43khBvNVwT3DjOYxED/nUv2fo4mU0W6C8n7hc4rohcBgFRcTQl8tu1dEtSelZcY24UFkwIehZBc
	tF5aQQ5W1S4bYnGu6bsPGHn0memy7EH1F9y8RJZNjJP6+jK8NhwPLzONBUez/99HrJp97GY4PKt
	yubRA2TbxQsgboKCIpc63PIRIKFgnccPBpUA==
X-Received: by 2002:a17:907:3d4c:b0:bab:1e1d:40b9 with SMTP id a640c23a62f3a-bab1e1d40fdmr140947566b.44.1776862950837;
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm41420944f8f.32.2026.04.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 15D7E61667;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
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
Subject: [PATCH v3 26/32] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 22 Apr 2026 13:52:43 +0100
Message-ID: <20260422125250.1303100-27-alex.bennee@linaro.org>
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

This mirrors the logic for DISAS_WFE in 32 bit world.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 073454b9195..d79c8ab431b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
-- 
2.47.3

