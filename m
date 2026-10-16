Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1273C454E
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179177; cv=pass; b=LayBMdSRdWbzbClFs0jPe27TjUNy9NaRUhNBaonyIWd5uHahFT0oWV/Wnpqua4K2gMfE9TRksTh0voOemZQNbtDBLg4RZNRVD+uRkuzdOfWeP7+FFEBsGYr7ANqoWLb5/JPT5t+WxlnrmNP/+HaZgkINpiaY3y5jWbgkg3FUxuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179177; c=relaxed/simple;
	bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9qrQIl4lXsPs4sCWiaS3Rm15XmF1fAZ20F+EaPQkG593fKBF5/nHgbqy2RsTzIciOAij8eXwRuEYS4P9mO6CrshgSVysUNDZ5+t6ipnIyzBeDfLnkwGCOhVnTntdFzW8MBbhqtKbLkZ4hEsylLXN0CElNtJ0a6ciq1ccxQKr6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQl5OsG9; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQl5OsG9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5337fa12431so611cf.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179173; cv=none;
        d=google.com; s=arc-20260327;
        b=H9W8wPv/sgO4U6LIGkPkSCUfOBLconXruRJxxEAPRBS74QorRg3QOJ/WPpJxWt6cfW
         UCup+vSLqfA9S5APGvjr5MUgnNPKgQOTqNL6m04QyB/mKDskrQeawlC8OK2g2CxapsLk
         FyW3laOHwT77Z4gW/K5NZIkQqMJzWnN+8EysCVuCyBl+sR0DKcIm3aji/pN5kzavVtVp
         0Ui0SjxqhCfRXGBphUuSkMOARdzTNV8BZEY6ImRef+dixgl9/Vqt+onBaCo24XuJevut
         OymtdBn93HiJ0KjJZwnLAafAz18j7Kzu5wZEP0n+GksisABPXqaKqiwfKsjDgptjKoyX
         cBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        fh=5DpxRx8e4NTOVQYEhYEnlsKr4sKdh7ULSurSXCfRSlM=;
        b=AltHQUc1mjZomQvAgcPkRZtSxF3fr5bkav/1UCI5YxKNqaV28yCaNruztHunNQq4gm
         Xb25h0xQ0n4A/zdhCygYMhuD6uXVFp9Wj8hsWkk5zsOFxmPwF8bt5vupS17wl5UxWPJR
         +qbl2Xp5yQ+INn9xXS/u2UNLvyGJVDw8peRfaYoJYaSjwUSd49pSWisN20YaBXicgMKJ
         kQcQJ9guP8A9VdO2bJdzuPmwAbDWPLYIt7ZQ0DgxLSEEbNlof4p7EdfKYzaohQ6UkfbA
         1/pcS9ibZSgVgVS4MOOOcuT9VcvlZ/rpyH8t1GkoirJaTciFi0ExJlvxCvoeAdiImjor
         WJKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179173; x=1792783973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        b=LQl5OsG9PWIneV6xpRYFa1mAyNeLlWP0rTkUHj3//0xaDk8hz80SqYhbN5GjkVRqG6
         q4nhdJf4fHfhYmCCUIgcruTovBcWT0z0RQuzCWOQGlM3ko5GHfs5xqM9Cz6YbKOA/wY0
         EEDC3ilWd7X61FjmItfijY7g6K7/wJjZmZK0UTSK4qJucRt+hDSkpais/hLq0XSBm/8j
         W5m2d452aabY87kbMwygBbA/dUvx72BgiJbsviOS+BGNb6kCM+cVADUda9ecxznKyLtu
         j7EiNSltjk9SxxwvZP81IqnzrpXA0BIkwW/u3e1VAsKUMIBEwDYU2+ySE5vlu4c/Fwp+
         Ah0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179173; x=1792783973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        b=B5i1SJ2X1twwuIiXdKlIgQDM3CF+7Ij1rB3836F2oScZ3CBxjR0HmDCDnbcx335kJf
         Cd3iAqiYQvIVXl4IczPG6dOmM1i4lmUJ7S6G84Rw2pQjktcI7qLcZ71Ep2jBc6RITnT/
         O+olKSUOClaTkI3XZKn51+QW91AkK3Aixgsc5zGKjDT5Eq8C2hJ2SqZVxP8qPPTOvKX7
         UImzGwSwZ5TxdLa/Sb+oHcBCSTKN+Dv/Rc+sAhhYGRCadvTf5q/hYqqoKjtbTcz9jfgW
         tJ+KtoG+izVc5PPT262w1zT6PGx65ENvYPGKxYBmdc+ozkx3djmxEc3uXA62fx+7b2Ck
         pppA==
X-Forwarded-Encrypted: i=1; AKwUvBxu+NHz5tGbbuDCUMmSd/M9wlyBDRopkrTZzuSmqI5j8fgxHMfvqb8cGbQpRTRjYwOlaRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfZLN6ydyxoJl+ukLcUnNC+KBLWlRljEJGl15yN7nb9yZeISxA
	P3EhHTvmq3QOnrWed8xPetPVWlUDqgk2FE6qjn0CVTv4U3BBg1PrxhucqnyAXfoNvsMHNxENNBL
	Ju3u3p97Wdd8eAp3FRiCtXVy1RIGkoEmgKy5sNBSZ
X-Gm-Gg: AYBFou1UV0g9PWoi1egdeGrv7T1JsvOYaUSHQ+L6na6AjKs2TU33D8brQU68HdGyCRy
	sIjUjOitvbqt9KAldLjdusTgAkiHv6PVE2AYu2Udljyz4zKkJ0lru/hJq3AYQgIbcuf08MfMSN4
	QzIxUvJlLJyvXKh/ijllk7o1yQcGT56p4Edd5rh0dUMVJNm0MVJmr7rIWo+lmRc+YE76AV6zvJX
	euLBH675CqOwfwdnIacHHLFBsrIyUnVw1tYm4TLeDdYbWsj2a301sOPy2DAxcWBVWFYW97D5WX4
	s5XRXZXxrr22fcq5Pj8bqvoIzJ1hrvwR898sZSsvJuGPxBcWzlZeJNk=
X-Received: by 2002:a05:622a:488d:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-536463584e4mr2454001cf.9.1792179172628; Fri, 16 Oct 2026
 12:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-2-yosry@kernel.org>
 <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com> <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
In-Reply-To: <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:32:37 -0700
X-Gm-Features: AclHuK-ZQp-6TfXpSbf_CVQg-2-T-7CMHpUhbyrETIPAQMotQvMXWEMbF3I55Hw
Message-ID: <CALMp9eQCbU5onzrjnprFuP+AF01hpn27ioBs7Vtq1bOaWiFwvA@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully
 leaving nested
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:19=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 8:02=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not wh=
en
> > > forcefully leaving nested. In this case, L2 TLB entries can leak into
> > > L1. Flush the TLB after forcefully exiting L2, similar to nested
> > > VM-Exits.
> > >
> > > Note that vmx_leave_nested() handles this correctly, as it reuses
> > > nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2=
 ->
> > > L1 transition.
> >
> > Fixes: ???
>
> I figured it was too old to be meaningful (i.e. we'll backport to all
> active stable kernels anyway).
>
> But I think it should be:
>
> Fixes: c513f484c558 ("KVM: nSVM: leave guest mode when clearing EFER.SVME=
")

I concur.
