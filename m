Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608448;
	b=a3kC8q07C3OdHf0sUETIDmPvekU8VVbThS5IvI0EPg3Apdd5/Zpd1HLDLlDTIHHrsoNS
	 6tqsfDU3iZCwMCzl5bZH0HeCmY9PKYRW4NUy+yHzNpvGnb98bL6tuhkpyyFiDGj+PDk4N
	 ojLdZcJsnFUuDktfWYVeZhv1LabSyZtdyGSxwc+rNYZRVTHxv/VSynHtowQci4uS4t4vN
	 oOITCLOKgALiiDENAxQN/kjq3JcuTEph1mKR5as8w34RNtrrL/oWTo6IEmpnuT+FK7L4Z
	 7/A3ZGL2ckCyxOutajvtDb51haZfFNLNDgC6r0SFLKerTqtot9UsSmzcFgAyrr0+F8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
	b=kB9JSvQKZlZCMqjxC7lj/37qaurDq8JFPQvTmr0bzXObAaP4ZZr8D5J0fNuiAODo8Omd
	 m5lqVfJMNYye2e33ejWd664EDIzvCIiWA3lYFKBf5OWIzCT9rjp08P7PR2mz1f7NyCgWU
	 dZeRlyOUz77CL9cC0XI0Osi02BaPTbdG+xXxVf4OOqul7KZlYfaO6khOdhLWjlPMkXbz7
	 /JazazPdrHSL0xgKeXJ1u7uN2k9cGmy7Bbv9qSkwgANaMjjcVFDgXiRnt02SNIPd4v14Y
	 sC32AdkzdQsH4MFamo/2jlf8amUGAn0+5LCfEoY7/0Ck/tH0TV68pDj/JPA0XO1s7qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A87606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1785745eec.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 11:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608447; cv=none;
        d=google.com; s=arc-20260327;
        b=XmKmF2ZnpU4EuxUP9pAHWDuL/JviiIlI5R2YsLh+i3hQ/Akh3U2nw3PCIrIb4VA+N8
         48qbGQuCNZ35eeV81W9ySbsMejkc2hZVJ1BUbZv9Vsfb1S4eIrjK769iAfN6Non4mbcP
         QowH6Q1WgDG9BSsrfpEk6xoSx0s4n7iysJUB81YS6cG1uuWl3Qu8Z9Ozt0qmEcwCROC/
         mOu+NvOk7w1je5G5gaslTdNi1rcL6z74sc2yzEguTLedu1Tp0su4Cyi34TiPF3cGC6Nw
         BF3T7A3dWdWBcmJWXgoFsP3QH9kssUfr41U2vrjVjhUr4DfRa4OvE3wyM+xp9wqgvTPY
         9heA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        fh=UwRgfgBgoNzDFDbBrl2yGcg1DkF9ahjghnmbh5vyf0Y=;
        b=EPuTd4KlZJxVUKqYQkRemXJOCUIGuslDuMBmP5DXMIxPJAkICnBwL6jRTZYbcYtcnO
         wOFGeFSIUZdvRiDUXSZs83Ox5H3wmTd/esjETCynVjZjCFTD6HWJxKfwswDGNlXjSFZS
         /nZ4sHEKvyrBN3iqwud5sCRRNiJkIVVfE7vLjfnj5o0QWVG+WvD8iyE4oP0exPeHDcM3
         p2ortGlVCQnba0/5KwO26kD/wqlKFBrsoHD/HC3/+F/FnWHfqv5+ppyoEEVzJsYZlFKg
         /tOCuU5csZZDSSChPcszGvl++ACjqHzL6X9iTR/v3S8V7tCwFHdssWPzZjn3CCTaKtb2
         R9xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792608447; x=1793213247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=DR2OOg7Cokd9wnC8bGWcf8lnE2DgANN4OCX47zntm6YeIxiIKdkNlSyMxGIzvsC8Yi
         +nu2MxLclS6ixH5D2q6uhakgMGBvLuPrRsev9q7rp0TNMBZWLaYyjH6GNRMU3+3bgYS+
         EChGinr+36jPwXttho3bWPBhPi/180HSIH22UBjN0HNhSsGeFnp3Zp3WBQ9ISO4qaWSE
         HVGLY8cSkGFARoh78a43yh3zx5g3O2U4glOPTARO9x5/Sker60qfPLmgksJmd3PLAlKk
         4Obt94H05egCn92XPZL1YpBXXtsyOexkNhnCmVkqiwNzUFxWUOBeJaGGzRVlc3miZe/8
         0meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608447; x=1793213247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=W5XrlX1k5qVFSIrjltysqmgSzYeI0p5Vr+n9ZjJhe+3zzsiuo78k5+0wajM5AXErd5
         H5JVQhZdJZ9GjeV9y1gzHtdCKpcPz8dCJs7nMEM/m3T+ma59QpPCk7AHiyfGQDhK1hDw
         jN7wXaX9dWOQVopL7W9YlQjwDcY4ltRGR8gb84Og/095eZcg2lnN5KsFCfyGGqty1sDw
         0DWmxPUuLXXy3sHLX89+TFkN23ELtJCwmvyyor39/Ic+fPUH8a1h+CIlav/4BzOwZ16v
         V35NTiWGJ6QXOs4cLy/K6l2NgiWShmOFk3jl6g/lXOujRdfVVZQsNhg0OUYgKldeUoUS
         m54w==
