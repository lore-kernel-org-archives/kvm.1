Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348D3DBD70
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269150; cv=none; b=f+W4G0NBTirC8kPVtlP29JGtONhx9aKlKbOmD5S97EwxYsjbNx3LGtH5DPmsHTd02ymHUqm0PxemodjaSkOxyNMhUn/FBbFpS+jybg4IR7G/nDWphP2pWKaeEn6TGLWNeyZRt1TtA8/FvrxthsrKT4WFzwxhYBEB+7YZv4WvkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269150; c=relaxed/simple;
	bh=qwrVZaJ8w0DVBNh7+BKEJThCgGURc6TMBDXjogqsrfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NlyAb6nWyT7+PLXlveQAmhaJVPiTjjSvH1DOQgbb8f6NufOT+vVx2nQDP59xCq5CuU60TFxyivd0hr3lYTb+C1t8c2ob8VZe72AH1wp3fTcG3WDjDLs2wsFVCXNZ6W3VKBYi0Q1Oww/cKrIt41eFjV10K0V0pboFqNywb6L+230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2PBR1Dz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2PBR1Dz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so898163b3a.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776269148; x=1776873948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QuFTNdG7aougrYuvI/HIgSB8ZVaWwT1LWPyv1PRH9w=;
        b=m2PBR1DzeSOlBoeV9ZhPjjWn8ly8ILgL2dvMjMRq5oO7zU6/RdSyInb7u4UnaADp13
         aGHVyIx+URT6fFvy25FDqAbRYkuMMcfjwZPIKmPz8MhYzciGUD1/IClzv8PsyNJEy8XE
         fPzpNaUP032QohYvdS+bPI6bDbc6c8cwYNggvK3kIGTfLLpSqDwTxXr8pPoGcMW4C80D
         CXbsq/G3Z5LKIo46KyxpvWf79ox4ZpbPOpo1l6JvZG6zINXY790jfrvUbtl/LKDDmyyr
         sqD3mhQbM34GbhJsf7AErkfks46JdSqSYEfbTzDThkEPIBV+KOnC3nt3ypV7AOlPAUMc
         UlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269148; x=1776873948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QuFTNdG7aougrYuvI/HIgSB8ZVaWwT1LWPyv1PRH9w=;
        b=ZOSrcIEwq520b+7JHQukIpc5EQyUspJPa/tbM5Z6gk6K3ir/tKpUNS+6dlCQ2g+2NY
         G31/keS/khIkQYG0jeu0ve+lKeGZFwtD3fwVt+NZXpSEsHGzbM+QqgqIInWq1YTOah2E
         rOEUSuE/TzUDrcI6jBoMM25cCZJ3tZY37jn5xAK2vTS5F/DS6vKfEvWHNmLJ+qfopZWU
         nDek/VR9aRkzipveKys8BOWNDUMMQXfGBt0lMVvsvbiBNg1ndtGErAPsI2Jxpd+xJjHH
         8D0u5onnyo3zz1OHB/X0RvgdQpsRAz9X5k1cOwNr+DEbRz46pja17HO8olsBhM9Xpxnz
         UXvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F0ZIYI32mMXOyQAHtjIPL1LXX0mStysgyMFn8DSq2AhKuUjWWIsvebMB+CRGRtzKzE3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJePtABgQOzDDwDuvRxUWhxE5BKL7n7jcfUwXWBxPwZSzzNS1h
	a0LEXRzP4QKhgV/rvdXOXlieacAJVJjCVT4PkyVobzXpo0niJ98eigO+wJtMwN7MM1Gr5+RdtC/
	BL0b5Jw==
X-Received: from pfbdi7.prod.google.com ([2002:a05:6a00:4807:b0:82c:9c4b:469f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bcd:b0:82c:24d5:63e6
 with SMTP id d2e1a72fcca58-82f0c169049mr21219442b3a.15.1776269147434; Wed, 15
 Apr 2026 09:05:47 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:05:45 -0700
In-Reply-To: <e11d37d0-a143-44e7-b76d-bf2d5b386d16@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com> <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com> <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
 <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com> <ad5JeT7UuiQI9Tqo@google.com>
 <c40b5057-4df5-44ba-93c9-5c46696de765@intel.com> <e11d37d0-a143-44e7-b76d-bf2d5b386d16@intel.com>
Message-ID: <ad-3WbefGOAGM4sa@google.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, Chang Seok Bae <chang.seok.bae@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 15, 2026, Xiaoyao Li wrote:
> On 4/15/2026 7:29 PM, Xiaoyao Li wrote:
> > > Note that updating only the "available" masks is wrong, as TDX needs
> > > to marshall written registers back to their correct location.
> > 
> > In what case it needs to marshall written registers back? Can you
> > elaborate?
> 
> Sorry that I asked a silly question. I mistakenly thought TDVMCALL for
> instructions (like, CPUID, RDMSR, WRMSR) use the same output register as the
> x86 instructions. After checking the TDX GHCI, obviously I'm wrong.
> 
> But I don't understand what's is wrong regarding "updating only the
> "available" masks". Or what is missing for "marshall written registers back
> to their correct location"?

KVM would need to also update the "dirty" mask, so that TDX knows it (a) needs
to propagate state back to the GHCI, and (b) that all registers it expects to be
dirty are indeed marked dirty.
