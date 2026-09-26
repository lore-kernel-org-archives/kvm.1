Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B03403E3
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406138; cv=none; b=sMR+cmcRgQTvahXEDbxd8vVLSqapCD7GP9W8+KgxmlQ9eRGIp9PGQfBruWOq/FiY43gY3yD/cIEnrc3HobN9cHOJjBbnSCmC/1Vfn8s0/xtg5aBVDKR4SN8EHgRlhKYcpWndo+uQt2f80P9veURAqr57M8GRj9cwISKqhxOjwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406138; c=relaxed/simple;
	bh=fFbYGmG8GkruSnnN1GGqot/Q9RX7vwFd3h3ZCFJbs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7eHUiFc8fGOdOKdTANSg4hOJHxeUluMWY2JlQckzer2Yq5D8iV6dcYpUlOCEk+r1Q57o+3qAmNP1iViqD5QHHiKUS/wzzBpjgB+C/4KXX2BqDrU+RF9x9ZCLMvSpijwUNerzq2HPZyD9Q0P3lzKez2s1coyR6/N9Y2ah59A754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/W5XJ6L; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/W5XJ6L"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34182b58c7eso1211312eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406136; x=1791010936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gM6IoquW3yjdS4WUjO1V8C4p7BWFFY+pJ3+gr7qZBo=;
        b=f/W5XJ6LmdiZ+0x/VA5xxhAC13yQFbg7DNNweQcIo5iL3Z9nmF4D1K9Zetq1c53JON
         g1DvUhNGRpKE6ha4tZHtAbGUlVHQzVuOypFsM3lBMwE1CQkNT6f+2o9qefqsB5orU6Eo
         h6d1KGEveCMNgEp4pGYLuXneO5iAX0gslDVcJaE3mpjXOOzvgq4ZdyCu7FL9x7dO5yfp
         DOKedrIuNezq6k+xybEv9CJdxTdfJ4xlNpx4K/oQIX/nwLA3HfLBQQa4YPfyYve5SXsA
         UfCBlQl4TWyYF09mXV77BftkNJJEyN9NRhyUZ1qEjn/o7iObUTfa3gh5I0k7FVMIhQg3
         vI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406136; x=1791010936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0gM6IoquW3yjdS4WUjO1V8C4p7BWFFY+pJ3+gr7qZBo=;
        b=s0yrGqMgOZzcEY9ydEuZdUjVA0IlQIrpDoFUyW1Nm/Yzwod8aC/nxBVOqmwjI514iV
         FuuZvTfJNxvmEJVPIbWFSnsUk3Jx3MX3fOWVX7xAKY48sBpZzuvkNDsqgbo1iNtbOYfg
         0kwMFidlZFK04Od8JlmiEBVUaoUC0rrRXVJ8QxK+rjiS4N8acqB1pluAAsSuuF3V6QEt
         R0oJO9iRB1dSvDzOcJd2Wq7czJ8pnInP1Mzpi1La37tqRsVCdRxnl0PFGcw/LHS8b9gP
         ALpBIds3M3LTDXj0qFgtxKQPuMjXQXiCupBgenWYPk6XqMEm7c5cUQ1vYg/FPBvIPlML
         S3vA==
X-Forwarded-Encrypted: i=1; AKwUvBxm6ttW/8eE1kRiqNo0feYUwMfKxBtUkvTUQ2+gc4RYnARiCRi+c0U1DPxjwFjbu5vcT2A=@vger.kernel.org
X-Gm-Message-State: AFuF++luc2p0uxBJw2GL1esGCCG2QL4/fTXl6qHfBchQTzjLqKF+BfiF
	7v8+iAdZWRSH3S8fvYzkCWqAT8sVNmQZLxWcmrAIl6MyU4X0ZolUVPhI
X-Gm-Gg: AYBFou1xgqqtg/pLLI5eCYvC1UWFHrqENzmFJJVV5AyAQVyFJ8YZg+V9IIqUNInnj/l
	ZWQKqVN+tRB+LpONyNBZw0ExnbGevA7yawhudiHv0l11ttGTsjhPaFVJXl9phYuMVMfkYCd62tx
	vImmSZ0t3XyDBDd3hkDbDRyiKYBtC2bRJLleA2YE0q98isgOuAnWwKxXWgh2gTCCAZpCiMcH6CL
	fwXPxjLJzwBYlRE267OFLYcwRI4sSFnkkJPcJLrXEvS8ce2ysSex/vB9/bQbc2e0/H9u6CxWTTu
	SUSJEENf70wXNf4nZaPr5syRXs3oey2gow8IE6N1s4fPt+g5A6r7LbGb3CZ33uy8YK8SE79anfA
	b5CkIk2pLgjeWbU+yYcg0+N1gHEdaAdyfR5FERutISKYu+oSkjk5U5ZtJqjEJJFTd6+zZqxQdb+
	rT6uOvUHDMLUdnT4zjw4jSn7rb3tO/DcobyZF7wSjo6di1w1Q3KkOPozA9bVF3GvkwU6M7+EYnn
	i3kibxPLzHH/oxiU/5nlPGJopkQy+4=
X-Received: by 2002:a05:7301:a2d:b0:33c:e82:70c7 with SMTP id 5a478bee46e88-34272b598d8mr2099056eec.30.1790406135670;
        Sat, 26 Sep 2026 00:02:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 18/55] target/arm: use vaddr for the A64 insn_start pc
Date: Sat, 26 Sep 2026 15:00:17 +0800
Message-ID: <20260926070057.1234-19-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aarch64_tr_insn_start records the guest pc as vaddr. Common compiles
have no per-target target_ulong for that value.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a9b29583f43..50c2b491ce2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11115,7 +11115,7 @@ static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong pc_arg = dc->base.pc_next;
+    vaddr pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
-- 
2.52.0.windows.1

