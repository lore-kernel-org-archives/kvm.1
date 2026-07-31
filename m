Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED1369D74
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528612; cv=none; b=Vl3UyTtpOXkCq27//xLB0oEkkQla08iiWw6A14E/AeT7F3cAXzPUZY1+T4UxmaRJfvduGiTIxrKNBoZfVxSWxzJJO2fzn8srtdj1aYc3LsYgsOfIevhfK24Aou/lWEBO54ApRUHD8D/7I0VxO42MGjU/36ZzTwHuaWGJreknc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528612; c=relaxed/simple;
	bh=EbkAtw/yPxzI+zkDqTO3nDCw8wZaoKCV5tUxOPgLNqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GmkQELnAx1QiAB9nrFYBRUQd/YIVVDGR5tk2pV0ZCdvDbjLjpk4INpIF/dJi1Gq9HwkVp73bcNFPkYZBQ0lf7M1SKef490beWMAEfPtqnRKhGwG7RjbawWjJz5lVvzBXH8Lc5sTdGE90iQh+EZFSDkBMnOac7baRiu+cedJVQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUH7X7Vb; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUH7X7Vb"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso1943927b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528611; x=1786133411; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dGHZhChNpAHEZYB2yzeExiUjrKbT3b7Zh2GTXyKqp4=;
        b=EUH7X7Vbv4/l+BwVXuuqLMnRLyHEUB/DxQAU/eTnGEz55NEyVg6g4f5/HdTsspSU4F
         2AnlvFgrvKtDSByeLBmXaFCXX5KjSQ8W2OZqz55SUq+8V/9GmnIsobrQhrALQwLuHnXR
         Clyw9aWyZfb45rZbBoblwBJhL26YCigISCxVNyUbKcvM6hROmZ63oU15sanYmfIFxCPS
         ka3jWY+vYcHA56P2TSYY0bHs0xo8fKE625tiUTP5NOOSpA2VFKJh3sgFPmR2fDxgYC4x
         bkBS7FoEH9k3V8VZzsDIvdb7kHxo98mJBcUfy2TVYGnM9eY7J0SYpgr2gvUmfgOG3QN1
         WxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528611; x=1786133411;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dGHZhChNpAHEZYB2yzeExiUjrKbT3b7Zh2GTXyKqp4=;
        b=Vd8FaduqTufEE/nnL7+f9EBLfiIvO8gU+h2H8H9hr4d6De18/fvXQzpNwv1nBNqAcG
         J8Gjy/3YRDtEhMeOBhXB0uniX7zKIJ0pxVMTAntwRd9qv3QJb7mbNHurYX21nWudi9Lp
         vSG8jFfEvio7WsoZXgCDR1z3yCfCQYXpf/WTOx5ISx8sYsaSRSMzdCxMiDVIf9W5u27Y
         dS83VH09EpDt6CcdQGSJWjwZCqOKayFjsCkLLrmzuhtrCNLPQ3QNc9DNHVcuyNlvTJpK
         e7AA+hABfH3KlqR6ztsTGeXLG6KyjpxcP81tEr8TMKwEzFCWW4v5RDa+dEpu3XYr8+pt
         eZxw==
X-Forwarded-Encrypted: i=1; AHgh+RrB/Bd3VtA9rHlI9S+E3OdVrghueb6MUv6BpuH20fRMGBWWQpQ6ZkQ/YrV8NrXNmJERDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1zwkcUnKGt4VzWOgrK379XBP+pD7UpokBOZZ9Bzc+FTpZbPf
	pEVrXwLKlTA0/CF4zrgU4erU5iTrM3d5AYWI4DfV9GVLylY3hTZUsUmntyhR2P7/+N2BFqNSrkF
	yguGzng==
X-Received: from pfbi27-n2.prod.google.com ([2002:a05:6a00:a51b:20b0:848:5395:9a78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d87:b0:848:4256:d6ad
 with SMTP id d2e1a72fcca58-84ee48f8ab0mr799329b3a.60.1785528610394; Fri, 31
 Jul 2026 13:10:10 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:44 -0700
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703212145.343527-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552799129.2700794.10181439022561913222.b4-ty@google.com>
Subject: Re: [PATCH v6 00/36] Cleaning up the KVM clock mess
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 03 Jul 2026 22:17:39 +0100, David Woodhouse wrote:
> This is v6 of the series to clean up the KVM clock, rebased onto the
> tip timers/ptp material (the timers-ptp-2026-06-13 merge, which includes
> Thomas's ktime snapshot series and the read_snapshot patches).
> 
> The KVM clock has historically suffered from three problems:
> 
>  1. Imprecision: get_kvmclock_ns() computed the clock from the *host*
>     TSC without applying guest TSC scaling, causing systemic drift from
>     the values the guest computes from its own TSC.
> 
> [...]

Applied patch 1 to kvm-x86 clocks.

[01/36] KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
        https://github.com/kvm-x86/linux/commit/3d4b20b5a7df

--
https://github.com/kvm-x86/linux/tree/next
