Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8A23D7E3
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599229; cv=none; b=hLkMv5Vt7whNVDGtRuq3c8zGU/+mi4eZqg2E2xXInzSVU2pTkBPINRJGGKqhIj/xVzaqDFr2g/KhGhnaLPEvLsLQ0Q+rVhJTAWwKt/koRGzUk+A2skkXq7/pCj7WiYLXDQIyyIb59fLIgyVxfTTIyLvN3NZ36inLMHYkUem34hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599229; c=relaxed/simple;
	bh=rc5XxMzqZHN/h8i9gnu5Hvcap9+yLXVxJXL+WFRkUqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hv/eH1Tv6inbW6OLtzPwAgTQMTCa78A9dT8pNSSbnV37ESmxn70vIh5BxtUKFHz8C/mmzNkgN8qpbdhclWyEWZSz0mOKBXVIdBQWYsF379HKGu3HsEKULEzNDH+RvsHlNFgww+muMcnT+zlpfsEXMy448iyTEdt+J/TVAYUeuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbQLBtI4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbQLBtI4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b965570d7so21333185e9.0
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599226; x=1789204026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e3AIKTqtccN8F5dbw/sA+nWDkX82cUAi4NxD23crSBI=;
        b=SbQLBtI4blGEQSATmwNYqS8O1pPpXKegjPWq5lbCNSuR2SFtu3Tuq5MG1jPbQOQmhT
         QHK9A8dnq8HjNLiK1dWHFrFf6t7voIGguQ5bFDU39zHZunkmiPOJskswaHMYvl/vGOTd
         9JeTbCFBzBMwxOijOp9nQH9SJjXxFE19nK5Wckbnj31DsqLdhMPE3e3oschiKpCQacUn
         S6ikMl0qJnJH92CnQfV2VrVZLtVBjpmgFJ0M70RFLn4vF6VwrkMoiFqRSiNGFms/HTCF
         8kNq637lcjLU41jZGKbMKGahaFTwaMagwYUhvsoznpRvpG5K71q+P6umQBK3sXyTr5w2
         WD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599226; x=1789204026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3AIKTqtccN8F5dbw/sA+nWDkX82cUAi4NxD23crSBI=;
        b=fgiT2n7n3XA1nnsfpDAzDncu1extBa9ANpobgac2B5F1YS973fsLdJTlwBb84twdo8
         CEQmTCQWgk88+eFKuoHoNegCSdIm1SN55mX/N7B7CoAh3nP9ft2+9mU5IghJR5Yb5Pi9
         m1jMP0gJYosS2I/xOYiCELon5eerXuAeU6f2v6Q+0ZFRjX6BuocVHnCfZeK66RG0BWwR
         J2cG3quqa1/A8FrrqSn+hiK8+HA16iz5mygAzA5ujL7vaV4IERznYeigGOnVBGlw9Ebs
         fUVWBR2OOpZwU1CczOvC8LO1EJTjnU2pX+TFbr7d0+VpRKYnol9v0GVWZAdZ77dLWgJd
         sxfA==
X-Forwarded-Encrypted: i=1; AKwUvBzzM3Qd+fg5ysjBcDPRZE+Cdn7DAzv3q6NQtT0IUgsgIBpqyZGicm+Fgl5mWTs6jr09yVs=@vger.kernel.org
X-Gm-Message-State: AFuF++knsHdUn45yznEqOaI0Gzr2Ul1sAoQCcyNHQiOFyfexr+YdsHTz
	JtX6L38+1sH7OumSZSpP0mG65BG80eM7TwBcpec0uoh+BqJLjM87uM3L
X-Gm-Gg: AYBFou2Opo9Ql3GUyr3jL8/9McIGJhutn9fDpml8cECvk4x3j5JsuHmNkfXe63VwPCB
	yedwM5NnfEh3y9kv+agc7LE8iosGrAfQ691Dr0nbWp2KZu4tLHicoe5P/rAzsxx30s5JVTlq7us
	VgvOd4d+rJSQMUDGIzsuZb/TCQKJwfTDSrfMwZrjII+4p7jb5tqGL5hoq/p2RUCaRci5tBbwAuA
	OVyzO+PVndqupkC7533KkOnk0oqs9DE3R/Q9vLWhKXwMb3gYY5O4NuOxiO1Z3UKXTPwVFzi8+gj
	ROrHdbHZYlFPzofTL10T9+YLC/kcxQmzGoKNFeg96k3++TkX095VDwhTYVCtEUTQYVs8DsfGHEb
	Qs13LDad47aonfzpkKuyp2199PlqSpdq5bPgm+CJcXLdk6dluffYpIfcBSW3/vJtiJV9Cxogxpt
	GvajieC53gmiclHoRA+Xy1h1R6j0lt+MuJ848Z9rbfnafsUtLdWJxV4qAfc0f3oceYFD/dhLEVg
	A1Rv1+1xNuXe+pDo0qyjDYhCCJCEeXHFyjnP2bd3BDryjWs67G9TCjXMCvsofSAF7HtIhFTI/ZT
	nEEC9lxWirjwxqS3DOUN6khcyW/AnQ/NTd0sqWQ7/MqnrtkEBwNBI/5ueQtnLLYCRp7X
X-Received: by 2002:a05:600c:6383:b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49cf820507cmr104027405e9.5.1788599225704;
        Sat, 05 Sep 2026 02:07:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00a5b19dsm52248545e9.2.2026.09.05.02.07.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:07:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: KVM: Fix the struct kvm_arm_device_addr name
Date: Sat,  5 Sep 2026 11:06:55 +0200
Message-Id: <20260905090655.40683-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_ARM_SET_DEVICE_ADDR takes struct kvm_arm_device_addr; the document
names it struct kvm_arm_device_address, which does not exist.

Use the real name.

Fixes: 3401d54696f9 ("KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR ioctl")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9..7a2de8640226 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3676,7 +3676,7 @@ type KVM_X86_REG_TYPE_MSR, but are NOT enumerated via KVM_GET_REG_LIST.
 :Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
 :Architectures: arm64
 :Type: vm ioctl
-:Parameters: struct kvm_arm_device_address (in)
+:Parameters: struct kvm_arm_device_addr (in)
 :Returns: 0 on success, -1 on error
 
 Errors:
-- 
2.53.0

