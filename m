Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2ED382F01
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713208; cv=none; b=n18hYKGywF9Np6f734+XPvnH9gUWQORKdZBqcxwh8QZj2PR/JpOR3WErgQhEcAfa896FKe02nYfPl/5vvWeE0inxy7s35OjVRZSW0efhs0IKNINjizYhPmL6kG3/bb3Dh5jUefSLSRg9klt3yKwveHZu9LUl50B/6mklvlBmyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713208; c=relaxed/simple;
	bh=LIlVRse+25RxtmyOnlQuJCH604HhiMNsnfPesYWrC88=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aE67674doYo90wEmQbNBbzLu7Q6ZyBd+LVBjV9M8/qys0FxwfOHXZ+YjZieA/ZjVdm3CcxLb/SeGs0GFn3CYJKF0ISjcVm79SG0BiibbjgHVFkTbmUdkr1J5hk6yiLF+tkxUbnT4chG3RH4ELTLqj5Rq2121hamsR5C6txTZD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMX9djEl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMX9djEl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso6818894a91.2
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776713207; x=1777318007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHRd9u9MI5PwUdX38fBBtu+JpbE/7TyzB5nBUxMzq4w=;
        b=VMX9djElUKZbLdTgxGoNb3tAcR1Q+8hBy2I4vRPN8Nz4l+lMFjUM0KDHrdODMV7/yj
         ahiEn73oDRh7VGNsO9iBX0JsPAWb28Ovsa2MAgMnbhXOcDkb1VWgZxKkuecO3JmGJKHU
         yj7+s9grNe9vn1YvirlteR4DkkJkmiuLmDGbhdNIwbn36nUW8m8MJ/YR6F6s3HOn/+4a
         Igq8x365n1WmLMZ0mTrjgxeJIELthorS45hdHmPwX9wkSbiVWYo8ACK8xUj/EmRrQWMW
         2Lnj2yGbyEZZNI0fpusVfGwV7yFyPGY3XSqpU32eU4e3lOjWBrJkN/xXqd12GyVZ4TMr
         4A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713207; x=1777318007;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHRd9u9MI5PwUdX38fBBtu+JpbE/7TyzB5nBUxMzq4w=;
        b=MuxhCHD6w/iNv1JBBR5NWA9AHFGztPV8hZ1NKXwr2VNxzYrQRvHNAgp88vpTKamalm
         7/XJmfqJgjuS+8RvnUxrFb6V1c0gwNnzlBQY3R4RC8JMzMFL3ZEhabfpDqGhCHDJfrbm
         c4duXBh/VcmHIl7Mi4MXe/nY90KHXWTBlrscY+YYheTOI9PNToj4w417jPRm+7FseKe0
         AyPo7P8sF+QZHKJnPSZ+QXVC6UGNQtTCEGyDT/hnIm8BMrlTKsIMoq3DDVp8+34SeP/M
         GbyNDvLkI+hxhH0S9PW1HJXL2WsmeksuCDI/XLB1F+5+o9r25dOypm9MSGhmZ09NmTLI
         fCNw==
X-Gm-Message-State: AOJu0YxfWuQG1YN4RGbbhp2HCsRNUwNNA7U9L1OYpBwS4KGYaVHeK++r
	3NkM1fPq51l13vY+3FviuOoTKGye0lKHse+Ppkj5TS8ZF4dyqHZFhUzD7TPBlPS11M2semUbwUv
	QMsfmjg==
X-Received: from pgbcq10.prod.google.com ([2002:a05:6a02:408a:b0:c73:9dd1:e159])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9996:b0:39b:bee4:2952
 with SMTP id adf61e73a8af0-3a08d908020mr17032576637.45.1776713206551; Mon, 20
 Apr 2026 12:26:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 12:26:44 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420192644.3892050-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Add check_steal_time_uapi() implementation
 for LoongArch
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiakai Xu <xujiakai2025@iscas.ac.cn>, Jiakai Xu <jiakaiPeanut@gmail.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Anup Patel <anup@brainfault.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Define check_steal_time_uapi() for LoongArch so that the steal_time test
builds.  Note, while LoongArch's steal_time_init() has some funky asserts,
none of the code is uniquely verifying KVM's uAPI.

Cc: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: Jiakai Xu <jiakaiPeanut@gmail.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Fixes: 40351ed924dd ("KVM: selftests: Refactor UAPI tests into dedicated function")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Paolo, if you can apply this directly, that would be ideal.

 tools/testing/selftests/kvm/steal_time.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index efe56a10d13e..ea18bbbbd9f9 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -461,6 +461,11 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 	ksft_print_msg("    version:   %d\n", st->version);
 	ksft_print_msg("    preempted: %d\n", st->preempted);
 }
+
+static void check_steal_time_uapi(void)
+{
+
+}
 #endif
 
 static void *do_steal_time(void *arg)

base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.54.0.rc1.555.g9c883467ad-goog

