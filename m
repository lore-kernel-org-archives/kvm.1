Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C62FB965
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665840; cv=pass; b=S17Pu/2dOr5p2U/rwc2oNgh06VnAahAirDCZxNuUeml1nbfTQgE8RzPcYKxLQvlS/XCwy84An7g27enG56UNJkiPsNrn3UrkXwOcGyay1aJsQdvVBLUbijDSHRIIAKVsGMIVSleRlKGmEcB34pi8g8cHwckMF4Y9+DpqfcfiRTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665840; c=relaxed/simple;
	bh=qW3BsbQGsGgKULV+hbJJQuiSOz+Kn3lDvAFF1WmVP9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf2f8F3rD7Sugps6vZP2CyjZfqIqpxzimw76u5ImzueOF/XE+uToj0MLbtdstjfC7UwNNB9zn1yiQmqIhohgcFsvRYweIcukDp0XFPAEpZkL8wBVO/9bPnhcumoOeazdwHzN6EPOHaeoAjlH3BwjvqVJ+yTItcosDf0W/gQsg5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQwMjOJQ; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQwMjOJQ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85ba774551so1944118a12.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 20:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781665838; cv=none;
        d=google.com; s=arc-20240605;
        b=c6RW4A+dDgSvU1PjFS4W6CXRmd5eb1QMjkAUGJHbz9C4J02on4tWl0vG8my+lYwYKM
         zlYrYiEmuIYuI4vW2YsxVv6SnlCqY4+LDnc0q9AXIzP2MhZR9nhPLSA29z94JNpHXDTu
         SGEcoUvaAD32A2Bf0cfQgLwLKg1Paj1V99e2US3JEpgDG6ntp7tAF5341wrut5YsrOpa
         HUyk4GTlgnWlbv1yXJ3bYEv9HuujrUnIOGxChf3bso2CurFsSQDFvv2lD1JF69GABVRS
         BlnkhyWoTFgGHQKDpFCyXxdKI1baB4hqmLJ4yU6RhNSJudaUKObdPsPwhG8sqTZeHWZC
         lKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        fh=shWPc0zZuVgeVvqspHfOiq2fvobdIv2KiUG/EmTlWvk=;
        b=BhGx6dMfhl+dSfbT5Dno9DU7hWtqz1sT56ph16Yb2wVKLTFp3foJL7+MfXN+xoI/FP
         fga+t416nFYKaVdS8DzpQ2KVkdOu0PbEWaRRv79FuCHBsOm6JsXDZ+Cbzd8+HGyyPYpv
         sYcOcW5FXDaXpTGOwkGIohwZ/02FcKYQ9oXJbOgcoG/JsYppX8wlumnaMCg0h1WsVq1K
         nIct2uZonNhujZcf4MyNP3brffGDTaFeJJDvSkZ8CuzZUQdMC1U4PcUT81etfqevG75O
         4P+ab9a5bCrvaQ2f3nLkJKj0mFf2Vndz5Dwg9nfKM/TkdSQI3pcDbzaKQN5LUoK0hP1s
         AusQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665838; x=1782270638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=oQwMjOJQuFjD7/KrNVYg9punGeV+QqkYjFVulASJdV1qtHzQb8Fxb628Mt0xyoEPiU
         Rga3/zakCQsdCPZf60O3QvicpNj6lAkkm/FxXulF6+hknx7W4WhArDQ/x0QxL0WIAh74
         uaRiZ/caakdHS1LRyhhQYjxFbQl4ShA1jwzXhOnMhScH76lRyshGhy0PjhS3bPAvhZ9C
         y7lOwn90iBA6w9aH0dBS1wGB9sbXUQcw6KfpFv2O9kaNASI2lHk1iZA9Qmhud7lmGRpR
         xF8GWH7MzNpbE248cjjxBnvgRw0EaGH//5Lo6n9NmB45iPMXzTQdAE+3idDrTtkT33TU
         FYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665838; x=1782270638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=BTyrfOKrkvzV9ZQeNJAAm4ANisA5l/TnEl21ew8+tOlemSIaka/OV8jdJFwRK9WIXa
         MXujsS2epgHQJzevhulmOJtt2px1uEX+LpjkXJ41cAt+IKbdEt9rz/khP99P5WSnYxA0
         TseIaDQsR0MVYKoAsit8k7XeEp3lLmp5eHLx6Bm06NMQ7ZWjWmCvvSXD7VLyhhKNr1ab
         Vip2FY01kmwe35tdIKpLuQ+TB6qKdaJkLnFKtWCxLyl0PJECq4tuFEfjpesbMgRI9bBD
         fRoAkxoRNA2ZDWaFwolP9BbeExGpPivGGA+vlOtsmpuSY3pXRd8NnAoNdR8nhK6chRew
         sRuA==
