Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03745040E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519535; cv=none; b=K36hM+85Ng0Z22+1qwTcvjpiFmirxezUceSNLMyyLEGix9cW5w+1nLtT6z8COWTAMf8OVE6ZLNz4fJOUMRHO/y9JyYcdYxvDWuAqcLIbrLnkaPhCaomykYjONsdS5MnyVw5tOVtzb/eP57P2IrEd2E5W+9jo2loRtIRQhqMwZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519535; c=relaxed/simple;
	bh=RHV6S91XxWOnp6mer53iR9CJQ71TXd8Ehz31ij4ywT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MtsJ5fXsELkA50AzrhPTxNdvo317ydViB0DttT9EN97Mev74+4wD0uPOrCYqB1fckrxX1PHzyNRNE9FYVKkNZH3fqVFII8sxEOqMCzq4Z2lT66q+rvvX/CtMRr4fUlX2riq801+8ejdPEPS9JyPinBexHNq6+1V/xQVQm3E21Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nG1Gum1N; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nG1Gum1N"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so15434105ad.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519530; x=1786124330; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4IW2TxQzpuRrl9K2PLDKB2iOCJoKXfZuD46r99yUXPA=;
        b=nG1Gum1NUvLsDqH/nmxPb5D1IWTl6eUcSqU/oF8K6xxuB4pdqaySO2ILWAUnw9uNSN
         ZfRwTKzYwnH27d4Se+Omwrd5GaQzbprtzcmgohZ531mH10UDY+NesMgGB+faHcNGvprn
         grunldGjtnrJjCScu9wpPfGgRQi3MLXHp/n2EkzzKibMUhyAKMzQelZTEIL9ZMHk3kJV
         ijqbklxWgzaImBSG/ilA9zOLnoCMSgvKfTSbVHiF9ieHH5P+3t7GA7D/kIAroOStFr78
         0hVr9O5e53JcDbLU5uBzQSftiP9uv1ceH2k4JU9QXs2V48VhkYl/OelF8FZu6vtkLPvI
         lPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519530; x=1786124330;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4IW2TxQzpuRrl9K2PLDKB2iOCJoKXfZuD46r99yUXPA=;
        b=CdeLTGByQdAfABsoTZWb2o0FfkFZtO4qYwtfLfu8PXln3Us5Qm9S4sk6NUsPIBBBiK
         Ty7FQng3JIgxk0zmAN2mQ9/LhEaDSnQTFqQkPV19+jm8wo8WjNgenYZujbGFGPOvJEIK
         nsPToSz+U7QY9MVpvhE7fdctmi2ZdiiSpBKKOYkmsd/6xEksVGTKv+LUuzANiG2/rGsp
         EvDrqcXejGTvZqo5hnCdh0Yhx68lg1LZyfywWNafMB6IRT9+n55TYyzQ/7rREvea1dQM
         //EdVVPZMJKnidEvSulO8dgeFvyn1VQKhjEFj5pVghYgdcx+ImhQXBnnUKiBs8BBRDxr
         9IGA==
X-Forwarded-Encrypted: i=1; AHgh+RrjnPtzwi3rE4ySAKS2xpH9ydcNkbO2Nd9x0TURySfXDKocEDHdNyCVJu7GWr1RPM+tB8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJVothi/hm/SFlJEM+50O1vGm8ZA3eLbH3Ak22xt4elfC6H4X
	eeJYkv3OPwygrkxBXjwc1oiucBud3aRAwGt9lGb1r/Rkycu5yO+C+MgGRtMN336qVAzA8iSYQun
	TfIm0AQ==
X-Received: from plbld14.prod.google.com ([2002:a17:902:face:b0:2ce:fc5f:e782])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84d:b0:2c9:d539:61e7
 with SMTP id d9443c01a7336-2d05221c115mr7938825ad.19.1785519529718; Fri, 31
 Jul 2026 10:38:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:40 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-4-seanjc@google.com>
Subject: [PATCH v2 3/5] MAINTAINERS: Add an entry for KVM's guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

To better reflect how guest_memfd has been maintained for the last few
years, and to prepare for significant upcoming growth and expansion, add a
dedicated MAINTAINERS entry for KVM's guest_memfd, with Paolo and myself
(Sean) as co-maintainers.

List both the KVM and KVM x86 git trees as authoritative repositories, as
any given guest_memfd change has a equal odds of hitting KVM x86 or not.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64980c262893..0e2f441314a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14412,6 +14412,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 F:	drivers/video/backlight/ktz8866.c
 
+KVM GUEST_MEMFD
+M:	Sean Christopherson <seanjc@google.com>
+M:	Paolo Bonzini <pbonzini@redhat.com>
+L:	kvm@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
+F:	virt/kvm/guest_memfd.*
+
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
-- 
2.55.0.508.g3f0d502094-goog

