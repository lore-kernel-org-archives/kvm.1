Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4893DAAC3
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365147; cv=none; b=V4BP8pk3yXfw1nYZrC1xJjzpfHzy6LmAtXQRcy8dI1mPJQyyOEmeTi1dmNbWANly7zqglhGz5j9T9WYDPBLtrWmpCp/nVVncluSlaMnq/U73beNhkefc17zXSv1visfht1YhvLDyhM0Afz8qcFVmSC2gdSncADz9R8hK2TWGbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365147; c=relaxed/simple;
	bh=FmRZBhpqLPyc1UGxxy4qJoUHxNedPgUqXqvk3ujJM1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAnJJx+Ykh3n/bbriqPZlFYCxzzC6YSydxd6pm1mtPOM3D1typPiX3Cn1mHhBpfZPlXLhvsS72XAaoI8kqvgw8h1SM4Os/Cvlvm0zbiyAHfu1QTMV0MHGcBfCjtAnpnbLiJZyAPGO4VbPxXKhk0yAvetxQLFe1Kxcbcgr9ickSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULInmk5k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULInmk5k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c37b612635bso167233966b.3
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792365143; x=1792969943; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=ULInmk5krdrdVnz1hL9loM4bYhVW1ZU8F24+6ODujTZVcHPe4C4kTNd0LjiYGRrVz7
         b58lzsVriKgtk5oKzBAIUcpiMU2fG0/BPYK7CxTZdjATLSZhGV7V8dL8hmNXsSj0yf/2
         h0nG8H77/NQj5t+c7moqUZhqbW9RohqX9Guyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365143; x=1792969943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=GbInOV1+sdn9eEVDoibLNYnf3rmHuJahTyHa3SG7+ClZ/VRu5IJICVVQPikKFscZFr
         F/DGC7FpD7+l2zwwzqS/04Q49Jl4nIWyxUu4V8YNgVKddI7wK5kwcb7mmoTh9st4Jik4
         KfDYLKJ2D4vcUZArsvcbczp6RxxSGTqT1UtjkIdAh2FyvBgq10BaqMZtFqFiXp5nI1iK
         FiIGPB+L/NPGqzPrK/1AiQ7NpbOwJOduO2hqMa1KbbioLCgiH2QY6QC+QNrSztQVY3VQ
         Cfc0XwcnEaCY66oFbe21j0sxG14T+JKqr2ULKeC9pBY1nVaBmim321LaNhZ8YMo9wSjf
         vslQ==
X-Forwarded-Encrypted: i=1; AKwUvBxr+S9MlmQSDiKxdfldx5bFq33WovaerSTWFtyIZesD6V8CGDKPF8/l4bKbeFguox+NHjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX9+DZPfLQkwKbgfp/Hes4oejL84p3aHoGBCHlEv0x2r0p53Gm
	AFTws0BgLlWWsD187WvSYQ/eWXeFBi4DG81rF0WJc5NkYeCJ0PWtaM39daJqnxZz+8ayAVfsYM8
	6L03r/7M=
X-Gm-Gg: AYBFou0AwilbrJmi1D2gTE0V+OjH563hUZhKxcncdPDEm4akuCMnkrrKkPFS4Hk+y1y
	9udv7S+1Qo+YHfRrRA+ylhKrvyJvv/oeQunZzzcJMpeyKckHd46ua0/gO+frn6ZulYxUA0362md
	GvXqhBwzZs2qi4WIW6NpG7oTxf8s+sw80EdvuUf/VAL00YJ1ujlRXknw7M1dC0oJ1NPr4eIDUuX
	d0o+otiw9/ftvGAwReUh489ZPXGu/nojNTgixgQho/zSMEEGcGvvgp8h5OrNjDFg8BdQuNPJk1m
	JmcitE7n/19JKV9+I2mXoISmvYMAhxA14eCxNPUVEOqc0CNMl4Or9lonY1uZfNvYNGb4+yOFcds
	+MgmamOC82LFaMHfp1OZzUfXC96/EGbRsTlAXZdmDSOVJ1hpcDvO473LLsRcoBIcqpLtKREg8HR
	q0xpr49y4QYxb6D/cufI+meidvEjz3OmZkRev6k7kNA7CdDgno/829w4USyi/xouLvUkbThrPq5
	oiguZCedNZHnvyBGqZC6IBfGt1JXixLYqOSzI9x+kuXXyJd
X-Received: by 2002:a17:907:930e:b0:c40:eb1a:4c8b with SMTP id a640c23a62f3a-c419fded7ccmr381856266b.29.1792365143132;
        Sun, 18 Oct 2026 16:12:23 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c409239b3acsm307600166b.86.2026.10.18.16.12.22
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c37b612635bso167233366b.3
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxgKmMZ0wgVLute2b22sxTFiiR+cYr2HJloOXrcRVRW5uDQf6jDzA+Ak22Xl5hvEd4pbtM=@vger.kernel.org
X-Received: by 2002:a17:907:9494:b0:c3f:7270:1093 with SMTP id
 a640c23a62f3a-c419f706c4cmr443663566b.26.1792365142168; Sun, 18 Oct 2026
 16:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin> <20261018175347-mutt-send-email-mst@kernel.org>
 <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 13:12:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
X-Gm-Features: AclHuK8ibgIQ7ZzCJT6T1XNCTCPJUVy2j1kAdMYMCDJTCT4gsOXcLC7aX43RNik
Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Haoran Wang <haoranwangsec@gmail.com>, 
	jasowangio@gmail.com, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux.dev, 
	Netdev <netdev@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 12:06, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> That's a separate bug, and you really shouldn't use __get_user to work around it just because it doesn't check.
>
> You should use pagefault_disable() around the access. And if there is still a sleep_on() complaint, that should be fixed.

Ok, no longer driving around and checked: using pagefault_disable()
around the get_user() should indeed fix the warning, because
get_user() uses 'might_fault()', which doesn't complain if
pagefault_disabled() is set.

Admittedly the actual fault handler uses a different check: it uses
faulthandler_disabled(), which also checks for "in_atomic()", which is
why that __get_user() case just silently happened to work (badly).

But that check is historical - but actively wrong - the added
in_atomic() check in faulthandler_disabled() also checks for disabled
preemption, which is one of those "it's not reliable" things (because
the preemption count depends on whether preemption is enabled at
all!).

So no. There are exactly _zero_ valid reasons to use __get_user() and
friends. We really need to just get rid of that broken garbage. All it
does now is open up potential security holes and allow people to avoid
warnings for actively buggy code.

               Linus
