Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7072EA47C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009328; cv=pass; b=IZzO5Q+8cecI4xmD5NO8XHMzpl7q2jeiYcsIAWOjT9VNWgp7hvhO5LMkou8PPkfrRR4SkEUcHprCfOgYp0YUs7dSgdIMt6ic7gY6vWKeWwS/sTVeyzZfgy0zUhjQAsVpSw+bapa1lY8HtiFJkL3F4w6vP6U+dGVLMSR+Twzoxi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009328; c=relaxed/simple;
	bh=ts0310NVS84irQjXAL/V89Vvi+LCGn9zVinw6Aj3vjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/SsHWU7CVVZ8ZSMbtaHPTWwfT2pg0Ig4inCHL6FwmKrd3+ri8ydhFsYO+goNKosAb6+DKKWG8gKmfwK9MbCvWXPPhyu9LprLtEER9UM/8fjM7X33Epq2VBjlh6QWny/d5BUqhjJO1y2b6Oxm6DLnQvyidLLps0cXSN8D03sCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKyQnU8t; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKyQnU8t"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d1ddcdf4so1871cf.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009326; cv=none;
        d=google.com; s=arc-20240605;
        b=EVlIe1ZRpMjSr74yte1BH+NG403cHHcCfG7S30S36nbo7o9PtUhY/BLor080HDydVu
         PGFqayTAgvzulEtbgXY5TccX3hfxaF4lFGh8Rx/42pWg2WELUUW2TjrVjST3uOIhSklc
         /mQrGcygFiZbwYiKwSmOaf8c0fFfeO5lQM7vQXzlYnRgwFktluowXeFmqj033DF07F5a
         GL8rZchLgoiJzdsfC3DkfxQqy60a+LCI6m+5def0DTuEY93JIDI1aU77CN8XcjrUGeIy
         fnDyUXN8J9FHlcUUX46Zxgavbp1faZgTLuRHwgbPdRB+W3+2EXqU05lInWTJF0LwIRyL
         35Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtpnK30NPSYs041J6tfbjVjHCITU0crTiELBmrfL80A=;
        fh=42t/zt3978dZFupawhuITbHmyk/FN4t+FQQFsoMearA=;
        b=DLcXyLGnB680BT6PnihIdXxL07oV/GocnMJEIUTw5C/IfP4IDZZGYk2Hi1R5fAlPwf
         SlMt7SxCGdkN/fLFaBVWecqNr7yDl6SCZjCsxHBHkydvR9eE7ItAIOujrm0J1J+oj7of
         k3ep/3GXB3MHCtWiCKTc1sTPQ+JQr7gS5GezGBUvQBK3WlAJ2VBgSX76p4bLj4SKZDyv
         OIXT+Z3pWFnn7v8P/96y+02FabOW0Gazbpm27QUIluZ4p7TVV9OeDTOLt4g9m+tt2wV7
         SjKBFfwbWcyc4+sFTdjlMqEWXjH1QleGUbt/gXPVs8HRNd3yjHdl8zTQnMlqQ3Krdk0z
         jTlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009326; x=1780614126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtpnK30NPSYs041J6tfbjVjHCITU0crTiELBmrfL80A=;
        b=gKyQnU8tgJE6GvxHH9qNnbjWm+GTtQaNdhI0eYAI2FpVGDqdsYtLe1A8zg7myH256S
         lM+egVy5Z2e8VHf9VG0rPvQ6w239hty9B2ZpwpXKQdmaW+oPPpsfVL0NuK//kgW24K3G
         O7WD/uOWrJw8UuVc0o+XKE6Ofejt5PRKS2iPZ2bDP4yIw7afYsJmN4YzPzzeRMhvv1wG
         CRH4jvEQdnW9R11cui+33nc2V+IRRElF3xBi0AbMLC4eFAMN4+nIglco+1k2j3sIcy8n
         D+TWWrwgXf758leS47axwuhTqYgKD0yB5R+oyqDr662TgOq0qUsJLY4U7KZLscfdFJKP
         pZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009326; x=1780614126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtpnK30NPSYs041J6tfbjVjHCITU0crTiELBmrfL80A=;
        b=qxqI6H947F7BbziI8lnn3M0ggHSKlmVDsSp9U4ClXK0NTa4lnm356m+pZrH2Wn0qG5
         JKWEfQvdZO7lnFNyv2ypKlmMXlxD1qR2ApCbVfTaY03GQZPeqYOYmtiMUJJh56ChJ/C8
         6ksMI0fthFRNlg4/R542ZsZoC16vqEOsCA6TqqH2sUTH0BJoeijUTXo8gA8gj0QZKrz6
         sNFEM8CIu7xEyE6n/pazdjKJztHZlTlU0At+UeeQh8S0yyrgbynEP5qQUaq83Hzzot7t
         XE1MPmqY4KrJZQlleAHfa4cWJoZbq+V2MH9Lo9H4pUD2F1XfGex+u8GwI3UwhFmwl4p9
         2LXw==
