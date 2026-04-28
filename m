Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897043BB9E1
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369202; cv=pass; b=GMKOZL1wM8IxP00bsvT3QWoGHcKC82n9Fd7dXmsUOpMYmwwDP/H3PThB3GYkocPrQ7jIcG7X7ss8HQZ/coFZl+QZ88hgDlCgbqI0gJYs4fOHUgqfkLkNUcM4YMa7+hzA/IEuTIcGQ3LzN0GxjWFqZvVS4Bqlb9yr4jKKC5XqpgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369202; c=relaxed/simple;
	bh=a8mF3Jvkb6RjDZM0P9AxS67wS1aU5+HJqF17cB1Oy5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bl4LUp20Y9mHeO3UCvTVKzyS2VrceqdFqzEC2U1HGflPwbbyjyOAxCpKx3lqK0hjjK/wdSjwd/+1MMSHYW1LzOf+1ZETq/EbPhdSmFCMHrCdrBX4pVd94cn5FqTB/PjVj/WsjSfhBvN2srIIMvBiiEJAXoPy42HvQWUjkmi0AxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSB5QitU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tnpGN+B+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSB5QitU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tnpGN+B+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777369200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgqD2LjcS3lfaRz0Bbuyp5agpi0erzgXbo3a6MpALAQ=;
	b=dSB5QitU6Wk9xlj6KkNxkAHXjerOCx+S3wy/zvTWAnl25KiunrUqpDi8gwdodQRjC1mR9R
	s/NEIbTuU4oEeG7auQ4qsMGUYIfEg36UHGPU700zFP/GexIaJ+S3+c1Eld9YSUFGffLktZ
	IuxGtM5ifwrrCSwM86WDw3CQDFmciws=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-1kc8TuwLM8ejWv7H5WPqWA-1; Tue, 28 Apr 2026 05:39:58 -0400
X-MC-Unique: 1kc8TuwLM8ejWv7H5WPqWA-1
X-Mimecast-MFC-AGG-ID: 1kc8TuwLM8ejWv7H5WPqWA_1777369197
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cff5ef652so7185347f8f.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777369197; cv=none;
        d=google.com; s=arc-20240605;
        b=CiyMTPrOYbh8DmwNBPb8zoOWi08cRY2re0uMb0Pg45QWP/Il4lOYEOYnj8t7vRvr0I
         PVCU88e7M/kNlqOVY5WTBuYF9a2VC6ch9/wVFySel+s2k3rEfBcPpy3LzmMIj+e3kWlM
         qEM7bNVlv94Jpxj6FlM7UGBGKiFdwBHi9JQnTJvkvZmHaXaHO8NqHMXshD0OmWRcAwEH
         2DwGGj5BZNKw1yQSCNSm5WooEbH6VZSGZkQ9IFI1g4H4eT0muRZOqc53wL8Dmvsn3w+H
         bnXtSI8fwwyb2EysnIb+Alj3DAZjzPW7ucm/7Uqs0jnrELbIChZNeORsmMS4kIg8pFBg
         KXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgqD2LjcS3lfaRz0Bbuyp5agpi0erzgXbo3a6MpALAQ=;
        fh=cb0deLVfK9V0CcMJHBEGaL8jeP9WwldPw18a67fn2QE=;
        b=Ku31vefyVEHMYq3akE9+lB5d/w4u8rSdda51DE7FzyX3R1iahnRHnQgS+2uFamr5iy
         PGW2g/YxP9oXO7ZkHdWnTowfdevpU2InRb48cJ1cSYlpl2YyLasnWLPfqFCLL/B6uSCF
         0brNBpbYJICuPhzNj+epwDHugMYN4gnmHGztYgZ05xQBUdMM6L7tXfsRwknqfRmQSseC
         8fwPkuyVC4wmm1UQ/BZAhLTM+j9lTJhNzGSSZa+v2dtwgJS1VdTgPpWVyh1pZvECPZYX
         31cNFY+lc87GzNXxh2QkU+oi4AGt6Utdlu2yQjNFV62d91stFm0cjFMflaCGAITK7IYX
         31jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777369197; x=1777973997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgqD2LjcS3lfaRz0Bbuyp5agpi0erzgXbo3a6MpALAQ=;
        b=tnpGN+B+KIu7AR9PQ2ZiEbgE7pxnqhA03wEwWzgX9bqgkoB0Pu9pNpnB1pAhL/Zy5v
         OxpjSgpHVXeSW4M3DoDm+zfWuSojLdmGFhHVcDmGOp5MIMnZj7O7mDqmAppmsLXOo6Yb
         HdTchWFR0IQGhyQy1W5Hmk57/6MfhmMJ82XnLg21Ej7EfweBgQU2dVTR8JCV/vs3GCm7
         L8PQ96gQPJvkojCvpnK3QxK/WxZQbTxsbZ8BUMhygzr/FnSU5MxgrhRDf81VHOEm8pxC
         1jMhR1POnvq29peYDixqQhmiNtnF5RmY1HrUd3egBDxHN2R1JSCq8KJUuuPgtJScj7Zp
         vxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369197; x=1777973997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgqD2LjcS3lfaRz0Bbuyp5agpi0erzgXbo3a6MpALAQ=;
        b=oiznOAgJOeUyem+//jEPmc6CAy9vZga+TvZvXpb2R9qoGlUxKOv7ZlKYWGdpJOek5n
         YfvvseuTN6j3TydlHRLmclMPzsmSLEgL9da++KcNqLgqO+ASJ9FfgmQgun2N5ACnOjYk
         63F7oCxzW0PQ0gb2aFIcRYO+BzgqnQSyIMt7wSnk4qoz4we8kbnXAtovysLk0UfboOUm
         so/SpI23Xh72/sAEqlGxeaWoKfzB5C1xywr6DNq4zcBG4eFVMB9mwW4gikGJvbxYEQF6
         AG/rIAG4xFdtozBgSjnS9e3zrxVitzm3ptUyl/FAgQHYdWZ1KMn4MnDAD1wxJ/e76fRj
         DTzw==
