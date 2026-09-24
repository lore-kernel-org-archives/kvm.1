Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAC41CB2E
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232663; cv=none; b=LXMQwvxlKi9omgY1EwMYDGVgy/tbUcned+bstz3JvbdeFoMyZY51rqzh0lHcWSf9GjFsxCs9TvTP8lfxp5Wr+tjRgzjBKr8oeNHxDq1VwxEaMNWBJo/nZJzw6CPOGYuBfAHJ4lt6NKAEiUc2ZQ5B8CCsLGGab/EH/XrMnx2FcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232663; c=relaxed/simple;
	bh=7gtAjeQO6yIyWja//vqyKW5Dj1OTWnZFxdHPJXFRCFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4qNEQ76BYzA7DUAxVzrL7fc/YIG7C+4kAnWFDqVe0/2P5FZ58yiaTx+kuFuvaYXFPf+4enPBmOReC25+fVAd5/Jqjet9gImflB+zjUXAk6EOfG1wOOv1+F83kcEyy93PNSWwdSXi8rub7uvySbxDvQsBCxLmYNO5LApJfEM6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIJ+wVHZ; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIJ+wVHZ"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so2954251c88.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790232659; x=1790837459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eyc6vxDzox4W8LdaVh1hfDPXOLyn2U/fTkEKcGp+Tno=;
        b=ZIJ+wVHZfdLf4dPAeXNyEmujFkyJiwhdREIoVcVhpP7PZKyD01gigg9luOyZQZ+qzV
         GYnA2kq/XRgZpULQEZOXagppUSAEulZuGp/XpbqJNv5VUNwkGfVLaDIKBkU1UkOqwLed
         J0nB5kB2+2ccm2JYjPahRFqDXa7JGEoLMYQsIK5tCfrAfLHmzooXOac4TpkXgx1/4mNZ
         r5Bey/5g3WMUEjanyaYkrSUlmA0il2ed60SjxEGJJlYLMAKdJqFsF4Hs1RNOMOGH7hkr
         84mrxwRzIuR9cgKXCMfUZyw7zVOLB99IQ9jYx+fQWvuByfHjCUkXSR+Xwddg/cimjA8F
         6hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232659; x=1790837459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eyc6vxDzox4W8LdaVh1hfDPXOLyn2U/fTkEKcGp+Tno=;
        b=WNyYEJ7S34a0K/LNXDTmZjmIftaA9stMXTsgpF/pWWsVxdn/NnKeYW7p0X8uo8K6eZ
         x4C1bGiLHY6FG8Aruqt39g0VCRZMNsUYgrdrr1SNumJkA0Nt3j/1YtMdKOciYvTD8MQs
         rrA2/XbCiGgOvEwanx7IXL57YS7Ez+971M9rLWnT/f+lAfZ0YLS/6rl+9s+pMxhzEs+6
         QF0UVjJL17+016wcF0BCIifRiJkwB6riX0KWgNIq7B8+Q+a5TfXSagQJXKJvL+6GGcaK
         Tp2RGGZPyp2KGKov6OgYD0FY/N907ug0s14qOSWYo0APwrINb7DTobkyd38RnJKKosl4
         RDaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTIhTQhn/n1KtUZIG67gtL6wXMScEo/k7toOo49SeQF6X+mN028eRJ8KazEm8S7J54tzg=@vger.kernel.org
X-Gm-Message-State: AFuF++mIcqb/ATyasjeLppFrgXYWYCWKX1X26KcrNjP29N3YvwGZd+fm
	ZxXJ3jHLZI+Og3zBm+MUYT8575rO1vuc2FSdvF0yaW8Z8MMiVbVY55/mD30+zwnG
