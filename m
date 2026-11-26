Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706171;
	b=DlYtObPssF+9fnR2/lMDKAB7iiTuqW2ZXYYkKx3PPeZlsy8ktxFjjaoL432+VZNurOwM
	 wzBaL5FTMlgn/kOvkE8c50+u4mNoSf4Qk9CiM22c6Gdb1J7cnOUb1RSDdXfHnrM9BJPpZ
	 0we46f06fUvdbyNdPl4zS2/i9BjcK4HteeP2LyCpkqJg+88ePYKZhLNP71Ibdv0wfDt3U
	 G5WYA/UWDC8ge5h9vsHqyDVz9jyPvcMPkZX4MPq+R2Zh8Td4+2xajBPnvugrtSoCfu5jj
	 Q2WfMZ0WQXr0QOgQen1S3Y42orxVIh4VWfXjlhnH1otK7DhuvIOkoxcWU45H8dTA3NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
	b=m2w9Z2uFAEOK+/xvAJUGRLhc7tnDo727JfRKxmb+ALY5rDLKi2H5gTxzYCzAFN3yaKoO
	 Mw5FVThKcY1FJlZ3aU2kjZRmNfymtc5FNQT6nOaVxMGeuxU/8JP36SVNHLvxkEgym98Mn
	 znE9VXFGfSGDVQv7cqUDy04enjGMetOm5Y7jVrLKfkNfeq2smyKl3Z+r95teqPo+hLI83
	 +MGwy0aonByvnLL9BpueiHzeo4xuXL26GKs1HwffJokqHRlm8XLb4nqlYs4mnWbmzneSA
	 4ZYqZqN23Dg7cDJvhraNZ0dHB+h+CCQ4KDzeWYf6ofmvL2sWnxtWCKh973/3HyR5LNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GhoTT+3h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE547606A331
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE547606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GhoTT+3h
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso71116505e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 07:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706169; cv=none;
        d=google.com; s=arc-20260327;
        b=c07H8vwz++bsp4TgQ6fu05ZxDB8fxmD0V5hLYd4PCeseHxSlDf23D5MKwhewkGXAu1
         08w7DKLlc7bhZzlb8SS/4GTMjAUjusaNslQPqo/ZOycqFK1WJZ7oV4A9SNqgL6eD+LD0
         C6iBh4NWGfTv8wsWd+1gMMNHookXvzXCmksUqgIUD9k1mEL5CV5Ka7cnOTikqcZM7Oit
         b4xwHoLeYlu7sp1Esx2KpYwrslGYFkfk0bAcm8ori1yIbK0JYLOBN+euKS2BGbv7tluh
         Bh0KWZKxKirlDSUkrjWiqtmm8Snw6BWTB8YbwUIya75q/IvF4ApT7bm6hNW3IhzJRdMd
         t9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        fh=GqDGhBWmP5aGbwwaksUk7LBheCHc0CTBTPuWK7WCsUM=;
        b=lkH95m6RQTtpChTv6eyC0ImtS9G9wLUUUpVoFPE44aErqa2IX4//NHScba2xwLsG6P
         F0M5RTHUj4Nytio4AE1nKQTRDrOKVWXSRete8i6ACydgEFEsfMtVFdJaI5p3aJ6DzPHa
         9IX0hMG6v2IuxRKr7S0vuk6iJYOrxjA9r9ioHPXiyTfbPt4ChgWk4ZtMxr+808uQOw5K
         Y0CZoj592pa3hN+HUIe9bxi3SlKN37/vmlyJrjZZVCpWjqmlCKzZrXrfg9rFR52RXhe2
         KdivwjUPNk9Zaku2TJTPmLuttna1KTWoXBpuk/i9syhhCsy0zjs0PDwWoUA9GfpJYU2E
         +ooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795706169; x=1796310969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        b=GhoTT+3hqhyTVwyAIWWrKhhvS3ulJ3gnLZmpoO8ekmItLfPnswvDvTb1d9fxSE6ODK
         qbifDHjnqj1LYSaKPeFKR/bKkcyOsXV9khDMPqKx8EhATt2qmZ+UAUJfF1Aw/JaA/+fh
         HcgqFxa26KkfxEzmerkJAymeRBm4huWFkkX1T6fnTZae8pq5GCUe/dt5h6QgmU2uxKTE
         USj8hNiuIfDuRFhTHvfAzTq9iJ8CPvgDkIQzlE4J5lOYX/YWKbNikkf+iDWCn/EuWI9s
         H71z0k9M1ab2zlQOVd/hiwXjMpT83N0jDbdgVatlCoMUYfjwt+5tyY+dw5mrugVQeRli
         R9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706169; x=1796310969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        b=U15bvqMVfnMh1KcA+8cCpieaqxWqFb4SGK8TWXIQwpfrCMeQnO1Yi7Jw6Mgrra8h6V
         srDKeG17Avmo6YG94rfCYaAvIUk28dtD1pqfXmzbInLomzf0ZAROhCQlHtiaOUJuNTJC
         qmeeJeQUvtwva6b7/c7Ua2FzLqJrlVq4TKEJdsNqPbLaWwFuB7QMbMar0boST5veLXuA
         2JmX/DbTx8RMnHP+mTQtmnj91gkOPdC3LeQnQOSlBGMuJeMrJXFfh2hqJa1txDAMBM/E
         3S2EbvF0vUhfWeAq7ZXKwRuNr7yGooivj+QGpNyoJX0IkfZJj1Qw9iuwI3My5WJCE5ot
         nBlQ==
