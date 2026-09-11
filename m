Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AF322C6D
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150224; cv=none; b=tLfELuygTqxC667KO3qI28iPWqP0P9YsvjupD7kwGxwvA6GYwuQo8P9mHaaovPVTh7SD4htQELigK5l2RwvpRhzYYRJf+nUrObC4kJbeZSHEJgF4oFcVl4nnWnwcMzfWTmkoW3W941jt5FOPC5DWUvgA+8peMBJOZtvzldCM7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150224; c=relaxed/simple;
	bh=pwGqM/+vkkzFyVI/JsfB/s0Y3ZhUGDk2RXiK+bDPZ8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leqjZZ1p7D2T0NDrN20kC5adrFmUblvAkPhj0UbFAc2n7dB9AfSxhbdFQamNB4yqneVNdHiUXPFC0ARY9ZFi33OC9ME2/XXgHT7NOLyFrgjPYFiYmTE9dGegGSpXLKprvIw5ZzIuZQ2iaAhwVcRAGr0snWgsw6pHUdE62rbJJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJGBsGOL; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJGBsGOL"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1532603a91.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150216; x=1789755016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vRIpRvEbMMuUyHQQxsZ0NfIJDkuNXQPXZTlmMz1Dzfo=;
        b=MJGBsGOL1Vx5T6qgQDRTvsJIxInyquLyKVSC/qnMOScZrZcEgx4T2oqJ3WDUKdg5D9
         LDJD/LvJBtCmoPIMWA1s68nEMamgKE/2cMjfkqzTfAB1/etNNhRYdiK/f5yyB9Kbuj/O
         wnwOkY/5MhWTdpbUlxHOcoVoehgFqcVvZr8i+DfKwNBW1Hy/W40zJ0ADs7//MW4zsbji
         DcL/ZXLxFyZqBJ19Py/IxBnLrDf6HnMoZzHa2EdnOitvlsbJ/NSeQz4EJLNLfa7G64XI
         lyTgjxJlnWUZQ9X/hF/ggE4Dwrmaqe6Vo11E9l6VJtygoBuwUZ9desx3LNvinXdebafH
         ZUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150216; x=1789755016;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRIpRvEbMMuUyHQQxsZ0NfIJDkuNXQPXZTlmMz1Dzfo=;
        b=W/GoMSA8etwj0bWYBoAelj9XoqoowFtOiRRZzWl1CO09NUDfPnxkPNa6b0EU+OLKT7
         4XmQMnHGt63xMYjx5FCZ/D+4Ju8V84Nmfx7Oc8w05nn1XwvwI0S8v3aZNuUf+yIQEF7q
         CBLhNHto0ZFIjBdaZgYiKMwD8Vm5CKwqySwKC6skVTuNDTRuskd24hMyBsKwBtgGyYKP
         tQLnB1tq0aPko5GzYspFinB4DU2XR8ndtPL16CLR+2FP9Xt2D+OQLqaMTn7fyUkponVu
         4pdiwVaGZ5wPAPno3fppzyU0fhTqXCr3z3xBrAjioFDL3EQbzXO9/d8z8nDAExI2Wo+q
         5WIg==
X-Forwarded-Encrypted: i=1; AKwUvBz0tzWHweGSa27nr7KQI/uNH4sYW+d3pV5K8Cuyx+ixfxaxHEAz4z+g9KYmStklH9/bX5A=@vger.kernel.org
X-Gm-Message-State: AFuF++m/VbR4rQvNaf3EgB5wG2vpFxJbgu5KcPA7S5peOvw812RqcdBw
	xecVSqUdNx5wkQ36YXt8TCNaah4DMSbqdF+gLTw49Q/tYaUyTm3rowNIGH6aShZLsB7uyMU6IbQ
	U7OiHxg==
X-Received: from pjdn62.prod.google.com ([2002:a17:90a:2cc4:b0:39d:a3ec:2af1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e50:b0:38e:9ef9:eb97
 with SMTP id 98e67ed59e1d1-39d9c1d8f30mr10349194a91.16.1789150215466; Fri, 11
 Sep 2026 11:10:15 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:10:14 -0700
In-Reply-To: <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Message-ID: <aqREBvLRKgD5cGgk@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, Jim Mattson wrote:
> On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > So, as an immediate set of changes, what if we do this over ~5 patches,=
 with patches
> > 1 and 2 tagged for stable@?
>=20
> By "we" here, you do mean the Royal "we," right?

Correct.

> I just want to confirm that you aren't expecting anything from me. :)

Do you happen to have a selftest for this?  Even if it's half-baked.  I'll =
take
anything you have, at this point I just want a way to test the changes.