X-Forwarded-Encrypted: i=1; AFNElJ/pzOcohITWnByDDi2+bUrw5M3nYYTBb+lPKwM9WsDEKxLeT8S5W8FJNflv0vdLNOESpfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIQcwoG/ig5gTR0zP5a8FRTl1+v1ktL6EeUxHL+53jjb98ARs
	X7KHxsLX3IbUp8nj1w3DI7euci24+hG8QHC1wIdxHlcGakC9rigNVkvf9hZBS/R2yCYf6yUjF9R
	OiTnm2PQhKrPEq2hGwKZoUCeUvz8Qoq8=
X-Gm-Gg: Acq92OGT1ifyL0/uRi6uIlVQYxowNKCaeZtauESJ4fZMm/eh1wkvoMmy0ELlwSxqKCx
	C3lCaBoFXPEYY7rwmZ5yy2iJKG4Mtcge181twXa6FnOdvx5HL36TxSdFJg3Yg3UA9CoJhivr00X
	8RUCPHmlvRUa/OcV6k1uZww5lXBEmdl12kVdmszQW6jSDUdXRQiIdfaBNvA78L1n6nSHQgOZGm2
	6sFdye5+y3KZdNZu46vnMDbq+D3Q2UPa8BVnIxfwSyK7jiK0h7IbhWvWRBjxpfyot44SyTan7zA
	0wqIaUtIhTskSgb82CxBAUc46I0rpDrtwS8C1e+ioIaJXlXs1TZiVp5qcJiBif1qUZqg4dWSCYI
	cAVUeL1nZseWvSg==
X-Received: by 2002:a05:6a20:7f92:b0:398:b95c:51ed with SMTP id
 adf61e73a8af0-3b8b7eddd0amr2155474637.35.1781665837570; Tue, 16 Jun 2026
 20:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617011303.3969027-1-clrkwllms@kernel.org> <20260617011303.3969027-2-clrkwllms@kernel.org>
In-Reply-To: <20260617011303.3969027-2-clrkwllms@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jun 2026 20:10:26 -0700
X-Gm-Features: AVVi8Cfc0CqsWHOwbee6X-rMFuNMy0GR6Pg8FpJSFXk-J0xJ0qCfLErAPY2sjx4
Message-ID: <CAADnVQKniB8TLvQkuVaPb4jrKLR5G894bMEOrT+GxzRxqgPVdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable <stable@vger.kernel.org>, bpf <bpf@vger.kernel.org>, x86@ekrnel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:13=E2=80=AFPM Clark Williams <clrkwllms@kernel.or=
g> wrote:
>
> [ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]
>
> strchr() now propagates const when passed a const char * argument in
> newer GCC/glibc combinations, causing -Werror=3Ddiscarded-qualifiers to
> fire on the assignment to next_path. Declare next_path as const char *
> since it is only used for pointer arithmetic, never written through.
>
> [ clrkwllms: only the next_path change from the upstream commit applies
>   to 6.1.y ]
>
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>

No. There is no reason to backport this patch.
Distros build and ship libbpf from official github source.
The kernel source tree is the source of truth though.
From there it gets synced into github automatically.
Anything but the latest bpf-next and bpf trees are irrelevant.
Hence, please do NOT backport any tools/lib/bpf/ patches. Ever.
It is just a waste of electrons.
