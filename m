Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE103E3179
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524804; cv=none; b=FNLzP6HLDU5AUNwUbVZgrNfPRtlLgasUBJO39QjsBsnM8T722QwYBXqEHO+Ns8+2MQo50xL4lliqysLsjxHJXPnxlA4li61bYSivOYlxz+uVYySS/T9JvZTXmwaWBCYLXEHvo1QVoiorm/apvvuw27tmqw441dRkgrseIoOaURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524804; c=relaxed/simple;
	bh=QC4L+iwl87iwjGr5goVdiAwoc99vCbYUdjiVuPiut4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKxvqDmdIllprJTFz78F1SZF6kqRHuTQu5Nvy+1l9AA/gdVg1UR70P4JC0KDTMf5qq/RPVHbU16kpVQpnFTo/RDgBDbVEpawamWwQDijawh1UPTXYyD1gji0wh7DmqomWa3/h0sAt/Z4u++n6gh6FIDCKjrtHG4ZIPKuOD/vtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqHF5diG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqHF5diG"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1826072b3a.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524803; x=1782129603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47hfi8LfGsgVp+b4yhOvnydmuFnxVuF/IyJ4r+pT0Qk=;
        b=YqHF5diGug/JpdGQjr7nBhYTs/9e18SMl/eKjl+KSaBTs3tpSICiokB0LxjKS1+QcV
         +6YqPPDLAqnwWWdd2H+ZPd1IHsviV5qOREyYr9YltF81noXIGjqUxPkrp7AjgjOon7vZ
         kcNruO+rIx3QGh24CZJfFcfDIzonAp6dvLP5vwxHeo8Fr1evkVI9H1ZXocfVNIgK/LYZ
         MnZ8tTLQk+wfceFJP8vWPdNku//UPodHDvC6dbIRm8aoktcQUSI2sLnYeUDeJ6EYbxWd
         5L+kWH8sEaw08S/zgSpH6r2o8zjjISdNgltAFnItyxEIc3qB5vEGLzoJTrrWjOhqQr/Y
         fRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524803; x=1782129603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47hfi8LfGsgVp+b4yhOvnydmuFnxVuF/IyJ4r+pT0Qk=;
        b=ioTf3GN8wN+X2EbazQmPykWJhgSD1WABOPkMpoSlyVRuZT6WeSiyQCkl/6xvqDiTxg
         m2Jsge+khDBl5WZJcBIOnqPyRyPaz0GuEKXQdHZsKhmLmPG0kotpZwyKL3Y5rghG/uF7
         5Dx+KHsTHAgGhjca6SgCSmt51HnqChPzZ4+DHPIZrPR8qVl4z1B3Hsf9MuwRF3qVB3fJ
         Z8SeEa8NReYZtEshkZTsMyBd2D9vfO4g0JdF29Gm9dB+Wrs0j4AvVV9+3jxkUYyD8oBM
         XQH8eOt0k3MWU3FrXxshreOYaFyhTWNZuh3X3jWvmkFcCQ7VSMlg1BL8EOfdjU99oC0p
         hFrg==
X-Forwarded-Encrypted: i=1; AFNElJ9Km3E9PeSZcpSgS2YRHORAcW+9C0mC70If3QdEgZFaM2qdA2wjuWZOCsFdVMPaG/yUJwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZht0yMhSAUgYs2L4zj17k64wg4wNrYk1sVIc/KTfmWzWjRo9
	MMqiNaZ2InmQ7qNw+QrVofYq5PU2DxA7h6Dg/HfY6sRt/sFg85uMbU4z
X-Gm-Gg: Acq92OFpXkHtBknU8Aw2I9eWh0Rgwg1mGG7DreGJgQ9gGRER0dkyWWA591FfuX3l7Cz
	LSr7YNOPzeHSIdj0mva2uLqBamVoVA2t7OjS2YQmXNgnwpSOxwyncnMH1Gj2Gpqy5GiXMqTXkBx
	L6AUS4fobiD0Fvq2siSs9TzKSUuoD295o1d1xGUa0jyu3RA5YyQfb3c1aidMh64mD1vqotN8lbo
	kTy1srOyZNxsq2Dax74lJ3AO8gOFt7krrcOLgC8laVl+Fd1UFsqQAvhNO6ZqAafsgq4BUaOOyDm
	Xb1VsodeM9y7lZqNrhmKkCmlhITVeUUUO1Nxdw9Byec6QEBwANMiPvrbHfDQKXbG4VIM/YHvMkA
	3QhzFVqKA3WRP5HSsxok4yZsXel1vXXPCnY9DE+fVY+l4RzFsDe3l9qm9OGy9FUZM76YXGkiywR
	Unu8CN9G5qE7ZcuRwSpZeGB1N22JryRpXaIRbV7cCjeisTkx9M5SWPzEw=
X-Received: by 2002:a05:6a00:4b04:b0:842:432e:b7ff with SMTP id d2e1a72fcca58-8434ce2e7d9mr15015612b3a.17.1781524802827;
        Mon, 15 Jun 2026 05:00:02 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b048496sm10630026b3a.54.2026.06.15.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:00:02 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	yashsuthar983@gmail.com
Subject: [PATCH v2] KVM: vfio: Convert fget() to CLASS(fd) in kvm_vfio_file_add()
Date: Mon, 15 Jun 2026 22:59:50 +0530
Message-ID: <20260615172950.107275-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523050242.41472-1-yashsuthar983@gmail.com>
References: <20260523050242.41472-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert fget() with __free(fput) cleanup to CLASS(fd, f),
using fd_empty() and fd_file().

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 virt/kvm/vfio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6cdc4e9a333a..bbd7a5dfb76e 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -144,12 +144,14 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
-	struct file *filp __free(fput) = NULL;
+	CLASS(fd, f)(fd);
+	struct file *filp = NULL;
 
-	filp = fget(fd);
-	if (!filp)
+	if (fd_empty(f))
 		return -EBADF;
 
+	filp = fd_file(f);
+
 	/* Ensure the FD is a vfio FD. */
 	if (!kvm_vfio_file_is_valid(filp))
 		return -EINVAL;
-- 
2.43.0

