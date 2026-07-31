Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F573B3BE5
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519531; cv=none; b=DKBqucClLXkRkn1Qhw5T4IboRZrVhEnfNhJAbCf47EWXAWOQtbev01Jdzsnzm1QGhPN96fNzxoS9u9UqeFlVH1yMohTpZPByqQIV414o6XOR0K1ZkmDSYQ6kDUErPdUV9HA5D2CciV+PcQC1U2i+kAcUS38YouIHt5Ke+anqkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519531; c=relaxed/simple;
	bh=meCCSBL734D9Q1M1uwIxFv4KCDWodhRKbkGy7nqlRi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rktZux5Gvc5qzE0Lsq4WQHpOXQYgZIJ1R8ZuN9ItSZcXsknfHycwOd9BDLYSE4Nzo2r/8tAa3psEqjPOU9VxLfl9K/qNhtZX5ziHHwLKKFsODCsB9EOO7vinKiAA/3C9ia8qMtLTRLbshv1mr3uPT4ssYj0WZw39MP3aSMsl8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEw750Ac; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEw750Ac"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so867303a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519527; x=1786124327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=64YnTUVabG7Ruds97xJ+wo11mQl+SR7u7QmqbKzHZSQ=;
        b=uEw750AcVgCzqFOFDwuTbFKSPHn0YjeQgKp9wlxF049yPx8qcD8qTefPEVOYWJuOsl
         ACshc8UAr+i/LZcVrttlDeE1pnOXOhFmRATpi8JV49Tn9Qv6AHQ5XBVNHQ59KYIkc5gc
         jhD+NgKi8CZiqmr5Y/iAq1GE7HMDhcJTcoEuhRE7qqm/hAMtBHo7BJRO39lHOjiE7bl+
         cprRZLEWImTLKwTJ7zj+KnKmgxpUv+WksK01hmk3D3oQOAeLhXfwmKn/xvBuBoYL1/Gy
         G7Sb9PTjhh88cJpl8rtEDIVwOOaF28wi3eAuBnQDm+LyQ7OGh6+sg7zpgkkKee/JbizB
         2wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519527; x=1786124327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=64YnTUVabG7Ruds97xJ+wo11mQl+SR7u7QmqbKzHZSQ=;
        b=OTx8sPzUXPzqz2WIj/5h0Zf/Ofdd0Lkg36cwXCpeUobCe5ymNJipOZS7TgURrD7BTx
         5hImltm9EI9Kb43Y5RB5y+a1nC3Q2oWjGT3jIW758qbg13iQS4fwGJwpgfvPqn9RrEv8
         z0gufqVS8f4TI/8g3xd5K735pn5cLjQhWHFzEIXZn15dXpyUTmdsT6EVX3UGC68QbJuV
         EfyExW8pP70L0jd3o7EfdKRsfC3q6OJwW6uTBwiQxpwAJNqN37VTOp7wTVSPi1ZJoxN/
         I6WMx4lyQo3HcjiAxFkzoPnPe1WrYn68Z+ORbV//2eDIpYkX/zPjXbONUi5U/L1LhUQt
         HIvA==
X-Forwarded-Encrypted: i=1; AHgh+RqIsUvT/yFiSmEZp9PsrPK2B+FBXdDDTUla0zp4GMnwQOaBiVTR9cTMKtmxrWV/1iJ3Big=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DTIBijRtbuAvS7xumvTy7aFgUDeFwbVxgDeuvY5fyYIBd4oE
	e17HTP43+GUHlBnGuV56Ky3JVTiLyKAOB7O5PzihsaMFA+6JLNVyPOSaMPiE+A4pyLbg9lTSKth
	sOHpzHw==
X-Received: from pgbcb1.prod.google.com ([2002:a05:6a02:701:b0:cbb:676d:ab19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:310c:b0:3c0:9c19:65a0
 with SMTP id adf61e73a8af0-3c92a95b9damr577148637.72.1785519527180; Fri, 31
 Jul 2026 10:38:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:38 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-2-seanjc@google.com>
Subject: [PATCH v2 1/5] MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add the kvm-x86 tree to all KVM x86 entries so that humans, bots, and
everything in between can more easily find KVM x86 (and some broader KVM)
patches that are targeted for the next kernel release, but haven't yet made
their way to the main KVM tree.  While the KVM x86 patch flow is documented
in Documentation/process/maintainer-kvm-x86.rst, that's very much one-off
documentation; random passersbys likely don't know it exists, and it's not
suitable for any workflow that's at all automated.

Reported-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a8edbf2625f..64980c262893 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14163,6 +14163,7 @@ L:	kvm@vger.kernel.org
 S:	Supported
 P:	Documentation/process/maintainer-kvm-x86.rst
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	Documentation/process/maintainer-kvm-x86.rst
 F:	arch/x86/include/asm/kvm*
 F:	arch/x86/include/asm/svm.h
@@ -14435,6 +14436,7 @@ M:	Paolo Bonzini <pbonzini@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/hyperv.*
 F:	arch/x86/kvm/kvm_onhyperv.*
 F:	arch/x86/kvm/svm/hyperv.*
@@ -14449,6 +14451,7 @@ M:	Paolo Bonzini <pbonzini@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/xen.*
 
 L3MDEV
-- 
2.55.0.508.g3f0d502094-goog

