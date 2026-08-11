Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5478397928;
	Tue, 11 Aug 2026 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413187; cv=none; b=YzHQ0rgAhyPnWuBF/biUSUtVj5RMXM3D7QmEwzuaR9vaqOSi3dp42ncaB5yEDn7SQBaq+tnQg/vbFhhmf7FScI5qN7+N9gMd8zgXImePMuQyQNNwsSsx9COGuGIQnKYL96YE3xT3GR3PDvbkx6heh1vvqKKNOnbygd8qcclFxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413187; c=relaxed/simple;
	bh=USSkt37zjiXpaOXdgBUUDjvtIRuME9JAeB4aUsmjfyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5uOqjem3XVFz1IakFJH/6FGcYEOfv00j8D06UUW72fud00gK7/VMGc0ymBIzqc0nwDHJ0kbJ+tKLnjPt0Er1qRrTvAxhDjHmAGQRX0bLlfgAw/inigDcV2Nx4R92WNYcpyrf0dDb8nKO2SoznPIf3WIotYMhN1F6ll3z2/5YME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=prelG2wa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="prelG2wa"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BAF9F20B7167;
	Mon, 10 Aug 2026 18:52:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAF9F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413161;
	bh=Pcwn2qTvc4F7UFe7dpQt3hY0hptv0VmVSVeDqOtxU0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prelG2waOEkg+YHrpjADM1dxegjor/NYa52LbtEHFtAwKCEQbss793J4A3cARuI5H
	 LgffnUJUV7OP5tcyoX6lqgAsvoEgcg6godkTUx7cR5W97Z80XZ4QzAmu69hDV3jUdv
	 9UzBHEzdhse5a0VIotnLLrcBYoOa6ykfMB3CaCHE=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/8] security/vbs: bootstrap the plane from the enable path
Date: Mon, 10 Aug 2026 18:52:42 -0700
Message-ID: <20260811015243.188486-8-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015243.188486-1-snambakam@linux.microsoft.com>
References: <20260811015243.188486-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the KVM software-planes backend is enabled, create and activate the
secure plane before the backend issues its first VTL call.  vbs_enable()
runs at late_initcall -- after device drivers have initialised and before
userspace starts -- which is where vm_planes_bootstrap() now runs.

Select VM_PLANES from VBS_KVM_PLANES so the plane bootstrap is built in
whenever the backend is.
---
 security/vbs/Kconfig |  1 +
 security/vbs/core.c  | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/security/vbs/Kconfig b/security/vbs/Kconfig
index e21f4f30b6cf..7a2ebc13e479 100644
--- a/security/vbs/Kconfig
+++ b/security/vbs/Kconfig
@@ -18,6 +18,7 @@ config VBS
 config VBS_KVM_PLANES
 	bool "VBS backend: KVM software planes"
 	depends on VBS && KVM_GUEST
+	select VM_PLANES
 	help
 	  VBS backend that uses a KVM paravirt hypercall to communicate
 	  between plane-0 (the normal guest kernel) and plane-1 (a secure
diff --git a/security/vbs/core.c b/security/vbs/core.c
index c006b6d53a14..8dd4567bcb9c 100644
--- a/security/vbs/core.c
+++ b/security/vbs/core.c
@@ -16,6 +16,7 @@
 #include <linux/reboot.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/vm_planes.h>
 #include <linux/vmalloc.h>
 
 static const struct vbs_ops *vbs_backend;
@@ -154,6 +155,17 @@ static int __init vbs_enable(void)
 	if (!vbs_plane_config_present())
 		return 0;
 
+	/*
+	 * Create and activate the secure plane before the backend issues its
+	 * first VTL call.  A failure here leaves the backend idle.
+	 */
+	ret = vm_planes_bootstrap();
+	if (ret) {
+		pr_warn("vbs: plane bootstrap failed (%d); backend \"%s\" left idle\n",
+			ret, ops->name);
+		return 0;
+	}
+
 	if (ops->init) {
 		ret = ops->init();
 		if (ret) {
-- 
2.55.0

