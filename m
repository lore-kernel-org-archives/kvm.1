Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB2345731
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406138; cv=none; b=qy1I9LttYQLJgHW7f3gaz5ksZ3I+4yK3oNGxVanRKnIA+kuei7mtwjE09/983bph+ea3QUkLqU+nS4VfJOKpOc54ACWP3SZ2wKQGMLYL1vRZpWvSg4M/9VkanuJFWcr9iHpqqDiy0dTTaaswllw9pSTLscuZpopshaRZyIwRVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406138; c=relaxed/simple;
	bh=uBzZE9qHqZzMWfKyAjzyaNmqUQ1Q72EzErxiiLg8dM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDCJNDXdaq4pm2PODJsRw4o/RAvhYF3WOtG8j9PSITx3j9MLnJfaS/I3Z5bs6arKcnxzZDSzjUZPALinLcNM8qmX9UDY/fogaVFojG4JggfTwS7P20wB7vPOTg5ympCX7YpE2shiWtxh9QbnpRzo6plWkC/dHWqe+B/pdloqjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO2rI5CE; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO2rI5CE"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7528so1430334eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406137; x=1791010937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8w8edACRSxH2Wzeeah29WdtkMXhnRnHLSCk5jpXu3o=;
        b=bO2rI5CEoAE0qH5cY0mciFJFfopV7JDonLG5drTEIWCdFiRC9ThbVvUtCJmN6romas
         Z6N0ecvMEM7RK9cyKtvO9PWXJLAfpk6qYgHWdcWXfDLvZV1uCVwK78LMwLLGpXPhpZOD
         oeQEGS9C3OmEISnf0k6sznog9JPv4TJh36vWPT+LyuxZlvgag80EF41f/88E0lK3C+T0
         jo5Bdn9K1tq8gTnE6Fn7lAfs/fkcKsI+Sor4+uRv3GrAbFyIYsZD6BDwObkYmJSKXJWT
         KLjNw7Zvsm2DUeN0gWTk2DnY7YAg61NTNRipwkV9GlxNUhh3nUXP0NqRKZ0YwM8PBZgd
         w98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406137; x=1791010937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8w8edACRSxH2Wzeeah29WdtkMXhnRnHLSCk5jpXu3o=;
        b=O8oLMV6KIMLIwfnIQdCMlzj0RVASH6TesNYe+aoASqZqufw2JVgK9EWAIIHMB4cfFz
         RZC0thDqZl2B1uViIuiAolsor+8ZJdXsfK81YG+CTX8qOm9PCBjBgS4iR7JWBiksZ35p
         7dAl/xOn0OYL2BqrtjKD5nVR+sWpGUC+cX/nLFICCCsPQHNFQOgpjbPKmV5VATVeBNXO
         VuPwTa3u90llBCExC0uB7QE99VpQLDo9XjCS4KlqMWvDr/YOx2w7HPmCvh0Suc1Mx0Pt
         Mh9XBsUkycKAf3QKNMsvW/7zt2juJZHH5+ym47qJ2cDgaCln6bufjwW6Oyab8M28AQ2n
         QtEQ==
X-Forwarded-Encrypted: i=1; AKwUvByyHMAJikP4/Uz8d9p1X5KSxIR3DHkh3Mm7xZWRVART8VSLQdepaScOn19nDVmiG9dBWGM=@vger.kernel.org
X-Gm-Message-State: AFuF++mXW2KJbW3xUWt7pCICvXSwhOHmIRR49qLcLxEuUnM8mUOIhZHB
	Q0FqCfegQKur5CWMsl0EervIxqE2/FGJYluditZaY+ukqMdwrKGDTnyq
X-Gm-Gg: AYBFou191fo7W4hX663qEH8dX3UByBMBMcDlXDHovMg/J2tWu8nMNE4Co4O0IJXPhve
	a+8m/aRVKFQkqljdv6BsYJRThBYibzuXYfuXSxxGQhuvO/DB2TjfOHYIiwK/pjIgumnuaJA80B4
	BMlGHwMlXtlxFPgnNKS+4pfaC217PNncWWRyfxP+uMxUrCOyFNFGsZtEkIoT2b1DiU5Zdf3+VfR
	22SmP5zCtV9wm9sew1+UdLgJ3cm+DU0Ze6aLGktZNp1WvC40X7SKhHyZ0vSf3b5vbK44W/16YRT
	+BNjaq2r1Fyclo5l2moCsTU1kVRtnamHta69FPSZ115bvqR/oQL9YfaWQ/wT/H3G7i/nIRUNFmJ
	1+bLfZc5oXCp2eRScpElCWzeGMg4Z22H4BL4/tqWGBBrB5CtW+TyCkM+VGEZzdCsmd/GF2sNrd4
	bF3Eu3f0MRuotYVW0kTj5ShWAxMFbJP+s48xZNf6oDyB3bIr841Sdksykm2nX9ebAOoMNqSelI/
	MKmPJJQu7iegJaYDiwBQBWBICnXT1I=
X-Received: by 2002:a05:7301:4887:b0:33b:c2bc:d288 with SMTP id 5a478bee46e88-34272e5e6a3mr2167820eec.35.1790406131848;
        Sat, 26 Sep 2026 00:02:11 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:11 -0700 (PDT)
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
Subject: [PATCH v4 17/55] target/arm: replace target_long in A64 translate
Date: Sat, 26 Sep 2026 15:00:16 +0800
Message-ID: <20260926070057.1234-18-luoyonggang@gmail.com>
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

- Change gen_pc_plus_diff and gen_a64_update_pc to take int64_t.
  Family-common has no signed target_long under -DCPU_DEFS_H.
- Match translate.h and the A32 gen_pc_plus_diff signature.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c60f4c4103d..a9b29583f43 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -184,7 +184,7 @@ static void reset_btype(DisasContext *s)
     }
 }
 
-static void gen_pc_plus_diff(DisasContext *s, TCGv_i64 dest, target_long diff)
+static void gen_pc_plus_diff(DisasContext *s, TCGv_i64 dest, int64_t diff)
 {
     assert(s->pc_save != -1);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
@@ -194,7 +194,7 @@ static void gen_pc_plus_diff(DisasContext *s, TCGv_i64 dest, target_long diff)
     }
 }
 
-void gen_a64_update_pc(DisasContext *s, target_long diff)
+void gen_a64_update_pc(DisasContext *s, int64_t diff)
 {
     gen_pc_plus_diff(s, cpu_pc, diff);
     s->pc_save = s->pc_curr + diff;
-- 
2.52.0.windows.1

