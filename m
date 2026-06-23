Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F51A6835
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183835; cv=pass; b=gc9JmVnRznAB9aUpHSWimOwStxCAzW2vLxGWZjNrpUyxyZkdii+WPDrLo1eM/Qvc4x2c45fXIx2galhrJbuJ4VtgpfqG12ZDTGxw0/wiZkgtFgW6FeiYqATjc18gJXVpMKbiVmq49tz7gZAgSHRetWqCMs/1FAtRLlghxWtXDrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183835; c=relaxed/simple;
	bh=hWycTV3EVLunskQOcFlzjWSy5WjEJ6trD0xzOQttKI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvwJKkZbUzNtMOKchj3LUaoymXaKROQYm6qYcntsJpHVEY5WfCRlKK0N6BJkudvwWfAjQiqOwc1BOpoXIXyY3xsQxqugR1zofDdeSNKqglQGQFzQYAHoTrLLzbhwA3q58ihWKyKrTb1iKdtqMhY8qW+sKHY1TVrj7ILhok1Zmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH9XSznw; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH9XSznw"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69690062350so4777087a12.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 20:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782183832; cv=none;
        d=google.com; s=arc-20240605;
        b=j6A9e2X4n8GQE7mUZR7rWtIRJrWw/aCl5QAQ0CgjgZkPntvVjWzPF6zv/nxkVr9OoS
         sV1dL+FUYig0oId4OH/lRVo2MBLInux5wWqAKjG/QzWS1Gxb0TUTNUooTVvN8TWtqadS
         1YaiR1XUUTPPY2ZJxr6Ruy8gAxRvqCUYul9utfdU0pT4PMAEvy4D8zsP9CtJDTVkH+/u
         oPaDm9FRTr/aW7V8Vx//IlQ/ZRIPTVN4MOo56fKqkvoBdTrN9vAPkxWjvM/QjUUQpytm
         XfFDEVGZLiY5rdzygdufYZpmHmpgI05u+DicpBMz1yeylNjRHe2yJjAZJOiHC3+LiUQo
         5rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        fh=vR3WlVo+3T6Q4MavuUKrtl2/uoxRq8DNf69LT4B/fXQ=;
        b=TUp7OpMhfQD7aZxW8Y8CP/SBlyQnncWYP5UZPb3EAjhMPVvXT3Uh/iaJ1jEPk2qh7d
         mPzE0cOV6DuCid1DCQqEg3JS944TBrtDq4IhbyvP0aNCucQt3tCWb31i26Kcb39FrZ79
         23j3XrOtDkWzfYXy0o+DrltRf9U8Xt0ZyBmemUOVaojr+aOWu9qdaSUOD8yYoFux0IVB
         IWSXKAlUazp1Lb+d//QwYOs3BiOw4ykxWvhoE29Uondd6Xym+SDWn8XXscI0xPl6u2YQ
         zEyLaCYoT2hzsX1kHax+MrYpuVEW9kfYtL2ajqNRzTFfJv/24ijgYouNJ+RdABzYhxhb
         VM7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183832; x=1782788632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        b=qH9XSznw3Yf1XL8xgwjlPlsYit04Ju50/bKbp8MQaVzq/w4cB+S2Cd4wqBOPWXpEBn
         NBW6S0+uaRT7AS1JLtVKm/7IbMp6LHy4UhbFzf10ya4ZJOKPw/L6g71rrCDhJ3QXOzr+
         92W+5+UK3kXJLYcXg2rZIDgRF6DJ0p44uM56aE1nxEU/QOSsYkC91xk5ybeZoVZpQ316
         aMsLVZtD6Wg/ehkhjVS73DAuyHH7uZTssm7cWjgEnPxRmkm4mQpw9SH8TS0+L15usWTP
         TLBJVx8fPA5yP9xtgJynhpIf+Ew+W9RoIsSeK7BheprtEIadQiNXNBBXncVuRtjxnmJd
         mf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183832; x=1782788632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=923HKIu3/MEcds1uZKAzkAoXqlwhb/QKAYqjIoUohpI=;
        b=q1529tK+DVCRv+EPTea0rrRhEe4+gtlYITmLn7dIOwFQsfgwOIFTooRqsmSRqUpdYA
         towourBQqvI/S0OD0J4Whmt6bD+Epqn3rXPy2bKPXKwHONEHFiNmpFuR7+DTdUp5FJ5h
         wxsd9r3qStB1zEdgoJh0OWV+/rM13jIfLfqY84cFzyoE03aOiQO8m0yXx5Ma4FquHu/7
         uCUTnOrHUXifZ6P1ngV6mwI3Hc7mlKysZnN77gvZMMLog2u9RYAX3Br38tXym/zPoWwj
         sNZuWB8EN58msbabhXNawNDHOgwty48L1otO9vi+AmTQaGQVG2WeiJWH0v2v0Zlfc3fT
         YI4A==
