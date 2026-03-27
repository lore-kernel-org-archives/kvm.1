Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9343EC2F5
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619165; cv=none; b=s3SEtKxZdPufoi6wbqz6tzbZpr9WFqhwhSCRtOuE/R30MAqeIqm7FKHfpV1dRUiT2/ZC2k8Ffu55AHtm1wcGtVfymOtcJ/ZcO6UvWvqeJOwNj6NY8nd6ADgDdceKg3jccEiovINuKC83Xkn4j7PlqKvJQ4rQhlb1z/ZuhpecsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619165; c=relaxed/simple;
	bh=aHcxVmENx58TY8/IDzc1OFqIHU6uxDNijjTtiINWGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMv6OPEIRfF5x8RPhMrSigWXLjUcdUnCb7W5agoL12659YykggHwo+jFZfKKREkMOIGLnRMCESJ++pAipvh2+XKGdi+mh08ZBxiDgEVerXgutNyR8VBMBdsrOKY2DXQvMaYUo2NDXMIaQPQVWrkU7hbauHN1AOwcK2z+KhoK+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbTvxL5K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbTvxL5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozMMMbc5i4osCd27yTtYVpRq0NefVxtoYxUcTIpyOtQ=;
	b=JbTvxL5KmiQWIa6tDSixH05QFfLWMi7PXtKWXZHTQsqqoXeLOWxVOc+AozG1mWtIbP/Ley
	VN++DtUZSxf9AYfoo3HhviADSjqHOuP+SMGbTCiNjN43tJo53bcMZ++ux19q7LSGLgYxMZ
	0S7MWimmEUeWwNaNUJA9ExG3hfKJACI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Oq34NabwP6-24Tg-o-cfLg-1; Fri,
 27 Mar 2026 09:45:57 -0400
X-MC-Unique: Oq34NabwP6-24Tg-o-cfLg-1
X-Mimecast-MFC-AGG-ID: Oq34NabwP6-24Tg-o-cfLg_1774619155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A42818005B0;
	Fri, 27 Mar 2026 13:45:55 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7719A1800673;
	Fri, 27 Mar 2026 13:45:48 +0000 (UTC)
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
Subject: [PATCH v2 14/15] storage-daemon: use same link arguments as other tools
Date: Fri, 27 Mar 2026 15:44:00 +0200
Message-ID: <20260327134401.270186-15-kkostiuk@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  8 ++++----
 storage-daemon/meson.build | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 1087e8c106..4a3fc306b7 100644
--- a/meson.build
+++ b/meson.build
@@ -4507,15 +4507,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
-  link_args = enable_modules ? ['@block.syms'] : []
+  tools_link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: link_args, link_depends: block_syms,
+               link_args: tools_link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e61a9d1bd..fc088cbea7 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,14 +1,14 @@
+assert(have_tools)
+
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
 qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
-if have_tools
-  qsd_ss = qsd_ss.apply({})
-  qsd = executable('qemu-storage-daemon',
-                   qsd_ss.sources(),
-                   link_args: '@block.syms', link_depends: block_syms,
-                   dependencies: qsd_ss.dependencies(),
-                   install: true)
-endif
+qsd_ss = qsd_ss.apply({})
+qsd = executable('qemu-storage-daemon',
+                 qsd_ss.sources(),
+                 link_args: tools_link_args, link_depends: block_syms,
+                 dependencies: qsd_ss.dependencies(),
+                 install: true)
-- 
2.52.0

