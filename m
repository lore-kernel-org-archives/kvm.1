Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600370;
	b=1Eh4KEa7Y16dOeMI9Ow90NClgFbpytR5JE1kDzek+ZJHzu3dgSzHmEDgZUmct1chZPg5
	 TVraRhzebeE9TD7D8Zt0ULaUiciuAoJS+i48uz8qVbikA5ZeGonE0w8bIDqrxouDVpZA5
	 mZsQrRuB5xNU9tBjAwGTafEeQXQGkxK4s94ztsBalUTYYk6jxnVHI1eFtNUFbanzpcluF
	 5zN3DDL6Y022l7oYO+liBxXrEUKU0bOXmt83WU0UiprtIdcuGwRma3ixn3UJTXjwMU8EG
	 vHwX0XTNs6d3C1hA0bE79afNV58dMROSQDPmxGIpIT1LihbhcjqgmQvuE6wfNv/L4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600370;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Oi199wsf8nTgvRE+hN//iXiFJETYhH2ljQFRicUL4uc=;
	b=2kgzKjalvid14AAFsVWCa0DvUezks17jnC66fS0uI85wSK7kmmsxuBzofz7kL+YrQ/71
	 iyhGAQV9wrUEOiRBteek865SX371wKk5ISY1I/rQowfFJE0JhunOiwGHzYBPR+fNMq+cc
	 8mV0y17bNXaL4zR1cd5E66U0lD9/BzbiLWiA/GHZIZQzZqdZCKaPaYguOzDAM210o/0X/
	 0n//qjCvD8f4iXNmYexfrvsHi7QiGWb+kGcFPzc6VrwA/+UPf0s242/17ix4+FWeGyVvu
	 MwyvTDljQ5E1iTy+0HZJdyFn8GVm6r/2/36RlLZ2kh0lXYSrHqidTS8Bligec8Mq/jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foZZudLG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F6606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F6F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foZZudLG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi199wsf8nTgvRE+hN//iXiFJETYhH2ljQFRicUL4uc=;
	b=foZZudLGENB//PT6EqhTtSOgA6U3HbO47CZ4UnlAZf/cT6u/CPnyoCKlbEV4Dzv33Jbbxx
	AZKVTDl2a0L73xMlVazMINCTBXoxm+U+SAmZHwRmMhDGG9m1I/bMbNpnVQq71Q0lLCmrvf
	+wlM/jiO2fh8ToaATffx5swwFD9a4y4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-6p3gm9sYPdqHSWpBhsvuEw-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: 6p3gm9sYPdqHSWpBhsvuEw-1
X-Mimecast-MFC-AGG-ID: 6p3gm9sYPdqHSWpBhsvuEw_1792600364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4646195608E;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B2F8362;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id EEBD91827594; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 06/10] backends/igvm: supply an empty device tree when the machine has none
Date: Wed, 21 Oct 2026 18:32:34 +0200
Message-ID: <20261021163239.1131460-7-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Luigi Leonardi <leonardi@redhat.com>

Commit 1c4bd8f13c ("igvm: add device tree parameter support") added
handling for the IGVM device tree parameter directive. The handler
fails when the machine has not built a device tree of its own, so an
IGVM file carrying that directive cannot be booted on such a machine,
for example q35.

An empty tree satisfies the IGVM file's request, so build and supply
one instead of rejecting the whole file.

While at it, rename fdt_packed to fdt, which better reflects the
content of the variable, as it does not always hold a packed fdt.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260923-relax_dt-v1-1-ff40f2a06acd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index ef45794744bc..5a1416fe8eac 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -29,6 +29,9 @@
 
 #ifdef CONFIG_FDT
 #include <libfdt.h>
+
+/* Enough for the header, the memory reservation block and an empty root node */
+#define EMPTY_FDT_SIZE 256
 #endif
 
 #ifndef IGVM_VHT_OPTIONAL_BIT
@@ -871,7 +874,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    g_autofree void *fdt_packed = NULL;
+    g_autofree void *fdt = NULL;
     uint8_t *param_data;
     uint32_t param_size;
     uint32_t fdt_size;
@@ -881,20 +884,27 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    if (ctx->machine_state->fdt == NULL) {
-        error_setg(errp, "IGVM: device tree not available");
-        return -1;
+    if (ctx->machine_state->fdt) {
+        fdt = g_memdup2(ctx->machine_state->fdt,
+                        fdt_totalsize(ctx->machine_state->fdt));
+    } else {
+        /*
+         * The machine doesn't build a device tree of its own.
+         * Supply an empty tree rather than rejecting the IGVM file.
+         */
+        fdt = g_malloc0(EMPTY_FDT_SIZE);
+        if (fdt_create_empty_tree(fdt, EMPTY_FDT_SIZE)) {
+            error_setg(errp, "IGVM: failed to create an empty device tree");
+            return -1;
+        }
     }
 
-    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
-    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
-
-    if (fdt_pack(fdt_packed)) {
+    if (fdt_pack(fdt)) {
         error_setg(errp, "IGVM: failed to pack device tree");
         return -1;
     }
 
-    fdt_size = fdt_totalsize(fdt_packed);
+    fdt_size = fdt_totalsize(fdt);
     if (fdt_size > param_size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
@@ -902,7 +912,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    memcpy(param_data, fdt_packed, fdt_size);
+    memcpy(param_data, fdt, fdt_size);
 
     return 0;
 }
-- 
2.56.0

