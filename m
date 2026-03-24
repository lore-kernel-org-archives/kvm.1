Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE003D5246
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365738; cv=none; b=amu5h2k7+YRWha3ithjiKPKRc6wgsTAW+YGQahyNFLgv4TOPRR/6OKooQobAckJZtmTfAhnTz2+PnHpAvq/8LrFRon+FEPNAKYEz4ZmHv+Qi/GthKakBM9sbL0hI+w7+DrjqDiZvebTBa+SfRZWPnLYDthKMXeTjQASZuswr9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365738; c=relaxed/simple;
	bh=PN3HvjjBSqxv3mdUtK4Vday1Ob37LpIx4b9QqWvpTl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lbe0ooDB856xUeELm+eyL1wj9O9fiHQVV2xbNidkyNl9J6UHWHpLK7xPHu4SE3dFgCmQV9G/LDyKZXL3RsaNN3kyZGXB6kf7md22Ot92Vf0fFQt0zp7FWOP+qXFAg703QXK58q6YAu5Ga7yCxJ2JFUeLepmeilrmGn10uOThjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bREoBf0M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bREoBf0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lRIyVAak8AiAXthiS6lC9CdPmPjeRvtYV0tyXWa32M=;
	b=bREoBf0MdJ4mxCivyFHHA1tJAGcSTEqFwPzOuL8L9+yaFdN6y/6zqar8dO3/zbYwgR5lZy
	0mp3MoEi/uLy+6SSxZp50Kqy4/ZhcxVsr2weMPKAC1Pbl1AJ9gQ3HoZ94OY+5dNv8QDTRS
	P7mqwN/Fn1DnAVH4B2XJ19uJ70DkNMc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-bNhvwRVLNn-7fFqWYg6q7w-1; Tue,
 24 Mar 2026 11:22:13 -0400
X-MC-Unique: bNhvwRVLNn-7fFqWYg6q7w-1
X-Mimecast-MFC-AGG-ID: bNhvwRVLNn-7fFqWYg6q7w_1774365731
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D0CC1800281;
	Tue, 24 Mar 2026 15:22:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2807180058B;
	Tue, 24 Mar 2026 15:22:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Mar 2026 19:21:48 +0400
Subject: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
In-Reply-To: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PN3HvjjBSqxv3mdUtK4Vday1Ob37LpIx4b9QqWvpTl0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpwqwRG4sP1eM/Pr7qCPiX4yJNHlQoof8tzGaTz
 y8gA7PUiMuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacKsEQAKCRDa6OEJdZac
 5dO1D/44rQsX5CljWFmmXG35rc4U6+2QCQFpqqXxe35GuDhYZr8HxCQVb+9+wk+070jhDlmmO3C
 l1u1yrsl6so3pJ8dA5uR+bYjgE5TNVwhMFI9tjaABNhyPOfvktK6/kiPPBUeZH8Dfy91QF1YPRe
 HJbcCHqrZg+j7+GJWpjlohNkCVY7sFTR4PmOIp46bhwPUbY/hO4nnDVEZKpvCg2/lDajcoE5Suh
 C/dSOuDgJepSkolOtl0xYgv/48cHsJ7Dk6SXci9CV6/8jsswke0ui8jKsLDVH3RTksGpEEuaj+T
 cjza5cmhUNVD7LeIdCwRtMNy+C8D6p6kldCy9cjgS6uQ+JoHeqV59rs3dTle9NM9yg9u/YHvFJW
 kMFzu7evxl3Bm/WFFoMsxXx3lZ+eM+GaLdIRgZTckYJWFx1eVV1QL1sBkdkSLWg8QhnLpxX1yJc
 wvppC0d2FMW6Cdo9zRJTzDjlwdsacSyVm8LsVbvAbThX4FaxYVgmq8tz2LDcfuf5mliI179ZAD4
 3uLEqWqr6mMnSpeS7D5leWdUrSyXIqj6qqt0FL2WcB2+dS9kDGVcEG2v+l3GEhSvXTNGZ5F9Fhh
 o5KAYsThqPqBewkuqIFuTYCDrHzL3+RwYAr0hQyrxhpjmXsOsja452N0gbSj6OiEHQ+4hdGISC7
 y4bOJPL+Hvtnq6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In TDX guests, hotplugged memory (e.g., via virtio-mem) is never
accepted before use. The first access triggers a fatal "SEPT entry in
PENDING state" EPT violation and KVM terminates the guest.

Fix this by registering a MEM_GOING_ONLINE memory hotplug notifier that
calls tdx_accept_memory() for the range being onlined.

The notifier returns NOTIFY_BAD on acceptance failure, preventing the
memory from going online.

Assisted-by: Claude:claude-opus-4-6
Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 arch/x86/coco/tdx/tdx.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7b2833705d475..89f90bc303258 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -1194,3 +1195,40 @@ void __init tdx_early_init(void)
 
 	tdx_announce();
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static int tdx_guest_memory_notifier(struct notifier_block *nb,
+				     unsigned long action, void *v)
+{
+	struct memory_notify *mn = v;
+	phys_addr_t start, end;
+
+	if (action != MEM_GOING_ONLINE)
+		return NOTIFY_OK;
+
+	start = PFN_PHYS(mn->start_pfn);
+	end = start + PFN_PHYS(mn->nr_pages);
+
+	if (!tdx_accept_memory(start, end)) {
+		pr_err("Failed to accept memory [0x%llx, 0x%llx)\n",
+		       (unsigned long long)start,
+		       (unsigned long long)end);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block tdx_guest_memory_nb = {
+	.notifier_call = tdx_guest_memory_notifier,
+};
+
+static int __init tdx_guest_memory_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return 0;
+
+	return register_memory_notifier(&tdx_guest_memory_nb);
+}
+core_initcall(tdx_guest_memory_init);
+#endif

-- 
2.53.0

