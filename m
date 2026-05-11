Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08337FF71
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530953; cv=none; b=eP94SJ9kQlD/CyNgduLBjNmQ47c3OupPgNXa5QS+HTdkp2484d0vpD+RmPpFCmYbk2obI9OcMVwh7TPAc2d2MinKjXimkpa4od8HWL2zLOUG0KePZQ2rCQ8Zsa4fYNg4f1qb4XO5kZN05VToNIuiuyu9qMCO6m4BAmtikZKbbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530953; c=relaxed/simple;
	bh=QIqUy69AYbjgocOEEsOCTEbfCmaN2Dc6VI/qZEXfOG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0W4CYO8+j8pmD2UjIgebbK6CXwuu/Cv/Ja2izVZSwrxH+VRoO9edLOLrgaoGLCM1rm272qWgDbM3ddARdVcuzM3QOc50yCMcSAkGtpv3TwhXCBVuI5TXpK9SxRSoNgDh8gaqiKitDDBAINqKWXSikDPUYb2sorvN4mqA5KItL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cue2HAYu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cue2HAYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778530951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gK+1NyCwHvVEv8FjA+IkYWzzVz8wUm5geGfRaiWoRM=;
	b=cue2HAYu6zTtJdzDBg/ioh8YC93hehzkpuMvuoJjPC/5rYaenB/OMgg/di07TftsddEMEn
	L2SwTPmRveOdkgaoA+RARKLoeXw22kxcvPY8gCeVgkmFvMp8gqIRwmyKcNiktgrqm7ND2s
	0FIaeY48pQrKw2G4a6we6/zh3pzooYw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-C4SjNV-1OoCmDfLQDysNlA-1; Mon,
 11 May 2026 16:22:27 -0400
X-MC-Unique: C4SjNV-1OoCmDfLQDysNlA-1
X-Mimecast-MFC-AGG-ID: C4SjNV-1OoCmDfLQDysNlA_1778530946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E48A19560AE;
	Mon, 11 May 2026 20:22:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C1B218004A3;
	Mon, 11 May 2026 20:22:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [PULL 13/24] accel/kvm: free device path on finalization
Date: Tue, 12 May 2026 00:20:59 +0400
Message-ID: <20260511202111.3091440-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Marc-André Lureau <marcandre.lureau@redhat.com>

kvm_set_device allocates device via g_strdup, but no
instance_finalize existed for the KVM accelerator type.

Fixes: aef158b093b9 ("Add class property to configure KVM device node to use")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
2.54.0