X-Forwarded-Encrypted: i=1; AFNElJ+6ZkRatA33HoSceMbaRuQ57dnakPx+CbSRDj1JA1p/KGfxejOeVaj1gLwO4d9n+ucdJ84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnLo2s6exDuSUGtMBvLFbPKREx1qekCbPQHJlQCRMHQqmc/oD
	J1rZ/k7BbHWp3088VtScf0RAMtb0xQ2SPLy3N7Cc5CrbcXv7sRhrVsoXPOGQ8E5EuQbhonknSRa
	m7rOk4JPGt4/ABma6qJ32iefIhA9ZRUc=
X-Gm-Gg: AfdE7cnEOa6+ycujCelb+mD42NspgzL8XxWF4b3LHfZFQrdE/1Wo/drM8xgRTCcGMCP
	u9irJmZ6LZSSQUl70eXw2c45LVRB0TGml4tZNo22H3wM1bP+43XkYuc6KnAHNRqR2E4/aocsZnj
	bN2jZEzHXMW7y5fXpd2d+RV0M6zUApvyvnof+4m0RIn8HkluUxaJvOXJQSviR3UyjNScxA/o5m2
	ERR3HWsSM/37W4EMdIi2hB0qUYqK8OlHoWwve1Ag9+Z4TpWBECQ+mIMXPFgF8P1ZTq9TBA=
X-Received: by 2002:a17:907:3fa3:b0:bee:9809:3ccd with SMTP id
 a640c23a62f3a-c108c7fdfa4mr26697566b.4.1782183831975; Mon, 22 Jun 2026
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
 <20260619203107.2752678-2-main.kalliope@gmail.com> <ajnpFEwXcqw07XCm@google.com>
In-Reply-To: <ajnpFEwXcqw07XCm@google.com>
From: Admin <main.kalliope@gmail.com>
Date: Mon, 22 Jun 2026 23:03:40 -0400
X-Gm-Features: AVVi8Ce3yoGe_vqyZJN72zTb7OPP-SRSHNCgbf1VXBn6dg0x7MaKOa9OmyfLD-s
Message-ID: <CAJZwKkhcx4Zc_OJqevhvG=ifPS=VeDd5ycmGAy_8KhcEra_3Bw@mail.gmail.com>
Subject: Re: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest
 pending from Posted Interrupt vector
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 0wn@theori.io, 
	mlevitsk@redhat.com, jmattson@google.com
Content-Type: text/plain; charset="UTF-8"

> This is misleading.  The helper is in arch/x86/kvm/vmx/posted_intr.h, even in
> upstream.  I don't know if I *intentionally* put the helper in KVM code, but for
> for whatever reason, I did.
>
> Commit 699f67512f04 caused a conflict that needed to be resolved in the 6.1
> backport, but that didn't have anything to do with needing to re-home the helper.
>
> That only matters because I was going to ask if we'd be better off backporting
> asm/posted_intr.h so that the helper would live in it's "proper" location, but
> the answer on that front is "no", because it's already there.
>
> FWIW, I got the same conflict resolution, it's just the blurb that's confusing.

Thanks, Sean. Yes I see it now, the conflict was 699f67512f04 not
being in 6.1.y, not the helper's location. Apologies for the
misattribution.
