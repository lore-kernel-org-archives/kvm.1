Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122706;
	b=bMIUUaBGqowIT8DT43GJQ0jDYQ+Ydf9XA78V18Sz7tqt8YOOVVBfuWW3vW7TBEjVT/wS
	 hsLHXG41YEevMl/xdBacWAAMPwjwC05UxjaxCYC4F2L+Q50u1eyyQrQzlHaJ2pfp3OjCa
	 RnS9zLUHSzhWP7qw9Sxeu1LIu6tx+QYkd4cuBXrG+vCVLdVHnfOhHzQRwRhzaqI1S8mlL
	 dDq8QM7wHhavd3BPBv8QnGCWcFVwrGBlbD65B6QBm9eO1Pil4rwfvgFeeDamRu+EO/k4T
	 +MDKYZ130GYLyeK2R3A6q4Z8TAdFxn2Ky7Co5LmmQogWKg6q4QbmwXqrPgXbYP3Crsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
	b=IgNQzoB2eGz8dhtAt10Z1cULoFMA4kuSmRTtka2zCoACP8wA0rEsW7mw0XoINh3298cM
	 aq7oXYkFlBNCIOdNcnDFMDtJl3NdTwIiDr1ROOxZRcLX0Md4Y/UQmxwscFki6TPLmU18m
	 lv2Cdx/dNk/b4gOygUd/2bLpoOLUmZ2BF2Lljjjsf7bOdcTN/bdcvVm3VV9XJPBb52r9e
	 7RQFzpkniGotuSUrZenmFkrK+QTIS6k9Itu5/6OyyCJRQcAX7SpRuW9INdrC56Fjegnbi
	 1wuql1TEB4S/C9WeJFYNyU5d0wAjg7a3tBnn9ha2n9RBOlDCBXoqSlYWLgD7n6j4nOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpaGH1Tx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1C606A320
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F1C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpaGH1Tx
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3fd91337baso9097966b.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122704; cv=none;
        d=google.com; s=arc-20260327;
        b=buImzP71S5NQU7+2z8yB//qEX+qGUfH8pGwNrZeUVz4R2DqmIoHM9t77oKOvnR0e8r
         Py7ftNqGNIJ6Ua+O9BjBRNA9Y0CT8OB57NVr+Byxks3xzKzBsqMqj7zbKTZAWi19znJt
         zfhA5rEELNtzkd4lRtMAkPlY1q5mxMfDjrQO4aU8e4LcT2fNS2QSixdCyTdB1tZLFdyi
         R0Lp+FqGmwHbr+WwSgP9khtxsVwwld3yluNUzYT7Yf050OSc47a+0tWrukWQmxY0KGrx
         5gv0aW5cg5MwFsIgq4vSSsO1+zqxvOtYbED6SSrWBYHD5x0ApYCvUcn70ThK9xdQbPi9
         Jfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        fh=wbUyKGpaekSt/EsAtm5ITF8JKkHg8SYolDUHA4KEdUo=;
        b=XWM7nmn5iIxUMXCv2I2xv0hDdY+HO1AO/9oe84Soskh0vjgNpgomPRrx9bihpDO03a
         An0umYA1FjS8rOF/0c5G0LzMhsD839Smr3o3KMuwIZXluWbq27Cv2oWCCv0cFxgmfAk+
         fx7/F6Ge6YLjL6MzcKgxcldGvg79r1hLn82BVOSJQ7/rgtaYs9GEaHWRy0Fm2B2r1JGl
         QY21PczgBAN5NntJ3srnRBxKusSr8FqB0P4GlNJZT1nbiNZdkac6q2ijUo4hZhD05fD+
         k8Hvn81ZdySB/9DL42ywfWUF/f6fALc7w51Tn5oAjFko5Oj7sLMFGUstwexghixEgNWk
         e8RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122704; x=1793727504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=BpaGH1Txd/+w5/V9hrGM2M4C4HXHif8xNS790Y75yM+gjPsyf9RDVpi3ythXOIyyxB
         LHbA39OrkFv6VPnuEf7YxyrFUeKLqjhKTuodkRzxStOKPPqtkjvXRm8JON1kZARoOGZw
         G+WE5WGXAh0gXHbGB/5AAOkcpk6oAAotpa8S4NsTzjTX151h94ky5bJl/0uFFt8oqWBD
         dSi8tn6WRA1fzl/53FwPJp809JfuxeD+VFM72MMcHhy/yO2MVvMG4SAVojeP94ItGytF
         rFXKgKpRIjqswwKzrkuh1/hhW61PeuNmG2g6oTy0jNK4pMKDJifndJWntEqZ/Dne6xve
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122704; x=1793727504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=rB4y399TSsN4k9dHD2RimbqjZxp0R2+MNjZjr0ULWTEIVMJes8RADZ43lXvMu++5+s
         YKGxrcp6j+zUmA++dy8yFGBpz3V5KkoIYwoN5MuOGgQn8UW8PvKlDvpQ3xZKx/QqZ/Rh
         FP9pp4feaWCfs9Lx5m1Tks6wdg7gT0v7E4oKnyVOy6T8u23EGyffqO3RYdh6Xc8x6sd+
         T/wlpxcBkMRfUyU8eq1ttFxZ5GEoUdXw4s7VQzQhen4qD+GfOoOfNMzCsPvCEoXDa+ua
         N5TSK/E9u7eX9mBUaGX1wxneCRPtQ4r6kcWDn8RAdxGoLzq4aa+5uRnhMCCrbsloXBJ5
         xRng==
