Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110E158DA3
	for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190809; cv=none; b=ZQe3M6llkP4bM25nB5+Il530dZgvSZ6oMpk0g84e7Q+/VwgWBsbaz9NKJC57nvZnCJa3P1wGaoCWjCQ5XSxjPZf5LTsm8jcYLejMCTAQQals51R75yXta3qJumntM/K8bYYBiShS9SEpfluOaW0CE03blAoIXBzFYYewwZa8HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190809; c=relaxed/simple;
	bh=RsglnV7wKfIPQfs8hfy8yvlxh5i+YSsKAcsQmH2tLF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcGe07abrjrac8dKQQQjMMQTwpOLkGqzfsuNQX3RBjlONhBa05hP63ofcrpZZXs5A9dEZ4+Wl3ySOqGQlDnXrqltEjCYKcrCvZOYA59YWooMC5DLrPf+TA1OCZMiAh4RThaG97lw+QKf6S1a+FAATo5uPFyeEetBj8fGjEmkzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmR/2ahm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmR/2ahm"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c63597a63a6so735048a12.3
        for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769190808; x=1769795608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YS7tf5uaWQzE/6a6Wt+0CLrn6r8A0gKK4bGIYWAh4do=;
        b=CmR/2ahmkqckqQL34cI7ndO+NpLcE0Rrsdf91/zmDYZ5MflyXBkjrFnufMf46zt8FZ
         4wwpWP7eXS9JAEpUJQQdXxl/EhRTZh8QBGoVRYuOhZRfwZcohOV9W3zEWl/g/4QLhY9R
         TXTJqC6oc1DrDPBT0hyxbM33EjBv0tcyYz3I6QwJ5N3Nu4DfbIFVdidQKZSzp288lq+o
         Mx/1GlmIHTOjaCRFwvsnLrbC3YtkViA8JccLVFl0Pr5ODE1FykFT76FGZwpxCxrQgIkf
         Rcp9UXNyxTrcaFdd8TNQUojosOI4Mdvt+5wh6okD70i7ZeTFwiWM4OGquQWHfvBodP3S
         u33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190808; x=1769795608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS7tf5uaWQzE/6a6Wt+0CLrn6r8A0gKK4bGIYWAh4do=;
        b=hRpnorV63U/ZtzQqr4HYhtBbaw17Cx6x+AW4wRrDs2C/8/VAR3tC59doPLy77Pyolu
         8F3hIS2LBb5EvCkiCvgV3yFbKoe+azZS9E9KUyzINYTDN2IlyCC7ayyxeR0nkUhicjA3
         J+ta6iZxx5K0b4up/2IAAMKfAHj4OJE5Yk2nX0scoIIMrbTTbPn6xi7xtM4Y0NJOzaCP
         //4A+B3taYcV5HxKGnC+6BQZQW7AS7iWPiUicDgrt35bxoKbRB6dplC22qYukEAlcHeT
         kPg6XI62O0NeU/H6FCrz3mwT/CU3Wphx3oojQHG/kfiJSoXx/MiplxCnOzpgPw+Hjl4a
         kxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvfZPbyXOz3rOTLHdtZG/gGJ66W6B1qrate0zGvwCr+bX8tKSkNwBjjriKgjCSEB0/ewE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsR217LXYbN1iRHUGaw+2gJ5qLaWqRmil5fAqh3Wle6yVjs6Z+
	B/bOu/8uQcZt5DGbzWycQI2hgU9p6v7p0PWCc3snXSYN9zaZmd+/XmV46bqlYhRBbzvYyUbMHB+
	p9OLcFw==
X-Received: from pfoi24.prod.google.com ([2002:aa7:87d8:0:b0:799:398b:a4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3694:b0:81f:3d32:fe58
 with SMTP id d2e1a72fcca58-82317e00a13mr2635564b3a.35.1769190807803; Fri, 23
 Jan 2026 09:53:27 -0800 (PST)
Date: Fri, 23 Jan 2026 09:53:26 -0800
In-Reply-To: <cf20fff4-931a-4a07-83c1-a33de13fa230@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120050720.931449-1-zhao1.liu@intel.com> <20251120050720.931449-3-zhao1.liu@intel.com>
 <cf20fff4-931a-4a07-83c1-a33de13fa230@intel.com>
Message-ID: <aXO1lhrCb-y8oEnF@google.com>
Subject: Re: [PATCH 2/4] KVM: x86: Advertise AMX CPUIDs in subleaf 0x1E.0x1 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 23, 2026, Xiaoyao Li wrote:
> On 11/20/2025 1:07 PM, Zhao Liu wrote:
> > In addition to the new features, CPUID 0x1E.0x1.EAX[bits 0-3] are
> > mirrored positions of existing AMX feature bits distributed across the
> > 0x7 leaves. To avoid duplicate feature names, name these mirror bits
> > with a *_MIRROR suffix, and define them in reverse_cpuid.h as KVM-only
> > features as well.
> 
> It looks that KVM can emulate the mirroring CPUIDs regardless of whether
> hardware supports subleaf 1. However, given such emulation provides no real
> benefit but complicates KVM implementation, this patch looks good to me.

Yeah, and it would run the risk of guest software doing stupid things like
assuming a certain CPU generation if the leaf is supported.
