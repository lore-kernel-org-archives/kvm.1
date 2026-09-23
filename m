Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D25304D1
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169736; cv=none; b=PdHEMsZRGXNcAvEq6UkczCeImqbHVCVG220p7Qsp/KLPG2w544HvYys7UzPUpTQaPfAIZsTmkqfuxLN52xm3VOSwmTTGmmaEdER8sg5+jnZiHFwugNIBYuEJv7TanaFD8ous/2CcW8ZrJVIdTtyzvJgfOmWBAiVhGFod2Ps0c+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169736; c=relaxed/simple;
	bh=jUn3qqyUEtQaZvX9hV0wZkqiXMDN8j17gg9/OOyFXck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGVCJIojJz8wyZCdX9/G/1B3sRaTHMQnJ8unSDzUykf9EbB0Q2o0xktKGge7FuVZLvZ34+C4NC7ta8FKSlWf7BDlaDs/MJn1on8uhzYJZ1ENKbNg1LNjcjVlmg+kluU/p76QhQC+60p8NEMMbMCeMVyYnDAd3ew0XqxapK6Inbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0vHJPg4; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0vHJPg4"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-142dce6e237so679038c88.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169734; x=1790774534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dE9e1D/hNDaJ+34nzjVxm6PaKrug7kV63zAG9/GlOBQ=;
        b=g0vHJPg4IBJwcZHRDzJXRuCdmTvRwqC3GeqBzT9LIx5hlEyaDAZT6m1ggBl8UH8W4p
         JzQLu3hPHB3WHc+PmidWOgfTd6KGVM9iW7wrXsEoAboVP7RA3pS5ujJZdp8ovuBq6gZX
         FAh/xWwID8OF/GGhAdoKJoAyKbZ0suUn3GL7Jz7lUoGqIHJNgP9LZG60Y7lmK8Y5alhr
         9s/Fa4aLNZrCIMOSzaTkWlahUxhVuQFBK01mso49e82KNNGPJtSYhCGhHCuswPc7MHDA
         DQ4lTchfxWTXDE/rS3FcgcAiQxzp8b7Wa4v9yYcjuYBkcILjapVXTUQ+viWOFhueWJm6
         3v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169734; x=1790774534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dE9e1D/hNDaJ+34nzjVxm6PaKrug7kV63zAG9/GlOBQ=;
        b=JnBb/j5uTH5/qsqAplskvLUTxysZ3YjFpbYph55Uz6M/21NUNMeHN+IGqEyJWDl4Hm
         PAYghRrKmYKCQ1msSEsoDeHSsXOBuXpaPRTUSFQRv47TGoTNw3oGy4k7+jBHTY5Y0wjn
         vNa3e3wFlajN3dPXGVD8ebXcYsYQ5Sb7IoO3LnfosVEPi1r2P2WIHaVODiFRJKT1hSso
         tzToRKIibmayN6mEO8GzBdVvJhBX6VUto2J/jW17pu5uGdI5UBrQJyjLo0bEZZOqlvTD
         v5MDittQgWmI9dEZfKPj+2hfK/LlNNGfSK7PaXqs61NzZalaVCwEBp7KmYwY086QDtXr
         iJmg==
X-Forwarded-Encrypted: i=1; AKwUvBxzpyeWsJBjIDHHQM0v2orAmExUF3bA1kwjvEwKM4pQLrUoMTXM+qOt1UT2mAPvnYD4AsY=@vger.kernel.org
X-Gm-Message-State: AFuF++nIFlRmHf3h8mFYMsdfnlHJYtvs3qGDR3BXcOLlGSoQ1HmAb/hV
	Dqd5Y3R2nDF6/pERSIexd2Osa3GeTHol0127YtUP6Prkzo1bebPWVgp8
X-Gm-Gg: AYBFou0Vqn0bNWkwmi0bGWaKTyDDz7WGg3yeJ4zqBUXJb396JZvJjDuzChnJEwchq6b
	ZbsUi/r4aamQqH9dvOdDg0vqIpYehEYXusq8E2b/U2xsiIwUhbYBXLb7rHYrVgKlfBt4ivD4lDl
	D1WrvzhtiunTpTDo2AG9DXakt1duHqIYdD0lDtUeh3J5N+GlQ46I4fQVWzXk/jA1ypE5y2rnbtD
	jyS1EAkm+WCX4rE87m2PPulm+NIBRvxSqYUfcEYGwFOjJJHMjp8VcirpbwF8nZOvOXDBrYsMU4B
	/CNHdJliVcFAayE+hSJ4dhbTKAG02fd1PNccwuR93P4VpnVvUBQmJaRBR/1YIdpxK3TrUcxWVbA
	kln9pTbQlmqmElmrV+kAgVYyQmtY52UR9XAlsCRmuFOeTqXMF54WBTeGv8wycBaXkeuSJYHollr
	Mx/zSSgiG6M2Q0HVWmwJFZMk7X9pTNvrTB75hIkQSbAeCcq81VIILcYLSzcaVoDdht68tYtiyPl
	4H8ZCO1enc/wQw1MubPV6VjvNrvnwM=
X-Received: by 2002:a05:7022:6b87:b0:143:57c1:6242 with SMTP id a92af1059eb24-144f917e7a9mr3802797c88.26.1790169734421;
        Wed, 23 Sep 2026 06:22:14 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 032/114] gdbstub: drop per-target cpu-param.h from helpers.h
Date: Wed, 23 Sep 2026 21:15:06 +0800
Message-ID: <20260923131635.1894-33-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Stop including cpu-param.h from gdbstub/helpers.h so once-compiled
  gdbstub can use the helpers without TARGET_* macros.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/gdbstub/helpers.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b2f41d6d280..7250e457c2c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -15,9 +15,6 @@
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu-param.h"
-#endif
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
-- 
2.52.0.windows.1

