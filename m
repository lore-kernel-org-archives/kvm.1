Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421002FF661
	for <kvm@vger.kernel.org>; Fri, 30 Jan 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752061; cv=none; b=B9dLfcsG47prZ44j0bo+2syBqPD75r0VQxW79fC2Xi304hfX65hSq5otVqt1khePUNQZ+0qZdL7I7io0jA4kgtQDU6E0e3iZlrcTfFrrilLlIgJbfZnp2Aon4m4rPofB4bx4sufsZv4h2Xd8gUQFi8Hs2hadyI4dsaELmjFRnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752061; c=relaxed/simple;
	bh=VgdPqso05BBXsk7/4ca2YPhOXzG1BPzptBnz3o61sas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkBO7ZDXUeDoJMkkd0Yau8c02YSaDKlTPwvb2lDsW62GyUHzTcdu4JJHSoGg/lOQl9FsUvQBHLbUNxM9gpPzP3+61czAC+przz+xstWKbvByoijQwNTHVkprR6LKUJLUgwQkvnuLZs3NIstQkCv4AuPSXT0kTmnDCUWJaGS421w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkDs2wm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkDs2wm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769752059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yihyRuKUsLo1MHTOSBv92Ge1QUi7oTtmEmgQnooQvNI=;
	b=HkDs2wm6Q1k3wbpNZkxYpGOnu9njEo1BzRUSG4IlRk6RgLzDBE07DOUmrg82YsatP9dFxZ
	XcVHb6ZbZMG4Xbrv7jl2wIW26H2VgP06UlAnCnS0X6ovqdZiDDNLNgsgoL2QMnfVmq5HRc
	ugLnqnCKoFh2I5x/9osD+b1Uv0DsdBg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-PQpvQy30NGSEEhUGuPyn_g-1; Fri,
 30 Jan 2026 00:47:35 -0500
X-MC-Unique: PQpvQy30NGSEEhUGuPyn_g-1
X-Mimecast-MFC-AGG-ID: PQpvQy30NGSEEhUGuPyn_g_1769752054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3CC018003FC;
	Fri, 30 Jan 2026 05:47:33 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown [10.45.226.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2628219560A2;
	Fri, 30 Jan 2026 05:47:28 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Ani Sinha <anisinha@redhat.com>,
	kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v6 2/9] hw/acpi: Make BIOS linker optional
Date: Fri, 30 Jan 2026 06:47:07 +0100
Message-ID: <20260130054714.715928-3-osteffen@redhat.com>
In-Reply-To: <20260130054714.715928-1-osteffen@redhat.com>
References: <20260130054714.715928-1-osteffen@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make the BIOS linker optional in acpi_table_end() and calculate the ACPI
table checksum directly if no linker is provided.

This makes it possible to call for example
acpi_build_madt() from outside the ACPI table builder context.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 hw/acpi/aml-build.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d..ea1c415b21 100644
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

