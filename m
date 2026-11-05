Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922458;
	b=t7kwCH+UZQNu6neohX0Q4o7kW3B6IpUFDdA3mWIDOETyleIy4hKqBlycCKSCOcq1WVos
	 NC1iaHpKu8RaQaWkC9yWF1s8xiJ7LqDSqmFIAxl0sKeW+KqSLaFPV/9OkjaCrwkIryZS1
	 9U8zLkJotYdP9+9Wc+ON0JWWDtwA7JX79cPGBxdRGEH3xpPSPfNIbN54GMSNduJpwslLy
	 HEOcVA9GFzISgnAOOFCkMXJLuisS5xVIQkm6qKVhl7twvp6NMMzcMGZ+9KD8Stg0Rk8xB
	 fNFFNPA8sOssTvbdJCcFU9geMT4O8KdAQHgV76rX3G+G/es6tyCFpXZYog3uBq8lKMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vppuJPSFZeGPAma4MS2y5frLVFc2Qg9ddu30RekCHa4=;
	b=NKAZwjatGBOgZtrQZBJFD0zmqaC281UxUqm53pv6dZoJ7TyIDbHi+byNHeB2DDEZqaGH
	 2GavHWCtFK+4bEiXoWJJNN8wa4GPizwGRsadbw5oQA4X6KSdUQ7g2tCVhsINCjY3e/5BH
	 WMC62Wyxl1P/FgJWS0+TkboGyvCKj+tEvlsc9V9HIOM8eCbyPHaXUIvaD7lWqvEB8SbTP
	 uLUPoe4+3c//hSi1P9dG/1WlBWInswTPL5dBBBJByoAS2XGi4hEHifgG+VuDzKEBtcXdH
	 1kNCHzVXXl7UI0lduiooFC1Rtm/ku95R80j9w3H1n+xmxbIv8vHVH+ALMxw+vAiM/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZT1SeCP5;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A63606A33D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A63606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZT1SeCP5
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed05900df7so686415ad.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922458; x=1794527258; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vppuJPSFZeGPAma4MS2y5frLVFc2Qg9ddu30RekCHa4=;
        b=ZT1SeCP5+JxLZdCKvh5EI0rMajSP6zCJdal3OeRXLRc1Z4/VXVP2X9Ls+fgx2mkMCf
         JOcGcHpEBOjnlXMrzEJ+SXQ0H/yaCyaGrKldaHGpVjx4DBMzLLU3/ebO8bi2+CQAg0TZ
         ucgLg/49c+ooG9cbigE/7iENAZ4+rcKLSnZBdO3aoLe0D2S2bYqPahBskIN0/lORZfrl
         7+WCue4HlQOiv/R8AQnt6UbuRJ56a3JTtWs2QxprNXQfwXj9hDRw9bBMEfp8VrhsO0QG
         Wf2taNmet1xjh4L137vQZN6BZQJg17gDvjT9lzty9LvCHTqtUWzjYczXNznY5Nx4LF+Z
         nePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922458; x=1794527258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vppuJPSFZeGPAma4MS2y5frLVFc2Qg9ddu30RekCHa4=;
        b=zyHR2lb1j+MZFKS7z8v/DUN/8CnP3EVAfAAnXz1x6tfkNCIOr3e8/VOXwwmAfNoYgu
         CW5whwU2xv4XoGNzTuYlkdEl+dE0G3A78PwkpDyKEHyhYe4QrQSBrkVulX9SRH1KkcnX
         NWK5OrY51WFDDxHJAV1yjZlWSTfCKjfBsLSeoSftAk3deTyYz7MU1V6YeY9fmk58vOZM
         FoTRaHS5zi3F9RwcZ7zRJFymfLbpjLy0uaxrN64nxC+TvDhMGISH3KONIVlKvbURwD4o
         nfVekUV+Nj5tkeaq/aoU0vRE0AVo+vbgnPJJNsPex7PZqO+56cfLe2cnVtQ0yU7x9RhV
         d5qw==
X-Forwarded-Encrypted: i=1; AKwUvBzeZQ/R95NOUesLKXxHMgmE4rjOpLL4yfNRe1hiMqmEH1hnmx+jkzTGhbABZjoQw1vYP6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ybheZYuqhvG4vzw4RAFxCVePeTrh4cV2nUHvHlwaJurfl12jb
	BmOhKCocXlnIQxbPxMoRiOIIdqAb0IT8v8xN2K6MNVPYVgOvm45TAIR+Jrya1xR//Jd7HbSw/gY
	Ab0waUw==
X-Received: from plsh11.prod.google.com ([2002:a17:902:b94b:b0:2e2:ec03:928c])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf4b:b0:2df:aed3:2ac0
 with SMTP id d9443c01a7336-2ed416a9ffemr13800745ad.10.1793922457565; Thu, 05
 Nov 2026 15:47:37 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:49 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=1655;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=V4TjxTrjbEWZZ89lwzM/hggtPKH7gxroDMryZjL/1oM=; b=e4e3a7HKXJEtxQDmamP9yWNpd6ntThLNO1R8K/2BpnR+Ks4Qi73B8ahTCyxAZj4l+XpTYE3BM
 50G9CQ/t/OSBI0sAAQ0FgZS8Qxl/1ussSPyihInZSFEEl0Dn3GTDpC/
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-5-2024e8fa517a@google.com>
Subject: [PATCH v16 05/20] tools: include: Add kbuild.h for assembly structure offsets
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Add the Kbuild macros needed to enable the filechk_offsets mechanism to
generate C header files containing structure member offset information.

Tools depending on assembly code that operate on structures have to
hardcode the offsets of structure members. The Kbuild infrastructure
can instead generate C header files with these offsets automatically,
allowing them to be included in assembly code as symbolic constants.

For example, the TDX guest boot code requires access to parameters
passed in the C structure (struct td_boot_parameters). This header
provides the macros needed to extract these offsets from C code and
expose them to assembly, ensuring the two remain synchronized.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/include/linux/kbuild.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
new file mode 100644
index 000000000000..957fd55cd159
--- /dev/null
+++ b/tools/include/linux/kbuild.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TOOLS_LINUX_KBUILD_H
+#define __TOOLS_LINUX_KBUILD_H
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, __builtin_offsetof(struct str, mem))
+
+#endif /* __TOOLS_LINUX_KBUILD_H */

-- 
2.56.0.455.g6c5a503b38-goog

