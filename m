Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941518;
	b=K0wY47JweP/P1MoZfiAfmNqsJWeQ73J6AU79KqMhuVLkjUfHgwMII9GVC+lJC3kC9oKU
	 1d5kDYXRhBjif4YnGbyl8pKwhqg7b5g9TJ5t9ri8nLXOeQGwNfB2XWvt6wPOxPOIOiWmM
	 cS9RaFq9/1QVfNGYqN7yBCQb0USOQp2gFhkZcE1gncGFGkWDK/HUM3gp5sPp7YbQxzRsS
	 ZZqqdrs8GsCsGIaaZ9bgM86P6AArnEb+YPMuj5KUeQrpjqy242kUeSF2UAUh2X+Devrzr
	 90xCxwgC0KgplS32RJPebu/REAUEtv4CpLWDoyGCQyYW83+qW0lSpXFUTKrpHrp39PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pspHsxwC+1fZ0eWgExmZb4edg4s0MDST/6bYFdzne0M=;
	b=lWgrYw+3mPdNsNYtJGXsyM6AvYqn2bGkDa/0zr0UR2chzM9I80I2wDyKRD/wsAPzMxY/
	 GTX8wTlB8ICscW6xppRRBeqhLuyk0Bk2dykgZaXsxRtUopCkgJIBtx1EV1VQ6mZfu1+v7
	 HltwpAe8pJ2jMVJnlsZh9aDvpfEw8feC+WsF2pp5DIRaZQsnasyI4oxUCbpWKVFO3YEcR
	 R2E14A+eviozMHQUWt8Kue+VxWiIrKcIDkvCuVfrebGROMCZDuxGcBH9heZhT2D2gk6sO
	 LjbnGJ5M7+l1EVR5nYicheANe1kdF6fyz5yigdQj2DXHwYplZWayR4ZnJEuBcfYxKpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T9xEbZc+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9C606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A9C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T9xEbZc+
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5383c97c8cfso29021cf.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941517; cv=none;
        d=google.com; s=arc-20260327;
        b=m0sOlI80NKs2Dlz6KQGEZZH0vQ5xWGCfg53mXIJZg7CrC8vXfBSnxPZUsZE8Df1mZ6
         8dkDhJ/kBJp/STpQTPU2Zwvj6TU6RoEDDOBidt5LM+hXiVtzu/a1D+43EB3Z4/H+ho89
         PPa4mATTfxWennuZ6VZO6f+LjfI3scKQJTfcqx10f7M32eIv0v9aorPEvdQT+2aOQgJG
         RSiiFXfdN78j1unVvF+Mr0dlb8MLHDad9rDaFGn3aaaoBcdADQO5R4xbuzJRXCwZe3Bp
         nd/NQwcxRoEI8tkIMqEbkDA2/uchny5QFScwJS8XDWSDuRMAVYQxnHg7sCC631S/t2e2
         nykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pspHsxwC+1fZ0eWgExmZb4edg4s0MDST/6bYFdzne0M=;
        fh=dMmwUcbqERfxUzQ2tl+nt9TGnLyWid5CbuG27jp3Ct0=;
        b=W8XcSxglNlpbEMLlY2lwiFcRMsqHI+COjApN3hUAiy4U2HjpGECWNO+f2cKNS8b27P
         jsS1P72nhByDhuUb3bGZu/8f40qDx09UsRReSTa9rtZnuWQyvWB1Sgl1cKR4KAUAbQci
         XQAMCMPQ6EpxzlFqQBmas6YfSLCRPZPV8Vo3478yf4JnXrhVaCYDuyjAh56Hiu8g48zh
         c9WYHbONTj9o1ORsdm76WHL1HWccKV6j1ZBlAK/lyJswXm5+umfRcxCMpV97SAW2A08k
         SWGalW3ENvA16ZQZxHtm/zJ/BcV3KEHlRetUpecbZNoDJTXuCLJ1dhbSY7tH9brdLsLL
         2Izg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941517; x=1794546317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pspHsxwC+1fZ0eWgExmZb4edg4s0MDST/6bYFdzne0M=;
        b=T9xEbZc+DwJsTIZJ5kRLvQitoKGARhVX9+FfMjxC5ToMew5+z4yZqWm1MXg5HZzJ8P
         q7Idnq2Uza6VKP4NVIJFQfZfXm+4BJ8pGqN+GjsCejEfftMg7PkH3flJzv+XMoMsMRWz
         Szv5py7JQwiVfTFSbwJe0EbWkmYFj3ZPM+w7LUmmdny9NQkBVe0ie/3otmNF+/dTKSdg
         XT9yHhVLYe/jo8Yst3WY1Sgj/q6XU+IRF++RaC3jV+Cmxzk5j65I2Xm6r6UYpXZfU73u
         nLhiExVdoRmWctIOxkyDuZOS22GG3mN5f1uNVTPvQhArGc6RosdnTZghPOw9PfyHpZaW
         OJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941517; x=1794546317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pspHsxwC+1fZ0eWgExmZb4edg4s0MDST/6bYFdzne0M=;
        b=GJxjCucecqPyWsYkKTp3Iwr+t7epOHyWcxF1PPhbsfJcVCHrWtEdQMvLU4Wt6Mx3eo
         OWuzt9gIMBoY9c7UM7/hR0Srr7PulqeG3f7hlsY+afXFLWIWvKURC77UnnBG1rVfi8r6
         GHGuJjHPq771iUIdzn3ZOre6pvsKhkUel81Brj5CJE4u96D72/YGXGt/lkCwn9RRykAI
         nzEDaLA/d3XvfvqJ2/a1lX9/neV6IMB0NMfnxFND02y0WDEQ3+ftobPuu8krDRzPJzCa
         FZhiX9iNcXChdDd7c99Rlv6obetnvcpJ5RNNgYk2ztGt5LTDrY2uaKOEaWLLVW3C7H/k
         iyiQ==
