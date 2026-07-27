Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCB2F9D89
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153131; cv=none; b=i0aFjI+S3xkmvNkLhk3DC6NtAi4XuD2LckweAF0vuDq7edzWRDYD+yAKUxCwdU6WEd5eDO9QQzm0S+yi/r55psXq8zdayaEoZvwdnhbBfIHPcJ/jnSftsRHr/e3GOdmw20/ZbiHqs6LADqsdP4GQy7+AOuVLl8n08tx9oh7G6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153131; c=relaxed/simple;
	bh=Mhhc24sMg3/r/S38Qe+3S85s7KlVq/EDYB1GAklx+k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNwXUsaRtQKZWduJV2Z8uoZPtDbeynNaw2dXWLD/qdWZP0oCBzK3JulinJqY8xbltpYz1v6HHEgsHtIsxFKNLbWKDDirZ+9KQyiSlqQNnKco+RtqT/rFfoCsu9cumkjC/7+FVSydIkOmag6Mr7rcJP4kKaZVwqTJjHTjwGYYYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ay5w1NNW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay5w1NNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785153129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5UQGqeTaYi2kaAkB+026BcAjPwRZW9Yj5wzH4u9ATk=;
	b=Ay5w1NNWz0ldO5sKLdLM3GsQuWZ045hj2FggvAX99fXiD1MAWh2LMheMP7oiOIoWuhZwxH
	p8pl1SCFuW5BhSkQbVrqUqlS6+V15kbXQSAHAkRizkr75eo8bcm0PH3mpf4qFvCt3LY0c7
	kY6wrEpkjN0qi12n0BHpqiIuffxZGYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-BLrv8nnUN0q04OGhaR7ezw-1; Mon,
 27 Jul 2026 07:52:07 -0400
X-MC-Unique: BLrv8nnUN0q04OGhaR7ezw-1
X-Mimecast-MFC-AGG-ID: BLrv8nnUN0q04OGhaR7ezw_1785153126
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EACF8180264B;
	Mon, 27 Jul 2026 11:52:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B732429;
	Mon, 27 Jul 2026 11:52:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:15 +0400
Subject: [GIT PULL 06/23] target/i386/sev: fix MemoryRegion reference leaks
 in gpa2hva callers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-6-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mhhc24sMg3/r/S38Qe+3S85s7KlVq/EDYB1GAklx+k4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+fGj1ciGYg3/G6BtXKbg01aMqoGrpUPrq6
 0Eq0DGF1/WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5RgqEACKwy8dkLIU6JwSGzDKMtVXkr7DEfaFR3siAcCWRK56vUVxeOAjrGtp7g6AGSeQusDHnTK
 JRF379tFVLKYhql12Y2sMGF9OFA+0ttIeSgzujJhqZvpcL5Tpf6EE9UUE0aEjZooDJNCsw8/dik
 DnKcpLzXSHueyJCVcbtOQDzX+TxV3hwGaRu5NOykg1xIvJZdF0ydMrtgltiSAnpSanHNbIJ5mdQ
 ydwHv/QXaoEVbn9qGHsdRdXs4P9fAHUvkZtJ44zXps3+MPsFsXoz6r767J17oEcpyoBjBnwQ8bA
 y1BaM4Owwm/QPRRmlUa6DjdDrGphJ3QTfGkedTmfSuoK4vrXpK6EMeKwNs/sN/Mk6WAYGXCqkhq
 I15cWgKFMR35c2Ye/czw9wlQK26TSRXvjmSVG8YWcM0Pwt5ZWLqQnJFaG3Cl3G9r8rJuAJPRR1d
 0xfD+G+RUzGAqWtn4Zd/koJjhgwN2IrYcdIe9P1Umw1IdOzVjhIKoGodZpKLQWmMQCE0q/2RIpV
 de1L2pYHHjY+x/s9SGuqXnSHF7CrZ0udwZRsaItFM1RPaiFb3fkWnsmOCZBbcnnPKuF4tnLYZM9
 R2rJO7r8VbuZvKGo0un507lqwc6Ob7XeUeiCqcq1kx9wND0tUae5GEY2yB5L3XvBavWFaERtzie
 U01/X2mJUzRjcqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
(inherited from memory_region_find()), but both SEV callers were failing
to release it.

Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
---
 include/system/memory.h | 2 ++
 target/i386/sev.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 47a0e06fbf8a..2192fc9bdc5b 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1085,6 +1085,8 @@ void memory_region_ref(MemoryRegion *mr);
  */
 void memory_region_unref(MemoryRegion *mr);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
+
 /**
  * memory_region_init_io: Initialize an I/O memory region.
  *
diff --git a/target/i386/sev.c b/target/i386/sev.c
index debe6344ab4d..d7dcefc8ecf5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1569,7 +1569,7 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
     OvmfSevMetadataDesc *desc;
     int type, ret, i;
     void *hva;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
 
     for (i = 0; i < metadata->num_desc; i++) {
         desc = &metadata->descs[i];
@@ -2063,7 +2063,7 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     int error, ret = 1;
     void *hva;
     gsize hdr_sz = 0, data_sz = 0;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     if (!sev_common) {

-- 
2.55.0

