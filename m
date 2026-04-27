Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6D41B35D
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319107; cv=none; b=RQAUYU+63rRDbTrivRkcE8TOZnMfqCHjOgMY6Y8nDBaqGXY6dYYs0L72MAZQByWX1vFc00SM4XjpJx60rpsNEArZTjeb8Iz1yl1sOvHaDfydbY1QGuVPovWizvEpcjFhHzxXt7Is8fGYoOsE0/vJnk8EZCzDMudJqRBocSfSKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319107; c=relaxed/simple;
	bh=kb8aCpIeuANYOHpQ9UF6rV+rRvi+Joa1R7pBjpmZggY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dr1w7yvuFoT2Izsn3D0Pr9Gukpct7e3pms/PcwBAolYeFdGVA7yrSFhJp6YKdXpwDNuYcTRaObcKNjPau2auaqTx5ukA6eGMYk0dXfFpbYw0gNyoj2wCXDzMEXZTLl/kousZsy8fk0Ni345YH4/h4JpG0tPaxhVei+/u5my3T5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9Nexzl5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9Nexzl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jswsE+qpixbv6iOMTTcNCxgSkRm1F5eNCKVbDRXPEJ8=;
	b=C9Nexzl5vWN66MjFkBhnW6ZqJadlNnWUa6wpefFrShRz/s2AiAAPiUAQlvVp5Ws5DSBJ7x
	fTzeI/Yek1kDfZ+Y74gvce5H3UVRC33JDLRVcu/nwcrZsmvXCUai7MZAm+UwwvvY/Y720P
	5T5lC0MDNR6pJLKLNWi+AftNexyBtUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-lz-EHQIzMRC18mRq1xyT0w-1; Mon,
 27 Apr 2026 15:45:03 -0400
X-MC-Unique: lz-EHQIzMRC18mRq1xyT0w-1
X-Mimecast-MFC-AGG-ID: lz-EHQIzMRC18mRq1xyT0w_1777319102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFE8719560B7;
	Mon, 27 Apr 2026 19:45:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B2D1180045E;
	Mon, 27 Apr 2026 19:45:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:25 +0400
Subject: [PATCH 26/41] accel/kvm: free device path on finalization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kb8aCpIeuANYOHpQ9UF6rV+rRvi+Joa1R7pBjpmZggY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVXPLyYwKimOxS6oHWzamgH/Fh9RyoF6TkM
 V5JZpGSwF2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5d70EACNGoq43OB3CaDM+7/7tFMzAAPCltI8juSVy+j+3BQDmaiciMy8bMR3VtcqDRoH55QM7xI
 IqP0HNxUcWeJh2XLTOBJ5hYzF/nir0jZ6tgSfu1c4sy11+ubmdXSkNzCQJs8VUQcZJp5zbFBkZU
 h9wDDUuWH+UpbZJ6Sm7vh5ZdOlNKEYQoCtAb6oBaa27BeQdEcYqtXFQYI+Pq0ts8xMrR0bJP12o
 PGMgtKvnEaFp9oR4tzjePuSx8m8kyG+591qp7sdFwzYUdawCKzTlp9J6tXqp8u0xmHjXWzUuTDl
 ngjv8zO0wc8g8qUu9qLSMEfPA+8xv4jIPjTHKJL6sqn8WUtdLcNKdwivbLIGeNLOKXykNT6Fa6C
 1zo3UYF4Q9rN+9d0OHJgdRk8dn8uPoAPv/efVD5eZWXSK1tWxLH0bqhSjy4Rf5QD0+3N8e0a1d4
 IalaY4y2lxfv5e/o8xyO/b7ctnx27/liTCmbgkuGULj8jItFCXahZt+Po6mS7Z14I6iAJUGdwxd
 Wguq+pOIjKJu5Kza1R8xjFXXgpUTSUCtBBlY6lVTq4CDlxx9w4s5t4k49hTurX4w7KEIRt8gX8c
 uxJ1w9Jo9SuXddTwQsMwzb5Yn5EYY0/tc++BnB/2qNWPzZp6LoLE46Vr96YTfex1wsMMubbuVfJ
 fKPAsHDnqtqFmqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

kvm_set_device allocates device via g_strdup, but no
instance_finalize existed for the KVM accelerator type.

Fixes: aef158b093b9 ("Add class property to configure KVM device node to use")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1..96f90ebb240 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4342,10 +4342,18 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     kvm_arch_accel_class_init(oc);
 }
 
+static void kvm_accel_finalize(Object *obj)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    g_free(s->device);
+}
+
 static const TypeInfo kvm_accel_type = {
     .name = TYPE_KVM_ACCEL,
     .parent = TYPE_ACCEL,
     .instance_init = kvm_accel_instance_init,
+    .instance_finalize = kvm_accel_finalize,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
 };

-- 
2.53.0

