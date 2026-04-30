Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80A44CAD7
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576166; cv=none; b=NaonpBVREvjKXYi9yo1rKQFfCZp0S9bRq+Du0ZfWhGK52YiMoj3l3ikxQBnbEs9heq4ypiR6jEc89SS92TfAquQmdi7KQUM/kEsiKDLmJENRdGgEIF+6eT/8g81gbifA64psqUXdTWLc6i7L58Qm3WXfpbQTfdyjxvzu0IiJihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576166; c=relaxed/simple;
	bh=5MaHcQbBlA+52el66f3P/SAAgjU2aQh+p7UF/1ZxF88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nFz9Lh5/N1l3zdPFPnC1dYmqUo46aO9Qdn7SvQFRI4ZMyKQlShptmK8S/YkMYMMsXJjHG0D9lvPqtUbgdLigb/9rQ9Zn7mT/rWPqGIRNFp849VLIC5cVUOtabeOEJFWsFETiTzLd1YSp/H5LtXkwi57M2bD6xrR7L09qXbe0R6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khNGb/9B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khNGb/9B"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e6ee9444so12112505ad.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576165; x=1778180965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KS3c1tmbsmpaYV3NWPhKpcEjND2/He2DmZ1zxAfi5pg=;
        b=khNGb/9BrIYqsUxrRWRp/lOxZRVA3ZdQLOBOma1Rx9pzRiAgPfJpKf30Uex9VkCHCS
         dre99tGFMuPbT9M5XzlPx4ZVukrfnwtYl49PhRZPocO0FIbSJR2Al2771M9bSz4YH7JP
         OP3n13ePF40Cr61wndMOI7Kx/QLZJ+FfGtaHebciK5yvkcBnOBrtTlUxBq13vxy7HoTa
         veUxCCkJMiyTJOUI4lWfeRo3Utu+Ai5aCMh1SUl/QnGjE93e2UWUNfXCYmiDDMYMs+dr
         Vz1wt7+x4uLtjHbQeoLwgO8Oy8oZwVB30agV0MTB8vzIwkI5MtkJVcqt6Hwfc6zky1OX
         tl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576165; x=1778180965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS3c1tmbsmpaYV3NWPhKpcEjND2/He2DmZ1zxAfi5pg=;
        b=spWpXE8C1cqaErAe57HO5/x/vF6EpjquVid3cUuavWoPiKFgaHvZPg1k0Cm9s5spvp
         +vdkxe1eJ+Sx4pMEjsgEa8Tzkb1psDKb2QnCwKKbY5hvx3PWDIr4x/nrzQ6yvosO1jzE
         RBC+so/gg+++pg5DUAhAyxsOrdIQSUC1pN+qSaDPxSwCN+dnVja/EZelLy9+m6ZSXRkv
         TURXpKXajzcfrPM2V9QcxrCbyytyVqkNyMqzG2p/vFGtpippn100VBcw3CfsnR6Lkfz+
         tanxrWoFWOL8zjfppM4guav/H5aFX1PDot8zsrnJJAEq2ZpxFXv+l/JG/kAM6EjnEcil
         1fXA==
X-Forwarded-Encrypted: i=1; AFNElJ9loEw0nmepXh8CzOhXVE5vo+Mqpjdj2plm7lmZAIYwarh+Aay+mGdeG7P1VzTR6gMdfY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwwfWfoS7k11Vd0IdOkahCRMHCBMkuP5Iy2VjKNEwMICwcLzm
	w5MSVYdsPeSV5os3+e9PrtjQrTT7O6qMo+pZan54Gzx5Lheu9IH6LBRkQy/RA/6ysCERuYFDjFH
	EQmcrYw==
X-Received: from plhw16.prod.google.com ([2002:a17:903:2f50:b0:2b0:6314:419b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c65:b0:2b0:4fb3:c771
 with SMTP id d9443c01a7336-2b9a42ab0b9mr31396755ad.6.1777576164700; Thu, 30
 Apr 2026 12:09:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:09:23 -0700
In-Reply-To: <20260430150747.76749-25-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-25-pbonzini@redhat.com>
Message-ID: <afOo4xvnIJn_FvSx@google.com>
Subject: Re: [PATCH 24/28] KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on
> supervisor accesses to an U=1 page.

What, don't you want to more closely follow real hardware?  :-D
