Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECC4052A5
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792106209; cv=pass; b=aAhQnw5a4eHCUDTdqqKDz7wYZs7Lb9rKhZQ4uMBpQ6Q2WBGyWLcVQ0nP1y4BAQtoMAY1siKYfbq5EN/SBMUmdbUwUvCO26eZQg/pYkjHSEPGfXhVxHS6G2ryDln8L38bqVIN6+Lnd0DVxcmuviR89Qjo+kQhSXVN2cSJxCqH3wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792106209; c=relaxed/simple;
	bh=uXzkqKblq6fQvGu8ml3Oo6m6nVdHmv3RtEL3U0hTe/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNvxxC5t1YukpJMEsX5/H+nkYWGSYusF7dtfbCaw2HHmapuo1GGqkweqmROerzVOLnMdy0A2Avw/swFLviGR5yvuKLZS1f4XOkxphQgj3RBjb6b9jCUYhpGf+M1nywvCFxYTKA7k+kTClbgXgQrzM9fYn1Na4eJvPKTZvL4A1hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtS6bpoI; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtS6bpoI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso4882a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792106206; cv=none;
        d=google.com; s=arc-20260327;
        b=miCVDpMUC4I/GGWicwAVPVPi5TiDBPEUtykBVQUoesG33+nSmzQ+Um29AjLSpVNOiI
         bjfXxHLUXYHdOS+bm0v2avtx+bNb9tFd6inQNoa5ugoD11uOd+iVl1IiytApJM3bcl3p
         cnEqb6AXbWdVeh6T3RZQLB2MHYm39LnZRZU/gC2UloZHLcBz5HDnzZCC7C4VitFHVtSg
         0p2oYuKH3rDep83KVtfwvfPPnQcT7vBjtBYptp+OaAFDdGAOF5IHtzhcyTcRQp2CTw21
         J0IxNXK6VFoE9V0qtf10qnlMVh0qogJpFTcYUG3BaEqgPV3NmtSEcINvAxodgHmWhySj
         8uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXzkqKblq6fQvGu8ml3Oo6m6nVdHmv3RtEL3U0hTe/o=;
        fh=bDvri2rw3fFbuZIL0rZTkVEOGRyxRKQyeHEL8XL5mhI=;
        b=FMEeJ2M5X+bEgWS3YaG+QxtvTHvEUmHBivsXw2L8drsWmDGv0teMahUExc7NA21XuY
         o5gsZ8gi8wYFIuraj3M5kj4FClNdWETfkZdOlvg8Nz9SFOUj3X6DsswBnDid7dtfCy/v
         84iAelZyQUNQZ1Vof69gX/QBFJ7Gag+TtV4htXQG6LNaaGjWSKJ2m4kafEL9bEUHnhpG
         OD1sMMYc7ucd1SpWPZoOrwYxNJYO+L1mkjGiZ2zLxXMtHZFGgudU04rX95fmfjB0LBhF
         ALMMEyvfBVxZgEkxWTTCyWHSXtqZwijQtVDyis2Dml5oQv5Yodlx5v+jdgY3Vq2REUVH
         6OvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792106206; x=1792711006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXzkqKblq6fQvGu8ml3Oo6m6nVdHmv3RtEL3U0hTe/o=;
        b=JtS6bpoIGPX8r9KkU121Dx3KXEtRitrM9eVcCnhD6vEVlt0Q43Fu5CfhMBEfPY1LfM
         VFxcqJ2v06EOr0E+nnbhgllJFiume4onIgZTfZKuW1Zer1fj6wujqMdWWAkxeDeCmMNj
         W6rOEbqdJ5PjzN19pnipmez998FpHkrMB6G4tpoG6G6ejRL4sPbXNhf0FslcN1cXywcW
         ikewGDPAMd7587dq0f6MAAej3bvy0+mTUj9rIOpCA+OpeDC+vnJHji9A0uC4pNqgyjap
         mwMG08iSoKotX14BLzjxizXt9LpzHymD+9kDfdMfGv0dTjaatQ11ndd0rDD/m8GBWRQ7
         ehWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792106206; x=1792711006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXzkqKblq6fQvGu8ml3Oo6m6nVdHmv3RtEL3U0hTe/o=;
        b=php0lqf0Y8opRMfTXVp+oFoOsC2vL6n2SGJsLylkBO7BuQxhrp7B7o1ceugLL/NW8a
         6phKbxL2gHFpIt/IVjtWFtNj/3dbLOPAid7gXzgb6ZsS9t2Z5ZTFyt9YLuFV+HqrZWmR
         plndU9gQbvYxi8rzG/8Jp+nwXp+Hh3ybOqaXqjZnkneHfIjWxcUFm7g7JULLrDIimCXu
         817J8DHJhbb7Bf8sc8SPh/oahJx7nLWUKWlGeN714gx6u+yDzMDdSXl+L9FPFfgk5rLB
         I20Yq6mj0UDFtkCAGZ2nX/y7Ik3RmdjegdvcbjRkRuj/h9HSEns9WQbdY5Xd5eHC4fai
         696Q==
