Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AF4A3411
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022711; cv=none; b=itgGgOR0c8DAOWBW9vNSfVwSyOcTElMXLaFqLgrenskOtudzrIl6rw+keHnYY424nPM5r24S/RyThZVct2OZe0n+ccujCIO59SmT75sh2fbYAfs+9b6+k42Hb7CmtVXqKdVnpG+NPxSJqN6K4NKVaM2uHdRsJLfHZa0aRbxWM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022711; c=relaxed/simple;
	bh=O27sB/RmwD8YNtwCKvnPaA0JgOPXO4OvaUEYOLLtvOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKlLM1pqKZ8PE4Dspx6cs2+pCvD2d1vgMwb+QbENZi7Fa9/rT8KjPBBmAWSnsO6dzpXTcS2vQSwG2MFgSs6BosHY3UFJKiRntBF/SGDVPQTKtAQOxo90Q7zNrtLZBAUBek6j13fldEkVMyZXtaR1W2fAAseiE9zey46BgvhU7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLL5ixZt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLL5ixZt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf30576aa3so40716885ad.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022710; x=1781627510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+25TWd2l8G/N6ggT97DlYSDMeVMta32S9PytI7couQ=;
        b=aLL5ixZtjTtisXi4tNTjuYmGXvoGBQeqoPee4Ibs5Wk6kTTDm273wwpAAFZziBQ41N
         zCYDofGf1OLuqanbJf/9um3EHvTOttyhSXETSXPfODW2ZjNA9LJ5kXA3wgtykEbIpWoN
         hwcZreEJKgNeim+I5mkTGWPiyfq4sHmxHu3cWbYTfM3Qu+7Jb2ErnSCnblCXYQRNzo+N
         kKNoeoWhemTyyepe7+s5qx7JuuKlDXEHROq3r0XeJkvp1my/zvemtHzDS0gr3P4/UoXY
         8z3W1gTifTTfGozfIKOPifIm+b/818uDkGW4xtHaQTIn0cO1E9BlftwCNC1/M7YFuHx1
         XyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022710; x=1781627510;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+25TWd2l8G/N6ggT97DlYSDMeVMta32S9PytI7couQ=;
        b=lbLMuL2op2dKjAA7Pdati3dKASSQgcAMoczpLDLfD+68K9eAqE0l14mc/3W4xvU6mX
         bkVHssRdc8gT7ESteM+k6KzBoVPjAQntcjFzRbGyRyLcWx1cs2TKVcZPK2KWWM6XVFxx
         jTm5Sbx2TYYn+BuGJQ4BOV7pVisN7I53YOACe3Ojo373z+eYH7dvI/tn7vvnT2JLHir8
         qWaNyeAMHGHsIlslR2ivegJzQEo/bj/B4A8XCtfn+44L6S5E94HLHbsmq7WJ0KG8s/Va
         4PqvS+e2wjNUyaHyeT76InT40cs5X7WnpYzLELFRR7RpSr6OWivqv+dvV4z6OlvwWspC
         FrOw==
X-Forwarded-Encrypted: i=1; AFNElJ8LIe3toH53x3zC40c22xkpcd8z9Sk0rOs0If0U63oPjvhEW1Fqs7pboX341xlzxuKIWf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPuwETlfqlJ+eFwJruRmMbSCc5GPG+OK7VirF9z70qgMQ6MZP
	MK27KLb/dZ+Nla6DH9rU9gVDw445wQQEmTiBWivgITl9SeAZ2gfBI0SXEoQnUSTizSRC4VHrHf3
	cPt+HFw==
X-Received: from pfnv24.prod.google.com ([2002:aa7:8518:0:b0:842:4162:a47c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d07:b0:841:dcbf:e82b
 with SMTP id d2e1a72fcca58-8430a66e82fmr4540257b3a.12.1781022709581; Tue, 09
 Jun 2026 09:31:49 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:30 -0700
In-Reply-To: <20260603114504.814647-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603114504.814647-2-clopez@suse.de>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102228042.2735004.16823159723918988940.b4-ty@google.com>
Subject: Re: [PATCH] Documentation: KVM: Synchronize x86 VM types
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Jun 2026 13:45:04 +0200, Carlos L=C3=B3pez wrote:
> KVM has reflected KVM_X86_SNP_VM to userspace since 1dfe571c12cf
> ("KVM: SEV: Add initial SEV-SNP support"), and KVM_X86_TDX_VM since
> 161d34609f9b ("KVM: TDX: Make TDX VM type supported"). Update the
> documentation to reflect this fact.
>=20
>=20

Applied to kvm-x86 misc, thanks!

[1/1] Documentation: KVM: Synchronize x86 VM types
      https://github.com/kvm-x86/linux/commit/65aa483f32ec

--
https://github.com/kvm-x86/linux/tree/next
