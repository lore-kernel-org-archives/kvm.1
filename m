Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2B37C0F3
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318315; cv=none; b=WFpU+FmTaX1U8RfUoU7bp5mPWylBKmGS3T8v1nI8VG6NctfMI9nd3zjjYMI7AUyAQVWpituFa4V4lWa13iAAMUQkkJJXSOkYq1WGUzg4HAdE84HULhYRYk209FKbvNlVxvHIgIYEWH1d19tH5+FAYt+JkKelPmYKWjF6xhhxbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318315; c=relaxed/simple;
	bh=6QdEcviyma3Qu4LLo5WT5Pqy0/BuIj2i4377ZRP+nmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+MvhrovBJbcm1PA9Ul2AwBP+GvBOP0jJBlokWAgSct/7Bovu8ZKgYObg4VKj7jg4QRW7pBhu21kXYlsnaOocYzaQ/D5C44Z3AZ7yKt9uIXzDz3dQd9bIXGhAUWwXD+ao1mIr5YiSwybfV3G5oADdkxc+KUS34pvibEDlKUipt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0854889|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0164078-0.000604772-0.982987;FP=16418801770556892254|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStuJ_1783317367;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStuJ_1783317367 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:07 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 8/9] target/i386: Use AMD legacy cache fallback for Hygon
Date: Mon,  6 Jul 2026 13:55:29 +0800
Message-ID: <20260706055530.1752094-9-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@open-hieco.net>

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
new Hygon vendor ABI fixes are enabled.
Keep the old fallback for pc-11.0 and
older machine types through x-hygon-vendor-abi-fixes=false.

The default Dhyana model is unchanged because it provides EPYC cache_info
and therefore defaults legacy-cache to off.  The guest-visible change is
limited to users who explicitly configure legacy-cache=on on new machine
types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 47f48f4a96..279c9b3ae7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10342,7 +10342,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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

