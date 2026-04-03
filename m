Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AD1E7660
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219672; cv=pass; b=gmXpJSF/ToP6Gqfb/6WP4v0IDzC4VJZEgCIGvVy3NtilpzI3nPnS+UezXMIdqOveFhvk8qNt60jPaNUAg+yj5kyNPHGrWz0hshW9a9hT8vj7rnJV6SzjgkbNLbPnrWnCdlATmNpIG0Xoqxs3/Kp04FUBv7GomRi68TnVC68W9JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219672; c=relaxed/simple;
	bh=axEo8RmBJPnqBUfyGbwqZpH8t50qcnnO5CV3JyYSkeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+2H6pgYhQV4REniXIiQa7go9ndM+qn4eTCxZNhTMHO1jRbKF3ONPfQXDUDm1/lZ2VibQY9iNNZrFkLsJVTqtHE+E5Wz/5wm1lkdDR7eryZVU3vm++Rly9HybtJ1OfTzIklpuIpKu1neDDwmaKwSknLjJsQy++pguNCpHW7IJXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=M9jgonaT; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="M9jgonaT"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d9d929e27aso1687552a34.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 05:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775219670; cv=none;
        d=google.com; s=arc-20240605;
        b=JmNZPk/zQ3ZwuyiJxao5bZJx5bObwfncXm1QmHuvBHo0/HmUX8bOXes6B012xyl4Qb
         ti+UqU4SuTznzfDOUMrS/1H63CNz6Y79tGsKFynvr0kMT7SZW+HHY+wHt0bYsj45ot1F
         /gkrR7nOpVflAdXKXVAXuH+wNsusp1At25cbo9Ymkp888XzilNkomZW0EzOPQk2YgMlx
         cwXm8XPT74UVgFzBXJsP6beiA6znaLyjJHuJaYwi/9ZU7iucRnrr7Qd8QVYONcV077Qh
         w+smOcRyjp9y7GtTpr9zIAzY/76ct5UuiqREGJptf7wPv32AAN624UW+kXVWVNiVs4H8
         NDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=59kVespEKWq9NAsOL9PYjbmf7GwSpQzIo0rrK3/DBI4=;
        fh=J0HWFyIkLSmiSXyJIYW4+Qmv+jkRHiHzW8qsDUul7VI=;
        b=PGif1tprODme92Hakms7+2msykH04VsTN72PGqRFOXdPH2Jw14Rs7zHEF/7v4n3tCH
         0GyXT+66N7Dcg8hgnxZH9QrMwKcMlgZtMLfeMUaH+5nQ4iJ471Nzv32mBWICVumJSh59
         KAORaef53k/sBcB83bE3jMbImI+SUG7urEWcgseHEXqaIy9HrAtTvB0j2czARBRIZTLV
         EOy9b33DdF6hrXT1eqcrKaWBg/vL1u6oD9zootK4SPcwW0wx82Xhse085FaA9sXXaKTF
         7I/+iTpR++ZV87g74bhwJsUpzDEj7QFXvxJ0w76xrmkuG2iT/I5mnh0MXK79M2nUmajy
         fgog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775219670; x=1775824470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59kVespEKWq9NAsOL9PYjbmf7GwSpQzIo0rrK3/DBI4=;
        b=M9jgonaTX1emrPFFOcHIiDLhUVOEz1CHRK0kwCjCGfVgJ8y2D0WG92OcLbdRWJWTwU
         MNHSMsRqdHDDVlf3WOmCSPYjX6HTAXjc7JtpWuMVwTmqBd5Ukn/Lf220kXTKJEp3GLyw
         gFMC6EPEqGzevKiszg6QFvrrOZcb5/opQOsdl1WtFxhH06bRx96kkZVh6jMGnW1zWTvo
         u9Jr67Sc68siamykyVoGWAuRqI2mlhlucXk4zRmyVa39kXKQL5DpekXxKXCvbCS2iVtj
         9eqzlE7QNRNP3IU1ySoyHIqhtHWs/aJaluvD1EL1uH6mBRMIN5nVIE9AV8XKne4KB5G5
         jIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775219670; x=1775824470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59kVespEKWq9NAsOL9PYjbmf7GwSpQzIo0rrK3/DBI4=;
        b=EVmWaIOZyItKoLF33T9YzxVLOe9DoK4ZrbtnFiGd4nRHy147iWbg1cqfey9N8AJ859
         3neQGcxhCQ6LudFAGscMsOhWhzRVx+Ol+M69g3RofbiPVwLlcpyVipSz65V6R0CNwLjG
         pDXTdQ92tlf7E2L0emsMKxo8fDY/KDiM4GgPIWPpQfwpXkNfj/u1ydj89ZhKR2OZpjhq
         zI4R4oFecE84cJQsYSm+JNa60SxbrT1v1w9CnYo7JNT7axM3Msjxp7dqkohbPJaEs3PP
         +cFqM93lOj/WaU4EYpSBGL6QundkOqyfgNh4s3yEbdFDZWwEImOGUChYANK1DYiqs5cg
         iNnw==