X-Forwarded-Encrypted: i=1; AKwUvByIS+L5WokbsTmYw8UqCMXl8Annw1vGR2THCxQrAZH46gHY+FoFlvAVFFwcTuI1I9r0nw4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SKFN/qB1fR42j8mvkttZUflfV+mxnmofn5BGUBvRKC+gyHuAt
	f/QQK9af4BqV9naeIiVvoCRwNYwVXB4Jo6ko1OSMIMbLSip99IqNw2HTGR5SmHupy4kwUMbIJX9
	6x2prL3SAj/6Z7CwsoFR3NTe0b7XXPzVECzMZnQ1d
X-Gm-Gg: AYBFou2wl/VJaQz6z+D0hUfXvdCdckvwfsldILia3TdEfDbp6qHGibUwqZ283+zQGU9
	Dit/VYAUBiYh5PjVDHvyPsx0DDNQqMwEDhjg8YrpEip5yU0Pr/+sSH/XoqicnKRcLOXPjbT8yxb
	NBDKQZuRMuRZp8M1Opt38QAcuQGZIk59G1eIruejW/bUHQlN9KTBejij0E6dB5jORV9nSmhQJ9n
	wzQqRqjNv4bVaRfhB3QyITso2JGXjTFqV5VykwMyin1jSMOr4tNcefK6bScoZL6aWx5KS4k/xcw
	5egiyMIs9HWORM0DHkNEjdqYO1w3hEwSrACy+HJXfDzeRX1CNPLoehkG7YIBA6rqSKZJiMjgeXi
	75vo1su63K4ao56TVamOEVyuYizyuKV9v+9fyKDtu+3xvbWtSbByOAEo7y/8P53ud90T7WdUkq8
	Xc87k8MwZG+wSFbzVM089hE8qZ
X-Received: by 2002:a05:622a:4894:b0:534:313:9b4e with SMTP id
 d75a77b69052e-54e96052d51mr2220171cf.5.1793941516495; Thu, 05 Nov 2026
 21:05:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-18-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-18-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:05:03 -0800
X-Gm-Features: AclHuK9lPryylgvZTsZT9okEXT1mwwp0Ro2hcmwenAEz7x0RSOlOJWzdvOWsQcM
Message-ID: <CALMp9eRzBd=wqOkL0o7f8utDbBm7Gturhyd1tirVKbeSw5=S5w@mail.gmail.com>
Subject: Re: [PATCH v8 17/20] KVM: x86: Expose APX foundation feature to userspace
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com, 
	Peter Fang <peter.fang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:23=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Expose the APX feature to userspace component. Update the maximum
> supported CPUID leaf to 0x29 to include the APX leaf.
>
> On SVM, do not advertise APX, as EGPR support is not yet implemented.
>
> No APX sub-features are enumerated yet. Those will be exposed in a
> separate patch.

Per Section 3.1.4.3.1 ("Intel APX Feature and Enumeration") of the Intel
APX Architecture Specification (rev. 9.0):

  Any Intel processor that enumerates support for APX_F will also
  enumerate support for APX_NCI_NDD_NF.

Why split leaf 0x29 across this patch and patch 18? And if they are split,
why add the leaf 0x29 plumbing here (where "case 0x29:" just duplicates the
default case) instead of in patch 18?
