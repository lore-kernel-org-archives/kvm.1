Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091A366DA3
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073238; cv=pass; b=NLtjFaMeEc0MFgz4S+a7G/Dc4HhQticoL4gDdpuU/rRAAHOTpd+KtQZI64sAqOxR5FEcEhZuYeTufsPVK7ZY/UHSayA0FHWtWMvX6yfFz3pVg+bzgFzHPMMjRzfrzig7NH2+Z2NPl0MipgJCFpzZhNE99uWwbpAC+PlMODmxiPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073238; c=relaxed/simple;
	bh=+pL6pqOHth8Kh+3sg+l+5cza3eT1hUeuSoLRqXYxmAo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OttTWjkc9L57m/Nq5tZxWf3zoQitmH6PThMH1QAZIsn57G7g+LFY/PVeTvXzP0/1VxpoV2x08y3oUXgcjlGIyMO5BSwGtURUxVvQBm+AtFBpc2DGdCXW+TTCQnM6pxtRFBCOw+pzRFukltEpffyOtFwnHxIayDJvH4hW4BJXbzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWit/tzH; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWit/tzH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3516678a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073237; cv=none;
        d=google.com; s=arc-20260327;
        b=e6jPamFkn+2xurFu4pMIsqjS+X0AyifmXWrv1mNdUuh45GjVUHr99EuqxUqq3Dop1a
         +WfX5woLMT1sVw+VhMM1erlk1cH29fdTZMU7Taz5UMTaMV/LZ1zffjzHgymFljUCQ4wP
         6GdLOA+7U2tlhRG2cO0kxCdN34dFWNey6m0tULpqhdvvq6E111Zhv9SeRVeWbcpuwYD+
         Wkj843i0ZvlrY82EtovL0mUVQGhbl3owhUxa4ocNkoxVdCvusJVeQUr2ahPHj/y6PFG9
         gLYMwhNSbXCiuuZc6ya1IFI8He6meCBSaQnQOUoOghS40uPVoJnS4HPjch7wvCZ/qM1j
         IPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bK9XdHdQPH9UANQoc71seorXHqS2gSZ9Sh+Ic2oUJ+8=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=MTJen+UzfDuYxdeFrap3M5kpibmbUUOOpTmDO0dnUs7G01TOprxQY/WS/jtTFVi99C
         xc15XGOVtDZRhwcIjhbnSnD20QtPInjRAciuu3b6sxLkT4j2nQ2BLWvQ0g97tj48Gfc3
         XVAwg49Uv41UEpZ1fgfqAhqxcvNBkXAmvwg4CWQbMY+2sM1Ki3Tc6T+piwJYPIibS2iP
         EJK4mF0R5+ZXIqSjitpoyYl0CJ3HibS0uyHNGeFPCnQUrc9zt4qfXKU19DsJ75YmM1Gb
         KDI49X1DjlJS+OV7xsuZANlXmq0sfbu5N9nsp4iVo8bV27Bmb9ggrW2JP2FD7FC3EUOA
         W7Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784073237; x=1784678037; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bK9XdHdQPH9UANQoc71seorXHqS2gSZ9Sh+Ic2oUJ+8=;
        b=YWit/tzH8r4MR8as428EFeO0Sl3X5xqyp6CymPHE0MnbgJY9NLhEVa8r1TrAUM3m0Z
         5Mqh6SYcFnhox5/gYtYI8tPahXyjtwYwaPaPoe2PQs10oaEvfXzA3pHAzN9r4AQd8i4c
         UtgGSSwVV3OSpFcjHMvnwacOz2QrQi93vH/dJDPtYKkZtxoHfZqSo0Apq1BiP7eIcua3
         v8iMQt+5kK94FLo4XI9gTagQmpU4n67B72o6CuX4sq6L5UUCd9zB4WWEnTQDwH++nIu6
         E+KO9Ejc3jHcJANDZIzBJOkun4cAe1yjJha3kILz8XMfuaDL9DHfgs1ME6O++zdZ+WbQ
         4ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073237; x=1784678037;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK9XdHdQPH9UANQoc71seorXHqS2gSZ9Sh+Ic2oUJ+8=;
        b=F1wqHTcDKIWcLmi2VzNttvZB/XH/vUaylWZ2PMlpQl46HxmTchra/MX7hLyTT8nj9F
         MRRRjzHMN+YTxONBYs250K6fymnLZ+DdadEn6EEBRdWjQluRxlCgiRJpsSx+dxQrUheF
         I6JnqkjiqlT29/EHpje3qhneV5Neszjp1HTjw46qPUT5b+dwIDgMlvyCexlYmOOR/tzS
         xslS6uSZRshpTZSuchlBMljBwY/ojAfBFyRWadtBhBekU8PHXQ8sMv7658/BgiijPwUY
         pAW+ug70k3M/9+JAy4GMtYIHfpZdbMtvgoEYSKUjuPVKInOdn3VaDqVQesGQvtPScO1W
         dkaQ==
