Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E563FF1
	for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527512; cv=none; b=U/yRCrIAKjN80Y4cugQH5saKBEMSxs1no9KXFc8luq6ZgCkZ3rBv9tgx722as6qJXIU3Bn+FCWhuOhyW3K7zh+qDTr+9pdK1AJBuw0Antxcimg8kUe0egAwtFApjGjdPzgt3CkuP5AFCHGPkcA7T5++bmY5PEWWVCrj8pHTXF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527512; c=relaxed/simple;
	bh=vk7vDIfIyDmX2vUb7k/XMNrhlPtlzSj78UsXzICjXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvwYZxbxt2S1OjiPMjfWCdmpF6kB5Nl4zAYOcva4KdsVHwM7H70KG9pkwzVpmZOJqDCcqTSaxLCQTyL/q4+1o06l2nEHHzLorqUZDcH38qIYIzK3uFr0E/Ot9Vb8Ogzc1ayl/HffCuW8ht4NIZ7fw+wWXy/XfqQlFSDHX8Goz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOtTN5EN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOtTN5EN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so25463525e9.3
        for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773527509; x=1774132309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ7hVQIRD6vEHOsR3AJFX+E3NnIhhIwHbuPfNg+Gnww=;
        b=GOtTN5ENkRqOvibYgnxREa+RilIIXTEIAp2xR9nqpaanhB1g+Zb6Ay114HA3rdj36v
         jYW0wkRWi9QfegNck1flUR0300WN0zGnuzQSF3r0P8KFsG1RUsAG1qzvQ4YARphzk+Q0
         dWgMiTObBGnuLA5vWInUjoLZZsIUnL2Ievvu00bwxjHWhNVESH6PnVlxC8Z7OBa+0Gpz
         44JxzH0zbjJUNShfsm3kdqvxwtb63PN7FqR6YlfTms8InoFKs43EAnFc0CGetQZvyCxH
         WhnNZ2jesPCjaVkDE+st//gRupVHHDFe6H0WdBvfXG85/a6zj/NIyajaNwMN69IgMFc1
         rfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527509; x=1774132309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ7hVQIRD6vEHOsR3AJFX+E3NnIhhIwHbuPfNg+Gnww=;
        b=bfY4+UnixW6D9YpfSq+/SEZGbcFvtWALVA8AssFuNAFdLau6TfVe+wknaHxGox52Hd
         wuAeLnA/lmNrxo6Dt1dAFZQohAu98YzkSj2xS+abXffovarbbtmHtXs9TxzbsUj0lVOj
         virzoyDuGi9AsOzpxgY11Km+9+2Ew+uhWldA8PMT2XLOumAbgIvWuhHFrEI0OdQdeR0Z
         23FieuWkgdkgltOZchlncz3j2dK74aFx3x9xXfQG5jFUhzmbQI88D84CYc0lNgIa5YD5
         Ao3hgQg2z8TeH/m4Z/GK7sJvEljcuL5/3KBQK0n64JQduMjZRJgyki3NX1tw5ebyt8/k
         oGYg==
X-Forwarded-Encrypted: i=1; AJvYcCU3YOKyiqMgwubG3AwxeEGaoz0tCzRVbmGOktSrhuQqvtzQmPlIH2nLNqlkQzFIFcY4FyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSs4AeLDhUIGbn28QKpAdZo/77KIYp3IQfM5s3uTVbnignmSYi
	6dKkEKGSrPYbDV+eFukD65XGc7yo9Qje/W3iFTBIr/QehXA7gCiTRQHj
X-Gm-Gg: ATEYQzw8vO5sjSxA7Q+yZy/A0YEI/FvK0MiUu3544w+PSzG5WqCyBLwQsSs3CcvG5lR
	cYW1QQkbHRqhqb7qx38aOMn9Mu6CPvLVubUdaowKOr6+vIJ6Y4sW5IgyjJ4t9CSqNvZ5gFSRdKd
	QiQ1tYvAkYP88vCumDI8CRhZ77ZD5wkAQSYO7t1KNpczwWTpPlh1RIl2QZaI/AajVAqv1qnsJKm
	yBETGd1ojPCyBr92zj41DNIViHieDwe9QJmJZ1PybLBHSaAnAhl7h6UaX3ibK80C6YQG5vfjvHR
	Nlf6p427T3zFOoEQfPlzRmGw7G+eB5RoWF5CsqVYFWqVTW4gyJjuISwDLT8D8Kv5uZpk9/d673L
	RnZqtHFxfA/Vix3vpdwOJaS8nah1kTNOZ8FCpE/vX72iaFis++fHhsj5Ir69eHqLG1d9/4WqmEH
	0Bwu4tkbp0zH9zgNTDBvfOngpZZvOAL1beJjMkWWWqgL0Eat/qIQlTwtfWL8NzbrdszQy/UA==
X-Received: by 2002:a05:600c:6287:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-485566d2ff2mr132595095e9.11.1773527508820;
        Sat, 14 Mar 2026 15:31:48 -0700 (PDT)
Received: from osama.. ([41.238.114.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm149314455e9.7.2026.03.14.15.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:31:48 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] riscv: kvm: fix vector context allocation leak
Date: Sat, 14 Mar 2026 23:31:43 +0100
Message-ID: <20260314223144.154349-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the second kzalloc (host_context.vector.datap) fails in
kvm_riscv_vcpu_alloc_vector_context, the first allocation
(guest_context.vector.datap) is leaked. Free it before returning.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_vector.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8e31..5b6ad82d47be 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
+		vcpu->arch.guest_context.vector.datap = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.43.0

