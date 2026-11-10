Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323545;
	b=pLzMOLya1EU7WQdNSaBbqINvAlPkHFb/CbRvH27eYGk+n/4nNShFO0/ucoNDZ8KNigku
	 LijKoOvblK4BqUxDDt7iNeqN04JW3XbrL3NgNHIq86ROnrka/PeYc4u8oABqH4lpec8dH
	 Zy7U5omuNZ1xBvy4izWKZOP6RcNWbkLXMfEL20P2+dgxvqWuu9cwswIGnBiefPBxxdjXt
	 UTpWeuaEsFp2zb+/s1O6EoCB5BcTf34zgyc+tKSRt1gWy4OHfUpBGQkg/DPR1n3AZ5pGt
	 DIvpkJqeIuzHP8bStFXUES3/+ByitIdlPmNuADa9JhsbqZ2g8EtQuFOidL8dX9XaMHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
	b=X7eQvJKwrmx/O0nJV90jq/5YIzL+UrBFpG2UHEB1dwAgMpR51KHFr9JaeJqPSoltMVLK
	 Nz/YrtrkGii64Lr+maevexxAY+a29olA9LqEXXx+TbG5PX2af9aIG8y3V5JlXAnTqxgaF
	 iZzwtLtJS2Wu0VZPywBb2sDOYy2OAaXIGJEDRgb5KGk1ybIE4Vy6dIMbLchSYo5i58G6O
	 ZbB86UcAoJhhTiGbeBDDJ45lGyEzJ+XtrDu3hFHsWcxB2mtvW7z4V8eg1ujyRT4DnuDII
	 iOA7HF5hUaLl+In9Il5f9UV3zuVd7yU9xx7UHDAbfub5rCcs3/npl88BS49SLXPW+4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="YOUBG/UJ";
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6460A2608
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC6460A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YOUBG/UJ
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso744063e0c.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323544; x=1794928344; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=YOUBG/UJDUN4UyxvkhIoLhefkcKvcqtCc43YY9icyFLipWGwJr4yRhoF61ai04yb3G
         /3oA/YdYUik8WvsHFnI3gFCqTxtjsY0R+rgJT3k6h2A7QoXojCu8iohoASLyE0xrRsG6
         r77coPHPIo9sHj3xb1YOG5IhOJKV9qF8R6gyeeM54RzrM2UnL6uNga7Md3t05uiI9v6o
         5KldDRCzbIk9P4MYLEtb+lU5m6ZqVMMuwQ4336EDEh3PepvHzOcgNGzJe9mzOCIKRb4w
         P2iFaU19sefu/7GQ+UIx4MnWmqodZKnGvXovtykItH/b2HiCw11TEk6EiCg3vu0DA4qv
         p42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323544; x=1794928344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=laXcGQzEKGMH9hekjdMzdx+Sajcb7N1nWLXHKUod+kiMnAb2m0R0cNKQ95IG/HURAL
         qaYwE/gwEWPMPdM0QXadNYgC0b4zx7imTUbV6k3jxGSgLrsikvQqIcIcezXfdcPz7/3m
         UWkv9u2yCWNQy2XnZo2tF4D9EE4X1fI3a/wpEvZsQeiTDrnPdXd/XfXzyHy/luF0La3O
         gYe3dQzwHK4T23IND+ODtFXr2tIGEDMEoy02SXhq0PVN6O1BX07Tv6Z2LbolJ14Q1Awg
         rZaciicSgwFTlWoNAbFvU8eFg+ORFjcwnE38E+VOOZ7Y1eXQqupGAbicfwcwq42b9jwm
         kkXg==
X-Forwarded-Encrypted: i=1; AL+hErH/bvzkCdO17q+8UviomiD33FyghcWVB9yl5qWUWjx8r1yQ6tTxDnGEvBx1EOasbC6qUtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cgJPcbxKhtoZrLe/Pl4BUJJ71sMgbkYOobtW3L31xuqW173nY
	X1zOvYAtL30U3KnpqXA8t/fUlnIkZpefKyv1ZCwnzv3Pl0n6efJbUHgxXXWeGeYc9og=
X-Gm-Gg: AYBFou1EqwVNOZMPUQfQG92aGbDLKgAfENOmXw9kGMBBtKVcLIb4ogb5YQgzngG+PIc
	N/ebQhXi6w/hthk2G4hk1nTUHr0+QxkLSVyzGMLXhEhgbXR2ZeU0xN7tBt1M4bKmZAIH7XCm6iz
	vJkLWKi0zXEWaqiLdA2SGTW30greQg08uIajku70mNfqeYA34bwg43Jum1Nbh4cp1HJObek/FGr
	Hz3/COs/NjZobR6Eqd2O0TGL7NYwr2HTGY0fApgi5sB164D7mwKfLpgdC3D+KxdE2j28utnWUqM
	6KeimstlaMFr7m2IvTsB6gt8cqRVkawOJnp9tPiph+bsUl9tRdAUZIQPVPSeR2dWh6PI6K8yw9D
	DRffDbYX6EkVhDXNPo64YxKDsQY4otrcxsDWkGgLY0w7uIiVvERyTEq3x/j3j3XgvJjQ4QNhESl
	KExSLdWqz4CmsTeGPYNsUID5ocVLnZnND1lqIR3huBBlxRdPjmVjsYinf+eWVtEtGb/tQ9vT5BK
	XiWYHQdpMo5LO+f9pXTBRwfYoxMsHcjhzI8BbJq8pUfqY+IpwplrIS+s02QAM7T3mLfG26tdCgT
	4beuMeVvhFVC/BILm7ygv3PjdNau7lF493J94XLZw8No4j/Z4aOxo/fgG495ls5PQ5JyZtir/kt
	xPU4NxldO1WjAIn2fLQYt0qlLY3Tt
X-Received: by 2002:a05:6122:5313:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee0d0cd07bmr947867e0c.10.1794323544266;
        Tue, 10 Nov 2026 07:12:24 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm2039560e0c.2.2026.11.10.07.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:12:23 -0800 (PST)
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
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-Id: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:

> +/**
> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
> + * @name:         Structure tag name (e.g. luo_ser).
> + * @payload_size: Compile-time expected size of struct @name in bytes.
> + * @nr_required:  Total number of defined required features.
> + * @nr_optional:  Total number of defined optional features.
> + *
> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LU=
O are
> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
> + */
> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      sizeof(struct name) =3D=3D (payload_size),		\
> +		      "struct " #name " size mismatch");		\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      __alignof__(struct name) =3D=3D 8,			\
> +		      "struct " #name " must be 8-byte aligned");	\
> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\

Remove this extern.

> +	enum {								\
> +		__KHO_SER_SIZE_##name =3D (payload_size),			\
> +		__KHO_SER_NR_REQUIRED_##name =3D (nr_required),		\
> +		__KHO_SER_NR_OPTIONAL_##name =3D (nr_optional),		\
> +	}
> +
> +/**
> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or pa=
rameter.
> + * @name: Structure tag name registered with DECLARE_KHO_SER().
> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER=
_PTR).
> + *
> + * Declares @decl with type struct kho_ser_hdr while checking at compile=
 time
> + * that @name was registered with DECLARE_KHO_SER(), documenting which
> + * serialized payload structure a feature header pointer belongs to.
> + */
> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) dec=
l

Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.

--=20
Pasha

