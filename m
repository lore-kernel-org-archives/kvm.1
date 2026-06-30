Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620731E858
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855855; cv=none; b=RdxA/XMYwyPIzJyTPqVb1QzqsXHdzF4fbWja5Ea08iTJNPuK/TZVDDj2RIJZ/QJWGerYAxVkaXYEBDaNtQjjnlNNCh/zv84lKwZa5mKVDoMdPDZky7wLalD+m8yzi/biZ70aXF2UBfd3swyTG7Kiw/ozt0ovY8r/W1NbHdtpDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855855; c=relaxed/simple;
	bh=7gdMP7g4es8HKlRkPDE3eeTsHBjBSWziFiloyUrEOiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieD5fhW82aV1YaIfxkRmObEkIsyv4npdd1+QadUSBnU9Zh9cf0xwfuQdXIgKGj3OWbEF262y+kJ6XL/23BVx6kOqFN+bOVypGqXHnd98xAQXw2XFHRBQo1uj5JQeUhiURqYTsbUtQZil9SevyuX/nf5OlHRBbj87bJanGG4TLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBm8ntWU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBm8ntWU"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so2040331a12.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782855852; x=1783460652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pw6lIALG0Spiu3IV0fArIcOqMCFn4hZoj0j6EEKXW5o=;
        b=DBm8ntWUJ/umuKES8UR6WXgKM07+90owOBYa5/f+6hrXLkn6U8+GI9Webi+AumV8ak
         Uwk5S+rOeh/fwupPi01ljTSF4Nimdh6cBaU6IG+z8QCrk/pXVxTvLIPUWzuiFJXJWu8j
         toYhZBi4/YCqhg1nWtWmm58f73ksPzocckD5KfevG82oZ/hbXdKMvvGeif77bqIqoI26
         BLEEwJnZ547U+IcPFt5A+8wY13g/YULUZ3R8NylsWkpca1vgElF6ySElukPkSA/sTHT6
         B3UuAcb7fW/Wdkbx8WAtOGWhPZS1/M6y4UllxgEmtiFsSQYMlLtWFvas4ol164Qyzug2
         ZRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855852; x=1783460652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pw6lIALG0Spiu3IV0fArIcOqMCFn4hZoj0j6EEKXW5o=;
        b=Ic3lQM9PgEBOf0Xrr/9p7YzdyV299Lwu4a7tccZPZnqJHfqZxs1jdoKlag0K/6JG52
         gm7h2Ls++j0XzkND/FbLKQ7l9SRASKXS6b+63FKyWw4jLNFxMf6e4vyaMM/PRnClrHVw
         uk+vcDOwf32ou5LuV5bRtwGzLOkKSn6xnSt3t5XtqadhKGH81WQChgrRGdvuDwfMjUVd
         hp8wdMXlmKX460kua2QEocAFTEIEb2cFYpVi+4UW/5ZgqbXKXda1hjEFIlMYrkw/FT4b
         en3qH6T4C06AoBif/s9U3yuicGEX8KZEus/SfZbve9QL3kGTgZuWihyFqL1VBeBjcTtt
         dSpw==
X-Forwarded-Encrypted: i=1; AFNElJ+TEiHdTCvZGMwr7ik7WPbAqcy2Ya8flBNeB3igE06wjqpL95uSaB4irqfnr76gsIQRDas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDsn4OspLyZsc6CaOMhKr6KbyVCpgUXUXqlsdxa4Jgpxva9U3
	CERJKQIIoPkwoixbXpxb68ooNicYg3UI5sX4bOaBrsx/TNXKSaosw1PWi1Wxupl86udggwKv85D
	ueob7Dw==
X-Gm-Gg: AfdE7cm80j3EEcplWxLL8CuJ/Sd+v/+BJngeGe/bVMRLJrK6fMfZVsgAaf6iP7dSe+F
	m/GpANMN40KB3xuGiYvCXZYLFyxNkncVQVQmz34B9tqg08td5FHjJaIb/nN7VvmB7QvCFNyCYKU
	9SwFr/CGC0uF8A9lxqUTcT92BEHnKASQHTa8ZuGDjJMtE8aAENZhdtTFa7iLME9ReXPgWKKD7TG
	lSlcQgLkotxWiH7q9gkVVkrWV7ClRGNY0oafN8l7rhye422WketCoWS6/Cm0+zfxaTdg9RyWm/O
	4if+UnlC7mQ4FdflzcgRoyf578sB03kzwkGgkHMyOPfZ3ZgJNX12VHdukUhP55oOyk0oU/oQtaE
	vpJmUELC3XfLgQ0+ZrU33tZE4VupaAqXPDKe0g0xILzfCBH07Hl2VFIc4dZNF/kV7LSXQIcEla4
	0LF1p8IPB8rQi+zYgGLAJp3nim6MqmVuEhB31z4V9HVCNjRph5Tm2qZCBeQlUe1Q==
X-Received: by 2002:a05:6a00:1896:b0:845:d4f0:98c6 with SMTP id d2e1a72fcca58-8479eecc353mr4683285b3a.4.1782855852080;
        Tue, 30 Jun 2026 14:44:12 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fff4ca8sm2852868b3a.15.2026.06.30.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:44:11 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:44:07 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raghavendra Rao Ananta <rananta@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH] vfio: selftests: Add luuid to libvfio.mk's list of
 libraries, not to the Makefile
Message-ID: <akQ4p3sPdNzSnAc9@google.com>
References: <20260630212805.474418-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630212805.474418-1-seanjc@google.com>

On 2026-06-30 02:28 PM, Sean Christopherson wrote:
> Link to the uuid library as part of libvfio.mk instead of as only linking
> it via VFIO selftests' Makefile, as the whole point of providing libvfio.mk
> is to allow linking the VFIO library functionality into KVM selftests,
> without KVM selftests having to know the gory details or duplicate code.
> 
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Fixes: e65f1bf8a2db ("vfio: selftests: Extend container/iommufd setup for passing vf_token")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> 
> I would either like to land this in 7.2-rcN (ideally rc2 or rc3), or take it
> through the KVM x86 tree for 7.3, as it's blocking a KVM selftest[*] that's
> been in the works for more than a year.  I can throw the IRQ selftest in its
> own topic branch, so even 7.2-rc5 would be "fine", but I would much prefer to
> get this (or an equivalent fix) into Linus' tree sooner than later.
> 
> [*] https://lore.kernel.org/all/20260626213534.3866178-1-seanjc@google.com

Sounds good to me. Alex can we take this in one of the next RCs?
