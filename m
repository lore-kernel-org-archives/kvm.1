Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E675225775
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172644; cv=none; b=pU8ifqerPaCDbdqQKThAWBojchKkgg6WUKopoL4x8WJND9lxBA2ND8M0SOBOOVGv5EQ+fxGo1QJ5BjVjvT811eWTfguKANXLUg2PaNIs5TJrJga8PssZRfaAYflbiMV//eO7brU+TtX2o32GUruPARTi/oMGOAvJj+TS2+4W97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172644; c=relaxed/simple;
	bh=BW47gQ1a861/LVIZYtjee6NzyilyIn4FYoiWHyHOcZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7f8ncfnAUpcPqiJX2JPxusevfryGhcAgGBMJj3Jmn2gECkYtdvOuxP4bP3AVqCzddtqkK+Z8kPY7CFfS1Sau3DB8FMwsg9y1VE/QrpMoFRn6FzVu8xnGb5vD7Cjb7xS1ctjk+W2dOuxfsp3pp5J4wnVigiUqAorx1PUqnuGPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbIA+ccf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbIA+ccf"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso2307572a12.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776172643; x=1776777443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCHGC2J+0M4MEamdm0EPkr7TMn9yURLgTFw2Rwgt3lQ=;
        b=RbIA+ccf8nvmQ3cZ7y7Jf4/1il5mPZJHS2Fyha5VTfxJxVp63Ho9EJWeSZ3hqJEovB
         23pdiLKEe1D18mpCRFmoZwSxg6Cet7xizqQI5NnqLfSqsYLDcRO7HJlMR2ztTHInYB0W
         EGRrazKcXa2XzxDgs4TqoCtL6MRHem1FyWNtKRtpfT8z1MTf7WdbLAEbgVZUpLvaWNJi
         zwxITvnyY1pcYqnLbBGXW9Eoe1A66wpMQXLtjkDTvyxCEeGw6lqmOc+3BKo42FJX5UNP
         /7qCATseQMK5Iju6LYCTAORjRynQSakAkb933lLe45YVXtnb4IffZ1gWlFTsAV+3sFlg
         /QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172643; x=1776777443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCHGC2J+0M4MEamdm0EPkr7TMn9yURLgTFw2Rwgt3lQ=;
        b=c4JaPbVms2a32RDNeX4TMaXHfFcR/+7Gbl/HInRbK1eZTAAPevvzKFjKthh2gPLDIG
         /nbNBpP2V64ZnBkMMgtWdnZ16GpHvH4es9BjklLk7Ae0CxhZBasxa2PRTFVPhjCB6hUO
         9vfsbol9Rg6T8cvAxszFmCJ+t9y2MGoci3fR/7aWS/aOypZYY3Jhao3Xk/W9AeWKb4V3
         HrvpcMhv0TDfaf8JgD4ceq4xIeO9MplCdRNtthxCjhVw+VqEI4Eo3ozbTcXaBbOZPMge
         9wqqkPVzP0r8u5l7r1T/AEYi8IObvOpwVklcY1+3Z8tAptjXXKMDdjM2Qb/Ynua7M2dB
         rjwA==
X-Gm-Message-State: AOJu0YzPM2/ssl4LD7UFwr60IJI8JD0jw+0ZM7fuBltLBKQOM69jqeS4
	uxH3wtU+yVKq1Pxx4Z6pOXxAD/Z5jBrI4v1aiOkKeBDV9Zg82Z3smhUAs9aw5Q==
X-Gm-Gg: AeBDieu22oAM/SSkqmb5nM7ZLi5e6diJEeGbgWtdKalMii3AU8X8QR7XE0TzE4drp64
	1c5jWxfdyjozufXtNLTkm+lYjlS0Z6RdBtdyK4JGAG6smjj7rmd4p9amF6vE0MiOLcDUkC5ZWtV
	H0/unxeZewWn2almedvJ75JyJBjNteQ+m3IIzO/B7V7iYWytCa4UWLY9oaWur0u61ss+vgi+73Z
	ZubYJnJFJsmRYp/kr39kBl1jrHrjDq0swzLYsyWGoKX5f6ximMyszuZ8onZBIONss2i1yNKmLxN
	u3zhETdE+lPCuMCJXB8bstFJSGJKTYfK5a6SWXjKtqkGCsHI5OWU7JUGF0V6YyfE+VNh9/NU6F9
	sndRUB3k26qWFfBavzcNcObC9iwmN8UL6h7/PK1r60QRxVIWv0iuFjICQJNEdL1GqsIA38UyVKk
	G5PRNB8cA+1JdXqUTCfegvlefg/727dRu+
X-Received: by 2002:a05:6a20:a11d:b0:39f:27ab:2447 with SMTP id adf61e73a8af0-39fe400264amr19452049637.47.1776172642571;
        Tue, 14 Apr 2026 06:17:22 -0700 (PDT)
Received: from ubuntu.. ([89.222.116.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7947fd2457sm2306382a12.4.2026.04.14.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:17:22 -0700 (PDT)
From: "jk.hong" <ryan.jk.hong@gmail.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: zaiguang.hong@riscv-computing.com,
	"jk.hong" <ryan.jk.hong@gmail.com>
Subject: [PATCH kvmtool] plic: Fix lock/unlock mismatch in plic__irq_trig()
Date: Tue, 14 Apr 2026 21:06:36 +0800
Message-ID: <20260414131714.538976-1-ryan.jk.hong@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plic__irq_trig() may call mutex_unlock(&s->irq_lock) without having acquired the lock first.
In some condition, the function jumps to the done label and s->irq_lock is unlocked without lock first.

Signed-off-by: jk.hong <ryan.jk.hong@gmail.com>
---
 riscv/plic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/riscv/plic.c b/riscv/plic.c
index 6bd13ac..a622005 100644
--- a/riscv/plic.c
+++ b/riscv/plic.c
@@ -217,7 +217,7 @@ static void plic__irq_trig(struct kvm *kvm, int irq, int level, bool edge)
 		return;
 
 	if (irq <= 0 || s->num_irq <= (u32)irq)
-		goto done;
+		return;
 
 	mutex_lock(&s->irq_lock);
 
@@ -261,7 +261,6 @@ static void plic__irq_trig(struct kvm *kvm, int irq, int level, bool edge)
 			break;
 	}
 
-done:
 	mutex_unlock(&s->irq_lock);
 }
 
-- 
2.48.1

