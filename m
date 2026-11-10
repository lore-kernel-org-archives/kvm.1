Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330446;
	b=fSmve1k9V1KriqBneQTVE6UCXxUUjlbKR2IxLj669fDlwVZcj3iC5Ww8YrxbJfLmeLJ1
	 BeAPHh+NU45tyNumvgH6hwa7M9xx4lwAuv+h0mw+D5bQSK3/HE7StIGrWjHusZo/iU7Xo
	 5K7pLIX1izkjliCK48PyGO6t16ZTCQFKTjOZedwJZOpsrK4dXnhZX3Q69gSsUou3f4WXW
	 TSf/gz9G0KP1hgA8YyMfEl1jaMmvrZ0pt8NqESrD61cHGsVCzfFXBwKGxy/mQ/e9s4SRZ
	 21MPa7ZbsJPVYMWRc3KreEIiHDvtVgzspIY5ptxE6rqTGK5I3Q3cS1KaZEkhdIGljFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
	b=rcGkiJ5B1V56MKXNVcwcrszgovJsMjkvZyt5n52rgfElNffYXVvYuuSp7adoN5HP3fiZ
	 zIoekpjvHjwVJMrUpJ0zob7sZIaX3BCS0KlmZW9cFCN+KzbIBtYLp8VyHhqh2QNYYNSgH
	 V7eitmVMjBRj14ad+p35qd/TehlKEYj5iuFZBh6vnpjwZK8mMGJtLPzrUR/ZGSoIbouRO
	 Um3A6NnsGJju+uAybpXLezy//NPDHtZpbcyPTvMV5r/5jgt8dj3jQ33EXgMvq+ZKc1rtP
	 fsxqswh6TAWyKewx8bTDRaVWLBQXCNHZ58LW4E6zRbf6Ixlh/E6E2xCRk/20yB1UZYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE9606A321
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBE9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1087608a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330445; x=1794935245; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=UVKcRwO3ejBDMk8klGa0pwyOX8V3E2o9Z5FDLbNmULmLkseoQWo3Lqy0OuNTv0i92Q
         ZjjYVo9KXE2zdYV53r0tp3tj121+8xjU74d8CsPd7T/ezb0GS32Oj0pnMKjoXKzmgYz1
         O+RYemVJ0UhckajWqJT6SbFntkibstlz/QpbrXg/A4Q20wwQ7hX+udbRjaT+kVWhERei
         LVTIfg/qTgjrELa088mLnh8eLDqBIePCWGGCjuCCKFA4k1sI0K7OyO7Ju718M6mBSoNU
         6TYqsOoIMH6yBuYtZwE0TFkjVgzg3JMY1p5vlkSwdwLpdJ4u9Z3VALtaIzkru9F3/ruI
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330445; x=1794935245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=FsZMUqIQykaPoDMnPwnjPsf+uJRb25MD2epQ3KatiqDgIV8hAXWdDzz73ws/Emd8Cd
         tZ7I8lQYtrf40vCnK4BvWBcbydhqmRpwZxZ7CSdn6c5+ZY1MuJDHTnt6Pc8uVjQlNbeZ
         3JUXwiURRImp/slSOnc8bs2fFTPwgCWnyB/+U6Y4Eo6IkMdcn56nbVRVWD5OvDh3tiwm
         QuG8CNVnokDt8rEcaY01pSJZ0GGoZKbxWTMsSxa3g4be7EDSLbANnUm9inmMyc1ACDg/
         95masTp2IKqGpWofEnGB1PImWdmEjDUVQACocvnW8LvouvkFjIZj0oOcI3pf/yVoo+gi
         Na8Q==
X-Forwarded-Encrypted: i=1; AL+hErEBJM3xwbLUWU2wHESwHgQdBAcag0rlczYYb42v0i9qf89vAvahl6dwWolwY/bG5nUh2xg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xXMhGE3/eGiRys6cKnknk7ULV22vlyFI5t1gVhkzgp3v4J1bP
	S+AicUnlfwkTSE/jMDmXlNB2ADmVtVNvDQD/2vGOw/GssDVJRUXRLQ8hce4Nb1aFzw==
X-Gm-Gg: AYBFou1UQ3qLsj5HjW7vEsmbzvavqb2TW1C467Rsp7W1e2vVHGUhR6zxaJ0YT/PUl/0
	YUbII8wXqpA15gLvlLU88rGPqD0rP3WfoVEnLd05R+mrudMozO7+NfKBpY0VpiT3qN2oBUlcLg2
	e5211BwI1sGITrb0mAOrgRxxvZ9DnNcF7sNAw4GhiqeeEIUCzVxxiWhQNu/zQQhqXsRKFNOZLlD
	1TrMjJZGn8ujQbzyhlPrcezPv+H1U1EfKWYadPYfFasltj3fqKEaylNpee9LTvTtPLSBV0TnqU/
	4psbEH72kLhxKPz8T/wHsNa80vYneO0dPWGRubmXTLgq84LX3fwX2laW3o5pFA6+xPFcORX2aab
	xHYhBatRfLkw2jN2eTxu6NRZdxvpi0DS5WCpfxEMc8e2ZZ73fJFhzemL4zIewBzKtWuaDQ8NDvL
	TnOauQaigFz1/5MWaJe8Ps+yImHXHlF94iUkDHCWD1+dQW6t1VrpefNhFZfknomZRFzGQXbvmNs
	XsPnkrNb6XjbMJXLZF+PP+hWyENW0LyN1p/0Q9cKlalTMj7yfH8tNgE/HUlOkQmgQVW40iGIc/h
	qq4BaHKTRWjRPLokLtk1TvOmNO6xXScKmisZ7+X/YlQJXCnfLVqQR8uFwW9b9+PA
X-Received: by 2002:a17:90a:e7c1:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b166cdb54amr3659496a91.46.1794330444574;
        Tue, 10 Nov 2026 09:07:24 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm499973a91.8.2026.11.10.09.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:07:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:07:22 +0000
Message-Id: <DMRP21FATCC0.ARAURXWV85JP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-9-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.

This adds a feature header to every block in the set, but the layout it
describes is a property of the whole set: all blocks are written by the
same kernel with the same header.

Blocks are only ever added and removed at the tail, so the head block
is stable for the lifetime of the set. I'd put a single set-wide
header in the first block only, e.g. a struct kho_block_set_ser with
its own feature header, and keep the per-block header to next and
count.

entry_size (added in patch 2) is another set-wide property that belongs
there. All blocks in a set have the same entry size, so recording it in
every block is redundant, and restore has to check that the copies
agree.

[...]

>  		entry_size =3D ser->entry_size;
>  		bs->entry_size =3D entry_size;
> -		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>  		bs->count_per_block =3D capacity;

Nothing checks that the blocks agree. Each block's entries start at its
own fhdr->size, and count_per_block ends up being whatever the last
block implies. With a single set-wide header this can't happen.
