Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4D38E8B8
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075852; cv=pass; b=gav7//ui0d4Lc4IPOq6GfCNPuURb1dxX60Enmj0ScGMl0NtuVudcOTk8ey35DfcJogpJ8T30FRQCDJdNxaRNEAdKlb1JE+O9zk4SCtW6uKH12Zkvenbs8E1Q2aaUyKHDfgpImN8TenKwxujCrUH2WXucinNEybGp6r9WeGE3Br4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075852; c=relaxed/simple;
	bh=uVQMlPiOQ9r4BPFFKmjbmg5hpo5fhnbDgrl9CiTzo6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuknIuIhSt2SdVs5NdYRPFPOEtWMKJdGSbt99kE4Wg/4sO3sFJBkhOP4oAAIu1IUmjuWqW7lEtWN4rGaNHTIbBoSQ7VQ0O+K9x17LZADlrILcAiLWNs14TCBbAAzBf2x6E8aEbl3XvSWKMG5bGNPy6G8eV5qnrPhhm0wFPxu5Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1Y/OAId; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj7m9kq7; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Y/OAId";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj7m9kq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780075850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4vpsnPCM+3HFQN8gJWvPuxu2ZHDXKm8E9PN0epI8+s=;
	b=E1Y/OAIdTp08HXTNA7ssqiIW29OltKYCH/6G3Jp2wjpTEWwYHnhj5HArpzgB2x6+KSEkvM
	MmejI2AxIxorgqhEg9ZJaOkyIUu0qUeIsr6yKralwTO3fp9KDBR95UemfS5k/YAkR/ATv1
	ZwJ/Q7NyGxLo0FAP1xMW8SH9UlfpYxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-y_uq5HUeNxO7uvofHg0eKA-1; Fri, 29 May 2026 13:30:47 -0400
X-MC-Unique: y_uq5HUeNxO7uvofHg0eKA-1
X-Mimecast-MFC-AGG-ID: y_uq5HUeNxO7uvofHg0eKA_1780075846
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef4931de5so385217f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 10:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780075846; cv=none;
        d=google.com; s=arc-20240605;
        b=cG5hC/piBHZ1Y5sUCvGIx2lh1eAU7KD3oBUAhBN+ITFKaqODiv0kNDQeJqGqIsSgpH
         oakdBTBBUHrGFuqIt9AqJTXr+oB4eHAxZdpQ+nuBWX8upP5qdnh4ux5sjJXSXYwp3Co+
         T9dygp0X8vz0AV2tFWQZKjLqSYUTHd1WPQwIiDD3TRGJRt2hTgmyhUjx/Y82rGeUZPOI
         3tdNMjOtPFanjsp9FVjbO9wfqCEqFNtzMXqJ+OsEEq/Vr/uqzd2wEyvX7o7fnXzqrrqz
         iM2vukdHHmQQD93fvfmjZ+lEur/DVJBTUye/ipdOGQT66/85zjvaBkLIMDNc4VHRxczf
         KRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4vpsnPCM+3HFQN8gJWvPuxu2ZHDXKm8E9PN0epI8+s=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=PIv4Goe9+baydvV51yyoNfItc16ZxDkdBgHdcQP8lVXLanhzNbr/lFFzaH6+Bf2Mek
         BbAV2uxIGZvndrcgZeMFqIVlvZ8zQFoApqoqHofZ263zV/fUbQT5n/YIAJc+7K17YGTd
         bNVFONbWO7DUihL3rDQHCxsc6IzFTpai9gzkSyhGLkiSlLMFLEy3drpAvo2pYX8SFA1F
         HCX5j/kVTwRtNUoWpoZOQbbblcG0x8xYv11AL5OU/Ef7oNuO30wS/zpdfcIXf8wpJqbs
         I8rVtgUEF8fZY15AQaLZsdnHX63eO/A0YuyAhMau2f9BSip4L6GqH5eBn8nUxShSVQEu
         ukBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780075846; x=1780680646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4vpsnPCM+3HFQN8gJWvPuxu2ZHDXKm8E9PN0epI8+s=;
        b=Qj7m9kq7vYYbNRbOL4TsUyMdyTZvTlu0rGPwryxDnDgNU0mlzvHuYsWmZ3HrEBK4k4
         m9pFa3DCGrGwKQMyla/lNOKGyFt/80PdkXYnY2qGWXUojTnAghmzsGiBj8O0eDdKnu4O
         oSrhR5YgN7WLLcOQUidlOnxbB9U9BCKI0owgsqkDoCgaWUb0yz5QafbLq+oa/drkUOI+
         i+5vhAThcXPXoAwZjhEZGrYSkk0uaXX1vArBeN0WS7Yi+t5ebrdP8SgAAg3j7LbpCRVV
         VSf8oLeU18wRZSEfhCRV2cYi6tHciSDrVMDe6wPW0dvMBau/gLm3c6YvsGsQMA1gV8R1
         fh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075846; x=1780680646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4vpsnPCM+3HFQN8gJWvPuxu2ZHDXKm8E9PN0epI8+s=;
        b=jZn+ovbPaOgtAVPdP3fm2UpwiegHo6EuKbEYyQTe1LOu3Hcr6hZM2ULQHsHfbRCbD6
         J5oWcTJ4p+NwAM44EmcYagttKYFHwAk1sRe8EjcZ3HNA0UM9GxIa+mtWSKYmPVf4juLx
         dlc1QAPYC9BH19Is/PQO/n22+vOL2RAl5dn5ToDG2A/9Db012kJriEIE3iP+qSoa8mV0
         BXqUq1UoquUwo9ZX20MLR20qb9fhMblqcKFGEmc/I4hEq44PtSePFizLI2YI/wTXgEXP
         6ZyAOur7CTPhbCDK/1jRt8ScR3hgIaeCAfu4/PFteyNRhYJpFKNpXwBSarWDEfiPWEHl
         hMcA==
