Received: from mail-dl2-f32.google.com (mail-dl2-f32.google.com [74.125.229.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657252CCFE
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169438; cv=none; b=He6fFuzR+2EoSpll0mCDJ5FvJT2rndQLPd6cXAtTjAR+QJkFWqYkbOvwWtQpcanSEyaYXtIeSgqfQKGVl6cAl2doRXhJGRmrojjflbGzxkozkVELlkdCBn/cT0oKJ5XgdqLfMNYyD+LPmKlZ4bIKNauPpFxOo4rjscVB95AxaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169438; c=relaxed/simple;
	bh=btILGjXv6B+RlEOPpUFBZSW2eg4ByJSrXN8XFqhWxVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNxu3bNTeKA3dnyHVZnLxHu1p2+5uCIj36UlC43Y3kLgNJkr+oUJPRLnh/BnkZygucgR/GJCCbKOW6Of4W7HgRnij0whFrEqxppxfulcq1PBb/Dc6Gu89QZGJZhrbR1eQJ7Fe80YL5pdT41o4cdm4ce+qFVm/azafoBHbeotcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2SIwLfv; arc=none smtp.client-ip=74.125.229.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2SIwLfv"
Received: by mail-dl2-f32.google.com with SMTP id a92af1059eb24-1437b77c274so542218c88.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169436; x=1790774236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t43puSbRZc523NBj9nQXSYWDHrWaj0cvHGn4qE6n+xk=;
        b=Q2SIwLfvKBp5O1Ozre3Z5ig0QB7gAc3w30VWOT9ssEuYDIQmtPFqAzmx8VDd06jjhG
         IEKei1Mc2koBVbfEl+2L7hMZc60jNKsj2Su5lcs/dixpABSxwb/4/PlqMtTmlQKucYXV
         7gdTRqGCqtAcBOf0KZYdxOVigh+1fGhq9RYH9DxNM1ojyXE4IyWqXgE6KtzmQsLyaMjv
         Fq4KAEqbx4Rlt0HLOnwWIxgsF+bb/vP6bw/OLx5ODqk+9HiJtic4wNQQTEIMmqa3J1AV
         3I4FbGaBMt7ya+mdF03NlrSctx0s2MZ8uueFE7TS3d24MR+hVNoCtBWZIE5OxsHO7kRd
         DqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169436; x=1790774236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t43puSbRZc523NBj9nQXSYWDHrWaj0cvHGn4qE6n+xk=;
        b=0SY3JTRZXwFDKASMuZLZYrlgarB4cFGr684g4tPTJM5TODplZ3xrKjmJu4yDfYEpOo
         s+iovv2TNvPmOEKdUcd5uaEMz1WGVL9hEyEHxAxb78/qsCJ3lHys2BQX3/vqadhC59Aa
         QzyELVRvUGzjIDEa3usegB/7GgRREgsTKj3evH9p+jjJsl3veFR6674rJeRAL4tvUAXn
         0/cxYAhaCBvrGLcpPTIRxRMGp2SFhR/msU215nLxFOhjN3h0t8IAf7vVAbkYpGcwy1uB
         /85aH+z5/6XD8gjjUgIZspSlAq6xhfX09xOWC3UkQVrGAyxpEhfBEN5UyviaG6vPfrTA
         ATQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw11xnLh7+z1heFfZxVMEP1N3wBX9joiaQkG0IW3zUpGNrELRshjExVIfJO5M6UqH2YOhc=@vger.kernel.org
X-Gm-Message-State: AFuF++kFm1H8lLaE3MFXPHBS/aR7UmmDcWYqiFhqlyMN1iygWfYReZPH
	uWg9MCTBudyKDCuj+bBLAeQIBeMaHQriAxk1HRfBQ4WpfWuCPKqSWYKw
X-Gm-Gg: AYBFou2/nAiOeu42EEcVdwGaE5yx7VMhvBERGIwV+Lb22SQYHdMki1Tw7PiE9j/gUCN
	bav4UFXtDKQl5QgosppGZVV4wdZCMbvGV54L3QFArjUTj6wi60ejDUSp6+irEsVcA+xkvXJQgVy
	DK61dvVNq9antOZqWXsjtGFEwq9liHHuiybRUc8z5siSRyd2L/4iYC6K723k6aloLiO1W5Agk8J
	weLcdquuQubFwhg9RMZfHQjPiTzN+ICwFBWi8eLBRh7TzMHLzP1MjunvNX7avv923XRAnJrkN5j
	4kXWL4fK6vCGyvxLttKyYBFeGlG+E5adjUKDjelI4bIEonbcx2CY/4alUerPHo1XdWTTQ64rLDX
	p6eRDo/P6TFgDfy35M72IBXIU+2yp3HAfCm27IlYBlpHT8YC4Z24kCfW4B3gL/qqP3IDY10uxpI
	zvAAh4Gw05kS8pPR1c4wV6AemHOLtX56N42OtqhS+NkJn6+1AHjk5KtLoLgLTMyh5kOj9CTzHOd
	8iDR7e3u80uwgV7W+HYqvT+2KlTTaI=
X-Received: by 2002:a05:7300:8818:b0:338:2485:ad03 with SMTP id 5a478bee46e88-33e8c53c0d4mr2821124eec.16.1790169436068;
        Wed, 23 Sep 2026 06:17:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:17:14 -0700 (PDT)
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
Subject: [PATCH v3 003/114] target-info: rename target-info-stub.c in target-info-def.c
Date: Wed, 23 Sep 2026 21:14:37 +0800
Message-ID: <20260923131635.1894-4-luoyonggang@gmail.com>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index f412d917d94..8bd2d725ca0 100644
--- a/meson.build
+++ b/meson.build
@@ -4330,7 +4330,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.52.0.windows.1

