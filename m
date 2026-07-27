Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87641B8F7
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168626; cv=pass; b=gRLeHAipDLLB21A+71OhFgg4ShPWCBddAjOo02w4ukP4/RU5CFB2NLvgtr/hL62FIHtPIXJbRHEDUL5h1AQDy9ZtyVhu1B7qaGxaGh6AWD8K/uHifXB2Hc/BByEudzbXvHlPJ3y/1ds1EHFH2ycwiTOj6P7fHNQFwi1fhZ9b1bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168626; c=relaxed/simple;
	bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR0vQCjzUYWqCMrlUP/lQYm31NvkMzxSsqgnHjV4hDfeuVTsmSM0Qvp/80a71pcSmKACMJnOtDGqKOlr7EV56YVEGn6RqOBW/LZ/ocodKxba9YqwX/CsG8M51Spe9bmiDlgP71YzHJtjoP7D+nVAR/RR5uIW4b2e02I8v3TTeCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muJPYlbS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muJPYlbS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66771ded50aso3637169d50.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785168624; cv=none;
        d=google.com; s=arc-20260327;
        b=KlKDLR6odYNib/fxg93Eb1JD3okuL9XTIeOtjbzeJxERadpgsQHb42QryIkkKHA6ik
         butkxnl27xPKbqnEM0ce8tG9DGBI0jtWT7lAmGnrpT2QonDeXrWgFKeTEFLjwVTXoe77
         Z2YWUrRW160Euub9GCdaSXEILsqdUk7DrGGg1HPPreSCByMAOuWRE8rT9kypBz/9hHGm
         6/witWf5iX5SqUP6/f45IYcHzsT3b3Ns9DmR+s21WjH4x7132KdLMgt+8QvLv/cdGvtU
         qxSjKTIX61yEPRmW+oJpgAQmzbHF+MfMqAKS0De5I5L9g1GSTF55N6+roJF3q00yX+XA
         63wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
        fh=RdTc8p3gFPzljFYbO58KtXoyj7yh3c861Q3sOh3/a3k=;
        b=iXqDp9NyX/0sL4uYRMH1WPf+p6iCeEXL5ZOvEvLgFplcnOdSAVpnyA6Kz4QXx7EHrq
         nG6sk+8lN3OHciSkG6KVzeQjyd/L43tm9L+TfDAUvGIfNzEVWXg7IGL99pJFZO3/ZCh0
         gXS3A5HJIr80XuQZvmcTeQagGSk0WgqMa6iQz4dEgfxJwZ9ryMZqygx9Exn4aqFa3gHW
         Srl/X7E0vJ6I9Zc1GEoDHXTxEpX1WQHDMI4vzvKHWOr8q6bIdhMNN6RoaR5+KYC3iqTk
         e/HXVFRmafQy9Xy8aqpMyU3Ma2irY7Z28PhCyz9zYZswHIKDQdgZdcFMUAlAckgQeRNK
         tufw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785168624; x=1785773424; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
        b=muJPYlbSbwSKQM/ZLcx0MA94P9EZlvY8AmAoSLqA+shZKBMNQOZUVX8QFfyBuGmOV1
         HwLwSHgDdog/JaROy0L+1tOv4JUEobGITu+ZDtV7KvzpgZxMfKZx0rMvaMOOmNWRnK5f
         UA+N/KjLcXGnIUqHSGzyWDQVHDPUaA9N2NyyZhD8nOq7CM60pKzsdCLXGQ0+aZ0+r+wc
         +/RR5AzwLqx5sRJYPdu6xKYrk0qhljeRe+HJYmk1lIvoqOQ8L+UI7Tv2ntFjeV9OfZmT
         dfZ8HN/B3RA7yGGERZM06EpuMooAj/JFek/w1UbmQa90bm/5W0jxSoZZMixRUqOTS8HJ
         0EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168624; x=1785773424;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OOsxF6EKGXLBykC9ScLiUIhGyadMeqkWsBstlwVytuc=;
        b=Y8mQioiSXLFQBsZ8D3vuUKGGdPVIujKUzpwlNAxziULo/yu6GwsUEKhjH+RDPC+RQp
         mXuPPXp+ApQPnKf8ljYrBSheI64sKjhCVDMARykOx8SIbDxCQnFGEhNTssVPSzDd5mAK
         MdJmPB+6fHufyNNPQUWNzouHj8L4THW7WV2ricvYjnOQfZXBOkxrGN/Tun8Sn2gDNaKv
         3I5Eoh+F4Nq7JknFOBFlmI6C6SCjzxIkIaQ6HmWSIrAXkVz3ZvrzjXq+DPLFlF952F6O
         uIWkHhsOdVspR7eNzFOdIRf8C+Z1BvXryL7Y/kc3egLbT+QHSC12noRXgiItZy98PHmu
         8aPA==
