Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683113806B4
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428602; cv=pass; b=EK+zrpiZDfH7cXHLYGuo+HBnWI/u2ysL2zqPTfpk0PJ7rYxVojrWs8MKvG0VLnTbH/cLxIs8bMppHF5NqS6w3bmurftdlmWJQs0G60rEb8xTnURrv5GdF6O3cVOl4j5f6/YYqCiFaXx4fs+i1MP4nE8OrYRYRN0A4djI7mt4h3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428602; c=relaxed/simple;
	bh=a1VJye+SOvdZY6af5daESbtKuOBlgigL0e9XM9KCWWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuqHFpzBfH+LU66KOlqvPXvwWcM3vCN1N47Y0tsaCGnwKf9LoYokJdAF1LtZO7GJ5nbH5lpkfTpZRd+fPB93AOK11DHy5gqTW9FBI+UIHVujCWXd350MfkzkrrtzHvxrJDOyIU3La0xaAHRd1cY800eadx6LzwclKAMdfmsO88U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XD/foVIT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rLhWmPTb; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD/foVIT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rLhWmPTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786428596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1VJye+SOvdZY6af5daESbtKuOBlgigL0e9XM9KCWWM=;
	b=XD/foVITL203wjuQqexy81R0s/OBsEtwMiCaLliLPKlDuQD7kdjaVaNL0GLFw+jl66/yzo
	KK9nG32ICTFE+8tg951S7XeQRpuujvzCFKTt838Xcdb4JyTad/7gWVIXxmI3+OKiI+oFzp
	9qR2fJX6+QALss8hNOPcdbOY9yT3bTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-g5wyeU2rNKGlCpPSS3eing-1; Tue, 11 Aug 2026 02:09:54 -0400
X-MC-Unique: g5wyeU2rNKGlCpPSS3eing-1
X-Mimecast-MFC-AGG-ID: g5wyeU2rNKGlCpPSS3eing_1786428593
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so1482336f8f.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786428593; cv=none;
        d=google.com; s=arc-20260327;
        b=Vx027Wgq7QXWQB9e8Xh5WRaSX27QslSjAlit130oUKYz0/esNiouklkFdzLOUIFQrl
         C3n2QeLOPdPHObYzSRbwX3VOS3KKfq/d/YoiAUD4goT4PdP59x/Mtjllz5apj0IrUSuF
         M1scKNXNMR/PLeBNDvIWfZxjH6+W3GIcj+svHT8pDnIFTTJc+IWT9JaOU3MxSO15fPfn
         QUzjJLIVY6/AGw1DLqMhYRJQiijhNNZe83SrCr9T6Z7XfRL70Sq2v9KvtM6ETrgG8jj5
         HJRyil6QJxkA6EZgAzwlhz1ZakFmbI0ZvXrEi6/DABIjL8gWF6m6z6+ogkWYEqVC3OcS
         LeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1VJye+SOvdZY6af5daESbtKuOBlgigL0e9XM9KCWWM=;
        fh=EWGVXj/3HRjE/VtdqRSEZ+VV5vhkVq3drynVONtiBF4=;
        b=g26AYDlxMe0+8C4kOuGIM032RsZ/hsVbR5J8mNHWM0nEfrN940t5aBM37f/QvwKdcp
         dl14I1rVy7aBIftCV3dvLJgWmCl6kVVP9MXe4siwz9/TaoIXlMCkxRtdm8khDHtreWcf
         G7ZUETx3PGfVtMMw13YEM30iZfbt510HAC/VZD4UNewbjnrr/yOhPKoEVnqJwnluABFD
         HtkO5CWLtvBRX4dQU/40pgfmf0nRTC80EAkmr9yQWn7wfC0SDYBye/9jyIfuWmcs0G8o
         FH9LxSzQ04heXIqhhgcxlChPMb/rLv6pT57hX/SaOBw3ZFSh9fy/jmnpFp6OHUnYEiaD
         VJwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786428593; x=1787033393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1VJye+SOvdZY6af5daESbtKuOBlgigL0e9XM9KCWWM=;
        b=rLhWmPTbq9CWiJ7QPyfxhhAPgCZ2G5zwJmZC6mT0RqzspD7bj5ppzfaLJslaZOzgrY
         nSokNHipxBnOZDbaQyjSmWYubMdpoFPCClLCqy3GMkV2G9ZZH6K9nybDsCnOFb89YcVf
         7hn5rcDx2bXWXqoAKgNaGA758oE7XXcIcVs/GgWd+Rqc601s2snzET769J9LnSRzFmwU
         FLNxVLM8Q4ctSCdT1y5B6ql7BSaMV6Krot+nlhgWsMPYyPe77IY3PDtv+0lY1hJTggiQ
         E2568Lo8+u0PPSLJbsH0lqXO3iTVmMjWXXBxhkI3VJE69T9LB6nC/t8JmHklTbJXj+jQ
         Kiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428593; x=1787033393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1VJye+SOvdZY6af5daESbtKuOBlgigL0e9XM9KCWWM=;
        b=igVQnZ25poe3ABNnoh2X/tl2i/Q5ZQV3nbb9JJYaxKir2+sRrdILmh97S6oi3b4Nrf
         FCxLgwtxB1exNsdiqBAqR6MOpKjkbDE1+69jxdzSQlInRXsC9EnuYTCrYPHUzVS8OP08
         E3u5b2sJLvuamDQIY+HMZyjvq2LduzqIWAnCR10D1jGCfR5jesUl6dPwhp8+zNjHJdbw
         Vo/Rhle2HQN5Iu2s93n7J9wqBcAscJFYtacpqFyZUuv6mB6JW/+L77Jr9hYNWzA4c/Ur
         TWowsZMDoD1d3hwXW3Majgr7VcRTZgiiqp+6pQ28ahJAyEOj4X3cy3AnZ9Kz1VpkwJcs
         IrdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqvix0zzIyi0NoNXzUtdGsw+pR+9uz+uBrz3abHb9G49H8AC+VVsCqDAw3fDMVP8Q+kEHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Gq0068AqiDkwn32oP70MNo8+ODOd4VNzZH0MuAKznsupzNtj
	GBE3q/BKwelMPqOPJ6fMRqJwF+J5evRC5x5pQYQhm2q149jUBEWVxHrdjcQgFJl3KRkrCnCUDjM
	I/lWc9v7p5BOIQHMbBYclUFLYw8QC4E6uti2q6WbYp5i8jPa0A61TLKkQxS/UaPvHV/8qrMYJdq
	ICyXnYRiIlpFASDS4k12Hj5o4FEujN
