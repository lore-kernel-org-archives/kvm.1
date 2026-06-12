Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B6219FC
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223002; cv=none; b=hV+VdSQrA7m3DXM7eE6ZEm/N+dYfhBmPMUR1Lr9o55XUY3fQyFcRNg/XP1wUv2kF42Ek4NwjBIKHzAB6oU1lenBsg6tOyFXrbjFIQd5+M9eDaTu+ubBj/wbWcxEG+efY81oFkKcdXzIViOzykHRtu56ZQo6Ah/VKt1K8097HR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223002; c=relaxed/simple;
	bh=7hjevxTS/pE67scrUmPnMNrAdATdqbszmG8o5umjaYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umH2spTgqMu3AI33/dW9XfOU6+MdXgP7s2bmZVh872+kiEzCNqQyX3/20eVssAE4+bympSzgeILewVVVFy6ZTeBsv02sutfho2gl9Zy4vh9tYL8zRg+hHDvdZEPRw18/n3eXN0+JbhNcxno5Myvfp8x8kjpJwSn9wuAsa7WH+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uL5T/qgK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uL5T/qgK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso8829165ad.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223001; x=1781827801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/eWL2vseWpXMlWKa6sGV7Bo7yoiqWdiiVjHrV5kk1ZU=;
        b=uL5T/qgKCRot8Dt6ZXGteBUHVeI2rfFZmqXqdNFgXX5XUSUVOCRmsbLW4g+KyDKVuS
         gikeBJ2s4o8nc9+9Itmt6Vlc378fJuipmTxqYLodgKG0l7inTGXIW0s9KI0Zuixtoq6L
         RSYFQ1aTH+QynzyTd/axr5Hf7fYs/Rz7YOOmmOGl7tFI9ZUZDK1ekfLNczmEXH99XlTG
         ofBf3VadUUJPw1H1CmYWHuT9xDWib1nMCEtgrv1yx2IUMpLkbKE0PXz2VCyXFATyeSuF
         pESBIQIas/K0sEGd6znEo9Wkq2jLraj049pqygVHL6IaJrsubcEVj2JTfulxkhXE3N+w
         z+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223001; x=1781827801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eWL2vseWpXMlWKa6sGV7Bo7yoiqWdiiVjHrV5kk1ZU=;
        b=jut1j369mZ5KIlMGiSxx8kIe1FZW7t69lG1vM1W/2yAjvCmor5e4kwC2H0WsTz0djR
         YAafu5cg8usTkkv5R+oVpw7MqO3RAs38XlGDxV0X1W/Oogs22UsKw9O3H2NGa+Uu76ip
         J0PkZ7LDKCTMhK3EkxRjAOdq4V9jG+Vzosg+/93rS+sMG33gHx1JrBnZ41JCI84Qn91D
         6IVxIuuvJXX8n70w0/i38zqtkp/EZVO53b8HHljLqxpRa6HHxv6mx77pSYUxv6E/XJug
         sB5J8O0KlZNPmT/dAnd7BFCZ4hPiHCHWtLl2ajugt1FW4ciiH0yMGvgEa/lcrWr5FoJP
         qUsw==
X-Forwarded-Encrypted: i=1; AFNElJ8do8XLc33JoqY8b22MjHEj3VJOrgNs6IPuaHc3+SEKpyTQeTqEbl/ofr+tPf21Ltdm/18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywwex/uZmwhGZPh+IUCjNsZbnKmZf/r9jgmaWPeS11Omh8uSKm
	XUsYKdHYN7NLFDZMKU5VQ7dk9p3DN8+wsmmZT9We4YPsLz4YvAd2J0WbKlU5WfoeZiR2+F3fzhJ
	pisjBCw==
X-Received: from pltg6.prod.google.com ([2002:a17:902:6b46:b0:2c2:da80:b99])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0e:b0:2c3:5683:9acb
 with SMTP id d9443c01a7336-2c412e2203emr6539415ad.32.1781223000763; Thu, 11
 Jun 2026 17:10:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:10:00 -0700
In-Reply-To: <sbub77galgn2zcecmeiznzi7nvgykby5lyqbebimfpd3wmsxgc@gxfth3taum3p>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aimMWzAf5b3luM0b@v4bel> <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel> <aiqueNUndQsbMNud@google.com> <airAthcKDZeDfzXS@v4bel>
 <airS1G23atiuWdTl@google.com> <sbub77galgn2zcecmeiznzi7nvgykby5lyqbebimfpd3wmsxgc@gxfth3taum3p>
Message-ID: <aitOWNQk8KfUdp5x@google.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, Michael Roth wrote:
> On Thu, Jun 11, 2026 at 08:23:00AM -0700, Sean Christopherson wrote:
> > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > and if that gfn is then hole-punched, a page that is still assigned to the
> > > guest is returned to the host in sev_gmem_invalidate(), which looked like it
> > > could lead to a host RMP PF, so I sent the patch.
> > 
> > Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
> > problem, which is that it's possible to free a page that's being used as a VMSA.
> > 
> > We can't simply pin the page, because IIUC ->free_folio() is called when the page
> > is removed from the filemap, not when the folio/page is free back to the allocator.
> 
> If free_folio() triggers, it would call into the
> kvm_gmem_invalidate()/rmp_make_shared() path and clear VMSA bit, which I
> think would cause a subsequent vcpu_run() to error cleanly. So that part
> maybe isn't the issue, so much as the stale VMSA reference we have once
> the hole-punched finished at folio actually gets freed to allocator..

What if the vCPU that's associated with the VMSA is actively running?  I assume
trying to reclaim a VMSA page will fail with FAIL_INUSE or FAIL_PERMISSION;
that's the scenario I'm worried about.

> But KVM would never be accessing it directly while it's allocated for a
> vCPU (it would be garbage on the host-side anyway), and I think the CPU
> should only be able to write to it as part of VMRUN/exit, but those
> should immediately fail since it's not a VMSA page any more at that
> point.
> 
> It's sort of a precarious state, but I think we might hold up okay
> there.. so I'm not sure we actually need the changes below, unless I'm
> missing something.
> 
> ..but on the VM cleanup side, we'd end up doing a double-free in that
> case, so we would need still need the elevated reference to handle that.

I don't think so?  KVM doesn't free vmcb->control.vmsa_pa when tearing down the
vCPU, KVM only explicitly frees svm->sev_es.vmsa.
