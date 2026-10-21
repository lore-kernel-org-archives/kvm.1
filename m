Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600367;
	b=3NvN/MNmLDLpVKuewkxQrmEvkBawxRMUc9piB599rDfB9A7v2StMjZF4YvzTGxH+FpTS
	 GjddX4EUBEHpdGYEMFwXCI3/x+xAoR3DdvLQVpMrCjZPFwyqkhx2e9kY+uc3OJ3SaYpbo
	 Pt492jQC0RfzbHpbtXQu/p4N1hsz5S7aOTMzNt673XusJdfXP05UZIGknpdn839c2G3e3
	 5jIZJQXrUKxwD8Hrww/wzwgLbtqdFwxwpixq+MuUBpoeJifcT7N2fV91kUQTyGhL8wf2A
	 HXFCw2V/8v6q+yHQOO34ZDpim0A5Ze8CA6aa72YnMMQo5QSkmHrCuCMfgGMRIgTBqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600367;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=mo9A88zTUtWCxiYeFyiKtbxLLu+CYvfULiG4sQRriTU=;
	b=T5CgXVgV96ejE+t+dwf0VvV8U2gSjj3jX57pJFRSVFZ8AMoeFjdgk86bQa+4jm6jXEr1
	 L+6M693qQn0ifWjg/cHyupDdEjb46UN9Tbk+Yx1+zOonczZvThK+y6luwlvlk4dnl/75N
	 5THF+i+F3GbgDhC9AcACddTnKQ8u+gXpS7diITqCvYsxmYJz/J9asUosBZqjnV+hk4z+G
	 lhvdmYAiNpLG3TYSl1NwOwLVI6p2R1G/cE4sPnOln9rse0eTG3VHjdDEaaJl70cTypS1G
	 ++A/WWKSfNQsWD8BIYr3iWd6dMsPaICx7SC7rGs1tK1rhL7/mDMQUiJB17zuoe4mSaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6WhFBs9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C251606A320
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C251606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6WhFBs9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mo9A88zTUtWCxiYeFyiKtbxLLu+CYvfULiG4sQRriTU=;
	b=Z6WhFBs9lg7N0ZTc2fR3p5eaIR4zu+jwNMXTHXKlNMPaUPQ3FTY9DtdxBnH1AhLFSu9kS5
	kUVfe/No+1rLS0Gl9e5j2FP6880SqGxP+tlO2tHRN3OWrj+tsxZtDcKrMVxBf/zBaLwp52
	B3aDG2MQeqM87R/7fAvig+QvJROmrpM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-vDBKqBqAP3i7Vvm3pvuLVg-1; Wed,
 21 Oct 2026 16:32:45 +0000
X-MC-Unique: vDBKqBqAP3i7Vvm3pvuLVg-1
X-Mimecast-MFC-AGG-ID: vDBKqBqAP3i7Vvm3pvuLVg_1792600364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01EA31956089;
	Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 821087D5;
	Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C3FCF1827592; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
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
Subject: [PULL 04/10] i386/sev: add a get_guest_policy callback
Date: Wed, 21 Oct 2026 18:32:32 +0200
Message-ID: <20261021163239.1131460-5-kraxel@redhat.com>
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

The next patch populates the SEV-SNP ID block's policy field.
That value must be whatever policy is currently in effect on the platform
but there is no way to read it back: the policy can come either from an
IGVM GUEST_POLICY header or from the command line, and the command line
sets it directly into the SEV/SNP guest struct without going through IGVM.
Reading it back from the platform is the only source that always reflects
the value in effect, regardless of where it came from.

Add a get_guest_policy callback to ConfidentialGuestSupportClass for
this purpose. It is not yet used; the following patch wires it into the
SNP ID block population.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-4-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/confidential-guest-support.h |  8 +++++++
 backends/confidential-guest-support.c       |  9 ++++++++
 target/i386/sev.c                           | 24 +++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 6d35ddb97a75..27ae0a21b6ad 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -137,6 +137,14 @@ typedef struct ConfidentialGuestSupportClass {
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
                             uint64_t policy, Error **errp);
 
+    /*
+     * Get the guest policy currently configured for the confidential
+     * platform, be it from the command line or from a previous call to
+     * set_guest_policy. Its format is the same as for set_guest_policy.
+     */
+    int (*get_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp);
+
     /*
      * Set the SEV-SNP ID block and ID authentication block. These are
      * passed to SNP_LAUNCH_FINISH to provide signed verification of the
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index d60d1f6eaaea..91701f1a5f5b 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -46,6 +46,14 @@ static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return -1;
 }
 
+static int get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp)
+{
+    error_setg(errp,
+               "Getting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -71,6 +79,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->get_guest_policy = get_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 38f97fd9b2b3..f11fdb6590ef 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2758,6 +2758,29 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static int cgs_get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t *policy, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
+        return -1;
+    }
+
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        *policy = sev_snp_guest->kvm_start_conf.policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        *policy = sev_guest->policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2888,6 +2911,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->get_guest_policy = cgs_get_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
-- 
2.56.0

