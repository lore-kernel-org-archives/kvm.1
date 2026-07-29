Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF94242D65
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305175; cv=pass; b=UeZtQN8xlFxKHeH3fuevVV9X36sCEyLxPlhfSqz8wNqIrRG3kgtLHUGq4Zlc/w7mhdDKm2dhVf9zBmlUlC1HevYTexo/KVkRBlLVUqCf2G9ADzQRelzmG4I/ZCyWnuOF6h8+DKI7zhxquTIyLNSb9a+Djn5xRB1HMqjw8J9a/1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305175; c=relaxed/simple;
	bh=AEahsskJk35LDvEm+vEuJ4gc6+ev8t1YfWcl8rXCbmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l17NAqpduFLXXq1EVBCmJ94KrBjYl6OhOWdjjN1wMv9JP/86k+MOoQKOkx9QCRD38MfoloRYv9oZKVSGP08BuuFSk/cNzTRKVt1W1eQV1PM111+qnra+N2fHesz/U0QFz9d/b8qGoE5CIOZLMEc0bytug+2a0sHmM9A437Fdy6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qj08/P9y; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qj08/P9y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so7446a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785305172; cv=none;
        d=google.com; s=arc-20260327;
        b=GEUAXnAWXTP+Mdgw661AqjMbH8Io2NcELz++Wfu31x41peae6yP66uj43P3tYWL0Qb
         cTXH7vzq3No8J9tH1audsd3Gl5InoEyKe7Yg+nNl1sie6BPuPjDoBscLU9GbZE0Pw3kM
         oRZj1suX6T4xLcBSniPc+l39y+X4AjKCKAmj8ghPiWBwsC4dkES+0IKAkribKbTZDRDb
         cmBEaxKUGJtwszzPnZkus+Lo71JdEYh5frWT8EEKQfNnYtexwCAEiLvTG+MhN9n5uljc
         nbhp3npp0RPBAbfA/AmXYsod2ncfQ8mgTU9dUaakYhirUvprNWoWDh0ts8lBwNwh5FC4
         lPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEahsskJk35LDvEm+vEuJ4gc6+ev8t1YfWcl8rXCbmY=;
        fh=ZNGPLkxopiVUipfktrjjv3EtpOs/8lis3yOAZ8ikRWo=;
        b=Lox1TFHepiR7HLCzuS4Y9qKQbBxoCge5onnA+uJI8YbYS2w+eeODtmGWiyPpL6FAEx
         /TO7FaL101uNSUAPLI33FFlhehPkP4oS6aTi+TjxjPHZfSqvq4ptjBkzQBe40PDVrQoJ
         k+ikzVvSYKNDgaT2wxdhgByLJBgyP5FpkwfwZhKJTCgBtZGm5c1VwB9Rh8UP2QJ1N/oq
         8MW7O01r5nL+04tKxBkBsFe0VfTSMUUAhZMGwsv8qiye9/rhWtQr/shbQJdQl5HlOY19
         TMVt2nfAg3eLAA5QjKsEZq+KIDTSKU3HQTlB0UjSybLm0WQ4Q+JdoUnJaej89TYRRpwF
         VJ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785305172; x=1785909972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEahsskJk35LDvEm+vEuJ4gc6+ev8t1YfWcl8rXCbmY=;
        b=Qj08/P9yZR+fvr7VqjjnGPkOc9vHLdQ4Oef+dRIpsdjjbup89AXFbAd+UzWkk7SLQq
         tWErn2t41o5daGfOERzAVklVd4KtMw6dW4OMmVXIv9i5JRN+vIZ1Ys1Tz8JUIC6MXoWW
         v8SJYxKwsDDKdvmIhNDj1JP0KUbWwTjJ5tbv111Ld0OU8WxYDDnsStfbrHeXEQ1xN2td
         u/g5Pu4J1z/EyOgfwWnqLgdx7iYwR6epMfKszZ3CwrG0npQW2F13gO/ttAuYL2XX8cyA
         IQGqjulDNKabDhpEBo0vfpI1qUYZzYMlYNXtjWdxh9E/QsuhrYP3VHNS+LXzFpCKBaeQ
         ZnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785305172; x=1785909972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEahsskJk35LDvEm+vEuJ4gc6+ev8t1YfWcl8rXCbmY=;
        b=kJtR9B06jTW2uj90mb3snGGV09juD2usfEi2D11uBEEk6HC8kOCQE2K0EjxVInTzJG
         mbMlbkzB+wea+NZYT83N8sYI5hPkwkU9B1zJse+f450K1Ckn6Y1OOR1YME/OXjpWixAm
         miE5cONjPS7iR0y14T5WahgC/6tT7peO6BEz2b/Au9whbhx+LCdX0gIVuEPcs0LuqOcM
         tkoqB/IBWJpBSbAYKmNTYRVPPM0IM5t86ViOSgRuQ/fysjyRuYeSnnD+vGH7GuSP2KGT
         n9pcH0FDceE+O9/dprOaEhHhvfyUjHgjZ38v0lFghhK220umbnBagEg0JLi61KLnbLCB
         52vw==
