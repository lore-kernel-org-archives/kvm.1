Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601E2F12DA
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181789; cv=none; b=OGX3tZV9FqRiT6vGUELqFHJ4gS/LFtsM39K4AGNnWA1L6MuFdirN/YvAs97Ppd4fzAvQC+Tr2QWXHUCLX3yY0fgcK5RaFerVu9SRAw0APmePQGMKM/LZHQW3mkkVaWk5G94ubh6A3wPTC2DhTHAC5P2q1l9swgEbhp0a/cYKUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181789; c=relaxed/simple;
	bh=6r2wSiS1OrKZjLIZIsNzlzfyS+o5DTffK/BlyxWwF30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMWAsjr0wdb7LSwqxiGDZmz0kuXgs/tyaUfWtB2mJ5Xk7gAYPUpxcdDXQHkn0tZxKVos2B/ol9Rq5QUYtEJ0Z5JoR2hyAOybIyIxElMTk+sLyq7LbUyLVbAFVqVrwvCFSKfh86eH5v5S8h7/cGmUCs3P+1Yc80FnhTw/kHeiMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTeX9vaS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTeX9vaS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so5956357a91.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781181787; x=1781786587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqAjTQM6QI1dGE0+M3wPWibIsSJpIcu2J8JnWgkuZ3E=;
        b=nTeX9vaSDruEPkojsxymk4vbs+TgCYPzjb05YKJ+w8Ej3JwBPDwcjuVZhYM1B0X1nH
         SpTpCNwMXRlf1Bh/sJmLgPIbu5ymGI8geGDL+ybWeg7TPRC2RsUo00fbvZOlg/XRE8P5
         7QoyRhVkZSvxa+qUYCKWUKjRDH91MV5jNiMjCBnTOt9eRxE4FfnKBzzf8cEYj/RPLjAe
         ag09IuyEyoLi8t0pVZSXJbQl/uReMufLbL+glNFkm2mMiEjj1hZMlwPMwL+55ZswrGD/
         plwRlSu4+K89psEzUkP3zVa8O/63SRYHhb0+aezQcdaaLL2OXjjHGRa+ElfH6U7zGoIY
         c6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181787; x=1781786587;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NqAjTQM6QI1dGE0+M3wPWibIsSJpIcu2J8JnWgkuZ3E=;
        b=dvuYYBS4b7UHCVgSLsPPNZVFpATcTM+AMmfShJqISwsFt47K1prJYKDl2B2rYhGWNo
         bEPiuYFWQllc7x2ST0OBI0e16B5CKmi19gCnA8Dni4/IeqJJ4qUPhNSjwzud/6lq01Jz
         yMY0XnVpCMMfy4oNkim8wJM0Lx+TFhD/XBvAseRTLGOK0I51yJFpNmDzpk4zEghXRGJn
         jiBudE54furek18FzXP7B5PpQY4heSBufuxs/qpuLPTEe5JxG7MPFu4kpKzXY+7a4iUC
         oGRCq/q9wQSPRR/Vlp7BqP0U7z4hYIU09wtPNAIppxbln4c/e33af+QEDEUNcEFhx/vd
         p12A==
X-Forwarded-Encrypted: i=1; AFNElJ/bI/4ueBJDy9qfOByBOsza9ZC2HMn3YOtpFFQDTI4YdOpAuBu1GvQJmcGCOXBWLBeYWd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQF2Rctbjs03OI6D988BVUAdlPaZWKIvuttlVy6bVVTIBFtBXi
	ySylDOeZuDagYKR9dOGBjqrCgcSb0EyJBzlv54tgYf+zAhYCA9CraVg6rYMNULnd4Q7seC7qS1T
	uBh5uag==
X-Received: from pgmk26.prod.google.com ([2002:a63:5a5a:0:b0:c82:a5b0:d9f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c7:b0:368:b4a5:c4dd
 with SMTP id 98e67ed59e1d1-3779bade7bfmr3145891a91.2.1781181787050; Thu, 11
 Jun 2026 05:43:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 05:43:05 -0700
In-Reply-To: <20260611123528.572255-5-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-5-joro@8bytes.org>
Message-ID: <aiqtWVMqTK6vDoZ8@google.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> Support setting a VMSA in guest physical memory during the SEV-SNP
> launch process. Only one VMSA can be provided which will then be used
> for the BSP. All of the APs will not have a VMSA allocated or assigned
> when this feature is used.
>
> This ensures stable launch measurements on SEV-SNP which are
> independent of the number of VCPUs the VM is launched with.

This needs a *much* longer explanation and more justification for exactly w=
hy
this needs to be handled in KVM.  I understand most of the words and acrony=
ms,
but that's about where my understanding stops.
