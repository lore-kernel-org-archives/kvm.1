Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5B36A033
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258183; cv=none; b=Z5vJUloModKMDXHETMCJMuBQ7GAoZrSLnVDuhl6rSTMaoVu25jUv+5eVddvbyX7JBoubSdAFw6kuSYUmMhAwZIOZ1kIp4UUVt1pIEPCWIFDpf/BmNMKZuQuazc9T2J6n+2QP7VQGeUC+CW1326/t5FX7mQYwYPHDPQy2WODFqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258183; c=relaxed/simple;
	bh=syIducttRk2fG0cX99ZSMirDQXV7FvAAoRbNBGCCMDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hi3+7MPtNmRS1Vk+cV09fBnzt5vJG+1HaiKxdyT1XFBvbEu1xAjtmyX+kNaqc9ib2tljoiC4Iw9zxvqMYFSKqoQKaD6nNJbGK8EvHgjo/gTlPl10g3je1r2q1H0tV8bYduMaNlCdw9UTU4cL4jmGaji4ITG0Bmnhs6R4BBJrq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCnhQrJJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCnhQrJJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842b0dd8107so277985b3a.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782258182; x=1782862982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgMvDUbIKofTb6b2HucDXASvWE7WMmjIOLWX301AQA=;
        b=pCnhQrJJNenPqL4v3qZlNftjUOA0Rao2phGI9O0TMfjsTCryUujUhuCpYvydu7SMzD
         ToCSSaR1bnXvEfdT+bzAS88T53NT+KIKgCGewJ8lA1nWUYWowfTpN1zMgGgK6NGmh5/+
         YOC9yQVQ7y0vm9PsQw6yn/NRpxnLO4TChlE8sYTBaGXWRfb+X61DgVHtPmK1RNMzrNHw
         ZN2tD07zqj/eOdpRc7bnUSZVDQNBWazcyxS+juXE2U5jWVAl9JPqzhMqIeSo6owKc3fU
         XRkwPMYOArzGFxb4psXygvWqj8nW8xj9/5YYPPbNP2xU1sEsj+FbR4U6VKLTQFlpeI2R
         z0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258182; x=1782862982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgMvDUbIKofTb6b2HucDXASvWE7WMmjIOLWX301AQA=;
        b=RLJpqz/Nyw7GN4UKkipdPKObkXM96D2dmSZ+3k/EnvjQ5wHBxxnYOGombxrouMK70U
         p6bK1hh/cCq9HHx3SE3BAL1sZSo7laIxX2M6JK4IqmmB/OeOgg8eXRR82qa3e07kFxQp
         Xsv6sMaH++uSkgypfUcUzyEv7XcANVCp+7Zjvx5qOsgQUKd1FFOWAJM2xgJohYZcLMmh
         ghN5Qfl5HcFanoQrXiwQskbUhFSUTuEBIi0HjXxgtoI2XuxI96jf8+CsZd93To/odsm6
         wzChNp5ow0Y790DSmHUin1ByUNIgLzdY6V+oXHYQ1qYLNziEyOTD/qwYAaJE9CkD8JLe
         x4dQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hJHneEV+quU2CP2j9km+P1l/N95N5HNOa8qWH+IRnSdjwA4JWiko/Jv24zuWPegcxjZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJS2j7P0QG6hmqBxNlk9V4C6FQbQrKyWDSo3xyN5x7ctQAIXWV
	3Ji5LCQn89u3n5YRx3n44vQSC4u/rQ35wkBEj1Kx6Azk73H6mRf/WUDP5ugTEODkwJVypkVLwA3
	pLFxa3Q==
X-Received: from pfbfh27.prod.google.com ([2002:a05:6a00:391b:b0:845:3450:ea3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a85:b0:845:44ec:a648
 with SMTP id d2e1a72fcca58-845a2c31597mr1241566b3a.21.1782258181529; Tue, 23
 Jun 2026 16:43:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:43:00 -0700
In-Reply-To: <89c4ac3a-1462-4798-a700-2e1e9407a4f8@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com> <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com> <ajsCdRhFEw2pcIXx@google.com>
 <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com> <ajsO6SLATtDsXYsZ@google.com>
 <89c4ac3a-1462-4798-a700-2e1e9407a4f8@fortanix.com>
Message-ID: <ajsaBBrsIbM7FISl@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA
 at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Jethro Beekman <jethro@fortanix.com>
Cc: Jon Lange <jlange@microsoft.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"thomas.lendacky" <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Jethro Beekman wrote:
> On 2026-06-24 00:55, Sean Christopherson wrote:
> > On Wed, Jun 24, 2026, Jethro Beekman wrote:
> >> On 2026-06-24 00:02, Sean Christopherson wrote:
> >>>> A UAPI that allows creation of all architecturally-valid enclaves for
> >>>> purposes of measurement portability was stated as an explicit non-goal. As
> >>>> this is the only stated purpose of this patch set, it should also not be
> >>>> accepted.
> >>>
> >>> No, the stated goals (thanks to the follow-up from Jon) are to (a) support VMSA
> >>> GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and 
> >>
> >> As Jon points out, the VMSA GPA is not architecturally relevant, so any
> >> enclave can be changed to support a BSP VMSA at 0xFFFFFFFFF000. The only
> >> reason to "support VMSA GPAs other than KVM's hardcoded, arbitrary
> >> 0xFFFFFFFFF000" is measurement portability.
> > 
> > Well, that and hardcoding 0xFFFFFFFFF000 is bizarre and confusing, IMO.
> > 
> >>> (b) to play nice with multi-VMPL scenarios in the future.
> >>
> >> It's not clear to me what multi-VMPL scenario Jon is describing that requires
> >> custom VMSA content/address at launch time other than measurement
> >> portability. It's currently completely possible for VMPL0 code to set the
> >> VMPL of a VMSA or create a new VMSA with VMPL>0 at any GPA of their choosing.
> > 
> > Sorry, I phrased that poorly.  It's not about directly playing nice with multi-VMPL
> > scenarios, it's that if/when multi-VMPL support comes along, the BSP's VMSA for
> > VMPL0 will likely be the only VMSA that is NOT in guest memory.  And so supporting
> > an in-guest VMSA for BSP VMPL0 would provide consistency on top of cross-hypervisor
> > compatilibity, and I place a lot of value on consistency.
> 
> If the goal is to get rid of the arbitrary 0xFFFFFFFFF000 GPA/put the VMSA in
> guest memory, then we just need a vcpu ioctl that lets you set the GPA.

That's more or less what I suggested[*], hopefully by piggybacking the AP_CREATE
logic inasmuch as possible.  Or were you thinking something even simpler?

[*] https://lore.kernel.org/all/ajr1r-PAiXMnZ7x1@google.com
