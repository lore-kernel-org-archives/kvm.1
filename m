Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBE3AE6E6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266261; cv=none; b=T4mDMkpKjdaeHGrypcu9ZkYrD8/BHesk7r1O9M0FmNtYM3UgVdYExhL1VyQGG7PHdce4JmdrS+fxCfLtPDo62WyGQobS0N4/U/ybYQjtSfrs+j7a0dbccPJfkX07kU9hvQOQEnsAooh8cHcLH2do1p0ICFeRCtygGYnObU8+XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266261; c=relaxed/simple;
	bh=/Ue+xg/ZYuqPhzuc+/3aJh35/slPCJ4LyrjEz3FyDVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQOb2dQoaNQmKJ1iLT+ZUgDBjaI0W3YvhIEOtYwPPseK4M/rtRlEiU5GyHWwKVkJGRAg/rExfpuJlOvFMB9WNTflPcfvdddDx6/lS8e22NpbFl/9rSgVmQA9I4OSROTgOnNWaf8BAxqceqUn8JpMZlTWwM8KPpXXl+MFHkYL4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnIuPHWk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1WAPQzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnIuPHWk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1WAPQzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779266258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F5nI6BsYXOkdJ0E3XParxZZiduu5LexwyHVtg9UZQ3Y=;
	b=HnIuPHWkHsqv+cvp1qzpEPcl7aVk3c7T24B2MzQ+7PyN5AuQRta/zzmdFAhExRClx0dBq1
	xRwFl6xR+AnOUqSbg0yLy4AEFCUqc5aT65pa6GG1Jr/DFp4l0LPRqV4t9Z2E6uukxAxgvY
	JT99AtuHTsjkYsDBHymzN2eJhUbUbjA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-fhF8j0_uN2u6h6f2apjQqQ-1; Wed, 20 May 2026 04:37:36 -0400
X-MC-Unique: fhF8j0_uN2u6h6f2apjQqQ-1
X-Mimecast-MFC-AGG-ID: fhF8j0_uN2u6h6f2apjQqQ_1779266255
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bd09ec46507so422370566b.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779266254; x=1779871054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5nI6BsYXOkdJ0E3XParxZZiduu5LexwyHVtg9UZQ3Y=;
        b=S1WAPQzhffSgA652sguc9NkFVayrWz9jTuznBTzfTzGLAxuZX9Q58ndYkEenCBFWsZ
         pb5hsawJNB7vyzJHhKDTF24C/OMcNjNDSImh2yGdnxmIt4ceVEfhqkct+eLnJXUG6faw
         tp1gc6ZGECiBFsmeNOmty4Vvy7asr0ugeGLzGzbCpTHoY8c9EtanOqpvgk5ESm8X05RH
         6dsnz21qHqySqs3xJPiSODRmiNxv4F9ax8hVEa3dXyJLxVPRCoZd8oD/nz+eUjXccW+k
         pMnKbMSQu8k/KHJAyA2obWWhmi36cXwhXwLQJkcCl4876gwrKWi/NHU84QdvRqDN6dUD
         bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266254; x=1779871054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5nI6BsYXOkdJ0E3XParxZZiduu5LexwyHVtg9UZQ3Y=;
        b=K45LUvjrhf91cUByg6JvaYLfE5kuBPZlQFCdDnlV2aPI3OwakH2IosSIkT+sGrsIdX
         oa9T/4bkKBY4ZwJXTef77U4BJw6porozxfkoXxVI1OdlThwpEmlowTold1hwU+D28KHj
         dytjFRY7FEqfFYIl/PFpgzxoaXvvz88EZlALXOFBpfIRiqPxefBrYde/dOjVxGUWakV6
         Cb8c3Vrd1o3+r9IGZ7PdkCMyymQAP7qnRrcLwV48x4g+CWJxzR3uicy5dBNSg6ECDZAe
         AGRuttbFhRcCo06m9ZyuIfLxuaAW3m5Iq9FY3tCjkNftHtrgS+N0zW1HArdgPRQ6FiBa
         vdSg==
