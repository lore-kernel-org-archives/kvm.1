Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912254279E7
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097571; cv=pass; b=jmylrdq6eOq5r52FkpR5GMXwz7Vxd/zkmCdkNZCafX2QXkPwdfIwCf6kFjWaSyDcOiW5Clsrs0Oo7kX+9MnWaVY1Lv7h020VDt9omlYgD1wBmAuuQgzX+jB7IRg/AAPiCPZQM4hDqkiVlDCdtq5RwENuA9nUvv8rSM5CbKwTPkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097571; c=relaxed/simple;
	bh=bUvnmW3ITD5wtOOK2u2GJqcn5fUYdrSU0LW4ixMKzJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeHT6f8b2pnNeRfAiUWW+vhqqZyQN0FtLfPRSdsN2PoTj86TXvS5VMl/IdsqSw8/pCf+2fMi8pPwYKTrybjGqyaDgIYwgMDLJuIrJgDGF8cAcnnnGlQrw0r3ZAsOXWDWpyYSWsPLETKCAvg+npbAao+39rnYoteDGOsNQFmoaiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LnENQiD; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LnENQiD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so2568a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 16:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773097568; cv=none;
        d=google.com; s=arc-20240605;
        b=Ln1gwF3+PgX9Mtl2tWkxJSvCfMZPm3FaroKMYctrMm/Qiu2vDYaxQG63Qk6bKQItJx
         KesTr4TUQsgeKppvl8FNFW1MrsjObO3/XO532ccGsDWGyHPHGWjhxmmOurasXWZWK1Ab
         2tjQ9ZPU0lO4vT96wQAyXn2yI7cdKwi88PVsP21WUgDE4B9iKpHPdksrVlVj8fCBsIJ8
         qWM9fZ0pNFPHCPDP1J/4KyVlTSd+0e5EQNXoI/dNWzpc2fcM+mJ8Iwjqw0x/18fCgiwx
         +8P5vp2KckFiZK5Wuow/JOinCkjYnzk4ogaovcP9ksbGQfxNLbarhBHGXR+k5cTfcxqn
         jMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUvnmW3ITD5wtOOK2u2GJqcn5fUYdrSU0LW4ixMKzJI=;
        fh=7LZMYusC1ekD+sCB6CzsXgLd1//UbiDLN1Fax+laSRM=;
        b=f2MvAo2ZoSI+zGGGrrfxxmt5gA/jnCEdq/U010RyxW1kmbaQ9gI4w2lzzX7/cnZETh
         JemALeQhrjFbKHIIesF3uFbJEobjTNAQmzOmJerPlKPBD27dUcfa2vEuOY7akYJgtvp9
         RN6hVhG4Ww30OTeUKkl86udI3KysJwco0pVd0M3MhOqickwqnK+1Trj21LGb+oROEXwI
         PDv8SRtOIK9anCYxoeW7VEOJ7PUFvYl7e3tSRip2WmeGuEvRi9/n3lUqQvxskr+O3aJZ
         XO5Wx7VRtnJhVTxD7gVsmG+FF0Z77mKrSE/nD0+p+muQz2qk1IuDU17FcVoeWw+b9OLU
         RlzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773097568; x=1773702368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUvnmW3ITD5wtOOK2u2GJqcn5fUYdrSU0LW4ixMKzJI=;
        b=1LnENQiDKMUPn8GkxfnmwulA3Xnn0pHEXfbGaHIMhK4Vf9DyXWYWCdAlZo5Z1R2Nab
         ouECAIX5FWYCsQtOPzj5UtYPLZ9L8WynDjUHsEC7uuLTYqJpIoIcIJ/fyhWgVE/kdXgd
         916duPQGpestjYplEd+HOdYcXfmY1IDSZj2kAmSlH/rqrytB9UD3Gsnoy9/t7FnRp6P2
         SxSlLDRCQE5HipE9yGH4vvuq7zaT4lBp8Rv3frRqvAejq7MaWVVxckxkGRm0Wwt+igHE
         l48lq8Fs9M8vdhxN1CEExSkK4BJJNkeIHBl4T2fvC4IoMRCmpFkHXZ4oWLoB1Rw/JyMF
         JHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097568; x=1773702368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUvnmW3ITD5wtOOK2u2GJqcn5fUYdrSU0LW4ixMKzJI=;
        b=H3bWXbFZy+PM3iXa+YE/in4mdKAQouDQ7zqzKMMgRR61DqdBSAa30br5eDq6njvofD
         5qCZKV23D57ouAfWdu8uUNbjLmXd/wn6rrpaZ+kFnIEjwQOs6Z9296+eGC4o9ENDbrxJ
         g6JHZ6Y4inUzNvriM8qubDCGKpxux6vpe24tLEbkhAWfpQmrLpDzP6hay99Pu/OgICNQ
         y3y0IhHjqOD+DfgUhlAWsAS4B92XfXzvP++C8DDUNWIWN4L7kRG5eF1yNIyaPTQJKTsF
         XKKB7StM6Kt2MaJfcWVVPmTI7c4BleiUh8CLSv4Gfoo4/5sgs5Hq5hlneRYQBllmDBOo
         Z+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhnbb0/T7LTJvE2GxzGlQhGbB/p08ad1sau06rFmDhKrw4oS62uzmT75aBdCutMY7G0v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatT61JQDGqL1wJnDuV3+QXx+++wFH7b2evfJQ0GeHYDmQo8cz
	ZgsL+r4ZSq/CzDx3v/AON+J40xxrk5zyNn3KGzIFYsAnpa0/SSDp2sBEldrgCBKXHYxSgjAaqKA
	B+WrE0Gk7TUwRtKX09YFASJygQUZxZnLWdWbvLKVl
