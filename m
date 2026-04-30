Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AD44D696
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575621; cv=pass; b=uyEJpH6tz5XwBgjKLUt8jZgshCtNjeifXiU4tpMWHhb2stHzdY+YkV/8raWlgIx227T9opKMMFcQYev2LwR2lgBi4DQrU8RoFAjDJcudMojphyYjSF5RHjzkWGCNV7RSeN8DOa+TK90BOXrorbpMB6WztyKlzOfcfZE64miIm7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575621; c=relaxed/simple;
	bh=zOavExCwbT2eLlkrIeVZA6KtxIjcOHY7aj/lqL9g4fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqOqcqFAhZkdOG265eWe4oOoR07UspmV8tFJNMgiNjRT2e21JpTzWGtsuawlQZhHtXSk0sYduUZ1HJNS8AvHpoZPwIKHE/FqNaSH9aPDjVJZbSgo3CO8dJczdHFXI8BG950e1ZKjmdQtodBFiTqLLWHbzdVz47wSQU1aSzGUT8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YrhwqxPL; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrhwqxPL"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b4d09141so1948405d50.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777575619; cv=none;
        d=google.com; s=arc-20240605;
        b=U82xaxpxf7d1xNEw31D6FBAan/ZVVBcd/7errj3c3eQ5qM3W/MHqK/ianbVd8fXL1c
         LG5125stq/hITofGhzsXNm+6jeb2iiyWzcpKZ1OYSJyuyPf8KiYA/m7+B0EjvAElPCNB
         DKqkppiY5EJd8hNBQ9Z/Bzo4hcbYxjKTi1gKm6TVGs/e9H5wLaevXuSHzfbFQ0jxN0Z1
         OdGu6s4vz34wY7KIVYidnNj/NCpX3w0Nup9PuQla5cDnV6tzWUglwGpWLj0SDxPJilD4
         TkcUjT/jaeu86SKx3+V431fyigi2A1Ddf6FL61DkcdyjtmJir9C/7JmIT5SIHeYzSYcq
         a17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
        fh=vYWakwJQny8gjz5S0Gzif1Awk0QAxaVBqlde/UCTBsU=;
        b=XoONY9KDHs+UfY2VigWNG39yx0IZX8eb3M/wgFwnQYp8pvFj+oyHCsQ+1YnNNfhV+X
         iijkq4dQTUxQGCEpepeTDslbDn1rHd8uDvzvndAD/R5+LcgK+2bBuvVbw8VDV2CmGi0h
         n84LdYMCiUk94hmKTYg7Wo7qrT4lN0RTjOSxrmJ+6TdzK0WvTbkks9jESIWtVT5/69rc
         ikgg0sMXVvo1w8Tclb0rWVMi6aw9BCm290fUVNnGMQZs79iWHjBzcGJIFhWgBVtlIClD
         0jwS6xyQA7GRPcL96d2ToFGUvd+4/aJBPqmlcOPs0r5qCoR6wlu0u4nZbK7q7oLmOwNW
         f75A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777575619; x=1778180419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
        b=YrhwqxPLbjVgxWsBO6rRxHNvRbbmuMI0bx/9fpQuZifAcYoLgm5kFHtxx2vU+iKZLH
         X7nS76r+ucJeB1xDymR3F2YqSD31XfgBN5ld5oJGxbyIbSdeD5h5h9TLxkzuM0UOoyaZ
         jkLeHalu9g6lujgovaTP1POYOOaYenlNe4ko1LaVjKd2bc/vvmeIa7UG5hNI0odcVcVq
         joOJt3/JMvAo6aISbQe6C1tsq5iz9OSpXJNQQzGy2pnWbaYWBqrMaXch7EkF+IzVegG+
         J0fulO0jhIV2kPNeItArVxfPfTU27K3iWXcUnI08I3IjogRCE46h3K1M5f7dHbXzI9lJ
         E+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777575619; x=1778180419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
        b=oMe8U34ylxdjxTVdoIQZqUq9nvvuE0lOiZfiPA78UxrnkNQkZG0UTP8ozpHDhc+x8j
         0Ynfkbl7pVw3NpYoBJrm01efjBHP638nNZkDgysnqRE7DB6/fYsu5hX2jzBI65LHYgpQ
         vCwFL+VMMMFoKs86+TVA/0BWmRJIwxRXoPwF8J53pA3ZLQbap3n6MYMI5lqV1oTfr6KH
         BxXm3YAZcwZsBCc6V2jQLissHL7Ct3VTy76v1vcbrEnVn+C/wPl9vL6CcKvyk+vqU89j
         EElUdRe08DYarTh4Xe2OZb9wXRWu2SuCPAm98Qvm9+tVLyiIVDOekemOO9Gd9cdvHfCj
         /wxg==
X-Forwarded-Encrypted: i=1; AFNElJ+dAHd1GHMiL5ar9YO/RRLbzyDCu/PpJBKiiMoC6XgNmQN/51M0prOEyh1bC/jSINsEGGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iqLnq868eiOs3IfQGlnXBW6KYJcmXbOwZPrnGZcBUFNOS/3C
	ZP7ibE3qarrcGJzeWLlYpt2Q8QRUlps0hi61H34HqBC1EUDT+J2vTbthMbWrh3s/NdyFHmmlZMA
	Tg4AQ/9OWiyqzMLUoMiRX163MRwYrqrhpsd3toFclqg==
X-Gm-Gg: AeBDies8tNF5/gAh3jRONYKBTZFT0cHggR+aq5nwPSYkVcy1moLRN5Uc26oxqo41w2l
	rAyPsSrqXyUW1OR28CYEb/28iVCq6wnbokWwppEzSeM9RT8RbikqHS+q9QV3+w3hSte22dMDUir
	tL6aprF8ZPRYODKXqKbvxYWK85uXhRjEKFEXXRWk367MM0xgljTkcqZu35tB3lpQdaKWQXygIYk
	fiXiGlLhxvkAWQ8SOTjCSiF4V4lIKIPtL9aPSKNd/vr02eenL+oftROcxSjNBRw99/dz+W4Mljw
	yakPk4gtM5SFjbLlU4pQViKBQimexQ+WdEw0glW9KFDDd8cu5mSMJmQPYzdh9rcx1eDqr27bhsC
	6NQ==
X-Received: by 2002:a05:690e:1207:b0:65c:2dde:1f20 with SMTP id
 956f58d0204a3-65c2dde2dcemr379405d50.22.1777575618555; Thu, 30 Apr 2026
 12:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp> <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 20:00:05 +0100
X-Gm-Features: AVHnY4IS446GOgig4mj2hWyzIYZXt735BiHhTy8NoMwOpE3wZw3c3RnA8q9fDSc
Message-ID: <CAFEAcA8kk=mUYaqzbqT_C55398SknRUdCmkWKk1ruLMnr=0vOw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Cache host CPU probe failure
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 28 Apr 2026 at 09:07, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
> > probe failure with caching. The current algorithm can be summarized as
> > follows:
> >
> >     If dtb_compatible is not cached:
> >         If kvm_arm_create_scratch_host_vcpu() fails:
> >             Report failure
> >
> >         Cache dtb_compatible
> >
> >         If getting register values fails:
> >             Report failure
> >
> >     Report success
> >
> > This algorithm has the following problems:
> >
> > - If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
> > - If getting register values fails, later invocations incorrectly report
> >   success.
> >
> > Make two changes to fix them:
> >
> > - Cache dtb_compatible whenever a probe is attempted.
> > - Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
> >   arm_host_cpu_features.target.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> > Supersedes: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM
