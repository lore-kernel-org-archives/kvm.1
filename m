Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E674C0406
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202332; cv=pass; b=R2vg9eIxUxppu/5nAyVSlLb2hgjSUXzO0muhQPGdBW+TPqDKJzjRDWtxHfq03uo2S6McFv7PH0WMR+HM7aK+maSPCoOr/8RICcA934odgk9jM8MDUlQockhKeS3sOdq2OiHniPEH3B0GDHKAXkylpaTnBqSWKIHXubn9KoHkAlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202332; c=relaxed/simple;
	bh=9KXgna/nwfEIF7S1Yx4SAsalr5XgJDJshnViSXgFlJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmmrvoVMe6LUKJFOssimb2sjIg4Fqh3JIENvmbaWpGs9Jb88lNrL9h7eNQkuH02tM8EY0udzNRT8sZvhySiMAJsA0zLbzYWACp2Puv0qyhteoZFzl3+aVgn1koi2z5DZG4wcUH8F2sbCHj2ifm3PTa5wMzb4pODURMnAnKeOZjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qttur0NS; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qttur0NS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5177d1ff061so57781cf.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 11:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781202328; cv=none;
        d=google.com; s=arc-20240605;
        b=EQu+As4zdg/zsXq9g5jfNIvarYKZZzBQJJA8yR3hzvuyRNiyADlNyw3scPU6ftT8TT
         hiO8L051igI2J3OTHGvjDnXqDB6QhgIhuMcJGaKVYBEVEvaZV8awwqWC5v/SPT2CuGnb
         X8ESpMdyYjINsXMwtVHatLIEdMYkJhMHrJ6AMy8UlI//5y9UIjuBzi2SH7V5yIdCVM8g
         FKc3D6Ym87xwsk2BHJZNxwIdVcwzdSamsMsV1AqJqvMzm73/e12LNsloHzM4iKIwr+BC
         6SOzDPRIzgDvVLLaiH1WDXSDLtUEKbF5XPmlB2pLFmnzxdNxajxpSW7LrDKlgcegNgqU
         uGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KXgna/nwfEIF7S1Yx4SAsalr5XgJDJshnViSXgFlJs=;
        fh=FUJgSJ53MVxrw1Mj9RxSGKPj0e4Col5YyUytED5eBaQ=;
        b=cSEnu9xk4Bv3i7e6WI9DDeJcCU3Kawba0NmYE9Rxl/II7QrgZSfpZNnzVS1ZmRE1mx
         algVAXHFRJYOCOLmdz8P3IeOxtvUKvEgHHnRA+yv2z+uajfGsM8iUx+RRNh9gNP7SBfD
         DCRaMN7LgEUM6EUq+SxcQdui907APmXgmgi6/yXlQUESvwn8WfDbG/GEt4dikGsCjFlO
         bmTMoKyYBB87eETe3LEPj38xgq58GUSVTv830MG4z+R341nGiWymg3rBgeD7ZK1Oed6g
         6sNI9E7NHd0Hq2CcUR2yN1BHOTpRXAzOtKXtyQVQnTKFgNco8uqkmyYHoPRaMxZWK96e
         wgfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781202328; x=1781807128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KXgna/nwfEIF7S1Yx4SAsalr5XgJDJshnViSXgFlJs=;
        b=Qttur0NS3fFLjDE54LJqlQKOmHCQLE5fa/7eh8CWm6wDv3iVxNDzli1fOu8O3t1h2+
         w7Fq1vRhqJRhDSSR1j+glcW8B4QmefOMySSY54jp6zRPl6hsiYL9bAxB+AbDbkXGvnU8
         W9vh/ogmqw3lhRk88Ddj+SUJn1VCbDRErvL4Rej0D0NqPSk+pBMOgQgCvQCvH4Fb+rG0
         AUwi0Ar20ywO4PuqjnNwOBX+CK+fspqrWAoO6SdisgrP+AULHSBEeea6Gk8h/qZY+Occ
         BHubIU0MBv7aJssBB/I0RVhElze2cKk/vyE8xWeUsClabPX1D19PpAtBmc+0ZG+w8UJS
         tYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202328; x=1781807128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KXgna/nwfEIF7S1Yx4SAsalr5XgJDJshnViSXgFlJs=;
        b=MZeMllZqaqozM4XFSQf8G+04p5+2zjOhPK5Q4kwt7p8GisdKnwXXTqUIVT9j+0xWcU
         onfHnZRGsW20gT1HkWf3LOKJInbOp3olZlTAs7dCI1w7XCsAb5ORl/8tI8GBR7XS5e2b
         vFTnFrx6RAq8cn1VsQkXuCIyZX3Rw8iXkWVfZgLPZDK4EVc6sRfnJqQuzqZkodEIz/Jw
         ZCh6XFbf8yLXOMOM2I7LQTDqJF93p+Q5e1sRnFUz0jmZO7gBFcAahxvI4FMr7Tm9Vx5A
         Z/uYlXqYIlF0nxla+7p0YQF1yQGFWjl+WXF04kYT/fVeZwhPP3Tn7rmb1VQAc+EdPb9z
         XIog==
