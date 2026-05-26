Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204E36E46C
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824248; cv=none; b=k2hha1tn0PwW3Pl/KtnEt4mUp8nvwlHINogF8P+y4LxtbkagzvF9eyM1/wmCz82D+2xqHw1FBZGhm1Bl6GpK8FaFpfmqKQCHNmJaNBMX4znT5NpBNA1TrSKYrR6BH9T7G8hAztdILg/NaV7jOQBNKtYAhV2CTXTQgH8YOA02fJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824248; c=relaxed/simple;
	bh=iUFkuxnHj+cpqwwryHKC3vge47qQtUDj15ZV0LW+iBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ip1MBLMJj44zLeBcbfCq/E7vwhqV6VX6rL1rCYs4PuaY8oPFc8FkhKsUiv/6aRqoaMTI4pd8PjmH8D5Ei77HglXDGBH7A+ruK56snXUQb8ck1UdeASahA/0Mvr5vw0d9Sjh4OLWaSwkJK1faJCdeVJUvmXktEn1DJ/quROXKRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1Wt5FPl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1Wt5FPl"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so10874238b3a.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779824247; x=1780429047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2LUH2rnlVmx0tYjHhRhFb1FVJJlzW2bbDoMOmlKuPc=;
        b=J1Wt5FPlej1ZCAKNXAp1bQrEs6Vt+md2IXMLqHzeKt1PlroQLnJ+2Y6ITRT3gVrkWb
         oyQvA/3TAG3CNXqMIR6tXAe+lmwvakGhqV7A6sqN865EbdbTPEZqMxRlZk2kGQcb8Oz3
         +qhO3X92JZ/BiXAT7G7V/3b/pNxqQlMAz/IhCnYKmKwseVTCs3I1AZAsXLEjwGfr9mlm
         gKHDIh5hjvPWeU/4W2xg7+UJaq1+lfKm6ezOnDXoKs0ixwcSRc+zqbyMFxu/YM1gVXcV
         pgJbnpN5sZrU/kt8oumLvR7ocKtPQVWGBtCohYtDo8G3stEQ8yQf/ExLAWnns31S503D
         RxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824247; x=1780429047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2LUH2rnlVmx0tYjHhRhFb1FVJJlzW2bbDoMOmlKuPc=;
        b=G2EXkbvXW32YjFznh7FrhbXIhWcB5T3oKBh4cH15PZ+QZI9TGeQW5trfiM0ojuthaN
         rxEAYQ4pP0rG1c4r5peN9u85ziqhfKf9Ej4XvtIaPXUIjgMGnNffM6AGct3ifvPAU3ps
         Phfz+9mpNvMT2hJ9xNXj1+YHjK0zsED+PfNGbNu9IYeiGgHzya77Byhw91xWplB3EwUa
         OxmiyrwD4A54kK30tiMISDtbwxM9qCoqkc7nkUHe1FfrDvsbHkaaRJVjw4dfRKNBY8SK
         D2SpMedH6YC6D4NCwzS2yeSgYkyRbJefWiDhN+7jpSyvI008drvalH+yqSwQ3wQnpz1+
         psSA==
X-Forwarded-Encrypted: i=1; AFNElJ85//LOdiK8P4MfchbkFsMq2i9AKrQWPoSzHcqzCtWurtGWOIcnwZYYui6tPMG/gmQoDW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmSSE0BXLf4ElgW/lns+Q2BJ+c22cfLOqvh2gX3fxPJ/Pvi4z
	QY82RY6FOnE3epOrc2R2yvbtML7hBGbxZyuB9qAf88oH3gDAYx6GjOG/bTMe6n8T/WeD9ent4rr
	qJycPsg==
X-Received: from pfbgt8.prod.google.com ([2002:a05:6a00:4e08:b0:837:aa2e:b191])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c3:b0:835:3de0:fad5
 with SMTP id d2e1a72fcca58-841611f213bmr14436204b3a.25.1779824246309; Tue, 26
 May 2026 12:37:26 -0700 (PDT)
Date: Tue, 26 May 2026 12:37:25 -0700
In-Reply-To: <20260430014852.24183-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
Message-ID: <ahX2dcHAQgwuiJBC@google.com>
Subject: Re: [PATCH v2 0/4] struct page to PFN conversion for TDX guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, kas@kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Yan Zhao wrote:
> Hi
> 
> This is v2 of the struct page to PFN conversion series, which converts TDX
> guest private memory mapping/unmapping APIs from taking struct page to
> taking PFN as input.
> 
> v2 is based on v7.1.0-rc1 + Sean's 4 cleanup patches (see details in
> section "Base" below). The purpose is to get Dave's Ack, so Sean can take
> it from the KVM x86 tree. The full stack of v2 is available at [14].

Dave, any concerns?

I'd like to get these into the KVM x86 tree sooner than later, so that we at
least have a fighting chance of landing the S-EPT cleanup (prep work for D-PAMT)
in 7.2.
