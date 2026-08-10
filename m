Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11463A785A
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351606; cv=none; b=OdtHkKUA6vdbYvUGmo/vfoS1s6/PqUpToWAHOJW60V3LBiiAnpbB+xkC6KXz80soBEpo6QFgXYM2YsBmVSzxlTsyN2rICfQblYZWR1iPQ2ZowYjm2XhLesaP4qnh0y6IOBxJF2A848lEOfZTJ6TuPssImT8uWbu1yny4l7s4CZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351606; c=relaxed/simple;
	bh=DuOrRN+KHNxjvklGhWMzuV6RgcD6dyuST/swi0KclVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9ug2Zo49O3NigP1GzyvPSIIfY2iK2GIE8LlOfmz936ayNOGeXZcf1CDJL28YMNQGACXAL2LT3wvN8XgOQkpkagwnntpomTA12uJHEpktZyftvXcm7cZ2i5OyOrT9LCEC7Q61Lht/XvyeKX3gxDpqiCCyJVEy29BVuosnjqf19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07985309|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0198397-0.00211061-0.97805;FP=16418793524219815007|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hQN_1786350664;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hQN_1786350664 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:04 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for Hygon
Date: Mon, 10 Aug 2026 16:29:55 +0800
Message-ID: <20260810082956.1768042-9-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
model.  It selected the AMD legacy cache table only for CPUs with the
AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
explicit compatibility path fell back to QEMU's old Intel legacy cache
table.

The wrong table is visible through AMD extended cache leaves.  With the
Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
extended cache leaves.

Use the AMD legacy cache table for Hygon in this fallback path when the
new vendor CPU ABI is enabled.  Keep the old fallback for pc-11.0 and
older machine types through x-hygon-vendor-abi-fixes=false.

The default Dhyana model is unchanged because it provides EPYC cache_info
and therefore defaults legacy-cache to off.  The guest-visible change is
limited to users who explicitly configure legacy-cache=on on new machine
types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 569ef785ca..4d8364f1ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10329,7 +10329,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             env->enable_legacy_vendor_cache = true;
         }
 
-        if (IS_AMD_CPU(env)) {
+        if (IS_AMD_CPU(env) ||
+            (IS_HYGON_CPU(env) && cpu->hygon_vendor_abi_fixes)) {
             env->cache_info = legacy_amd_cache_info;
         } else {
             env->cache_info = legacy_intel_cache_info;
-- 
2.43.7

