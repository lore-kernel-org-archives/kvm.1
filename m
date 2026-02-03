Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204332F764
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120247; cv=none; b=KlQGkSi/ErdBfK2xGiVBGK7wD9Ivi0Smv+HgGkQJ9eUtYP6qDPqpjWjUwBfRy6EVees0Om9CtDIVDmzNxP9NPeBX4UVuHZJsZNU4XpiZlJZGEXNfL0vT2wL0PIkRM95M/mnUSZY47fn/pcfgRiSxYNdi22Mtm4zM1EzCnk5pTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120247; c=relaxed/simple;
	bh=iFD6ZOcHvQFg21wzAsAQpOE80J04zePFJr7kt8xDemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fveV+0e75at5ZbETAc8yXWOLM1rKPBtUtn1nJTxTLSrO9tz96wULp3Yf7ctySNXL8P/F+CnDccLDhigNZ1aTmQlFzrFC8MKC49RbXWnA8VMakNeFQwVplze8kgqmWfd74e0PmyVCiISHsJJWfRcIp/VCNMDKDbInDYn3qxORsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsHPuS7R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsHPuS7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULBT82r83PakWzRBR3bZIimvFJnaS5GsrH66SL5Ftko=;
	b=MsHPuS7RvoJtr8yDvFHo7OpfFN0VgC+e3VCFnhOi0LCeKgbHNuEDlekfRHb++XWxrR1Pg4
	rXRZIrgqKAsdygc9mHqvLnlW+Px2X8jJKVGRgE+apYEF2B5D/RDP3NV9bkhA6LUCh1+W7R
	ADDYGnTGu/3WaRKzaaH7EGFJmMSwf30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-NjpDmlDmMIOhX3JJFdah3g-1; Tue,
 03 Feb 2026 07:04:01 -0500
X-MC-Unique: NjpDmlDmMIOhX3JJFdah3g-1
X-Mimecast-MFC-AGG-ID: NjpDmlDmMIOhX3JJFdah3g_1770120240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ABF01954234;
	Tue,  3 Feb 2026 12:04:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B879719560B2;
	Tue,  3 Feb 2026 12:03:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 47F2A180AC1C; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
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
Subject: [PULL 11/17] hw/acpi: Add standalone function to build MADT
Date: Tue,  3 Feb 2026 13:03:36 +0100
Message-ID: <20260203120343.656961-12-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Oliver Steffen <osteffen@redhat.com>

Add a function called `acpi_build_madt_standalone()` that builds a MADT
without the rest of the ACPI table structure.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260130054714.715928-4-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.h | 2 ++
 hw/i386/acpi-build.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 8ba3c33e4831..00e19bbe5edf 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -8,4 +8,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 void acpi_setup(void);
 Object *acpi_get_i386_pci_host(void);
 
+GArray *acpi_build_madt_standalone(MachineState *machine);
+
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862ca..19c62362e31d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2249,3 +2249,12 @@ void acpi_setup(void)
      */
     acpi_build_tables_cleanup(&tables, false);
 }
+
+GArray *acpi_build_madt_standalone(MachineState *machine)
+{
+  X86MachineState *x86ms = X86_MACHINE(machine);
+  GArray *table = g_array_new(false, true, 1);
+  acpi_build_madt(table, NULL, x86ms, x86ms->oem_id,
+                  x86ms->oem_table_id);
+  return table;
+}
-- 
2.52.0

