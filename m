Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31341611A
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348732; cv=none; b=rDRle+PB/MM6DvoIBVeq5wsp/4kpYcPtiNlIMo1nbeL8ja4O//VsHFbFDAh0sjjSk9zpOjxpnkhUF3WUH/bKrncsX27nL7qLW3Kgs2nFnkTnqwkGQQU/wMFce2fStt9nxjfyTV/Usr/nOK2SSMgrt0wCcL/EzTVCIuUN6wmi1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348732; c=relaxed/simple;
	bh=WyeJ5EF/tZjBuZW11IRhC91KEL0VyusWcgSZs5evABY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qLd1xmzXXM3EgpSTghvLtdUf6G0fitbeLUQ7NSlG7EhoG+G7WiDI0oaAxZiUfnfgb36Fu0/s5x+Z0FJvPh2DkF06L1n3nKtqqwoZCzPSqgqMZxg+tnhFwggQ+WBuVCG5zibnguNXzNP0NcJjxbMo9JDwNwhQURAs3n7QaVqJQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qogevq8t; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qogevq8t"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3811279d51aso6343836a91.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783348730; x=1783953530; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UwAAxpyd6WHoE3P9g3F0tNABu8pkS38T+IVIKKDUsQ4=;
        b=Qogevq8tFVgw+YyawkhfT+FDMkT3ZsslWXOlX3nteiUl4BJ4rpprV00TCbu6+5RKIl
         4GKy5eUIcolmNipvXwO1JoZp/A2vQdzA2XDcIDP4zeaC8bhwqlM7e77vT4hxQW1iSIBR
         2FNvS6UEizK0v3VygzpmiYbw2wIZ6AySJCyw6cnck+NQLs2OdVW6AXpkRi4jAOkva0EZ
         WBlFzjK/8z0Q/+mXj+DcEXST0MAwgffyoqyEFfito10AKIIUybu+Zh9nQKhTED9S8orx
         +Y9jVf2xYleYpkem4ccQ/VTqX6xMEyieZW9qMTkELJdutcw3rv4T81SIp0DxuxjqtIVs
         2MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348730; x=1783953530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwAAxpyd6WHoE3P9g3F0tNABu8pkS38T+IVIKKDUsQ4=;
        b=R0d5kamlsXrOw67cbwExDGWpGa2OxcmXF2ZPKd5CYaFDtn+O3NxcwaqeVR+Q/maiIw
         p2pSRXUe+mBbnjJJTn4JO7yydq31PDI8JTrdBxAzNiyr8mFDh9fLl+xOKAzngCgw3SH9
         JpMpQ3MyP0xqQs+YFX15Hnpyq+M0bKi/8lSBxXZobPeN4YUuBIRLcps+FLg6nDOvrnIu
         DB/QEiQLbHPgQe75D4aj5Jce1lIvRiBlMeUJWjyu9f25SfAga6+flqQVU9CKOpxFQ8R+
         gh/Wwfzsfxe/XmkGAW6rM83hDxoH8r3EY9A5ak+irlO+70Q+K+co9ZmPWCTscadoF39c
         af+w==
X-Forwarded-Encrypted: i=1; AHgh+RpEzo9lxpcTS6HBqEg3jy6K3/IlAYFduD82s+d7cOOyUr4iW27V1u6OgGljOxcwiUYHa5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRg7E1hDWS9xB7lOZ2tH3An/11Ol1O+rFhpswzsaFRZGD7p5y
	1GR/6zWM78lPTssenOKVkaFHbnFYuoAmWDvt8US7vcv4T/vv6CfnG6PZ4hLIoJxqBlUqbhDCbXL
	ov/c3wQ==
X-Received: from pgja21.prod.google.com ([2002:a63:cd55:0:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914a:b0:3bf:c28f:8afd
 with SMTP id adf61e73a8af0-3c08ee373c7mr1061624637.31.1783348729959; Mon, 06
 Jul 2026 07:38:49 -0700 (PDT)
Date: Mon, 6 Jul 2026 07:38:48 -0700
In-Reply-To: <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
 <20260701024521.kffehv7bxcjc5f3y@ewan-server> <akUfrLPAAUuD8zRZ@google.com> <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
Message-ID: <aku9-O5K4a7vTDXS@google.com>
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, 
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Borislav Petkov wrote:
> Btw, Sashiko rightfully mentions:

Please no, let the perf folks deal with synchronizing the headers.  I explicitly
instruct people *not* to copy kernel header changes to tools/ when sumbmitting
KVM patches, because it creates the false impression that KVM selftests actually
consume those headers.

> https://lore.kernel.org/r/20260610024350.F13471F00893@smtp.kernel.org