X-Forwarded-Encrypted: i=1; AKwUvBys9icnhi/+OOvp56+kfhOfPZvOEIcVn6AL8T7jWIkno27NuGzQG4gag+E2f8zF09tRYXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoZO/DROaFIPyQraqNz7hietARdSU2USlijJNr/Sc7n0bf6FnB
	EX3WeHlLmUMYxETN68t0txoHj0mwSzekezurkTlFBk25gLcgQKypfvgxcF408e7C/238YlfDUQ3
	3qsyGe/SEmN97ZlKSl8ugUFNeSnhP6yYTddT3O1cN
X-Gm-Gg: AYBFou1g4A9nhd8gknBADuvlwRdhjNYZbE1KmZoaLvJqqVR1R+EYAwX8yyGlxpTuEqu
	Qd2+ic2kS6yhGX/KfSohgwJL8MAIO3A/1tWK6qlQYWqa1gUlf29998goB1KiEeLpautmC7hsDAJ
	RxY2dwRRh1q22ynpfc6sZIFhpqMkhO6VF6YiJITs633jvj7FfnaF39Tk3OdM80vvj5CEOhxtex7
	lhSm+9VJUjzT39n74F36axQLeAufcrfMq2nOcXvDfa+lklQFL4XfONn8B/+mcPbluLri9dSJBli
	DBUxhR0qP0aaFG5OKLnWzw2BQiv0JY5XKMg4iQNMI2Vf/wzKBlfggUq+dpdslNaHlyb6eLuZzTx
	u7j8pJPfRyrTie+hdbBuWX+l4Qp29RY9IDRBZqbcacNv77QeJ8V6dSOBOf54=
X-Received: by 2002:a05:7022:2507:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-190a4d18cc9mr4696437c88.14.1792608446024; Wed, 21 Oct 2026
 11:47:26 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <9huzecdi6go0.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzecdi6go0.fsf@tarunix.c.googlers.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 11:46:56 -0700
X-Gm-Features: AclHuK9GVWu4pH4tc-A36maNXu-EHT2uwChCmCT-hqS2EBFk28gxkLJBLwcVEzg
Message-ID: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, 
	arnd@arndb.de, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> LUO and its file handlers validate handed-over state with monolithic
> >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
> >> structure, even an optional additive one, must bump the string, which
> >> breaks live update between adjacent kernels. Replace the string in
> >> struct luo_ser with a feature header, so that the target kernel can
> >> accept or reject the source kernel state per feature.
> >>
> >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
>
> NOO, It is not. It is intended to avoid complex mess with unnecessary
> over-engineering.
>
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> If we will have dynamic extension of flags, Think about this.

To support dynamic extensions in a backward compatible way you want
something like this:

struct luo_feature_hdr {
   size
   flags
   extensions  // offset of first luo_feature_extensions (or 0)
}

struct luo_feature_extentions {
    flags
    extensions // offset of next luo_feature_extensions (or 0)
}

And then an example serialization struct would be:

struct foo_ser {
    struct luo_feature_hdr header;
    ... fields ...
    struct luo_feature_extension extensions1;
    ... fields ...
    struct luo_feature_extension extensions2;
}
