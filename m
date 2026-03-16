Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D83A6F12
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674182; cv=none; b=oHkLw4oIPRuUf4mZuzwMAGRSUkjReukqJxMa6ReBNsAbeLH9STwXGPBD7482XziZp0zkvk6XR6sHJbsO2e4LShOby/IU47EQWZHY/kL2LnwwnfApl8r+hIBMbvgk9fLZoG9KSobmUi4zh+TqJt74sc+8R4anNNyCMkZwAdwdfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674182; c=relaxed/simple;
	bh=zaGpMN5MsHeRI5IgLx3OK1qQQFMq33LxzGPJO5RR2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8subOa6IoZLsrv/hVIr3PEFiHxz3Nboq5DPDAbFVkali3wjYuGNxwWU/3OiA99msxZmn5bLwRfSpgGIMqHA0dKhPyBeK1Vajnh/BfNSlM3zrIbe0ibKptB+37FQkwwAem9e06IE2rbsCP6hSsrOcD6nADNUhLNnzGK4CBLAIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmnHLrXY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnHLrXY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso43597025e9.2
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674178; x=1774278978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGf7yZtpUu5J1lX6HR+56oGmyUxqirhDSxD8uYe+Tfg=;
        b=nmnHLrXYZbLWxruy8c4BPXT28GPqzFsEyJEIUgmKXwwyW64IjOXusgT2bwmOVj7NX7
         1ElGJRF8RMzQIkZdabbHy8CTYraV9ulEIBPgVLW20XVa0XJUwfvCkWo3LyyjjMzPyK9i
         CMc/9lV5JabUSB3SBttxu0XHGr6D+wU6tbyfOOanv9Y5SSqvCK2BhGbV7bT821ge9wp9
         CHB1rw0SuNC/BYtIxfsDLhEPi0wbb/HE7V0fwJWjYhc4Ci2H6CrCrj/EU6Oy0GRfmXRk
         +0yiDVNcu0driJvhri3lQULVjNyX01Oyk0xknByQtjNQ3gO/hdXWmu8hCkyx31uCCqx3
         XrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674178; x=1774278978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGf7yZtpUu5J1lX6HR+56oGmyUxqirhDSxD8uYe+Tfg=;
        b=WH1rTF9M5WvcclM3c+O0O7hVXd47MEMQkBi9iqMKxu7N9amUBJvscRC6ClqleksKNi
         smvcOSPw3co40GscAP4+8JxpuWt6n22pGooga3IcTtAfx1lzC+xl7kw38SQwCKGS8CF8
         6OrHpH3vvyClfp81X3N10yvsaGq74QUq8KxG5E5ZCkMsE8CM9yQT14wphbm7sk3oi2Dj
         S/OWLn8gGTGQIQs2wy1LQD3pZtKEuPxMBpWxaVkRZXLa25ofrxBHJAH0otVukZk5tVV/
         7WXYgElLeYudWS9UvD8fIkV2aBoYBDumQkzgcUgW78tyhhG4DpO6Bf+lC7kl0Z12caHp
         kfTw==
X-Forwarded-Encrypted: i=1; AJvYcCXeWWqauwgOc+gDa4a0hYiR9BC7t92T1QuD39eblcT7mKZTsLbtia+jXAxdr4cEAKvdj/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kuGFk7t06VzWddYZj7Gc3ss4GkAKaNctsbmSxwB2vx2Qxs3v
	Sb72WpCQL8bTkoZ/5TI5gVfb5QBpt2eXRcAvZpn7Qo/+TKq69L/ythxi
X-Gm-Gg: ATEYQzyF5UDgrq67y8HvMlgBNNMNQV7I8BquvwjTs3/oRkZrhwRSZvLCgogpQxQGuTw
	oGVY3JG1BoptFmhoRRwuNoCYcxKdqh5J4fnWRnpiQx1eooWYBt4ZtaNattiqfIOpugsMdRCCr8r
	fri7xHrntLSSb0CAVXbsWUQZPqdf9s3MEDUR2O0i3JNvbt06LLhE2X6b1kXlGRcKpk8gos/vTzU
	jtHyat+eL8A/Q4l15m64lbPCL6ZcFBUJszs9tQyJv0oVyGl9i6qqrIKIwMr+h/WtgBa1mUV5VRl
	Uk8dcjxuormCW0JTV2yJus1ayiTLs90vXjqqrnTqrS4h9U8Z0HJP4lNbJUgwaqyOYwzEjTsadv0
	oebAwoYNze8uoP10D4NlPjwfDuMRKtbSfMH+kt2TJNxyQ93tMFYEUMg5aaJaxC7OdtdKNQXwmY2
	8J/VVQtRvmX+zPZ3hgAv7DMuzHInOJQyb5ssoHnnZZPFXp54/6EduW0x79Yg==
X-Received: by 2002:a05:600c:c162:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-485566c94a6mr221915275e9.2.1773674178274;
        Mon, 16 Mar 2026 08:16:18 -0700 (PDT)
Received: from osama.. ([102.46.166.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556422338sm99206145e9.7.2026.03.16.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:16:17 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andybnac@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] riscv: kvm: fix vector context allocation leak
Date: Mon, 16 Mar 2026 16:16:11 +0100
Message-ID: <20260316151612.13305-1-osama.abdelkader@gmail.com>
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

Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Add Fixes: tag
- Add Cc: stable@vger.kernel.org
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

