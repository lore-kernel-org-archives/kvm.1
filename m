Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D33AD51C
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148925; cv=none; b=HVuAnStCm1GL0PKVbujn586R1lVnfn9Aut4cm0/k7ZGYsthQKulE43E+3wbHu/tekiLZvfjyDAAa9edtSkHcF45jwHPVTj01fq8dev9qjhWt7OVq9EGLnN7dUXxg5pM3/Z4Hf5YS0ofdNJAoA5+iyXYnGmVcWzBNrPKwiHAt2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148925; c=relaxed/simple;
	bh=bnL+tp1vHCrRLvS1xchXw+fChY4GYRrF/2lrO/9JAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM5Uc7hoqy/sfxDVkDZwW8sWiKSbKINweb/mZoAgtrrrSQdISvxcanPc/3Kwzj3bfy7YmiOcW2k4chsJwuqDp9RDH2V1kDW1Uqok00nT4ITn47atQbv8wXwcsfPZmVtwIjLUprjif0mqsJfCx4wz3FEPHceyO8K4sKd/GptlA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlVUNqJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlVUNqJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWghBUkeSE3zI2cdCfl1UKaHfHhMgE7oEA7r9bNf++E=;
	b=YlVUNqJPSyA4CJLb9YV6yh5o82k9mz4gBmSe5KI8cbnWun6wWNJBr3Cwo0ZYIrn78vG+4M
	1HDo7Hn/kxoHUudz+llELmPr7VvuR9OgGrrwMg57lXzZs1AO6MWBuzIdaDu9WClel2RmNU
	X3ZBKUvaGfk7uXLpk04/KUsioObISLg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-7si1zSQGNJiQhW1BCcNKQg-1; Tue,
 10 Mar 2026 09:22:01 -0400
X-MC-Unique: 7si1zSQGNJiQhW1BCcNKQg-1
X-Mimecast-MFC-AGG-ID: 7si1zSQGNJiQhW1BCcNKQg_1773148920
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A499180056E;
	Tue, 10 Mar 2026 13:22:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE5DA180035F;
	Tue, 10 Mar 2026 13:21:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id F3F681800865; Tue, 10 Mar 2026 14:21:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 2/3] igvm: fix build when igvm is not installed in a well known path
Date: Tue, 10 Mar 2026 14:21:53 +0100
Message-ID: <20260310132154.2783257-3-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
References: <20260310132154.2783257-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Luigi Leonardi <leonardi@redhat.com>

`stubs/igvm.c` includes `igvm-internal.h`, that in turn includes the igvm library.
This is required just for the QIgvm declaration and creates an
unnecessary dependency on the library.

Since igvm is not listed as a dependency of stubs, this results in build
failing when the library is not installed in a "well known" path of the
system.

Add a forward declaration for QIgvm and move the definition of
`qigvm_directive_madt` to `igvm.h` so that we can drop `igvm-internal.h` from
`stubs/igvm.c`.

Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260309-master-v2-1-7e02f07a1096@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/typedefs.h        | 1 +
 include/system/igvm-internal.h | 9 ++-------
 include/system/igvm.h          | 5 +++++
 stubs/igvm.c                   | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acead..cbe6f7f4c7c1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,6 +102,7 @@ typedef struct QEMUSGList QEMUSGList;
 typedef struct QemuSpin QemuSpin;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
+typedef struct QIgvm QIgvm;
 typedef struct QList QList;
 typedef struct QNull QNull;
 typedef struct QNum QNum;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 38004bd908e7..76ae1bc3be92 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -42,7 +42,7 @@ typedef struct QIgvmParameterData {
  * QIgvm contains the information required during processing of a single IGVM
  * file.
  */
-typedef struct QIgvm {
+struct QIgvm {
     IgvmHandle file;
     MachineState *machine_state;
     ConfidentialGuestSupportClass *cgsc;
@@ -67,16 +67,11 @@ typedef struct QIgvm {
     unsigned region_start_index;
     unsigned region_last_index;
     unsigned region_page_count;
-} QIgvm;
+};
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
 
-/*
- *  IGVM parameter handlers
- */
-int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
-
 #endif
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 5573a6111ae7..f9231f03ec80 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -27,4 +27,9 @@ int qigvm_x86_get_mem_map_entry(int index,
 int qigvm_x86_set_vp_context(void *data, int index,
                              Error **errp);
 
+/*
+ *  IGVM parameter handlers
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+
 #endif
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 47d5130d9d74..9e9f683fc960 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm.h"
-#include "system/igvm-internal.h"
 
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
-- 
2.53.0