X-Gm-Gg: ATEYQzyvQoOX35wY3uDhRFNhc/MdmgNoVMhGCjf/u9euiumJ11kSJBRST8RwnBRBwwx
	5EVZRueKTBnGRQrvshFqDNo1cWQvRWPhEIogFU8Q6p/3VlSMo7u2W64xFSIRsXLa9xKdN1LnoXk
	waLBY/2QawT0QCwf4WZBEKqfHIaxNsca1IlZQPAnWxcCe/W2UMb2cDc4mCmv1CeY10Rl56aPAdv
	Z9auc8peVt+jg4pWbRgZYCpcVX3ozPm5eTJnJsFAoGNiYPO4d6XOVwBh6PuuGyPQm5FPCA+fYpD
	GGsrC+4=
X-Received: by 2002:a05:6402:2356:b0:660:a3cc:2921 with SMTP id
 4fb4d7f45d1cf-662c630756emr10208a12.5.1773097567467; Mon, 09 Mar 2026
 16:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-vmscape-bhb-v4-4-1adad4e69ddc@linux.intel.com>
 <CALMp9eQNBZsJNdfCVwbJ4v1DgCNqRV3DVcEeCPFt=dd29+qy-A@mail.gmail.com>
 <20260306223225.l2beapz3nvmqefou@desk> <CALMp9eQoE13d1cqD3PNJtvdKUGZeVm1g-9TWh+M+MJj_sm9CzA@mail.gmail.com>
 <20260306232920.dja5n7cngrsyj6tk@desk> <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
 <20260307010051.u4ugg3nyvsu6hwbg@desk> <CALMp9eQGZcekQ3QtL=J7TqHJ9YfZ+SbrgY5P8fp14p4KNThYmw@mail.gmail.com>
 <20260307024132.wleqtpovzd6wtvm7@desk> <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>
 <20260309222935.2wu6xhydsgikkjpn@desk>
In-Reply-To: <20260309222935.2wu6xhydsgikkjpn@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Mar 2026 16:05:55 -0700
X-Gm-Features: AaiRm53j9opSYSOMkHf2xTJXtTgjquPx5x3wbnpxe3HSBQ1SSv7x0AmhcS60_Ws
Message-ID: <CALMp9eRu1YYFiqzMbNKOOhwwy-FqrSOvw-ddTuNtiSZbNs7JLg@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, David Kaplan <david.kaplan@amd.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, David Dunn <daviddunn@google.com>, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 3:29=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
> > Is it reasonable to assume that without the presence of BHI_CTRL, the
> > non-Linux OS we've been discussing will (ironically) only use the long
> > sequence if the hypervisor advertises BHB_CLEAR_SEQ_S_SUPPORT? That
> > is, without BHB_CLEAR_SEQ_S_SUPPORT, does it assume the short sequence
> > is adequate?
>
> I don't know. But, it doesn't seem logical to assume short sequence is
> adequate when the guest can't ensure that VMM would do BHI_DIS_S for it. =
It
> should be the other way around.

Assuming BHI_NO is clear...

If the hypervisor offers to enable BHI_DIS_S for you, then the
migration pool may contain SPR+, so you need the long sequence if
you're going to clear the BHB in software rather than accept the
hypervisor's offer.
You are saying that if the hypervisor does not offer to enable
BHI_DIS_S for you, then you know nothing, so you need the long
sequence.

How would a guest that refuses BHI_DIS_S ever be able to use the short sequ=
ence?
