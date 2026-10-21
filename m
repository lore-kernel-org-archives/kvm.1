Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600369;
	b=QFDj5VKS29CIB+AojhT1qZoY6cjoBbgZ7/n2uYIBmno8F/jmATnzIXzA8i7IHR/894Dr
	 7C0QhC0w8wsTyAc0fwYc3DMxg2jb3mk6rfzAQZIunfPsvJ+94WEYeIBz2A1LUaGpepMR0
	 TAF4Z5zNjXjfs/o4vNPuby6FrNU9Y3gaTNYBXdHwEIPPbupIbAngPpDqHLtQpC4SwkY4N
	 gDUyc9vrpqmO5h26RTkfabvh9bjC2a95FQTl1tzA0tq/pvdaY5CWXUbyZ1/BDXLkXz7xY
	 fHCv6kDXy/rYX+g40xlK1b0bihCxCQuvJjntq2FXuKCatCC5SP5f6bliGvsDK8fDpsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600369;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=M09Bt5Xqymo5EruqBYA5nEGo9deFrSjSyw/JX8fKg1E=;
	b=Xd72rinhZXl8OJbiBFK2bgzxhSTs/mIGL2bPW969qZOuxjJyc/gvsCllW0QWt1hZAHBO
	 z53UJkh38W0KI9pmzHvZ22X3gcJ+GX7aK3r1WAwDL2PKRTfnNDgRsXED3ZxiZcTP3Ubyt
	 8IA4UgpZCqn8GVaMVnuh/KmAr5zSSGI2r53cs34g4oc8vO0uYkuIp4TCX0UJoOcZV5Ytj
	 6egyOj4rz43Ti08ntl/zCfHxAkmVHn76O1xaEYcDpIa9udRq5Ds1IutA3Bb4r9MwgtFjY
	 iAUURM4vEEIhxFGIk/AIbwIdFjCgErFNAJPqAnFErVcTwGiW+axlrlPbwWoAj/XcEwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="M/uLaEZK";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A7606A334
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5A7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M/uLaEZK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M09Bt5Xqymo5EruqBYA5nEGo9deFrSjSyw/JX8fKg1E=;
	b=M/uLaEZKZBGgOinVsC8b8h2aNo50RZfrHVqMNY2Vayl+RTvAjSlMGdbLBk7A23xDe6ikH8
	ZPJG8ILavEVsMKdwMdxDXt4mU4OVHX2mCKVOiygADG/JJIbi4/ANyUQKinkugaOuWTehdl
	7ri1FdCdRs6w8q3Y9BhAXS1P56OdyrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-kmBmVSG3NiijxmWRoMD2EA-1; Wed,
 21 Oct 2026 12:32:46 -0400
X-MC-Unique: kmBmVSG3NiijxmWRoMD2EA-1
X-Mimecast-MFC-AGG-ID: kmBmVSG3NiijxmWRoMD2EA_1792600365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7807B1800578;
	Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 324EB1803A51;
	Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 217301827596; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
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
Subject: [PULL 08/10] igvm: add command line parameter support
Date: Wed, 21 Oct 2026 18:32:36 +0200
Message-ID: <20261021163239.1131460-9-kraxel@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Luigi Leonardi <leonardi@redhat.com>

Add a "cmdline" property to the igvm-cfg object and a handler for the
IGVM_VHT_COMMAND_LINE directive, which copies the string into the
parameter area the directive points at.

The command line is passed to whatever software the IGVM file loads,
such as an SVSM. For example, SVSM can use it to select the serial port
it logs to.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261019-igvm_command_line-v3-1-29aeacbd6cd7@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  5 +++++
 backends/igvm-cfg.c            | 21 +++++++++++++++++++++
 backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
 qapi/qom.json                  |  7 ++++++-
 qemu-options.hx                |  6 +++++-
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index d88268bf602c..7ec6c204721b 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -32,6 +32,11 @@ struct IgvmCfg {
      *           format.
      */
     char *filename;
+    /*
+     * cmdline: Command line for the software loaded from the IGVM file,
+     *          if it asks for one.
+     */
+    char *cmdline;
     IgvmHandle file;
     ResettableState reset_state;
     QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 935ba54f54f3..653f79bef58e 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -34,6 +34,19 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
     igvm->filename = g_strdup(value);
 }
 