X-Forwarded-Encrypted: i=1; AJvYcCXNK1IQ2RJXqovfk0GzYwwRPJB5fvREBn1YQOeh7bZlmLCqXW+aGd79DMgHO+jOm2wus+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOnyBT853SA+XNULWVYRpe1NpFNK5D7y2/pLbWBFHJP/C84XP
	GyhBTApR+0UjXL99c1eqxG1uSMYjKvLdngAZeW4Rqnribvfh2FflGft25kkpK0AoPoekHkFBTT3
	/HAZjxeRft5IfyEGPQ1DMn/uF0iCMW7F5x2+ieFeyGZHuW8oZkEPzgA8=
X-Gm-Gg: ATEYQzw0axZ5Lpq+cmrbUk8Ad18EM7Q64NdSoES2bEpoly6IxCUmyP6/E+wSUXWNtv3
	lmc8b3QVxF3GSrH60H6zkYmAniD85qrksPPqt7O1IlUmrQLNdoGycbXqji1wIbBQ5QHSaPwvyW4
	YAzFKXX7dnDkBcJSd0mmoPzClNfk3zkI8ZzdmpxoGIrxTHlPmydWHn7z5gzLGZ90YwfShDMNO4c
	ePWks2CJS9UtZlLtmpJAZhwF+/2w9QYoyjRKZFqZjC4OCJGbHw6QqXzsfJWk9+BzrW4CdEeUxAb
	ZiQFfcze/1rQc0BmscVsALdY972AIBx630FIlaXb0qiq3bg/aB2Oipimse+3ApybRBCvYvRhbwV
	+SsUHT4p1bhdxerMKNRzOM77OkEc=
X-Received: by 2002:a05:6820:8118:b0:67e:42ca:bf2 with SMTP id
 006d021491bc7-68220541d3fmr1471004eaf.58.1775219669835; Fri, 03 Apr 2026
 05:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
 <20260120080013.2153519-6-anup.patel@oss.qualcomm.com> <DH1PTVPUM2UR.2J53ICCVVPAFA@oss.qualcomm.com>
In-Reply-To: <DH1PTVPUM2UR.2J53ICCVVPAFA@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 18:04:18 +0530
X-Gm-Features: AQROBzCgiw5HblgNuoDX5QU1aUCJYkWwlXJ-vtI51cG69rWO0VI_zpIeHFgZcTM
Message-ID: <CAAhSdy25k5YWBxLDhNhPkC79LVOZOdA9ZHHZ+65EgF8jewWa1w@mail.gmail.com>
Subject: Re: [PATCH 05/27] RISC-V: KVM: Factor-out ISA checks into separate sources
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:44=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99
<radim.krcmar@oss.qualcomm.com> wrote:
>
> 2026-01-20T13:29:51+05:30, Anup Patel <anup.patel@oss.qualcomm.com>:
> > The KVM ISA extension related checks are not VCPU specific and
> > should be factored out of vcpu_onereg.c into separate sources.
> >
> > Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> > ---
> > diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/kvm_host.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/cpufeature.h>
> > +#include <asm/kvm_isa.h>
>
> I guess <cpufeature.h> isn't needed anymore,

Okay, I will drop this include at the time of merging this patch.

>
> Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <radim.krcmar@oss.qualcomm.com>

Regards,
Anup