X-Forwarded-Encrypted: i=1; AFNElJ8vqvrMFr77Yg9R5pUthbGXXNqb7udmHL4Zx9Usa/DxRs09aTngQxtV7nLi0NnB9J0ejBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwjtlcpg4oCJDfFgGkPfQeHuGxL6/mH64jNlkBtjdkP8TQ/Ue
	w2OSq1b2na56o4T0GTFQ8cj6uSaJp2vkFWMmGbXyyysxHWuBnS8YIt17mnbV3C67/yNUTLn+fUD
	RN7a3/grRJcm2m2eidiRm1hwQrmfyoz6EUdJPakY=
X-Gm-Gg: Acq92OEFd3CQ0zaCFtXkFtRZ7q3SooQkLvMMrzIBfWULqP/d3gVXG8bfhL5Usg1cwjB
	J+qCXU+TkcNL9cka21MWbqW+mQDbERyylASZSPAIWTuuP0y4ZHmFleHIuK5RMPtVDFUskAUEdk4
	CAT6WWG21cJTaZsuGX18bZu84DKLYULpBKrnFTNyB8QcqcCHoxSD66e87mr4qY51lTn8pBJ7LHe
	CUc9+HqLfNyXc7j23xoQtRfkA6wAHTnYNL0VrhiLvpX8ySCTC6v4Lv3sb+2ZpezgyfCizTEo5s/
	VhxDJAHQOK1LlEVNZXURqe/mkcRx53HpWMGKbOIheiN3xIs=
X-Received: by 2002:a05:622a:d02:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-5172ddf7d2fmr2090641cf.16.1780009325915; Thu, 28 May 2026
 16:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-6-jrhilke@google.com>
 <ahZPvCt_8J86Ak3F@google.com>
In-Reply-To: <ahZPvCt_8J86Ak3F@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 28 May 2026 16:01:53 -0700
X-Gm-Features: AVHnY4KweaTk_K2-osStf9h8w_0Sy-p8ida00erG5d7COSEliAII9dnaTf6cmm0
Message-ID: <CAAdrzjtsHdc=fWKc_GsuUfgMVwRgk5Vpu4r8tMwDOv7-FAmj6Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] KVM: selftests: Add helper to generate random
 u64 in range [min,max]
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:58=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Josh Hilke wrote:
> > +/* Returns a random u64 in the inclusive range [min, max] */
>
> Put the comment above the definition (But thank you for writing it!  I ha=
d typed
> up a response asking for exactly this, before I realized it was there, ju=
st on
> the declaration).

Will do

> > +uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint6=
4_t min, uint64_t max)
>
> Wrap.

Will do.

> > +     TEST_ASSERT(min <=3D max, "min (0x%lx) cannot be greater than max=
 (0x%lx)", min, max);
>
> LOL, that's a rather hilarious error message.  Partly because it's so poi=
ntless
> (gotta love TEST_ASSERT()), partly because @min obviously _can_ be greate=
r than
> @max :-)
>
> The "min <=3D max" that gets printed is pretty darn self-explanatory, may=
be take
> the opportunity to throw shade at the user/developer?
>
>         TEST_ASSERT(min <=3D max, "PEBKAC, min =3D 0x%lx, max =3D 0x%lx",=
 min, max);

I love a good roast ;)
