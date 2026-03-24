Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D80402459
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365732; cv=none; b=d7/tbxsG3dO5hY1ao2hGB9ybbaaPJWbCQ4RUiY8X0jQRnBaqJfSxd3v80ftf3WXQA14hPvOYlnQoyi+Ji+2f52zRVhf0XTpdPqhOv03KbYENvwDQvRkbg7GVIGiJIHBXN7zeaMKEA1e4ZLzmU6UHiUvlErnfWhy6FFp5HUO/fb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365732; c=relaxed/simple;
	bh=6pOGht8waBPs00lfqXrQSxwdCnGb0VUU5lV9DVr/Ypw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5627RiftmPkk+CFGmodmaDiT8BZoi37n2NlsSvmZZmF+SEACzRmkh+tOY2dv7PA/Z4bUWwdcNHYPwXS5x2m15GFLNML0yZf79HYMJrH/m9HZ3PNwdpikrniaropY4wqhfUMkiwADuvEXbEeuuiJHW7DGn4j9P/OALfzxz7kwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+/0ErGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+/0ErGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bXZJGaMgnIm6+lTpw422W1yiXiQQt0/cup2uQ+1EZE=;
	b=C+/0ErGEXuhpLteZZKuZcnwIVZpIoZ0cmBW+X7+G2qslP5chDpWg7mKy9zyPkcEeHCsyES
	M8TPDyD6617xdBwJDhHpahHN5p9/WVVjpwYc/6Ya8xxOXaTcyEEpxxaskbeSymoBy0qOoU
	TGBZv1a1tQMPCpk0YThzxRO8DkI8Qew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-0TUpUOQTMhi_PczQD7G_gg-1; Tue,
 24 Mar 2026 11:22:06 -0400
X-MC-Unique: 0TUpUOQTMhi_PczQD7G_gg-1
X-Mimecast-MFC-AGG-ID: 0TUpUOQTMhi_PczQD7G_gg_1774365724
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA031195605E;
	Tue, 24 Mar 2026 15:22:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF68D19560B1;
	Tue, 24 Mar 2026 15:22:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Mar 2026 19:21:47 +0400
Subject: [PATCH 1/2] x86/tdx: Handle TDG.MEM.PAGE.ACCEPT
 success-with-warning returns
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-tdx-hotplug-fixes-v1-1-8f29f2c17278@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6pOGht8waBPs00lfqXrQSxwdCnGb0VUU5lV9DVr/Ypw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpwqwRp1SP1VzCaRlY7TK7rAh3VxUzZyWDn0Kvt
 JDRJ5R93wiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacKsEQAKCRDa6OEJdZac
 5fZKD/93VrywdI9aSDyJ7N4jik+syEedJz2qtP4Ct+GCpyCvb5iroS4XDeyRC66fk7yziC2AKOI
 +DzahPvWzyiRjKNkfUXf44ldXRafmB89TKEujff+X0tKUs+3y9pIIBu10c9vT/w31bwsiHfhsfq
 FvJYKa/sDMztEq2DijYJrXk2rcpwBzYLRrVDixI8GPNw/W9nCn4yhnZpYY/B4dFG5pIPjUvU3RM
 KsbblbP1/WpDZL33bpuM0afOW6W8KEq31RklRMEBPzFYxoAGV/wkiDcYfBflz0mIRl+iquI+AHU
 Gks5n9tGvl7RfkAi3AR06aS22yYcqH8aoACBQUBFSjpxkUq4aqDC1137PKrOsAg4uJGEnbBo8mK
 uJiOdcYb66Li6brrmncGOtWZsKBclLtEZzgRLI0so4eNQV2Sf1Z1zcNR7rqSp0KdJttE8yhaN+M
 iA3I5iCwQbfwoir84icH1HvXqgsJCZTO9Uh84dqWPpTeVA9MfWITWuVQWYU92Fs2oP8yt4W/Rv0
 C3M6qf4REh7u4Xb3uFFVbVj7mPb7Dhqr7zvv+NOXrw0wPmXapv+IXNjD+bXcA0Zrrr0MH6YgDSX
 hDeFJHDbQaI71Ed5xvHepykTEZnzsfAo4fB1LzYAAKiQgZR2UmZDO7b+/BgiaGUZe6tW3IEJGEW
 l73PtuTml2DZHEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

try_accept_one() treats any non-zero return from __tdcall() as a
failure. However, per the TDX Module Base Spec (Table SEPT Walk Cases),
TDG.MEM.PAGE.ACCEPT returns a non-zero status code with bit 63 clear
when the target page is already in MAPPED state (i.e., already
accepted). This is a "success-with-warning" -- the page is usable and no
action is needed.

Check only bit 63 (TDX_ERROR) to distinguish real errors from
success-with-warning returns, rather than treating all non-zero values
as failures.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 arch/x86/coco/tdx/tdx-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 1655aa56a0a51..24983601a2ded 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	}
 
 	args.rcx = start | page_size;
-	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args) & TDX_ERROR)
 		return 0;
 
 	return accept_size;

-- 
2.53.0

