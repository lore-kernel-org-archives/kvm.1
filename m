Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD947884C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114618; cv=none; b=ViGBfhKtl4ke1wYWpZW5OcBIqQKlzcHivRrk/3Z5ASPuLFRWjme+E8mEnLOpzjrvJtJsXp/zLsg1nEEKp67bgJQ0/Bu0rUYAfSJY9/VimKNsYD1I22Da8vp3ltC/xvJco0xJ444fOuDX+dCAkoweqRHeWvVf8NC5XYBgVcgs+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114618; c=relaxed/simple;
	bh=+QqIRMlk35NfFtNSwIIXR0tHqjMN8/7Dy2pT9i6K1QU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p250/gc0Lg0aKE53d8IPtphzymxtQygf7avZK6yIKKhX0lfj02MTle5C4dSi+H9jp7crW28DDBKcOu1LDA2Gy7cPUiHJFCqQPC9R94WXfEAqEEuP+rp3Hwc7zshZE8QBnJmqY9Ijh55fPX3aPBfVJ5jjIU2u1BGmqt58losGmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIb92z79; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIb92z79"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso3855291a12.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779114616; x=1779719416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BMZN8DfhHB/P3bRfvTgBvNLjXRHABO/5pnPVGlHVwI=;
        b=QIb92z79D/2T/eIzgi+OnZRayMt5qAgdMktpTQDzJMkpZ766OcgH4n2XPI0jifGnRM
         K+fL1xRc7ZpOP0ZBdRnltO3svlVwlkddc3hszOxneSNU8idFLJ9sN3flbOW1OuZNgZIZ
         scT/rT6kek+NXEyRB28WZn1gkYoDzKxBLU8QtMlMzfOHOLg/t6E03AOcaPC+tFwNXGQQ
         ePsRCaNIBx9bj0mFr2f275fBMSzG4Q1go3HGhH2aPiod1r/KbLMo+oBnnl2cr7wWbCPP
         dYejyZaqL75VYNZT6axtsa5zPnkNcQdW2qKTzBpGKS4Jlw7+IbxyQ0NgAI4y8ek2PRhs
         GhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114616; x=1779719416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BMZN8DfhHB/P3bRfvTgBvNLjXRHABO/5pnPVGlHVwI=;
        b=I8/sm10Njyk1TAETdzIwhqV5XkprB2XHFaMvSuoEuuNzMqQLuo8bJ3IwSKlRyZFe3Q
         XSMwX1ROngua5mc7YkTs1qQ3X9D81NsfEmjcPzRf867Lg58CexarawwN/sX5BaBzt6rF
         UsViVUIvfeql6tC2Mxgd/akqAdIes0uhDOLFTPZ83cZa5Bsk8dfjc7jz9i0h0l9cp5xx
         nSQD9WoQ/sDq8d5EQwN8Mv9wzhq/RnXD5YZ9ChBMUIAnW6ypOYO04WUhzYXIOOrGw85C
         6gevz+2X5vwGZjmihc21QDz2uu9+ADcLRaZ/WeK+dwnxfdO8FBU964e3hZEMmCRcrKJR
         1Aqg==
X-Gm-Message-State: AOJu0YwlU1Yr2ZKzLY/aUnt7L96v0bh2bHgIuwGB93D24PqCE27i4avf
	0tyo2kjyruDeIEoe2h+Hm1q9LUtJZIcF06G+JnZwnmF5eEElxVQBLn3a4d43s8cBD2AFjEEBl7O
	OzJSiBQ==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c80:e758:dec3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9f:b0:398:7ed3:a001
 with SMTP id adf61e73a8af0-3b22e7afe34mr16907559637.2.1779114615413; Mon, 18
 May 2026 07:30:15 -0700 (PDT)
Date: Mon, 18 May 2026 07:30:14 -0700
In-Reply-To: <20260518143255.3795625a@imammedo>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515111957.4188366-1-imammedo@redhat.com> <agcVNezX5lf1_3O7@google.com>
 <20260518143255.3795625a@imammedo>
Message-ID: <agsidj11-eY80au1@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/svm: work around Virtual VMLOAD/VMSAVE
 bug on Naples and Rome
From: Sean Christopherson <seanjc@google.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Igor Mammedov wrote:
> On Fri, 15 May 2026 05:44:37 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> > > +static bool has_vls_bug(void)  
> > 
> > Probably need to be more specific, because there appear to be multiple flavors
> > of vls bugs.  :-/
> 
> 
> would something like this work:
> 
> -static bool has_vls_bug(void)
> +/*
> + * Naples (Fam17h/00-0f) and Rome (Fam17h/30-3f) cause spurious VMEXITs
> + * on VMLOAD/VMSAVE when the VMCB address falls in [0x78000000, 0x80000000).
> + */
> +static bool has_vls_spurious_vmexit_bug(void)

Works for me.  Any chance you have a specific erratum number that we could reference?
