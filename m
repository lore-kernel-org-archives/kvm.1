Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225A3655D4
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785949; cv=none; b=jKR9tMw6z0OtBIAmU83IV9DLQd7P4Tog8ZWJgcBz6nDbyhFq+0ESAUiPyIJfNKKdSQ5Xv7tBlKDq6EC28UFfvbJtvrbQSyoNvzfQX8dXGNZaFG8MxkwayBm+CHkmdUkBl1xFn16hnl2bOhuGNwmDfJIz5L1eoQbxm/Bzg0cty88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785949; c=relaxed/simple;
	bh=ca1jM0fOCLIP9WuBP03SPXW8RpJRHt73yJX9//rI98M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSc80k43vEpm2FulCOHE3WCB97i5N+w/PtyAArjJVXC36voCkfhEhOXN69VUMX3VWovVbT4fKP8/L9Zwa5zsBeFqQjiYzU40SaM6yDSY9EAWml4ZVPpr0OaTMkpx44SweMl1IXhcp3uZSIer+H/7SUpJ+3EYxAWwGrpGK87QcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4mR3ySA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4mR3ySA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4998e0916faso3628185e9.2
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786785945; x=1787390745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk8cmy7ROF0KR33i9zqmPXL+Xk26nOxz+b7oFhOL0UE=;
        b=N4mR3ySAqDNC1eti+WwmUO+UEyq7GOOKlIaoCfl8PFplEw2Sc970GRaMAjz5boYlfe
         h3WTtpJmADHqZtZ25wBnsShQpbfJHQRS5XFwsxuoChF5XekSm0uRwc8H2nHokYVFwd9x
         DuZV6R8S0ZGoNiu6lL+N2TlgxTofx63KfnrDrjqcsAw2Y1ZVmzeNg7DpeeRVS7FxbRvw
         Ry2N05t1HTnyrq+nhJflM8WjhUHfrcaIAHC864U0208CfqqP8ZtWI9R8UFCPN9VAWX2b
         V962CBHjnIcWSEZnb9nv2WThmuF4Cgqj20xlnjbeVWMH4WSpFGRDWIqb3WEm5MdKsZKm
         C8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786785945; x=1787390745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hk8cmy7ROF0KR33i9zqmPXL+Xk26nOxz+b7oFhOL0UE=;
        b=DPkjsH4iEnW2JVB5bE/ft2xpxCVTnzlGNFDzLI/N73uIAHNsUG8Hwu5gdutuoDF2qy
         2ud35r2YZtYTqUvq8Pq1Ox/L1VA5iFYkXB6rmJwJWdrY+JFU8kiWji2BjercKo+csnr5
         0b5j9dJx3iQw9d4END8Y9/rdnm6yll25TyFVXSQK2jQVwLEdhIDoKhU2dGfYv1EVrJDk
         lOe59/wI1UyyXKcpVKfvNtelWx4mTwyHjVuV1UM/NY3zm+FtSOHl55uqaGVYi+I3pyQn
         2v/28CxK6wDh6DKSeQbYGfvYy6zzwELLqJMQ4rQKeD5gJT5RbvaejXtwTV/rkznL+R1h
         HOgw==
X-Forwarded-Encrypted: i=1; AHgh+RrUjshxFVOFxdMWNZdi23MkwYJ1DzaTjl0TqY4gNecFRnO4NexSBjOuGLJh/1ozzDv4AcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTW9yi3unXJl6a8vpan18mYY+MloMpAFah1cyqMd4wl6/T2/+4
	s7f7VJNo/2jiDJkyqGiMSNrmbGKwd+vfqhkCuHmSFra8CMc2xdd+TDrM