X-Forwarded-Encrypted: i=1; AHgh+RrVn0BcLcKbSteLK+N39RznBVW6Kp3Dqe3D5A1NbojcCMu3NJ0M86J25Z6zfWqaaU7/Xhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9MzoEnnhaA0h3oxQrxapYv0pxYKbpYpcsr3Lf/B5+8vvTPVR
	qp93nJxTjb2O7OIBRjJGJs8B9nAPZktIhuzLwKszqojUjwhdJEA6+z3h01etUGACZvKPhs4rTzk
	vI9WY4iWS6cnstE9jogj87e1HDU/wsLUhu93EAzA2
X-Gm-Gg: AR+sD116iWq0r90i6cxTksiL6WdjJvwTH8zTAVMGQmweOz4Nx3+qbF1dXhMpkS5qT/a
	xqtgrbMAT3UXtOt2P4bS8DUwJ8viOdDASJtBRYZHKqUWEZQjxTAzcgQLNTSkFSVA1ZQNbCqIj0E
	8/qB7xxCtAWmZBoW9HxM2+EpS6vKWvkofemff0PFYywLCtJFtnT5z8IiRxUTvXLEL05+xoHbeK0
	+Ocd4WQvZbBoKKotDxJvsNnK7gnQMX1roDqSKq/jWKboy5NHvAC4VTMyzbcyC57bjCBirkT2uAj
	RFUFb7kSpnqcZ+4nc6rWcC3Yd3/tom4vL6rNbZ4Ar23bLuQEXLmfRkg=
X-Received: by 2002:a05:6402:a388:b0:69f:2c93:b7cc with SMTP id
 4fb4d7f45d1cf-6a063fa0e0emr4326a12.9.1785305171843; Tue, 28 Jul 2026 23:06:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772732517.git.isaku.yamahata@intel.com>
 <aliWoldWX9/9tqNn@intel.com> <amlYsJzUurSeYlTm@intel.com>
In-Reply-To: <amlYsJzUurSeYlTm@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 28 Jul 2026 23:05:59 -0700
X-Gm-Features: AUfX_mzknf5sOhHd3wZDK2wEssFqUWQ4ixQXVPW0Vx9HlFSERQ_CQWmsE-wN5KQ
Message-ID: <CALMp9eSKEMotL19H4WxZN5iVfUxnDScpW0TqGLAEGSitG4AAbw@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	isaku.yamahata@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:35=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> Hi Sean, Jim,
>
> Any thoughts on the approach of reusing hv_timer for APIC timer
> virtualization?

Last I heard, APIC timer virtualization was only available on E-cores,
with no P-core intercept on the roadmap.
