Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3594457AF
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519538; cv=none; b=UXtBaeYhusUm8H63Gk2sFgVFgUbBwueejpy1Unk0/MUSYyXoqbvY41SYB8uzqFSLryxFBAcV0pS5uDZLTdytZ0isV1m5h0yuFMCTiWF8Px25aa4xDNJ9JSjRJ23IZGeBGcH9oSGThq2ye/sh2UxuwcSgbxL2kbpLDp5R3y8lavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519538; c=relaxed/simple;
	bh=HfHLi0n7NJXCkv8SfNe7UdWHCJxfBRplb+v+0FPqIfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnAO8Zpimt09RDiYMACi2ZRasJdrFZbcQeyi3zzZ0sWtfrl7jqvdKTCMqCaK1i0w2q0mzn8W01E57tJW9KCFItbpVxmvp4bvvD00L8+Mk3gaS/KSsEKGEMoqK0Es/L7soKKRXJmYBAnMDbEz8tifHhv1C+xpiluPh9dNpFvBmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fh6sGkb3; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fh6sGkb3"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso1561884b3a.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519532; x=1786124332; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iSnPYifs8rSuCLMozXNq/Bjt5pw2LxHM1o1rTZeLjL4=;
        b=Fh6sGkb3yP8lhSAmKZahp30t53jn8fQOhlF8hNja/r8HqPukOOIygEbw4Ff1kZq6cp
         c2wtHZ+y09Oc2yfpDWAhddmBxQeuD73U0q6x4d8I1iIigX4yUeAYj5nQscQnqikmcuB8
         kaSjDNknNEPRKqirW57PK8qyRHOa0il7pLOgEc1cgRukaXI1Ig3G38z6qMnmSVbzeymL
         844Xh6QxorfpJ4r4p+sh4HiXaAP1NN9cP4wwxA0JwPgMcnV9syZps9UKitq9wAVHclGM
         CTxGJmLcGBCOVxOD/RU6SzSh+1vnZS/Kvxb7d6y9bmZ3NdxRDxCfAvsxCEQ49DzahFxa
         s5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519532; x=1786124332;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iSnPYifs8rSuCLMozXNq/Bjt5pw2LxHM1o1rTZeLjL4=;
        b=gMMex0D4zhDBRAYnv3lrPBkbt7+ASVtuPQFwx6srQlUAC5QJ5xAaYxZzW6IqYxUowX
         I7jxAhMYEPYUTOSh58SpvQxsZfghT7jr+xIaQ+4EhlIc+NiMZWDRarBn267/9Lmi7kQu
         4+NqBkZOOnK7px7QRuK9lP43fLqHM24tnU9AiZU/Q7LF/e3E71jZlkLQBgHcOJ+xv3yo
         SASfZPSFs0fDuwv3dsSHMOZdugbQEbQPKv4+B3F4POhBQUbLQIIv9bk6Q5psU84RiX12
         cIKG4mU2QJgMCotCa/9YoppyCl0FTMbWgRiG1jIFDBKapJKdCAxXVsSinTHR0X9qqrNc
         FYng==
X-Forwarded-Encrypted: i=1; AHgh+RrpWTobZhbp5xq9k54SDusLlOK3GxTsF9dRHVC0hH3lnhFI4sh2kBM1JobIZ6kXL2FW5ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQ8Qvmw9KMj9UM4K4gooXS8Qr5vLFa9DBKQxq1DgWhTiIOb+I
	wn9QRl/9Uzvj3i13aLrQ3tifGkrIiKcbiHMYwazoZkU4Myzm7Q6A/kCPEs2kYP/v/hOrjmv0m+C
	5n/G4jg==
X-Received: from pgjj30.prod.google.com ([2002:a63:231e:0:b0:c7b:b2bd:6cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a17:b0:848:2c5e:305e
 with SMTP id d2e1a72fcca58-84ee47dff35mr518256b3a.6.1785519532321; Fri, 31
 Jul 2026 10:38:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:42 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-6-seanjc@google.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in the
 main KVM entry
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add myself as a reviewer for overall KVM, as I have been helping shepherd
a decent chunk of the virt/kvm commits into the kernel over the last few
years, and I expect to continue doing so.  Of the 270 non-merge commits
that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
coming from non-KVM folks, e.g. from treewide changes.

Note, this intended to purely be an efficiency and quality of life
improvement, for both contributors and myself.  There is no implied right
of succession or anything of the sort.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c79bb25522f..556ccf640516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14047,6 +14047,7 @@ F:	kernel/umh.c
 
 KERNEL VIRTUAL MACHINE (KVM)
 M:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Sean Christopherson <seanjc@google.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 W:	http://www.linux-kvm.org
-- 
2.55.0.508.g3f0d502094-goog