X-Gm-Gg: AR+sD13xb/rfESbB8UukzIK0mO55Vy60UKmDRiRbeS4yP8My32zXjAJa1WLNhw0/Y4d
	As2ewYjXIkuKbkEjUmiaXWlWr/6a4dv/T1ra1P6b0QpUxghOO1Zf/d9HuXyNN4G/r1OLgkYnTfa
	UgE96sjBGv6DgsTDgIkk13Di56CKcNCyZ/fflqCu/iPAabASjgNGRLeJ49SYQIG0g/0Qa3BRWHa
	x5HGr1RXepIDhSKVtGdOHPUgDZvENR19e1a2PyS2t5982ndnCb6nx7VAPW2tE7dOEkbwa5XCNIo
	L89z1glPZiUCD4CXAj+ZPHfG3C0PEzglR8cQIw9Ten+bDXh7uCGu304+3sSyJg/jL6MvAnYgrtS
	U1ZpvtC7kNHzB5Nqgcphj5TuaHNc//oWb0MLirqawOzqXpQuExzNtgG8qHWQ+B8EoIwgopN2NsG
	BhoF90DGRR5eiaTQrGbbjTY87kbwyjICrIPbWNoGQ0z40Dr74rqsWhlwdE3Eal168gRHtDEyfSp
	rPE8VFKvEGor+eoHXXryEHpNOq78bc2EF/zzItvkKUWjj+P8ozQaTt0Sl7Yy4MG0uQ+BZbaQzVy
	Q2Z90N2tuyreQkzikd6w3WdqY9llhz1d9Jq6RXLwuB8kiwuAWDRsxR+Ud1L1V1+LA4Lv82xndQ=
	=
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr158343345e9.14.1786785945038;
        Sat, 15 Aug 2026 02:25:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998ca63e5csm29202615e9.2.2026.08.15.02.25.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 02:25:44 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] Documentation: KVM: Fix the GICv5 KVM_IRQ_LINE PPI range
Date: Sat, 15 Aug 2026 11:25:37 +0200
Message-Id: <20260815092537.31737-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM rejects GICv5 PPI irq_id values above 63, while the documented
range extends to 127. KVM also rejects PPIs not present in the
KVM_DEV_ARM_VGIC_USERSPACE_PPIS mask. That mask is populated by
KVM_DEV_ARM_VGIC_CTRL_INIT; reading it beforehand currently succeeds
but returns all zeroes.

Correct the range, document the mask restriction, and require the mask
to be queried after VGIC initialization.

Fixes: b88d05a893cb ("KVM: arm64: gic-v5: Support GICv5 interrupts with KVM_IRQ_LINE")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/virt/kvm/api.rst                  | 4 +++-
 Documentation/virt/kvm/devices/arm-vgic-v5.rst | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e3003a241d5b0..6d8fd74174492 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -912,7 +912,9 @@ The irq_type field has the following values:
 	       in-kernel GICv5: SPI, irq_id between 0 and 65535 (incl.)
 - KVM_ARM_IRQ_TYPE_PPI:
 	       in-kernel GICv2/GICv3: PPI, irq_id between 16 and 31 (incl.)
-	       in-kernel GICv5: PPI, irq_id between 0 and 127 (incl.)
+	       in-kernel GICv5: PPI, irq_id between 0 and 63 (incl.), and
+	       only if present in the mask returned by the
+	       KVM_DEV_ARM_VGIC_USERSPACE_PPIS attribute
 
 (The irq_id field thus corresponds nicely to the IRQ ID in the ARM GIC specs)
 
diff --git a/Documentation/virt/kvm/devices/arm-vgic-v5.rst b/Documentation/virt/kvm/devices/arm-vgic-v5.rst
index d328cf1e22c1f..e24aed0c4afcd 100644
--- a/Documentation/virt/kvm/devices/arm-vgic-v5.rst
+++ b/Documentation/virt/kvm/devices/arm-vgic-v5.rst
@@ -35,6 +35,9 @@ Groups:
       populated with the userspace PPI mask. The lower __u64 contains the mask
       for the lower 64 PPIS, with the remaining 64 being in the second __u64.
 
+      Userspace must query this attribute after initializing the VGIC with
+      KVM_DEV_ARM_VGIC_CTRL_INIT.
+
       This is a read-only attribute, and cannot be set. Attempts to set it are
       rejected.
 
-- 
2.53.0
