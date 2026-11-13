Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577817;
	b=vS4vRANOJmB3c5iZ/wc+pOQDagjKDYPiPC7B0pIs6yDXVa5rbNZhUhC/E1iUjoHB/AK0
	 KueIrm81xOYFIzVJuagEX3e1Gxbeaxj7YuwYkFbcaeE4soQBr5iJNeGp+pNokMz6Q3DKo
	 JF3t4VdW5l0pPV2EBirTuXpAv2mpT/XhehIkkwjT8G0XZQY1kQ5ajX7DF4P/F5Pr6wFzl
	 iJv9zGW8DuBROkTYn2hnBWEpzgVbQbKvD64WLWxWwk1z46g/EVOWvkcWUAZIfNY/8Qlaq
	 jD6fsPTOG7DoSRnVvliuMO7RWXYq5ISP4+6p56VHvOYfmEO2JRfqWGIerMBXryUwuZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jb7nyjamFgcgVR3nOIWVWhlGLSSmfYZaeBbucH4zfgQ=;
	b=p6j9/a/+JI77mVmUzK28mtOjPAs8WHe6q+xz5Pr2Otq47We00d4a8dJnycXoai+xioPa
	 +Wk/bWXHrlXddeuUt4gomXF6ihprgO26MGa8bUAWtcG3SpSK9Vj8P2FucXHK734hnAn/D
	 FLwPq3WowrqdqKvmxwT23xVP4DjdlmyG4J5RtiutZNh3qaCyemXcseG4uJGTXRr2ipm80
	 3A1HZZmCGQWszF1/OGOlu4KHwzaX9iQbVBXxzw73kQ/lgajwU4KYvIrGG6uMSlCbYUWOm
	 rwbB/0x3D//+6uGfpvrpSLpvOAqYlvVtVPGjMheKrrmhlEKRu6rHsPn5/SrXXMMUcvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JQcimdpd;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5760A260C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF5760A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JQcimdpd
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed276af91dso17514825ad.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577816; x=1795182616; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jb7nyjamFgcgVR3nOIWVWhlGLSSmfYZaeBbucH4zfgQ=;
        b=JQcimdpd5VGkIluNchEtbtDbMjOM0kaWOiF9OJuCXa1gzUYQbxhfNWYZSf8UG6BoUE
         KWfsDT3+Xb61Hj/Ai8x+SlmIPU13fa8jZChlmYlcgPcNoC5SYprvuAprp7m2kDl+bWo9
         vH4uRPmu0yHl/VfZAOjwtu6yXv45abZRnTVq4gxrUaaKGnKR+g6l4YHkK9MJ85a+rn62
         Ouukbw0P6DGIXQDUrjneLcBnPBiP3T4P/Hgdv5QKlnIKAJ3EqdpsjTm7xpwcyUOK894G
         i5eZP+RqvdlSV22PezaQJOMqueiv8csxBJufcNMo5uXwOFosPtd1/hGXV/U43BpPKiHC
         zXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577816; x=1795182616;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jb7nyjamFgcgVR3nOIWVWhlGLSSmfYZaeBbucH4zfgQ=;
        b=cOMw4fWbteJhbNVWvbV4QGahxDHRSzomqbaIfx7y9vEqj0bM7djtahzfMyllGTQq5H
         oK+llkcYlin4kGryKyvYiO2T52nDV80+ugmcXCzYOK3XDzAQRNN81EE6/pU5Ig//xPD2
         1t4ivHqDpI4UKL0fuSDWh28r2jmBFICwb2Xyjt+SyAa6OaUrY9EqvNIzXEKRZG3J5yic
         vzXyJ50reV0qbmAdwlE6YjZpytrmd/1asMAa3mNKGYLsyTuJUYgOckMMKAo/Nt5GggT3
         vSgnvfx+zWV1xNwnvhx2ip+VPC5QU4bksyPxgNGwxE+GmcXhFYMgkNpbi173og8vDacM
         VFiQ==
X-Forwarded-Encrypted: i=1; AL+hErF00lAYNApl5dB2TZ59m+fBJme1VTT0TAbo3uBe5veO8anq+euWBW4PMB5mvbNXi1L6vsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vRSW6CXvbJecXHg4Fi/P/xKhzW2pjeBX4vL4I4remoFUjueFH
	DgzZcZsy93vMb7pCqfJ+ba76+drmdQZzTAqXNZAsHUwcF3eA3lM80PTXinmqbpA/rv84smXOa+N
	kgUQ47A==
X-Received: from plnm14.prod.google.com ([2002:a17:902:fdae:b0:2e8:ea16:c701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c6:b0:2ed:205e:eabc
 with SMTP id d9443c01a7336-2ee0dad02dfmr27151415ad.32.1794577816132; Fri, 13
 Nov 2026 05:50:16 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:52 -0800
In-Reply-To: <20261024174525.1218244-1-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024174525.1218244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441787535.77103.9188676623707194015.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Compute the max guest TSC frequency from the
 current tsc_khz
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sasha Levin <sashal@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 24 Oct 2026 13:45:25 -0400, Sasha Levin wrote:
> KVM computes the highest frequency that KVM_SET_TSC_KHZ accepts once,
> during vendor init, from the tsc_khz of the time. When KVM is built in,
> that runs before tsc_refine_calibration_work() refines tsc_khz, about a
> second later. If refinement raises tsc_khz, the cap stays below what the
> maximum scaling ratio gives for the refined frequency, and
> KVM_SET_TSC_KHZ rejects frequencies that set_tsc_khz() would accept, as
> set_tsc_khz() computes the ratio from the current tsc_khz.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Compute the max guest TSC frequency from the current tsc_khz
      https://github.com/kvm-x86/linux/commit/87ea335ed2bc

--
https://github.com/kvm-x86/linux/tree/next
