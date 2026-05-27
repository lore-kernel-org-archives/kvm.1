Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325A36728F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920280; cv=none; b=FAglSaVCK3o0LR0EVt6yRiDzqkY1BDbqtfP9jLVFOvGKl+bpizPBD2FZvjdu7s77eOO9uyvUOlMUzqxFGorM0dRs6WnCT56JVsrsI7TN/mvXzFdwpczwbG23+ODcVdpHk2oMX3ZvlPEM87aZUXuYAQ/VHpw0Na3k2UxIV3XLzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920280; c=relaxed/simple;
	bh=1sxaT2yKT87FBjAklG3y4fjte2ftGz9EHca3CrIXFgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxksfjpUqFSHgFrUA++m1ufRUNqEYqlHr1e/3/FCV6hRTaE4Kc3dhRlxmLD62/Q2SI3OERX+TETubHUv7IU75QmqAPERdrbRjGQXXyiTv/FqQYgUr0tocaD+e8Dokku0zZvy7X/e0k9tu2gbjF4mpEaMUU7UM8agW8oYipFBbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/ZualOn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/ZualOn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so14226050b3a.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920279; x=1780525079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJUvpxMykDcZEh8E5S70X1RGAlIIE45ie8Q8d7UxZhY=;
        b=f/ZualOntV9OlXt11saxi9h32w3s+NbpEWXiv+gmaBCU4jlTw2HB0Gi+KSii7x0uzf
         1agvCb1D/c5DgR/Fj0oVU0E0ZuX3tGA93xe5oFegPPZ7d1YRQNnw+RsaiYBG2QLgE8ns
         P9yOk8Aj1h7rNiV7NAJMh/9DNmnAi9Wds9kSHWa2KwhjJLjBhmCDY5lf3nzlu73faKdx
         zBed7NujFjx4357ipANZTgQEdkXWyMTSmicWGbpwLHZujZAbyT1WPr73R86Z/rR0DKCr
         bYjsp0xmJin1kqTzxS93fs5X+XIR8yYOvZoO1Um0/Wsf7LlW/yxXLoc8B1DkTGd9zfyD
         mahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920279; x=1780525079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vJUvpxMykDcZEh8E5S70X1RGAlIIE45ie8Q8d7UxZhY=;
        b=s/5HoKyTaGrcI1xtzdBIFnDwGik8UW4rhpgsteOdb/2teI5SFYgf6w2KC/L5HgQPz0
         k7fuwbfWZ2lfwOou9kkmylfuDBgSIJFlzRvCIDq+O/m3bWLhRDVLQC8OXqhm4BB0PAPg
         SBhtwy6LUaVeVZjLgAyu7wThNd9GABp5TkdXBpsvKuPQtUqOOEIsjG3m7sb8zyocRlGb
         /EgdRzsgLb2Y9d1qy1BOcRQXruZUhulCbpwrNVKTNynQ8vLH8ZZjcMCOekVE0Mv/wvTd
         tsIiKOeycmcTia9nuGvuGDguidvH44EwobjqDdkmOC1Yuic0w6XR+M6uyUFTLCeLQVfO
         iW1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/la+a6sb22CZNjexWeXcjW8qo6EaGhsVVtdRorb6Fo4TwbTLthbtwKr0Htnqcw1lD+tHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy465uMgGWbBnzI0YL/Krd663CsjhqDdNpJpLCcR7uddgdXtfBG
	ygBQGU26SvYH5DAN3/Hk+4zy/hJUV8B1GmSGJRL+clkGEzLLrQ60737Mb5yiRtaBtJTnYLHX2ic
	YElfIAg==
X-Received: from pfbim9.prod.google.com ([2002:a05:6a00:8d89:b0:82f:a396:2232])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a09:b0:83e:c8fb:54df
 with SMTP id d2e1a72fcca58-8415f3add4cmr24266333b3a.2.1779920278475; Wed, 27
 May 2026 15:17:58 -0700 (PDT)
Date: Wed, 27 May 2026 15:17:57 -0700
In-Reply-To: <bb2a3905fb2fefe815ec482b7eaed5f7d7bd2a3d.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509075201.4077-1-yan.y.zhao@intel.com> <20260509075357.4113-1-yan.y.zhao@intel.com>
 <ahc3hmTa3TiOTZv6@google.com> <bb2a3905fb2fefe815ec482b7eaed5f7d7bd2a3d.camel@intel.com>
Message-ID: <ahdtlXPnU_sZ04XU@google.com>
Subject: Re: [PATCH v2 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-05-27 at 11:27 -0700, Sean Christopherson wrote:
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > [Rick: add in trivial feedback]
> > > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > ---
> > > MMU_refactors v2:
> > > - Moved this patch to the very beginning of the series so that when
> > > =C2=A0=C2=A0 warnings like "KVM_BUG_ON(!is_shadow_present_pte(new_spt=
e), kvm)" are
> > > =C2=A0=C2=A0 removed from __tdp_mmu_set_spte_atomic() in TDP MMU in a=
 later patch, the
> > > =C2=A0=C2=A0 atomic zap change can be propagated via the .set_externa=
l_spte() op.
> > > =C2=A0=C2=A0 (Yan).
> > >=20
> > > MMU_refactors v1:
> > > =C2=A0 - rename external_spt->sept_pt (Rick, Yan)
> >=20
> > Put the versioning info below the "---" that delineates the diff, other=
wise
> > `git am` adds it to the changelog.
>=20
> Hmm, it doesn't for me. The higher "---" gets picked up. Just tested on t=
his
> patch and the version logs are dropped after git am.
>=20
> I use format Yan has here to keep the version logs in the commit in the g=
it
> tree. Then when sending out, it automatically gets dropped by the first a=
pplier.

I'm a dumbass.  I didn't apply these, I pulled down the github branch, beca=
use
I couldn't get them to apply cleanly.  /facepalm

Actually applying them does indeed work as intended.

Sorry, and thanks!
