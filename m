Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE5472F65
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020800; cv=pass; b=C4xxsIjfpK4BuUsnWvUp8z3BbjogQV6ud7joRUOjgwGJTettBQlRK0s2JDJQ+oMNhM5JAEQo2uydV8ZQsMWVmxhfW7m4CHozxBwVZinZg8Y8o10GmpHFTtYqEBuDNBskN2/cbiUX08K6aE2a1O2TBrPuEmzg74ScCW9Ipf2jdkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020800; c=relaxed/simple;
	bh=UME3gLxvOcbdeeImfZzUcDJxVeJkr7yc9QMRKYfW8v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0Q0bdedIvHR+6ewvM1tfKVebO1YMmTxnWll2otSYaKe+sJ4IV9XRBMzoxttdc8IFDYaLHA5B+pSq/rTEl142sF6jCI04dV8cgcczTwRfdH3y3qoASnKrCJ4r7tPjAr3pKx7MEOpoJje7a3t2lwFB/keb8ey2tOozoRObc8FvtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lupv9RHL; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lupv9RHL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1027a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792020796; cv=none;
        d=google.com; s=arc-20260327;
        b=Tb3JQR/sIblQFbU8G0ZcR+Vcdoca4WaCRH3sC+VNNO6y5e1kkHY4uEmCEN9WtZyPNp
         5/S1JjXYymF9YUUXwmzNvPUEimu2aBpCRze98vFzZHRi1WlHL5rgo6VcF1SUYea0zS7/
         opqWDhzSZNBDZWhBm7Xy7VHMU2rKo3OuQjCuYHE1nnVqYKLAeAYc0iPUmt376+7Bb74a
         EnXWskJd/p15wSYDJ68SqGbtK0Q/dltFsVLovRMT6J41FEeGOivb4vKJxa4Y2R6xxk7/
         TrBvkgSE4LuO8t1P2rLANkOEHkThfQ82kVsAHSxkeY7/ii1mj6bbh4kdYgP3BQ8Nh345
         xw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UME3gLxvOcbdeeImfZzUcDJxVeJkr7yc9QMRKYfW8v0=;
        fh=G2YUTZCMg4qWJsji7Od/Vcxn+qTuc7DVtqLsd3gxhd0=;
        b=iYNoyYanOdrWVkmbjZfpGg0x6Jykg93UUZUfgtlc4+eH5vPAi7aqDc1/lKmuUprlVk
         nqH5agd+afYMQyepa0JRH8TCzIwrXLbgre4xiuLPZvs8xdeyfKfdA9KX8xQdojNk9bSM
         7KRlaFEJc1StFJBDYWVdB1YWRCrzXroZpmBHtTHN+/8Qb182FGwmytbszJjZj0jtu0Li
         Zd6/eg8eGqbkdacfzdMSdJWdo4pWSWYSukbHu+Q6QtDgYhxIo/mxtl3KNGUQExaEPstA
         pZLo2pLpO0AA2WVbTLdbI0YqdqCrNqmO7j5FkGKaMdEMpSOyC9dzkxpdnKynmzOZiTp5
         1h6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792020796; x=1792625596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UME3gLxvOcbdeeImfZzUcDJxVeJkr7yc9QMRKYfW8v0=;
        b=Lupv9RHLK8uaKj4rl49Fam9q/DWsm4IFC/4GAehCjKz8VvOHrQ8buFVDclki0WA3jB
         fnkGNRN76+CSDLPDzPd9WWnWyUxFMty4EzYnaUOwlszpLvKN2+57fGnWILBfH9YEtgnQ
         1otAPqf0SKSCJdLvOBYUK+hc9SV0ak9WJwReX8n4ZaUV0xPa0fz3ujASpyijj/msVEBZ
         AYOhUfY9gRPsAvb9bY6yZI11gB8VksL1xjBJ2MNOPTREIUluobcWNZqeOCxdtQbvB912
         llQISzZk7QyBQ0vLzeMw2yAPaUswJZmyiOAEUvpPiMhxkB9bCVXfMbl8ICIJfz8hgKwg
         zCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020796; x=1792625596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UME3gLxvOcbdeeImfZzUcDJxVeJkr7yc9QMRKYfW8v0=;
        b=i/FgPLS2xuwfvPusj2VDFT7pKKIkxUUR5HsUgiIYrRinxZJPvLb0U7SLH3ALmS1NKk
         xYuMsNl73LmRyPTZNUhnNrDDALvz3SIm0snMTqHeOM5ItCJBncVnuX6+Uab0kJq+343P
         d47+Gpiov1huC155+kx5X6BzbxZ/XPsucH4kcXreHOKs7r+hUK8U7pjdWczPoXgukTg2
         UG+4s6lFIKSU8PiHoIENGaNhm354tu8Zbh4EhxEyoQbTFCID5vwQdcNhm+vASowyUNY/
         JCS3Z1KuwN3zxU2ENWOIvyohDCKw4xMqi9Z/y4dnki7Ew518veBzCm2pRCE+yp0FBM7Q
         yLuQ==
X-Forwarded-Encrypted: i=1; AKwUvBy75OJIXu8WyEtAIXsqBEBLtTED14bSJi0ygHMzRulwFVQeAM9V3ciIukT18ZVusfddegA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnHrW5FMgCAXSTp0wOgjyzNeYT+K2ucFDtNJVvdC0K/LsCne5W
	cz6b6mNUP+KUKpmpPNuxXN5DZ+ymMdRzlDzVcj6wGXWTGfR6M2s/7h3xLg73Q7qpe85CPOzw1+g
	xuYTACaY7o51JAOlUrXMQdYJM/npYGSMAe9hebgR4
X-Gm-Gg: AYBFou0KyZGzFHt09tJtigGO+9hFrHaPyPaLAgbxZW0mWAsNjk+1j7X24kwSUCHboDy
	rodVF0sxo4nLo1FBPEn5lwKGW8Q1isrBrLMrPiZAz7C0+dhQyF+JR5Zn8lrD5XsA3qJmAeipBsf
	jkV1Udv+/rpzhvFku1zacXexXbQcVjY89WfiCxBZV/1meJQ1cnyWU0faKyePpJUG4zHf69PPl9t
	1GArwVWSvO/b40QlNgcGXKbL1Ce27gWWBYcMAp9VfYq4T8vfNau8eX2VhRaFJRziuImYrvlFTIZ
	yJ9shzWo6LYcqknhdRthQzrBWCp1xsv4c8EDH4ldRZpR/OHOsL4Ac8I=
X-Received: by 2002:a05:6402:a546:20b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b323170e5dmr3931a12.0.1792020796073; Wed, 14 Oct 2026 16:33:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-9-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-9-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 16:33:03 -0700
X-Gm-Features: AclHuK_3nG_mewji-7JZbITUFFbQKSC5wLbCzDueJSSlfMYouBa9PjUn-HbQoec
Message-ID: <CALMp9eQ6ZeJLR5b-ChuwLjWCVC2MzYnFSHoRoV5Pr2kO50P+Pg@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] KVM: SEV: Expose sev_get_asid() outside of sev.c
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Move the function definition to svm.h in preparation for using it in
> more SVM code.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
