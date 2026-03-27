Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436573EF66B
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619171; cv=none; b=j++KfsV6Fe/lcnLA+erCqrUTGABmAIgGHRmZIlYz8om3O2QStUvDi7m57ZV9QK867MzU6CpospQnj5/lNKdKtN4wodTpCJEMSL/lcTDNdNB1E3Yt3IWghO0+8/oef9Cud53+Hrs19la9GyYwhd07CXXklGcYFejvV75vaK5szyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619171; c=relaxed/simple;
	bh=M3mKnRIuDKs4NDJTUdrVebV0HAd1eZl9EMr4XSzrSDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNThiGTHKGN2WkJpkidyW1tngwRNOMkGvILBSeFwWKwPkInYd6qh0srRJtM4KyyECuWXUjnPltsC4pH34ZfkoC9TOxCkbbyZUTFGKem1ngA23xWp+ugOpcRNBKdUeKHW4wR2vYvBHhcLSJdGzEc8O2niDBrFZlXpVqASGjVlzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0Hffq32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0Hffq32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5I4/G72hvVsFtElipL0UZ7WDqmWzfz7Df4ICX/cOls=;
	b=O0Hffq32sREdE16Q90nwsM0RhHKg7F1tM2lpbrQfUTTcwBxph3WBs8vK2au/2TDXN0ow3V
	ujcxLuIutljpqtarRFurjYBSLRMCaFtlIeI4s4sZ+Gvqalbq+pUltyKa9LG/GaTkDLvG7y
	ZGvJErP/OxFJxrI6zG321t38FbUVKvc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-B3v5Nm5sNkuoJ7zD4fQKiQ-1; Fri,
 27 Mar 2026 09:46:05 -0400
X-MC-Unique: B3v5Nm5sNkuoJ7zD4fQKiQ-1
X-Mimecast-MFC-AGG-ID: B3v5Nm5sNkuoJ7zD4fQKiQ_1774619163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5067195608E;
	Fri, 27 Mar 2026 13:46:02 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86AA8180075C;
	Fri, 27 Mar 2026 13:45:55 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 15/15] meson: Don't require nm for non-modular builds
Date: Fri, 27 Mar 2026 15:44:01 +0200
Message-ID: <20260327134401.270186-16-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In the MSVC build environment, nm is missing; at the same time,
scripts/undefsym.py exits with code 0 at the beginning
for non-modular builds.

So, this change is harmless because it already didn't do anything
in non-modular builds, but remove the additional tool requirements.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 4a3fc306b7..cc9e9784e9 100644
--- a/meson.build
+++ b/meson.build
@@ -3908,6 +3908,9 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 audio_modinfo_files = []
 
+block_syms = []
+qemu_syms = []
+
 block_mods = []
 system_mods = []
 emulator_modules = []
@@ -4023,18 +4026,18 @@ if enable_modules
   if emulator_modules.length() > 0
     alias_target('modules', emulator_modules)
   endif
-endif
 
-nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.py')
-block_syms = custom_target('block.syms', output: 'block.syms',
-                             input: [libqemuutil, block_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, system_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
+  nm = find_program('nm')
+  undefsym = find_program('scripts/undefsym.py')
+  block_syms = custom_target('block.syms', output: 'block.syms',
+                              input: [libqemuutil, block_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+  qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                              input: [libqemuutil, system_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+endif
 
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
-- 
2.52.0

