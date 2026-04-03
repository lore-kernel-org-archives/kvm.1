Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1F361DB4
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229748; cv=none; b=TiWx35Hgzp+6TdwLSGv1S6LbJtSnUyLk7tAna+KxTkaiPWp7kEecmhZ0ticEpd6EfAcY6M+MYa7eyDa9iCdZGAxlRIMhIpDEEq7gg7PhIvGeYbi8WOBZw7f7q1A7cHCtjmDFSetOi3XQ801driBnVRP82xOzNU1U0CL/AJk6tik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229748; c=relaxed/simple;
	bh=DFBq3w/+92JvVnCUbNwiX8XBReWt3DAvnjGNuqvEFVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Lc3EVg52cwYBsgJYut025N0aQ1m+lGVb2ZS1gn9Pdh3G1cuBJiBzf07+0bcjmZcfRaoEu7y7eHTHsyI47B8VH03xKQwJ34Japu7SiwwnDzCYgftWsozyqO/6RVxH89rYTsy6hOdrmWwk8HHeEAtc+9oiJM73pu07FmbyvxtJyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7U/ywbl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7U/ywbl"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so1297391a12.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229746; x=1775834546; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpqHqNyfK10lqPQLcRaczDLbjeG2pjSQT2XmZnmBEwU=;
        b=V7U/ywblejifqP78l8dW7Ik8EudEIfcb6fj0hFD+oC+P4ugICyRU1+YSIwquX/jgKC
         De7KoKpTZLTZPHciHBnXHt6AWJrQ5no2Ui9X02aRRXO/1YEfekH1f9nZuWiJ7VhiSsgr
         ue1cNWL6tkY16knhsKbMBSu1vGqBW0sk95hvT5NaKq7+pdjnp4wjpOJRjSNL9gQoKAtH
         RfHzQ6sYCulGV1FHs75ltgdjnrwlQjiKmZkpjfXZtQbI/lysgl7DbUlDm7IDSJkhrCSk
         I1MkN7E6RqcrOT2Bb25ZeNz7YmFxHs/vzVTeF1Oq5eoW5XKy/4d3RpK10xL8AWhrv42j
         d8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229746; x=1775834546;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpqHqNyfK10lqPQLcRaczDLbjeG2pjSQT2XmZnmBEwU=;
        b=HJIrXKvsfo3C7ueoMezOIDx+PiORPIxyJ5B1YSRM/lKJ4AL08FWbKaFSjo5kVbfpV+
         lSk9gKMkxT9IGdQjPs5MaPWIr3rR1oMEJSjiEl8JjfPFRu/FDvPLDSOXJZWoFNdFqO8T
         0F4hWi93onQ9C845izJ/aQ4zHfeqf3vzyKS/ICeXoryU9GWw5HtSIvDw0IjebMfGaRo8
         Cqf1VndlqORLWfKuJktwjQiSUZO3N8kEqCTSOIjqVlisP5zTguMLjhEgDeaNjp9u/CwL
         VtiMZErTmoLwMdLnKRPFG6n6TVvJiBB0XyKKuaqhJvSbEpgWuu1WUrx/lxKkUPN3DHi5
         opbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUL13UiUdkQE73igRcMrHC0byTRhR2bpnVe1MBcOOP/qaIs4uM7psj7lUKz08aqlFMLMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KQ92TpfvTgx2gMbiD16hymaPriTKRI7d7ZsdSW3XvQRnYboT
	Od4w4fXmH1nwoYPd9pou4kXDUFzLyaElWtqqIASlzAnUfA9mHoglwdzOD63TakMU5p2vprrQPag
	Zgu9ExA==
X-Received: from pfbfc19.prod.google.com ([2002:a05:6a00:2e13:b0:824:aec2:e5eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1705:b0:828:d9a1:c5f9
 with SMTP id d2e1a72fcca58-82d0db53ec9mr3313449b3a.33.1775229745970; Fri, 03
 Apr 2026 08:22:25 -0700 (PDT)
Date: Fri, 3 Apr 2026 08:22:24 -0700
In-Reply-To: <20260120203937.1447592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120203937.1447592-1-seanjc@google.com>
Message-ID: <ac_bMKD7YGhMwUCf@google.com>
Subject: Re: [PATCH] x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's
 0-based level
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 20, 2026, Sean Christopherson wrote:
> Rework the TDX APIs to take the kernel's 1-based pg_level enum, not the
> TDX-Module's 0-based level.  The APIs are _kernel_ APIs, not TDX-Module
> APIs, and the kernel (and KVM) uses "enum pg_level" literally everywhere.
> 
> Using "enum pg_level" eliminates ambiguity when looking at the APIs (it's
> NOT clear that "int level" refers to the TDX-Module's level), and will
> allow for using existing helpers like page_level_size() when support for
> hugepages is added to the S-EPT APIs.
> 
> No functional change intended.
> 
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

This still applies cleanly, any chance this can be picked up for 7.1 to avoid
prototype conflicts in ongoing work?
