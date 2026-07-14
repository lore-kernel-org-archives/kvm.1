Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD5424D60
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057362; cv=none; b=SPwtGCBT9LnLd+AUtVPke2vXsetrbl8F1NOFpxiyGMgxmijRd4Qb6axizoPO/xQj1q6dIxLskAqXXNVgmVngneh936xN6qBTI8GnE6D7Nk2p1M1HaBg1TseaMTAW1nLw3WzEECP9bh351CtB9xmJ3MYdM7F2RmBKaoPDTgUhAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057362; c=relaxed/simple;
	bh=BBeDVyGWRQot8ZJ/aWhbjZjNFmDjco14N/2OA/d8xYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbENSVnOUOlb7xxJ3uaxeboT8aX+f9d5PPY3PZh/MJD+kaKNSeWCZnX/nLo8KjDqORWUWjV+qRV1N78lp7UCI6Mr9Y76iD9bnH5SuaSGl8TY/hjzmVQJJVBluMvGZOgDjZyKmGOowikvd3sYyXrZqJSa82Ilfy0cPDAcLEMugu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DT+A+D9Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DT+A+D9Y"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8486c3411c8so6633364b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057361; x=1784662161; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gb5iFTR62Fu5LpZpu/BNvIOpuloZcZNngIH2I4WRC24=;
        b=DT+A+D9YbCCOCHqJOHcf7QElb+sjZxI+2MlAw/vSzw+dI9EPawVoaotdQUtXABHq3I
         5KBf/9hL9v6UT7kdCIvQB4CvdrjZWD8RxiksxK+Jfg3G6nu2UsB7CViZRXQmul8dGOtv
         dbMY7HPgGPJGeiTOR6f6wTjFY00G05zKOJW5AlUrj8TZQB6JS3rnJNCUhjnySUR5YHtN
         9glkKNsML0iBFiPkxxh0IQwscH39iCUz61zmgTMF50mouE6kYtqWma7OPEBb3P8avTbI
         3ITrTLmDOVyGVdY+3XBgPTz3Tm+EsRRAeDQu0YyBiDlzew6TVwcfPXDhG+vr7v02OVji
         2Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057361; x=1784662161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gb5iFTR62Fu5LpZpu/BNvIOpuloZcZNngIH2I4WRC24=;
        b=QX5MdgE7CBWQb+YvKpJ4zpkB6YtUkeKI41QmH1wzm9ea3TZiBzaZXWGLDNYVYqDZSU
         Whl1NczFySDyBXTxbrg8XzqE/TGr7zHp5q6dWXqUei9yD/B0aMUCtaQ2g2fjmESiHunR
         xsaQj82wO73dZ1nDAK96Sr5ye4cmk4fXRKruvPCF1SpYWZlcS0C9HzaYUhgCkMoTtdtp
         uVC98SYZGmduGkWPIbkEXYHhVRVC7gxwi3xmloE83z8cO6R+SLoLK2qAiAvFf0iFMpHr
         XZOBuUax2pAvvHRW5W2vhhm3HgIzZOe2cM1FqrY59DFOC987JTgN5Bqp6S+CUXRKjTTV
         JUWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoILvS0Twgf92W54E4Ol3XEjAfOHapdTiNdyNj2NstR6fZNpWXhFheLNuNRbqBVUWNssSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3NoqFMzyZ9MPu5Ijn/oQssYw/V6XWCD7ko0QFyltFx0ipREs
	ZP4CoZ6/lUCC+xWlgQLK7GWu9yBiLF/75FKDAao+XfHGS0z268f8TVDAHuC4Wt88Z2VCW5qebrY
	NgZoazQ==
X-Received: from pfud15.prod.google.com ([2002:a05:6a00:10cf:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3395:b0:842:83d1:ee6d
 with SMTP id d2e1a72fcca58-848896dd7fbmr14046307b3a.45.1784057360778; Tue, 14
 Jul 2026 12:29:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:21 -0700
In-Reply-To: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405254820.3110300.4723160760872313662.b4-ty@google.com>
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: binbin.wu@linux.intel.com, cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Content-Type: text/plain; charset="utf-8"

On Wed, 10 Jun 2026 10:35:07 +0800, Ewan Hai-oc wrote:
> This series exposes five groups of Zhaoxin-specific CPUID 0xC0000001 EDX
> feature bits to KVM guests. Each group corresponds to a category of
> unprivileged cryptographic or RNG instructions that have been present in
> Zhaoxin processors but not yet advertised by KVM.
> 
> All instructions covered here are unprivileged (no CPL restriction) and
> available in all CPU modes (real / V86 / compat / protected / long), with
> no associated MSR control. Each feature is reported as a (X, X_EN) pair
> where the two bits are redundant by hardware design (set or cleared
> together), and both are CPUID-level reporting bits requiring no KVM
> emulation.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
      https://github.com/kvm-x86/linux/commit/d99fc2a7c5e2
[2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
      https://github.com/kvm-x86/linux/commit/3ee865eb696f
[3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
      https://github.com/kvm-x86/linux/commit/93134f14106b
[4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
      https://github.com/kvm-x86/linux/commit/54db9aaacc2a
[5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
      https://github.com/kvm-x86/linux/commit/dcfb0f2c067a

--
https://github.com/kvm-x86/linux/tree/next
