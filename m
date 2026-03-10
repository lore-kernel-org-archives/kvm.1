Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A43AD50D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148922; cv=none; b=Wp9G1GFA6DDsjgTJaHoOHuHMSdsGjSCn7C35wNG7dntqW7uRukj+ch6JofOqYUll7GCKeqq7irisVhcoS/yXvYBVZrwsvPZ67CjnxOYcduhTmfE1bjYBaP5eA7v7NyBvbb2iHuMZzx+4v9oknArkv4PZm9bIVFjrtrh3fiRL4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148922; c=relaxed/simple;
	bh=2ZcEWenQOD+NOl65pkIQhL0NtL0EvUW3sXsfPcDiJYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnCOl5S+x+E+4rmOv5Lw0+zvZNZp1KZgH6Xk4gaZsUbZbc7uCY7l+TuGLN5vaWddep/mPWxf0FPlRG6kOrvtezDWaD1aAjCtOgj+6stU+XgILCXhNnvo3reCLVh+vPBRaMtFtL2QZXrVEvemL+IiXiMginckLRXVoHIBzxKHuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey9CoLXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey9CoLXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ofQ4nmwEu3wL7Z0Aby5YaVlITUvrkllN4FHvtGxenI=;
	b=ey9CoLXkBUuPUjG8u9kTTZXwqTjWh1IFqYQH0XJK6KcFfXyP1Yg5/tX1G3Fj8AWT5F351f
	mUfwgJYP1dUYjLI3wcIMbBA5Jvx+CktVKC0VT/DhqSPFiPnBYNQFi1asJTOsxC7D7j7c/C
	OnHd4sxBTRH/QDxYXoKttiAmLkgFn4s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-GtC0Yw3fMlOGmRVcTOWRpQ-1; Tue,
 10 Mar 2026 09:21:59 -0400
X-MC-Unique: GtC0Yw3fMlOGmRVcTOWRpQ-1
X-Mimecast-MFC-AGG-ID: GtC0Yw3fMlOGmRVcTOWRpQ_1773148918
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A194E1956050;
	Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A0811800351;
	Tue, 10 Mar 2026 13:21:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DB1CD1800850; Tue, 10 Mar 2026 14:21:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Oliver Steffen <osteffen@redhat.com>
Subject: [PULL 1/3] docs/interop: Add AMD SEV-SNP SVSM interface to firmware.json
Date: Tue, 10 Mar 2026 14:21:52 +0100
Message-ID: <20260310132154.2783257-2-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
References: <20260310132154.2783257-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Oliver Steffen <osteffen@redhat.com>

AMD SEV-SNP defines a guest to Secure VM Service Module (SVSM) firmware
[1] interface. Add a corresponding item to the FirmwareOSInterface
enum.

[1]
https://docs.amd.com/api/khub/documents/Al5Q~fSl~kWKkJ3zC0vk_g/content

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260123083204.999920-3-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/interop/firmware.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 3c71914a526c..421bee0e5ed4 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -40,10 +40,12 @@
 #     example, firmware built from the edk2 (EFI Development Kit II)
 #     project usually provides this interface.
 #
+# @svsm: AMD SEV-SNP Secure VM Service Module (SVSM) guest protocol.
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareOSInterface',
-  'data' : [ 'bios', 'openfirmware', 'uboot', 'uefi' ] }
+  'data' : [ 'bios', 'openfirmware', 'svsm', 'uboot', 'uefi' ] }
 
 ##
 # @FirmwareDevice:
-- 
2.53.0