X-Gm-Gg: AR+sD10nHdsF8rMPRHBYCwuAH9iAiOYumlyZjsau1R7t8yvnu8yD5Fy4dieQjCBiRcI
	86hd7JR7MlKjHHx2L2WZwhOS3TzFxXf+Smq5xAyFeiPEaRJ22hFm4TDAQN6kUp/wBHED14lkWfk
	BQTdeuL3/OMe93j8BgDDm/IrTlI7qAxvDAF8q2u/XGI9Hzfm/wTpdv3P6v6WyH7Y4AjMCWYhMZu
	xmBTrAk3MpUkXkueGkmjCEEhJb+DIntvOMS9IeavinIfSFZQKpAihkwAa4=
X-Received: by 2002:a05:6000:40cb:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4814adafe03mr1376924f8f.15.1786428592881;
        Mon, 10 Aug 2026 23:09:52 -0700 (PDT)
X-Received: by 2002:a05:6000:40cb:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-4814adafe03mr1376874f8f.15.1786428592531; Mon, 10 Aug 2026
 23:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com> <anYQsMnpS2kpYoqA@google.com>
 <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
 <anZehP6yD66SRsNj@google.com> <CABgObfYqWf8WXNTZtz+W=CSK8yrGJhDruObp42LXkywhyK6=0Q@mail.gmail.com>
 <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>
In-Reply-To: <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Aug 2026 08:09:39 +0200
X-Gm-Features: AUfX_my2sUEg9BxebvhPYb8Rs0CcWmLSYhyvEzKMwjQzRcXaZ_YfmPglyAPGTIs
Message-ID: <CABgObfZZGYbLHoAfkHDXyAz-Ua1-JfhDHO0Bt=bKh32dYshf5g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 11:30=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
> I assume the answer is yes, and something is broken. But if the answer
> is no, then we shouldn't be looking any further and the fix proposed
> by you/Sean is correct regardless.

Even if the answer is yes, the exact same code works on Intel just
with INVVPID instead of INVLPGA, so that's fishy.

We did ask AMD a few months ago, and again about a month ago after
confirming that it's happening even with recent microcode (and also
happens on Milan processors that would not be affected by other
INVLPGA errata), but haven't gotten any answer yet.

> My goal is to make sure we are not papering over an existing bug in
> KVM's Hyper-V code. The fact that hyperv_tlb_flush is flaky with NPT=3D0
> makes me suspect there's a bug somewhere in this code, and it might be
> manifesting differently for NPT=3D0/1.

I've meant to debug the test but didn't have time for it... Maybe
today. It seems to be a different issue since it's 100% reproducible
with npt=3D0 and takes hundreds of hours with npt=3D1.

Paolo

