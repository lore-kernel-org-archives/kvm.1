Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC843DA3F
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396563; cv=none; b=qKD+JZ+Icx/TMs4/bA8g/boMTySvsGFXukJIHTJjWWViOBCQzBxL6vyh9UQHCD5cvKgXpKis6d1wxVwl9BmTeQgGIVqKzsMu1t6qaNNLYfd518OjChXM9Vt9Y6W96IAj8X1ElQMr0jmrT3TUo82Qv+59hKIEBW4smaDQaMCwkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396563; c=relaxed/simple;
	bh=sJT/BWB71XQHqaBeAa7pWa8ixz8I9grIBnJEuBlwnps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMSyyO1s/FL1DZW9p+IBYaDmOLUKoMa09KzbCb2CDcgzi9RrzSo/LKjrXEg2jqbHo+bvS/RNabG5NbE/TDbxf5domOdvFYITOUx4JCseTRToTK4RJPoHmyScnuKN9hfbKWt5s2tCr4RmlOb9go7SnuxkVe7Hac5TohWczqUZiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fi1IY9X3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fi1IY9X3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so14139041b3a.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396556; x=1778001356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pB70d3mVql6RUUSlFgAqlD0KUMSBEvpQeqGOJn9+rvk=;
        b=Fi1IY9X34lFrNBtH/jIZ61CD7Xq+MJuHaGTGboYhREW+kbjZO5tX7DnMaO5RhnWBiA
         UwHZ5OwKTDPqb2iaLAlt+iNo5pLDq46XT3RgGPLWveny0Fk3qurJuUYlmbFi6FY7oeif
         FLzJNTiojnU8LYi9isg2IRH6yesTpG4SNe+md5a4UnfD3NipNCWK5e7Rsdcew4wBxEZa
         QjQ3rFy18+geuuHtGIQFYXKkDyziWRdZPxJLE2a+1ckQjyY8djvi5D7PKdrpISAifzLm
         MbNPzZaKGgJR6lECvutsqAhMVkEiv8X0hikWoFo0DwzE7wjStcUjBEASoYA+OjOKALth
         Gs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396556; x=1778001356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB70d3mVql6RUUSlFgAqlD0KUMSBEvpQeqGOJn9+rvk=;
        b=H6WSfn2kIK/BTx4JD67wm+p0hGPVz9Glicniv51KsH5rfoVGKIzwjxWJGWQIugnaI/
         hmHjHNpfQ53JlwzZbne2d+Tlhwq/PsyjFopxFGFaOVX49RYGZyYHiNF2OsBJNnoc1eio
         JYqyX5KjmEPlSjXx6CSAtZ+NCp2l28oE4V6O7p3qgN/Gcx1XNGcJrIi02jytvH59fjx5
         cCK4O1vTvpBAMcfup0d4SJpMZCwKFpOCG4CvAmiLZFsmWWzdNLw2ne77LK/4t/RfXuOV
         l3YfvqMxo8c8mczDOLT/2Kgwkdhe8bE016ZIdODPNV+x8esJYcYG4RISaGzP/jSv2tCk
         9GpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MezuiKWqkDVPb0C0sKgqVQVRtEbam6us4aCV0evpXi71GPgheo0s3RhB0R15wOtMzMnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3VBWnUrlqEukA5GlPCL0cN8Xeh7LL2K3kXQIDz0zA89qOSbC
	4Q5CDcrBjkwUUeYD+qams648FPPEfkOxepl84K/W6l3n3Fc4Aj4pWXMuvbNT/iBs3MTRbPn1NIH
	Iq7vTCQ==
X-Received: from pfbhx21.prod.google.com ([2002:a05:6a00:8995:b0:82f:8b22:bc77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c9:b0:82f:a6bf:bede
 with SMTP id d2e1a72fcca58-834ddc59be5mr3940969b3a.40.1777396555594; Tue, 28
 Apr 2026 10:15:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:37 -0700
In-Reply-To: <20260428171541.1342335-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-2-seanjc@google.com>
Subject: [RFC PATCH 1/5] MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
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
index 2fb1c75afd16..89b470db22de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14149,6 +14149,7 @@ L:	kvm@vger.kernel.org
 S:	Supported
 P:	Documentation/process/maintainer-kvm-x86.rst
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/include/asm/kvm*
 F:	arch/x86/include/asm/svm.h
 F:	arch/x86/include/asm/vmx*.h
@@ -14419,6 +14420,7 @@ M:	Paolo Bonzini <pbonzini@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/hyperv.*
 F:	arch/x86/kvm/kvm_onhyperv.*
 F:	arch/x86/kvm/svm/hyperv.*
@@ -14433,6 +14435,7 @@ M:	Paolo Bonzini <pbonzini@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
+T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/xen.*
 
 L3MDEV
-- 
2.54.0.545.g6539524ca2-goog