X-Forwarded-Encrypted: i=1; AFNElJ+xX5uK+DyvphuLz+0aPG2INWsX/54b8qBdHPlKdOYOENIA0DPPV0N3fHOIWICIiXFMMEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2H1WtwJ4BbTeBBR8cScEQ9LezqTzHrqA8a2GJ5sXAb9s/zWh9
	vMzudjY3zKC7CsZFoqex/AyQMTbOG/qk515E85UJxB7UQ5cH7p4dQtH7/biT5kzJ396WziG74y/
	5g6ID4e1jdBXxb4T28WHr+WsRc3VvEh12TSiJ7WwA
X-Gm-Gg: Acq92OE65Sn1GBpcbx4HKruQhNlroKBDv3newYpz7Us7fBEYF+SOW3FueRtIqlqeDMF
	NkIwP+aAMUWToaBhVzJMRxQnk0r+e7ljU7+r8NLBB9+qRA3Da1JF0fzVT+YWRSJhF31gZv/CPUN
	Hh3zMcob7r4neZjC2xdlh6KdM3bKv9k7VReyMmKzsIyLsKtPxKeK19ruWycYta1KAopJeyhDo2u
	m3Qi2n3NTE33snvn7Egr7s4SHDCsYgEurOGwgPone+/kze+vu5kfXkOxxMEjgiKPrDWHtsPhYiW
	W8xIAYFQAm0gFJO0HX+GqNlgnmCcLKueIsP9xyg1
X-Received: by 2002:ac8:5d16:0:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-517facbda8fmr1217551cf.0.1781202327712; Thu, 11 Jun 2026
 11:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com> <20260526023515.288829-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20260526023515.288829-2-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 11 Jun 2026 11:25:16 -0700
X-Gm-Features: AVVi8Cc_4ND7d7yx-9ajFnqcQ8evQgoIAwHtu_wkSwUVPyjfFy-YFFdjIGUufDs
Message-ID: <CAGtprH9HupUdHmLJbxk0QL=8bQ0kKNw=j_-fpvfAKTf=x7izgw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> For each memory region that the TDX module might use (called TDMR), three
> separate traditional PAMT allocations are needed. One for each supported
> page size (1GB, 2MB, 4KB). These store information on each page in the
> TDMR. In Linux, they are allocated out of one physically contiguous block=
,
> in order to more efficiently use some internal TDX module book keeping
> resources. So some simple math is needed to break the single large
> allocation into three smaller allocations for each page size.
>
> There are some commonalities in the math needed to calculate the base and
> size for each smaller allocation, and so an effort was made to share logi=
c
> across the three. Unfortunately doing this turned out unnaturally torture=
d,
> with a loop iterating over the three page sizes, only to call into a
> function with cases statement for each page size. In the future Dynamic
> PAMT will add more logic that is special to the 4KB page size, making the
> benefit of the math sharing even more questionable.
>
> Three is not a very high number, so get rid of the loop and just duplicat=
e
> the small calculation three times. In doing so, setup for future Dynamic
> PAMT changes.
>
> Since the loop that iterates over it is gone, further simplify the code b=
y
> dropping the array of intermediate size and base storage. Just store the
> values to their final locations. Accept the small complication of having
> to clear tdmr->pamt_4k_base in the error path, so that tdmr_do_pamt_func(=
)
> will not try to operate on the TDMR struct when attempting to free it.
>
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