X-Gm-Message-State: AOJu0YyLMvBX7d6j2FpM1Mbdg2F8zZ7eTdOtqpPoYhFcv8tmDS65tmDX
	sVLjl1xXIl5NA+VLQfkNZsRvB8P3z0/RzCTmThp1EsS2ptqF1SN5SUCLMdQWxZ1RzEfZOB/w+Dp
	2eT6cOA8G15Ldz9pC5CccyvRLu4X0oq8/YcuLT25wzoQnByfZNek2l73+ZYEbzYCEul3blP1+Qd
	VStjXKs8VOARWNPWnCwomCjhUPqj6QbYNLWiRLCGfM
X-Gm-Gg: Acq92OHZWupCSCE/mEYTfb3b5fhoIvvKQU2AmmzCjGvAmqGmlP2hQogx8Gxmq3KbT5J
	nFaMxXie9n1lNmRyZzN+wMNrd6hmzQq9PtwIOcqWknQoOvvUc/a/lyhb3Xu7/ugpNOBWv7n4Eir
	flIG7qPf2UFfGj33LeIGRvjaDKQyEcKlzrqMjZ+5rcGfEJThEqHP7S88COjm793yiuqkWEsvMsw
	u3pEP7pPc16Q7RlK/1BVhhkD12kacSYa2otqWScTs3N5SgDRV3uqvPVmn3ANAUwatOX3KxCQURJ
	Rq4Kt3iQ3i1u125BC45pthOD0J+Wwd1xyFI2Ah7rG4L6XXQvgfI7OuKnePFaKp9MiLsI2B/pY22
	i2LxM1Vd5ZK7VgO9PiF9rCrbRYTISnPybL2gggoOMUwibGco+vQCdJfICnklDHP3bnNCdRQnyPn
	KbwVFBX3/RVEGsDpbhX676T8nZ4DjtWAJHIQ==
X-Received: by 2002:a17:907:5c6:b0:bd4:f598:cc3d with SMTP id a640c23a62f3a-bd517ab0e92mr1144437566b.41.1779266254367;
        Wed, 20 May 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a17:907:5c6:b0:bd4:f598:cc3d with SMTP id a640c23a62f3a-bd517ab0e92mr1144435966b.41.1779266253892;
        Wed, 20 May 2026 01:37:33 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eac613sm820639966b.56.2026.05.20.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:37:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH kvm-unit-tests] build: add -Wno-override-init
Date: Wed, 20 May 2026 10:37:32 +0200
Message-ID: <20260520083732.360181-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -Woverride-init flag (also known as -Winitializer-overrides in clang,
but it supports both spellings) warns about code that may be intentional
or not.  While the unintentional ones tend to be real bugs, overall the
idea of overriding function pointers is more useful than the warning.

Cc: f4c5838c ("svm: add basic GMET tests", 2026-05-12)
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 403fd495..42ef5826 100644
--- a/Makefile
+++ b/Makefile
@@ -76,6 +76,7 @@ wclobbered := $(call cc-option, -Wclobbered, "")
 wunused_but_set_parameter := $(call cc-option, -Wunused-but-set-parameter, "")
 wmissing_parameter_type := $(call cc-option, -Wmissing-parameter-type, "")
 wold_style_declaration := $(call cc-option, -Wold-style-declaration, "")
+wno_override_init := $(call cc-option, -Wno-override-init, "")
 
 COMMON_CFLAGS += $(fomit_frame_pointer)
 COMMON_CFLAGS += $(fno_stack_protector)
@@ -89,6 +90,7 @@ COMMON_CFLAGS += $(fno_pic)
 endif
 COMMON_CFLAGS += $(wclobbered)
 COMMON_CFLAGS += $(wunused_but_set_parameter)
+COMMON_CFLAGS += $(wno_override_init)
 
 CFLAGS += $(COMMON_CFLAGS)
 CFLAGS += $(wmissing_parameter_type)
-- 
2.54.0

