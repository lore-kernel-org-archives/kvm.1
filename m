Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3437700D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925001; cv=none; b=fZyFQC+wL4k0gjUHiUUg/LVuXJhFE/9lZowrdXpbYOrLDO+i54wzy3wuDOi77CABeSCouRJEymJleO5Rpf/f+kv985R+rFj8MDAJNailNfgVTt1k5VGZTvGzbxR9WqAuWUEwpvU4s3LMORJUaEZOStJzq4uBfCUxxOUs4WZottw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925001; c=relaxed/simple;
	bh=LWCSSYbvZ4ZgsMDaus3LM8CVJNtwgefrMZfBUzegL0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnLioBYcOFjNckR4QnlXTDdJhpBzoPdfaQ3RTgIYZht99y5ZUNsbkGvxo44yvKr/gHOZMrVIxtjVO+lKg2/xYRH2R5VAQhJAroENztU1KdW9Ff1vw+UIxEqh4cRGPjDwuTJKLLWqQ7nXfOI4ZZ+FBD5rxI/bzrYdxmaj0ykH+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDvgwupW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDvgwupW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478e603285so1812024b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782924999; x=1783529799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPe/fCvCCe9amvNR+OBJKvY1CXaERhOlDRt+CktIxg=;
        b=aDvgwupW3zSNtfyDQOO0g3DXze7W7pREJCSx5J3UmyQt40KLpflEzKM4af3M0pL9us
         qpIBULhzRKQzs1OHitiN2yDwElTRYug//eQCBEA9Y73H2vFIdORoWGlyXBnl/Zy67KPs
         HbySHgMMfv3u+PMEp3bePG0zckneeXqNEMJcMrYDcZdvB9zOwmIDqhnR0HEo1Xj8Qu2H
         BZb+fTx0295UTzK/apxwMQTPpM0T2WcWiAAZxF1JgMdNCN2biP2EK3y5QndmhpoBL52v
         fuzMhuvQ4DaU4Z7BFarFPnqOb7R2TayqVmbjalhvw9tbujlmMwIfk3uLMyfszVfoJlHT
         CMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924999; x=1783529799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPe/fCvCCe9amvNR+OBJKvY1CXaERhOlDRt+CktIxg=;
        b=Cj6ZNUMxcSi1/SijLvCjl74Kz56V4o12CKpTsrTFfwK4F39vIYkIITxdGgnNH6KGtl
         WF1z3o41BsW1C/sm9wF4CNlUsIVS/NyWWYGb0zil4Wt9uv9DEVmWzXALwmfOsnwU7bHp
         VeCUF+5JsWT6RzC0Wn8FPPoPsSfbiArPuWji9cW3dVuxbTEbJIIxs/11TpeATNHsd++O
         SvJHMrZ3FIUTaexZsMdSGzHfrAF/e5dPWflcujHuaDhfKdqCpM9NffkJ7wVvvKvqJMHh
         M847wHo7BrX9py5yXs37dHlNewemaqmR0boIe90ef56GcZC+HZPceZYA8oM6wI9ociEt
         qSRw==
X-Forwarded-Encrypted: i=1; AFNElJ+ddqwSF7J2NwxbVA0ihB4j2tZW4uXqMXL+bIKofzDLrF1cf4Pt/LAx130uTwnof0WZkB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BU4FPRr6LmIJ0iakmve0Et/gT1bVM2hjCSVRqn3Sh9LJfbsk
	awZP5nCGY+W139urb27ATjfYeCFk81xZmK0TibRZDIH5F7LJSeadgnQGqZJ3gkYe9xSrj24591R
	taEahhQ==
X-Received: from pfll12.prod.google.com ([2002:a05:6a00:158c:b0:847:87ec:2a9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9283:b0:847:8f33:b159
 with SMTP id d2e1a72fcca58-847bf8231acmr2005298b3a.10.1782924999054; Wed, 01
 Jul 2026 09:56:39 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:56:38 -0700
In-Reply-To: <d9f98e2f-d2c6-447a-b3b1-17f07d1fac3f@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701144543.39582-1-pankaj.gupta@amd.com> <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <akVAnGuiuJttE5-6@google.com> <d9f98e2f-d2c6-447a-b3b1-17f07d1fac3f@kernel.org>
Message-ID: <akVGxp2fA6O3lk-G@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, David Hildenbrand (Arm) wrote:
> On 7/1/26 18:30, Sean Christopherson wrote:
> > On Wed, Jul 01, 2026, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 16:45, Pankaj Gupta wrote:
> >>> commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
> >>> added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
> >>> migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
> >>> virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
> >>> FOLL_WRITE | FOLL_LONGTERM since:
> >>>
> >>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
> >>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
> >>>
> >>> Drop FOLL_LONGTERM when registering encrypted memory regions and restore
> >>> the previous behavior.
> >>
> >> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?
> > 
> > Ya.
> > 
> >> If it is a longterm pin, it must use FOLL_LONGTERM. :/
> > 
> > Heh, well, KVM showed that that's not entirely true for many years :-)
> 
> What exactly do you mean? KVM MMUs sync through memory notifiers and doesn't
> need this.
> 
> It's only our "interesting" CoCo code :)

Yeah, I'm just being cheeky and saying that it's obviously possible to do what
is effectively a long-term pint without specifying FOLL_LONGTERM, i.e. saying
it "must" use FOLL_LONGTERM isn't super duper strictly true.