X-Forwarded-Encrypted: i=1; AKwUvByzDZNTCK58BU936b1SL6vYR3zxOPDjglqYItIblf0i/nGdwQQRee9XfVlBQrXGpIBkZhw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc+9WzXlX+0y4Dn/qmnRQglRnOpFi3EoA8gaobrGq7XYHhEsEU
	rwBcd2pmqzhenbXuIPcd6on3rR2I+FgfUmMe5BsSmViyUvQ+rnl5Il+oEXJG3UXsYQkDkSVFphj
	X376c+v3bip8gi1FyNSAUZXyqvUuiGD6zJHn/rDwI
X-Gm-Gg: AYBFou0qxIw+vVBMOp4/lLuMjDy2NonSJUZXvBSwusqFuls44/qwgsQfvhGT7UHzb6Z
	kc+wVM6yo2dyW6Dh0zKbBNyTu+ngYpCad6uhI4hOgb962gfzSI3BbS74W0Fd2Uy+9PlPW2/a94k
	/26lpB/5iYlq6EwSmJIkt/USdfjYyNSfHW/oqoH9ATeYgK/IUOtrgD7ezw0HOzs3y1MCdGlk7dE
	yu0edDaw0REhNvFrMiOO/p00CN68cM50xM9N4JumZex37a/NhuZ0wawF5EipgO6aabGstqL1xju
	4QEppyCIIbb5q06+1dYfMPv8thX5iozwj0zzdJWPoNBcSDBTdpv41Jw6xOewbFCa3b06ZodfQge
	iG6NXI2VYwY19qniFin7h0SYDOOJLWHi5qhl/zQ==
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c46bde8c44fmr1091193766b.32.1793122703439; Tue, 27 Oct 2026
 10:38:23 -0700 (PDT)
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
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com> <auDT5MjXYq3lcQjE@google.com>
In-Reply-To: <auDT5MjXYq3lcQjE@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 Oct 2026 10:37:56 -0700
X-Gm-Features: AclHuK9nhZy1yfbGSOSB3h6FsOr-7RUqfg5DsC4iepC4uLqRp9MK3EAsOEkjOYw
Message-ID: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 10-26 21:14, David Matlack wrote:
> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > > Right, Required bit should be source kernel payload property to tell
> > > target kernel that the payload must be handled to correctly deseriali=
ze
> > > the data. It should be source kernel (userspace) responsiblity to mak=
e
> > > sure it understand the target kernel before doing liveupdate.
> > >
> > > Saying this, During deserialization, target kernel's required bit is =
not
> > > necessary. So I propose the following truth table.
> > >
> > > Source hdr  Target supported[i]  Action
> > > ----------  -------------------  ----------------------------------
> > > 00          0 or 1               Accept: feature absent in payload
> > > 01          0                    Accept: ignore the feature data
> > > 01          1                    Accept: use the feature data
> > > 11          0                    Reject: -EOPNOTSUPP
> > > 11          1                    Accept: use the feature data
> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> >
> > Yes, this matches what I had in mind for the semantics.
> >
> > To be explicit: the source kernel should set the bits for each Live
> > Update based on what is actually preserved, rather than generating the
> > header from a static per-kernel array. E.g. memfd would only mark a
> > feature present for memfds that actually use it. That's what allows
> > rollback to an older kernel as long as nothing being preserved depends
> > on the new feature.
> >
> > But looking at this again, I think the required bit is redundant. Wheth=
er
> > a feature can be safely ignored is a property of the feature itself, no=
t
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> >
> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature=
.
> > But it can be conveyed by the feature's number rather than an extra bit=
:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1]=
.
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits *=
/
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The lengt=
h
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
>
> I like this proposal. I bet most features are going to be either
> optional or required, and even if we ever have a magical
> sometimes-optional feature, it can have its own required flag. So, no
> need to pay double the cost on every flag.
>
> Just need to make sure that optional features always start from 0, in
> their own enum, so the offset can be computed correctly in the incoming
> kernel.

Right. Instead of having a single 32-bit feature space where every
feature can either be optional or required, we have 2 16-bit feature
spaces, one for required features and one for optional features. Both
feature spaces span from 0 to 2^16-1, and then are packed into
flags[].
