Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED732F764
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120245; cv=none; b=Ga74SJ0puqIlxnP+fEn+KghvklCDV0QgA9L00w8m/gkfggsBY4W1VYxB9DybcridLENmbhgvU0yClLUkDoNt/xReqNvL5/0X9HmRs0Uo4HkNkSpCFAeUG7lyQZwPV7E4X/VgXLpYbfAQTBwbJ3I1QN0ITP+jLjD+pjHRX1L9jJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120245; c=relaxed/simple;
	bh=+cpl3T8SFHY3Gfi2fQWk3ave1UpU+uDfXbpB7xi2HJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIsWVLNLDHE2tf9eoQnRK1qKk3CCDfR6kBt1/Sg5uye7wLkDGU7DqJhVzSOMu5O92/2Cf0qBX+sKyFL4AYYNfsyNgZa/XMjZmfHEaIZVcom1Fc0+MCWw1A7nCxWbEUL7XQiBMoep7vzGZIotwXNCj6gGKMqLHYsNo/l/xy4xFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBgZFXH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBgZFXH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loXsmGiHRJkptDEGOD1FfWEs1PUecmUMq7dO8U3G78k=;
	b=hBgZFXH9wYGk38SXtrfoK2GWc6gmloXppzuCGmyg7YIkkmDDYZIBqF/gLHB07kzu4p3elW
	JoGXJbI5Pb17zci9oeKaMry3DeG2Yw6F86Pj4epC27DxCQPxX4vrQBPzU3+qy7ayeqcDTZ
	80jHH+bJ1arZYJm3I5uPIYxI6/siokc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-N_6GyYj4OmS5QqCHGo2Kzg-1; Tue,
 03 Feb 2026 07:04:01 -0500
X-MC-Unique: N_6GyYj4OmS5QqCHGo2Kzg-1
X-Mimecast-MFC-AGG-ID: N_6GyYj4OmS5QqCHGo2Kzg_1770120240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7891718005B6;
	Tue,  3 Feb 2026 12:04:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9B0F30001A7;
	Tue,  3 Feb 2026 12:03:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 344DB1807DE5; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Ani Sinha <anisinha@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Eduardo Habkost <eduardo@habkost.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Oliver Steffen <osteffen@redhat.com>
Subject: [PULL 10/17] hw/acpi: Make BIOS linker optional
Date: Tue,  3 Feb 2026 13:03:35 +0100
Message-ID: <20260203120343.656961-11-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Oliver Steffen <osteffen@redhat.com>

Make the BIOS linker optional in acpi_table_end() and calculate the ACPI
table checksum directly if no linker is provided.

This makes it possible to call for example
acpi_build_madt() from outside the ACPI table builder context.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260130054714.715928-3-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/acpi/aml-build.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d80..ea1c415b211b 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/acpi.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "system/numa.h"
@@ -1741,6 +1742,7 @@ void acpi_table_end(BIOSLinker *linker, AcpiTable *desc)
     uint32_t table_len = desc->array->len - desc->table_offset;
     uint32_t table_len_le = cpu_to_le32(table_len);
     gchar *len_ptr = &desc->array->data[desc->table_offset + 4];
+    uint8_t *table;
 
     /* patch "Length" field that has been reserved by acpi_table_begin()
      * to the actual length, i.e. accumulated table length from
@@ -1748,8 +1750,14 @@ void acpi_table_end(BIOSLinker *linker, AcpiTable *desc)
      */
     memcpy(len_ptr, &table_len_le, sizeof table_len_le);
 
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
-        desc->table_offset, table_len, desc->table_offset + checksum_offset);
+    if (linker != NULL) {
+        bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
+                                        desc->table_offset, table_len,
+                                        desc->table_offset + checksum_offset);
+    } else {
+        table = (uint8_t *) &desc->array->data[desc->table_offset];
+        table[checksum_offset] = acpi_checksum(table, table_len);
+    }
 }
 
 void *acpi_data_push(GArray *table_data, unsigned size)
-- 
2.52.0

