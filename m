Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CB125AA
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319074; cv=none; b=QFjPs887tHWwVSmmn0XH3phCgxUd3KF1gEcD3kJ7GIjAtiK8+bk5B4HZUAhehlWeKLMJ4Y589Y7NSEZZlZ69pKOdiuyicr7xeQ2sFRjpTwH5ORRh6NgQwe0v4TcJqslVCmZA2mVPSu6wguQualxQR48LujY+w4sEUg34MnbVNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319074; c=relaxed/simple;
	bh=owTdgCW7z+9rJcjQ83R8ZEybDyEY8YNmwtxW2tfBqxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pix0Omxh2hgpx2C7Lr8B4KLDEpFKcvLSbLJto36h8PrbUMoe+w6iwLK0ZktbPs4UAg2jp8HBnmNW8mwSxDCARITu/tJTTE2gJlIbyZ+xwhgCW2ZKfkoa4zRWpcCGM0BfcC2aeDAh5aSZucGUvktv4ejZHQz9ItCQ50toKsy85rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NX6uJmTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NX6uJmTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3mpIj7kKLWQd1wHYRB/isiRg9MwxmXnW9JJf/oFUXQ=;
	b=NX6uJmTVIk2ZveQlf/yljfZJcy5dlA8RAf7WPpTBoV5GlEwRQ0tp22hY0XERGznGKQhhjC
	dgfvvMxZ5dan18ojCZzgDEBUsRWI0CVg1Oph8bKqUYI0LbP8PdVp1KUVe5Yyyt26ErqrJP
	ijVfeNnB8cN/OfpxLuVV0KwUHoCIkik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-66sLjyeEMly5eSJMVCE_XQ-1; Mon,
 27 Apr 2026 15:44:27 -0400
X-MC-Unique: 66sLjyeEMly5eSJMVCE_XQ-1
X-Mimecast-MFC-AGG-ID: 66sLjyeEMly5eSJMVCE_XQ_1777319066
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21D2A1800345;
	Mon, 27 Apr 2026 19:44:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBEBE300070A;
	Mon, 27 Apr 2026 19:44:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:19 +0400
Subject: [PATCH 20/41] target/i386/sev: add finalize functions and fix
 leaking setters
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-20-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=owTdgCW7z+9rJcjQ83R8ZEybDyEY8YNmwtxW2tfBqxA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVh3bge/hfu7M/mrWwNzqJk9dgdWrhJfDTA
 kRvwWFs6TaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5YS/D/44TGXRiKZhlIVanFn8435rX5HTctjAkmt5JVuGq93W2jX/6NB9o6p+UYPrvNcz9xeRued
 +67951etfZW+rt4Eht7tX7nN0YOf/FTLnHAcrkFfdyMR8r/lP1Bne4qhDdLnTBkqwfR2IbgT+Uw
 hGQMpc83p4WHRo+nQpHAO93xbH6bOW2XgbTemdwaO7DVK55JxBA/0713I6qlm7+QcF/WdRTSYEU
 sKU+9Dm0DSqltJQ51JM3jRvLju6Q8PNeybeDNSlHVDjoD1aVJu0TN6KCcPALc9i1LCwmgcK6qyx
 ALotZh3NJtOPxjSX57aKsaJZvFetSCXYrNE3ql9JR1GxYX4GzEsOQW7er/UZ9bLBaASoCdGjORe
 P9sgw6t/PW9pYfqPl9cIaMKmia9jQo/ZRJZna7AhQ45RL05aFzfMNeLgumaNBVRE1czuRFJyCv1
 Samt+ncT7GrJeym2Wez9sNueqBlRrs66CYhuxSHHDkivA1N2xS/d36PeLP5+2jutCNLBM+zm/R0
 CWHbHUYoDSByF3H2u8jnMcnBU8EQhbF3JS4EgMgb5EgDucaoY+Rl+cfDDNJzjGIEZLkI/eWP3PQ
 WD8uGBEZb2cFIMJLQP978qKhVyi5RV2oyjGehUIHCIGv/HeorfSWgIfBQdFTUS8224kAPRlquV7
 Pt/qLRCMLtb+Xag==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