X-Gm-Gg: AYBFou3An3ydw0EffE7kP39NfNNXauchA4qHIrLAQYrCpx29RTbZFLmeWpd/3M3/jSi
	E+tq1iZej+p0f3eUTQETNOT0GPqdjuP9IytS/7uqjyufreyGWMx7/jedol0lCh/IHzWl5zHUiNX
	7RiDSPZoQEodZzz4dYYpkf5TwCZZIBW3J9rconlBdnzkVPaBxEhqRfG2ErKabrCa/4i69b4/DSZ
	nn/t7hOIUoWqse4hotyg6BYLBEFex2Sgq8eQ6rDZmPqLHvBIIk0obZTrv1Bb5nANriT5R9i7fgk
	xRkp/GDO38WPM9yCb6iuBz7IljByfOC0jWgNEmElk7uO7CMaFtdZQC6PxuP6P08Bue1Fix7RclQ
	xYyAKBfRhvcrbe1gg/1NSVS0Gj5KaY7bKYFfRWcJ3piQ3ASsiiTsWsLJHL1DEzJ8tu8ZLySf2IL
	XMgEGIbxV+sYUV8RpkfwDYW7Kw0UxY4BA3Y34u8NgRmaWHPPpsTqo94oA6oJDSKzsTFEjIQzXv6
	PnrJdLeY/k=
X-Received: by 2002:a05:7022:309:b0:143:7821:e151 with SMTP id a92af1059eb24-145040427dbmr1873170c88.47.1790232659113;
        Wed, 23 Sep 2026 23:50:59 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm18497821c88.7.2026.09.23.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:50:58 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Xianglai Li <lixianglai@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH v2] LoongArch: KVM: Return the actual error code in kvm_ipi_create()
Date: Thu, 24 Sep 2026 06:50:33 +0000
Message-ID: <20260924065033.374786-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
References: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_ipi_create() registers the IPI device on the IOCSR bus. The error
path currently discards the error code returned by
kvm_io_bus_register_dev() and returns -EFAULT instead:

	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BASE,
				      IOCSR_IPI_SIZE, device);
	mutex_unlock(&kvm->slots_lock);
	if (ret < 0) {
		kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret = %d\n",
			      __func__, ret);
		goto err;
	}
	...
err:
	kfree(s);
	return -EFAULT;

kvm_io_bus_register_dev() fails with -ENOMEM or -ENOSPC, so userspace
creating a KVM_DEV_TYPE_LOONGARCH_IPI device is told that it passed a
bad address when the real problem is that the host is out of memory or
out of IOCSR bus slots. -EFAULT is reserved for faulting user addresses,
and the remaining -EFAULT returns in this file are get_user() failures,
where it is correct.

Free the IPI state and propagate the error directly after cleanup. The
error label had a single user, so handling the failure in place removes
the label as well. This matches kvm_eiointc_create(), which already frees
its state and propagates the kvm_io_bus_register_dev() error code
unchanged.

Only compile-tested.

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Suggested-by: Huacai Chen <chenhuacai@kernel.org>
Assisted-by: Cursor:claude-opus-5
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
v2:
 - Handle the failure in place and drop the now unused err label instead
   of only correcting the returned value (Huacai Chen).
 - Reworded the commit message accordingly.
 - Dropped Bibo Mao's Reviewed-by from v1, as the error path is
   restructured in this version rather than only returning ret.

Link to v1:
https://lore.kernel.org/all/20260922103931.215091-1-nagachaithanya9911@gmail.com/

 arch/loongarch/kvm/intc/ipi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 7b333a4a0430..80faa770c0cd 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -423,15 +423,12 @@ static int kvm_ipi_create(struct kvm_device *dev, u32 type)
 	mutex_unlock(&kvm->slots_lock);
 	if (ret < 0) {
 		kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret = %d\n", __func__, ret);
-		goto err;
+		kfree(s);
+		return ret;
 	}
 
 	kvm->arch.ipi = s;
 	return 0;
-
-err:
-	kfree(s);
-	return -EFAULT;
 }
 
 static void kvm_ipi_destroy(struct kvm_device *dev)
-- 
2.43.0

