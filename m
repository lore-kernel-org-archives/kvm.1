Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872D325704
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860052; cv=none; b=FSA9es/AZ7u9rAcLxRwzHPn97vl6NzH01WTbMyPNyj1n4e41tDbQ10A6sCBTGLrnzV7GGIFcw2f9krYF+t2UyQrUO21SVb7AMEAdwloxps6hiTv6KwPpoEF82RitlpXDI+UXFYIMBDGZGEgo15ZaFnYs62xPCSmncsWbDoCknJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860052; c=relaxed/simple;
	bh=d1ITr+F91RMHw7830BV85obVdmlMmLYgt1bwpC/pI5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jV0UoWl23NQtLETHgO6WvR9n5gugrjLvaJ4ZiIucQblK1CLsSxPZ9xceL2aMA9DaH4v2t4jHER4oRh5MLPukDFcMRfJDstIGkDWo2uF3QyjO2LJglnWdu4wvldETCPTjzFoh/HF72rhRlMR6IWnlW6ed76xmWN5dQ13nQbC5Nr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=K5Y+q+NE reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="K5Y+q+NE"
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63MCDTNX030696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 21:13:47 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=c6f8xHZahEQDw28PGKsEGeLYdPm2CEUuNXUGAafH/bE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1776860027; v=1;
        b=K5Y+q+NEM9CIQi34hFmbkuZOigsKb3+zWv5nzi9VKx5LXXaUAAL6Y1NgK4lBjMEJ
         jLNYXhfgj8a8Ab9qMNxdYDRbEKorOdX8Ut4GUGI+UeId/7g85j1VszVX6UoP+ru0
         drQFgaLj6tjh0zeQjpCxxMn2NHQ7offGRKyeVu5CYjJmcF2G+eG+DXIv2dgF15Ze
         OqnovCytaaDKIQKabeR4PBhWktf6nffKZ+dqZRuw10Hk9C/cuBIaSUQjdFEiO6Bm
         8TPxHuIXugT4nAlIZzC7UYt9mbibwaztojjLBJe7V4Ws9hJnHZ4RS10oJsB6zgCN
         TF+7ohEPHxzG/UnsJw/Wwg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 22 Apr 2026 21:13:26 +0900
Subject: [PATCH] target/arm/kvm: Mark host feature cache valid last
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMj3cSiXF0LkyQj45TEFANTM0MloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AP/7gvWcAAAA=
X-Change-ID: 20260422-arm-84b23dad0561
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
        kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047

kvm_arm_set_cpu_features_from_host() treats dtb_compatible as the host
feature cache valid bit, but kvm_arm_get_host_cpu_features() set it
before later register reads could fail.

Set target and dtb_compatible only after the feature data is complete.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
This fixes a semantic issue I found while writing the next version of [1].
I am not aware of any case where it manifests as a real bug.

[1] http://lore.kernel.org/qemu-devel/20260225-kvm-v2-1-b8d743db0f73@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH RFC v2] target/arm/kvm: Choose PMU backend")
---
 target/arm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b880..03c3346d50ed 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -329,8 +329,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         return false;
     }
 
-    ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,armv8";
     int fd = fdarray[2];
 
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
@@ -472,6 +470,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     ahcf->features = features;
+    ahcf->target = init.target;
+    ahcf->dtb_compatible = "arm,armv8";
 
     return true;
 }

---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260422-arm-84b23dad0561

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

