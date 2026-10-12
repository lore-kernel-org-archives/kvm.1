Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB14A485B
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820136; cv=none; b=a1y3ZjHq4sRkg8EVBt7k2IpsvB+IxmuwIg43TH3Ow0sSKXAvLdoo5wO1wYEbA+do2rPA6sSW4x/oF9foU2EqQpMBfolR2V45HvEUK5et/fb9HXwaFHdZwBN5hVunQWa/2XAelOYLpGikUj2dO5vRdD3Orfo64hJYwzwmwoMS1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820136; c=relaxed/simple;
	bh=IBQngc9E6IMptShoUCo5yKbFcmdbP8vVNx4ur1yYVnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwOuBDMR2TsSNxvy4xVJ/YXQXg+B2zKZEbhX6bUCW9WyuHxwKE3bcxoucVwkrzEM0DwK1iYb7XILfqjsbznZEBUxpM+pum/oOlG18adVZ2SjmZx0RIrRn/H3s5QRi55qjJe/VV0sC4PkG5ZJvI+NhLS7dHbNuI4TNTdqy5VF4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTOZbUeL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTOZbUeL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso9684695e9.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820133; x=1792424933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=YTOZbUeLKKbxksGFl3X9SRUSILmTkpQbdG3/S2suV36u4ulO3yQ/CwHt61806PNp5E
         ow1LIvzCLHvBVYVWmAmeQ1RiutgtMpmbxUDWdEjr6PFBU1zADRngD4F+c+O7y6MZhm/3
         OItOxC8zgX+czXK6nwSGzK6l1xcFKyZeSAWPwH8q57IlU999l80A21QlkgPoZSEjYEnn
         NiKCYOISk2rKQl2PIGpBTQvP7cCSXCSckUsWWFfSd9auGOrmLG9yxlXBvUZyDmZcMNOU
         VLDRbI6HZj7h66MzgD/3RF7W5NxrdXdj8IQCBfXNj9fscpFDo3QVJL+Bbcu8DwuKHmVw
         CdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820133; x=1792424933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=FdZ99QalZhR1vzMofvFlfKcdu8yjpJmANuTUhNXOAEwMGoOrhrBb5eFHTNd720v+fg
         I+RsplH+y2EzRGr9cW+Rh17viTZLMcjfihnMHUe9nxFbctviNznn9vwbQn2SDU8VVWtS
         FZSZwGPNedIYSrlxRpot/Tm/Xm2rwWiV8ggFXYTJDz2iZmByUodZ8DGrcqfw4i1hIu+L
         C9BbbDBjARphiVIM+6EggogSys8Ky3jkHQ2BH1KA0vNmu8b8rnyhTUijtdTRev6t3gwd
         RD60p6IG/zn73xAaCd0zz2NbGzTcmGvNuDOC0orPJzRItoHQ+G0ldk4z8J1jSSOO0fQG
         VC/w==
X-Forwarded-Encrypted: i=1; AKwUvBxt96Pj4i5AD9OJKw8sWRi5O9uybYg1KaOaeZHUQ6yQYSVyC5uyrUzIfkqkoTdDF9WCnwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYItFtfAfsjcXiXShnfG5QLL5q300J02kfjVoM4fDueCQgp4nwvh
	Wa+4O5hHTOAEh99y9zmHnp2GN3t171lcB5oMrOQ7Utb1xnHnUyRcM4wA
X-Gm-Gg: AYBFou25eVoDRPmIZ9QxTruQBn+sEXR3cCcLymCYDGFCvXG+sPtaNZsbBXZ2w8wzkTJ
	heFcSXBOeK+2tEbrfnE29e4N989WPc6po9lzweYVoR7f2OtLDaY2zclUHqnFAloo76ZlShuKu8j
	bXqwb42zi8Z95HzdSgb0/nLAjVCpGSS4anWf8RVxs3pRgJp+RJPRvVFDpn4IJ7qhhe3CoSZuped
	q4HL3M1YtCzai1AqkGyQa8lJHLBMKDfo8BzI0eXGR2IFEgqnBY4QNj2wFnfjL3kIwDfLdF+5Tuw
	ExUDLm/tFljdnQZ3/Sob1GBAzkwwmYLlX1Ij91Kk6tTocLr+3xkRq7BTfbZxhNPBE6urGT5sPmr
	JIe3/q4s/0cVBCvLxHkB1kvAlSFfixs6qaa9KjgfBWfFn7IRgLsOcHUf7quQn9FrZUM6QBhJb7o
	UvppU92MW/PWhPpE0jeBS5QZeYxCZoBYjkjN+Yzbd8WydO6GTtoRwHVlMm9HqjKduSrwvcT7GvL
	FCmAcpeU9vC/OAoS0n3LUVTVS86RuRDgb+5nJkx4Tj9klSlDkA0Dm17Jp4bKYr9eVqeJ4kjm3in
	8nyzA+UARzzlCMQg5JNvx0HyNo1NL5iOP7U=
X-Received: by 2002:a05:600c:699b:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a18e4af334mr195124235e9.33.1791820132890;
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a193f2c992sm210228205e9.5.2026.10.12.08.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
Date: Mon, 12 Oct 2026 15:48:50 +0000
Message-ID: <20261012154850.96716-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com> <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com> <20261012150715.25132-1-griffoul@gmail.com> <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2026-10-12 at 16:13 +0100, David Woodhouse wrote:
> On Mon, 2026-10-12 at 15:07 +0000, Fred Griffoul wrote:
> >  Devices are different, because a device may not support
> > faults. So the provider also revokes the range on the target once it
> > owns the frames, and iommufd maps them right away. In other words, a
> > revoke means that the frames behind a range changed, whether they went
> > away or arrived.
>
> That would map to the IOMMUFD 'REPLACE' operation that hitlessly
> replaces a PTE, but does anyone actually need that?

No, not on the target. Before the move the child has nothing mapped
in that range, so when the frames arrive iommufd just maps them. That
is a plain map, not a REPLACE.

> As I said, assume that the "crappy devices can't take faults and need a
> scratch patch" issue is dealt with *elsewhere* and not relevant to the
> guest_memfd/memprovider work. That's purely a quirk on a given IOAS
> within iommufd.

Agreed. The replace is only needed on the source, where the frames go
away and a device that cannot fault must see the scratch page instead.
With that quirk on the IOAS, iommufd does it, and the provider does not
need to know about it.

Thanks,
Fred
