Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F2282F1D
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410520; cv=none; b=rj2cCCp2tCdZt1FoG3BJoItc0tonULLXOPVzssubxSbV18PfQmz7n7emooiVviYYEDjKxzoV77OHxeXHKZnrMetyLBL8xMWWZGmI+q9FNTsC/Gpa6qbCYV+IRRQpAyHL0ELavrJzziuT2NEUV5p68VhigrRwazV5iDJZdg09ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410520; c=relaxed/simple;
	bh=AWA1RyC3DW+Gbn4npqgD5CoqZo4JbHLfF2ZhLzS2+6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZJKDy9vnHRXSb0usc5wX8tPX89KQWyI+gNeor7+NuUAIpmUf8Rw+MbGVp7Tvz/OeBCEhhe1JrbwN7IByrsJ3tLUgBEFrx9McxTdrekBIdo0XcKj+P0Slahrg+XleEEmcReQ2AXWbye/40PWdIV7qtoNBbuf/zecB+eWcQ+DI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IY9hhBVW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IY9hhBVW"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845bc2f62c9so13786b3a.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782410519; x=1783015319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9XORV0MpbLe0TPyqpmXBTUptzOlLBIC6P4Y0TjKtCc=;
        b=IY9hhBVWRfnXdKFhhq5vg8DrLoZUxUiyRsDfAPZVGN/QZVe3h3XMj5YCzr+mDX9VxV
         Z83DLCE4cmg00Lm8lCxMd1AofHEU3V/xsOb+ZqBHuIl80C7Y6+1bt0XQC6U3u7RbZI+J
         MCeTQp94dJxPvyomjKWH3+BOdKXAq4qHDMnhEFqCLkm9znGYmtwjIxGKVyPdhUsZftNV
         G2RiXHhDavSTj/oE2rElQPoX1Z+SE15t55HTlY7gTxmfP2kELKejyroG/ZuUsu2Xi57f
         jl9AWSkroQFyE96FkbK+IaNKj2bNQ1Tlrv7W3shbrJDhu65GZFWrk7KIVfcl68X3uwLU
         OqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410519; x=1783015319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9XORV0MpbLe0TPyqpmXBTUptzOlLBIC6P4Y0TjKtCc=;
        b=eAsUwaPeDpLlGOBc1JpjE2MYD0knOn+vgkteEfx9PAO1lE99GngGA0bY450kW1uI6f
         5M//PRcbQrSTpPWQZvDWmxTs2kyVHRfebV/RPdVFo5pzXVj4aRH5MrEIYk4+Xr5h2Qea
         2CjCCTp8vWhbFmqWxfFSra1M4gKb2vJ3LK9K9fCQp9OYYQmdVJVsqeKC1u0/TEM+3LLo
         FSF9PB6lEuP0puL7fs8o1OMECMTiB2ETdbjOxauPA8jHOv+OBxKoEmJHTNLX9F8sRmEi
         Ts1x7VsDDqU4oRLk7OwXieSQXJZGYnOQ109TfzaNx6iSLLU0onl8+MKvpz+41BAzBfHF
         4d2w==
X-Forwarded-Encrypted: i=1; AHgh+RrEwJchqDOWdzTZ49MTaUmR1vfNVKdPmeHfi4TI1BU+OaRHfEHe41fAcNvPgxEXmXUOK3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNznJIPGYazzxRiWrEgC86XKhzPsIbNPyUiW8H/BeKdxU1mqB8
	rs5Wi2lUi0xZlxa7PrJFYdunWJErxSxIxbvoANLJSsqtUamha0MG2/HU3mc7/p3wi4ixP6hR7A/
	10IKy4A==
X-Received: from pful12.prod.google.com ([2002:a05:6a00:140c:b0:845:5d45:e510])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438e:b0:842:5a18:9af4
 with SMTP id d2e1a72fcca58-845b39e85bcmr4011361b3a.18.1782410518627; Thu, 25
 Jun 2026 11:01:58 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:01:58 -0700
In-Reply-To: <20260618081355.3253581-17-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com> <20260618081355.3253581-17-yilun.xu@linux.intel.com>
Message-ID: <aj1tFuwZWdPGfUoG@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, yilun.xu@intel.com, xiaoyao.li@intel.com, 
	sohil.mehta@intel.com, adrian.hunter@intel.com, kishen.maloor@intel.com, 
	tony.lindgren@linux.intel.com, peter.fang@intel.com, baolu.lu@linux.intel.com, 
	zhenzhong.duan@intel.com, dave.hansen@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 18, 2026, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Provide an in-kernel path for Quote generation when handling
> TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.

Why?
