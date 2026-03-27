Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310ED3EE1F3
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619066; cv=none; b=Q+PKCeFgqRhr7Wi2h9EczNhGNd7UbaIDz3IWVzm1UzX90fy9jUJJfdNBsom5iZHoUhY2Cw5V8OsEQPKcJwRVppJSzKz/rAqO8cdq6sEPzg9nw2IKfijqD60+PupRHfYHBZZjVMe/ni3wT0AYDuoFPw54C7EwVIaufJ25GyBbICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619066; c=relaxed/simple;
	bh=iIdygynTGl8Kuzv4zZucIOopGi1tEBGoGS1OBmbrWPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlhXQX1f/Jia+sjTEb6Xn/yilQPOWZZ5XFZxXVux48fnBIxub0MwEPaM0hG3trj+UxrxBTvYEfuhhCfd3c3hybt/Tc5wz87iSTDnDpqmT5K3VFawboDY9MiFgcK1wGkb9O7tvHSAeT27Pnu4UVAPFatDhFuVFwB+7CNJmqzE3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWLwdHmo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWLwdHmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tcxKslIn6LU9r2hkVjCtK7yULes57vCUXv6/td3HUM=;
	b=WWLwdHmoY04KtrbC3lewKzTwHE3IOOU3bTNBEx/nrfWwr3of5a+KmHZQ35UppBvADKrxRo
	5Y6rdzOHVR+hPBbq7GFnD7q7BwhRX1b03/0qSkx3pEib8/VTKanGmFFoqaLWO+ybZ4DKOx
	BpylHlzQd3pPC+mLZpMuPyvjI/I7MtE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-Z6RWgCS5N9ebqJHyzjf_2Q-1; Fri,
 27 Mar 2026 09:44:22 -0400
X-MC-Unique: Z6RWgCS5N9ebqJHyzjf_2Q-1
X-Mimecast-MFC-AGG-ID: Z6RWgCS5N9ebqJHyzjf_2Q_1774619060
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C18F41955F18;
	Fri, 27 Mar 2026 13:44:19 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CAC8180075C;
	Fri, 27 Mar 2026 13:44:12 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 01/15] meson: Use stddef.h instead of unistd.h
Date: Fri, 27 Mar 2026 15:43:47 +0200
Message-ID: <20260327134401.270186-2-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

POSIX says stddef.h provides size_t, which is the only thing
we care about here. unistd.h can be missing in non-POSIX runtimes,
so include stddef.h instead.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6c712f8b0d..1087e8c106 100644
--- a/meson.build
+++ b/meson.build
@@ -1057,7 +1057,7 @@ endif
 
 if not cc.compiles('''
   #include <glib.h>
-  #include <unistd.h>
+  #include <stddef.h>
 
   #define QEMU_BUILD_BUG_ON(x) \
   typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unused));
-- 
2.52.0