X-Forwarded-Encrypted: i=1; AKwUvByMBQyACK7EIqB4idNbfffloIn18lfTYyVKAolMUtORP7NMwaOpWY6q1ru1y3qOibzX/DA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKojR6OvaYknRkLxxY3Hjmr7aY1dzxyjZv7LeO64+gdvZbFFXp
	RGv44MvBkDHIWFxr/8n1rCnxQS8VG1b1D6idCvbayZNDe1mOV4xJCJGJuF9vIEl1F1eVrK75Q1x
	oeoAgEViXBU+iWlc2ZwsF5jktHCyzHMrq6+RlZ0Ir
X-Gm-Gg: AYBFou0ICiAGLAoUsXjmBD3jfSLREwuvjgSpDRlTRe2yGX/uG3WeuuLXakFjQ+LuHXV
	AA/KabcZUtPCQOmZPebCdjX2CXqWwLAe2zl421naxUP4jKCo167o03W1v3S4muBdV5amXYwcKKl
	5Ld71gvIJLwICz5KDgUnYV1isKNi3vzN2xG0xeWFlPcjtpPv+97NSCrAvAQcW+n3Er0yAUH+y3M
	oPMk3/oliHPsjoYzhX2VwRiZ4yr/FHtAy6rrWkdLjyNaQeCU4gVre5P1yx1kzGPApr1jmZKJtum
	dCksfM1UjtQBomZq7GSYJCNGIijy+HF+cWbYIjQ9uPVUH+zThuNiPno=
X-Received: by 2002:aa7:d58b:0:b0:6ac:bd5c:9e2e with SMTP id
 4fb4d7f45d1cf-6b38ba0eff6mr15062a12.6.1792106205772; Thu, 15 Oct 2026
 16:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-24-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-24-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 16:16:33 -0700
X-Gm-Features: AclHuK9-OldzijEU45y2UUwduzs8NSJRwL3OgHFCmTXDYRVo0XnREasyo8UAXGI
Message-ID: <CALMp9eSZkbSEMkrbFDsWU962AuLVMMe-Uo_gesqrU7Nb_V+ezA@mail.gmail.com>
Subject: Re: [PATCH v3 23/27] KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on
 nested VM-Enter
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Stop clearing TLB_CONTROL when preparing the control area of vmcb02, as
> this potentially undoes pending TLB flushes for L2 (e.g. through
> KVM_REQ_TLB_FLUSH while L1 is running), and remove the associated TODO
> comment.
>
> This is currently harmless, because nested_svm_entry_tlb_flush() always
> requests KVM_REQ_TLB_FLUSH_CURRENT on nested VM-Enter, which sets
> TLB_CONTROL again before L2 is actually run. However, always flushing
> will soon go away with proper TLB handling for L2, at which point always
> clearing TLB_CONTROL would be a bug.
>
> Clearing TLB_CONTROL on nested VM-Enter was probably done because
> TLB_CONTROL is not cleared by the CPU on VM-Exit. However, KVM always
> clears TLB_CONTROL in the active VMCB after a successful VMRUN. Hence,
> at nested VM-Enter, TLB_CONTROL in vmcb02 can only be non-zero if a TLB
> flush is queued for L2 while L1 is running (i.e. KVM_REQ_TLB_FLUSH), and

Nit: s/i.e./e.g./

> that should never be ignored.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