X-Gm-Message-State: AOJu0Yx++o87NgSIpPS3A/andQX6HFk6mJaM+JVLCMS7Ld4enq0E//GP
	yjgHpCM8J/ioaXXdds7i/Z/UWhE1lAf7vY7rvfbyIUaGlBl9g9E+JXIQZFqBexBjwsUhjsQjbIQ
	l7IH8xM6jVR5LTbRxVeZdRL/+9M5lQAwOUgTsSdz3
X-Gm-Gg: AfdE7cmEkVPbyXpzxtoF9mrfUIOCudAsXQhSt7YH9kOvJsFGWxXVXqFSUoMUur1l1eM
	jdl98a7u20Jwm6R6VaIEiSqbYeFq31CGBQ3sliZLYjrsLAPP4ph3zrGfDBGT7MThl7QKWNTvrpN
	HlxFlgMAQaC+stQxpTcJftfj/WWP/pARzSNnvQAL73bYRN/UiB0xCUvrWoKqsL7ru0sHAGJb1lw
	nN6CL9e+2VaIfIPclBplrgxVqGe/KYFKs4ZZ9aINs4j7fgUX2hBTKtEJh2ncMEuw5UkHaNQLq/z
	CepNn0xZjOJWPZIB4unpf/H0ux5iACeBroMXTSsehWecQf1BVmUg0JOeWYs=
X-Received: by 2002:a05:6a21:e8a:b0:3c1:744:a584 with SMTP id
 adf61e73a8af0-3c35738f6bamr5028359637.19.1784073236192; Tue, 14 Jul 2026
 16:53:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:53:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:53:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-3-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jul 2026 16:53:55 -0700
X-Gm-Features: AUfX_mzwE1s_XZLm0RPCt0KJgaH_aH5v6zLUL8YrI4FY3k6NEOGsfoPD8t22kog
Message-ID: <CAEvNRgGN4dpoyQnrY-5VWZ28-qXbS_OPO+0jE=k4EW5HXpuFVw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] KVM: guest_memfd: Rename invalidate() arch hook to
 reclaim() and isolate it
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rename guest_memfd's invalidate() hook to reclaim() and isolate it via its
> own RECLAIM Kconfig, as the hook is called when a folio is freed, which is
> far too late and lacks sufficient information for KVM to actually
> invalidate its usage of the memory.  E.g. SNP uses the hook to convert
> memory back to SHARED so that it can be safely accessed by the host, there
> is no invalidation of guest mappings anywhere.  Isolating the hook will
> also allow pKVM on arm64 to opt-in to reclaim() without also having to
> differentiate between reclaim and conversions to shared for active VMs.
>
> Keep guest_memfd's trampoline, even though it would be trivial to wire up
> .free_folio() directly to an arch callback, to avoid bleeding guest_memfd
> internals into arch code (specifically, avoid referencing folios in arch
> code).
>
> Leave the kvm_x86_ops hook as-is for the moment, as the hook can be dropped
> entirely ("reclaim" on SNP is the same as convert-to-shared).
>
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
