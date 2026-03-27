Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDE3F23AA
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620983; cv=pass; b=jfHa+/WuOpYRnxRvYEDYVV135dTGUM97HKU42AL3nwlrHYzsWVF2+XpUi93K6eikJ3WivlHYY441rpYsqJyeFodLLgdTYKQGFap8NpavzBO45QMUiOihcN5Tk5lOluXOQmXdFI9eg43YqxVk/43HJfo98Cmdjccw7zsIVyAOu4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620983; c=relaxed/simple;
	bh=H05pu1oph6i20zdQPmfFwuNamYsmz88n81AK/YEWkBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns8ftk96cFddzChFuZVteusEWmSvoca/4J9HRfTLvHogapcP/3v12s94V5AKWaX78EYs+OFMJCIVPaGsIGe2ryxRtzL7dgHQcZ5B9YG+T/KINQFO/0ac6fANyC98Ur0wHwQcMdkipVrZgUKl6+QABqGjS5vB4J22pRLxOG2ohds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6ZzRj8N; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6ZzRj8N"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so1832325d50.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620978; cv=none;
        d=google.com; s=arc-20240605;
        b=a9X8k//Fx0iWdWzbsHFetxmt68p2aMosyPFUFdoAFMXtv4wH0eUtlskNyCF3i8hKdI
         Ph2sSNalaiiN+6d6qu+gbNSE+mk1wKnhAiF813tclWCO5NKnNs8Z3kC1O4r/M6p75jfh
         Sh2Zp1ocShd35HZVamYFfWBuV4MVw2mpo0O+xJIPuILEH73nRnLmvCWYJS+B7eHBCCgp
         H3vMl44aijC0L36gOBIwyozExDXfQSCAWVqVF4xnnnck4rI7Cbb7VbtFtiHL10fTJBr7
         xU8TmKHTg4VdGB+WDWz4+qNbzTYhC+mqTyV+AloWoUuT8w8w+1Q1zrLyLvM7tJRXn4qF
         G3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        fh=jaTq95e4G3SZQShXwVPouJV6YwY73q/uZVWFoiMPAHA=;
        b=L0tq5Np9Uz0fY2DjgE56HRlG29SJd6JkDuIcSwuLLaGxzMkuq16+9WwjTD9lfoDIYw
         P5w7BuPmKry8XioNYLVDTpumn2C+61oDmzEQC1KcifeDoIR0aUyWIkQKCx9jLTTHgqbn
         Xud2L85Q778l8vMqJSSgtTzrxjKITQ3cQ3jtdTVAV6lx8cai5lwkpIlLNnZ93vVCUKER
         ZfE1YbvtrXg2rVviw0rvnyT4cZgbkaMouRoBirBTsuGDGrky6jGldpB7FQF+DsBw6jkc
         ElE4uPzLYybW4gDtZRCCm9kaH50QU4hshtJ4TXC58ge4S5w2MnfMyJjkHkMbrmbHPX54
         bQ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620978; x=1775225778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=p6ZzRj8NzwSEayFBm2HxffD/LDCLybfhZzAa+te4hmDHTcDuO004m5shGM0tXulkpa
         sQJkObaveNCqUKtCmjiNEIXyOfb5cMIy8atvmMjBYOWFUaDG3sB4c3z9rIgiOyAJU5vF
         RO++N0uCGS99IHaTwj0UoAV/fetlVeKTJ7q9D02KmYxek78hB+w4d8H+hhS/BnfuUrPK
         hWzcLleAH/jBCBDv3WgZN7c2Fa0zUh+bkCNpYmMW2A4TuDXqb6kAY+bVyGMfMrmjWITn
         k3fIA5PWsDhxlERnZwEVPFwR+oOdEh/bKMjOSMCX4xFihOjPOWFgIQR+nerxJ5Z393Dq
         G4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620978; x=1775225778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
        b=itwVSQa3KHvhLVwcqScW1yTNCPdMQlwt0p6syYNNL6qbSkGVfVwbwjEQfDvBP2Xxgj
         UFsXuUz6w5EafAVBLFQnGiQPxSAiBDEiBDOdgdyeevaUYWOQxkIoKw3oFz/v9vX0gPMe
         NeBf+3OMcsxYY8i5UpYnqpj5qJzHQOArvCeBwO0ePE54XN645hC2B0ufiGF7Roevp+C4
         ADDeGws4mCjDvI2rrUufnB/pPNGwzJYtBO1Z2QAOPxBsFBii0hSBWt6ASuIns0tewk/8
         nRSovxjGpT9gcUVF2Pv6hPzJ31ZY/rsRpgcHmwdrSiXbLDjJiK+Ui2VymuwR1n5E6/w3
         5ROQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtrfD2aUSzmrSQDWVvN1zjMKDHjg3wCI2VfCjkeWvLxHVP9OwvtDgGhiot7TnMYipgmtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhUwUCvO5XQwgpQmu620Fx9cvvHcWjkZDv8ekUn1If3JG5rBD
	RXotPudZFW6Vhs3ZBpYW99vvRtYUOnycDhspgNJC5KzaUwr/u3lJY+mtgsOcZfE1Jp/iMSyc4HS
	ciiIq+1MXunxj2jjycBMlKrAIJz7PLY1B4yf2qlCxiA==
X-Gm-Gg: ATEYQzy8ztEbHqThVwutboUJNiMwuSg3tmC+dSahSBGmpouizlhpTly3nI5CqzvEe1T
	BiLjPBv5KVOIYuDEMPueg85VL4AFgIyXkLgV0WjkElDiVvE3M4GE2Q/qbhNm52bCU/Kg0VSodpp
	159pvHo1dw0q5QaqQlPsiFL00d311LuTMn1qNmAhrQvqoIDODaONjFRt3uHgluoiXtRb/zxi788
	AdtrQ7dB+7tHs+YFFyRR8Pjdz/5o3ktbFDZSA7s7nffk9eZzsT8dXr3uxMNFHkXitKoINlX7GrY
	1Tg7I1FU2MIjt6enhT0F1ChCoZdTPjPyE9gr+tP4roBhZSph20Iu3uk9H7odUjFLG6w=
X-Received: by 2002:a05:690e:11ce:b0:64e:e464:12fa with SMTP id
 956f58d0204a3-64ff7186196mr2658872d50.5.1774620977579; Fri, 27 Mar 2026
 07:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-8-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:16:06 +0000
X-Gm-Features: AQROBzB7drqtslZ5P4MR3E6zpMZVuU-zinN5xOcd-ktq5T8QKtXHBkqxN3bKfLU
Message-ID: <CAFEAcA9rGYiN7=819n2Fd-J3pA10ZVd8Tmt4VhHqp+sme2j5qQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of strcasecmp/strncasecmp
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
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
