Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EF330D2F
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179577; cv=none; b=jupIHozRedlkBgpEDWlWrWi4lvf/XL0FEYm7W60w6GMlWTcf9gKotpvuBOoPXX4AZugXYEhs/wfqjjYGWvrjVfutH4SzBRsEkp9HhptlWyxdUB9cg4v3FirjHdOPXZtJLlwP9VSBq7/5U07XaT8avs2HbGfpR7jMrPWSsY/5Sag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179577; c=relaxed/simple;
	bh=tWU0AQQMpeAf2oQa8xqfr6R4fb+4+/rnKSZ4VI6XYJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AlmXdhTscZfOZRon3cPEqnpBCSSTzoi+/jkcYr5/uvbrhX7+RqXHhYQn5Gg7BNS7fbecgDqlkgPdIRc1yE7vgzHwVs80yT3MbMdbaHFeddaclYiPa8QJZroR8X62a+ARNa/DGxhl6xJh5FcwKfgUtw4q2+zD/wTz713ZqDGCKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3KrvFfq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3KrvFfq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b99f1c85cdso9167295ad.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778179575; x=1778784375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BMFp9ZNQd97vO473dmPCsB2qO20odiBdL6bA91p25I=;
        b=Q3KrvFfqZx9SFhDdJXqTqapUhYZV3QrFM8vITf5Gr2nu/6LuHaCdg5xB2gpA1CPc2f
         rqBKWWFiuJFnmrEmd8HvAQrjRQKnnnYNYsKTWKTbDpu++/tHSs/TCqntWmQyfeJRcAcO
         BN3gOELg724SFGGf4fdwnLnXL6xQ8O2y4eYWp59AthjDfSMKr/OeoJAf38rykQPzdJ5E
         Rl4qEzzlmD8rT/jQS4ASkOJZZy2ipd0lxbb0rtiyUrVU/fkkw0MJilXUFQfmlcTG1DgH
         yXO+RPLS6NqgFH7oJkRPJEdOHcyhB/Y009B0bmmkRD3Vv/hMrCkhJw9dIk5yN+9SwjiC
         kepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179575; x=1778784375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BMFp9ZNQd97vO473dmPCsB2qO20odiBdL6bA91p25I=;
        b=dvjczqXeiaMLtAUXhBz3+TEOuSbqqxORhBaK+ePr5W8C4NKq/ahYC/znMsloogg7t1
         nKE+3zrxuc9YAmUhLcXP2KRMiCYoQ57+szjxdK583AXSgVpxPrfJ1607I6U/umLTsR6F
         aEVdY54bwh3Ga5yEv0Yu5EpwYnaBSaV9sbM3s/pwowKam70n/oCx1GuPty0Q4pYm4UYW
         5jIxEXlPCiXg6Pafs1ZnOsKS1X1wT4r5Cnhbta7ArAMrNDofm/J5ybrjGOpHq6gHvEfe
         PYwEEVM/D9kLK1eLfqq1dKmMTnlBeZ5PetpDdE1xaXtPj2zc0QgOITdn7jDAMfYLHT7u
         dZuw==
X-Forwarded-Encrypted: i=1; AFNElJ9GbdUkzR9balV49lSwMjGe4wme3yng/zbzlcjBkvcmT518c0IuJKoAy3xWGkWGnQtoXLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhdyc6vAtESzPLsw1ssUDTL7Ggg71eB+ddzKWQHPFRDdDi0KGW
	9T5/0nEsZfFSLwfwaB4w4kvHA78AEa7z5DDqH+FhSxzM+Tdsy8QMyudX6iNAKqF7jUMkff8bX6Q
	vy0sqow==
X-Received: from plsb4.prod.google.com ([2002:a17:902:b604:b0:2b4:62f1:955b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2684:b0:2b4:5c20:ec7
 with SMTP id d9443c01a7336-2ba7a379c9fmr62432345ad.41.1778179574650; Thu, 07
 May 2026 11:46:14 -0700 (PDT)
Date: Thu, 7 May 2026 11:46:14 -0700
In-Reply-To: <afxIc/0qNvwcr4VQ@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014929.24210-1-yan.y.zhao@intel.com>
 <28c8d380-d2e5-4f70-96b0-00225e0ea86d@intel.com> <afxIc/0qNvwcr4VQ@yzhao56-desk.sh.intel.com>
Message-ID: <afzd9vW5fwj09wdX@google.com>
Subject: Re: [PATCH v2 1/4] x86/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com, 
	sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Yan Zhao wrote:
> On Thu, May 07, 2026 at 03:49:09PM +0800, Xiaoyao Li wrote:
> > On 4/30/2026 9:49 AM, Yan Zhao wrote:
> > There is on-going attempt to remove the direct map for guest_memfd. The good
> > news is TDX is excluded. [1]
> We can see if any code refinement is necessary if TDX is included in the future.

Yeah, I wouldn't worry too much about that effort.  The onus will firmly be on
that series to do the right thing for TDX (and any other unique code).