+static char *get_cmdline(Object *obj, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return g_strdup(igvm->cmdline);
+}
+
+static void set_cmdline(Object *obj, const char *value, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    g_free(igvm->cmdline);
+    igvm->cmdline = g_strdup(value);
+}
+
 static ResettableState *igvm_reset_state(Object *obj)
 {
     IgvmCfg *igvm = IGVM_CFG(obj);
@@ -85,6 +98,13 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "file",
                                           "Set the IGVM filename to use");
 
+    object_class_property_add_str(oc, "cmdline", get_cmdline, set_cmdline);
+    object_class_property_set_description(oc, "cmdline",
+                                          "Set the command line for the "
+                                          "software loaded from the IGVM "
+                                          "file (copied verbatim, not "
+                                          "parsed by QEMU)");
+
     igvmc->process = qigvm_process_file;
 
     rc->get_state = igvm_reset_state;
@@ -112,4 +132,5 @@ static void igvm_cfg_finalize(Object *obj)
         igvm_free(igvm->file);
     }
     g_free(igvm->filename);
+    g_free(igvm->cmdline);
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index 5a1416fe8eac..4b9d78630863 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -161,6 +161,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp);
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp);
@@ -195,6 +197,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+    { IGVM_VHT_COMMAND_LINE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_command_line },
 #ifdef CONFIG_FDT
     { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_device_tree },
@@ -869,6 +873,33 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    const char *cmdline = ctx->cfg->cmdline ? ctx->cfg->cmdline : "";
+    uint8_t *param_data;
+    uint32_t param_size;
+    size_t cmdline_size = strlen(cmdline) + 1;
+
+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!param_data) {
+        return -1;
+    }
+
+    if (cmdline_size > param_size) {
+        error_setg(errp,
+                   "IGVM: command line size %zu exceeds the %u byte "
+                   "parameter area defined in IGVM file",
+                   cmdline_size, param_size);
+        return -1;
+    }
+
+    memcpy(param_data, cmdline, cmdline_size);
+
+    return 0;
+}
+
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
diff --git a/qapi/qom.json b/qapi/qom.json
index 49f222796ab4..4810d53e585e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -977,11 +977,16 @@
 #
 # @file: IGVM file to use to configure guest
 #
+# @cmdline: command line for the software loaded from the IGVM file.
+#     Its format is specific to that software.  Passed verbatim: QEMU
+#     does not parse it.
+#     Ignored if the IGVM file does not ask for one.  (since 11.2)
+#
 # Since: 10.1
 ##
 { 'struct': 'IgvmCfgProperties',
   'if': 'CONFIG_IGVM',
-  'data': { 'file': 'str' } }
+  'data': { 'file': 'str', '*cmdline': 'str' } }
 
 ##
 # @SevCommonProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b0f..f72f30e246d6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6496,7 +6496,7 @@ SRST
                  -machine ...,confidential-guest-support=tdx \\
                  ......
 
-    ``-object igvm-cfg,file=file``
+    ``-object igvm-cfg,file=file[,cmdline=string]``
         Create an IGVM configuration object that defines the initial state
         of the guest using a file in that conforms to the Independent Guest
         Virtual Machine (IGVM) file format.
@@ -6509,6 +6509,10 @@ SRST
         memory of the virtual machine and, depending on the platform, can
         define the initial processor state, memory map and parameters.
 
+        The optional ``cmdline`` parameter is a command line passed
+        verbatim to the software loaded from the IGVM file, if the file
+        requests one. Its format is specific to that software.
+
         The IGVM file is expected to contain the firmware for the virtual
         machine, therefore an ``igvm-cfg`` object cannot be provided along
         with other ways of specifying firmware, such as the ``-bios``
-- 
2.56.0