X-Forwarded-Encrypted: i=1; AHgh+RoeptZFSK+jSAWFIss0IDN3ydzojvZRvQFlw8ZUvkIiPtjGNaQbwWRc0EtaV+fHlwAC4Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LSUOu4CO2F8VQNEy9nYuvUFt3srWI0jMQHMoDfX3OjfMX8Bw
	6VNmMHMZBD8sfXDAbzyNFMYsqo7hMjvIKa+vMpLvS75ALXoYG7cF0eynjTkOLMsUcULKAZuVDta
	bDQ4CrtDh0PiE6Ur4hy3/wIfBTh9BHqOaffMe+XFfI4lDieRxzOAelFU=
X-Gm-Gg: AR+sD13NSZp5HPQ24Xa8ehpklYBLTgynjl68l6QELczm0WdycG0XUl+h5D2INutwlIQ
	rVmuLUTll465RfnQAgNXz/bpavva64IsLPuNDnt3kY3O6T36lo1sHmTcAeEpzYyVVFjtzPnbfqc
	JgTDXnWxX+0oYBJ4JAnauY51tK9WaE+YTw2lQ8fAQLZUR7NbY4rC1XE9VHIZkWIYypP+urAMD0U
	4qH3Ae0Dp+C6Op+eav6cPblsw5qR/Y5aw/dy5iOwV5WSKc8AAKnu3ZYIvItPvA4bdrc0/RMDeMH
	4F3Ehorkn/XtqedxJUBuYQ4TWKN4y1NTeX1g1DHIKUK5sMTjZnB9Jy7qiCGHVeDBZ8NgtaN2t97
	qGV7pPn38D4D35aqbtlasFg6H6uLw
X-Received: by 2002:a05:690e:58e:b0:668:482b:af78 with SMTP id
 956f58d0204a3-668c7a76831mr2025073d50.28.1785168623684; Mon, 27 Jul 2026
 09:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 17:10:11 +0100
X-Gm-Features: AUfX_mymxx0UeI3zaYN-XNOKfFhNqx9ca_fv4qPFNtyAB8qHCBXWywBAQqhTdMs
Message-ID: <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com>
Subject: Re: [PATCH v7] target/arm: Always add pmu property for host and max
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
	qemu-devel@nongnu.org, kvm@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 09:10, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property for
> "host" and "max".
>
> Note that we still don't add the property for other CPUs that lack PMU.
> This is because we do not know what a PMU version should be enabled
> when the user sets the property to true while it is defined as an error
> for the "host" or "max" CPU when the hardware accelerator is enabled and
> the host doesn't have a PMU.
>
> This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
> KVM but doesn't support PMU emulation.

No, we should not special case "host" and "max" like this.
The "pmu" property exists only if the CPU has a PMU and it can
be turned off. If The arm-cpu-features test assumes that the
host CPU always has a PMU and so always has the property, then
that's a bug in the test, not in the code handling the property.

-- PMM