X-Gm-Message-State: AOJu0YxOLdtQbHvU9rlcQYTLKTlJjNkZbrLswKU7yIxLvV7NlkAPM17S
	pCWB/38oKcH1h33Po1z4o6/vyVy69kSMQXgGLhJNcdYHx5TzV6s3IULFu8PvaXlWEzMS2qah/Bb
	Pf+gnM1X/X/SuS9ZRMj35/BemD6MT0hsX6MKELl1BnxWLT016Bc8UOQW1X/cnvyFhf1rv1TAxXu
	pQjTcDN8zBKfcoj/ROYPjDD0jbch/q
X-Gm-Gg: Acq92OFJw1ZQZcMn0mLgCa2l+2NIVgLW6xIsoXoWiFZpOWp05JFEy59Wi7oXrZPWKCV
	rF4FWO8ZUtmVPop3R62Y2lWMIoHxKcq+Hp4DeLobNGBY0Mkx2VKtOCBxX78GSy8B1VGsZUvtbAj
	Ns4FR9BsDlKarBBtANhYS/HE+Cccvgo4FCU+UATHldIhJ92T62x1NdyMZjRUp32MHU5mfK0XXsx
	YW4I7dHD9AOMd/ASZvT818Ynot5I70M11r2WOUpsLTrejflfMcnnEbHT+1CNhwZkz9d5qvrO6A1
	KJInFebhNByXA1wTjQ==
X-Received: by 2002:a05:600c:3545:b0:490:50ff:d394 with SMTP id 5b1f17b1804b1-4909c1670a5mr66161655e9.16.1780075846102;
        Fri, 29 May 2026 10:30:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3545:b0:490:50ff:d394 with SMTP id
 5b1f17b1804b1-4909c1670a5mr66161305e9.16.1780075845754; Fri, 29 May 2026
 10:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529155523.729502-1-seanjc@google.com>
In-Reply-To: <20260529155523.729502-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 May 2026 19:30:33 +0200
X-Gm-Features: AVHnY4KbbxkyH-wYJesz18AOYjw4pPvaxNnh8RLrVoIYOsANL8_G46OVoAoMWqU
Message-ID: <CABgObfYHcBDkEB=JMzP2TCrXANkSsM2q1cyGwK-7fp9S6mFV4A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fix for 7.1-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:55=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>  - Fudge around an RCU splat in the emegerncy reboot code that is technic=
ally
>    a legitimate flaw, but in practice is a non-issue and fixing the flaw,=
 e.g.
>    by adding locking, would incur meaningful risk, i.e. do more harm than=
 good.

Pulled, I'll add a note that this was left to be picked up by x86
maintainers but they didn't.

Paolo