X-Forwarded-Encrypted: i=1; AFNElJ8uoCcBJZXVEbSpRu80BE08lsC3dwiD1NvVwz91SJ8ceetOSkJ7ETEyiLCDbTKTeeVzQ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWF6dzRqvunaqNlNbgb32EQVi+3qYpkYPg2pXZ8SNETfi2lfnQ
	zOOCmMgDRNsKngZiB04H/h3tXV+jkPIezcCmhFpk7QINxg9HP6JnNCkdEwJh3NlDfdTBgd3uuVG
	/cxLtjGRQ2UigTRmAd12ZNTGFVwY1aHon0wckIWVBMb/XU5r3aq7czdnUl70B5N9SeZ62jTliFP
	I8I5SOQyqmRUZFBqqdknKYutL/a/lG
X-Gm-Gg: AeBDievBRLdCtx7BoD0mXoi/FmVUPAhzPV9TpO0f9Fcj93fGbyiMJfxnNMHFWpwf4iv
	4ydZdMcz+SyPzr7OOol4qM/Gv6+N7G2mK10YxVa3ll3oyGsJrAU6cDfIm0iGW3a0K6F3NDIsaQs
	flb8cJZ+XPgcfjWMW63pvZdquO1irQv4miYlOpwMwzcvK2CXpCbEtRQDH3cDrQ3g+oR6wS2hC6r
	MSA/27rBJ+3Am5lY0Yig7zuRO3tPR3zI2rmse/jFZJ9HgbbeRlXMMLNf2G6fjzyRyXMdTK1VNuL
	lP4HWbFdhQsjvk4H
X-Received: by 2002:a05:6000:184a:b0:43d:7946:badc with SMTP id ffacd0b85a97d-446496d5208mr4451823f8f.26.1777369197236;
        Tue, 28 Apr 2026 02:39:57 -0700 (PDT)
X-Received: by 2002:a05:6000:184a:b0:43d:7946:badc with SMTP id
 ffacd0b85a97d-446496d5208mr4451757f8f.26.1777369196742; Tue, 28 Apr 2026
 02:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105810.23761-1-pbonzini@redhat.com> <CAMuHMdUvehWeTwdN1czjvv7OjGsu_XaaYS1R6Tg557mDqP+fSg@mail.gmail.com>
In-Reply-To: <CAMuHMdUvehWeTwdN1czjvv7OjGsu_XaaYS1R6Tg557mDqP+fSg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Apr 2026 11:39:44 +0200
X-Gm-Features: AVHnY4InOLQxxAYojPY9TCY0WEKwcodWBYhqlVS7vN1v5Z6dVPP34NbhnYWlh34
Message-ID: <CABgObfa+2ERN1TmVeeWxCQKzra_OThkgkVkBGgDfu5yOsjOH1A@mail.gmail.com>
Subject: Re: [PATCH] mm_types: remove references to s390 gmap
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-m68k@lists.linux-m68k.org, "David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:58=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On Mon, 27 Apr 2026 at 12:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > s390 does not anymore use special struct page for its shadow page table=
s.
> > The honor of giving a special meaning to pt_index is now m68k's, so
> > rename the fields and adjust them for the desired type.
> >
> > Cc: linux-mm@kvack.org
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: David Hildenbrand (Arm) <david@kernel.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> >  arch/m68k/mm/motorola.c  |  2 +-
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks, do you expect it to go through the mm tree or are you taking
it yourself?

Paolo