X-Forwarded-Encrypted: i=1; AL+hErGKHMiKHPnyoFR+z9x2PEPR2Fo59hdpSigeCUc8suhqUka1A5GjgDg0d46zEYCTAh1EjSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1TE7CVKb0Q+lxLSh40bY6Kunus/DJmTOBWgxDxER0rOzBsQtE
	Vf2IMv6b2qvGGI5l3gfvooOi6AebpIEBAXrztZL9hwAjL+AId3EStltn/bBvhyWKCK2zuEjDOvA
	/N8NnqcM50CKt70OaXZ8+Tq8r2NlxcxVttRo74U9M
X-Gm-Gg: AZFdTZdFXo9PYCIVFT+8ZJUHrxmdg4j5XpPBPM+BT8o2VeRb+c9SqIY+nNvrMNWhq4z
	8z8ooFknPORWaS+c8AaRsD44DK14oEa86o2tikUW+X/raLq+WZLRrWWTxlZQW8ZBFqDSp96P8sL
	E2MEmDpfkMoOyna5Q809SwkOhYP3hiX2ccQ5WO26BK53P7/NQxfcFOaKeCN42KEkkeflEn7BCpe
	9numrR4pXKTqXRsXRfLAzugOfXAYsE+JoCKyRJHM/jSo0StGPkGi3+rgXFuj+ECHb0K8a0TlCgm
	lHrfyAuqd2xiZLDt4N0ccInAoUqc7CVBGxsopdL+BJ8CO8Q4qFxHOHNNgap8MDkDrtQIZC0ur44
	389+f8cAZz5EtS9pUrve/lZVKHUAyYnd9x3qD6pELKb8ZvpqN4nIiBw+HvpPagTV6hWJLvDsGE/
	jHILQxRAg9lbVQWlF0ayPQ3+XTWpZN5Z/aH/xrNIi9KsBT
X-Received: by 2002:a05:600c:16c9:b0:4bb:7ad9:311d with SMTP id
 5b1f17b1804b1-4bb861692a1mr332818735e9.19.1795706168571; Thu, 26 Nov 2026
 07:16:08 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119215046.2892839-1-xinmengs@nvidia.com> <20261119215046.2892839-8-xinmengs@nvidia.com>
 <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
In-Reply-To: <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Nov 2026 15:15:56 +0000
X-Gm-Features: Aa3M54o7yVaAHH6adwEWSabFuYapgO-QYKd3fskOtzrfMLGKtESTl7nq44reziM
Message-ID: <CAH5fLggYpTiLKDXMQ9UYBGZ9VuZBWbNfCZn9fs=i82-xf6A-1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: Simon Song <xinmengs@nvidia.com>, acourbot@nvidia.com, kvm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
	linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com, 
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, 
	kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org, 
	zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev, 
	jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org, 
	dri-devel@lists.freedesktop.org, peter@colberg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 11:51=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:

I suspect Mapping<'a> should wrap a VmaNew instead of VmaRef.

Alice