None of the three SEV types (sev-common, sev-guest, sev-snp-guest)
had instance_finalize functions, so all string fields allocated
during init or by property setters were leaked on object destruction.

Add sev_common_finalize, sev_guest_finalize, and
sev_snp_guest_finalize to free the allocated fields.

Also fix sev_common_set_sev_device, sev_guest_set_dh_cert_file,
and sev_guest_set_session_file to free the old value before
replacing it.

Fixes: a9b4942f485b ("target/i386: add Secure Encrypted Virtualization (SEV) object")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 261b6aaa37b..3c2734ad83b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2527,6 +2527,7 @@ sev_common_get_sev_device(Object *obj, Error **errp)
 static void
 sev_common_set_sev_device(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_COMMON(obj)->sev_device);
     SEV_COMMON(obj)->sev_device = g_strdup(value);
 }
 
@@ -2831,12 +2832,21 @@ sev_common_instance_init(Object *obj)
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
 
+static void
+sev_common_finalize(Object *obj)
+{
+    SevCommonState *sev_common = SEV_COMMON(obj);
+
+    g_free(sev_common->sev_device);
+}
+
 /* sev guest info common to sev/sev-es/sev-snp */
 static const TypeInfo sev_common_info = {
     .parent = TYPE_X86_CONFIDENTIAL_GUEST,
     .name = TYPE_SEV_COMMON,
     .instance_size = sizeof(SevCommonState),
     .instance_init = sev_common_instance_init,
+    .instance_finalize = sev_common_finalize,
     .class_size = sizeof(SevCommonStateClass),
     .class_init = sev_common_class_init,
     .abstract = true,
@@ -2856,6 +2866,7 @@ sev_guest_get_dh_cert_file(Object *obj, Error **errp)
 static void
 sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->dh_cert_file);
     SEV_GUEST(obj)->dh_cert_file = g_strdup(value);
 }
 
@@ -2870,6 +2881,7 @@ sev_guest_get_session_file(Object *obj, Error **errp)
 static void
 sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->session_file);
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
@@ -2937,12 +2949,23 @@ sev_guest_instance_init(Object *obj)
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
 }
 
+static void
+sev_guest_finalize(Object *obj)
+{
+    SevGuestState *sev_guest = SEV_GUEST(obj);
+
+    g_free(sev_guest->dh_cert_file);
+    g_free(sev_guest->session_file);
+    g_free(sev_guest->measurement);
+}
+
 /* guest info specific sev/sev-es */
 static const TypeInfo sev_guest_info = {
     .parent = TYPE_SEV_COMMON,
     .name = TYPE_SEV_GUEST,
     .instance_size = sizeof(SevGuestState),
     .instance_init = sev_guest_instance_init,
+    .instance_finalize = sev_guest_finalize,
     .class_init = sev_guest_class_init,
 };
 
@@ -3195,6 +3218,19 @@ sev_snp_guest_instance_init(Object *obj)
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
 }
 
+static void
+sev_snp_guest_finalize(Object *obj)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    g_free(sev_snp_guest->guest_visible_workarounds);
+    g_free(sev_snp_guest->id_block_base64);
+    g_free(sev_snp_guest->id_block);
+    g_free(sev_snp_guest->id_auth_base64);
+    g_free(sev_snp_guest->id_auth);
+    g_free(sev_snp_guest->host_data);
+}
+
 /* guest info specific to sev-snp */
 static const TypeInfo sev_snp_guest_info = {
     .parent = TYPE_SEV_COMMON,
@@ -3202,6 +3238,7 @@ static const TypeInfo sev_snp_guest_info = {
     .instance_size = sizeof(SevSnpGuestState),
     .class_init = sev_snp_guest_class_init,
     .instance_init = sev_snp_guest_instance_init,
+    .instance_finalize = sev_snp_guest_finalize,
 };
 
 static void

-- 
2.53.0

