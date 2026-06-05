Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787853C09FF
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692938; cv=none; b=D+DdUC8TKyJ4Wy+HKX4HkmctjXPk/0UKAmklKzM/8qgMQmSo/pdKtuPon9N4aNWaVcYHVaP/pYndJFUVPXWZN+lqS3Z0zMuJASicZ/0Y/UHL79tamoowsp+1AVSHhdnvp1h+sbb9XZW2tm9wqvlfxrVxYYDweEoL0M0jOX1TGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692938; c=relaxed/simple;
	bh=0vydJJLS3Sntbf5LAp34fsIjIyGOa4+ICeBoCwr8TsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Go558bbyDHbU8eS3JnPtBLtlDnFtkTeE4q0Qp2SCQcQEA6vCk3IPlyC1JFfd6805r+8Vt6Xb6++MBOYnFRUeldb30255SkWU41YxGjCMqIQH2Lu2SDY5LgtpBxKNW9IiHSy3aE/KyUYrhZHshLSHEXnEI7Qtbjh88CXfSub3RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkYDnk2f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkYDnk2f"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf2bc4371bso24308595ad.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780692937; x=1781297737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdePwDbGlnMmBliR8vYN2IkY1Za9M0DDxswlaOroTNw=;
        b=fkYDnk2f5GUB2YOcE7QHWHvtksQMIiIANHGf15ZTE8YBB/InGILLTYTJUbr8nXAIIC
         8l6n/u7eR+jcShzGsTw5K2yV3a/9vS7xizDGkDfIXr2ACYBo0D8Vaih+jblXFvFZnOmM
         /b1lJQnVTOJD28/b1gHl3ume6Mvn9mNMWhakSfu2T72UxF3wC9yWWiJlsP/YWIe40bXF
         mBgZAafgtekY1Evqr9NRXg2GaTjXfwYJHfS7oEuEoyHEsHOOghYMnGTY3j4KI4Ztyls1
         IZtzGr+qjiEH/c2Lqt7W6bYb43VGIXB7qSEksui36Y/IH8wNnsx4EwRbt6bmtiV6dXAi
         Mmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692937; x=1781297737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdePwDbGlnMmBliR8vYN2IkY1Za9M0DDxswlaOroTNw=;
        b=sIQ7ZP1T/8jeee8ZXZmBZgGxMLLW4w76n5W7I4hbPyYRBKuaDeNvZogv3CKW8JGOVJ
         M66+ZjLBOeCfwnGa8KfsuIkloQYkeWbygo9QzkCrDYQMa30CvvzOXPjfYFVhYpsZFxa9
         5f6ahc6pg2HabCYwSlpswGSQB8ENXlE7A6Q5vIO4by4TXprsUydJb8HGyutPRZw65PDx
         Z+6tyToY0PU1pk1bZ5Ke29RFx36LzhKTvMJZzcgaZa/hfxBhe84mhkkojRVgstk/lvrz
         RtGWP8P5idSqFz1LC7Z4muiYFz4bg3HQgH0pRdndVMdqQhEJ50dqKsEolOQpB4sBplFf
         iwMA==
X-Forwarded-Encrypted: i=1; AFNElJ+F2dE35Lk2YI9eLqMhIR+O7nf97DTL3tUAaN2sh/HT1gEsI1Iy7bLuEE9NGLYvvAqrIBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznASRJO/7iy9AeB1V0Plz5pul9S2rRrzW19lJc6sCmGLskwNJB
	eynorKQNFCnkEjx0V0m7o6jVGwy5rCw4X8C6uJU5mlfS7op1b5PNCEWAxRhy9bEOpo+9XictXw1
	4reQG0g==
X-Received: from plbbb8.prod.google.com ([2002:a17:902:bc88:b0:2bc:c295:bdd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f706:b0:2bc:977b:846d
 with SMTP id d9443c01a7336-2c1ec66cf3bmr45250375ad.5.1780692936629; Fri, 05
 Jun 2026 13:55:36 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:55:35 -0700
In-Reply-To: <aiMrnk8a5fsWfze9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-32-seanjc@google.com>
 <e1c32d6ba008a443797d26dba21cb9ae59b39f93.camel@intel.com> <aiMrnk8a5fsWfze9@google.com>
Message-ID: <aiM3x2cMQo3O9O2s@google.com>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Sean Christopherson wrote:
> On Fri, Jun 05, 2026, Kai Huang wrote:
> > #define KVM_HPAGE_GFN_SHIFT(x) (((x) - 1) * 9)
> > #define KVM_HPAGE_SHIFT(x)     (PAGE_SHIFT + KVM_HPAGE_GFN_SHIFT(x))
> > #define KVM_HPAGE_SIZE(x)      (1UL << KVM_HPAGE_SHIFT(x))
> > #define KVM_HPAGE_MASK(x)      (~(KVM_HPAGE_SIZE(x) - 1))
> > #define KVM_PAGES_PER_HPAGE(x) (KVM_HPAGE_SIZE(x) / PAGE_SIZE)
> 
> Huh.  Oh, /facepalm.  I looked at these, but saw there were references in kvm_host.h
> and moved on.  But they're all "self" references.  So yeah, I agree moving these
> and INVALID_PAGE+VALID_PAGE makes sense.

Never mind, I was right the first time.  KVM_NR_PAGE_SIZES is used in several
locations, and I don't want to isolate that one.

#define KVM_MAX_HUGEPAGE_LEVEL	PG_LEVEL_1G
#define KVM_NR_PAGE_SIZES	(KVM_MAX_HUGEPAGE_LEVEL - PG_LEVEL_4K + 1)   <===
#define KVM_HPAGE_GFN_SHIFT(x)	(((x) - 1) * 9)
#define KVM_HPAGE_SHIFT(x)	(PAGE_SHIFT + KVM_HPAGE_GFN_SHIFT(x))
#define KVM_HPAGE_SIZE(x)	(1UL << KVM_HPAGE_SHIFT(x))
#define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))
#define KVM_PAGES_PER_HPAGE(x)	(KVM_HPAGE_SIZE(x) / PAGE_SIZE)
