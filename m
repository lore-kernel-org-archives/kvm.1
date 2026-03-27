Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1A22D7B5
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621166; cv=pass; b=DRnedTZJgcTuPY078dGbGfHOayMbrfAK0tvSVNsPzPq7tKzAkDNKjU+jQejv69+Xj+di4tXlivY2dA0yPYSYZMh2nH0/oFqKY1Pb1+P5H/367/ttKcQNblmc+Se/SMuDJuitLnR+o9/4JQ32O4oeTUX8ehTbYX0Aq02Hi/VLP4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621166; c=relaxed/simple;
	bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY+SS1lA0+7Wil/I++m6q979iHJw/DH66NId2TUJHjszMhwmtc8gWAXPK9uNGU1LVm0JWVKo5avXBhGMU4PS+RS7mNvGPXSOd76yENDRl4n8q//L7u5c0OBTqKC1/Q4/hu0I0TDJQo5xFMV4s9CQiXg8zXZ8ttPqgDoehXdb6Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1wvfy4i; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1wvfy4i"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64e8ae85700so2390038d50.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621164; cv=none;
        d=google.com; s=arc-20240605;
        b=aFHXidm8Y0yg/sQMdQT1cfHQDLXJyg7ZI36rBtpoUHl6dAFQs7tq2LhwhVlJAnnvaE
         Wv7/RbhyFC+nHL0fiqSgnNKQnU+lK7ytTkzOU6Tt+4p2Z1sdshGmzHmHN6m9/Z4iAhvm
         6iShH/7rcIR5P2RJ5Ia0wDTQ2G9p4fQGrHIxblbtabMo2uwiznV+uVa40yqD4KQKFAQS
         nAWPI1GZMEI5Tr0wjCUUTT7fvxaiPOeB8HPxVdiiLBmEMslA8DSU/EieKw095FIAylTr
         KnF2AQevG/kZzZmPAX0iRmKhO4MrBxCcxQ3Nym5dcYdVM92onXqnk9NAmoIr91uU2omU
         JCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
        fh=DGWoJ8q6ga/la4Q24LhTaKwBboLAyC4JxBtepg4OUnU=;
        b=kLxe0xT7ZtPJcTByEmBFa/uWL1MhTKkbLECljIQhLNrBQ/69MtweaHD+8HKDhIxV1m
         0hPvUSi3FZFk5xNZaC1w80/2sqwgiHq8WRCVR6TpWhxqtCHkELysnkaIV8sdIQAPHQy4
         TRRukm5mUW1h2ywBblmM6H59PebO257+yvZXb9GU8uzo/pLA1NTb9Zoz/cGSKD0ZeHTA
         Q9bk60EWRFd1Jy17HFUNSseO3o8HoPHD4gbwag+pN0OcKNg/Pqm/lin0fla5/Fz7pJKo
         +fT+2649L2dIatZW4FFMEfElWJSgMZhQrYoYr6rbDf6AJtv17cm9iBz5qwUITPN5ZijZ
         iMgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621164; x=1775225964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
        b=K1wvfy4iSfKdQ5NbN4lkTpk+ZIDCNYtbUX3e6iqzOZZVG+d1QzhxUjPrkk1RXZUgGZ
         Pm0WxvimW6YEGWCuJiNg0qMvKEVhEvqy3MJuBTLUbZ6MmgOxsX9UAAU/QmntmODIpKTk
         ftUHJAYZW0uzkhaatzH3hx9SRD2v1p90EtVyhHS2j3beLe9uk/YDBbdioHHYJA6P5Crc
         fB8lCW0XaFswq/IAnUc0nLQbpMiLhB39iehZWWqv/EKO0N3t764007Qz85VYgd80NBbB
         5OIOvryMu2KozSwYRCrjWVI4brmonD7tKfJ+AuvqPAHi4aSJyYmJyDNK45aljYvavB8t
         Ympg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621164; x=1775225964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
        b=eUkwr96ILnI9XryoxsFk4SL2LEYBeiFCfKcGdDV1yOltnqka2pggMi7u0jBG+olO3J
         nqWOs0cegfVMXF9H58Oegivn7W0+/1UxgQiH7viDTeOAll+4iKZMlZsYhM/bY9gx9j1T
         HahDzPmv6n50ap4QJc8SVGnTPxY5VPIUo0drWYfQTFI32HU9lZ9sRh6L+9bL49DCGBbl
         2ASZNSMXgGvAukyOkapmpQQ89Na7ic+Zq1lDA/nDGnfdLX9xYMqhsusQ5t29K0rVYUnC
         1fS1u3QVcAhrbzz2fJcLF2Xfz8UG1idP7rDF+iMaOq2vhGyUN6MBvXzItktE1xw3amax
         wzhA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3NHdkK9N3kM+WSYGk/mHjQEOqhbBwFg7DhNLnUgcs7P6YoxLX6V1BwepQuBxfCPUwKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49lGXftxOadxmGRtWmYltmULVHGolRSJWF/iOfdlS7D4SvPRW
	4kg41YqQIgZrPsmus2/sYUDOnj1v/fYiAeYwZ4MguM8kCPI7mpnBNZPsL4oOwj+c2fgEeU3Vxpt
	Wwc/hcMB6A4I9zQ8Va8E2uDyNWVXX4h7kQjQz1B8QKQ==
X-Gm-Gg: ATEYQzwLiYNNpQpGkbkdJMYOC9QCizB+1wySi0WHbdWd905MQ+yfwE7DDqJsUwUU1p1
	eWmyvRB7KjeeEFGpvbov0qRKGYkQwo33txyZBz7LLaoG0SnM27mgNGzwuI6ybC8DEW2NzXb2r24
	eqReCTAb+EYI4xJ6tuk6Qj5WHJ4KNG+YS49E5Qxg7XZCEUgEkWRfjmcvmYVleBOd003a8T5nzQd
	Oc5cEds0ekU6BZvUxSG+Ew2QzeRhCeK0itbikj9Xln8wuDzml6ZZWeYDjIj75VEkbTZTpmr61jR
	S4sR1AASMr1NzB2+KoGpYirvYY0kgsMiVhZPBtC93zDL/PbMAtDlE15XNnkKKBqvbWg=
X-Received: by 2002:a05:690e:4810:b0:64d:6193:a760 with SMTP id
 956f58d0204a3-64ff71d6b38mr2131553d50.27.1774621164224; Fri, 27 Mar 2026
 07:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-12-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-12-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:19:12 +0000
X-Gm-Features: AQROBzDFKAtaDnZ_CkP8sLNQj62KF0xDt5c24sJEJyOSFn4rOw6Vt4Bc3wmhX_U
Message-ID: <CAFEAcA-7uAnDm56JLJh-ASDGdSAv6EGoB5NNcKtbVGPuZzAYPA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] osdep: Remove unused strings.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> We don't use strcasecmp/strncasecmp anymore. Also, we don't
> use any other strings.h function. So this include is no more
> needed.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
