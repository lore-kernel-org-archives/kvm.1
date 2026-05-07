Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12E3B7B7F
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178497; cv=none; b=uWiXUTLbFjvqaldpt9Z14loX6RpVLWcpNyRPcsr6HRZSW90m6t01sdEKmNPeckxQWKc2A6KfA1hvuLP5AcG4PMkKn73I/6ut2xwJgIyCiQGvkj4v+K/wq+MMq6tcXzlePQykNxrh54+rDWMx1VB4qnG6YzhodeAz6YuFtJguoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178497; c=relaxed/simple;
	bh=Y5nb6fjm3pKQJFfUBy+egnJei//D/8agJcP13ZYs5sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZVFQJPYsypTFDCgRf0j4VMzwwfeVgPqrVrKiWHCOGWCPYyUAd0y8y/Cx4YKrPANwlSQdOHcSNbcbXbjUHNAp6Vdqi5zn0GF7/gYChpAFOjVFpkxRijZTZTFxaPHQIvMuvlTd344HK2iuuKV8xOE7azfN5U4gj1UvFhkK3f6mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sIOUkTcq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIOUkTcq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83603145987so807835b3a.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778178495; x=1778783295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzemv5AAJCeAzw/lVI3sW5woYPq3JMeaoDbzUMaRVms=;
        b=sIOUkTcqtxp/W2LWuogx034zQMdapI/KVx3XXP3F2L20KGUvfxZULOpPXUTS/FAx4Z
         wE6LccQBNAPeVFmiwNpPkEocMC9BNza9SoNur7VIoefLWw7YbWdIFydyIjYjh8nkpfrc
         Mx6BuyVkEqw2HAGZUSGR7SZAGJBrZ19004GMxxqn8H64CDFPv+HFzYTKqpkCBAUxt3DT
         bfjBwQuTbmPm1BTcyjQxn35UgvIiIAI4/kP3f1L4IsVzvUBXe2UidfukRxXBkK55WYw/
         kljWb+eT333masrJqzv4deuwUr2UqeE1Dt4NqAK/LFvRRDW3WXAlNu/DMOCP2EcnrBn0
         LtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178495; x=1778783295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzemv5AAJCeAzw/lVI3sW5woYPq3JMeaoDbzUMaRVms=;
        b=YTJDLTgZXS1bIPHQtP1ixWtPshsemJIMiAsjNrRNdypKOJ6WDjKu8UYP4RKBMSYCbU
         WG+HJbPkvpeylvtLDMuzck2fM7u9kNTK9n+P3u99a8jCIdY5h3ni5oYA66PXZsS9+3me
         1hMzurwUkMw5GdfIcpRVR37Y37GH/YRnR/+xDgsUs5PgwavAH99i+/ktxGrlkhX0W031
         br49CD8qA6Mf7QldeIVxCRNg7BE2JiEHUdpOcl0XVYWSDaiIh/Mq1AwdCRVsdD+E4U3j
         hT5y6y9pBt58QSP/JGC93UhVYV3E/XmaBTv6faO6ybuiky6aQKYx70tSpeF7myTMSung
         xwhw==
X-Forwarded-Encrypted: i=1; AFNElJ81yowNTdM7MKu8FU6+utWsylRrKk9vBmQiikBYbEBW7Qmqc6Wa2d3hlVT3OJxCjD2Dgfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKO//1ZPGAlOI++x6fdHRZcg5A/U8QJ6yqv9ttxM8JpKRr74Pz
	eHUFCxUQECbPvRLngt0nv4PNFToyGO683GLtZ+9aKA/SifEhT27j+YCT+HbXX1jw5EXod2esMIn
	TgORiBA==
X-Received: from pfwy14.prod.google.com ([2002:a05:6a00:1c8e:b0:82f:6658:1e84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8d:b0:82f:cfd2:6ca0
 with SMTP id d2e1a72fcca58-83a5dd57ddemr8392331b3a.40.1778178495257; Thu, 07
 May 2026 11:28:15 -0700 (PDT)
Date: Thu, 7 May 2026 11:28:14 -0700
In-Reply-To: <20260507153850.8214-1-costas.argyris@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507153850.8214-1-costas.argyris@amd.com>
Message-ID: <afzZvhJgmpAT2elF@google.com>
Subject: Re: [PATCH] KVM: selftests: Add guest-side test for AMD HWCR.McStatusWrEn
From: Sean Christopherson <seanjc@google.com>
To: Costas Argyris <costas.argyris@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Costas Argyris wrote:
> The existing hwcr_msr_test exercises MSR_K7_HWCR only via KVM_SET_MSRS,
> which sets host_initiated=true in KVM. The gate in set_msr_mce() that
> calls can_set_mci_status() short-circuits when host_initiated=true, so
> can_set_mci_status() is never reached by the existing test.
> 
> Add a guest-side test that verifies HWCR.McStatusWrEn (bit 18) correctly
> gates non-zero writes to MCi_STATUS MSRs. With the bit set, the write
> must succeed and read back unchanged. With the bit clear, the write must
> raise #GP and leave the register unmodified.
> 
> Signed-off-by: Costas Argyris <costas.argyris@amd.com>
> ---
>  .../testing/selftests/kvm/x86/hwcr_msr_test.c | 65 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 2 deletions(-)

Rather than pile code into a one-off MSR test, how hard would it be to fold this
into msrs_test.c?
